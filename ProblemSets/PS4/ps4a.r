<<<<<<< HEAD
system('wget -o dates.json "https://www.vizgr.org/historical-events/search.php?format=json&begin_date=00000101&end_date=20210219&lang=en"')
system('cat dates.json')
mylist <- fromJSON('dates.json')
mydf   <- bind_rows(mylist$result[-1])
print(class(mydf))
print(class(mydf$date))
head(mydf, n = 10)
=======
system('wget -o dates.json "https://www.vizgr.org/historical-events/search.php?format=json&begin_date=00000101&end_date=20210219&lang=en"')
system('cat dates.json')
mylist <- fromJSON('dates.json')
mydf   <- bind_rows(mylist$result[-1])
print(class(mydf))
print(class(mydf$date))
head(mydf, n = 10)
>>>>>>> 6abd1b965e6796350454bf87e1f4a915b5e0489d
