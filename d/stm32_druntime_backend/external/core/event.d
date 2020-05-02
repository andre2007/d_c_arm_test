module external.core.event;

import core.time;

struct Event
{
    nothrow @nogc:

    /**
     * Creates an event object.
     *
     * Params:
     *  manualReset  = the state of the event is not reset automatically after resuming waiting clients
     *  initialState = initial state of the signal
     */
    this(bool manualReset, bool initialState)
    {
        assert(false, "Not implemented");
    }

    /**
     * Initializes an event object. Does nothing if the event is already initialized.
     *
     * Params:
     *  manualReset  = the state of the event is not reset automatically after resuming waiting clients
     *  initialState = initial state of the signal
     */
    void initialize(bool manualReset, bool initialState)
    {
        assert(false, "Not implemented");
    }

    // copying not allowed, can produce resource leaks
    @disable this(this);
    @disable void opAssign(Event);

    ~this()
    {
        assert(false, "Not implemented");
    }

    /**
     * deinitialize event. Does nothing if the event is not initialized. There must not be
     * threads currently waiting for the event to be signaled.
    */
    void terminate()
    {
        assert(false, "Not implemented");
    }


    /// Set the event to "signaled", so that waiting clients are resumed
    void set()
    {
        assert(false, "Not implemented");
    }

    /// Reset the event manually
    void reset()
    {
        assert(false, "Not implemented");
    }

    /**
     * Wait for the event to be signaled without timeout.
     *
     * Returns:
     *  `true` if the event is in signaled state, `false` if the event is uninitialized or another error occured
     */
    bool wait()
    {
        assert(false, "Not implemented");
    }

    /**
     * Wait for the event to be signaled with timeout.
     *
     * Params:
     *  tmout = the maximum time to wait
     * Returns:
     *  `true` if the event is in signaled state, `false` if the event was nonsignaled for the given time or
     *  the event is uninitialized or another error occured
     */
    bool wait(Duration tmout)
    {
        assert(false, "Not implemented");
    }
}
