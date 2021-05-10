instance MonadIO HTTP where
    liftIO io = HTTP io
