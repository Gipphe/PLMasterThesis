import java.util.function.Supplier;

public class Main {
	public static void main(String... args) {
		MailServer ms = new ConsoleMailServer();
		Operator.human1(ms, new Email.Builder());
		System.out.println("-----");
		Operator.human2(ms, () -> new Email.Builder());
	}
}
