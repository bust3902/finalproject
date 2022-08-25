package kr.co.nc.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("QaDto")
public class QaDto {

	private int no;						// QA 글 번호
	private int userNo;					// 사용자 번호
	private String content;				// 문의내용
	private String title;				// 제목
	private Date createdDate;			// 작성일
	private String image;				// 이미지
	private MultipartFile imageFile;	// 이미지
	private String answerStatus;		// 답변 상태
	private String userNickName;		// 사용자 닉네임
	private String userName;			// 사용자 이름

	private String answerContent;			// 답글
}
