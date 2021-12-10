public class WorkSlices.ViewModel.TimerViewModel: Object {
    public bool is_timer_running { get; set; }

    public void toggle () {
        toggle_timer_running_status ();
    }

    public void skip () {
        if (!is_timer_running) {
            toggle_timer_running_status ();
        }
    }

    public void toggle_timer_running_status () {
        is_timer_running = !is_timer_running;
    }
}
