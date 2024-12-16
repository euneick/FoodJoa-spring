package com.foodjoa.mealkit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.foodjoa.mealkit.vo.MealkitCartVO;
import com.foodjoa.mealkit.vo.MealkitOrderVO;
import com.foodjoa.mealkit.vo.MealkitReviewVO;
import com.foodjoa.mealkit.vo.MealkitVO;
import com.foodjoa.mealkit.vo.MealkitWishListVO;

@Repository
public class MealkitDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Map<String, Object>> selectMealkitsList(MealkitVO mealkitVO){
		return sqlSession.selectList("mapper.mealkit.selectMealkitsList", mealkitVO);
	}

	public MealkitVO selectMealkitInfo(int no) {
		return sqlSession.selectOne("mapper.mealkit.selectMealkitInfo", no);
	}

	public List<Object> selectReviewsInfo(MealkitVO mealkitVO) {
		return sqlSession.selectList("mapper.mealkitReview.selectReviewsInfo", mealkitVO);
	}

	public List<Map<String, Object>> selectMyMealkitsList(MealkitVO mealkitVO) {
		return sqlSession.selectList("mapper.mealkit.selectMyMealkitsList", mealkitVO);
	}

	public MealkitReviewVO selectMyReviewInfo(int no) {
		return sqlSession.selectOne("mapper.mealkit.selectMyReviewInfo", no);
	}

	public int insertMealkit(MealkitVO mealkitVO) {
		return sqlSession.insert("mapper.mealkit.insertMealkit", mealkitVO);
	}
	
	public MealkitVO selectRecentMealkit(MealkitVO mealkitVO) {
		return sqlSession.selectOne("mapper.mealkit.selectRecentMealkit", mealkitVO);
	}

	public int deleteMealkit(int no) {
		return sqlSession.delete("mapper.mealkit.deleteMealkit", no);
	}

	public List<Map<String, Object>> selectSearchList(String key, String word) {
		Map<String, Object> params = new HashMap<>();
	    params.put("key", key);
	    params.put("word", word);
	    
		return sqlSession.selectList("mapper.mealkit.selectSearchList", params);
	}

	public int selectMealkitWishlist(MealkitWishListVO wishlistVO) {
		return sqlSession.selectOne("mapper.mealkitWishlist.selectMealkitWishlist", wishlistVO);
	}
	
	public int insertMealkitWishlist(MealkitWishListVO wishlistVO) {
		return sqlSession.insert("mapper.mealkitWishlist.insertMealkitWishlist", wishlistVO);
	}

	public int selectMealkitCart(MealkitCartVO cartVO) {
		return sqlSession.selectOne("mapper.mealkitCart.selectMealkitCart", cartVO);
	}

	public int updateMealkitCart(MealkitCartVO cartVO) {
		return sqlSession.update("mapper.mealkitCart.updateMealkitCart", cartVO);
	}
	
	public int insertMealkitCart(MealkitCartVO cartVO) {
		return sqlSession.insert("mapper.mealkitCart.insertMealkitCart", cartVO);
	}

	public List<MealkitReviewVO> selectReviewsById(String userId) {
		return sqlSession.selectList("mapper.mealkitReview.selectReviewsById", userId);
	}

	public List<MealkitWishListVO> selectWishListById(String userId) {
		return sqlSession.selectList("mapper.mealkitWishlist.selectWishListById", userId);
	}

	public int deleteWishlist(int _no) {
		return sqlSession.delete("mapper.mealkitWishlist.deleteWishlist", _no);
	}

	public List<MealkitWishListVO> selectRecentById(String userId) {
		return sqlSession.selectList("mapper.recentViewMealkit.selectRecentById", userId);
	}

	// 민석 작업
	public List<MealkitOrderVO> selectDeliveredMealkits(String userId) {
		return sqlSession.selectList("mapper.mealkitOrder.selectDeliveredMealkits", userId);
	}

	// 민석 작업
	public List<MealkitOrderVO> selectSendedMealkits(String userId) {
		return sqlSession.selectList("mapper.mealkitOrder.selectSendedMealkits", userId);
	}
}
