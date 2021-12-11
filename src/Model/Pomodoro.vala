public class WorkSlices.Model.Pomodoro : Object {
    public WorkSlices.Enums.SessionType current_session_type { get; private set;}
    public int work_sessions_completed { get; private set;}
    public int total_work_sessions { get; private set; }
    public TimeSpan time_left { get; private set; }
    public WorkSlices.Model.SessionLengths session_lengths { get; private set; }

    /**
     * Continue to next session
     *
     */
    public void proceed () {
        work_sessions_completed++;
        current_session_type = update_current_session_type (current_session_type);
        time_left = reset_time_left (current_session_type);
    }

    private WorkSlices.Enums.SessionType update_current_session_type (WorkSlices.Enums.SessionType session_type) {
        switch (session_type) {
            case WorkSlices.Enums.SessionType.WORK:
                return work_sessions_completed == total_work_sessions ?
                    WorkSlices.Enums.SessionType.BREAK :
                    WorkSlices.Enums.SessionType.LONG_BREAK;
            case WorkSlices.Enums.SessionType.BREAK:
            case WorkSlices.Enums.SessionType.LONG_BREAK:
                return WorkSlices.Enums.SessionType.WORK;
        }

        return WorkSlices.Enums.SessionType.UNKNOWN;
    }

    private TimeSpan reset_time_left (WorkSlices.Enums.SessionType session_type) {
        return session_lengths.length_from_type (session_type);
    }

    public void update_time_left (TimeSpan new_time) {
        time_left = new_time;
    }


}
