package com.biz.nav.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NcTrafast {
	
	private String[][] path;
//	private NcSummary summary;
//	private Section[] section;
//	private Guide[] guide;
	
}

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
class Section {
	private String pointIndex;
	private String pointCount;
	private String distance;
	private String name;
	private String congestion;
	private String speed;
}

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
class Guide {
	private String pointIndex;
	private String type;
	private String instructions;
	private String distance;
	private String duration;
}

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
class NcSummary {
	private SumLocation start;
	private SumGoal goal;
	private String distance;
	private String duration;
	private String departureTime;
	private String[][] bbox;
	private String tollFare;
	private String taxiFare;
	private String fuelPrice;
}

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

class SumLocation {
    private String[][] location;
}

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
class SumGoal {
    private String[][] location;
    private String dir;
}