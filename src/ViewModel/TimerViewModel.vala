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
    }

    public void toggle () {
        toggle_timer_running_status ();
    }

    public void skip () {
        if (!is_timer_running) {
            toggle_timer_running_status ();
        }
    }

    public void toggle_timer_running_status () {
        if (!timer_service.is_running) {
            timer_service.start ();
        } else {
            timer_service.stop ();
        }

        is_timer_running = timer_service.is_running;
    }
}
