package kr.co.nc.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 문의게시판 답변 저장을 위한 vo
 * @author USER
 *
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@Alias("QaAnswer")
public class QaAnswer {

	private int qaNo;
	private int answerNo;
	private String content;
	
	public QaAnswer(int qaNo, String content) {
		this.qaNo = qaNo;
		this.content = content;
	}
}
