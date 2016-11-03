package test.dao.generate.mapper;

/**
 * SQL构建类（由代码生成工具生成，修改请重新生成）
 * 
 * @author aohanhe
 *
 */
public class ${className}GenSql {
	protected String SEL_FIELD = " tbUser.id as id,tbUser.name as name,tbUser.mobile as mobile, 
	tbUser.company_Id as companyId, tbUserCompany.Name as companyName";
	protected String SEL_TABLE = "tb_user tbUser";
	protected String TABLE = "${data.Table.Name}";
	protected String[] LEFT_JOINTABLES = { "tb_user_company tbUserCompany on tbUserCompany.id = tbUser.company_Id" };
	protected String SEQ = "${data.Table.Name}_SEQ";

	/**
	 * 根据ID构建查询语句
	 * 
	 * @param Id
	 * @return
	 */
	public String get${className}ById(@Param("id") long Id) {
		return new SQL() {
			{
				SELECT(SEL_FIELD);
				FROM(SEL_TABLE);
				for (String joinTables : LEFT_JOINTABLES) {
					LEFT_OUTER_JOIN(joinTables);

				}
				WHERE("tbUser.id = ${'#'}{id}");
			}
		}.toString();
	}
	
	public String get${className}ByCurrentId() {
		return new SQL() {
			{
				SELECT(SEL_FIELD);
				FROM(SEL_TABLE);
				for (String joinTables : LEFT_JOINTABLES) {
					LEFT_OUTER_JOIN(joinTables);

				}
				WHERE("tbUser.id = re");
			}
		}.toString();
	}

	/**
	 * 查询用户信息SQL
	 * 
	 * @param queries
	 * @param orders
	 * @return
	 */
	public String getAll${className}(@Param("queries") final ${className}Entity.QList queries,
			final ${className}Entity.OList orders) {
		String string = new SQL() {
			{
				SELECT(SEL_FIELD);
				FROM(SEL_TABLE);
				for (String joinTables : LEFT_JOINTABLES) {
					LEFT_OUTER_JOIN(joinTables);
				}
				// 生成查询条件
				if (queries != null) {
					for (int i = 0; i < queries.size(); i++) {
						Query<${className}Entity.${className}EntityKey> query = queries.get(i);
						WHERE(query.getKeyName() + " " + query.getOpt().toString() + " ${'#'}{queries." + i + ".value}");
					}
				}

				// 生成排序条件
				if (orders != null) {
					for (${className}EntityKey key : orders.keySet()) {
						ORDER_BY(key.toString() + " " + orders.get(key).toString());
					}
				}

			}
		}.toString();
		return string;
	}

	/**
	 * 添加新用户SQL
	 * 
	 * @param entity
	 * @return
	 */
	public String addNew${className}(@Param("entity") ${className}Entity entity) {
		String string = new SQL() {
			{
				INSERT_INTO(TABLE);
				VALUES("id ,name,mobile",
						SEQ + ".NEXTVAL,${'#'}{entity.name,mode=IN,jdbcType=VARCHAR},${'#'}{entity.mobile,mode=IN,jdbcType=VARCHAR}");

			}
		}.toString();
		
		
		return "BEGIN "+string+" ; SELECT "+SEQ + ".CURRVAL into ${'#'}{entity.id,mode=OUT,jdbcType=NUMERIC,javaType=long}   FROM DUAL; END;";
		}

	

	/**
	 * 更新用户数据SQL
	 * 
	 * @param entity
	 * @return
	 */
	public String save${className}(@Param("entity") ${className}Entity entity) {
		String string = new SQL() {
			{
				UPDATE(TABLE);
				SET("name = ${'#'}{entity.name,jdbcType=VARCHAR}");
				SET("mobile = ${'#'}{entity.mobile,jdbcType=VARCHAR}");
				WHERE("id = ${'#'}{entity.id}");
			}
		}.toString();
		return string;
	}

	/**
	 * 删除指定ID的用户信息
	 * 
	 * @param id
	 * @return
	 */
	public String del${className}(@Param("id") long id) {
		String string = new SQL() {
			{
				DELETE_FROM(TABLE);
				WHERE("id = ${'#'}{id}");
			}
		}.toString();
		return string;
	}

}
