package kr.co.nc.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.User;

@Mapper
public interface UserMapper {

	void insert(User user);
	User getUserByNo(int no);
	User getUserById(String id);
	User getUserByEmail(String email);
	void update(User user);
	
	// 해당 찜하기 정보가 존재하면 1을, 존재하지 않으면 0을 반환
	int isExistUserLikeByAccoId(Map<String, Integer> param);
	void insertUserLikeByAccoId(Map<String, Integer> param);
	void deleteUserLikeByAccoId(Map<String, Integer> param);
	
}