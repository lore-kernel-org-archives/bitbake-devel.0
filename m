Return-Path: <develop@schnelte.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FADC07548
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 07:45:08 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by mx.groups.io with SMTP id smtpd.web11.8310.1700034297807401573
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 23:44:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: schnelte.de, ip: 212.227.126.130, mailfrom: develop@schnelte.de)
Received: from [10.50.195.250] ([137.133.13.22]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8XgH-1rPSbx0VA9-014Tp4 for <bitbake-devel@lists.openembedded.org>; Wed, 15
 Nov 2023 08:44:56 +0100
Content-Type: multipart/alternative;
 boundary="------------82xByYpzGdy0l0RtQXxv5D3T"
Message-ID: <3f695af4-e04c-46c0-b97b-a2312178f509@schnelte.de>
Date: Wed, 15 Nov 2023 08:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH v6 02/22] hashserv: Add websocket
 connection implementation
To: bitbake-devel@lists.openembedded.org
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-3-JPEWhacker@gmail.com>
 <31f6c36f-4924-4880-9788-537ec241263c@schnelte.de>
 <CAJdd5GbSH-r=b5qpzzNdhZ-q6mR7WuE8XX3=u8ZF9xL8UCDFDA@mail.gmail.com>
Content-Language: en-US
From: Matthias Schnelte <develop@schnelte.de>
In-Reply-To: <CAJdd5GbSH-r=b5qpzzNdhZ-q6mR7WuE8XX3=u8ZF9xL8UCDFDA@mail.gmail.com>
X-Provags-ID: V03:K1:ThafDpaFbNAJncxHNl2xOKqwtAdC4OXKdXvqvkTlXdhYIRnz4iC
 gZy6wMuuAZM2AJveaPBlYcn2KpY0CEhT6ejYxH9iZ+u0td681PwxdRfFX/9P7P4TBY1Qb5k
 P9Fevd9u/0RferWPVhb3RVkbaP6MgGgrMvw4ZN0YnV4UIeyzI42AFKU7Xf8d8rpLQ/ISSRc
 ezafwhFFXBaZpG7VBq2GA==
UI-OutboundReport: notjunk:1;M01:P0:Skx6d+nAtYY=;dvoJc9+AgQrjanttYrbznFl15PF
 naqWRjYY9BRHpgi4TVWxxOWYx2Jnple77EY3128BTsnSIg/gKqb8ZQKBYI/3Oxw4+aC1CUxdB
 7mJxpXYMVpLjHAbEoCkNfL8GD58Iv7aNWX4OAiXLqpqnLlFeosZDSHfAUA6gRK5JP36w9PGWk
 8GvlHeWaxXVIBISw7VIGSAOEwlnXkR0rAxZ5Xzh5HwmrVV/5qhPef9hDmJKXFg9/GG2JxRt/Q
 Cw7cIJJpcm2QKhV8I9P4xg/PWQ8kmBTpWfbWMH84R4H8479SSIP8+fzWQlO9od7I0p3UY8YGM
 gQ3Dy5YfgxDIISlarMhhW8b7PqmKWvScowBoe1O6lVPFCRVnzFvy5GqUTdJsk68SegLGoCd7F
 Ga/5vn/tQklobJOnx7v4+Y4piY6810WAOgzxK6qA+qG4n9uuUZ2SYmgyHvdWzdDRCAL9qByiV
 SAmyULiItiN0zrBnB92Mb6tInNnelpULy2us6yryC1eD08yxGlElj1L0/F4fk+GH4ttnd34Aa
 PB6JS1mBAHJl6DkwsakeEEJVrryTm9kyVv4W6tglA7oBHfQz3hSCunTWUBRECFudEDdEnIFll
 h6+AzTlnZnGDqU1ROD78XjwACuUlyruuz+5XGSm+NIANf3gW7sY3nO74MYKIBOlu8Nt/RsZYg
 deg++aGzQAnK3Pa0lUvXyhN0ntXsgX4JJ0GHKiIJ8Gy5+5emjQpTRCYWZ5Y0COUi0trvlx7w3
 rmz03AX6gzmk5bzGBbbVm0qNgokVUtvRjRI9IU067TXeMeAlwDNcPLW5R7HTijaS/uGUvwME1
 LAUiUA9ia3d+GxFpDDymCBTpJilwqaJIa74vhai/yPwioQTH3sdqHkk3s9vdn+LjAcTWhwgE+
 C6/rJaMShAsag1Q==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Nov 2023 07:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15529

This is a multi-part message in MIME format.
--------------82xByYpzGdy0l0RtQXxv5D3T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joshua,

