Return-Path: <develop@schnelte.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA8DC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 12:03:34 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by mx.groups.io with SMTP id smtpd.web11.25848.1699617806045692555
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 04:03:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: schnelte.de, ip: 212.227.126.134, mailfrom: develop@schnelte.de)
Received: from [IPV6:2a01:599:416:120e:5b24:df9a:5008:5314] ([80.187.102.185])
 by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
 (Nemesis) id 1N30VJ-1rP1d83ggn-013KaJ; Fri, 10 Nov 2023 13:03:23 +0100
Message-ID: <31f6c36f-4924-4880-9788-537ec241263c@schnelte.de>
Date: Fri, 10 Nov 2023 13:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH v6 02/22] hashserv: Add websocket
 connection implementation
Content-Language: en-US
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-3-JPEWhacker@gmail.com>
From: Matthias Schnelte <develop@schnelte.de>
In-Reply-To: <20231103142640.1936827-3-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R/v8EBfAR3q2SzFELt56klZhJVsUt+3HwPo6OG06/5kS0/8Kx0c
 A8lvALDAxajOSwWEr6IP37paACTDHF42pvCnvmAxopLd/gTi9ZkvGGOcf/JCaiiW4QpBejj
 kl6peI5cmbmxSBBmVh2tbzzYL47o4cL++EbWXpgae1hcEX/3OSBMyjdVWIRPHYDxHX9ya4f
 oehFgRdAN1EumV1hTgM8w==
UI-OutboundReport: notjunk:1;M01:P0:7KOaf2QXobA=;HJAbJGUxUWZwaWHPWghY2vbGLjV
 QUa1Sy0eCBHcO5hi9XZA71t8zsFsJlqchqsyurYNe+VCDIxxromEomD7lIHmHVh+Oz6jjbCPU
 A5QLdaNKcajyBWPjWg81ycJpQ+5is2+2Du7lDrHzQz5PUlygy+6e0ylhu/USn0757JSSbMrpG
 pkGADU0Yk4NhVsVkp9wdpymM4uE/HEaB+txWFmwJ5/RZ4/FQR7MijsEdPZT0ehagKIscFfDiA
 7q4n1vWImESVc3h29I7C74lODgospKwbolu2sPwRyUpF2avWdQOs90h5vtvFT/lA5D0wgM9nq
 ZTXhTH8OifIo/MIDrwm5EX6GU/FEX21l4Q9n5TL0LnyEViyD8t7I0Cy2nPHvogfpdIXHqG9RR
 ijge63u2HhXTbz1rNW/wNA3/d//8bdG6ISP4okSpI35tmPFkCLgLtCfT6nIggWUCqJGikoAbD
 yBP60IkpOY3oslcr0OuZr2GlDJ/yOW/WYM9jIsF3ZHwE/tMz5nI/Irpi/xBfK+lVEijR40sdy
 /Schjp9/aJI5AFo1AXW4NzcqKe5a4biKGgijM5f81xWWCVLxAPm934XVy8CaehYoyENytE/wK
 oyUGruKVmk9+XHIlpr/RXfCnOu5Dcr4vKehkv/9A2lBU514bi2GGDHZTPMX3ZoqTCcg4okjRJ
 eh6ZC1VH6ioYqhBhuQHjgHuBoVrfqOr9VVgBCEUJJd+ym+E4l4tqi2vG8cmkX76cTndfM3Cmw
 HAjjHtegfcQal3h0O9DBw8m0Au7f2cH+lZQTJt6FL/DHs/98slg1gPceeL49OLsqSqCJjhFKR
 He8j9plSdkYbqYHCHCKoSv2TE+Q8nvpUM3IszKgNrnNYPZd/5pJTTU/C4Bt6Toid5VBNGIH6P
 5gZ4ysPUnBjLQXw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 12:03:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15491

Hi Joshua,

thanks for this change! Being able to use websockets instead of some tcp 
connection would help a lot in cooperate setups which are often 
restricted to only http(s) ports and enforce the use of a cooperate proxy.

Unfortunately the websocket library you are using seems not to support 
websockets over http proxy. At least that is what I understood.

Would it be possible to use another client lib for websockets in order 
to support connection through proxy?

This library seems to support it: 
https://websocket-client.readthedocs.io/en/latest/examples.html#connecting-through-a-proxy

Matthias

