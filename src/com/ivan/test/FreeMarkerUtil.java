package com.ivan.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class FreeMarkerUtil {

	private static final String template_dir = "D://Java//project//FreemarkerGen//template";
	private Configuration cfg;

	public void init() throws Exception {
		// 初始化FreeMarker配置
		// 创建一个Configuration实例
		cfg = new Configuration();
		// 设置FreeMarker的模版文件位置
		cfg.setDirectoryForTemplateLoading(new File(template_dir));
	}

	public void process(FreeMarkerUtil hf, String[] args) throws Exception {

		Map<String, Object> root = new HashMap<String, Object>();
		
		String jsonFileName = null;
		if (args.length > 0) {
			jsonFileName = args[0];
		} else {
			System.out.println("请输入json文件路径:");
			BufferedReader br = new BufferedReader(new InputStreamReader(
					System.in));
			jsonFileName = br.readLine();
		}
		FileInputStream fis = new FileInputStream(jsonFileName);
		String json = "";
		int len = 0;
		byte[] buffer = new byte[512];

		while ((len = fis.read(buffer)) > -1) {
			json += new String(buffer, 0, len, "UTF-8");
		}
		
		fis.close();

		// System.out.println("json content= "+json);

		JSONObject jsonObject = JSON.parseObject(json);

		System.out.println("jsonObject = " + jsonObject);

		String projectPath = "D://Java//project//FreemarkerGen//";
		String savePath = "output//";

		root.put("author", "yinghui");
		root.put("data", jsonObject);
		// root.put("entity_package","com.ivan.entity");
		// root.put("entity_package","com.ivan.entity");
		// root.put("entity_package","com.ivan.entity");

		File[] templateFiles = new File(template_dir).listFiles(getFileExtensionFilter("ftl"));

		//实体类前缀使用json文件的名字
		System.out.println("jsonFileName= "+jsonFileName);
		String beanName=jsonFileName.substring(jsonFileName.lastIndexOf("\\")+1, jsonFileName.lastIndexOf("."));
				
		for (File file : templateFiles) {
			String name = file.getName();
			Template template = cfg.getTemplate(name);
			String fileName = getFileName(beanName, name.substring(0, name.lastIndexOf(".")));
			root.put("className", beanName);
			buildTemplate(root, projectPath, savePath, fileName, template);
		}

		// Template template = cfg.getTemplate("a.ftl");
		//
		// buildTemplate(root, projectPath, savePath, fileName, template);
	}

	public static FilenameFilter getFileExtensionFilter(String extension) {// 指定扩展名过滤
		final String _extension = extension;
		return new FilenameFilter() {
			public boolean accept(File file, String name) {
				boolean ret = name.endsWith(_extension);
				return ret;
			}
		};
	}

	/**
	 * 获取输出文件的名字
	 * @return
	 */
	private String getFileName(String beanName, String suffix) {
		return beanName + suffix + ".java";
	}

	public void buildTemplate(Map<String, Object> root, String projectPath, String savePath, String fileName,
			Template template) {
		String realFileName = projectPath + savePath + fileName;
		String realSavePath = projectPath + "/" + savePath;
		File newsDir = new File(realSavePath);
		if (!newsDir.exists()) {
			newsDir.mkdirs();
		}
		try {
			Writer out = new OutputStreamWriter(new FileOutputStream(realFileName), Constants.SYSTEM_ENCODING);
			template.process(root, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {
		FreeMarkerUtil hf = new FreeMarkerUtil();
		hf.init();
		hf.process(hf,args);
	}

}
