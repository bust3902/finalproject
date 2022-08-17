package kr.co.nc.web.form;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.QaCategory;
import kr.co.nc.vo.QaType;
import kr.co.nc.vo.User;

public class QaRegisterForm {

	private int no;
	private User user;
	private String content;
	private Date createdDate;
	private String image;
	private MultipartFile imageFile;
	private boolean answerStatus;
	
	List<QaCategory> qaCategories;
	List<QaType> qaTypes;
}
