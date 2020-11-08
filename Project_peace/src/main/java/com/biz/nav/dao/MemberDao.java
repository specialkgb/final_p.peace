package com.biz.nav.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.biz.nav.model.MemberVO;

public interface MemberDao extends GenericDao<MemberVO, String> {

	@Select(" SELECT COUNT(*) FROM tbl_navimember ")
	public int memberCount();

	public MemberVO idCheck(String n_userid);
	public MemberVO passCheck(@Param("n_password") String n_password,
			@Param("n_userid")String n_userid);
	
}