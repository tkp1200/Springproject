package user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import user.bean.UserDTO;
import user.bean.UserUploadDTO;
@Mapper
public interface ImageDAO {

	
    public List<UserUploadDTO> list(); // 이 메서드가 정의되어야 함
	public void write(List<UserUploadDTO> imageUploadList);
	public UserUploadDTO imageView(String seq);
	public String getImageFileName(int seq);
	public void uploadUpdate(UserUploadDTO userUploadDTO);
	public void delete(String seq);
	

	

	

}
