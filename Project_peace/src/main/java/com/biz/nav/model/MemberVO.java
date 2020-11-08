package com.biz.nav.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberVO {
	
	private long seq;
	private String n_userid;	//VARCHAR2(30)
	private String n_password;	//nVARCHAR2(255)
	private String n_email;	//VARCHAR2(125)
	private String n_roll;	//nVARCHAR2(20)
	private String n_file;
	private String n_date;


}
