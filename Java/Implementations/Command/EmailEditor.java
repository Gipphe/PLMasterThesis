public interface EmailEditor {
	EmailEditor subject(String subject);
	EmailEditor body(String body);
	EmailEditor sign(String signature);
	Email create();
}
