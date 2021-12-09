public class WorkSlices.View.TimerView : Gtk.Grid {
    private WorkSlices.ViewModel.TimerViewModel _view_model =
        new WorkSlices.ViewModel.TimerViewModel ();

    public TimerView () {

    }

    static construct {
        // Load TimerView specific styles here?
        set_css_name ("timer-view");
    }

    construct {
        this.add (new Gtk.Label ("Hello World"));
    }

    protected override void dispose () {
        base.dispose ();
    }

}
