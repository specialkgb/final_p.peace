package com.biz.nav.service;

import java.util.List;

import com.biz.nav.model.MemberVO;

public interface GenericService<VO, PK> {
	
	public List<VO> selectAll();
	public VO findById(PK id);
	
	public int insert(VO vo);
	public int update(VO vo);
	public void delete(VO vo);

	
	public MemberVO idCheck(String n_userid);
	public MemberVO passCheck(String n_password,String n_userid);
}
