package kr.co.dong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.dong.catdog.CatDogService;
import kr.co.dong.catdog.ProductDTO;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Inject
	CatDogService catDogService;  

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView list(HttpSession session) {
	    ModelAndView mav = new ModelAndView();

	    // 세션에서 사용자 정보 가져오기
	    Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
	    String user_id = null;

	    if (user != null && user.get("user_id") != null) {
	        user_id = (String) user.get("user_id");
	    }

	    // 파라미터 맵 구성
	    Map<String, Object> param = new HashMap<>();
	    if (user_id != null) {
	        param.put("user_id", user_id);
	    }

	    // 카테고리별 상품 목록 조회
	    param.put("product_category", 1);
	    List<ProductDTO> list01 = catDogService.mainlist(param);

	    param.put("product_category", 2);
	    List<ProductDTO> list02 = catDogService.mainlist(param);

	    param.put("product_category", 3);
	    List<ProductDTO> list03 = catDogService.mainlist(param);

	    param.put("product_category", 4);
	    List<ProductDTO> list04 = catDogService.mainlist(param);

	    param.put("product_category", 5);
	    List<ProductDTO> list05 = catDogService.mainlist(param);

	    // 뷰에 데이터 추가
	    mav.addObject("list01", list01);
	    mav.addObject("list02", list02);
	    mav.addObject("list03", list03);
	    mav.addObject("list04", list04);
	    mav.addObject("list05", list05);

	    mav.setViewName("home");
	    return mav;
	}
	
	@RequestMapping(value="/main")
	public String testmain(Model model) {
		String name = "Hello Song World~~~";
		model.addAttribute("name", name);//모델에 저장
		return "main";
	}
	
}