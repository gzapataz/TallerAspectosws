/*Envia un correo desde una cuenta temporal de GMAIL
 *
 */


package resources;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class MailTransport {
	
		public void sendEmail(String eMailAddr, String msgImpuesto) {    
	   
	      
	      final String username = "desarrollosgzapata@gmail.com";
	      final String password = "_1234567_";
	      
	      Properties props = System.getProperties();
	      props.put("mail.smtp.auth", "true");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.host", "smtp.gmail.com");
	      props.put("mail.smtp.port", "587");

	     
	      Session session = Session.getInstance(props,
	    		  new javax.mail.Authenticator() {
	    			protected PasswordAuthentication getPasswordAuthentication() {
	    				return new PasswordAuthentication(username, password);
	    			}
	    		  });

	    		try {
	    			Message message = new MimeMessage(session);
	    			message.setFrom(new InternetAddress("desarrollosgzapata@gmail.com"));
	    			message.setRecipients(Message.RecipientType.TO,
	    				InternetAddress.parse((eMailAddr.isEmpty()) ? "desarrollosgzapata@gmail.com": eMailAddr));
	    			message.setSubject("Alerta: Impuesto Mayor al Estipulado");
	    			message.setText("Apreciado Senor,"
	    				+ "\n\n Encontramos un impuesto mayor al estipulado:" + msgImpuesto);

	    			Transport.send(message);

	    			System.out.println(" Correo Enviado");

	    		} catch (MessagingException e) {
	    			throw new RuntimeException(e);
	    	}
	}
}
