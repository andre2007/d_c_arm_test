module external.rt.dmain;

import freertos;

nothrow:
@nogc:

struct MainTaskProperties
{
    enum taskStackSizeBytes = ushort.max * 4;
    enum taskStackSize = taskStackSizeBytes / 4; // words, not bytes!
    void* stackBottom; // filled out after task starts
}

__gshared MainTaskProperties mainTaskProperties;

template _d_cmain()
{
    nothrow:
    @nogc:
    extern(C):

    void systick_interrupt_disable(); // provided by libopencm3

    int _Dmain(char[][] args);

    /// Type of the D main() function (`_Dmain`).
    private alias int function(char[][] args) MainFunc;

    int _d_run_main2(char[][] args, size_t totalArgsLength, MainFunc mainFunc);

    import external.rt.dmain: MainTaskProperties, mainTaskProperties;

    void _d_run_main(void* mtp)
    {
        //~ systick_interrupt_disable(); // FIXME remove
        import core.stdc.stdlib: _Exit;
        import external.core.thread: getStackTop;

        // stack isn't used yet, so assumed what we on top
        (cast(MainTaskProperties*) mtp).stackBottom = getStackTop();

        __gshared int main_ret = 7; // _d_run_main2 uncatched exception occured
        scope(exit)
        {
            systick_interrupt_disable(); // tell FreeRTOS to doesn't interfere with exiting code
            _Exit(main_ret); // It is impossible to escape from FreeRTOS main loop, thus just exit
        }

        main_ret = _d_run_main2(null, 0, &_Dmain);
    }

    int main(int argc, char** argv)
    {
        pragma(LDC_profile_instr, false);

        auto creation_res = xTaskCreate(
            &_d_run_main,
            cast(const(char*)) "_d_run_main",
            mainTaskProperties.taskStackSize, // usStackDepth
            cast(void*) &mainTaskProperties, // *pvParameters
            5, // uxPriority
            null // task handler
        );

        if(creation_res != pdTRUE /* FIXME: pdPASS */)
            return 2; // task creation error

        // Init needed FreeRTOS interrupts handlers
        import external.rt.dmain;

        interruptsVector.sv_call = &vPortSVCHandler;
        interruptsVector.pend_sv = &xPortPendSVHandler;
        interruptsVector.systick = &xPortSysTickHandler;

        vTaskStartScheduler(); // infinity loop

        return 6; // Out of memory
    }
}

static import os = freertos;

private extern(C) void vApplicationGetIdleTaskMemory(os.StaticTask_t** tcb, os.StackType_t** stackBuffer, uint* stackSize)
{
  __gshared os.StaticTask_t idle_TCB;
  __gshared os.StackType_t[os.configMINIMAL_STACK_SIZE] idle_Stack;

  *tcb = &idle_TCB;
  *stackBuffer = idle_Stack.ptr;
  *stackSize = os.configMINIMAL_STACK_SIZE;
}

private extern(C) void vApplicationGetTimerTaskMemory (os.StaticTask_t** timerTaskTCBBuffer, os.StackType_t** timerTaskStackBuffer, uint* timerTaskStackSize)
{
  __gshared os.StaticTask_t timer_TCB;
  __gshared os.StackType_t[os.configMINIMAL_STACK_SIZE] timer_Stack;

  *timerTaskTCBBuffer   = &timer_TCB;
  *timerTaskStackBuffer = timer_Stack.ptr;
  *timerTaskStackSize   = os.configMINIMAL_STACK_SIZE;
}

extern(C) void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName)
{
    while(true)
    {}
}

import ldc.attributes;
extern(C) void vPortSVCHandler() @naked; // provided by FreeRTOS
extern(C) void xPortPendSVHandler() @naked; // provided by FreeRTOS
extern(C) void xPortSysTickHandler(); // provided by FreeRTOS

/// ARM Cortex-M3 interrupts vector
extern(C) __gshared InterruptsVector* interruptsVector = null;

//TODO: move to ARM Cortex-M3 related module
struct InterruptsVector
{
    void* initial_sp_value;
    void* reset;
    void* nmi_handler;
    void* hard_fault;
    void* memory_manage_fault;
    void* bus_fault;
    void* usage_fault;
    void*[4] reserved1;
    void* sv_call;
    void*[2] reserved2;
    void* pend_sv;
    void* systick;
    void* irq;
}
