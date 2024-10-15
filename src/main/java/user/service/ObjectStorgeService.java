package user.service;

import org.springframework.web.multipart.MultipartFile;

public interface ObjectStorgeService {

	
	String uploadFile(String bucketName, String directoryPath, MultipartFile img);

	

	void deleteFile(String bucketName, String directoryPath, String imageFileName);

}
