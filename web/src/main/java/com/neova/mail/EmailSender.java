package com.neova.mail;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.neova.model.User;

@Component("emailSender")
@PropertySource({ "classpath:mail.properties" })
public class EmailSender {
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private VelocityEngine velocityEngine;
	@Resource
	private Environment env;

	public void sendAccountCreationEmail(final String subject, final User user) {

		final Map<String, Object> input = new HashMap<String, Object>();
		input.put("firstName", user.getFirstName());
		input.put("lastName", user.getLastName());
		input.put("userName", user.getUserName());
		input.put("password", user.getPassword());
		input.put("email", user.getEmail());
		final String fromEmailAddress = env
				.getRequiredProperty("mail.senderUserName");
		final String body = VelocityEngineUtils.mergeTemplateIntoString(
				velocityEngine, "templates/accountCreation.vm", "UTF-8", input);

		sendMessage(user.getEmail(), fromEmailAddress, subject, body);

	}

	public void sendAccountUpdationEmail(final String subject, final User user) {
		final Map<String, Object> input = new HashMap<String, Object>();
		input.put("userName", user.getUserName());
		final String body = VelocityEngineUtils.mergeTemplateIntoString(
				velocityEngine, "templates/accountUpdation.vm", "UTF-8", input);
		final String fromEmailAddress = env
				.getRequiredProperty("mail.senderUserName");

		sendMessage(user.getEmail(), fromEmailAddress, subject, body);

	}

	public void sendAccountDeletionEmail(final String subject, final User user) {

		final Map<String, Object> input = new HashMap<String, Object>();
		input.put("userName", user.getUserName());
		input.put("email", user.getEmail());
		final String body = VelocityEngineUtils.mergeTemplateIntoString(
				velocityEngine, "templates/accountDeletion.vm", "UTF-8", input);
		final String fromEmailAddress = env
				.getRequiredProperty("mail.senderUserName");

		sendMessage(user.getEmail(), fromEmailAddress, subject, body);

	}

	public void sendSimpleEmail(final String toEmailAddresses,
			final String fromEmailAddress, final String subject) {
		VelocityContext context = new VelocityContext();
		context.put("firstName", "Mahendra");
		context.put("lastName", "Bagul");
		context.put("when", "15/04/2014");
		Template t = velocityEngine.getTemplate("templates/reminder.vm");

		final StringWriter writer = new StringWriter();
		t.merge(context, writer);

		sendMessage(toEmailAddresses, fromEmailAddress, subject,
				writer.toString());
	}

	private void sendMessage(final String toEmailAddresses,
			final String fromEmailAddress, final String subject,
			final String body) {

		MimeMessagePreparator preparator = new MimeMessagePreparator() {

			public void prepare(MimeMessage mimeMessage) throws Exception {

				MimeMessageHelper message = new MimeMessageHelper(mimeMessage,
						true);
				message.setTo(toEmailAddresses);
				message.setFrom(new InternetAddress(fromEmailAddress));
				message.setSubject(subject);
				message.setText(body, true);
			}
		};
		this.mailSender.send(preparator);
	}

}