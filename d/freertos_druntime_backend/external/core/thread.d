module external.core.thread;

import core.thread.osthread;
import external.libc.config: c_ulong;

alias ThreadID = c_ulong;

@nogc:
nothrow:

/// Init threads module
extern (C) void thread_init() @nogc
{
    // Threads storage
    assert(typeid(Thread).initializer.ptr);
    _mainThreadStore[] = typeid(Thread).initializer[];

    // Creating main thread
    Thread.sm_main = attachThread((cast(Thread)_mainThreadStore.ptr).__ctor());
}

/// Term threads module
extern (C) void thread_term() @nogc
{
    assert(false, "Not implemented");
}

extern (C) bool thread_isMainThread() nothrow @nogc
{
    return Thread.getThis() is Thread.sm_main;
}

extern (C) static Thread thread_findByAddr(ThreadID addr)
{
    assert(false, "Not implemented");
}

extern (C) void* thread_entryPoint( void* arg ) nothrow
{
    Thread obj = cast(Thread) arg;
    Thread.setThis(obj);

    obj.m_tlsgcdata = rt_tlsgc_init();

    return null;
}

extern (C) void thread_suspendHandler( int sig ) nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_resumeHandler( int sig ) nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_joinAll()
{
    assert(false, "Not implemented");
}

extern (C) void thread_suspendAll() nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_resumeAll() nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_scanAllType( scope ScanAllThreadsTypeFn scan ) nothrow
{
    assert(false, "Not implemented");
}

void thread_intermediateShutdown() nothrow @nogc
{
    assert(false, "Not implemented");
}

extern(C) void thread_processGCMarks( scope IsMarkedDg isMarked ) nothrow
{
    assert(false, "Not implemented");
}

version (LDC_Windows)
{
    import ldc.attributes;

    void* getStackBottom() nothrow @nogc @naked
    {
        assert(false, "Not implemented");
    }
} else {
    void* getStackBottom() nothrow @nogc
    {
        assert(false, "Not implemented");
    }
}

extern (C) void* thread_stackBottom() nothrow @nogc
{
    assert(false, "Not implemented");
}

ThreadID createLowLevelThread(void delegate() nothrow dg, uint stacksize = 0,
                              void delegate() nothrow cbDllUnload = null) nothrow @nogc
{
    assert(false, "Not implemented");
}

bool findLowLevelThread(ThreadID tid) nothrow @nogc
{
    assert(false, "Not implemented");
}

Thread attachThread(Thread thisThread) @nogc
{
    Thread.setThis(thisThread);

    thisThread.m_tlsgcdata = rt_tlsgc_init();

    return thisThread;
}

class Thread
{
    /// Main process thread
    private __gshared Thread sm_main;

    /// Current thread
    private static Thread sm_this;

    bool m_isInCriticalRegion;

    /// Initializes a thread object which has no associated executable function.
    /// This is used for the main thread initialized in thread_init().
    private this(size_t sz = 0) @safe pure nothrow @nogc
    {
    }

    this(void function() fn, size_t sz = 0) @safe pure nothrow @nogc
    in(fn !is null)
    {
        assert(false, "Not implemented");
    }

    this(void delegate() dg, size_t sz = 0) @safe pure nothrow @nogc
    in(dg !is null)
    {
        assert(false, "Not implemented");
    }

    final Thread start() nothrow
    {
        assert(false, "Not implemented");
    }

    static void initLocks() @nogc
    {
        //~ assert(false, "Not implemented");
    }

    /// Sets a thread-local reference to the current thread object.
    static void setThis(Thread t) nothrow @nogc
    {
        sm_this = t;
    }

    static Thread getThis() @safe nothrow @nogc
    {
        return sm_this;
    }

    final @property bool isRunning() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    import external.core.mutex: Mutex;

    @property static Mutex criticalRegionLock() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    static void add( Context* c ) nothrow @nogc
    in( c )
    {
        assert(false, "Not implemented");
    }

    //
    // Remove a thread from the global thread list.
    //
    static void remove(Thread t) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    static void remove(Context* c) nothrow @nogc
    in( c )
    {
        assert(false, "Not implemented");
    }

    @property static Mutex slock() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    final Throwable join( bool rethrow = true )
    {
        assert(false, "Not implemented");
    }

    final void joinAll( bool rethrow = true )
    {
        assert(false, "Not implemented");
    }

    import core.time: Duration;

    static void sleep( Duration val ) @nogc nothrow
    {
        assert(false, "Not implemented");
    }

    static void yield() @nogc nothrow
    {
        assert(false, "Not implemented");
    }

    final void pushContext( Context* c ) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    final void popContext() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    static import core.thread.osthread;

    alias Context = core.thread.osthread.Context;

    //FIXME: remove or wrap this
    Context             m_main;
    Context*            m_curr;
    bool                m_lock;
    void*               m_tlsgcdata;

    static int opApply(scope int delegate(ref Thread) dg)
    {
        assert(false, "Not implemented");
    }
}
