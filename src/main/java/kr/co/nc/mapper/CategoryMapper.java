package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Category;

@Mapper
public interface CategoryMapper {

	List<Category> getAllCategories();
	Category getcateCategoryById(String categoryId);
}
