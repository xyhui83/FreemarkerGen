package com.ivan.test;
 
/**
 *  实体类，由工具生成
 */
 
public class ${className}Entity extends BaseEntity {

	public enum ${className}EntityKey {
		<#list data.Table.Fields as field> 
			<#if field.leftjoin ?? && field.leftjoin.Table ??>
				<#list field.leftjoin.Table.Fields as childField>
					${childField.Name}("${field.leftjoin.Table.Name}.${childField.ToName}"),
				</#list>
			<#else>
				${field.Name}("${data.Table.Name}.${field.ToName}"),
			</#if>
		</#list>
		
		private final String value;

		${className}EntityKey(String value) {
			this.value = value;
		}

		@Override
		public java.lang.String toString() {
			return this.value;
		}
	}

	/**
	 *  构造函数
	 */
	public ${className}Entity() {
	}
	
	/**
	 * 实体查询集合
	 */
	public static class QList extends QueryList<${className}EntityKey> {		
	}

	/**
	 * 实体排序集合
	 */
	public static class OList extends HashMap<${className}Entity.${className}EntityKey, OrderType> {		
	}


    <#list data.Table.Fields as field>
    	<#if field.leftjoin ?? && field.leftjoin.Table ??>
    		<#list field.leftjoin.Table.Fields as childField>
				private ${childField.ToType} ${childField.ToName}
			</#list>
    	<#else>
    		private ${field.ToType} ${field.ToName};
    	</#if>
    	
    </#list>
    
    <#list data.Table.Fields as field>
    	<#if field.leftjoin ?? && field.leftjoin.Table ??>
    		<#list field.leftjoin.Table.Fields as childField>
				public void set${childField.ToName?cap_first}(${childField.ToType} ${childField.ToName}){
		        	this.${childField.ToName} = ${childField.ToName};
			    }
			    
			    public ${childField.ToType} get${childField.ToName?cap_first}(){
			        return this.${childField.ToName};
			    }
			</#list>
    	<#else>
		    public void set${field.ToName?cap_first}(${field.ToType} ${field.ToName}){
		        this.${field.ToName} = ${field.ToName};
		    }
		    
		    public ${field.ToType} get${field.ToName?cap_first}(){
		        return this.${field.ToName};
		    }
	    </#if>
    </#list>
    
    @override
    
    public long getEntityId() {
    	if(id==null)
    		return -1;
    	return this.id;
    }
}