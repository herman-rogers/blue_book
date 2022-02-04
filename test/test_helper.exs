ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BlueBook.Repo, :manual)

Mox.defmock(BlueBook.Services.IEXMock, for: BlueBook.Services.External.Api)
Mox.defmock(BlueBook.MessengerMock, for: BlueBook.Messenger)

Application.put_env(:blue_book, :iex_api, BlueBook.Services.IEXMock)
Application.put_env(:blue_book, :app_logger, BlueBook.MessengerMock)
