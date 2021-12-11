namespace WorkSlices.Helpers.TimerHelpers {
    public static TimeSpan timespan_from (
        int days = 0,
        int minutes = 0,
        int hours = 0,
        int seconds = 0,
        int milliseconds = 0
    ) {
        return (days * TimeSpan.DAY) + (minutes * TimeSpan.MINUTE) +
            (hours * TimeSpan.HOUR) + (seconds * TimeSpan.SECOND) +
            (milliseconds * TimeSpan.MILLISECOND);
    }
}
