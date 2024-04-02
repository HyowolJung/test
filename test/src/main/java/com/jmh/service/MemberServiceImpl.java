package com.jmh.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.jmh.dto.Criteria;
import com.jmh.dto.MemberDto;
import com.jmh.dto.MemberDto;
import com.jmh.dto.ProjectDto;
import com.jmh.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProjectService projectService;
	
//	@Transactional
//	@Override
//	public void add() {
//		String data1 = "abc";
//		String data2 = "abccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc";
//		//projectService.insertTest1(data1);
//		//projectService.insertTest2(data2);
//		memberMapper.insertTest1(data1);
//		memberMapper.insertTest2(data2);
//	}
	
	//@Autowired
    //private CacheManager cacheManager;
	
	//1. 조회(검색어 X)
	//@Cacheable(value = "memberListCache")
	@Override
	public List<MemberDto> getMemberList(Criteria cri) {// , @Param("data") Criteria data
		return memberMapper.getMemberList(cri);
	}
	
	@Override
	public List<MemberDto> searchMemberList(Criteria cri) {
		return memberMapper.searchMemberList(cri);
	}

	
	@Override
	@Cacheable(value = "memberListCache")
	public List<MemberDto> getmemberList2() {
		System.err.println("cricricricricricri2222 : ");
		return memberMapper.getmemberList2();
	}
	// TODO Auto-generated method stub
			//Cache cache = cacheManager.getCache("memberListCache");
	        //Element element = cache.get(cri);
	        //System.err.println("elementelementelement : " + element);
	//1. 조회(검색어 O)
//	@Override
//	public List<MemberDto> searchmemberList(Criteria cri) {
//		// TODO Auto-generated method stub
//		return memberMapper.searchmemberList(cri);
//	}
	
	//1. 조회(페이징 정보)
	@Override
	public int getTotalCnt(Criteria cri) {
		// TODO Auto-generated method stub
		return memberMapper.getTotalCnt(cri);
	}
	
	//2. 등록(아이디 체크)
	@Override
	public boolean checkId(String memberId) {
		// TODO Auto-generated method stub
		return memberMapper.checkId(memberId);
	}
	
	//2. 등록(전화번호 체크)
	@Override
	public boolean checkTel(String memberTel) {
		// TODO Auto-generated method stub
		return memberMapper.checkTel(memberTel);
	}
	
	//2. 등록(회원 등록)
	@Override
	public int insertMember(MemberDto insertDatas) {
		// TODO Auto-generated method stub
		String pwd = insertDatas.getMemberPw();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPwd = encoder.encode(pwd);
		
		//insertDatas.setMember_Pw(encodedPwd);
		insertDatas.setMemberPw(encodedPwd);
		return memberMapper.insertMember(insertDatas);
	}
	
	@Override
	public List<MemberDto> getSelectedList(List<String> selectedList) {
		// TODO Auto-generated method stub
		return memberMapper.getSelectedList(selectedList);
	}
	
	@Override
	public int modifyMember(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.modifyMember(resultMap);
	}
	
	
	
	
	
	
	
	
	
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	@Override
	public List<MemberDto> getModifyList(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getModifyList(member_Id);
	}
	
	//3. 수정(페이지 이동 + 회원 정보 조회)
	@Override
	public List<MemberDto> selectModifyList(int memberId) {
		// TODO Auto-generated method stub
		return memberMapper.selectModifyList(memberId);
	}
	
	//3. 수정(전화번호 중복체크) - 수정하려는 전화번호가 다른 회원의 전화번호와 겹치는지
	@Override
	public int member_Tel_ck(@Param("member_Tel") String member_Tel, @Param("member_Id") int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.member_Tel_ck(member_Tel, member_Id);
	}
	
	//3. 수정(회원 정보 수정)
	@Override
	public int memberModify(MemberDto modifyDatas) {
		// TODO Auto-generated method stub
		return memberMapper.memberModify(modifyDatas);
	}
	
	
	
	
	
	//4. 삭제(회원 정보 삭제)
	@Override
	public int deleteMember(List<String> member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.deleteMember(member_Id);
	}

	@Override
	public List<ProjectDto> getmemberprojectList(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberprojectList(member_Id);
	}

	@Override
	public int getmemberId(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getmemberId(member_Id);
	}

