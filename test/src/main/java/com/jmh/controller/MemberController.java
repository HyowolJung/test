package com.jmh.controller;

import java.io.IOException;
//import java.lang.ProcessBuilder.Redirect;
//import java.sql.Date;
//import java.time.LocalDate;
import java.util.ArrayList;
//import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.SysexMessage;

//import org.apache.ibatis.annotations.Param;
//import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.EnableCaching;
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
import com.jmh.dto.MemberDetailDTO;
import com.jmh.dto.MemberDto;
import com.jmh.dto.PageDto;
import com.jmh.dto.ProjectDetailDto;
import com.jmh.dto.ProjectDto;
//import com.jmh.mapper.MemberMapper;
import com.jmh.service.MemberService;

//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

@Controller
@EnableCaching
@RequestMapping("/member")
public class MemberController {
	@Autowired	//의존성 주입
	private MemberService memberService;
	
	//엑셀 다운로드
	@GetMapping("/download")
	public void downloadExcel(HttpServletResponse response) throws IOException {
	    memberService.exportToExcel(response);
	}
	
	@PostMapping(value = "/download") //, produces = "application/json;charset=UTF-8"
	public void downloadExcel(HttpServletResponse response, @RequestParam Map<String, String> data) throws IOException {
		System.err.println("datadatadata : " + data);
		//memberService.exportToExcel2(response, data);
	}
	
	//1. 메인페이지
	@GetMapping("/memberMain")
	public String memberMain() {
		return "member/memberMain";
	}
	
	//1. 조회(페이징 정보)
	@GetMapping("/memberList")	//memberList.jsp
	public String memberListGet(Model model, Criteria cri, HttpSession session) {
		int totalCnt = memberService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("memberId" , session.getAttribute("memberId"));
		return "member/memberList";
	}
	
	//1. 조회(사원 정보)
	@PostMapping("/memberList") //memberList.jsp
	@ResponseBody
	public Map<String, Object> memberListPost(Model model, Criteria cri, HttpSession session) {//@RequestParam("checkList") List<String> checkList, @RequestBody List<String> checkList, @RequestParam( value = "selectedList[]" , required = false)List<String>selectedList
		//System.err.println("selectedListselectedListselectedList는 : " + selectedList);
		Map<String, Object> resultMap = new HashMap<>();
		List<MemberDetailDTO> memberList = memberService.getmemberList(cri);
		//List<MemberDetailDTO> memberList2 = memberService.getmemberList2(); //캐시버전인데 안됨;;
		int pageNoPost = cri.getPageNo();
		int totalCnt = memberService.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		resultMap.put("pageNoPost", pageNoPost);
		resultMap.put("pageDto", pageDto);
		resultMap.put("memberList", memberList);
		//resultMap.put("memberList", memberList2);
		return resultMap;	
	}
	
//		if(cri.getSearchWord().equals("") && cri.getSearch_startDate() == null && cri.getSearch_endDate() == null) {
//			System.err.println("검색어 없는 조회");
//			
//			int totalCnt = memberService.getTotalCnt(cri);
//			PageDto pageDto = new PageDto(cri, totalCnt);
//			memberList = memberService.getmemberList(cri);
//			//System.out.println("POST X) searchWord : " + cri.getSearchWord());
//			//System.out.println("POST X) getSearch_startDate : " + cri.getSearch_startDate());
//			//System.out.println("POST X) getSearch_endDate : " + cri.getSearch_endDate());
//			//System.out.println("POST X) totalCnt : " + totalCnt);
//			resultMap.put("pageNoPost", pageNoPost);
//			resultMap.put("pageDto", pageDto);
//			System.err.println("memberListPost : " + memberList);
//			resultMap.put("memberList", memberList);
//			//resultMap.put("member_Id_SE", session.getAttribute("member_Id"));
//			return resultMap;
//		}
//		
//		if(!cri.getSearchWord().equals("") || cri.getSearch_startDate() != null || cri.getSearch_endDate() != null) {
//			System.err.println("검색어 있는 조회");
//			
//			int totalCnt = memberService.getTotalCnt(cri);
//			PageDto pageDto = new PageDto(cri, totalCnt);
//			memberList = memberService.getmemberList(cri);
//			//memberList = memberService.searchmemberList(cri);
//			//System.out.println("POST O) searchWord : " + pageDto.cri.getSearchWord());
//			//System.out.println("POST O) getSearch_startDate : " + pageDto.cri.getSearch_startDate());
//			//System.out.println("POST O) getSearch_endDate : " + pageDto.cri.getSearch_endDate());
//			//System.out.println("POST O) totalCnt : " + totalCnt);
//			resultMap.put("pageNoPost", pageNoPost);
//			resultMap.put("pageDto", pageDto);
//			resultMap.put("memberList", memberList);
//			//resultMap.put("member_Id_SE", session.getAttribute("member_Id"));
//			return resultMap;
//		}

