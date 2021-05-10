import StateT (StateT, get, put)

data Instruction = Inc | Dec

evalInstruction :: Monad m => Instruction -> StateT Int m ()
evalInstruction instr = do
    i <- get
    put
        (case instr of
            Inc -> i + 1
            Dec -> i - 1
        )

execute :: Monad m => [Instruction] -> StateT Int m ()
execute []           = pure ()
execute (instr : xs) = do
    evalInstruction instr
    execute xs

main :: IO ()
main = do
    (res, ()) <- runStateT program 0
    print res
    where program = execute [Inc, Inc, Dec, Inc]
