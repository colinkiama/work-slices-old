using WorkSlices.Enums;
/**
 * A Timer that sends signals about it's progress.
 */
public class WorkSlices.Services.TimerService : Object {
    // In milliseconds (ms)
    private const uint INTERVAL = 500;
    private bool is_running { get; set; }
    private DateTime _last_stored_time;
    private TimerRequest timer_request;

    public signal void ticked (TimeSpan time_elapsed);
    public signal void stopped (TimeSpan time_elapsed);
    // Past tense of "reset" is "reset". It's
    public signal void progress_reset (TimeSpan time_elapsed);


    public TimeSpan length { get; construct; }
    public TimeSpan time_elapsed { get; private set; }


    public TimerService (TimeSpan length) {
        Object (length: length);
    }

    public void start () {
        _last_stored_time = new DateTime.now_utc ();
        Timeout.add (INTERVAL, tick);
    }

    public void stop () {
        request_stop ();
    }

    public void reset () {
        request_stop ();
    }

    private void request_stop () {
        if (timer_request == TimerRequest.NONE) {
            timer_request = TimerRequest.STOP;
        }
    }

    private void remove_request () {
        timer_request = TimerRequest.NONE;
    }

    /**
     * Will keep being called until method returns false
     */
    private bool tick () {
        bool should_continue_timer = false;
        switch (timer_request) {
            case TimerRequest.NONE:
                var current_time = new DateTime.now_utc ();
                time_elapsed += current_time.difference (_last_stored_time);
                should_continue_timer = time_elapsed >= length;
                break;
            case TimerRequest.STOP:
                break;
            case TimerRequest.RESET:
                time_elapsed = 0;
                break;
        }

        send_request_signal (timer_request);
        if (timer_request != TimerRequest.NONE) {
            remove_request ();
        }

        return should_continue_timer;
    }

    private void send_request_signal (TimerRequest request) {
        switch (request) {
            case TimerRequest.RESET:
                progress_reset (time_elapsed);
                break;
            case TimerRequest.STOP:
                stopped (time_elapsed);
                break;
        }
    }
}
