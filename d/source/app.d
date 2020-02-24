extern(C) __gshared void _d_dso_registry(void* arg) {}

@nogc:

import gpio;
import freertos;

int main()
{
	gpio_setup();

	xTaskCreate(
		&blinkTask,
		cast(const(char*)) "LED Blink",
		32, // usStackDepth
		null, // *pvParameters
		1, // uxPriority
		null // task handler
	);

	vTaskStartScheduler();

	// Will not get here unless there is insufficient RAM
	return 1;
}

extern(C) void blinkTask(void *pvParametres)
{
	gpio_toggle(GPIOB, GPIO1);

	vTaskDelay(500);
}
