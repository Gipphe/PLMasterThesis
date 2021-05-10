import Customer (Customer(..))
import DB (query)
import ReaderT (ReaderT, ask)

fetchInvoices :: Customer -> ReaderT Config IO [Invoice]
fetchInvoices customer = do
    config <- ask
    let conn = databaseConnection config
    liftIO
        (query
            conn
            "SELECT * FROM Invoices WHERE customerID = ?"
            [customerID customer]
        )
