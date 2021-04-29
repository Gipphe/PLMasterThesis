import java.util.function.Supplier;

public class Main {
	public static void main(String... args) {
		MailServer ms = new ConsoleMailServer();
		Operator.human1(ms, new Email.Builder());
		System.out.println("-----");
		Operator.human2(ms, () -> new Email.Builder());
	}
}

/**
 * A human operating the system in question.
 */
class Operator {
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
		Operator human = new Operator(mailServer, editor);
		Command writeInitialBody = human.writeBody("Foo bar baz quux quack");
		Command changeBody = human.writeBody("Eleven point eight inches");
		Command writeSubject = human.writeSubject("Foobar");
		Command signTheEmail = human.signEmailWithServer();
		Command sendTheEmail = human.sendEditedEmail("foo.bar@quack.quux");

		Command[] commands = new Command[]{
			writeInitialBody,
			changeBody,
			writeSubject,
			signTheEmail,
			sendTheEmail
		};

		for (Command command : commands) {
			command.execute();
		}
	}

	public static void human2(MailServer mailServer, Supplier<EmailEditor> editorFactory) {
		EmailEditor editor = editorFactory.get();
		Operator human = new Operator(mailServer, editor);
		String recipient = "grace.hopper@us.navy";
		Command writeInitialBody = human.writeBody("Hello");
		Command writeMoreBody = human.writeBody("Hello there");
		Command writeEvenMoreBody = human.writeBody("Hello th");
		Command writeFinalBody = human.writeBody("Hello, dear reader");
		Command writeTheSubject = human.writeSubject("To hello");
		Command correctTheSubject = new MacroCommand()
			.add(human.writeSubject(""))
			.add(human.writeSubject("To reader"));
		Command sendTheEmail = human.sendEditedEmail(recipient);
		Command sendEmailAgainByAccident = human.sendEditedEmail(recipient);

		Command[] firstEmail = new Command[]{
			writeInitialBody,
			writeMoreBody,
			writeEvenMoreBody,
			writeFinalBody,
			writeTheSubject,
			correctTheSubject,
			sendTheEmail
		};


		for (Command command : firstEmail) {
			command.execute();
		}

		System.out.println("-----");

		sendEmailAgainByAccident.execute();

		System.out.println("-----");

		editor = editorFactory.get();
		Command writeApologeticBody = human.writeBody("Sorry for sending it twice");
		Command writeApologeticSubject = human.writeSubject("RE: To reader");
		Command sendApologeticEmail = human.sendEditedEmail(recipient);

		Command[] secondEmail = new Command[]{
			writeApologeticBody,
			writeApologeticSubject,
			sendApologeticEmail
		};

		for (Command command : secondEmail) {
			command.execute();
		}
	}
}
