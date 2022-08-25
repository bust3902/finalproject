package kr.co.nc.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.nc.vo.User;

@Mapper
public interface UserMapper {

	// 회원가입
	void insert(User user);
	
	User getUserByNo(int no);
	User getUserById(String Id);
	User getUserByEmail(String email);
	User getUserByName(String name);
	
	// 회원정보 수정
	void update(User user);
	
	// 아이디 찾기
	String findId(@Param("name")String name, @Param("email")String email);

	// 비밀번호 변경
	void updatePw(User user);

	int finePwCheck(@Param("id") String id, @Param("email")String email);

}