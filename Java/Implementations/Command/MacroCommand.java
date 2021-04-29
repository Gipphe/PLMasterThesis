import java.util.*;

public class MacroCommand implements Command {
	private List<Command> commands = new ArrayList<>();

	public MacroCommand add(Command command) {
		this.commands.add(command);
		return this;
	}

	public void execute() {
		for (Command command : this.commands) {
			command.execute();
		}
	}
}
