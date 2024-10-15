package user.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import user.bean.UserDTO;
import user.bean.UserUploadDTO;
import user.dao.ImageDAO;
import user.service.ImageService;
import user.service.ObjectStorgeService;
import user.service.UserService;
@Controller

public class UserUploadController {
	@Autowired
	private ImageService imageService;
	@Autowired
	private ObjectStorgeService objectStorgeService;
	private String bucketName ="bitcamp-9th-bucket-136";

	
	@RequestMapping(value = "/user/uploadForm")
	  public String uploadForm() {
		
	 return "upload/uploadForm";
	  }
		@RequestMapping(value = "/user/uploadAJxaForm")
		  public String uploadAJxaForm() {
			
		 return "upload/uploadAJxaForm";
		  }
		/*
		 * //2개이상
		 * 
		 * @RequestMapping(value = "/user/upload", method = RequestMethod.POST)
		 * 
		 * @ResponseBody public String upload(@ModelAttribute UserUploadDTO
		 * userUploadDTO,
		 * 
		 * @RequestParam MultipartFile[] img,HttpSession session) {
		 * //실제폴더//HttpServletRequest request//
		 * 
		 * String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		 * 
		 * System.out.println("실제폴더 =" +filePath);
		 * 
		 * 
		 * 
		 * 
		 * String imageOriginalFileName; File file; String result; //-------
		 * imageOriginalFileName= img[0].getOriginalFilename(); file =new
		 * File(filePath,imageOriginalFileName); try { img[0].transferTo(file); } catch
		 * (IllegalStateException e) {
		 * 
		 * e.printStackTrace(); } catch (IOException e) {
		 * 
		 * e.printStackTrace(); }
		 * 
		 * result = "<span>" + "<img src='/spring/storage/" + imageOriginalFileName +
		 * "' width='300' height='300'>" + "</span>"; //------- imageOriginalFileName=
		 * img[1].getOriginalFilename(); file =new File(filePath,imageOriginalFileName);
		 * try { img[1].transferTo(file); } catch (IllegalStateException e) {
		 * 
		 * e.printStackTrace(); } catch (IOException e) {
		 * 
		 * e.printStackTrace(); }
		 * 
		 * result += "<span>" + "<img src='/spring/storage/" + imageOriginalFileName +
		 * "' width='300' height='300'>" + "</span>";
		 * 
		 * System.out.println(userUploadDTO.getImageName()+","
		 * +userUploadDTO.getImageContent()+"," +userUploadDTO.getImageFileName()+","
		 * +userUploadDTO.getImageOriginalFileName());
		 * userUploadDTO.setImageOriginalFileName(imageOriginalFileName); //DB
		 * 
		 * return result; }
		 */
	//1개 또는 여러개
	//한글공백있어도 업로드 문제없음!!
	@RequestMapping(value = "/user/upload", method = RequestMethod.POST,produces = "text/html; charset=UTF-8")
	@ResponseBody
	  public String upload(@ModelAttribute UserUploadDTO userUploadDTO,
				 @RequestParam("img[]") List<MultipartFile> list,
				 HttpSession session)  {
		//실제폴더//HttpServletRequest request//
		
		String filePath = session.getServletContext().getRealPath("WEB-INF/storage");

		System.out.println("실제폴더 =" +filePath);
		
		String imageFileName = null;
		String imageOriginalFileName;
		File file;
		String result="";
		
		
		//파일들을 모아서 DB로 보내기
				List<UserUploadDTO> imageUploadList = new ArrayList<>();
				for(MultipartFile img:list) {
					//imageFileName =UUID.randomUUID().toString();
					//naver cloud 오브젝트 스토리지 PlateForm
					imageFileName =objectStorgeService.uploadFile(bucketName,"storage/",img);
				}
				
				for(MultipartFile img : list) {
					imageOriginalFileName = img.getOriginalFilename();
					file = new File(filePath, imageOriginalFileName);
					
					try {
						img.transferTo(file);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
//					try {
						result += "<span>"
							   + "<img src='/spring/storage/"
//							   + URLEncoder.encode(imageOriginalFileName, "UTF-8")//공백 있을시 깨짐
							   +imageOriginalFileName
							   + "' width='200' height='200'>"
							   + "</span>";
//					} catch (UnsupportedEncodingException e) {
//						e.printStackTrace();
//					}
				//DB
				UserUploadDTO dto = new UserUploadDTO();
				dto.setImageName(userUploadDTO.getImageName());
				dto.setImageContent(userUploadDTO.getImageContent());
				dto.setImageFileName(imageFileName);
				dto.setImageOriginalFileName(imageOriginalFileName);
				
				imageUploadList.add(dto);
				
			
		}
		 
		 
				
				imageService.write(imageUploadList);
		
		
		
		return result;
	  }
/* 1개의 파일만 넘어올떄
		@RequestMapping(value = "/user/upload", method = RequestMethod.POST)
		@ResponseBody
		  public String upload(@ModelAttribute UserUploadDTO userUploadDTO,
				  				@RequestParam MultipartFile img,HttpSession session) {
			//실제폴더//HttpServletRequest request//
			
			String filePath = session.getServletContext().getRealPath("WEB-INF/storage");

			System.out.println("실제폴더 =" +filePath);
			
			String imageOriginalFileName= img.getOriginalFilename();
			File file =new File(filePath,imageOriginalFileName);
			try {
				img.transferTo(file);
			} catch (IllegalStateException e) {
				
				e.printStackTrace();
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			
			String result = "<span>" 
	                + "<img src='/spring/storage/" + imageOriginalFileName + "' width='300' height='300'>" 
	                + "</span>";
			
			System.out.println(userUploadDTO.getImageName()+","
								+userUploadDTO.getImageContent()+","
								+userUploadDTO.getImageFileName()+","
								+userUploadDTO.getImageOriginalFileName());
			userUploadDTO.setImageOriginalFileName(imageOriginalFileName);
			//DB
			
			return result;
		  }*/
	@RequestMapping(value = "/user/uploadList")
    public String uploadList(Model model) {
        List<UserUploadDTO> list = imageService.list();
        model.addAttribute("list", list);  // JSP에 전달할 데이터 추가

        return "upload/uploadList";  // JSP 파일 경로
    }
	//update
	@RequestMapping(value = "/user/uploadView")
    public String uploadView(@RequestParam String seq,Model model) {
		
		UserUploadDTO userUploadDTO =imageService.imageView(seq);
		 model.addAttribute("userUploadDTO", userUploadDTO);
        return "upload/uploadView";  // JSP 파일 경로
    }
	
	@RequestMapping(value = "/user/uploadUpdateForm")
    public String uploadupdate( @RequestParam String seq,Model model) {
		UserUploadDTO userUploadDTO =imageService.imageView(seq);
		 model.addAttribute("userUploadDTO", userUploadDTO);

        return "upload/uploadUpdateFrom";  // JSP 파일 경로
    }
	
	///////////
	@RequestMapping(value = "/user/uploadUpdate")
    public String uploadUpdate(@ModelAttribute UserUploadDTO userUploadDTO,
			 @RequestParam("img") MultipartFile img) {
		
		
		
		

	    // DB 업데이트
	    imageService.update(userUploadDTO,img);

	    return "이미지 수정 완료"; // 성공 페이지로 리다이렉트
	}

	@RequestMapping(value = "/user/uploaddelete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(@RequestParam("seq") List<String> seqList) {
		
	    for (String seq : seqList) {
	    	System.out.println("seq: "+seq);
	        imageService.delete(seq);  // 각 seq에 대해 delete 메서드 호출
	        
	    }
	}
    
	
}
