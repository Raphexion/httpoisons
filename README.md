# Httpoisons

```
alias Httpoisons.Example.Server

Server.start_link
url = "https://jsonplaceholder.typicode.com/todos/1"
for _ <- 1..100, do: spawn(fn -> Server.get url end)
```
