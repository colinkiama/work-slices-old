public class WorkSlices.MainWindow: Hdy.ApplicationWindow {
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            width_request: 300,
            height_request: 300
        );
    }

    construct {
        var grid = new Gtk.Grid () {
            orientation = Gtk.Orientation.VERTICAL,
        };

        var header_bar = new Hdy.HeaderBar () {
            show_close_button = true,
            // Stretches Hdy.HeaderBar to the width of its container
            hexpand = true
        };

        header_bar.show_all ();

        grid.attach (header_bar, 0, 0);
        grid.attach (new WorkSlices.View.TimerView (), 0, 1);

        grid.show ();

        this.add (grid);
        this.show ();
    }

}
