package com.jmh.controller;

//import java.lang.ProcessBuilder.Redirect;
//import java.sql.Date;
//import java.time.LocalDate;
import java.util.ArrayList;
//import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import java.util.stream.Collectors;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.apache.ibatis.annotations.Param;
//import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

//import com.fasterxml.jackson.annotation.JsonFormat;
import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;
//import com.jmh.mapper.MemberMapper;
import com.jmh.service.MemberService;

//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

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired	//의존성 주입
	private MemberService memberService;
	
	//1. 조회(페이징 정보)
	@GetMapping("/memberList")	//parameter 와 argument의 차이
	public String memberList(Model model, Criteria cri, @RequestParam int pageNo, HttpSession session) {
		int totalCnt = memberService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("member_Id_SE" , session.getAttribute("member_Id"));
		return "member/memberList";	//뷰를 반환합니다.(뷰의 위치) - 메서드 타입이 String 이므로.
	}
	
	//1. 조회(사원 정보)
	@PostMapping("/memberList")
	@ResponseBody
	public Map<String, Object> memberList(Model model, Criteria cri, HttpSession session) {//@RequestParam("checkList") List<String> checkList, @RequestBody List<String> checkList
		Map<String, Object> resultMap = new HashMap<>();
		List<MemberDto> memberList = memberService.getmemberList(cri); 
		if(cri.getSearchWord().equals("") && cri.getSearch_startDate() == null && cri.getSearch_endDate() == null) {
			System.err.println("검색어 없는 조회");
			
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			memberList = memberService.getmemberList(cri);
			System.out.println("POST X) searchWord : " + cri.getSearchWord());
			System.out.println("POST X) getSearch_startDate : " + cri.getSearch_startDate());
			System.out.println("POST X) getSearch_endDate : " + cri.getSearch_endDate());
			System.out.println("POST X) totalCnt : " + totalCnt);
			resultMap.put("pageDto", pageDto);
			resultMap.put("memberList", memberList);
			resultMap.put("member_Id_SE", session.getAttribute("member_Id"));
			return resultMap;
		}
		
		if(!cri.getSearchWord().equals("") || cri.getSearch_startDate() != null || cri.getSearch_endDate() != null) {
			System.err.println("검색어 있는 조회");
			
			int totalCnt = memberService.getTotalCnt(cri);
			PageDto pageDto = new PageDto(cri, totalCnt);
			memberList = memberService.searchmemberList(cri);
			System.out.println("POST O) searchWord : " + cri.getSearchWord());
			System.out.println("POST O) getSearch_startDate : " + cri.getSearch_startDate());
			System.out.println("POST O) getSearch_endDate : " + cri.getSearch_endDate());
			System.out.println("POST O) totalCnt : " + totalCnt);
			resultMap.put("pageDto", pageDto);
			resultMap.put("memberList", memberList);
			resultMap.put("member_Id_SE", session.getAttribute("member_Id"));
			return resultMap;
		}
		return resultMap;	
	}
	
	//2. 등록(페이지 이동)
	@GetMapping("/memberInsert")
	public String memberInsert() {
		return "member/memberInsert";
	}
	
	//2. 등록(아이디 체크)
	@GetMapping("/memberInsert_ck")
	@ResponseBody
	public ResponseEntity<Boolean> insertMember_ck(String member_Tel, Integer member_Id) {
		boolean result = true;
		System.out.println("member_Tel : " + member_Tel);
		System.out.println("member_Id : " + member_Id);
		
		if(member_Id != null) {
			if(memberService.checkId(member_Id)) {
				System.out.println("memberService.checkId1(member_Id : " + memberService.checkId(member_Id));
				result = false;
				
			}else {
				System.out.println("memberService.checkId2(member_Id : " + memberService.checkId(member_Id));
				result = true;
			}
		}
		
		if(member_Tel != null) {
			if(memberService.checkTel(member_Tel)) {
				System.out.println("memberService.checkTel1(member_Tel : " + memberService.checkTel(member_Tel));
				result = false;
			
			}else {
				System.out.println("memberService.checkTel2(member_Tel : " + memberService.checkTel(member_Tel));
				result = true;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//2. 등록(회원 등록)
	@PostMapping("/memberInsert")
	public String insertMember(@RequestBody MemberDto insertDatas) {
		
		int insertCnt = memberService.insertMember(insertDatas);
		if(insertCnt > 0) {
			System.out.println("등록성공");
			return "member/memberList";
		}else {
			System.out.println("실패");
			return "";
		}
	}
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	@GetMapping("/memberModify")
	public String modifyMember(@RequestParam("member_Id") int member_Id, Model model, @RequestParam int pageNo, ProjectDto projectDto) { /* , @RequestParam int pageNo */
		//System.out.println("수정 화면 작동");
		List<ProjectDto> memberprojectList = memberService.getmemberprojectList(member_Id);
		System.out.println("memberprojectList : " + memberprojectList);
		model.addAttribute("memberprojectList", memberprojectList);
		model.addAttribute("memberList" ,memberService.getModifyList(member_Id));
		model.addAttribute("pageNo" , pageNo);
		return "member/memberModify";
	}
	
	//3.수정(#modifyButton)버튼 클릭- 조회(체크박스 클릭된 사원 정보)
	@PostMapping("/memberListM")
	@ResponseBody
	public Map<String, Object> memberListM(Model model, Criteria cri, HttpSession session, @RequestBody(required = false) List<String> checkList) {//@RequestParam("checkList") List<String> checkList, @RequestBody List<String> checkList
		System.out.println("checkList : " + checkList);
		Map<String, Object> resultMap = new HashMap<>();
		if(checkList != null) {
			System.err.println("checkList가 비어있지 않아요.");
			List<String> memberListM = memberService.getmemberListM(checkList);
			resultMap.put("memberList", memberListM);
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/member/memberModify");
			mav.addObject("memberListM", memberListM);
			return resultMap;	
		}
		return resultMap;
	}
	
	//3. 수정(회원 정보 수정)
	@PostMapping("/memberModify")
	public ResponseEntity<Boolean> memberModify(@RequestBody MemberDto modifyDatas) {//HTTP 요청의 본문은 하나의 객체만 포함할 수 있기 때문에 RequestBody 는 하나만 가능함
		String member_Tel = modifyDatas.getMember_Tel();	//jsp 에서 보내온 전화번호
		int member_Id = modifyDatas.getMember_Id();		//jsp 에서 보내온 아이디
		System.err.println("modifyDatas : " + modifyDatas);
		
		//1. 원래 내 번호가 아닌데 바꾸고자 하는 번호가 중복되지 않은 경우
		//2. 원래 내 번호가 아닌데 바꾸고자 하는 번호가 중복된 경우
		//예외적 허용: 내 번호인데 바꾸고자 하는 번호가 내 번호일 경우
		int member_Tel_ck = memberService.member_Tel_ck(member_Tel, member_Id);	//바꾸고자 하는 번호가 원래 내 번호인지 아닌지
		boolean result = false;
		
		System.out.println("member_Tel_ck : " + member_Tel_ck);
		if(member_Tel_ck > 0) {  //수정하고자 하는 번호가 내 번호야.
			System.out.println("내 번호가 맞아");
			int modifyCnt = memberService.memberModify(modifyDatas);
			if(modifyCnt > 0) {
				System.out.println("수정 성공1");
				result = true;
			}else if(modifyCnt < 0 ) {
				System.out.println("수정 실패1");
				result = false;
			}
		}else if(member_Tel_ck <= 0) {	//수정하고자 하는 번호가 내 번호가 아니야.
			System.out.println("내 번호가 아니야");
			int modifyCnt = memberService.memberModify(modifyDatas);
			if(modifyCnt > 0) {
				System.out.println("수정 성공2");
				result = true;
			}else if(modifyCnt < 0) {
				System.out.println("수정 실패2");
				result = false;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//2-2. 다중 수정(#m_modifyButton)버튼 클릭했을 때
	@PostMapping("/memberModifyM") 
	public ResponseEntity<?> memberModifyM(@RequestBody List<MemberDto> modifyDatas) {//HTTP 요청의 본문은 하나의 객체만 포함할 수 있기 때문에 RequestBody 는 하나만 가능함
		Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("modifyDatas", modifyDatas);
        
        boolean result = false;
		System.out.println("modifyDatas : " + modifyDatas);
		int modifyCnt = memberService.memberModify_M(resultMap);
		System.out.println("modifyCnt : " + modifyCnt);
		if (modifyCnt >= 0) {
		    System.out.println("수정 성공");
		    result = true;
		} else {
		    System.out.println("수정 실패");
		    result = false;
		}
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	//4. 삭제(다중 회원 정보 삭제)
	@PostMapping("/memberDeleteM") //@RequestParam(value="parameter이름[]")List<String>
	public String memberDeleteM(@RequestBody List<String> checkList) { //@RequestParam int member_Id, @RequestParam(value="checkList[]") MemberDto[] checkList  
		System.out.println("checkList : " + checkList);
		ArrayList<String> deleteMemberM_ck = new ArrayList<String>();
		deleteMemberM_ck = memberService.deleteMemberM_ck(checkList);
		System.out.println("deleteMemberM_ck : " + deleteMemberM_ck);
		
		boolean allZeros = deleteMemberM_ck.stream().allMatch(value -> Integer.parseInt(value) == 0);
		if (allZeros) {
			// 모두 0인 경우
			System.out.println("모든 값이 0입니다.");
			int deleteCnt = memberService.deleteMember(checkList);
			if(deleteCnt > 0) {
				return "member/memberList";
			}else {
				return "";
			}
		} else {
			// 0이 아닌게 하나라도 있다.(=투입이력이 있다)
			System.out.println("0이 아닌 값이 존재합니다.");
		}
		return "";
	}
	
	//4. 삭제(회원 정보 삭제)
	@PostMapping("/memberDelete") //@RequestParam(value="parameter이름[]")List<String>
	public String memberDelete(@RequestBody List<String> checkList) { //@RequestParam int member_Id, @RequestParam(value="checkList[]") MemberDto[] checkList  
		for(String member_Id : checkList) {
			System.out.println("삭제할 체크리스트 : " + checkList);
			int deleteCnt = memberService.deleteMember(checkList);
				
			if(deleteCnt > 0) {
				return "member/memberList";
			}else {
				return "";
			}
		}
		return "";
	}
		
	//5. 멤버 상세화면
	@GetMapping("/memberRead")
	public String memberRead(Model model, @RequestParam int member_Id, Criteria cri, @RequestParam int pageNo) {
		List<ProjectDto> projectList = memberService.getmemberprojectList(member_Id);
		System.out.println("projectList : " + projectList);
		System.out.println("pageNo : " + pageNo);
		model.addAttribute("pageNo" , pageNo);
		model.addAttribute("projectList" , projectList);
		model.addAttribute("memberList" , memberService.getModifyList(member_Id));
		return "member/memberRead";
	}
	
	@PostMapping("/memberModify2")
	public ResponseEntity<Boolean> memberModify2(@RequestBody List<ProjectDetailDto> selectedProjectData) {
		System.out.println("selectedProjectData : " + selectedProjectData);
		Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("selectedProjectData", selectedProjectData);
		boolean result = false;
		int modifyCnt = memberService.memberModify2(resultMap);
		
		if(modifyCnt > 0) {
			System.out.println("수정성공");
			result = true;
		}else if(modifyCnt < 0) {
			System.out.println("수정실패");
			result = false;
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@PostMapping("/memberDelete2")
	public ResponseEntity<Boolean> memberDelete2(@RequestBody List<ProjectDetailDto> selectedProjectData) {
		Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("selectedProjectData", selectedProjectData);
		//System.out.println("selectedProjectData : " + selectedProjectData);
		boolean result = false;
		int deleteCnt = memberService.memberDelete2(resultMap);
		
		if(deleteCnt > 0) {
			System.out.println("삭제성공");
			result = true;
		}else if(deleteCnt < 0) {
			System.out.println("삭제실패");
			result = false;
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
}