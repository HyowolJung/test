package com.jmh.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jmh.dto.BoardDto;
import com.jmh.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		List<BoardDto> getFreeBoardList = boardService.getFreeBoardList();
		//System.out.println("getFreeBoardList : " + getFreeBoardList);
		model.addAttribute("getFreeBoardList" , getFreeBoardList);
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		return "/board/comunity/home"; 
	}
	
	@PostMapping("/home")
	public String home(@RequestParam String member_Id, Model model, HttpSession session) {
		List<BoardDto> getFreeBoardList = boardService.getFreeBoardList();
		//System.out.println("getFreeBoardList : " + getFreeBoardList);
		model.addAttribute("getFreeBoardList" , getFreeBoardList);
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		return "/board/comunity/home";
	}
	
	@GetMapping("/comunity/insert")
	public String insert() {
		return "/board/comunity/insert";
	}
	
	
	@PostMapping("/comunity/insert")
	public String insert(Model model, @RequestParam int member_Id, @ModelAttribute BoardDto boardForm) {
		if (boardForm.getBoard_Title() != null || boardForm.getBoard_Content() != null || boardForm.getBoard_Type() != null) {
			System.err.println("null이 아니에요.");
			
			int insertCnt = boardService.insertBoard(boardForm);
			if(insertCnt > 0) {
				System.err.println("글 등록 성공");
				return "redirect:/board/comunity/home";
			} else {
				System.err.println("글 등록 실패");
				//return "/board/comunity/insert";
			}
		}
		
		if (boardForm.getBoard_Title() == null || boardForm.getBoard_Content() == null || boardForm.getBoard_Type() == null) {
			System.err.println("null입니다.");
			return "/board/comunity/insert";
		}

		return "/board/comunity/insert";
	}
	
	@PostMapping("/comunity/read")
	public String read2(Model model, String member_Id, String board_Title, HttpSession session) {
		System.err.println("POST) member_Id : " + member_Id + "/ board_Title : " + board_Title);
		List<BoardDto> selectFreeBoardList = boardService.selectFreeBoardList(board_Title);
		model.addAttribute("selectFreeBoardList" , selectFreeBoardList);
		//	List<BoardDto> selectFreeBoardList = boardService.selectFreeBoardList(board_Title);
		//	model.addAttribute("selectFreeBoardList" , selectFreeBoardList);
		System.err.println("selectFreeBoardList 1 : " + selectFreeBoardList);
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		return "/board/comunity/read";
	}
	
	@GetMapping("/comunity/read")
	public String read1(Model model, String member_Id, String board_Title, HttpSession session) {
		model.addAttribute("member_Id", session.getAttribute("member_Id"));
		List<BoardDto> selectFreeBoardList = boardService.selectFreeBoardList(board_Title);
		System.err.println("selectFreeBoardList 2 : " + selectFreeBoardList);
		model.addAttribute("selectFreeBoardList" , selectFreeBoardList);
		return "/board/comunity/read";
	}
	
//	@GetMapping("/auth/kakao/callback")
//    public String kakaoCallback(String code, HttpSession session, RedirectAttributes redirectAttributes, Model model) throws JsonProcessingException {
//        RestTemplate rt = new RestTemplate();
//        HttpHeaders headers = new HttpHeaders();
//        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//
//        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//        params.add("grant_type", "authorization_code");
//        params.add("client_id", clientId);
//        params.add("redirect_uri", redirectUri);
//        params.add("code", code);
//
//        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
//        ResponseEntity<String> response = rt.exchange(
//            "https://kauth.kakao.com/oauth/token",
//            HttpMethod.POST,
//            kakaoTokenRequest,
//            String.class
//        );
//
//        ObjectMapper objectMapper = new ObjectMapper();
//        OAuthToken oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
//
//        RestTemplate rt2 = new RestTemplate();
//        HttpHeaders headers2 = new HttpHeaders();
//        headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
//        headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//
//        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);
//        ResponseEntity<String> response2 = rt2.exchange(
//            "https://kapi.kakao.com/v2/user/me",
//            HttpMethod.POST,
//            kakaoProfileRequest,
//            String.class
//        );
//
//        KakaoProfile kakaoProfile = objectMapper.readValue(response2.getBody(), KakaoProfile.class);
//        String email = kakaoProfile.getKakao_account().getEmail(); // 이메일을 사용자 이름으로 사용
//        Users existingUser = userService.findByEmail(email);
//        System.out.println("이메일체크"+ email);
//
//        String nicknameRaw = kakaoProfile.getProperties().getNickname();
//        String nickname = "";
//		try {
//			nickname = URLEncoder.encode(nicknameRaw, StandardCharsets.UTF_8.toString());
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//
////		UUID garbagePassword = UUID.randomUUID();
////        String password = garbagePassword.toString(); // 랜덤 비밀번호를 생성
//
//        // 사용자가 이미 등록되어 있는지 확인
//        System.out.println("존재하는 사용자:" + existingUser);        
//        if (existingUser == null) {
//        	 redirectAttributes.addAttribute("email", email);
//             redirectAttributes.addAttribute("nickname", nickname);
//        	return "redirect:/register_kakao";
//        }
//        
//        String passwordHash = existingUser.getPasswordHash();
//        
//        // 등록된 사용자인 경우 로그인 처리
//        authenticateUser(email);
//        System.out.println("카카오 Authenticated");	
//        
//        
//        // 등록된 사용자인 경우 로그인 처리
//        List<GrantedAuthority> authorities = new ArrayList<>(); // Assume no specific roles necessary
//        PreAuthenticatedAuthenticationToken authToken = new PreAuthenticatedAuthenticationToken(existingUser, null, authorities);
//        authToken.setAuthenticated(true);
//        SecurityContextHolder.getContext().setAuthentication(authToken);
//        session.setAttribute("userSession", existingUser);
//
//        // After setting authentication, immediately use it for further checks or setups
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        if (authentication != null && authentication.isAuthenticated()) {
//            Users userSession = null;
//
//            if (authentication.getPrincipal() instanceof Users) {
//                userSession = (Users) authentication.getPrincipal();
//            } else if (authentication.getPrincipal() instanceof UserDetails) {
//                String username = ((UserDetails) authentication.getPrincipal()).getUsername();
//                userSession = userService.findByEmail(username);
//            }
//
//            if (userSession != null) {
//                session.setAttribute("userSession", userSession);
//                model.addAttribute("userSession", userSession);
//            } else {
//                System.out.println("Database does not contain the user.");
//            }
//        } else {
//            System.out.println("No authentication information available or user is not authenticated.");
//        }
//        return "redirect:/index";
//    }
//	
//	@GetMapping("/index")    
//    public String processLogin(HttpSession session, Model model) {
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        
//        if (authentication != null && authentication.getPrincipal() instanceof org.springframework.security.core.userdetails.User) {
//            org.springframework.security.core.userdetails.User userDetails = 
//                (org.springframework.security.core.userdetails.User) authentication.getPrincipal(); 
//            String username = userDetails.getUsername(); 
//            Users userSession = dao.findByEmail(username); 
//            if (userSession != null) {
//                session.setAttribute("userSession", userSession);
//                //model.addAttribute("userSession", userSession); 모델로 가져와야되면 주석해제해서 사용.
//            } else {
//                System.out.println("데이터베이스에서 사용자를 찾을 수 없습니다.");
//            }
//        } else {
//            System.out.println("principal 객체가 예상한 타입이 아닙니다.");
//        }
//        return "index";
//    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

