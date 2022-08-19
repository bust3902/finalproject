package kr.co.nc.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.mapper.QaMapper;
import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Qa;
import kr.co.nc.vo.QaCategory;
import kr.co.nc.vo.QaType;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.QaRegisterForm;

@Service
public class QaService {

	@Autowired
	private QaMapper qaMapper;
	
	public void addNewQa(User loginUser, QaRegisterForm qaRegisterForm) throws IOException{
		Qa qa = new Qa();
		qa.setContent(qa.getContent());
		qa.setTitle(qa.getTitle());
		qa.setImage(qa.getImage());
		qaMapper.insertQa(qa);
	}
	
	/**
	 * 사용자가 작성한 모든 문의사항을 반환한다.
	 * @return 문의사항
	 */
	public List<Qa> getAllQas() {
		return qaMapper.getAllQas();
	}
	
	public List<QaCategory> getAllQaCategory() {
		return qaMapper.getAllQaCategories();
	}
	
	public List<QaType> getAllQaTypes() {
		return qaMapper.getAllQaTypes();
	}
}
