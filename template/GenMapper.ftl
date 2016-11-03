package test.dao.generate.mapper;

/**
 * Mybatis映射对象（由代码生成工具生成，修改请重新生成）
 * @author aohanhe
 *
 */
public interface ${className}GenMapper {
	/**
	 * 通过ID取得实体对象
	 * @param Id 对象的ID值
	 * @return
	 * @exception  SwallowException
	 */
	@SelectProvider(method = "get${className}ById", type = ${className}GenSql.class)
	${className}Entity get${className}ById(@Param("id") long Id) ;
	
	/**
	 * 取得所有用户信息
	 * @param queries 查询条件集合
	 * @param orders  排序条件集合
	 * @return UserInfoEntity 列表
	 * @exception  SwallowException
	 */
	@SelectProvider(method = "getAll${className}", type = ${className}GenSql.class)
	List<${className}Entity> getAll${className}(@Param("queries") final ${className}Entity.QList queries,
			 final ${className}Entity.OList orders) ;

	
	
	/**
	 * 保存用户信息
	 * @param userInfo 要保存的新的UserInfoEntity对象 
	 * @return  保存生成的记录条数
	 * @throws SwallowException
	 */
	@SelectProvider(method = "addNew${className}", type = ${className}GenSql.class)	 
	@Options(statementType=StatementType.CALLABLE)	
	void addNew${className}(@Param("entity") ${className}Entity entity);	


	/**
	 * 保存用户信息
	 * @param userInfo 要保存的UserInfoEntity对象 
	 * @return userInfo 影响的记录数
	 * @throws SwallowException
	 */
	@UpdateProvider(method = "save${className}", type = ${className}GenSql.class)
	int save${className}(@Param("entity") ${className}Entity entity);
	
	/**
	 * 删除用户信息
	 * @param id 用户记录对应的id
	 * @return 影响的记录数
	 */
	@DeleteProvider(method = "del${className}", type = ${className}GenSql.class)
	int del${className}(@Param("id") long id);
}
