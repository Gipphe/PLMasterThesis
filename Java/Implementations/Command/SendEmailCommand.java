public class SendEmailCommand implements Command {
	private final MailServer mailServer;
	private final EmailEditor editor;
	private final String recipient;

	public SendEmailCommand(MailServer mailServer, EmailEditor editor, String recipient) {
		this.mailServer = mailServer;
		this.editor = editor;
		this.recipient = recipient;
	}

	public void execute() {
		Email email = this.editor.create();
		this.mailServer.sendEmail(email, this.recipient);
	}
}
