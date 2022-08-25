package kr.co.nc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.dto.QaDto;
import kr.co.nc.mapper.QaMapper;
import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.Qa;
import kr.co.nc.vo.QaCategory;
import kr.co.nc.vo.QaType;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.QaRegisterForm;

@Service
public class QaService {
	
	// 문의사항 이미지 저장 디렉토리
	@Value("${seoul.qa.image.save-directory}")
	String qaImageSaveDirectory;

	@Autowired
	private QaMapper qaMapper;
	
	public void addNewQa(QaDto qaDto) throws IOException{
		// 음식점 이미지 사진 업로드
		if (!qaDto.getImageFile().isEmpty()) {
			MultipartFile imageFile = qaDto.getImageFile();
			String filename = imageFile.getOriginalFilename();
			qaDto.setImage(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(qaImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		qaMapper.insertQa(qaDto);
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

	public List<QaDto> getUserQa(int userNo) {
		return qaMapper.getUserQa(userNo);
	}

	public QaDto getQaByNo(int no) {
		System.out.println("서비스 입력"+no);
		System.out.println("서비스 호출"+qaMapper.getUserQa(no));
		return qaMapper.getQaByNo(no);
	}
	
	public QaDto getUserQaByQaNo(int no) {
		System.out.println("서비스 입력"+no);
		System.out.println("서비스 호출"+qaMapper.getUserQa(no));
		return qaMapper.getUserQaByQaNo(no);
	}
}
