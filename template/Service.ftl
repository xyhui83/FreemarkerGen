package swallow.business;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import swallow.base.dao.BaseBusiness;
import swallow.base.dao.PagerInfo;
import swallow.base.exception.SwallowException;


/**
 * 用户信息业务逻辑类，用于对用户信息进行管理服务
 * 
 * @author aohanhe
 *
 */
@Service
@Scope("prototype")
public class ${className}Sevice extends BaseBusiness<${className}Entity> {
	private static Logger log = Logger.getLogger(${className}Sevice.class);

	@Autowired
	private ${className}Mapper mapper;

	public ${className}Sevice() {
		super("基础信息", "用户信息");
	}

	/**
	 * 保存新的用户信息
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	protected ${className}Entity onSaveNew(${className}Entity entity) throws SwallowException {
		if (entity == null)
			throw new SwallowException("参数entity不允许为null");
		entity.setId(-1l);
		mapper.addNew${className}(entity);
		if (entity.getId() < 0)
			throw new SwallowException("没有取得实体在数据库的ID值");

		return getEntity(entity.getId());
	}

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	protected ${className}Entity onUpdate(${className}Entity entity) throws SwallowException {
		if (entity == null)
			throw new SwallowException("参数entity不允许为null");
		int re = mapper.save${className}(entity);
		if (re != 1)
			throw new SwallowException("更新的记录个数不为0：实际为" + re);

		return getEntity(entity.getId());
	}

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	protected boolean onDelete(long id) throws SwallowException {
		int re = mapper.del${className}(id);
		if (re != 1)
			throw new SwallowException("删除的记录个数不为0：实际为" + re);
		return true;
	}

	/**
	 * 取得实体by ID
	 */
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	protected ${className}Entity onGetEntity(long id) throws SwallowException {
		return mapper.get${className}ById(id);
	}

	/**
	 * 通过条件与排序取得所有用户
	 * 
	 * @param queries
	 *            查询条件列表
	 * @param orders
	 *            排序条件列表
	 * @return 对应的结果集
	 * @throws SwallowException
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<${className}Entity> getAll${className}(final ${className}Entity.QList queries, final ${className}Entity.OList orders)
			throws SwallowException {
		try {
			return mapper.getAll${className}(queries, orders);
		} catch (Exception ex) {
			log.error("执行getAll${className}ByPage出错");
			throw new SwallowException("执行getAll${className}ByPage出错");
		}

	}

	/**
	 * 通过条件与排序分页取得所有用户
	 * 
	 * @param queries
	 *            查询条件列表
	 * @param orders
	 *            排序条件列表
	 * @param PagerInfo
	 *            分页信息
	 * @return 对应的结果集 分页结果在PagerInfo返回
	 * @throws SwallowException
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<${className}Entity> getAll${className}ByPage(final ${className}Entity.QList queries,
			final ${className}Entity.OList orders, PagerInfo pagerInfo) throws SwallowException {

		if (pagerInfo == null)
			throw new SwallowException("参数pagerInfo不允许为空");

		try {
			PageHelper.startPage(pagerInfo.getCurrentPage(), pagerInfo.getPageSize());
			List<${className}Entity> reList = mapper.getAll${className}(queries, orders);
			// 更新分页数据
			pagerInfo.updatePageInfo(new PageInfo(reList));
			return reList;
		} catch (Exception ex) {
			log.error("执行getAll${className}ByPage出错");
			throw new SwallowException("执行getAll${className}ByPage出错");
		}		
	}
}
