data Sort
    = Asc
    | Desc

sortList :: Sort -> [a] -> [a]
sortList sort xs = case sort of
    Asc -> ...
    Desc -> ...