what we are using currently is a http tunnel to be able to connect to 
the hashserver which is running on azure infrastructure. The hashserver 
connection in the local.conf is then connecting to the localhost port of 
the httptunnel.

The tunnel is started whenever bitbake is called. This is done by 
sourcing our own environment that replaces the bitbake command with a 
small script that opens the tunnel and then call the original bitbake. I 
just came across  'addhandler' - maybe this would have been a better 
integrated solution.

But this is some project specific plumping - not sure if one could make 
this into a more generic solution.

On 10.11.23 15:11, Joshua Watt wrote:
>
>
> On Fri, Nov 10, 2023, 5:03 AM Matthias Schnelte <develop@schnelte.de> 
> wrote:
>
>     Hi Joshua,
>
>     thanks for this change! Being able to use websockets instead of
>     some tcp
>     connection would help a lot in cooperate setups which are often
>     restricted to only http(s) ports and enforce the use of a
>     cooperate proxy.
>
>     Unfortunately the websocket library you are using seems not to
>     support
>     websockets over http proxy. At least that is what I understood.
>
>     Would it be possible to use another client lib for websockets in
>     order
>     to support connection through proxy?
>
>     This library seems to support it:
>     https://websocket-client.readthedocs.io/en/latest/examples.html#connecting-through-a-proxy
>
>
> I'm not sure that's going to work. We need a library that supports 
> asyncio, and has very minimal dependencies, which the current library 
> satisfies (it only depends on core Python)
>
>
> Maybe there is another solution for proxying?
>
>
>
>
>     Matthias
>
>     On 03.11.23 15:26, Joshua Watt wrote:
>     > Adds support to the hash equivalence client and server to
>     communicate
>     > over websockets. Since websockets are message orientated instead of
>     > stream orientated, and new connection class is needed to handle
>     them.
>     >
>     > Note that websocket support does require the 3rd party
>     websockets python
>     > module be installed on the host, but it should not be required
>     unless
>     > websockets are actually being used.
>     >
>     > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>     > ---
>     >   lib/bb/asyncrpc/client.py     | 11 +++++++-
>     >   lib/bb/asyncrpc/connection.py | 44 +++++++++++++++++++++++++++++
>     >   lib/bb/asyncrpc/serv.py       | 53
>     ++++++++++++++++++++++++++++++++++-
>     >   lib/hashserv/__init__.py      | 13 +++++++++
>     >   lib/hashserv/client.py        |  1 +
>     >   lib/hashserv/tests.py         | 17 +++++++++++
>     >   6 files changed, 137 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
>     > index 7f33099b..802c07df 100644
>     > --- a/lib/bb/asyncrpc/client.py
>     > +++ b/lib/bb/asyncrpc/client.py
>     > @@ -10,7 +10,7 @@ import json
>     >   import os
>     >   import socket
>     >   import sys
>     > -from .connection import StreamConnection, DEFAULT_MAX_CHUNK
>     > +from .connection import StreamConnection, WebsocketConnection,
>     DEFAULT_MAX_CHUNK
>     >   from .exceptions import ConnectionClosedError
>     >
>     >
>     > @@ -47,6 +47,15 @@ class AsyncClient(object):
>     >
>     >           self._connect_sock = connect_sock
>     >
>     > +    async def connect_websocket(self, uri):
>     > +        import websockets
>     > +
>     > +        async def connect_sock():
>     > +            websocket = await websockets.connect(uri,
>     ping_interval=None)
>     > +            return WebsocketConnection(websocket, self.timeout)
>     > +
>     > +        self._connect_sock = connect_sock
>     > +
>     >       async def setup_connection(self):
>     >           # Send headers
>     >           await self.socket.send("%s %s" % (self.proto_name,
>     self.proto_version))
>     > diff --git a/lib/bb/asyncrpc/connection.py
>     b/lib/bb/asyncrpc/connection.py
>     > index c4fd2475..a10628f7 100644
>     > --- a/lib/bb/asyncrpc/connection.py
>     > +++ b/lib/bb/asyncrpc/connection.py
>     > @@ -93,3 +93,47 @@ class StreamConnection(object):
>     >           if self.writer is not None:
>     >               self.writer.close()
>     >               self.writer = None
>     > +
>     > +
>     > +class WebsocketConnection(object):
>     > +    def __init__(self, socket, timeout):
>     > +        self.socket = socket
>     > +        self.timeout = timeout
>     > +
>     > +    @property
>     > +    def address(self):
>     > +        return ":".join(str(s) for s in self.socket.remote_address)
>     > +
>     > +    async def send_message(self, msg):
>     > +        await self.send(json.dumps(msg))
>     > +
>     > +    async def recv_message(self):
>     > +        m = await self.recv()
>     > +        return json.loads(m)
>     > +
>     > +    async def send(self, msg):
>     > +        import websockets.exceptions
>     > +
>     > +        try:
>     > +            await self.socket.send(msg)
>     > +        except websockets.exceptions.ConnectionClosed:
>     > +            raise ConnectionClosedError("Connection closed")
>     > +
>     > +    async def recv(self):
>     > +        import websockets.exceptions
>     > +
>     > +        try:
>     > +            if self.timeout < 0:
>     > +                return await self.socket.recv()
>     > +
>     > +            try:
>     > +                return await
>     asyncio.wait_for(self.socket.recv(), self.timeout)
>     > +            except asyncio.TimeoutError:
>     > +                raise ConnectionError("Timed out waiting for data")
>     > +        except websockets.exceptions.ConnectionClosed:
>     > +            raise ConnectionClosedError("Connection closed")
>     > +
>     > +    async def close(self):
>     > +        if self.socket is not None:
>     > +            await self.socket.close()
>     > +            self.socket = None
>     > diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
>     > index 3e0d0632..dfb03773 100644
>     > --- a/lib/bb/asyncrpc/serv.py
>     > +++ b/lib/bb/asyncrpc/serv.py
>     > @@ -12,7 +12,7 @@ import signal
>     >   import socket
>     >   import sys
>     >   import multiprocessing
>     > -from .connection import StreamConnection
>     > +from .connection import StreamConnection, WebsocketConnection
>     >   from .exceptions import ClientError, ServerError,
>     ConnectionClosedError
>     >
>     >
>     > @@ -178,6 +178,54 @@ class UnixStreamServer(StreamServer):
>     >           os.unlink(self.path)
>     >
>     >
>     > +class WebsocketsServer(object):
>     > +    def __init__(self, host, port, handler, logger):
>     > +        self.host = host
>     > +        self.port = port
>     > +        self.handler = handler
>     > +        self.logger = logger
>     > +
>     > +    def start(self, loop):
>     > +        import websockets.server
>     > +
>     > +        self.server = loop.run_until_complete(
>     > +            websockets.server.serve(
>     > +                self.client_handler,
>     > +                self.host,
>     > +                self.port,
>     > +                ping_interval=None,
>     > +            )
>     > +        )
>     > +
>     > +        for s in self.server.sockets:
>     > +            self.logger.debug("Listening on %r" %
>     (s.getsockname(),))
>     > +
>     > +            # Enable keep alives. This prevents broken client
>     connections
>     > +            # from persisting on the server for long periods of
>     time.
>     > +            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
>     > +            s.setsockopt(socket.IPPROTO_TCP,
>     socket.TCP_KEEPIDLE, 30)
>     > +            s.setsockopt(socket.IPPROTO_TCP,
>     socket.TCP_KEEPINTVL, 15)
>     > +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 4)
>     > +
>     > +        name = self.server.sockets[0].getsockname()
>     > +        if self.server.sockets[0].family == socket.AF_INET6:
>     > +            self.address = "ws://[%s]:%d" % (name[0], name[1])
>     > +        else:
>     > +            self.address = "ws://%s:%d" % (name[0], name[1])
>     > +
>     > +        return [self.server.wait_closed()]
>     > +
>     > +    async def stop(self):
>     > +        self.server.close()
>     > +
>     > +    def cleanup(self):
>     > +        pass
>     > +
>     > +    async def client_handler(self, websocket):
>     > +        socket = WebsocketConnection(websocket, -1)
>     > +        await self.handler(socket)
>     > +
>     > +
>     >   class AsyncServer(object):
>     >       def __init__(self, logger):
>     >           self.logger = logger
>     > @@ -190,6 +238,9 @@ class AsyncServer(object):
>     >       def start_unix_server(self, path):
>     >           self.server = UnixStreamServer(path,
>     self._client_handler, self.logger)
>     >
>     > +    def start_websocket_server(self, host, port):
>     > +        self.server = WebsocketsServer(host, port,
>     self._client_handler, self.logger)
>     > +
>     >       async def _client_handler(self, socket):
>     >           try:
>     >               client = self.accept_client(socket)
>     > diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
>     > index 3a401835..56b9c6bc 100644
>     > --- a/lib/hashserv/__init__.py
>     > +++ b/lib/hashserv/__init__.py
>     > @@ -9,11 +9,15 @@ import re
>     >   import sqlite3
>     >   import itertools
>     >   import json
>     > +from urllib.parse import urlparse
>     >
>     >   UNIX_PREFIX = "unix://"
>     > +WS_PREFIX = "ws://"
>     > +WSS_PREFIX = "wss://"
>     >
>     >   ADDR_TYPE_UNIX = 0
>     >   ADDR_TYPE_TCP = 1
>     > +ADDR_TYPE_WS = 2
>     >
>     >   UNIHASH_TABLE_DEFINITION = (
>     >       ("method", "TEXT NOT NULL", "UNIQUE"),
>     > @@ -84,6 +88,8 @@ def setup_database(database, sync=True):
>     >   def parse_address(addr):
>     >       if addr.startswith(UNIX_PREFIX):
>     >           return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX):],))
>     > +    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
>     > +        return (ADDR_TYPE_WS, (addr,))
>     >       else:
>     >           m = re.match(r'\[(?P<host>[^\]]*)\]:(?P<port>\d+)$', addr)
>     >           if m is not None:
>     > @@ -103,6 +109,9 @@ def create_server(addr, dbname, *,
>     sync=True, upstream=None, read_only=False):
>     >       (typ, a) = parse_address(addr)
>     >       if typ == ADDR_TYPE_UNIX:
>     >           s.start_unix_server(*a)
>     > +    elif typ == ADDR_TYPE_WS:
>     > +        url = urlparse(a[0])
>     > +        s.start_websocket_server(url.hostname, url.port)
>     >       else:
>     >           s.start_tcp_server(*a)
>     >
>     > @@ -116,6 +125,8 @@ def create_client(addr):
>     >       (typ, a) = parse_address(addr)
>     >       if typ == ADDR_TYPE_UNIX:
>     >           c.connect_unix(*a)
>     > +    elif typ == ADDR_TYPE_WS:
>     > +        c.connect_websocket(*a)
>     >       else:
>     >           c.connect_tcp(*a)
>     >
>     > @@ -128,6 +139,8 @@ async def create_async_client(addr):
>     >       (typ, a) = parse_address(addr)
>     >       if typ == ADDR_TYPE_UNIX:
>     >           await c.connect_unix(*a)
>     > +    elif typ == ADDR_TYPE_WS:
>     > +        await c.connect_websocket(*a)
>     >       else:
>     >           await c.connect_tcp(*a)
>     >
>     > diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
>     > index 5f7d22ab..9542d72f 100644
>     > --- a/lib/hashserv/client.py
>     > +++ b/lib/hashserv/client.py
>     > @@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):
>     >           super().__init__()
>     >           self._add_methods(
>     >               "connect_tcp",
>     > +            "connect_websocket",
>     >               "get_unihash",
>     >               "report_unihash",
>     >               "report_unihash_equiv",
>     > diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
>     > index f343c586..01ffd52c 100644
>     > --- a/lib/hashserv/tests.py
>     > +++ b/lib/hashserv/tests.py
>     > @@ -483,3 +483,20 @@ class
>     TestHashEquivalenceTCPServer(HashEquivalenceTestSetup,
>     HashEquivalenceComm
>     >           # If IPv6 is enabled, it should be safe to use
>     localhost directly, in general
>     >           # case it is more reliable to resolve the IP address
>     explicitly.
>     >           return socket.gethostbyname("localhost") + ":0"
>     > +
>     > +
>     > +class
>     TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup,
>     HashEquivalenceCommonTests, unittest.TestCase):
>     > +    def setUp(self):
>     > +        try:
>     > +            import websockets
>     > +        except ImportError as e:
>     > +            self.skipTest(str(e))
>     > +
>     > +        super().setUp()
>     > +
>     > +    def get_server_addr(self, server_idx):
>     > +        # Some hosts cause asyncio module to misbehave, when
>     IPv6 is not enabled.
>     > +        # If IPv6 is enabled, it should be safe to use
>     localhost directly, in general
>     > +        # case it is more reliable to resolve the IP address
>     explicitly.
>     > +        host = socket.gethostbyname("localhost")
>     > +        return "ws://%s:0" % host
>     >
>     >
>     >
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15501):https://lists.openembedded.org/g/bitbake-devel/message/15501
> Mute This Topic:https://lists.openembedded.org/mt/102364905/7851872
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [develop@schnelte.de]
> -=-=-=-=-=-=-=-=-=-=-=-
>
--------------82xByYpzGdy0l0RtQXxv5D3T
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Joshua, <br>
    </p>
    <p>what we are using currently is a http tunnel to be able to
      connect to the hashserver which is running on azure
      infrastructure. The hashserver connection in the local.conf is
      then connecting to the localhost port of the httptunnel.<br>
    </p>
    <p>The tunnel is started whenever bitbake is called. This is done by
      sourcing our own environment that replaces the bitbake command
      with a small script that opens the tunnel and then call the
      original bitbake. I just came across  'addhandler' - maybe this
      would have been a better integrated solution.</p>
    <p>But this is some project specific plumping - not sure if one
      could make this into a more generic solution.<br>
    </p>
    <div class="moz-cite-prefix">On 10.11.23 15:11, Joshua Watt wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJdd5GbSH-r=b5qpzzNdhZ-q6mR7WuE8XX3=u8ZF9xL8UCDFDA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Fri, Nov 10, 2023,
              5:03 AM Matthias Schnelte &lt;<a
                href="mailto:develop@schnelte.de" moz-do-not-send="true"
                class="moz-txt-link-freetext">develop@schnelte.de</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote"