//	@Override
//	public int memberModify2(Map<String, Object> resultMap) {
//		// TODO Auto-generated method stub
//		return memberMapper.memberModify2(resultMap);
//	}

	@Override
	public int memberDelete2(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.memberDelete2(resultMap);
	}

	@Override
	public List<MemberDto> getFilterd_search_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id) {
		System.out.println("Service) cri.getStartNo() : " + cri.getStartNo());
		return memberMapper.getFilterd_search_mem_List(cri, project_Id);
	}

	@Override
	public List<MemberDto> getFilterd_mem_List(@Param("cri") Criteria cri, @Param("project_Id") int project_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getFilterd_mem_List(cri, project_Id);
	}

//	@Override
//	public List<MemberDto> loginCk(@Param("member_Id") int member_Id, @Param("member_Pw_ck") String member_Pw_ck) {
//		// TODO Auto-generated method stub
//		
//		return memberMapper.loginCk(member_Id, member_Pw_ck);
//	}

	@Override
	public List<String> checkedList(List<String> checkList) {
		// TODO Auto-generated method stub
		return memberMapper.checkedList(checkList);
	}

	@Override
	public int memberModify_M(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.memberModify_M(resultMap);
	}

	@Override
	public ArrayList<String> deleteMemberM_ck(List<String> checkList) {
		// TODO Auto-generated method stub
		return memberMapper.deleteMemberM_ck(checkList);
	}

	@Override
	public ArrayList<MemberDto> member_Tel_ck_m(List<MemberDto> modifyList) {
		// TODO Auto-generated method stub
		return memberMapper.member_Tel_ck_M(modifyList);
	}
	
	//팝업창 관련
	@Override
	public int projectDetailInsert(Map<String, Object> resultMap) {
		// TODO Auto-generated method stub
		return memberMapper.projectDetailInsert(resultMap);
	}

	@Override
	public String getmember_Pw(int member_Id) {
		// TODO Auto-generated method stub
		return memberMapper.getmember_Pw(member_Id);
	}

//	@Override
//	public void exportToExcel(HttpServletResponse response) throws IOException {
//	    List<MemberDto> memberList = memberService.getmemberList(new Criteria()); // 전체 데이터를 가져오는 로직
//
//	    Workbook workbook = new XSSFWorkbook();
//	    Sheet sheet = workbook.createSheet("Data");
//
//	    // 헤더 생성
//	    Row headerRow = sheet.createRow(0);
//	    String[] headerNames = {"Member ID", "Member Name", "Gender", "Position", "Department", "Telephone", "Start Day", "Last Day"}; // 실제 컬럼명으로 변경하세요
//	    for (int i = 0; i < headers.length; i++) {
//	        Cell cell = headerRow.createCell(i);
//	        cell.setCellValue(headers[i]);
//	    }
//
//	    // 데이터 쓰기
//	    int rowIdx = 1;
//	    for (MemberDto member : memberList) {
//	        Row row = sheet.createRow(rowIdx++);
//
//	        row.createCell(0).setCellValue(member.getMemberId());
//	        row.createCell(1).setCellValue(member.getMemberName());
//	        row.createCell(2).setCellValue(member.getMemberGn());
//	        // 나머지 필드도 이와 같은 방식으로 추가...
//	    }
//
//	    // HTTP 응답으로 Excel 파일 전송
//	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//	    response.setHeader("Content-Disposition", "attachment; filename=\"members.xlsx\"");
//
//	    workbook.write(response.getOutputStream());
//	    workbook.close();
//	}
	
	@Override
	public void exportToExcel(HttpServletResponse response) throws IOException{
		// TODO Auto-generated method stub
		List<MemberDto> memberList = memberService.searchMemberList(new Criteria()); // 전체 데이터를 가져오는 로직
		System.err.println("memberListmemberListmemberListmemberList : " + memberList);
		Workbook workbook = new XSSFWorkbook();
	    Sheet sheet = workbook.createSheet("Data");

	    Row headerRow = sheet.createRow(0);
	    String[] headerNames = {"Member ID", "Member Name", "Gender", "Position", "Department", "Telephone", "Start Day", "Last Day"}; // 실제 컬럼명으로 변경하세요
	    for (int i = 0; i < headerNames.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headerNames[i]);
	    }
	    
	    int rowIdx = 1;
	    for (MemberDto member : memberList) {
	        Row row = sheet.createRow(rowIdx++);
	        row.createCell(0).setCellValue(member.getMemberId());
	        row.createCell(1).setCellValue(member.getMemberName());
	        row.createCell(2).setCellValue(member.getMemberGn());
	        row.createCell(3).setCellValue(member.getMemberPos());
	        row.createCell(4).setCellValue(member.getMemberDept());
	        row.createCell(5).setCellValue(member.getMemberTel());
	        row.createCell(6).setCellValue(member.getMemberStDay());
	        row.createCell(7).setCellValue(member.getMemberLaDay());
	    }
	    
	    //String[] headerNames = {"Member ID", "Member Name", "Gender", "Position", "Department", "Telephone", "Start Day", "Last Day"};
	    
