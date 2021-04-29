public class SignEmailCommand implements Command {
	private final EmailEditor editor;
	private final MailServer mailServer;

	public SignEmailCommand(MailServer mailServer, EmailEditor editor) {
		this.mailServer = mailServer;
		this.editor = editor;
	}

	public void execute() {
		this.mailServer.signEmail(this.editor);
	}
}
