import java.util.StringJoiner;

public class ConsoleMailServer implements MailServer {
	public void sendEmail(Email email, String recipient) {
		StringJoiner sj = new StringJoiner("\n");
		sj.add("+ New email");
		sj.add("| Recipient: " + recipient);
		sj.add("| Subject: " + email.subject);
		if (email.signature != null && email.signature.length() != 0) {
			sj.add("| Signature: " + email.signature);
		}
		sj.add("| Body: " + email.body);
		System.out.println(sj);
	}

	public void signEmail(EmailEditor editor) {
		editor.sign("Signed by ConsoleMailServer");
	}
}
