package user.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.bean.UserDTO;
import user.bean.UserPaging;
import user.dao.UserDAO;
import user.service.UserService;
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private UserPaging userPaging;

	@Override
	public String getExistId(String id) {
		UserDTO userDTO = userDAO.getExistId(id);
		
		if(userDTO == null)
			return "non_exist";
		else
			return "exist";
	}


	@Override
	public void write(UserDTO userDTO) {
		System.out.println(" user: " + userDTO); 
		userDAO.write(userDTO);
	}


	@Override
	public Map<String,Object> list(String pg) {
		//1페이지당 5개씩
		//
		
		int startNum= (Integer.parseInt(pg)-1)*5;
		int endNum= 5;
		
		Map<String,Integer> map =new HashedMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		List<UserDTO> list=userDAO.list(map);
		int tatalA=userDAO.getTotalA();
		userPaging.setCurrentPage(Integer.parseInt(pg));
		userPaging.setPageBlock(3);
		userPaging.setPageSize(5);
		userPaging.setTotalA(tatalA);
		userPaging.makePagingHTML();
		
		Map<String,Object> map2 =new HashedMap<>();
		map2.put("list", list);
		map2.put("userPaging", userPaging);
		
		return map2;
	}


	@Override
	public UserDTO getUser(String id) {
		
		return userDAO.getUser(id);
	}


	@Override
	public void update(UserDTO userDTO) {
		
		userDAO.update(userDTO);
		System.out.println(userDTO);
	}


	@Override
	public void delete(String id) {
		userDAO.delete(id);
		
	}


	


	@Override
	public boolean check(String id, String pwd) {
	    Map<String, String> map = new HashMap<>();
	    map.put("id", id); // id를 map에 추가
	    map.put("pwd", pwd); // pwd를 map에 추가
	    
	    UserDTO userDTO = userDAO.check(map); // map을 사용하여 데이터베이스 쿼리 호출
	    return userDTO != null; // 유저가 존재하면 true, 그렇지 않으면 false
	}


}
