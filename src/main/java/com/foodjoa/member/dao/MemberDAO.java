package com.foodjoa.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.foodjoa.member.vo.RecentViewVO;
import com.foodjoa.recipe.vo.RecipeWishListVO;
import com.foodjoa.mealkit.vo.MealkitCartVO;
import com.foodjoa.mealkit.vo.MealkitOrderVO;
import com.foodjoa.mealkit.vo.MealkitVO;

import com.foodjoa.member.vo.MemberVO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession sqlSession;		
	
	public List<HashMap<String, Object>> selectDeliveredMealkit(MealkitVO mealkitvo) {
	    
	    return sqlSession.selectList("mapper.member.selectDeliveredMealkit", mealkitvo);
	}
	
	public List<HashMap<String, Object>> selectSendedMealkit(MealkitVO mealkitvo){
		
		return sqlSession.selectList("mapper.member.selectSendedMealkit", mealkitvo);
	}

	public int selectRecentCount(RecentViewVO recentViewVO) {

		return sqlSession.selectOne("mapper.recentView.selectRecentCount", recentViewVO);
	}

	public int insertRecentRecipe(RecentViewVO recentViewVO) {

		return sqlSession.insert("mapper.recentView.insertRecentView", recentViewVO);
	}

	public int insertMember(MemberVO memberVO) {

		return sqlSession.insert("mapper.member.insertMember", memberVO);

	}

	public boolean isUserExists(String userId) {

		int count = sqlSession.selectOne("mapper.member.isUserExists", userId); // 수정된 코드
		return count > 0;
	}
	
	
	public int deleteMemberById(String readonlyId) {
		
		int count = sqlSession.delete("mapper.member.deleteMemberById", readonlyId);
		return count;
		
	}
	
	public String getProfileFileName(String readonlyId) {
	    return sqlSession.selectOne("mapper.member.getProfileFileName", readonlyId);
	}
	
	
	//----------------------------------------------------
	
	public ArrayList<Integer> selectCountOrderDelivered(String id){
		
		ArrayList<Integer> countOrderDelivered = new ArrayList<Integer>();
		
		MealkitOrderVO orderVO = new MealkitOrderVO();
		orderVO.setId(id);
		
		for (int i = 0; i < 3; i++) {
			orderVO.setDelivered(i);
			
			int result = sqlSession.selectOne("mapper.mealkitOrder.selectCountOrderDelivered", orderVO);
			
			countOrderDelivered.add(result);
		}
		
		return countOrderDelivered;
	}

	public ArrayList<Integer> selectCountOrderSended(String id) {
		
		ArrayList<Integer> countOrderSended = new ArrayList<Integer>();
		
		MealkitOrderVO orderVO = new MealkitOrderVO();
		orderVO.setId(id);
		 
		for (int i = 0; i < 3; i++) {
			orderVO.setDelivered(i);
			
			int result = sqlSession.selectOne("mapper.mealkitOrder.selectCountOrderSended", orderVO);
			
			countOrderSended.add(result);
		}
		
		return countOrderSended;
	}

	public MemberVO selectMember(String id) {
		return sqlSession.selectOne("mapper.member.selectMember", id);
	}

	public int updateMember(MemberVO memberVO) {
	    // MyBatis의 update 메서드를 사용하여 업데이트 작업을 수행합니다.
	    int result = sqlSession.update("mapper.member.updateMember", memberVO);
	    return result;
	}

	public List<RecentViewVO> recentRecipeListById(String userId) {
		return sqlSession.selectList("mapper.recentView.recentRecipeListById",userId);
	}
	
	public List<RecentViewVO> recentMealkitListById(String userId) {
		return sqlSession.selectList("mapper.recentView.recentMealkitListById",userId);
	}

	public List<MealkitCartVO> selectCartListById(String userId) {
		return sqlSession.selectList("mapper.mealkitCart.selectCartListById",userId);
	}

	public int deleteCartList(String userId, String mealkitNo) {
		Map<String, Object> params = new HashMap<>();
	    params.put("userId", userId);
	    params.put("mealkitNo", mealkitNo);
		return sqlSession.delete("mapper.mealkitCart.deleteCartList",params);
	}

	public int updateCartList(String userId, String mealkitNo, int quantity) {
		Map<String, Object> params = new HashMap<>();
	    params.put("userId", userId);
	    params.put("mealkitNo", mealkitNo);
	    params.put("quantity", quantity);
		return sqlSession.update("mapper.mealkitCart.updateCartList",params);
	}

    // 밀키트와 수량 정보를 받아오는 메서드
	public List<HashMap<String, Object>> selectPurchaseMealkits(String[] mealkitNos, String[] quantities) {
	    // 매개변수를 Map으로 묶어서 MyBatis 쿼리로 전달
	    HashMap<String, Object> params = new HashMap<>();
	    params.put("mealkitNos", mealkitNos);
	    params.put("quantities", quantities);  // quantities는 나중에 사용할 수 있음

	    // selectList로 쿼리 실행, 반환 타입을 List<HashMap<String, Object>>로 받기
	    return sqlSession.selectList("mapper.mealkitCart.selectPurchaseMealkits", params);
	}


	public int insertMyOrder(String userId, Integer[] mealkitNosInt, Integer[] quantitiesInt, String address, String isCart) {
	    List<MealkitOrderVO> orderList = new ArrayList<>();
	    
	    // 주문 리스트 만들기
	    for (int i = 0; i < mealkitNosInt.length; i++) {
	        MealkitOrderVO order = new MealkitOrderVO();
	        order.setId(userId);
	        order.setMealkitNo(mealkitNosInt[i]);
	        order.setQuantity(quantitiesInt[i]);
	        order.setAddress(address);
	        orderList.add(order);
	    }
	    
	    // SQL 실행
	    return sqlSession.insert("mapper.mealkitOrder.insertMyOrder", orderList);
	}

	public int deleteCartList(String userId, Integer[] mealkitNosInt) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userId", userId);
	    params.put("mealkitNos", mealkitNosInt);

	    return sqlSession.delete("mapper.mealkitOrder.deleteCartList", params);
	}




}
