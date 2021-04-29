import java.util.function.Consumer;

public class TextCommand implements Command {
	private final Consumer<String> consumer;
	private final String text;

	public TextCommand(Consumer<String> consumer, String text) {
		this.consumer = consumer;
		this.text = text;
	}

	public void execute() {
		if (this.text != null && this.text.length() != 0) {
			this.consumer.accept(this.text);
		}
	}
}
