Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB4C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 14:12:05 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.28269.1699625522265345685
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 06:12:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UBAGqqWO;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507ad511315so2951940e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699625520; x=1700230320; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNx6kllSx07/Eiop3aX+TIP675KlWUE0drHVy/fAbBk=;
        b=UBAGqqWOQOz2K1rE/EhKbSBTv3PPdvoqbq7wqNxVjoRjVN40SgFHBFXuvfU+cW3/Oi
         4HvwDAOCnNHgNuGIA2tGWgPoBfcoEX9FlZYdp9GceklqGC54H6PvFUZId2pkD8BKUQ0Y
         qM3cFAken/ZuIPg+3jNIYs4N9alhj8VfTWG6lKnyYWRlf69l1ggzQdiIE8Qjm9POong1
         gBErG3pk1CnsqF7lvQM42wWSUjBPUm2bRaqMHc1RqzmF5epu6aOx9Cym1bcR1H2IH1Os
         w7H4I9NXx0dWSDk+cp0j/RO/PhETY2W5mt5j00bZNp3tzRJknrc9bBaNniYOmaq8C1sK
         fWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625520; x=1700230320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNx6kllSx07/Eiop3aX+TIP675KlWUE0drHVy/fAbBk=;
        b=gn2Y1IzmPqL5ba3O8btPW6Rg5lsUGKMzmm3NUopSyVyxB1V++JK3qgKn7bj5OAG8gO
         zMX1TkB8T1DapMgS59GCHrO+A367ghDRm/aiV1WbaD8otKDpHF20o7YC8khmEHvcl7iE
         MPmJ5aRxrxKHjcF3VQ3jMp67DUz04CYvzTP7d3VmyQiGa6Q19xLSZBWhIKwwvTtHi2Xy
         wCWA1jUF9EVeXEa3jojCnXqNoNgcgICerScLTvofKheb+Q6scjVqOznwXjCbcx+Vgucj
         J5yy6/RfWBlpuU6K90dEE1jQM7nOoV90334p3fceD12EMD4L7kICH3EObJx3TjSBJ2Sk
         H7tw==
X-Gm-Message-State: AOJu0YxHasPicwcajzVT/g2tRThlO/N31lV4S1eYDrpO1u+VbLfrzN6U
	1NyrGw6uRukhyywvLrhyrnM8M5p0BAd82fPF9n8=
X-Google-Smtp-Source: AGHT+IF8d2ZKsggWKdkOLD/yxXDPvUtoREsFSCcetMMUD6ELLQQxErs89W0BIel9Tho4NL2+VJ6B7CPkPwboDzr3T7g=
X-Received: by 2002:a05:6512:2396:b0:507:b099:749d with SMTP id
 c22-20020a056512239600b00507b099749dmr5109867lfv.15.1699625520027; Fri, 10
 Nov 2023 06:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com> <20231103142640.1936827-3-JPEWhacker@gmail.com>
 <31f6c36f-4924-4880-9788-537ec241263c@schnelte.de>
In-Reply-To: <31f6c36f-4924-4880-9788-537ec241263c@schnelte.de>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 10 Nov 2023 07:11:50 -0700
Message-ID: <CAJdd5GbSH-r=b5qpzzNdhZ-q6mR7WuE8XX3=u8ZF9xL8UCDFDA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v6 02/22] hashserv: Add websocket
 connection implementation
To: Matthias Schnelte <develop@schnelte.de>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000005f5cbb0609cce7f8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 14:12:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15501

--0000000000005f5cbb0609cce7f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023, 5:03=E2=80=AFAM Matthias Schnelte <develop@schnelte.d=
e> wrote:

> Hi Joshua,
>
> thanks for this change! Being able to use websockets instead of some tcp
> connection would help a lot in cooperate setups which are often
> restricted to only http(s) ports and enforce the use of a cooperate proxy=
.
>
> Unfortunately the websocket library you are using seems not to support
> websockets over http proxy. At least that is what I understood.
>
> Would it be possible to use another client lib for websockets in order
> to support connection through proxy?
>
> This library seems to support it:
>
> https://websocket-client.readthedocs.io/en/latest/examples.html#connectin=
g-through-a-proxy