//	    // 헤더 생성
//	    Row headerRow = sheet.createRow(0);
//	    Cell headerCell = headerRow.createCell(0);
//	    headerCell.setCellValue("Column1");
//
//	    headerCell = headerRow.createCell(1);
//	    headerCell.setCellValue("Column2");

//	    // 데이터 쓰기
//	    Row dataRow = sheet.createRow(1);
//	    Cell dataCell = dataRow.createCell(0);
//	    dataCell.setCellValue("Data1");
//
//	    dataCell = dataRow.createCell(1);
//	    dataCell.setCellValue("Data2");

	    // 여기에서 실제 데이터를 반복해서 추가...

	    // HTTP 응답으로 Excel 파일 전송
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment; filename=\"member.xlsx\"");

	    workbook.write(response.getOutputStream());
	    workbook.close();
	}

	
	

	
//	try {
//	String memberName1 = "abc";
//	String memberName2 = "abccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc";
//	
//    memberMapper.insertTest1(memberName1);
//    memberMapper.insertTest2(memberName2);
//} catch (DataIntegrityViolationException e) {
//	// TODO: handle exception
//	System.err.println("데이터 크기 오류");
//}	
//	@Override
//	public int insertTest1(String member_Name1) {
//		// TODO Auto-generated method stub
//		
//		return memberMapper.insertTest1(member_Name1);
//	}
//
//	@Override
//	public int insertTest2(String member_Name2) {
//		// TODO Auto-generated method stub
//		return memberMapper.insertTest2(member_Name2);
//	}	

	
	
//	@Override
//	public void exportToExcel2(HttpServletResponse response, List<MemberDto> modifyDatas) throws IOException {
//		System.err.println("modifyDatasmodifyDatasmodifyDatas : " + modifyDatas);
//		Workbook workbook = new XSSFWorkbook();
//	    Sheet sheet = workbook.createSheet("Data");
//
//	    // 헤더 생성
//	    Row headerRow = sheet.createRow(0);
//	    String[] headerNames = {"Member ID", "Member Name", "Gender", "Position", "Department", "Telephone", "Start Day", "Last Day"};
//	    for (int i = 0; i < headerNames.length; i++) {
//	        Cell cell = headerRow.createCell(i);
//	        cell.setCellValue(headerNames[i]);
//	    }
//
//	    // 데이터 쓰기
//	    int rowNum = 1;
//	    for (MemberDto member : modifyDatas) {
//	        Row row = sheet.createRow(rowNum++);
//	        row.createCell(0).setCellValue(member.getMemberId());
//	        row.createCell(1).setCellValue(member.getMemberName());
//	        row.createCell(2).setCellValue(member.getMemberGn());
//	        row.createCell(3).setCellValue(member.getMemberPos());
//	        row.createCell(4).setCellValue(member.getMemberDept());
//	        row.createCell(5).setCellValue(member.getMemberTel());
//	        row.createCell(6).setCellValue(member.getMemberStDay());
//	        row.createCell(7).setCellValue(member.getMemberLaDay());
//	    }
//	    
//	    // HTTP 응답으로 Excel 파일 전송
//	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//	    response.setHeader("Content-Disposition", "attachment; filename=\"data.xlsx\"");
//
//	    workbook.write(response.getOutputStream());
//	    workbook.close();
//	}

//	@Override
//	public String getDept(String member_Id) {
//		// TODO Auto-generated method stub
//		return memberMapper.getDept(member_Id);
//	}
}
