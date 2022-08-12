package kr.co.nc.service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.mapper.UserMapper;
import kr.co.nc.vo.User;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;
	
	/**
	 * 카카오 로그인으로 획득한 사용자정보로 로그인처리를 수행한다.<p>
	 * 카카오 로그인은 회원가입 절차없이 카카오 로그인 API로 획득한 정보를 데이터베이스에 저장한다.<p>
	 * 카카오 로그인으로 우리 서비스를 한 번이라도 사용한 사용자는 사용자 정보가 데이터베이스에 이미 저장되어 있다.
	 * @param user 카카오 로그인으로 획득한 사용자 정보
	 * @return 사용자 정보
	 */
	public User loginWithKakao(User user) {
		User savedUser = userMapper.getUserByEmail(user.getEmail());
		log.info("카카오 로그인 아이디로 조회한 유저 정보: " + savedUser);
		
		if (savedUser == null) {
			user.setId(UUID.randomUUID().toString());
			userMapper.insert(user);
			log.info("카카오 로그인 신규 사용자 정보 등록 완료: " + user.getId() + ", " + user.getName());
		}
		return savedUser;
	}
	
	/**
	 * 이 사이트의 회원가입 폼에서 입력한 사용자 정보를 데이터베이스에 등록시킨다.<p>
	 * 사용자명(사용자 아이디), 이메일 중복 여부를 체크한다.
	 * @param user 신규 사용자 정보
	 * @return 사용자정보
	 */
	public User registerUser(User user) {
		log.info("일반 회원가입 유저정보: " + user);
		
		User savedUser = userMapper.getUserById(user.getId());
		if (savedUser != null) {
			log.warn("일반 회원가입: 아이디 중복");
			throw new RuntimeException("사용할 수 없는 아이디입니다.");
		}
		
		savedUser = userMapper.getUserByEmail(user.getEmail());
		if (savedUser != null) {
			log.warn("일반 회원가입: 이메일 중복");
			throw new RuntimeException("사용할 수 없는 이메일입니다.");
		}
		
		userMapper.insert(user);
		log.info("일반 회원가입 신규 사용자 정보 등록 완료");
		
		return user;
	}
	
	/**
	 * 이 사이트에 회원가입한 사용자의 아이디, 비밀번호를 전달받아서 로그인 처리를 수행한다.
	 * @param username 사용자명(아이디)
	 * @param password 비밀번호
	 * @return 인증된 사용자 정보
	 */
	public User login(String id, String password) {
		log.info("일반 로그인: " + id);
		
		User savedUser = userMapper.getUserById(id);
		if (savedUser == null) {
			log.warn("일반 로그인: 사용자정보 없음");
			throw new RuntimeException("사용자가 존재하지 않습니다.");
		}
		if (!"normal".equals(savedUser.getLoginType())) {
			log.warn("일반 로그인: 회원가입 사용자 아님");
			throw new RuntimeException("회원가입으로 가입한 사용자가 아닙니다.");
		}
		if ("Y".equals(savedUser.getDisabled())) {
			log.warn("일반 로그인: 탈퇴처리된 사용자");
			throw new RuntimeException("탈퇴처리된 사용자입니다.");
		}
		if (!password.equals(savedUser.getPassword())) {
			log.warn("일반 로그인: 비밀번호 불일치");
			throw new RuntimeException("비밀번호가 일치하지 않습니다.");
		}
		return savedUser;
	}

	public User facebook(String email, String name) {
		User user = userMapper.getUserByEmail(email);
		if (user == null) {
			user = new User();
			user.setId(UUID.randomUUID().toString());
			user.setEmail(email);

			userMapper.insert(user);// User의 no
		}

		return user;
	}
	
	/**
	 * 해당 번호를 가진 사용자의, 해당 아이디를 가진 숙소에 대한 찜하기 상태를 변경한다.
	 * USER_ACCOMMODATION_LIKE 테이블에 해당사용자의 해당숙소 찜하기 정보가 있으면 삭제하고, 없으면 추가한다.
	 * @param userNo
	 * @param accoId
	 */
	public void changeMyAccoLikeStatus(User loginUser, int accoId) {
		Map<String, Integer> param = new HashMap<>();
		int userNo = loginUser.getNo();
		param.put("userNo", userNo);
		param.put("accoId", accoId);
		
		// isExistUserLikeByAccoId(param)는 존재하면 1을, 존재하지 않으면 0을 반환한다.
		if (isLikedAcco(userNo, accoId)) {
			userMapper.deleteUserLikeByAccoId(param);
		} else {
			userMapper.insertUserLikeByAccoId(param);
		}
	}
	
	/**
	 * 해당 사용자가 해당 숙소를 찜하기 눌렀는지 여부를 조회해 boolean타입의 값으로 반환한다.
	 * @param param {userNo=사용자번호, accoId=숙소아이디}가 담긴 map객체
	 * @return
	 */
	public boolean isLikedAcco(int userNo, int accoId) {
		Map<String, Integer> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("accoId", accoId);
		
		return userMapper.isExistUserLikeByAccoId(param) == 1 ? true : false;
	}
}
