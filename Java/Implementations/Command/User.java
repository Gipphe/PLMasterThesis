import java.util.*;

public class User {
	private String name;
	private List<Command> commands = new ArrayList<>();

	public User(String name) {
		this.name = name;
	}

	public void newCommand(Command c) {
		this.commands.add(c);
	}

	public void runCommandsAsUser() {
		System.out.println("Running commands as user " + this.name);
		for (Command command : this.commands) {
			command.execute();
		}
		this.commands.clear();
	}
}
