public class WorkSlices.View.TimerView : Gtk.Grid {
    private WorkSlices.ViewModel.TimerViewModel _view_model =
        new WorkSlices.ViewModel.TimerViewModel ();

    private Gtk.Label _time_label = new Gtk.Label ("0:00");
    private Gtk.Button _pause_button = new Gtk.Button.with_label ("Pause");
    private Gtk.Button _play_button = new Gtk.Button.with_label ("Play");
    private Gtk.Button _skip_button = new Gtk.Button.with_label ("Skip");
    private Gtk.Button _reset_button = new Gtk.Button.with_label ("Reset") {
        halign = Gtk.Align.CENTER
    };

    static construct {
        // Load TimerView specific styles here?
        set_css_name ("timer-view");
    }

    construct {
        setup_events ();
        _time_label.get_style_context ().add_class ("h1");
        Gtk.Box primary_timer_controls_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 24) {
            halign = Gtk.Align.CENTER,
        };

        _play_button.hide ();

        primary_timer_controls_box.add (_play_button);
        primary_timer_controls_box.add (_skip_button);
        primary_timer_controls_box.add (_pause_button);

        Gtk.Box center_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 20) {
            hexpand = true,
            vexpand = true,
        };

        center_box.add (_time_label);
        center_box.add (primary_timer_controls_box);
        center_box.add (_reset_button);

        Gtk.Grid center_grid = new Gtk.Grid () {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };

        center_grid.add (center_box);

        this.add (center_grid);
        this.show_all ();
        setup_bindings ();
    }

    private void setup_events () {
        _play_button.clicked.connect (() => _view_model.toggle ());
        _pause_button.clicked.connect (() => _view_model.toggle ());
        _skip_button.clicked.connect (() => _view_model.skip ());


    }

    private void setup_bindings () {
        _view_model.bind_property ("is-timer-running", _play_button, "visible", GLib.BindingFlags.SYNC_CREATE |
            GLib.BindingFlags.INVERT_BOOLEAN);
        _view_model.bind_property ("is-timer-running", _skip_button, "visible", GLib.BindingFlags.SYNC_CREATE |
            GLib.BindingFlags.INVERT_BOOLEAN);
        _view_model.bind_property ("is-timer-running", _pause_button, "visible", GLib.BindingFlags.SYNC_CREATE |
            GLib.BindingFlags.DEFAULT);
    }

    protected override void dispose () {
        base.dispose ();
    }

}
