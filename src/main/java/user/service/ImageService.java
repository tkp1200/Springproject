package user.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import user.bean.UserUploadDTO;



public interface ImageService {

	public void write(List<UserUploadDTO> imageUploadList);

	public List<UserUploadDTO> list();

	public UserUploadDTO imageView(String seq);

	public void update(UserUploadDTO userUploadDTO, MultipartFile img);

	

	public void delete(String seq);

	
	
	
	
}
