package com.yamacbayin.blogbackend.util;

import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

public class DateUtils {
    private static final String EXPECTED_FORMAT = "yyyy-MM-dd'T'HH:mm:ssXXX";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern(EXPECTED_FORMAT);

    public static OffsetDateTime formatCreationDate(OffsetDateTime creationDate) {
        if (creationDate == null || !isDateInExpectedFormat(creationDate)) {
            return OffsetDateTime.now();
        } else {
            String formattedDate = creationDate.format(FORMATTER);
            return OffsetDateTime.parse(formattedDate, FORMATTER);
        }
    }

    private static boolean isDateInExpectedFormat(OffsetDateTime dateTime) {
        String formattedDate = dateTime.format(FORMATTER);
        return formattedDate.equals(dateTime.toString());
    }
}
