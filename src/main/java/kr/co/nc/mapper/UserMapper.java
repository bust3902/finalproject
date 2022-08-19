package kr.co.nc.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.User;

@Mapper
public interface UserMapper {

	void insert(User user);
	User getUserByNo(int no);
	User getUserById(String Id);
	User getUserByEmail(String email);
	User getUserByName(String name);
	void update(User user);
	
}