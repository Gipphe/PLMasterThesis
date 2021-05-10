/**
 * Cutlery from mother nature.
 */
public class PrimitiveCutleryFactory implements CutleryFactory {
	public Fork makeFork() {
		return new PrimitiveFork();
	}

	public Knife makeKnife() {
		return new PrimitiveKnife();
	}
}
