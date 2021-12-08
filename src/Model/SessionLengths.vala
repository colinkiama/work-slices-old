public struct WorkSlices.Model.SessionLengths {
    TimeSpan work_length;
    TimeSpan break_length;
    TimeSpan long_break_length;

    public TimeSpan length_from_type (WorkSlices.Enums.SessionType session_type) {
        switch (session_type) {
            case WorkSlices.Enums.SessionType.WORK:
                return work_length;
            case WorkSlices.Enums.SessionType.BREAK:
                return break_length;
            case WorkSlices.Enums.SessionType.LONG_BREAK:
                return long_break_length;
        }

        return WorkSlices.Enums.SessionType.UNKNOWN;
     }
}