I'm not sure that's going to work. We need a library that supports asyncio,
and has very minimal dependencies, which the current library satisfies (it
only depends on core Python)


Maybe there is another solution for proxying?



>
> Matthias
>
> On 03.11.23 15:26, Joshua Watt wrote:
> > Adds support to the hash equivalence client and server to communicate
> > over websockets. Since websockets are message orientated instead of
> > stream orientated, and new connection class is needed to handle them.
> >
> > Note that websocket support does require the 3rd party websockets pytho=
n
> > module be installed on the host, but it should not be required unless
> > websockets are actually being used.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >   lib/bb/asyncrpc/client.py     | 11 +++++++-
> >   lib/bb/asyncrpc/connection.py | 44 +++++++++++++++++++++++++++++
> >   lib/bb/asyncrpc/serv.py       | 53 ++++++++++++++++++++++++++++++++++=
-
> >   lib/hashserv/__init__.py      | 13 +++++++++
> >   lib/hashserv/client.py        |  1 +
> >   lib/hashserv/tests.py         | 17 +++++++++++
> >   6 files changed, 137 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> > index 7f33099b..802c07df 100644
> > --- a/lib/bb/asyncrpc/client.py
> > +++ b/lib/bb/asyncrpc/client.py
> > @@ -10,7 +10,7 @@ import json
> >   import os
> >   import socket
> >   import sys
> > -from .connection import StreamConnection, DEFAULT_MAX_CHUNK
> > +from .connection import StreamConnection, WebsocketConnection,
> DEFAULT_MAX_CHUNK
> >   from .exceptions import ConnectionClosedError
> >
> >
> > @@ -47,6 +47,15 @@ class AsyncClient(object):
> >
> >           self._connect_sock =3D connect_sock
> >
> > +    async def connect_websocket(self, uri):
> > +        import websockets
> > +
> > +        async def connect_sock():
> > +            websocket =3D await websockets.connect(uri,
> ping_interval=3DNone)
> > +            return WebsocketConnection(websocket, self.timeout)
> > +
> > +        self._connect_sock =3D connect_sock
> > +
> >       async def setup_connection(self):
> >           # Send headers
> >           await self.socket.send("%s %s" % (self.proto_name,
> self.proto_version))
> > diff --git a/lib/bb/asyncrpc/connection.py
> b/lib/bb/asyncrpc/connection.py
> > index c4fd2475..a10628f7 100644
> > --- a/lib/bb/asyncrpc/connection.py
> > +++ b/lib/bb/asyncrpc/connection.py
> > @@ -93,3 +93,47 @@ class StreamConnection(object):
> >           if self.writer is not None:
> >               self.writer.close()
> >               self.writer =3D None
> > +
> > +
> > +class WebsocketConnection(object):
> > +    def __init__(self, socket, timeout):
> > +        self.socket =3D socket
> > +        self.timeout =3D timeout
> > +
> > +    @property
> > +    def address(self):
> > +        return ":".join(str(s) for s in self.socket.remote_address)
> > +
> > +    async def send_message(self, msg):
> > +        await self.send(json.dumps(msg))
> > +
> > +    async def recv_message(self):
> > +        m =3D await self.recv()
> > +        return json.loads(m)
> > +
> > +    async def send(self, msg):
> > +        import websockets.exceptions
> > +
> > +        try:
> > +            await self.socket.send(msg)
> > +        except websockets.exceptions.ConnectionClosed:
> > +            raise ConnectionClosedError("Connection closed")
> > +
> > +    async def recv(self):
> > +        import websockets.exceptions
> > +
> > +        try:
> > +            if self.timeout < 0:
> > +                return await self.socket.recv()
> > +
> > +            try:
> > +                return await asyncio.wait_for(self.socket.recv(),
> self.timeout)
> > +            except asyncio.TimeoutError:
> > +                raise ConnectionError("Timed out waiting for data")
> > +        except websockets.exceptions.ConnectionClosed:
> > +            raise ConnectionClosedError("Connection closed")
> > +
> > +    async def close(self):
> > +        if self.socket is not None:
> > +            await self.socket.close()
> > +            self.socket =3D None
> > diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> > index 3e0d0632..dfb03773 100644
> > --- a/lib/bb/asyncrpc/serv.py
> > +++ b/lib/bb/asyncrpc/serv.py
> > @@ -12,7 +12,7 @@ import signal
> >   import socket
> >   import sys
> >   import multiprocessing
> > -from .connection import StreamConnection
> > +from .connection import StreamConnection, WebsocketConnection
> >   from .exceptions import ClientError, ServerError, ConnectionClosedErr=
or
> >
> >
> > @@ -178,6 +178,54 @@ class UnixStreamServer(StreamServer):
> >           os.unlink(self.path)
> >
> >
> > +class WebsocketsServer(object):
> > +    def __init__(self, host, port, handler, logger):
> > +        self.host =3D host
> > +        self.port =3D port
> > +        self.handler =3D handler
> > +        self.logger =3D logger
> > +
> > +    def start(self, loop):
> > +        import websockets.server
> > +
> > +        self.server =3D loop.run_until_complete(
> > +            websockets.server.serve(
> > +                self.client_handler,
> > +                self.host,
> > +                self.port,
> > +                ping_interval=3DNone,
> > +            )
> > +        )
> > +
> > +        for s in self.server.sockets:
> > +            self.logger.debug("Listening on %r" % (s.getsockname(),))
> > +
> > +            # Enable keep alives. This prevents broken client
> connections
> > +            # from persisting on the server for long periods of time.
> > +            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
> > +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPIDLE, 30)
> > +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPINTVL, 15)
> > +            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 4)
> > +
> > +        name =3D self.server.sockets[0].getsockname()
> > +        if self.server.sockets[0].family =3D=3D socket.AF_INET6:
> > +            self.address =3D "ws://[%s]:%d" % (name[0], name[1])
> > +        else:
> > +            self.address =3D "ws://%s:%d" % (name[0], name[1])
> > +
> > +        return [self.server.wait_closed()]
> > +
> > +    async def stop(self):
> > +        self.server.close()
> > +
> > +    def cleanup(self):
> > +        pass
> > +
> > +    async def client_handler(self, websocket):
> > +        socket =3D WebsocketConnection(websocket, -1)
> > +        await self.handler(socket)
> > +
> > +
> >   class AsyncServer(object):
> >       def __init__(self, logger):
> >           self.logger =3D logger
> > @@ -190,6 +238,9 @@ class AsyncServer(object):
> >       def start_unix_server(self, path):
> >           self.server =3D UnixStreamServer(path, self._client_handler,
> self.logger)
> >
> > +    def start_websocket_server(self, host, port):
> > +        self.server =3D WebsocketsServer(host, port,
> self._client_handler, self.logger)
> > +
> >       async def _client_handler(self, socket):
> >           try:
> >               client =3D self.accept_client(socket)
> > diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
> > index 3a401835..56b9c6bc 100644
> > --- a/lib/hashserv/__init__.py
> > +++ b/lib/hashserv/__init__.py
> > @@ -9,11 +9,15 @@ import re
> >   import sqlite3
> >   import itertools
> >   import json
> > +from urllib.parse import urlparse
> >
> >   UNIX_PREFIX =3D "unix://"
> > +WS_PREFIX =3D "ws://"
> > +WSS_PREFIX =3D "wss://"
> >
> >   ADDR_TYPE_UNIX =3D 0
> >   ADDR_TYPE_TCP =3D 1
> > +ADDR_TYPE_WS =3D 2
> >
> >   UNIHASH_TABLE_DEFINITION =3D (
> >       ("method", "TEXT NOT NULL", "UNIQUE"),
> > @@ -84,6 +88,8 @@ def setup_database(database, sync=3DTrue):
> >   def parse_address(addr):
> >       if addr.startswith(UNIX_PREFIX):
> >           return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX):],))
> > +    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
> > +        return (ADDR_TYPE_WS, (addr,))
> >       else:
> >           m =3D re.match(r'\[(?P<host>[^\]]*)\]:(?P<port>\d+)$', addr)
> >           if m is not None:
> > @@ -103,6 +109,9 @@ def create_server(addr, dbname, *, sync=3DTrue,
> upstream=3DNone, read_only=3DFalse):
> >       (typ, a) =3D parse_address(addr)
> >       if typ =3D=3D ADDR_TYPE_UNIX:
> >           s.start_unix_server(*a)
> > +    elif typ =3D=3D ADDR_TYPE_WS:
> > +        url =3D urlparse(a[0])
> > +        s.start_websocket_server(url.hostname, url.port)
> >       else:
> >           s.start_tcp_server(*a)
> >
> > @@ -116,6 +125,8 @@ def create_client(addr):
> >       (typ, a) =3D parse_address(addr)
> >       if typ =3D=3D ADDR_TYPE_UNIX:
> >           c.connect_unix(*a)
> > +    elif typ =3D=3D ADDR_TYPE_WS:
> > +        c.connect_websocket(*a)
> >       else:
> >           c.connect_tcp(*a)
> >
> > @@ -128,6 +139,8 @@ async def create_async_client(addr):
> >       (typ, a) =3D parse_address(addr)
> >       if typ =3D=3D ADDR_TYPE_UNIX:
> >           await c.connect_unix(*a)
> > +    elif typ =3D=3D ADDR_TYPE_WS:
> > +        await c.connect_websocket(*a)
> >       else:
> >           await c.connect_tcp(*a)
> >
> > diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> > index 5f7d22ab..9542d72f 100644
> > --- a/lib/hashserv/client.py
> > +++ b/lib/hashserv/client.py
> > @@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):
> >           super().__init__()
> >           self._add_methods(
> >               "connect_tcp",
> > +            "connect_websocket",
> >               "get_unihash",
> >               "report_unihash",
> >               "report_unihash_equiv",
> > diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
> > index f343c586..01ffd52c 100644
> > --- a/lib/hashserv/tests.py
> > +++ b/lib/hashserv/tests.py
> > @@ -483,3 +483,20 @@ class
> TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceCom=
m
> >           # If IPv6 is enabled, it should be safe to use localhost
> directly, in general
> >           # case it is more reliable to resolve the IP address
> explicitly.
> >           return socket.gethostbyname("localhost") + ":0"
> > +
> > +
> > +class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup,
> HashEquivalenceCommonTests, unittest.TestCase):
> > +    def setUp(self):
> > +        try:
> > +            import websockets
> > +        except ImportError as e:
> > +            self.skipTest(str(e))
> > +
> > +        super().setUp()
> > +
> > +    def get_server_addr(self, server_idx):
> > +        # Some hosts cause asyncio module to misbehave, when IPv6 is
> not enabled.
> > +        # If IPv6 is enabled, it should be safe to use localhost
> directly, in general
> > +        # case it is more reliable to resolve the IP address explicitl=
y.
> > +        host =3D socket.gethostbyname("localhost")
> > +        return "ws://%s:0" % host
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#15423):
> https://lists.openembedded.org/g/bitbake-devel/message/15423
> > Mute This Topic: https://lists.openembedded.org/mt/102364905/7851872
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> develop@schnelte.de]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>

