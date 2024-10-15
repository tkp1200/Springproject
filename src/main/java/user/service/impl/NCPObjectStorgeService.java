package user.service.impl;

import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.UUID;

import org.apache.taglibs.standard.extra.spath.Path;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import spring.conf.NaverConfiguration;
import user.dao.ImageDAO;
import user.service.ObjectStorgeService;
@Service
public class NCPObjectStorgeService implements ObjectStorgeService{
final AmazonS3 s3;	


	public NCPObjectStorgeService(NaverConfiguration configuration) {

		s3=AmazonS3ClientBuilder
				.standard()
				.withEndpointConfiguration(
						new AwsClientBuilder
						.EndpointConfiguration(configuration.getEndPoint(),configuration.getResionName()))
				.withCredentials(new AWSStaticCredentialsProvider(
						new BasicAWSCredentials(configuration.getAccessKey(),configuration.getSecretKey())))
				.build();
	}

	@Override
	public String uploadFile(String bucketName,String directoryPath, MultipartFile img) {
		try(InputStream inputStream=img.getInputStream()){
			String imagefileName=UUID.randomUUID().toString();
			FileInputStream fileIn = null;
			
         

            ObjectMetadata objectMetadata=new ObjectMetadata();
            objectMetadata.setContentType(img.getContentType());
		
			
			PutObjectRequest objectRequest =
					new PutObjectRequest(bucketName,
							directoryPath +imagefileName,
							inputStream,objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead);
			//모든 사용자가 객체를 읽을수있지만 수정삭제 불가능
			
			s3.putObject(objectRequest);
			
			return imagefileName;
			
			
			
		}catch (Exception e) {
			throw new RuntimeException("파일 업로드 에러");
		}
		
	}

	@Override
	public void deleteFile(String bucketName, String directoryPath, String imageFileName) {
		s3.deleteObject(bucketName, directoryPath + imageFileName);

		
	}

}
