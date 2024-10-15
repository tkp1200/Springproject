package user.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.model.Bucket;

import user.bean.UserDTO;
import user.bean.UserUploadDTO;
import user.dao.ImageDAO;
import user.dao.UserDAO;
import user.service.ImageService;
import user.service.ObjectStorgeService;

@Service
public class ImageServiceImpl implements ImageService{
@Autowired
private ImageDAO imageDAO;
@Autowired
private HttpSession session;

@Autowired
private ObjectStorgeService objectStorgeService;
private String bucketName ="bitcamp-9th-bucket-136";

@Override
public void write(List<UserUploadDTO> imageUploadList) {
	
	
        imageDAO.write(imageUploadList); // 수정된 부분
    
}

@Override
public List<UserUploadDTO> list() {
    return imageDAO.list();
}

@Override
public UserUploadDTO imageView(String seq) {
	
	return imageDAO.imageView(seq);
}

@Override
public void update(UserUploadDTO userUploadDTO, MultipartFile img) {
	
	String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
	
	System.out.println("실제폴더 =" +filePath);
	
	//object Storage(NCP)는 이미지를 어어쓰지않은다
	//db에서 seq에 해당하는 이미지 파일이름을 꺼내와 삭제하고 집어넣어 새로운 이미지로 수정
	
	String imageFileName=imageDAO.getImageFileName(userUploadDTO.getSeq());
	System.out.println("imageFileName=" + imageFileName);
	//이미지 삭제
	objectStorgeService.deleteFile(bucketName, "storage/", imageFileName);
     System.out.println("기존 이미지 삭제 완료: " + imageFileName);
     
     
	//새로운 이미지 올리기
     imageFileName = objectStorgeService.uploadFile(bucketName, "storage/", img);
String imageOriginalFileName=img.getOriginalFilename();
     File file =new File(filePath,imageOriginalFileName);
     
     try {
		img.transferTo(file);
	} catch (IllegalStateException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
userUploadDTO.setImageFileName(imageFileName);
userUploadDTO.setImageOriginalFileName(imageOriginalFileName);

//DB
imageDAO.uploadUpdate(userUploadDTO);
}

@Override
public void delete(String seq) {
	UserUploadDTO userUploadDTO=imageDAO.imageView(seq);
	
	String imageFileName=imageDAO.getImageFileName(userUploadDTO.getSeq());
	System.out.println("imageFileName=" + imageFileName);
	objectStorgeService.deleteFile(bucketName, "storage/", imageFileName);
    System.out.println("기존 이미지 삭제 완료: " + imageFileName);
	imageDAO.delete(seq);
	
}






	

	

}
