package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.mapper.QaMapper;
import kr.co.nc.vo.Qa;

@Service
public class QaService {

	@Autowired
	private QaMapper qaMapper;
	
	/**
	 * 사용자가 작성한 모든 문의사항을 반환한다.
	 * @return 문의사항
	 */
	public List<Qa> getAllQas() {
		return qaMapper.getAllQas();
	}
}
