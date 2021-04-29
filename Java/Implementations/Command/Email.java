import java.util.function.Function;

public class Email {
	public final String subject;
	public final String body;
	public final String signature;

	public Email(String subject, String body, String signature) {
		this.subject = subject;
		this.body = body;
		this.signature = signature;
	}

	public static class Builder implements EmailEditor {
		private String subject = "";
		private String body = "";
		private String signature;

		public EmailEditor subject(String subject) {
			this.subject = subject;
			return this;
		}

		public EmailEditor body(String body) {
			this.body = body;
			return this;
		}

		public EmailEditor sign(String signature) {
			this.signature = signature;
			return this;
		}

		public Email create() {
			return new Email(this.subject, this.body, this.signature);
		}
	}
}
