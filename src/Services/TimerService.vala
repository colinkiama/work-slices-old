using WorkSlices.Enums;
/**
 * A Timer that sends signals about it's progress.
 */
public class WorkSlices.Services.TimerService : Object {
    // In milliseconds (ms)
    private const uint INTERVAL = 500;
    private DateTime _last_stored_time;
    private TimerRequest timer_request;

    public signal void ticked (TimeSpan time_elapsed);
    public signal void stopped ();
    public signal void completed ();
    // Past tense of "reset" is "reset". It's
    public signal void progress_reset ();


    public bool is_running { get; private set; }
    public TimeSpan length { get; construct; }
    public TimeSpan time_elapsed { get; private set; }


    public TimerService (TimeSpan length) {
        Object (length: length);
    }

    public void start () {
        _last_stored_time = new DateTime.now_utc ();
        Timeout.add (INTERVAL, tick);
        is_running = true;
    }

    public void stop () {
        if (timer_request == TimerRequest.NONE) {
            timer_request = TimerRequest.STOP;
        };
    }

    public void reset () {
        if (timer_request == TimerRequest.NONE) {
            timer_request = TimerRequest.RESET;
        };
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
                _last_stored_time = current_time;
                should_continue_timer = time_elapsed < length;
                if (!should_continue_timer) {
                    completed ();
                } else {
                  ticked (time_elapsed);
                }

                break;
            case TimerRequest.STOP:
                break;
            case TimerRequest.RESET:
                time_elapsed = 0;
                break;
        }

        if (timer_request != TimerRequest.NONE) {
            send_request_signal (timer_request);
            remove_request ();
        }

        return should_continue_timer;
    }

    private void send_request_signal (TimerRequest request) {
        switch (request) {
            case TimerRequest.RESET:
                is_running = false;
                progress_reset ();
                break;
            case TimerRequest.STOP:
                is_running = false;
                stopped ();
                break;
        }
    }
}