On 03.11.23 15:26, Joshua Watt wrote:
> Adds support to the hash equivalence client and server to communicate
> over websockets. Since websockets are message orientated instead of
> stream orientated, and new connection class is needed to handle them.
>
> Note that websocket support does require the 3rd party websockets python
> module be installed on the host, but it should not be required unless
> websockets are actually being used.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   lib/bb/asyncrpc/client.py     | 11 +++++++-
>   lib/bb/asyncrpc/connection.py | 44 +++++++++++++++++++++++++++++
>   lib/bb/asyncrpc/serv.py       | 53 ++++++++++++++++++++++++++++++++++-
>   lib/hashserv/__init__.py      | 13 +++++++++
>   lib/hashserv/client.py        |  1 +
>   lib/hashserv/tests.py         | 17 +++++++++++
>   6 files changed, 137 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> index 7f33099b..802c07df 100644
> --- a/lib/bb/asyncrpc/client.py
> +++ b/lib/bb/asyncrpc/client.py
> @@ -10,7 +10,7 @@ import json
>   import os
>   import socket
>   import sys
> -from .connection import StreamConnection, DEFAULT_MAX_CHUNK
> +from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
>   from .exceptions import ConnectionClosedError
>   
>   
> @@ -47,6 +47,15 @@ class AsyncClient(object):
>   
>           self._connect_sock = connect_sock
>   
> +    async def connect_websocket(self, uri):
> +        import websockets
> +
> +        async def connect_sock():
> +            websocket = await websockets.connect(uri, ping_interval=None)
> +            return WebsocketConnection(websocket, self.timeout)
> +
> +        self._connect_sock = connect_sock
> +
>       async def setup_connection(self):
>           # Send headers
>           await self.socket.send("%s %s" % (self.proto_name, self.proto_version))
> diff --git a/lib/bb/asyncrpc/connection.py b/lib/bb/asyncrpc/connection.py
> index c4fd2475..a10628f7 100644
> --- a/lib/bb/asyncrpc/connection.py
> +++ b/lib/bb/asyncrpc/connection.py
> @@ -93,3 +93,47 @@ class StreamConnection(object):
>           if self.writer is not None:
>               self.writer.close()
>               self.writer = None
> +
> +
> +class WebsocketConnection(object):
> +    def __init__(self, socket, timeout):
> +        self.socket = socket
> +        self.timeout = timeout
> +
> +    @property
> +    def address(self):
> +        return ":".join(str(s) for s in self.socket.remote_address)
> +
> +    async def send_message(self, msg):
> +        await self.send(json.dumps(msg))
> +
> +    async def recv_message(self):
> +        m = await self.recv()
> +        return json.loads(m)
> +
> +    async def send(self, msg):
> +        import websockets.exceptions
> +
> +        try:
> +            await self.socket.send(msg)
> +        except websockets.exceptions.ConnectionClosed:
> +            raise ConnectionClosedError("Connection closed")
> +
> +    async def recv(self):
> +        import websockets.exceptions
> +
> +        try:
> +            if self.timeout < 0:
> +                return await self.socket.recv()
> +
> +            try:
> +                return await asyncio.wait_for(self.socket.recv(), self.timeout)
> +            except asyncio.TimeoutError:
> +                raise ConnectionError("Timed out waiting for data")
> +        except websockets.exceptions.ConnectionClosed:
> +            raise ConnectionClosedError("Connection closed")
> +
> +    async def close(self):
> +        if self.socket is not None:
> +            await self.socket.close()
> +            self.socket = None
> diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> index 3e0d0632..dfb03773 100644
> --- a/lib/bb/asyncrpc/serv.py
> +++ b/lib/bb/asyncrpc/serv.py
> @@ -12,7 +12,7 @@ import signal
>   import socket
>   import sys
>   import multiprocessing
> -from .connection import StreamConnection
> +from .connection import StreamConnection, WebsocketConnection
>   from .exceptions import ClientError, ServerError, ConnectionClosedError
>   
>   
> @@ -178,6 +178,54 @@ class UnixStreamServer(StreamServer):
>           os.unlink(self.path)
>   
>   
> +class WebsocketsServer(object):
> +    def __init__(self, host, port, handler, logger):
> +        self.host = host
> +        self.port = port
> +        self.handler = handler
> +        self.logger = logger
> +
> +    def start(self, loop):
> +        import websockets.server
> +
> +        self.server = loop.run_until_complete(
> +            websockets.server.serve(
> +                self.client_handler,
> +                self.host,
> +                self.port,
> +                ping_interval=None,
> +            )
> +        )
> +
> +        for s in self.server.sockets:
> +            self.logger.debug("Listening on %r" % (s.getsockname(),))
> +
> +            # Enable keep alives. This prevents broken client connections
> +            # from persisting on the server for long periods of time.
> +            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
> +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPIDLE, 30)
> +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPINTVL, 15)
> +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 4)
> +
> +        name = self.server.sockets[0].getsockname()
> +        if self.server.sockets[0].family == socket.AF_INET6:
> +            self.address = "ws://[%s]:%d" % (name[0], name[1])
> +        else:
> +            self.address = "ws://%s:%d" % (name[0], name[1])
> +
> +        return [self.server.wait_closed()]
> +
> +    async def stop(self):
> +        self.server.close()
> +
> +    def cleanup(self):
> +        pass
> +
> +    async def client_handler(self, websocket):
> +        socket = WebsocketConnection(websocket, -1)
> +        await self.handler(socket)
> +
> +
>   class AsyncServer(object):
>       def __init__(self, logger):
>           self.logger = logger
> @@ -190,6 +238,9 @@ class AsyncServer(object):
>       def start_unix_server(self, path):
>           self.server = UnixStreamServer(path, self._client_handler, self.logger)
>   
> +    def start_websocket_server(self, host, port):
> +        self.server = WebsocketsServer(host, port, self._client_handler, self.logger)
> +
>       async def _client_handler(self, socket):
>           try:
>               client = self.accept_client(socket)
> diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
> index 3a401835..56b9c6bc 100644
> --- a/lib/hashserv/__init__.py
> +++ b/lib/hashserv/__init__.py
> @@ -9,11 +9,15 @@ import re
>   import sqlite3
>   import itertools
>   import json
> +from urllib.parse import urlparse
>   
>   UNIX_PREFIX = "unix://"
> +WS_PREFIX = "ws://"
> +WSS_PREFIX = "wss://"
>   
>   ADDR_TYPE_UNIX = 0
>   ADDR_TYPE_TCP = 1
> +ADDR_TYPE_WS = 2
>   
>   UNIHASH_TABLE_DEFINITION = (
>       ("method", "TEXT NOT NULL", "UNIQUE"),
> @@ -84,6 +88,8 @@ def setup_database(database, sync=True):
>   def parse_address(addr):
>       if addr.startswith(UNIX_PREFIX):
>           return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX):],))
> +    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
> +        return (ADDR_TYPE_WS, (addr,))
>       else:
>           m = re.match(r'\[(?P<host>[^\]]*)\]:(?P<port>\d+)$', addr)
>           if m is not None:
> @@ -103,6 +109,9 @@ def create_server(addr, dbname, *, sync=True, upstream=None, read_only=False):
>       (typ, a) = parse_address(addr)
>       if typ == ADDR_TYPE_UNIX:
>           s.start_unix_server(*a)
> +    elif typ == ADDR_TYPE_WS:
> +        url = urlparse(a[0])
> +        s.start_websocket_server(url.hostname, url.port)
>       else:
>           s.start_tcp_server(*a)
>   
> @@ -116,6 +125,8 @@ def create_client(addr):
>       (typ, a) = parse_address(addr)
>       if typ == ADDR_TYPE_UNIX:
>           c.connect_unix(*a)
> +    elif typ == ADDR_TYPE_WS:
> +        c.connect_websocket(*a)
>       else:
>           c.connect_tcp(*a)
>   
> @@ -128,6 +139,8 @@ async def create_async_client(addr):
>       (typ, a) = parse_address(addr)
>       if typ == ADDR_TYPE_UNIX:
>           await c.connect_unix(*a)
> +    elif typ == ADDR_TYPE_WS:
> +        await c.connect_websocket(*a)
>       else:
>           await c.connect_tcp(*a)
>   
> diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> index 5f7d22ab..9542d72f 100644
> --- a/lib/hashserv/client.py
> +++ b/lib/hashserv/client.py
> @@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):
>           super().__init__()
>           self._add_methods(
>               "connect_tcp",
> +            "connect_websocket",
>               "get_unihash",
>               "report_unihash",
>               "report_unihash_equiv",
> diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
> index f343c586..01ffd52c 100644
> --- a/lib/hashserv/tests.py
> +++ b/lib/hashserv/tests.py
> @@ -483,3 +483,20 @@ class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceComm
>           # If IPv6 is enabled, it should be safe to use localhost directly, in general
>           # case it is more reliable to resolve the IP address explicitly.
>           return socket.gethostbyname("localhost") + ":0"
> +
> +
> +class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
> +    def setUp(self):
> +        try:
> +            import websockets
> +        except ImportError as e:
> +            self.skipTest(str(e))
> +
> +        super().setUp()
> +
> +    def get_server_addr(self, server_idx):
> +        # Some hosts cause asyncio module to misbehave, when IPv6 is not enabled.
> +        # If IPv6 is enabled, it should be safe to use localhost directly, in general
> +        # case it is more reliable to resolve the IP address explicitly.
> +        host = socket.gethostbyname("localhost")
> +        return "ws://%s:0" % host
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15423): https://lists.openembedded.org/g/bitbake-devel/message/15423
> Mute This Topic: https://lists.openembedded.org/mt/102364905/7851872
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [develop@schnelte.de]
> -=-=-=-=-=-=-=-=-=-=-=-
>

