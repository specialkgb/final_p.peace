package com.biz.nav.service.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.nav.dao.MemberDao;
import com.biz.nav.model.MemberVO;
import com.biz.nav.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service(value = "mServiceV1")
public class MemberServiceImplV1 implements MemberService{

	@Autowired
	private MemberDao memDao;
	
	@Override
	public List<MemberVO> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public int insert(MemberVO vo) {
		
		int count = memDao.memberCount();
		
		LocalDateTime ldt = LocalDateTime.now();
		String cd = DateTimeFormatter.ofPattern("yyyy-MM-dd").format(ldt);
		
		
		if(count>0) {
			vo.setN_roll("USER");
			vo.setN_date(cd);
		}else {
			vo.setN_roll("ADMIN");
			vo.setN_date(cd);
		}
		
		int ret = memDao.insert(vo);
		
		log.debug("INSERT 성공 ! " + vo.toString());
		
		return ret;
	}

	@Override
	public int update(MemberVO vo) {

		return memDao.update(vo);
	}

	@Override
	public MemberVO login(MemberVO loginVO) {

		MemberVO memVO = memDao.findById(loginVO.getN_userid());
		
		return memVO;
	}

	@Override
	public MemberVO findById(String id) {
		MemberVO loginVO = new MemberVO();
		
		MemberVO memVO = memDao.findById(loginVO.getN_userid());
		
		return memVO;
	}


	@Override
	public void delete(MemberVO vo) {

		memDao.delete(vo);
		
	}


	@Override
	public MemberVO idCheck(String n_userid) {

		return memDao.idCheck(n_userid);
	}


	@Override
	public MemberVO passCheck(String n_password, String n_userid) {

		return memDao.passCheck(n_password,n_userid);
	}

}
