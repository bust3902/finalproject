package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Qa;

@Mapper
public interface QaMapper {

	void insertQa(Qa qa);		// 작성 문의사항 등록하기
	List<Qa> getAllQas();		// 작성한 모든 문의사항 가져오기
}