style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi
              Joshua,<br>
              <br>
              thanks for this change! Being able to use websockets
              instead of some tcp <br>
              connection would help a lot in cooperate setups which are
              often <br>
              restricted to only http(s) ports and enforce the use of a
              cooperate proxy.<br>
              <br>
              Unfortunately the websocket library you are using seems
              not to support <br>
              websockets over http proxy. At least that is what I
              understood.<br>
              <br>
              Would it be possible to use another client lib for
              websockets in order <br>
              to support connection through proxy?<br>
              <br>
              This library seems to support it: <br>
              <a
href="https://websocket-client.readthedocs.io/en/latest/examples.html#connecting-through-a-proxy"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">https://websocket-client.readthedocs.io/en/latest/examples.html#connecting-through-a-proxy</a></blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I'm not sure that's going to work. We need a
          library that supports asyncio, and has very minimal
          dependencies, which the current library satisfies (it only
          depends on core Python)</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Maybe there is another solution for proxying?</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote"
style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
              <br>
              Matthias<br>
              <br>
              On 03.11.23 15:26, Joshua Watt wrote:<br>
              &gt; Adds support to the hash equivalence client and
              server to communicate<br>
              &gt; over websockets. Since websockets are message
              orientated instead of<br>
              &gt; stream orientated, and new connection class is needed
              to handle them.<br>
              &gt;<br>
              &gt; Note that websocket support does require the 3rd
              party websockets python<br>
              &gt; module be installed on the host, but it should not be
              required unless<br>
              &gt; websockets are actually being used.<br>
              &gt;<br>
              &gt; Signed-off-by: Joshua Watt &lt;<a
                href="mailto:JPEWhacker@gmail.com" target="_blank"
                rel="noreferrer" moz-do-not-send="true"
                class="moz-txt-link-freetext">JPEWhacker@gmail.com</a>&gt;<br>
              &gt; ---<br>
              &gt;   lib/bb/asyncrpc/client.py     | 11 +++++++-<br>
              &gt;   lib/bb/asyncrpc/connection.py | 44
              +++++++++++++++++++++++++++++<br>
              &gt;   lib/bb/asyncrpc/serv.py       | 53
              ++++++++++++++++++++++++++++++++++-<br>
              &gt;   lib/hashserv/__init__.py      | 13 +++++++++<br>
              &gt;   lib/hashserv/client.py        |  1 +<br>
              &gt;   lib/hashserv/tests.py         | 17 +++++++++++<br>
              &gt;   6 files changed, 137 insertions(+), 2 deletions(-)<br>
              &gt;<br>
              &gt; diff --git a/lib/bb/asyncrpc/client.py
              b/lib/bb/asyncrpc/client.py<br>
              &gt; index 7f33099b..802c07df 100644<br>
              &gt; --- a/lib/bb/asyncrpc/client.py<br>
              &gt; +++ b/lib/bb/asyncrpc/client.py<br>
              &gt; @@ -10,7 +10,7 @@ import json<br>
              &gt;   import os<br>
              &gt;   import socket<br>
              &gt;   import sys<br>
              &gt; -from .connection import StreamConnection,
              DEFAULT_MAX_CHUNK<br>
              &gt; +from .connection import StreamConnection,
              WebsocketConnection, DEFAULT_MAX_CHUNK<br>
              &gt;   from .exceptions import ConnectionClosedError<br>
              &gt;   <br>
              &gt;   <br>
              &gt; @@ -47,6 +47,15 @@ class AsyncClient(object):<br>
              &gt;   <br>
              &gt;           self._connect_sock = connect_sock<br>
              &gt;   <br>
              &gt; +    async def connect_websocket(self, uri):<br>
              &gt; +        import websockets<br>
              &gt; +<br>
              &gt; +        async def connect_sock():<br>
              &gt; +            websocket = await
              websockets.connect(uri, ping_interval=None)<br>
              &gt; +            return WebsocketConnection(websocket,
              self.timeout)<br>
              &gt; +<br>
              &gt; +        self._connect_sock = connect_sock<br>
              &gt; +<br>
              &gt;       async def setup_connection(self):<br>
              &gt;           # Send headers<br>
              &gt;           await self.socket.send("%s %s" %
              (self.proto_name, self.proto_version))<br>
              &gt; diff --git a/lib/bb/asyncrpc/connection.py
              b/lib/bb/asyncrpc/connection.py<br>
              &gt; index c4fd2475..a10628f7 100644<br>
              &gt; --- a/lib/bb/asyncrpc/connection.py<br>
              &gt; +++ b/lib/bb/asyncrpc/connection.py<br>
              &gt; @@ -93,3 +93,47 @@ class StreamConnection(object):<br>
              &gt;           if self.writer is not None:<br>
              &gt;               self.writer.close()<br>
              &gt;               self.writer = None<br>
              &gt; +<br>
              &gt; +<br>
              &gt; +class WebsocketConnection(object):<br>
              &gt; +    def __init__(self, socket, timeout):<br>
              &gt; +        self.socket = socket<br>
              &gt; +        self.timeout = timeout<br>
              &gt; +<br>
              &gt; +    @property<br>
              &gt; +    def address(self):<br>
              &gt; +        return ":".join(str(s) for s in
              self.socket.remote_address)<br>
              &gt; +<br>
              &gt; +    async def send_message(self, msg):<br>
              &gt; +        await self.send(json.dumps(msg))<br>
              &gt; +<br>
              &gt; +    async def recv_message(self):<br>
              &gt; +        m = await self.recv()<br>
              &gt; +        return json.loads(m)<br>
              &gt; +<br>
              &gt; +    async def send(self, msg):<br>
              &gt; +        import websockets.exceptions<br>
              &gt; +<br>
              &gt; +        try:<br>
              &gt; +            await self.socket.send(msg)<br>
              &gt; +        except
              websockets.exceptions.ConnectionClosed:<br>
              &gt; +            raise ConnectionClosedError("Connection
              closed")<br>
              &gt; +<br>
              &gt; +    async def recv(self):<br>
              &gt; +        import websockets.exceptions<br>
              &gt; +<br>
              &gt; +        try:<br>
              &gt; +            if self.timeout &lt; 0:<br>
              &gt; +                return await self.socket.recv()<br>
              &gt; +<br>
              &gt; +            try:<br>
              &gt; +                return await
              asyncio.wait_for(self.socket.recv(), self.timeout)<br>
              &gt; +            except asyncio.TimeoutError:<br>
              &gt; +                raise ConnectionError("Timed out
              waiting for data")<br>
              &gt; +        except
              websockets.exceptions.ConnectionClosed:<br>
              &gt; +            raise ConnectionClosedError("Connection
              closed")<br>
              &gt; +<br>
              &gt; +    async def close(self):<br>
              &gt; +        if self.socket is not None:<br>
              &gt; +            await self.socket.close()<br>
              &gt; +            self.socket = None<br>
              &gt; diff --git a/lib/bb/asyncrpc/serv.py
              b/lib/bb/asyncrpc/serv.py<br>
              &gt; index 3e0d0632..dfb03773 100644<br>
              &gt; --- a/lib/bb/asyncrpc/serv.py<br>
              &gt; +++ b/lib/bb/asyncrpc/serv.py<br>
              &gt; @@ -12,7 +12,7 @@ import signal<br>
              &gt;   import socket<br>
              &gt;   import sys<br>
              &gt;   import multiprocessing<br>
              &gt; -from .connection import StreamConnection<br>
              &gt; +from .connection import StreamConnection,
              WebsocketConnection<br>
              &gt;   from .exceptions import ClientError, ServerError,
              ConnectionClosedError<br>
              &gt;   <br>
              &gt;   <br>
              &gt; @@ -178,6 +178,54 @@ class
              UnixStreamServer(StreamServer):<br>
              &gt;           os.unlink(self.path)<br>
              &gt;   <br>
              &gt;   <br>
              &gt; +class WebsocketsServer(object):<br>
              &gt; +    def __init__(self, host, port, handler, logger):<br>
              &gt; +        self.host = host<br>
              &gt; +        self.port = port<br>
              &gt; +        self.handler = handler<br>
              &gt; +        self.logger = logger<br>
              &gt; +<br>
              &gt; +    def start(self, loop):<br>
              &gt; +        import websockets.server<br>
              &gt; +<br>
              &gt; +        self.server = loop.run_until_complete(<br>
              &gt; +            websockets.server.serve(<br>
              &gt; +                self.client_handler,<br>
              &gt; +                self.host,<br>
              &gt; +                self.port,<br>
              &gt; +                ping_interval=None,<br>
              &gt; +            )<br>
              &gt; +        )<br>
              &gt; +<br>
              &gt; +        for s in self.server.sockets:<br>
              &gt; +            self.logger.debug("Listening on %r" %
              (s.getsockname(),))<br>
              &gt; +<br>
              &gt; +            # Enable keep alives. This prevents
              broken client connections<br>
              &gt; +            # from persisting on the server for long
              periods of time.<br>
              &gt; +            s.setsockopt(socket.SOL_SOCKET,
              socket.SO_KEEPALIVE, 1)<br>
              &gt; +            s.setsockopt(socket.IPPROTO_TCP,
              socket.TCP_KEEPIDLE, 30)<br>
              &gt; +            s.setsockopt(socket.IPPROTO_TCP,
              socket.TCP_KEEPINTVL, 15)<br>
              &gt; +            s.setsockopt(socket.IPPROTO_TCP,
              socket.TCP_KEEPCNT, 4)<br>
              &gt; +<br>
              &gt; +        name = self.server.sockets[0].getsockname()<br>
              &gt; +        if self.server.sockets[0].family ==
              socket.AF_INET6:<br>
              &gt; +            self.address = "ws://[%s]:%d" %
              (name[0], name[1])<br>
              &gt; +        else:<br>
              &gt; +            self.address = "ws://%s:%d" % (name[0],
              name[1])<br>
              &gt; +<br>
              &gt; +        return [self.server.wait_closed()]<br>
              &gt; +<br>
              &gt; +    async def stop(self):<br>
              &gt; +        self.server.close()<br>
              &gt; +<br>
              &gt; +    def cleanup(self):<br>
              &gt; +        pass<br>
              &gt; +<br>
              &gt; +    async def client_handler(self, websocket):<br>
              &gt; +        socket = WebsocketConnection(websocket, -1)<br>
              &gt; +        await self.handler(socket)<br>
              &gt; +<br>
              &gt; +<br>
              &gt;   class AsyncServer(object):<br>
              &gt;       def __init__(self, logger):<br>
              &gt;           self.logger = logger<br>
              &gt; @@ -190,6 +238,9 @@ class AsyncServer(object):<br>
              &gt;       def start_unix_server(self, path):<br>
              &gt;           self.server = UnixStreamServer(path,
              self._client_handler, self.logger)<br>
              &gt;   <br>
              &gt; +    def start_websocket_server(self, host, port):<br>
              &gt; +        self.server = WebsocketsServer(host, port,
              self._client_handler, self.logger)<br>
              &gt; +<br>
              &gt;       async def _client_handler(self, socket):<br>
              &gt;           try:<br>
              &gt;               client = self.accept_client(socket)<br>
              &gt; diff --git a/lib/hashserv/__init__.py
              b/lib/hashserv/__init__.py<br>
              &gt; index 3a401835..56b9c6bc 100644<br>
              &gt; --- a/lib/hashserv/__init__.py<br>
              &gt; +++ b/lib/hashserv/__init__.py<br>
              &gt; @@ -9,11 +9,15 @@ import re<br>
              &gt;   import sqlite3<br>
              &gt;   import itertools<br>
              &gt;   import json<br>
              &gt; +from urllib.parse import urlparse<br>
              &gt;   <br>
              &gt;   UNIX_PREFIX = "unix://"<br>
              &gt; +WS_PREFIX = "ws://"<br>
              &gt; +WSS_PREFIX = "wss://"<br>
              &gt;   <br>
              &gt;   ADDR_TYPE_UNIX = 0<br>
              &gt;   ADDR_TYPE_TCP = 1<br>
              &gt; +ADDR_TYPE_WS = 2<br>
              &gt;   <br>
              &gt;   UNIHASH_TABLE_DEFINITION = (<br>
              &gt;       ("method", "TEXT NOT NULL", "UNIQUE"),<br>
              &gt; @@ -84,6 +88,8 @@ def setup_database(database,
              sync=True):<br>
              &gt;   def parse_address(addr):<br>
              &gt;       if addr.startswith(UNIX_PREFIX):<br>
              &gt;           return (ADDR_TYPE_UNIX,
              (addr[len(UNIX_PREFIX):],))<br>
              &gt; +    elif addr.startswith(WS_PREFIX) or
              addr.startswith(WSS_PREFIX):<br>
              &gt; +        return (ADDR_TYPE_WS, (addr,))<br>
              &gt;       else:<br>
              &gt;           m =
              re.match(r'\[(?P&lt;host&gt;[^\]]*)\]:(?P&lt;port&gt;\d+)$',
              addr)<br>
              &gt;           if m is not None:<br>
              &gt; @@ -103,6 +109,9 @@ def create_server(addr, dbname,
              *, sync=True, upstream=None, read_only=False):<br>
              &gt;       (typ, a) = parse_address(addr)<br>
              &gt;       if typ == ADDR_TYPE_UNIX:<br>
              &gt;           s.start_unix_server(*a)<br>
              &gt; +    elif typ == ADDR_TYPE_WS:<br>
              &gt; +        url = urlparse(a[0])<br>
              &gt; +        s.start_websocket_server(url.hostname,
              url.port)<br>
              &gt;       else:<br>
              &gt;           s.start_tcp_server(*a)<br>
              &gt;   <br>
              &gt; @@ -116,6 +125,8 @@ def create_client(addr):<br>
              &gt;       (typ, a) = parse_address(addr)<br>
              &gt;       if typ == ADDR_TYPE_UNIX:<br>
              &gt;           c.connect_unix(*a)<br>
              &gt; +    elif typ == ADDR_TYPE_WS:<br>
              &gt; +        c.connect_websocket(*a)<br>
              &gt;       else:<br>
              &gt;           c.connect_tcp(*a)<br>
              &gt;   <br>
              &gt; @@ -128,6 +139,8 @@ async def
              create_async_client(addr):<br>
              &gt;       (typ, a) = parse_address(addr)<br>
              &gt;       if typ == ADDR_TYPE_UNIX:<br>
              &gt;           await c.connect_unix(*a)<br>
              &gt; +    elif typ == ADDR_TYPE_WS:<br>
              &gt; +        await c.connect_websocket(*a)<br>
              &gt;       else:<br>
              &gt;           await c.connect_tcp(*a)<br>
              &gt;   <br>
              &gt; diff --git a/lib/hashserv/client.py
              b/lib/hashserv/client.py<br>
              &gt; index 5f7d22ab..9542d72f 100644<br>
              &gt; --- a/lib/hashserv/client.py<br>
              &gt; +++ b/lib/hashserv/client.py<br>
              &gt; @@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):<br>
              &gt;           super().__init__()<br>
              &gt;           self._add_methods(<br>
              &gt;               "connect_tcp",<br>
              &gt; +            "connect_websocket",<br>
              &gt;               "get_unihash",<br>
              &gt;               "report_unihash",<br>
              &gt;               "report_unihash_equiv",<br>
              &gt; diff --git a/lib/hashserv/tests.py
              b/lib/hashserv/tests.py<br>
              &gt; index f343c586..01ffd52c 100644<br>
              &gt; --- a/lib/hashserv/tests.py<br>
              &gt; +++ b/lib/hashserv/tests.py<br>
              &gt; @@ -483,3 +483,20 @@ class
              TestHashEquivalenceTCPServer(HashEquivalenceTestSetup,
              HashEquivalenceComm<br>
              &gt;           # If IPv6 is enabled, it should be safe to
              use localhost directly, in general<br>
              &gt;           # case it is more reliable to resolve the
              IP address explicitly.<br>
              &gt;           return socket.gethostbyname("localhost") +
              ":0"<br>
              &gt; +<br>
              &gt; +<br>
              &gt; +class
              TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup,
              HashEquivalenceCommonTests, unittest.TestCase):<br>
              &gt; +    def setUp(self):<br>
              &gt; +        try:<br>
              &gt; +            import websockets<br>
              &gt; +        except ImportError as e:<br>
              &gt; +            self.skipTest(str(e))<br>
              &gt; +<br>
              &gt; +        super().setUp()<br>
              &gt; +<br>
              &gt; +    def get_server_addr(self, server_idx):<br>
              &gt; +        # Some hosts cause asyncio module to
              misbehave, when IPv6 is not enabled.<br>
              &gt; +        # If IPv6 is enabled, it should be safe to
              use localhost directly, in general<br>
              &gt; +        # case it is more reliable to resolve the IP
              address explicitly.<br>
              &gt; +        host = socket.gethostbyname("localhost")<br>
              &gt; +        return <a class="moz-txt-link-rfc2396E" href="ws://%s:0">"ws://%s:0"</a> % host<br>
              &gt;<br>
              &gt; <br>
              &gt;<br>
            </blockquote>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#15501): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/15501">https://lists.openembedded.org/g/bitbake-devel/message/15501</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/102364905/7851872">https://lists.openembedded.org/mt/102364905/7851872</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:develop@schnelte.de">develop@schnelte.de</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
  </body>
</html>

--------------82xByYpzGdy0l0RtQXxv5D3T--

