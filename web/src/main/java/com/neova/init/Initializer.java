package com.neova.init;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration.Dynamic;

import org.apache.log4j.Logger;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class Initializer implements WebApplicationInitializer {
	private static final Logger logger = Logger.getLogger(Initializer.class);

	public void onStartup(ServletContext servletContext)
			throws ServletException {
		AnnotationConfigWebApplicationContext ctx = new AnnotationConfigWebApplicationContext();
		ctx.register(WebAppConfig.class);
		servletContext.addListener(new ContextLoaderListener(ctx));

		logger.info("AnnotationConfigWebApplicationContext has been created...");
		// log it via log4j

		if (logger.isDebugEnabled()) {
			logger.debug(ctx);
		}
		ctx.setServletContext(servletContext);

		Dynamic servlet = servletContext.addServlet("dispatcher",
				new DispatcherServlet(ctx));
		servlet.addMapping("/");
		servlet.setLoadOnStartup(1);

	}

}
