package kr.co.nc.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.User;

@Mapper
public interface UserMapper {
	/**
	 * 신규 사용자를 저장한다.
	 * @param user 신규 사용자 정보
	 */
	void insert(User user);
	
	/**
	 * 사용자 번호로 사용자를 조회해서 반환한다.
	 * @param no 사용자번호
	 * @return 사용자 정보
	 */
	User getUserByNo(int no);
	
	/**
	 * 사용자명(사용자의 아이디다.)으로 사용자를 조회해서 반환한다.
	 * @param username 사용자명(사용자 아이디)
	 * @return 사용자 정보
	 */
	User getUserByUsername(String username);
	User getUserById(String id);

	/**
	 * 사용자 이메일로 사용자를 조회해서 반환한다.
	 * @param email 이메일
	 * @return 사용자 정보
	 */
	User getUserByEmail(String email);
	
	/**
	 * 사용자정보를 변경한다.
	 * @param user 변경된 내용이 포함된 사용자정보
	 */
	void update(User user);
	
}