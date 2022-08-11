package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Qa;
import kr.co.nc.vo.QaCategory;
import kr.co.nc.vo.QaType;

@Mapper
public interface QaMapper {

	void insertQa(Qa qa);						// 작성 문의사항 등록하기
	List<Qa> getAllQas();						// 작성한 모든 문의사항 가져오기
	List<QaCategory> getAllQaCategories(); 		// 모든 문의사항 카테고리
	List<QaType> getAllQaTypes();				// 모든 문의사항 유형
}
