using WorkSlices.Helpers;

public class WorkSlices.ViewModel.TimerViewModel: Object {
    public bool is_timer_running { get; set ; }
    public TimeSpan time_left { get; set; }
    public WorkSlices.Enums.TimerStatus timer_status { get; set; }
    private WorkSlices.Services.TimerService timer_service;
    private TimeSpan session_length = TimerHelpers.timespan_from (0, 0, 25);

    construct {
        // TODO: Load timer service
        timer_service = new WorkSlices.Services.TimerService (
            TimerHelpers.timespan_from (0, 0, 25)
        );

        timer_service.ticked.connect ((time_elapsed) => {
            time_left = session_length - time_elapsed;
        });

        timer_service.stopped.connect (() => {
            update_timer_run_status ();
        });

        timer_service.progress_reset.connect (() => {
            time_left = session_length;
            update_timer_run_status ();
        });
    }

    public void toggle () {
        toggle_timer_running_status ();
    }

    public void skip () {
        if (!is_timer_running) {
            toggle_timer_running_status ();
        }
    }

    // TODO: Replace timer_service with new one
    public void reset () {
        timer_service.reset ();
    }

    public void toggle_timer_running_status () {
        if (!timer_service.is_running) {
            timer_service.start ();
        } else {
            timer_service.stop ();
        }

        update_timer_run_status ();
    }

    private void update_timer_run_status () {
        is_timer_running = timer_service.is_running;

    }
}
