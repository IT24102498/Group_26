package com.example.util;

import com.example.model.Event;
import java.util.ArrayList;
import java.util.List;

public class MergeSortUtil {
    public static void mergeSortByDate(List<Event> events, int left, int right) {
        if (left < right) {
            int mid = left + (right - left) / 2;
            mergeSortByDate(events, left, mid);
            mergeSortByDate(events, mid + 1, right);
            mergeByDate(events, left, mid, right);
        }
    }

    private static void mergeByDate(List<Event> events, int left, int mid, int right) {
        List<Event> leftList = events.subList(left, mid + 1);
        List<Event> rightList = events.subList(mid + 1, right + 1);
        List<Event> temp = new ArrayList<>();

        int i = 0, j = 0;
        while (i < leftList.size() && j < rightList.size()) {
            if (leftList.get(i).compareTo(rightList.get(j)) <= 0) {
                temp.add(leftList.get(i++));
            } else {
                temp.add(rightList.get(j++));
            }
        }
        while (i < leftList.size()) temp.add(leftList.get(i++));
        while (j < rightList.size()) temp.add(rightList.get(j++));

        for (int k = 0; k < temp.size(); k++) {
            events.set(left + k, temp.get(k));
        }
    }

    public static void mergeSortByPopularity(List<Event> events, int left, int right) {
        if (left < right) {
            int mid = left + (right - left) / 2;
            mergeSortByPopularity(events, left, mid);
            mergeSortByPopularity(events, mid + 1, right);
            mergeByPopularity(events, left, mid, right);
        }
    }

    private static void mergeByPopularity(List<Event> events, int left, int mid, int right) {
        List<Event> leftList = events.subList(left, mid + 1);
        List<Event> rightList = events.subList(mid + 1, right + 1);
        List<Event> temp = new ArrayList<>();

        int i = 0, j = 0;
        while (i < leftList.size() && j < rightList.size()) {
            if (leftList.get(i).compareByPopularity(rightList.get(j)) >= 0) {
                temp.add(leftList.get(i++));
            } else {
                temp.add(rightList.get(j++));
            }
        }
        while (i < leftList.size()) temp.add(leftList.get(i++));
        while (j < rightList.size()) temp.add(rightList.get(j++));

        for (int k = 0; k < temp.size(); k++) {
            events.set(left + k, temp.get(k));
        }
    }
}