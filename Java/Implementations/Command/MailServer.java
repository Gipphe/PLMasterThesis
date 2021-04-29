public interface MailServer {
	void sendEmail(Email email, String receiver);
	void signEmail(EmailEditor email);
}