--0000000000005f5cbb0609cce7f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Nov 10, 2023, 5:03=E2=80=AFAM Matthias Schnelt=
e &lt;<a href=3D"mailto:develop@schnelte.de">develop@schnelte.de</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi Joshua,<br>
<br>
thanks for this change! Being able to use websockets instead of some tcp <b=
r>
connection would help a lot in cooperate setups which are often <br>
restricted to only http(s) ports and enforce the use of a cooperate proxy.<=
br>
<br>
Unfortunately the websocket library you are using seems not to support <br>
websockets over http proxy. At least that is what I understood.<br>
<br>
Would it be possible to use another client lib for websockets in order <br>
to support connection through proxy?<br>
<br>
This library seems to support it: <br>
<a href=3D"https://websocket-client.readthedocs.io/en/latest/examples.html#=
connecting-through-a-proxy" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>https://websocket-client.readthedocs.io/en/latest/examples.html#connecting=
-through-a-proxy</a></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">I&#39;m not sure that&#39;s going to work. We need a librar=
y that supports asyncio, and has very minimal dependencies, which the curre=
nt library satisfies (it only depends on core Python)</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Maybe there is an=
other solution for proxying?</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><br>
<br>
Matthias<br>
<br>
On 03.11.23 15:26, Joshua Watt wrote:<br>
&gt; Adds support to the hash equivalence client and server to communicate<=
br>
&gt; over websockets. Since websockets are message orientated instead of<br=
>
&gt; stream orientated, and new connection class is needed to handle them.<=
br>
&gt;<br>
&gt; Note that websocket support does require the 3rd party websockets pyth=
on<br>
&gt; module be installed on the host, but it should not be required unless<=
br>
&gt; websockets are actually being used.<br>
&gt;<br>
&gt; Signed-off-by: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">JPEWhacker@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/bb/asyncrpc/client.py=C2=A0 =C2=A0 =C2=A0| 11 +++++++-=
<br>
&gt;=C2=A0 =C2=A0lib/bb/asyncrpc/connection.py | 44 +++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 =C2=A0lib/bb/asyncrpc/serv.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 53 +++=
+++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0lib/hashserv/__init__.py=C2=A0 =C2=A0 =C2=A0 | 13 ++++++++=
+<br>
&gt;=C2=A0 =C2=A0lib/hashserv/client.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
&gt;=C2=A0 =C2=A0lib/hashserv/tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
7 +++++++++++<br>
&gt;=C2=A0 =C2=A06 files changed, 137 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py<br>
&gt; index 7f33099b..802c07df 100644<br>
&gt; --- a/lib/bb/asyncrpc/client.py<br>
&gt; +++ b/lib/bb/asyncrpc/client.py<br>
&gt; @@ -10,7 +10,7 @@ import json<br>
&gt;=C2=A0 =C2=A0import os<br>
&gt;=C2=A0 =C2=A0import socket<br>
&gt;=C2=A0 =C2=A0import sys<br>
&gt; -from .connection import StreamConnection, DEFAULT_MAX_CHUNK<br>
&gt; +from .connection import StreamConnection, WebsocketConnection, DEFAUL=
T_MAX_CHUNK<br>
&gt;=C2=A0 =C2=A0from .exceptions import ConnectionClosedError<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -47,6 +47,15 @@ class AsyncClient(object):<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._connect_sock =3D connect=
_sock<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 async def connect_websocket(self, uri):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 import websockets<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 async def connect_sock():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 websocket =3D await websock=
ets.connect(uri, ping_interval=3DNone)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WebsocketConnection(=
websocket, self.timeout)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._connect_sock =3D connect_sock<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0async def setup_connection(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Send headers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0await self.socket.send(&quot;%=
s %s&quot; % (self.proto_name, self.proto_version))<br>
&gt; diff --git a/lib/bb/asyncrpc/connection.py b/lib/bb/asyncrpc/connectio=
n.py<br>
&gt; index c4fd2475..a10628f7 100644<br>
&gt; --- a/lib/bb/asyncrpc/connection.py<br>
&gt; +++ b/lib/bb/asyncrpc/connection.py<br>
&gt; @@ -93,3 +93,47 @@ class StreamConnection(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.writer is not None:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.writer.clos=
e()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.writer =3D =
None<br>
&gt; +<br>
&gt; +<br>
&gt; +class WebsocketConnection(object):<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, socket, timeout):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.socket =3D socket<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.timeout =3D timeout<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @property<br>
&gt; +=C2=A0 =C2=A0 def address(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;:&quot;.join(str(s) for s in=
 self.socket.remote_address)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def send_message(self, msg):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 await self.send(json.dumps(msg))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def recv_message(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D await self.recv()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return json.loads(m)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def send(self, msg):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 import websockets.exceptions<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 await self.socket.send(msg)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 except websockets.exceptions.ConnectionCl=
osed:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ConnectionClosedError=
(&quot;Connection closed&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def recv(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 import websockets.exceptions<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.timeout &lt; 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return await =
self.socket.recv()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return await =
asyncio.wait_for(self.socket.recv(), self.timeout)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except asyncio.TimeoutError=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Connect=
ionError(&quot;Timed out waiting for data&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 except websockets.exceptions.ConnectionCl=
osed:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ConnectionClosedError=
(&quot;Connection closed&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def close(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.socket is not None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 await self.socket.close()<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.socket =3D None<br>
&gt; diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py<br>
&gt; index 3e0d0632..dfb03773 100644<br>
&gt; --- a/lib/bb/asyncrpc/serv.py<br>
&gt; +++ b/lib/bb/asyncrpc/serv.py<br>
&gt; @@ -12,7 +12,7 @@ import signal<br>
&gt;=C2=A0 =C2=A0import socket<br>
&gt;=C2=A0 =C2=A0import sys<br>
&gt;=C2=A0 =C2=A0import multiprocessing<br>
&gt; -from .connection import StreamConnection<br>
&gt; +from .connection import StreamConnection, WebsocketConnection<br>
&gt;=C2=A0 =C2=A0from .exceptions import ClientError, ServerError, Connecti=
onClosedError<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -178,6 +178,54 @@ class UnixStreamServer(StreamServer):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(self.path)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +class WebsocketsServer(object):<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, host, port, handler, logger):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.host =3D host<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.port =3D port<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.handler =3D handler<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger =3D logger<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def start(self, loop):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 import websockets.server<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =3D loop.run_until_complete(<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 websockets.server.serve(<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.client_h=
andler,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.host,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.port,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ping_interval=
=3DNone,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for s in self.server.sockets:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.debug(&quot;Lis=
tening on %r&quot; % (s.getsockname(),))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable keep alives. This =
prevents broken client connections<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # from persisting on the se=
rver for long periods of time.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s.setsockopt(socket.SOL_SOC=
KET, socket.SO_KEEPALIVE, 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s.setsockopt(socket.IPPROTO=
_TCP, socket.TCP_KEEPIDLE, 30)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s.setsockopt(socket.IPPROTO=
_TCP, socket.TCP_KEEPINTVL, 15)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s.setsockopt(socket.IPPROTO=
_TCP, socket.TCP_KEEPCNT, 4)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D self.server.sockets[0].getsockna=
me()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.server.sockets[0].family =3D=3D s=
ocket.AF_INET6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.address =3D &quot;ws:/=
/[%s]:%d&quot; % (name[0], name[1])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.address =3D &quot;ws:/=
/%s:%d&quot; % (name[0], name[1])<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return [self.server.wait_closed()]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def stop(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server.close()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def cleanup(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 async def client_handler(self, websocket):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 socket =3D WebsocketConnection(websocket,=
 -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 await self.handler(socket)<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0class AsyncServer(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def __init__(self, logger):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger =3D logger<br>
&gt; @@ -190,6 +238,9 @@ class AsyncServer(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def start_unix_server(self, path):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.server =3D UnixStreamServ=
er(path, self._client_handler, self.logger)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 def start_websocket_server(self, host, port):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =3D WebsocketsServer(host, po=
rt, self._client_handler, self.logger)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0async def _client_handler(self, socket):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client =3D self.=
accept_client(socket)<br>
&gt; diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py<br>
&gt; index 3a401835..56b9c6bc 100644<br>
&gt; --- a/lib/hashserv/__init__.py<br>
&gt; +++ b/lib/hashserv/__init__.py<br>
&gt; @@ -9,11 +9,15 @@ import re<br>
&gt;=C2=A0 =C2=A0import sqlite3<br>
&gt;=C2=A0 =C2=A0import itertools<br>
&gt;=C2=A0 =C2=A0import json<br>
&gt; +from urllib.parse import urlparse<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0UNIX_PREFIX =3D &quot;unix://&quot;<br>
&gt; +WS_PREFIX =3D &quot;ws://&quot;<br>
&gt; +WSS_PREFIX =3D &quot;wss://&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0ADDR_TYPE_UNIX =3D 0<br>
&gt;=C2=A0 =C2=A0ADDR_TYPE_TCP =3D 1<br>
&gt; +ADDR_TYPE_WS =3D 2<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0UNIHASH_TABLE_DEFINITION =3D (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(&quot;method&quot;, &quot;TEXT NOT NULL&quo=
t;, &quot;UNIQUE&quot;),<br>
&gt; @@ -84,6 +88,8 @@ def setup_database(database, sync=3DTrue):<br>
&gt;=C2=A0 =C2=A0def parse_address(addr):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if addr.startswith(UNIX_PREFIX):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (ADDR_TYPE_UNIX, (addr[=
len(UNIX_PREFIX):],))<br>
&gt; +=C2=A0 =C2=A0 elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_=
PREFIX):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (ADDR_TYPE_WS, (addr,))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D re.match(r&#39;\[(?P&lt;=
host&gt;[^\]]*)\]:(?P&lt;port&gt;\d+)$&#39;, addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if m is not None:<br>
&gt; @@ -103,6 +109,9 @@ def create_server(addr, dbname, *, sync=3DTrue, up=
stream=3DNone, read_only=3DFalse):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(typ, a) =3D parse_address(addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if typ =3D=3D ADDR_TYPE_UNIX:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s.start_unix_server(*a)<br>
&gt; +=C2=A0 =C2=A0 elif typ =3D=3D ADDR_TYPE_WS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D urlparse(a[0])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.start_websocket_server(url.hostname, ur=
l.port)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s.start_tcp_server(*a)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -116,6 +125,8 @@ def create_client(addr):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(typ, a) =3D parse_address(addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if typ =3D=3D ADDR_TYPE_UNIX:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c.connect_unix(*a)<br>
&gt; +=C2=A0 =C2=A0 elif typ =3D=3D ADDR_TYPE_WS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c.connect_websocket(*a)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c.connect_tcp(*a)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -128,6 +139,8 @@ async def create_async_client(addr):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(typ, a) =3D parse_address(addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if typ =3D=3D ADDR_TYPE_UNIX:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0await c.connect_unix(*a)<br>
&gt; +=C2=A0 =C2=A0 elif typ =3D=3D ADDR_TYPE_WS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 await c.connect_websocket(*a)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0await c.connect_tcp(*a)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py<br>
&gt; index 5f7d22ab..9542d72f 100644<br>
&gt; --- a/lib/hashserv/client.py<br>
&gt; +++ b/lib/hashserv/client.py<br>
&gt; @@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._add_methods(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;connect_tc=
p&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;connect_websocket&quo=
t;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;get_unihas=
h&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;report_uni=
hash&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;report_uni=
hash_equiv&quot;,<br>
&gt; diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py<br>
&gt; index f343c586..01ffd52c 100644<br>
&gt; --- a/lib/hashserv/tests.py<br>
&gt; +++ b/lib/hashserv/tests.py<br>
&gt; @@ -483,3 +483,20 @@ class TestHashEquivalenceTCPServer(HashEquivalenc=
eTestSetup, HashEquivalenceComm<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# If IPv6 is enabled, it shoul=
d be safe to use localhost directly, in general<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# case it is more reliable to =
resolve the IP address explicitly.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return socket.gethostbyname(&q=
uot;localhost&quot;) + &quot;:0&quot;<br>
&gt; +<br>
&gt; +<br>
&gt; +class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, Ha=
shEquivalenceCommonTests, unittest.TestCase):<br>
&gt; +=C2=A0 =C2=A0 def setUp(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import websockets<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 except ImportError as e:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.skipTest(str(e))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().setUp()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def get_server_addr(self, server_idx):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Some hosts cause asyncio module to misb=
ehave, when IPv6 is not enabled.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If IPv6 is enabled, it should be safe t=
o use localhost directly, in general<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # case it is more reliable to resolve the=
 IP address explicitly.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D socket.gethostbyname(&quot;local=
host&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;ws://%s:0&quot; % host<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#15423): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/15423" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://lists.openembedded.org/g/bitbake-devel/message/15423</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/10236490=
5/7851872" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.op=
enembedded.org/mt/102364905/7851872</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank" rel=3D"noreferrer">bitbake-devel+owner@lists.opene=
mbedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.opene=
mbedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:develop@schnelte.d=
e" target=3D"_blank" rel=3D"noreferrer">develop@schnelte.de</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
</blockquote></div></div></div>

--0000000000005f5cbb0609cce7f8--

