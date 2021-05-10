import HTTP (HTTP, get)

printInvoices :: HTTP ()
printInvoices = do
    invoices <- get "/invoices"
    print invoices
