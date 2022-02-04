ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BlueBook.Repo, :manual)

Mox.defmock(BlueBook.Services.IEXMock, for: BlueBook.Services.External.Api)

Application.put_env(:blue_book, :iex_api, BlueBook.Services.IEXMock)
