public class WorkSlices.View.TimerView : Gtk.Grid {
    private WorkSlices.ViewModel.TimerViewModel _view_model =
        new WorkSlices.ViewModel.TimerViewModel ();

    private Gtk.Label _time_label = new Gtk.Label ("0:00");
    private Gtk.Button _pause_button = new Gtk.Button ();
    private Gtk.Button _play_button = new Gtk.Button ();
    private Gtk.Button _skip_button = new Gtk.Button ();
    private Gtk.Button _reset_button = new Gtk.Button ();

    public TimerView () {

    }

    static construct {
        // Load TimerView specific styles here?
        set_css_name ("timer-view");
    }

    construct {
        Gtk.Box center_stack = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
            hexpand = true,
            vexpand = true
        };

        center_stack.add (_time_label);

        Gtk.Grid center_grid = new Gtk.Grid () {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };

        center_grid.add (center_stack);

        this.add (center_grid);
    }

    protected override void dispose () {
        base.dispose ();
    }

}
