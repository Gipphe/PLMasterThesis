import MonadState (MonadState(..))
import StateT (runStateT)

data Instruction = Inc | Dec

evalInstruction :: MonadState Int m => Instruction -> m ()
evalInstruction instr = do
    i <- get
    put
        (case instr of
            Inc -> i + 1
            Dec -> i - 1
        )

execute :: MonadState Int m => [Instruction] -> m ()
execute []           = pure ()
execute (instr : xs) = do
    evalInstruction instr
    execute xs

main :: IO ()
main = do
    (res, ()) <- runStateT program 0
    print res
    where program = execute [Inc, Inc, Dec, Inc]
