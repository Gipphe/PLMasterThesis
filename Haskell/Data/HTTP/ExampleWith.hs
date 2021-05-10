import HTTP (HTTP, get)

printInvoices :: HTTP ()
printInvoices = do
    invoices <- get "/invoices"
    liftIO (print invoices)
