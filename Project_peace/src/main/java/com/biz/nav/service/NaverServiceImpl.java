package com.biz.nav.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.biz.nav.config.NaverSecret;
import com.biz.nav.model.Map_JSON_Parent;
import com.biz.nav.model.NcRouter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NaverServiceImpl {
	
	public String queryURL(String sPos, String aPos) {

		String queryURL = NaverSecret.NAVER_MAPS_JSON;

		queryURL += String.format("?start=%s", sPos);
		queryURL += String.format("&goal=%s&option=trafast", aPos);

		return queryURL;
	}

	public NcRouter getNaverPath(String queryURL) {

		URI restURI = null;
		RestTemplate restTemp = new RestTemplate();

		try {
			restURI = new URI(queryURL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		HttpHeaders headers = new HttpHeaders();
		headers.set("X-NCP-APIGW-API-KEY-ID", NaverSecret.NAVER_CLIENT_ID);
		headers.set("X-NCP-APIGW-API-KEY", NaverSecret.NAVER_CLIENT_SECRET);

		HttpEntity<String> entity = new HttpEntity<String>("parameter", headers);
		ResponseEntity<Map_JSON_Parent> mapList = null;
		
		mapList = restTemp.exchange(restURI, HttpMethod.GET, entity, Map_JSON_Parent.class);
		log.debug("정보 >>> "+ mapList.toString());

		return mapList.getBody().route;
	}

}
