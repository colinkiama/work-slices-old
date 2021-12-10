public class WorkSlices.Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "com.github.colinkiama.work-slices",
            flags: ApplicationFlags.FLAGS_NONE
        );

        this.startup.connect (() => {
            Hdy.init ();
        });
    }

    protected override void activate () {
        MainWindow main_window = new MainWindow (this);
        main_window.show ();

        var gtk_settings = Gtk.Settings.get_default ();
        var granite_settings = Granite.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = (
            granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
        );

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = (
                granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
            );
        });

    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}
