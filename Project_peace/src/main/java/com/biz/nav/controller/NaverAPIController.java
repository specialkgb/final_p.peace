package com.biz.nav.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.biz.nav.model.NcRouter;
import com.biz.nav.service.NaverServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@CrossOrigin({"http://127.0.0.1:5500", "http://192.168.4.14:8080/", "*"})
@RequestMapping(value = "/api")
public class NaverAPIController {

	@Autowired
	private NaverServiceImpl nService;
	
	@RequestMapping(value = "/search", method = RequestMethod.POST, produces = "application/json;charset=utf8")
	public NcRouter naverSearch(String sPos, String aPos) {
		String queryURL = nService.queryURL(sPos, aPos);
		
		log.debug(sPos);
		NcRouter res = nService.getNaverPath(queryURL);
		log.debug("res >>> " + res.toString());
		
		return res;
	}
	
}
