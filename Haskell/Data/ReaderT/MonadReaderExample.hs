import Customer (Customer(..))
import DB (query)
import MonadReader (MonadReader, ask)

fetchInvoices :: (MonadReader Config m, MonadIO m) => Customer -> m [Invoice]
fetchInvoices customer = do
    config <- ask
    let conn = databaseConnection config
    liftIO
        (query
            conn
            "SELECT * FROM Invoices WHERE customerID = ?"
            [customerID customer]
        )
