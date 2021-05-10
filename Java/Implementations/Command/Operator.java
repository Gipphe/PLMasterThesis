import java.util.function.Supplier;

/**
 * A human operating the system in question.
 */
public class Operator {
	private EmailEditor editor;
	private MailServer mailServer;

	public Operator(MailServer mailServer, EmailEditor editor) {
		this.mailServer = mailServer;
		this.editor = editor;
	}

	public Command sendEditedEmail(String recipient) {
		return new SendEmailCommand(this.mailServer, this.editor, recipient);
	}

	public Command signEmailWithServer() {
		return new SignEmailCommand(this.mailServer, this.editor);
	}

	public Command writeSubject(String subject) {
		return new TextCommand(t -> this.editor.subject(t), subject);
	}

	public Command writeBody(String body) {
		return new TextCommand(t -> this.editor.body(t), body);
	}

	public static void human1(MailServer mailServer, EmailEditor editor) {
		User user = new User("Human 1");
		Operator human = new Operator(mailServer, editor);

		Command[] commands = new Command[]{
			human.writeBody("Foo bar baz quux quack"),
			human.writeBody("Eleven point eight inches"),
			human.writeSubject("Foobar"),
			human.signEmailWithServer(),
			human.sendEditedEmail("foo.bar@quack.quux")
		};

		for (Command command : commands) {
			user.newCommand(command);
		}

		user.runCommandsAsUser();
	}

	public static void human2(MailServer mailServer, Supplier<EmailEditor> editorFactory) {
		User user = new User("Human 2");
		EmailEditor editor = editorFactory.get();
		Operator human = new Operator(mailServer, editor);
		String recipient = "grace.hopper@us.navy";

		Command[] commands = new Command[]{
			human.writeBody("Hello"),
			human.writeBody("Hello there"),
			human.writeBody("Hello th"),
			human.writeBody("Hello, dear reader"),
			human.writeSubject("To hello"),
			new MacroCommand()
				.add(human.writeSubject(""))
				.add(human.writeSubject("To reader")),
			human.sendEditedEmail(recipient),
			human.sendEditedEmail(recipient),
		};

		for (Command command : commands) {
			user.newCommand(command);
		}

		user.runCommandsAsUser();

		System.out.println("-----");

		editor = editorFactory.get();

		// 63

		Command[] commands = new Command[]{
			human.writeBody("Sorry for sending it twice"),
			human.writeSubject("RE: To reader"),
			human.sendEditedEmail(recipient)
		};

		for (Command command : commands) {
			user.newCommand(command);
		}

		user.runCommandsAsUser();
	}
}
