newtype HTTP a = HTTP { runHTTP :: IO a }

get :: String -> HTTP ByteString
get url = ...

post :: String -> JSON -> HTTP ByteString
post url payload = ...
