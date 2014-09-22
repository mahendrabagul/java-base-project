package com.neova.init;

import java.util.Properties;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.hibernate.cfg.NamingStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan("com.neova")
@EnableWebMvc
@EnableTransactionManagement
@PropertySource({ "classpath:application.properties",
		"classpath:log4j.properties", "classpath:mail.properties" })
@ImportResource("classpath:spring-security.xml")
public class WebAppConfig extends WebMvcConfigurerAdapter {

	private static final String PROPERTY_NAME_DATABASE_DRIVER = "db.driver";
	private static final String PROPERTY_NAME_DATABASE_PASSWORD = "db.password";
	private static final String PROPERTY_NAME_DATABASE_URL = "db.url";
	private static final String PROPERTY_NAME_DATABASE_USERNAME = "db.username";
	private static final String PROPERTY_NAME_ENTITYMANAGER_PACKAGES_TO_SCAN = "entitymanager.packages.to.scan";
	private static final String PROPERTY_NAME_HIBERNATE_DIALECT = "hibernate.dialect";
	private static final String PROPERTY_NAME_HIBERNATE_SHOW_SQL = "hibernate.show_sql";

	@Resource
	private Environment env;

	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();

		dataSource.setDriverClassName(env
				.getRequiredProperty(PROPERTY_NAME_DATABASE_DRIVER));
		dataSource.setUrl(env.getRequiredProperty(PROPERTY_NAME_DATABASE_URL));
		dataSource.setUsername(env
				.getRequiredProperty(PROPERTY_NAME_DATABASE_USERNAME));
		dataSource.setPassword(env
				.getRequiredProperty(PROPERTY_NAME_DATABASE_PASSWORD));

		return dataSource;
	}

	private Properties hibProperties() {
		Properties properties = new Properties();
		properties.put(PROPERTY_NAME_HIBERNATE_DIALECT,
				env.getRequiredProperty(PROPERTY_NAME_HIBERNATE_DIALECT));

		properties.put(PROPERTY_NAME_HIBERNATE_SHOW_SQL,
				env.getRequiredProperty(PROPERTY_NAME_HIBERNATE_SHOW_SQL));

		return properties;
	}

	public NamingStrategy namingStrategy() {
		CustomNamingStrategy customNamingStrategy = new CustomNamingStrategy();
		customNamingStrategy.setTenantName("java");
		return customNamingStrategy;
	}

	@Bean
	public LocalSessionFactoryBean sessionFactory() {
		LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
		sessionFactoryBean.setDataSource(dataSource());
		sessionFactoryBean
				.setPackagesToScan(env
						.getRequiredProperty(PROPERTY_NAME_ENTITYMANAGER_PACKAGES_TO_SCAN));
		sessionFactoryBean.setHibernateProperties(hibProperties());
		sessionFactoryBean.setNamingStrategy(namingStrategy());

		return sessionFactoryBean;
	}

	@Bean
	public InternalResourceViewResolver getViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/pages/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

	// @Bean(name = "excelReportView")
	// public ExcelReportView getExcelReportView() {
	// XmlViewResolver resolver = new XmlViewResolver();
	// resolver.se
	// ExcelReportView excelReportView = new ExcelReportView();
	// return excelReportView;
	// }

	@Bean
	public HibernateTransactionManager transactionManager() {
		HibernateTransactionManager transactionManager = new HibernateTransactionManager();
		transactionManager.setSessionFactory(sessionFactory().getObject());
		return transactionManager;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/themes/**")
				.addResourceLocations("classpath:/themes/")
				.setCachePeriod(31556926);
		registry.addResourceHandler("/themes/bootstrap/css/**")
				.addResourceLocations("classpath:/themes/bootstrap/css/")
				.setCachePeriod(31556926);
		registry.addResourceHandler("/themes/bootstrap/js/**")
				.addResourceLocations("classpath:/themes/bootstrap/js/")
				.setCachePeriod(31556926);
		registry.addResourceHandler("/themes/bootstrap/fonts/**")
				.addResourceLocations("classpath:/themes/bootstrap/fonts/")
				.setCachePeriod(31556926);
		registry.addResourceHandler("/themes/styles/**")
				.addResourceLocations("classpath:/themes/styles/")
				.setCachePeriod(31556926);
	}

	@Bean(name = "mailSender")
	public JavaMailSenderImpl getJavaMailSenderImpl() {
		JavaMailSenderImpl javaMailSenderImpl = new JavaMailSenderImpl();
		javaMailSenderImpl.setJavaMailProperties(getMailProperties());
		javaMailSenderImpl.setUsername(env
				.getRequiredProperty("mail.senderUserName"));
		javaMailSenderImpl.setPassword(env
				.getRequiredProperty("mail.senderPassword"));
		return javaMailSenderImpl;

	}

	private Properties getMailProperties() {
		Properties properties = new Properties();
		properties.setProperty("mail.smtp.auth",
				env.getRequiredProperty("smtp.mailSmptpAuth"));

		properties.setProperty("mail.smtp.starttls.enable",
				env.getRequiredProperty("smtp.mailSmtpStarttlsEnable"));

		properties.setProperty("mail.smtp.host",
				env.getRequiredProperty("smtp.mailSmtpHost"));

		properties.setProperty("mail.smtp.port",
				env.getRequiredProperty("smtp.mailSmtpPort"));
		return properties;
	}

	private Properties velocityProperties() {
		Properties properties = new Properties();
		properties.put("resource.loader", "class");
		properties
				.put("class.resource.loader.class",
						"org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
		return properties;
	}

	@Bean(name = "velocityEngine")
	public VelocityEngineFactoryBean getVelocityEngineFactoryBean() {
		VelocityEngineFactoryBean bean = new VelocityEngineFactoryBean();
		bean.setVelocityProperties(velocityProperties());
		return bean;
	}

	@Override
	public void configureDefaultServletHandling(
			DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

}
