package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Qa;

@Mapper
public interface QaMapper {

	void insertQa(Qa qa);
	List<Qa> getAllQas();
}