	//2. 등록(페이지 이동)
	@GetMapping("/memberInsert") //memberList.jsp
	public String memberInsert() {
		return "member/memberInsert";
	}
		
	//2. 등록(중복 체크)
	@GetMapping("/memberInsert_ck")	//memberList.jsp
	@ResponseBody
	public ResponseEntity<Boolean> insertMember_ck(String memberTel, String memberId) {
		boolean result = true;
		System.out.println("member_Tel : " + memberTel);
		System.out.println("member_Id : " + memberId);
		
		//1. 아이디(사번) 중복 체크
		if(memberId != null) {
			if(memberService.checkId(memberId)) {
				System.out.println("memberService.checkId1(member_Id : " + memberService.checkId(memberId));
				result = false;
				
			}else {
				System.out.println("memberService.checkId2(member_Id : " + memberService.checkId(memberId));
				result = true;
			}
		}
		
		//2. 전화번호 중복 체크
		if(memberTel != null) {
			if(memberService.checkTel(memberTel)) {
				System.out.println("memberService.checkTel1(member_Tel : " + memberService.checkTel(memberTel));
				result = false;
			
			}else {
				System.out.println("memberService.checkTel2(member_Tel : " + memberService.checkTel(memberTel));
				result = true;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//2. 등록(회원 등록)
	@PostMapping("/memberInsert")	//memberList.jsp
	public String insertMember(@RequestBody MemberDetailDTO insertDatas) {
		
		int insertCnt = memberService.insertMember(insertDatas);
		if(insertCnt > 0) {
			System.out.println("등록성공");
			return "member/memberList";
		}else {
			System.out.println("실패");
			return "";
		}
	}
	
	//2. 수정
	@PostMapping("/memberModifyM")	//memberList.jsp
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
	
	
	
	
	//3. 상세화면
	@PostMapping("/memberRead")
	public String memberReadPost(Model model, Criteria cri, @RequestParam("selectedList[]")List<String>selectedList, @RequestParam("pageNo") int pageNo) {//@RequestParam("memberId") int memberId, 
		System.err.println("selectedList : " + selectedList);
		
		model.addAttribute("pageNo" , pageNo);
		model.addAttribute("memberList" , memberService.getSelectedList(selectedList));
		return "member/memberRead";
	}
	
	//3. 수정(회원 정보 수정)
		@PostMapping("/memberModifyInfo")//, @RequestParam("member_Id") int member_Id2, @RequestParam("pageNo") int pageNo
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
	
	
	//3.수정(#modifyButton)버튼 클릭- 조회(체크박스 클릭된 사원 정보)
//	@PostMapping("/memberListM")
//	@ResponseBody
//	public Map<String, Object> memberList(Model model, Criteria cri, HttpSession session, @RequestBody(required = false) List<String> checkList) {//@RequestParam("checkList") List<String> checkList, @RequestBody List<String> checkList
//		System.out.println("checkList : " + checkList);
//		Map<String, Object> resultMap = new HashMap<>();
//		if(checkList != null) {
//			System.err.println("checkList가 비어있지 않아요.");
//			List<String> memberList = memberService.checkedList(checkList);
//			System.err.println("memberList의 여러건 선택값은 : " + memberList);
//			resultMap.put("memberList", memberList);
//			
//			ModelAndView mav = new ModelAndView();
//			mav.setViewName("/member/memberModify");
//			mav.addObject("memberList", memberList);
//			return resultMap;	
//		}
//		return resultMap;
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@PostMapping("/memberModify")
	public String modifyMember(Model model,
			@RequestParam("member_Id") int member_Id, 
			@RequestParam("pageNo") int pageNo) {
		System.err.println("member_Id2 : " + member_Id);
		System.err.println("pageNo : " + pageNo);
		List<ProjectDto> memberprojectList = memberService.getmemberprojectList(member_Id);
		System.out.println("memberprojectList : " + memberprojectList);
		model.addAttribute("memberprojectList", memberprojectList);
		model.addAttribute("memberList", memberService.getModifyList(member_Id));
		model.addAttribute("pageNo", pageNo);
				
		return "member/memberModify";
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