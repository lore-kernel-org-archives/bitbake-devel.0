Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web08.6946.1606406233512812567
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Nov 2020 07:57:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=vaqLqYlY;
 spf=pass (domain: gmail.com, ip: 209.85.128.67, mailfrom: jpewhacker@gmail.com)
Received: by mail-wm1-f67.google.com with SMTP id h21so2876559wmb.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Nov 2020 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1ZZSke6ef8XSYlJo/bnOFT3xUKckswVgmTmZecG4Cw=;
        b=vaqLqYlYRoHjqjkrSOmL1UpncLS+vLAiXTXUD+buAMCvLoHrFiNxP1gKULLPv0JZyY
         B/FSYZtLvGh37ivWxw4hTXED5jHRSKgmuMkej15dhsofnWJ7We+BQxpM5LWiwa3SVmPO
         H7pXckxiI++duy7WB2+FHOlnJOdJbuQiCu4HWsPcJcQvaZiJeHZNdFEQG73/+Nx2RlVV
         aInj6Zwx4mKWWaaVrmUSdcQdcyKfpJx+UoJ1mZ4bKLJJYmDaTk+GLv/iXAmLF6ihx66t
         geczR9uTTQ2dVf+Xdm9U+i9JkRpRskfoJ+2V/s7kDL2bnAPnsndHxUEGi5G04tbErQfg
         K6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1ZZSke6ef8XSYlJo/bnOFT3xUKckswVgmTmZecG4Cw=;
        b=tpFT1qsk8QPSEyojOGY2cjrvkDbY+FSQeSAuxZ6Axni/h1FHd1k3hHQPWXMEeSrQk+
         pEIQEIdKcfhl1KhVv33kzieKEO0cNIuQv9J3DZddxiPMGazQJj2prkYAFJJOBQh2zwVW
         8gNyhni0VBjdpVr74EGcFV889ntcoMjvCwRYikj0c1Ty9ILKNE7GZzS+mw0rFNqHSEuZ
         B13VjQ9BTpspCDx9nHneXET4lyfFZWLXJ7yVeuFbrmemEvMAqv8n/+ED+k1maTmjpO6E
         qvAhhs2yvB4PORBgJsEmzEE/sz1Fv5wD1x3+xKrqlcnP0hIUppsmpY53UIgdOuS+wtW0
         xz8w==
X-Gm-Message-State: AOAM533WF9/Jv2Qm0SprhtZ+GXb4RL6ARrVxi8S9HwAg3p+LoxExnTpC
	R07tlvReNpYrjoFI9OpPUm1yGOZy5CZaMl6fT2o=
X-Google-Smtp-Source: ABdhPJwdmhTkOoIRKjuej+xiTjrJLb7mOdrCW6lr6BRB0Hv29xkB8HCeMaOkcXSzmN5AWHJvOz+KBdq6n3oXkmYwSvY=
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr4206870wmu.31.1606406231850;
 Thu, 26 Nov 2020 07:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20201110145956.1518964-1-JPEWhacker@gmail.com>
 <20201110145956.1518964-2-JPEWhacker@gmail.com> <48c57013bc2141c0cfbbb0ca5440071955428840.camel@intel.com>
In-Reply-To: <48c57013bc2141c0cfbbb0ca5440071955428840.camel@intel.com>
From: "Joshua Watt" <JPEWhacker@gmail.com>
Date: Thu, 26 Nov 2020 09:56:59 -0600
Message-ID: <CAJdd5GYbEFSnTjv_CN2NG=Zv5qJ1ABdRskSon8wiE+nySF6Z4Q@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake: hashserve: Add async client
To: Anuj Mittal <anuj.mittal@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000d087d005b5049818"

--000000000000d087d005b5049818
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2020, 12:22 AM Anuj Mittal <anuj.mittal@intel.com> wrote:

> Hi Joshua,
>
> I think this is causing issues when the path exceeds 108 chars:
>
> step1b: WARNING: Error contacting Hash Equivalence Server
> unix:///home/pokybuild/yocto-autobuilder-new/yocto-worker/intel-core2-
> 32-altcfg-linux-yocto/build/build/hashserve.sock: AF_UNIX path too long
>

Odd. I would have expected that limit to be a problem with the old
(non-async) client as well


> Thanks,
>
> Anuj
>
> On Tue, 2020-11-10 at 08:59 -0600, Joshua Watt wrote:
> > Adds support for create a client that operates using Python
> > asynchronous
> > I/O.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  bitbake/lib/hashserv/__init__.py |  13 ++
> >  bitbake/lib/hashserv/client.py   | 238 +++++++++++++++++------------
> > --
> >  2 files changed, 143 insertions(+), 108 deletions(-)
> >
> > diff --git a/bitbake/lib/hashserv/__init__.py
> > b/bitbake/lib/hashserv/__init__.py
> > index f95e8f43f1..622ca17a91 100644
> > --- a/bitbake/lib/hashserv/__init__.py
> > +++ b/bitbake/lib/hashserv/__init__.py
> > @@ -3,6 +3,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  #
> >
> > +import asyncio
> >  from contextlib import closing
> >  import re
> >  import sqlite3
> > @@ -113,3 +114,15 @@ def create_client(addr):
> >          c.connect_tcp(*a)
> >
> >      return c
> > +
> > +async def create_async_client(addr):
> > +    from . import client
> > +    c = client.AsyncClient()
> > +
> > +    (typ, a) = parse_address(addr)
> > +    if typ == ADDR_TYPE_UNIX:
> > +        await c.connect_unix(*a)
> > +    else:
> > +        await c.connect_tcp(*a)
> > +
> > +    return c
> > diff --git a/bitbake/lib/hashserv/client.py
> > b/bitbake/lib/hashserv/client.py
> > index a29af836d9..d0b3cf3863 100644
> > --- a/bitbake/lib/hashserv/client.py
> > +++ b/bitbake/lib/hashserv/client.py
> > @@ -3,189 +3,211 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  #
> >
> > +import asyncio
> >  import json
> >  import logging
> >  import socket
> >  import os
> > -from . import chunkify, DEFAULT_MAX_CHUNK
> > +from . import chunkify, DEFAULT_MAX_CHUNK, create_async_client
> >
> >
> > -logger = logging.getLogger('hashserv.client')
> > +logger = logging.getLogger("hashserv.client")
> >
> >
> >  class HashConnectionError(Exception):
> >      pass
> >
> >
> > -class Client(object):
> > +class AsyncClient(object):
> >      MODE_NORMAL = 0
> >      MODE_GET_STREAM = 1
> >
> >      def __init__(self):
> > -        self._socket = None
> >          self.reader = None
> >          self.writer = None
> >          self.mode = self.MODE_NORMAL
> >          self.max_chunk = DEFAULT_MAX_CHUNK
> >
> > -    def connect_tcp(self, address, port):
> > -        def connect_sock():
> > -            s = socket.create_connection((address, port))
> > -
> > -            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
> > -            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
> > -            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
> > -            return s
> > +    async def connect_tcp(self, address, port):
> > +        async def connect_sock():
> > +            return await asyncio.open_connection(address, port)
> >
> >          self._connect_sock = connect_sock
> >
> > -    def connect_unix(self, path):
> > -        def connect_sock():
> > -            s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> > -            # AF_UNIX has path length issues so chdir here to
> > workaround
> > -            cwd = os.getcwd()
> > -            try:
> > -                os.chdir(os.path.dirname(path))
> > -                s.connect(os.path.basename(path))
> > -            finally:
> > -                os.chdir(cwd)
> > -            return s
> > +    async def connect_unix(self, path):
> > +        async def connect_sock():
> > +            return await asyncio.open_unix_connection(path)
> >
> >          self._connect_sock = connect_sock
> >
> > -    def connect(self):
> > -        if self._socket is None:
> > -            self._socket = self._connect_sock()
> > -
> > -            self.reader = self._socket.makefile('r', encoding='utf-
> > 8')
> > -            self.writer = self._socket.makefile('w', encoding='utf-
> > 8')
> > +    async def _connect(self):
> > +        if self.reader is None or self.writer is None:
> > +            (self.reader, self.writer) = await self._connect_sock()
> >
> > -            self.writer.write('OEHASHEQUIV 1.1\n\n')
> > -            self.writer.flush()
> > +            self.writer.write("OEHASHEQUIV 1.1\n\n".encode("utf-8"))
> > +            await self.writer.drain()
> >
> > -            # Restore mode if the socket is being re-created
> >              cur_mode = self.mode
> >              self.mode = self.MODE_NORMAL
> > -            self._set_mode(cur_mode)
> > +            await self._set_mode(cur_mode)
> >
> > -        return self._socket
> > +    async def close(self):
> > +        self.reader = None
> >
> > -    def close(self):
> > -        if self._socket is not None:
> > -            self._socket.close()
> > -            self._socket = None
> > -            self.reader = None
> > +        if self.writer is not None:
> > +            self.writer.close()
> >              self.writer = None
> >
> > -    def _send_wrapper(self, proc):
> > +    async def _send_wrapper(self, proc):
> >          count = 0
> >          while True:
> >              try:
> > -                self.connect()
> > -                return proc()
> > -            except (OSError, HashConnectionError,
> > json.JSONDecodeError, UnicodeDecodeError) as e:
> > -                logger.warning('Error talking to server: %s' % e)
> > +                await self._connect()
> > +                return await proc()
> > +            except (
> > +                OSError,
> > +                HashConnectionError,
> > +                json.JSONDecodeError,
> > +                UnicodeDecodeError,
> > +            ) as e:
> > +                logger.warning("Error talking to server: %s" % e)
> >                  if count >= 3:
> >                      if not isinstance(e, HashConnectionError):
> >                          raise HashConnectionError(str(e))
> >                      raise e
> > -                self.close()
> > +                await self.close()
> >                  count += 1
> >
> > -    def send_message(self, msg):
> > -        def get_line():
> > -            line = self.reader.readline()
> > +    async def send_message(self, msg):
> > +        async def get_line():
> > +            line = await self.reader.readline()
> >              if not line:
> > -                raise HashConnectionError('Connection closed')
> > +                raise HashConnectionError("Connection closed")
> > +
> > +            line = line.decode("utf-8")
> >
> > -            if not line.endswith('\n'):
> > -                raise HashConnectionError('Bad message %r' %
> > message)
> > +            if not line.endswith("\n"):
> > +                raise HashConnectionError("Bad message %r" %
> > message)
> >
> >              return line
> >
> > -        def proc():
> > +        async def proc():
> >              for c in chunkify(json.dumps(msg), self.max_chunk):
> > -                self.writer.write(c)
> > -            self.writer.flush()
> > +                self.writer.write(c.encode("utf-8"))
> > +            await self.writer.drain()
> >
> > -            l = get_line()
> > +            l = await get_line()
> >
> >              m = json.loads(l)
> > -            if 'chunk-stream' in m:
> > +            if "chunk-stream" in m:
> >                  lines = []
> >                  while True:
> > -                    l = get_line().rstrip('\n')
> > +                    l = (await get_line()).rstrip("\n")
> >                      if not l:
> >                          break
> >                      lines.append(l)
> >
> > -                m = json.loads(''.join(lines))
> > +                m = json.loads("".join(lines))
> >
> >              return m
> >
> > -        return self._send_wrapper(proc)
> > +        return await self._send_wrapper(proc)
> >
> > -    def send_stream(self, msg):
> > -        def proc():
> > -            self.writer.write("%s\n" % msg)
> > -            self.writer.flush()
> > -            l = self.reader.readline()
> > +    async def send_stream(self, msg):
> > +        async def proc():
> > +            self.writer.write(("%s\n" % msg).encode("utf-8"))
> > +            await self.writer.drain()
> > +            l = await self.reader.readline()
> >              if not l:
> > -                raise HashConnectionError('Connection closed')
> > -            return l.rstrip()
> > +                raise HashConnectionError("Connection closed")
> > +            return l.decode("utf-8").rstrip()
> >
> > -        return self._send_wrapper(proc)
> > +        return await self._send_wrapper(proc)
> >
> > -    def _set_mode(self, new_mode):
> > +    async def _set_mode(self, new_mode):
> >          if new_mode == self.MODE_NORMAL and self.mode ==
> > self.MODE_GET_STREAM:
> > -            r = self.send_stream('END')
> > -            if r != 'ok':
> > -                raise HashConnectionError('Bad response from server
> > %r' % r)
> > +            r = await self.send_stream("END")
> > +            if r != "ok":
> > +                raise HashConnectionError("Bad response from server
> > %r" % r)
> >          elif new_mode == self.MODE_GET_STREAM and self.mode ==
> > self.MODE_NORMAL:
> > -            r = self.send_message({'get-stream': None})
> > -            if r != 'ok':
> > -                raise HashConnectionError('Bad response from server
> > %r' % r)
> > +            r = await self.send_message({"get-stream": None})
> > +            if r != "ok":
> > +                raise HashConnectionError("Bad response from server
> > %r" % r)
> >          elif new_mode != self.mode:
> > -            raise Exception('Undefined mode transition %r -> %r' %
> > (self.mode, new_mode))
> > +            raise Exception(
> > +                "Undefined mode transition %r -> %r" % (self.mode,
> > new_mode)
> > +            )
> >
> >          self.mode = new_mode
> >
> > -    def get_unihash(self, method, taskhash):
> > -        self._set_mode(self.MODE_GET_STREAM)
> > -        r = self.send_stream('%s %s' % (method, taskhash))
> > +    async def get_unihash(self, method, taskhash):
> > +        await self._set_mode(self.MODE_GET_STREAM)
> > +        r = await self.send_stream("%s %s" % (method, taskhash))
> >          if not r:
> >              return None
> >          return r
> >
> > -    def report_unihash(self, taskhash, method, outhash, unihash,
> > extra={}):
> > -        self._set_mode(self.MODE_NORMAL)
> > +    async def report_unihash(self, taskhash, method, outhash,
> > unihash, extra={}):
> > +        await self._set_mode(self.MODE_NORMAL)
> >          m = extra.copy()
> > -        m['taskhash'] = taskhash
> > -        m['method'] = method
> > -        m['outhash'] = outhash
> > -        m['unihash'] = unihash
> > -        return self.send_message({'report': m})
> > -
> > -    def report_unihash_equiv(self, taskhash, method, unihash,
> > extra={}):
> > -        self._set_mode(self.MODE_NORMAL)
> > +        m["taskhash"] = taskhash
> > +        m["method"] = method
> > +        m["outhash"] = outhash
> > +        m["unihash"] = unihash
> > +        return await self.send_message({"report": m})
> > +
> > +    async def report_unihash_equiv(self, taskhash, method, unihash,
> > extra={}):
> > +        await self._set_mode(self.MODE_NORMAL)
> >          m = extra.copy()
> > -        m['taskhash'] = taskhash
> > -        m['method'] = method
> > -        m['unihash'] = unihash
> > -        return self.send_message({'report-equiv': m})
> > -
> > -    def get_taskhash(self, method, taskhash, all_properties=False):
> > -        self._set_mode(self.MODE_NORMAL)
> > -        return self.send_message({'get': {
> > -            'taskhash': taskhash,
> > -            'method': method,
> > -            'all': all_properties
> > -        }})
> > -
> > -    def get_stats(self):
> > -        self._set_mode(self.MODE_NORMAL)
> > -        return self.send_message({'get-stats': None})
> > -
> > -    def reset_stats(self):
> > -        self._set_mode(self.MODE_NORMAL)
> > -        return self.send_message({'reset-stats': None})
> > +        m["taskhash"] = taskhash
> > +        m["method"] = method
> > +        m["unihash"] = unihash
> > +        return await self.send_message({"report-equiv": m})
> > +
> > +    async def get_taskhash(self, method, taskhash,
> > all_properties=False):
> > +        await self._set_mode(self.MODE_NORMAL)
> > +        return await self.send_message(
> > +            {"get": {"taskhash": taskhash, "method": method, "all":
> > all_properties}}
> > +        )
> > +
> > +    async def get_stats(self):
> > +        await self._set_mode(self.MODE_NORMAL)
> > +        return await self.send_message({"get-stats": None})
> > +
> > +    async def reset_stats(self):
> > +        await self._set_mode(self.MODE_NORMAL)
> > +        return await self.send_message({"reset-stats": None})
> > +
> > +
> > +class Client(object):
> > +    def __init__(self):
> > +        self.client = AsyncClient()
> > +        self.loop = asyncio.new_event_loop()
> > +
> > +        def get_wrapper(self, downcall):
> > +            def wrapper(*args, **kwargs):
> > +                return self.loop.run_until_complete(downcall(*args,
> > **kwargs))
> > +
> > +            return wrapper
> > +
> > +        for call in (
> > +            "connect_tcp",
> > +            "connect_unix",
> > +            "close",
> > +            "get_unihash",
> > +            "report_unihash",
> > +            "report_unihash_equiv",
> > +            "get_taskhash",
> > +            "get_stats",
> > +            "reset_stats",
> > +        ):
> > +            downcall = getattr(self.client, call)
> > +            setattr(self, call, get_wrapper(self, downcall))
> > +
> > +    @property
> > +    def max_chunk(self):
> > +        return self.client.max_chunk
> > +
> > +    @max_chunk.setter
> > +    def max_chunk(self, value):
> > +        self.client.max_chunk = value
> >
> >
> >
>
>
> 
>
>

--000000000000d087d005b5049818
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgTm92IDI2LCAyMDIwLCAxMjoy
MiBBTSBBbnVqIE1pdHRhbCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFudWoubWl0dGFsQGludGVsLmNv
bSI+YW51ai5taXR0YWxAaW50ZWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhpIEpvc2h1YSw8YnI+DQo8YnI+
DQpJIHRoaW5rIHRoaXMgaXMgY2F1c2luZyBpc3N1ZXMgd2hlbiB0aGUgcGF0aCBleGNlZWRzIDEw
OCBjaGFyczo8YnI+DQo8YnI+DQpzdGVwMWI6IFdBUk5JTkc6IEVycm9yIGNvbnRhY3RpbmcgSGFz
aCBFcXVpdmFsZW5jZSBTZXJ2ZXI8YnI+DQp1bml4Oi8vL2hvbWUvcG9reWJ1aWxkL3lvY3RvLWF1
dG9idWlsZGVyLW5ldy95b2N0by13b3JrZXIvaW50ZWwtY29yZTItPGJyPg0KMzItYWx0Y2ZnLWxp
bnV4LXlvY3RvL2J1aWxkL2J1aWxkL2hhc2hzZXJ2ZS5zb2NrOiBBRl9VTklYIHBhdGggdG9vIGxv
bmc8YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+
PGRpdiBkaXI9ImF1dG8iPk9kZC4gSSB3b3VsZCBoYXZlIGV4cGVjdGVkIHRoYXQgbGltaXQgdG8g
YmUgYSBwcm9ibGVtIHdpdGggdGhlIG9sZCAobm9uLWFzeW5jKSBjbGllbnQgYXMgd2VsbDwvZGl2
PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4N
Cjxicj4NClRoYW5rcyw8YnI+DQo8YnI+DQpBbnVqPGJyPg0KPGJyPg0KT24gVHVlLCAyMDIwLTEx
LTEwIGF0IDA4OjU5IC0wNjAwLCBKb3NodWEgV2F0dCB3cm90ZTo8YnI+DQomZ3Q7IEFkZHMgc3Vw
cG9ydCBmb3IgY3JlYXRlIGEgY2xpZW50IHRoYXQgb3BlcmF0ZXMgdXNpbmcgUHl0aG9uPGJyPg0K
Jmd0OyBhc3luY2hyb25vdXM8YnI+DQomZ3Q7IEkvTy48YnI+DQomZ3Q7IDxicj4NCiZndDsgU2ln
bmVkLW9mZi1ieTogSm9zaHVhIFdhdHQgJmx0OzxhIGhyZWY9Im1haWx0bzpKUEVXaGFja2VyQGdt
YWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciI+SlBFV2hhY2tlckBnbWFp
bC5jb208L2E+Jmd0Ozxicj4NCiZndDsgLS0tPGJyPg0KJmd0OyDCoGJpdGJha2UvbGliL2hhc2hz
ZXJ2L19faW5pdF9fLnB5IHzCoCAxMyArKzxicj4NCiZndDsgwqBiaXRiYWtlL2xpYi9oYXNoc2Vy
di9jbGllbnQucHnCoMKgIHwgMjM4ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tPGJyPg0K
Jmd0OyAtLTxicj4NCiZndDsgwqAyIGZpbGVzIGNoYW5nZWQsIDE0MyBpbnNlcnRpb25zKCspLCAx
MDggZGVsZXRpb25zKC0pPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS9iaXRiYWtl
L2xpYi9oYXNoc2Vydi9fX2luaXRfXy5weTxicj4NCiZndDsgYi9iaXRiYWtlL2xpYi9oYXNoc2Vy
di9fX2luaXRfXy5weTxicj4NCiZndDsgaW5kZXggZjk1ZThmNDNmMS4uNjIyY2ExN2E5MSAxMDA2
NDQ8YnI+DQomZ3Q7IC0tLSBhL2JpdGJha2UvbGliL2hhc2hzZXJ2L19faW5pdF9fLnB5PGJyPg0K
Jmd0OyArKysgYi9iaXRiYWtlL2xpYi9oYXNoc2Vydi9fX2luaXRfXy5weTxicj4NCiZndDsgQEAg
LTMsNiArMyw3IEBAPGJyPg0KJmd0OyDCoCMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seTxicj4NCiZndDsgwqAjPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgK2ltcG9ydCBhc3lu
Y2lvPGJyPg0KJmd0OyDCoGZyb20gY29udGV4dGxpYiBpbXBvcnQgY2xvc2luZzxicj4NCiZndDsg
wqBpbXBvcnQgcmU8YnI+DQomZ3Q7IMKgaW1wb3J0IHNxbGl0ZTM8YnI+DQomZ3Q7IEBAIC0xMTMs
MyArMTE0LDE1IEBAIGRlZiBjcmVhdGVfY2xpZW50KGFkZHIpOjxicj4NCiZndDsgwqDCoMKgwqDC
oMKgwqDCoCBjLmNvbm5lY3RfdGNwKCphKTxicj4NCiZndDsgwqA8YnI+DQomZ3Q7IMKgwqDCoMKg
IHJldHVybiBjPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArYXN5bmMgZGVmIGNyZWF0ZV9hc3luY19j
bGllbnQoYWRkcik6PGJyPg0KJmd0OyArwqDCoMKgIGZyb20gLiBpbXBvcnQgY2xpZW50PGJyPg0K
Jmd0OyArwqDCoMKgIGMgPSBjbGllbnQuQXN5bmNDbGllbnQoKTxicj4NCiZndDsgKzxicj4NCiZn
dDsgK8KgwqDCoCAodHlwLCBhKSA9IHBhcnNlX2FkZHJlc3MoYWRkcik8YnI+DQomZ3Q7ICvCoMKg
wqAgaWYgdHlwID09IEFERFJfVFlQRV9VTklYOjxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIGF3
YWl0IGMuY29ubmVjdF91bml4KCphKTxicj4NCiZndDsgK8KgwqDCoCBlbHNlOjxicj4NCiZndDsg
K8KgwqDCoMKgwqDCoMKgIGF3YWl0IGMuY29ubmVjdF90Y3AoKmEpPGJyPg0KJmd0OyArPGJyPg0K
Jmd0OyArwqDCoMKgIHJldHVybiBjPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvYml0YmFrZS9saWIv
aGFzaHNlcnYvY2xpZW50LnB5PGJyPg0KJmd0OyBiL2JpdGJha2UvbGliL2hhc2hzZXJ2L2NsaWVu
dC5weTxicj4NCiZndDsgaW5kZXggYTI5YWY4MzZkOS4uZDBiM2NmMzg2MyAxMDA2NDQ8YnI+DQom
Z3Q7IC0tLSBhL2JpdGJha2UvbGliL2hhc2hzZXJ2L2NsaWVudC5weTxicj4NCiZndDsgKysrIGIv
Yml0YmFrZS9saWIvaGFzaHNlcnYvY2xpZW50LnB5PGJyPg0KJmd0OyBAQCAtMywxODkgKzMsMjEx
IEBAPGJyPg0KJmd0OyDCoCMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seTxi
cj4NCiZndDsgwqAjPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgK2ltcG9ydCBhc3luY2lvPGJyPg0K
Jmd0OyDCoGltcG9ydCBqc29uPGJyPg0KJmd0OyDCoGltcG9ydCBsb2dnaW5nPGJyPg0KJmd0OyDC
oGltcG9ydCBzb2NrZXQ8YnI+DQomZ3Q7IMKgaW1wb3J0IG9zPGJyPg0KJmd0OyAtZnJvbSAuIGlt
cG9ydCBjaHVua2lmeSwgREVGQVVMVF9NQVhfQ0hVTks8YnI+DQomZ3Q7ICtmcm9tIC4gaW1wb3J0
IGNodW5raWZ5LCBERUZBVUxUX01BWF9DSFVOSywgY3JlYXRlX2FzeW5jX2NsaWVudDxicj4NCiZn
dDsgwqA8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyAtbG9nZ2VyID0gbG9nZ2luZy5nZXRMb2dnZXIo
JiMzOTtoYXNoc2Vydi5jbGllbnQmIzM5Oyk8YnI+DQomZ3Q7ICtsb2dnZXIgPSBsb2dnaW5nLmdl
dExvZ2dlcigmcXVvdDtoYXNoc2Vydi5jbGllbnQmcXVvdDspPGJyPg0KJmd0OyDCoDxicj4NCiZn
dDsgwqA8YnI+DQomZ3Q7IMKgY2xhc3MgSGFzaENvbm5lY3Rpb25FcnJvcihFeGNlcHRpb24pOjxi
cj4NCiZndDsgwqDCoMKgwqAgcGFzczxicj4NCiZndDsgwqA8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0
OyAtY2xhc3MgQ2xpZW50KG9iamVjdCk6PGJyPg0KJmd0OyArY2xhc3MgQXN5bmNDbGllbnQob2Jq
ZWN0KTo8YnI+DQomZ3Q7IMKgwqDCoMKgIE1PREVfTk9STUFMID0gMDxicj4NCiZndDsgwqDCoMKg
wqAgTU9ERV9HRVRfU1RSRUFNID0gMTxicj4NCiZndDsgwqA8YnI+DQomZ3Q7IMKgwqDCoMKgIGRl
ZiBfX2luaXRfXyhzZWxmKTo8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCBzZWxmLl9zb2NrZXQg
PSBOb25lPGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKgIHNlbGYucmVhZGVyID0gTm9uZTxicj4N
CiZndDsgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLndyaXRlciA9IE5vbmU8YnI+DQomZ3Q7IMKgwqDC
oMKgwqDCoMKgwqAgc2VsZi5tb2RlID0gc2VsZi5NT0RFX05PUk1BTDxicj4NCiZndDsgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLm1heF9jaHVuayA9IERFRkFVTFRfTUFYX0NIVU5LPGJyPg0KJmd0OyDC
oDxicj4NCiZndDsgLcKgwqDCoCBkZWYgY29ubmVjdF90Y3Aoc2VsZiwgYWRkcmVzcywgcG9ydCk6
PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgZGVmIGNvbm5lY3Rfc29jaygpOjxicj4NCiZndDsg
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcyA9IHNvY2tldC5jcmVhdGVfY29ubmVjdGlvbigoYWRk
cmVzcywgcG9ydCkpPGJyPg0KJmd0OyAtPGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzLnNldHNvY2tvcHQoc29ja2V0LlNPTF9UQ1AsIHNvY2tldC5UQ1BfTk9ERUxBWSwgMSk8YnI+
DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMuc2V0c29ja29wdChzb2NrZXQuU09MX1RD
UCwgc29ja2V0LlRDUF9RVUlDS0FDSywgMSk8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHMuc2V0c29ja29wdChzb2NrZXQuU09MX1NPQ0tFVCwgc29ja2V0LlNPX0tFRVBBTElWRSwg
MSk8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzPGJyPg0KJmd0OyAr
wqDCoMKgIGFzeW5jIGRlZiBjb25uZWN0X3RjcChzZWxmLCBhZGRyZXNzLCBwb3J0KTo8YnI+DQom
Z3Q7ICvCoMKgwqDCoMKgwqDCoCBhc3luYyBkZWYgY29ubmVjdF9zb2NrKCk6PGJyPg0KJmd0OyAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gYXdhaXQgYXN5bmNpby5vcGVuX2Nvbm5lY3Rp
b24oYWRkcmVzcywgcG9ydCk8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKg
IHNlbGYuX2Nvbm5lY3Rfc29jayA9IGNvbm5lY3Rfc29jazxicj4NCiZndDsgwqA8YnI+DQomZ3Q7
IC3CoMKgwqAgZGVmIGNvbm5lY3RfdW5peChzZWxmLCBwYXRoKTo8YnI+DQomZ3Q7IC3CoMKgwqDC
oMKgwqDCoCBkZWYgY29ubmVjdF9zb2NrKCk6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzID0gc29ja2V0LnNvY2tldChzb2NrZXQuQUZfVU5JWCwgc29ja2V0LlNPQ0tfU1RSRUFN
KTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBBRl9VTklYIGhhcyBwYXRoIGxl
bmd0aCBpc3N1ZXMgc28gY2hkaXIgaGVyZSB0bzxicj4NCiZndDsgd29ya2Fyb3VuZDxicj4NCiZn
dDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3dkID0gb3MuZ2V0Y3dkKCk8YnI+DQomZ3Q7IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyeTo8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgb3MuY2hkaXIob3MucGF0aC5kaXJuYW1lKHBhdGgpKTxicj4NCiZndDsgLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLmNvbm5lY3Qob3MucGF0aC5iYXNlbmFtZShw
YXRoKSk8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbmFsbHk6PGJyPg0KJmd0
OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9zLmNoZGlyKGN3ZCk8YnI+DQomZ3Q7
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzPGJyPg0KJmd0OyArwqDCoMKgIGFzeW5j
IGRlZiBjb25uZWN0X3VuaXgoc2VsZiwgcGF0aCk6PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAg
YXN5bmMgZGVmIGNvbm5lY3Rfc29jaygpOjxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIGF3YWl0IGFzeW5jaW8ub3Blbl91bml4X2Nvbm5lY3Rpb24ocGF0aCk8YnI+DQom
Z3Q7IMKgPGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuX2Nvbm5lY3Rfc29jayA9IGNv
bm5lY3Rfc29jazxicj4NCiZndDsgwqA8YnI+DQomZ3Q7IC3CoMKgwqAgZGVmIGNvbm5lY3Qoc2Vs
Zik6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgaWYgc2VsZi5fc29ja2V0IGlzIE5vbmU6PGJy
Pg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLl9zb2NrZXQgPSBzZWxmLl9jb25u
ZWN0X3NvY2soKTxicj4NCiZndDsgLTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2VsZi5yZWFkZXIgPSBzZWxmLl9zb2NrZXQubWFrZWZpbGUoJiMzOTtyJiMzOTssIGVuY29kaW5n
PSYjMzk7dXRmLTxicj4NCiZndDsgOCYjMzk7KTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2VsZi53cml0ZXIgPSBzZWxmLl9zb2NrZXQubWFrZWZpbGUoJiMzOTt3JiMzOTssIGVu
Y29kaW5nPSYjMzk7dXRmLTxicj4NCiZndDsgOCYjMzk7KTxicj4NCiZndDsgK8KgwqDCoCBhc3lu
YyBkZWYgX2Nvbm5lY3Qoc2VsZik6PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgaWYgc2VsZi5y
ZWFkZXIgaXMgTm9uZSBvciBzZWxmLndyaXRlciBpcyBOb25lOjxicj4NCiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKHNlbGYucmVhZGVyLCBzZWxmLndyaXRlcikgPSBhd2FpdCBzZWxmLl9j
b25uZWN0X3NvY2soKTxicj4NCiZndDsgwqA8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNlbGYud3JpdGVyLndyaXRlKCYjMzk7T0VIQVNIRVFVSVYgMS4xXG5cbiYjMzk7KTxicj4N
CiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi53cml0ZXIuZmx1c2goKTxicj4NCiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi53cml0ZXIud3JpdGUoJnF1b3Q7T0VIQVNI
RVFVSVYgMS4xXG5cbiZxdW90Oy5lbmNvZGUoJnF1b3Q7dXRmLTgmcXVvdDspKTxicj4NCiZndDsg
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXdhaXQgc2VsZi53cml0ZXIuZHJhaW4oKTxicj4NCiZn
dDsgwqA8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgUmVzdG9yZSBtb2RlIGlm
IHRoZSBzb2NrZXQgaXMgYmVpbmcgcmUtY3JlYXRlZDxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGN1cl9tb2RlID0gc2VsZi5tb2RlPGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2VsZi5tb2RlID0gc2VsZi5NT0RFX05PUk1BTDxicj4NCiZndDsgLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2VsZi5fc2V0X21vZGUoY3VyX21vZGUpPGJyPg0KJmd0OyArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhd2FpdCBzZWxmLl9zZXRfbW9kZShjdXJfbW9kZSk8YnI+DQomZ3Q7
IMKgPGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNlbGYuX3NvY2tldDxicj4NCiZn
dDsgK8KgwqDCoCBhc3luYyBkZWYgY2xvc2Uoc2VsZik6PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKg
wqAgc2VsZi5yZWFkZXIgPSBOb25lPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgLcKgwqDCoCBkZWYg
Y2xvc2Uoc2VsZik6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgaWYgc2VsZi5fc29ja2V0IGlz
IG5vdCBOb25lOjxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5fc29ja2V0
LmNsb3NlKCk8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuX3NvY2tldCA9
IE5vbmU8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYucmVhZGVyID0gTm9u
ZTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIGlmIHNlbGYud3JpdGVyIGlzIG5vdCBOb25lOjxi
cj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi53cml0ZXIuY2xvc2UoKTxicj4N
CiZndDsgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYud3JpdGVyID0gTm9uZTxicj4NCiZn
dDsgwqA8YnI+DQomZ3Q7IC3CoMKgwqAgZGVmIF9zZW5kX3dyYXBwZXIoc2VsZiwgcHJvYyk6PGJy
Pg0KJmd0OyArwqDCoMKgIGFzeW5jIGRlZiBfc2VuZF93cmFwcGVyKHNlbGYsIHByb2MpOjxicj4N
CiZndDsgwqDCoMKgwqDCoMKgwqDCoCBjb3VudCA9IDA8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKg
wqAgd2hpbGUgVHJ1ZTo8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnk6PGJy
Pg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuY29ubmVjdCgpPGJy
Pg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBwcm9jKCk8YnI+
DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4Y2VwdCAoT1NFcnJvciwgSGFzaENvbm5l
Y3Rpb25FcnJvciw8YnI+DQomZ3Q7IGpzb24uSlNPTkRlY29kZUVycm9yLCBVbmljb2RlRGVjb2Rl
RXJyb3IpIGFzIGU6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxv
Z2dlci53YXJuaW5nKCYjMzk7RXJyb3IgdGFsa2luZyB0byBzZXJ2ZXI6ICVzJiMzOTsgJSBlKTxi
cj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhd2FpdCBzZWxmLl9jb25u
ZWN0KCk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGF3
YWl0IHByb2MoKTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZXB0ICg8YnI+
DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT1NFcnJvciw8YnI+DQomZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSGFzaENvbm5lY3Rpb25FcnJvciw8YnI+
DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAganNvbi5KU09ORGVjb2RlRXJy
b3IsPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVuaWNvZGVEZWNv
ZGVFcnJvciw8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICkgYXMgZTo8YnI+DQom
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9nZ2VyLndhcm5pbmcoJnF1b3Q7
RXJyb3IgdGFsa2luZyB0byBzZXJ2ZXI6ICVzJnF1b3Q7ICUgZSk8YnI+DQomZ3Q7IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGNvdW50ICZndDs9IDM6PGJyPg0KJmd0OyDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIG5vdCBpc2luc3RhbmNlKGUs
IEhhc2hDb25uZWN0aW9uRXJyb3IpOjxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNlIEhhc2hDb25uZWN0aW9uRXJyb3Ioc3RyKGUp
KTxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlz
ZSBlPGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuY2xvc2Uo
KTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhd2FpdCBzZWxmLmNs
b3NlKCk8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50ICs9
IDE8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyAtwqDCoMKgIGRlZiBzZW5kX21lc3NhZ2Uoc2VsZiwg
bXNnKTo8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCBkZWYgZ2V0X2xpbmUoKTo8YnI+DQomZ3Q7
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmUgPSBzZWxmLnJlYWRlci5yZWFkbGluZSgpPGJy
Pg0KJmd0OyArwqDCoMKgIGFzeW5jIGRlZiBzZW5kX21lc3NhZ2Uoc2VsZiwgbXNnKTo8YnI+DQom
Z3Q7ICvCoMKgwqDCoMKgwqDCoCBhc3luYyBkZWYgZ2V0X2xpbmUoKTo8YnI+DQomZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxpbmUgPSBhd2FpdCBzZWxmLnJlYWRlci5yZWFkbGluZSgpPGJy
Pg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IGxpbmU6PGJyPg0KJmd0OyAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNlIEhhc2hDb25uZWN0aW9uRXJyb3Io
JiMzOTtDb25uZWN0aW9uIGNsb3NlZCYjMzk7KTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByYWlzZSBIYXNoQ29ubmVjdGlvbkVycm9yKCZxdW90O0Nvbm5lY3Rpb24g
Y2xvc2VkJnF1b3Q7KTxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbGluZSA9IGxpbmUuZGVjb2RlKCZxdW90O3V0Zi04JnF1b3Q7KTxicj4NCiZndDsgwqA8YnI+
DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIG5vdCBsaW5lLmVuZHN3aXRoKCYjMzk7
XG4mIzM5Oyk6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNl
IEhhc2hDb25uZWN0aW9uRXJyb3IoJiMzOTtCYWQgbWVzc2FnZSAlciYjMzk7ICU8YnI+DQomZ3Q7
IG1lc3NhZ2UpPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBub3QgbGluZS5l
bmRzd2l0aCgmcXVvdDtcbiZxdW90Oyk6PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJhaXNlIEhhc2hDb25uZWN0aW9uRXJyb3IoJnF1b3Q7QmFkIG1lc3NhZ2UgJXIm
cXVvdDsgJTxicj4NCiZndDsgbWVzc2FnZSk8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGxpbmU8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyAtwqDC
oMKgwqDCoMKgwqAgZGVmIHByb2MoKTo8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCBhc3luYyBk
ZWYgcHJvYygpOjxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBjIGluIGNo
dW5raWZ5KGpzb24uZHVtcHMobXNnKSwgc2VsZi5tYXhfY2h1bmspOjxicj4NCiZndDsgLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLndyaXRlci53cml0ZShjKTxicj4NCiZndDsg
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi53cml0ZXIuZmx1c2goKTxicj4NCiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLndyaXRlci53cml0ZShjLmVuY29kZSgm
cXVvdDt1dGYtOCZxdW90OykpPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhd2Fp
dCBzZWxmLndyaXRlci5kcmFpbigpPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbCA9IGdldF9saW5lKCk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGwgPSBhd2FpdCBnZXRfbGluZSgpPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG0gPSBqc29uLmxvYWRzKGwpPGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAmIzM5O2NodW5rLXN0cmVhbSYjMzk7IGluIG06PGJyPg0KJmd0OyArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAmcXVvdDtjaHVuay1zdHJlYW0mcXVvdDsgaW4gbTo8YnI+
DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmVzID0gW108YnI+DQom
Z3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlIFRydWU6PGJyPg0KJmd0
OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbCA9IGdldF9saW5lKCku
cnN0cmlwKCYjMzk7XG4mIzM5Oyk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBsID0gKGF3YWl0IGdldF9saW5lKCkpLnJzdHJpcCgmcXVvdDtcbiZxdW90
Oyk8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
bm90IGw6PGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbGluZXMuYXBwZW5kKGwpPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtID0ganNvbi5sb2FkcygmIzM5OyYjMzk7LmpvaW4obGlu
ZXMpKTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtID0ganNvbi5s
b2FkcygmcXVvdDsmcXVvdDsuam9pbihsaW5lcykpPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBtPGJyPg0KJmd0OyDCoDxicj4NCiZndDsgLcKg
wqDCoMKgwqDCoMKgIHJldHVybiBzZWxmLl9zZW5kX3dyYXBwZXIocHJvYyk8YnI+DQomZ3Q7ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gYXdhaXQgc2VsZi5fc2VuZF93cmFwcGVyKHByb2MpPGJyPg0K
Jmd0OyDCoDxicj4NCiZndDsgLcKgwqDCoCBkZWYgc2VuZF9zdHJlYW0oc2VsZiwgbXNnKTo8YnI+
DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCBkZWYgcHJvYygpOjxicj4NCiZndDsgLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc2VsZi53cml0ZXIud3JpdGUoJnF1b3Q7JXNcbiZxdW90OyAlIG1zZyk8YnI+
DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYud3JpdGVyLmZsdXNoKCk8YnI+DQom
Z3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGwgPSBzZWxmLnJlYWRlci5yZWFkbGluZSgpPGJy
Pg0KJmd0OyArwqDCoMKgIGFzeW5jIGRlZiBzZW5kX3N0cmVhbShzZWxmLCBtc2cpOjxicj4NCiZn
dDsgK8KgwqDCoMKgwqDCoMKgIGFzeW5jIGRlZiBwcm9jKCk6PGJyPg0KJmd0OyArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzZWxmLndyaXRlci53cml0ZSgoJnF1b3Q7JXNcbiZxdW90OyAlIG1zZyku
ZW5jb2RlKCZxdW90O3V0Zi04JnF1b3Q7KSk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGF3YWl0IHNlbGYud3JpdGVyLmRyYWluKCk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGwgPSBhd2FpdCBzZWxmLnJlYWRlci5yZWFkbGluZSgpPGJyPg0KJmd0OyDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IGw6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJhaXNlIEhhc2hDb25uZWN0aW9uRXJyb3IoJiMzOTtDb25uZWN0aW9uIGNs
b3NlZCYjMzk7KTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGwucnN0
cmlwKCk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFpc2UgSGFz
aENvbm5lY3Rpb25FcnJvcigmcXVvdDtDb25uZWN0aW9uIGNsb3NlZCZxdW90Oyk8YnI+DQomZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBsLmRlY29kZSgmcXVvdDt1dGYtOCZxdW90
OykucnN0cmlwKCk8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHNlbGYuX3NlbmRfd3JhcHBlcihwcm9jKTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIHJldHVy
biBhd2FpdCBzZWxmLl9zZW5kX3dyYXBwZXIocHJvYyk8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0OyAt
wqDCoMKgIGRlZiBfc2V0X21vZGUoc2VsZiwgbmV3X21vZGUpOjxicj4NCiZndDsgK8KgwqDCoCBh
c3luYyBkZWYgX3NldF9tb2RlKHNlbGYsIG5ld19tb2RlKTo8YnI+DQomZ3Q7IMKgwqDCoMKgwqDC
oMKgwqAgaWYgbmV3X21vZGUgPT0gc2VsZi5NT0RFX05PUk1BTCBhbmQgc2VsZi5tb2RlID09PGJy
Pg0KJmd0OyBzZWxmLk1PREVfR0VUX1NUUkVBTTo8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHIgPSBzZWxmLnNlbmRfc3RyZWFtKCYjMzk7RU5EJiMzOTspPGJyPg0KJmd0OyAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiByICE9ICYjMzk7b2smIzM5Ozo8YnI+DQomZ3Q7IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFpc2UgSGFzaENvbm5lY3Rpb25FcnJvcigmIzM5
O0JhZCByZXNwb25zZSBmcm9tIHNlcnZlcjxicj4NCiZndDsgJXImIzM5OyAlIHIpPGJyPg0KJmd0
OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0gYXdhaXQgc2VsZi5zZW5kX3N0cmVhbSgmcXVv
dDtFTkQmcXVvdDspPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiByICE9ICZx
dW90O29rJnF1b3Q7Ojxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
YWlzZSBIYXNoQ29ubmVjdGlvbkVycm9yKCZxdW90O0JhZCByZXNwb25zZSBmcm9tIHNlcnZlcjxi
cj4NCiZndDsgJXImcXVvdDsgJSByKTxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoCBlbGlmIG5l
d19tb2RlID09IHNlbGYuTU9ERV9HRVRfU1RSRUFNIGFuZCBzZWxmLm1vZGUgPT08YnI+DQomZ3Q7
IHNlbGYuTU9ERV9OT1JNQUw6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0g
c2VsZi5zZW5kX21lc3NhZ2UoeyYjMzk7Z2V0LXN0cmVhbSYjMzk7OiBOb25lfSk8YnI+DQomZ3Q7
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIHIgIT0gJiMzOTtvayYjMzk7Ojxicj4NCiZndDsg
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBIYXNoQ29ubmVjdGlvbkVycm9y
KCYjMzk7QmFkIHJlc3BvbnNlIGZyb20gc2VydmVyPGJyPg0KJmd0OyAlciYjMzk7ICUgcik8YnI+
DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSBhd2FpdCBzZWxmLnNlbmRfbWVzc2Fn
ZSh7JnF1b3Q7Z2V0LXN0cmVhbSZxdW90OzogTm9uZX0pPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiByICE9ICZxdW90O29rJnF1b3Q7Ojxicj4NCiZndDsgK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBIYXNoQ29ubmVjdGlvbkVycm9yKCZxdW90O0JhZCBy
ZXNwb25zZSBmcm9tIHNlcnZlcjxicj4NCiZndDsgJXImcXVvdDsgJSByKTxicj4NCiZndDsgwqDC
oMKgwqDCoMKgwqDCoCBlbGlmIG5ld19tb2RlICE9IHNlbGYubW9kZTo8YnI+DQomZ3Q7IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNlIEV4Y2VwdGlvbigmIzM5O1VuZGVmaW5lZCBtb2RlIHRy
YW5zaXRpb24gJXIgLSZndDsgJXImIzM5OyAlPGJyPg0KJmd0OyAoc2VsZi5tb2RlLCBuZXdfbW9k
ZSkpPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBFeGNlcHRpb24oPGJy
Pg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZxdW90O1VuZGVmaW5lZCBt
b2RlIHRyYW5zaXRpb24gJXIgLSZndDsgJXImcXVvdDsgJSAoc2VsZi5tb2RlLDxicj4NCiZndDsg
bmV3X21vZGUpPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCApPGJyPg0KJmd0OyDC
oDxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLm1vZGUgPSBuZXdfbW9kZTxicj4NCiZn
dDsgwqA8YnI+DQomZ3Q7IC3CoMKgwqAgZGVmIGdldF91bmloYXNoKHNlbGYsIG1ldGhvZCwgdGFz
a2hhc2gpOjxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgIHNlbGYuX3NldF9tb2RlKHNlbGYuTU9E
RV9HRVRfU1RSRUFNKTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgIHIgPSBzZWxmLnNlbmRfc3Ry
ZWFtKCYjMzk7JXMgJXMmIzM5OyAlIChtZXRob2QsIHRhc2toYXNoKSk8YnI+DQomZ3Q7ICvCoMKg
wqAgYXN5bmMgZGVmIGdldF91bmloYXNoKHNlbGYsIG1ldGhvZCwgdGFza2hhc2gpOjxicj4NCiZn
dDsgK8KgwqDCoMKgwqDCoMKgIGF3YWl0IHNlbGYuX3NldF9tb2RlKHNlbGYuTU9ERV9HRVRfU1RS
RUFNKTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIHIgPSBhd2FpdCBzZWxmLnNlbmRfc3RyZWFt
KCZxdW90OyVzICVzJnF1b3Q7ICUgKG1ldGhvZCwgdGFza2hhc2gpKTxicj4NCiZndDsgwqDCoMKg
wqDCoMKgwqDCoCBpZiBub3Qgcjo8YnI+DQomZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gTm9uZTxicj4NCiZndDsgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjxicj4NCiZndDsg
wqA8YnI+DQomZ3Q7IC3CoMKgwqAgZGVmIHJlcG9ydF91bmloYXNoKHNlbGYsIHRhc2toYXNoLCBt
ZXRob2QsIG91dGhhc2gsIHVuaWhhc2gsPGJyPg0KJmd0OyBleHRyYT17fSk6PGJyPg0KJmd0OyAt
wqDCoMKgwqDCoMKgwqAgc2VsZi5fc2V0X21vZGUoc2VsZi5NT0RFX05PUk1BTCk8YnI+DQomZ3Q7
ICvCoMKgwqAgYXN5bmMgZGVmIHJlcG9ydF91bmloYXNoKHNlbGYsIHRhc2toYXNoLCBtZXRob2Qs
IG91dGhhc2gsPGJyPg0KJmd0OyB1bmloYXNoLCBleHRyYT17fSk6PGJyPg0KJmd0OyArwqDCoMKg
wqDCoMKgwqAgYXdhaXQgc2VsZi5fc2V0X21vZGUoc2VsZi5NT0RFX05PUk1BTCk8YnI+DQomZ3Q7
IMKgwqDCoMKgwqDCoMKgwqAgbSA9IGV4dHJhLmNvcHkoKTxicj4NCiZndDsgLcKgwqDCoMKgwqDC
oMKgIG1bJiMzOTt0YXNraGFzaCYjMzk7XSA9IHRhc2toYXNoPGJyPg0KJmd0OyAtwqDCoMKgwqDC
oMKgwqAgbVsmIzM5O21ldGhvZCYjMzk7XSA9IG1ldGhvZDxicj4NCiZndDsgLcKgwqDCoMKgwqDC
oMKgIG1bJiMzOTtvdXRoYXNoJiMzOTtdID0gb3V0aGFzaDxicj4NCiZndDsgLcKgwqDCoMKgwqDC
oMKgIG1bJiMzOTt1bmloYXNoJiMzOTtdID0gdW5paGFzaDxicj4NCiZndDsgLcKgwqDCoMKgwqDC
oMKgIHJldHVybiBzZWxmLnNlbmRfbWVzc2FnZSh7JiMzOTtyZXBvcnQmIzM5OzogbX0pPGJyPg0K
Jmd0OyAtPGJyPg0KJmd0OyAtwqDCoMKgIGRlZiByZXBvcnRfdW5paGFzaF9lcXVpdihzZWxmLCB0
YXNraGFzaCwgbWV0aG9kLCB1bmloYXNoLDxicj4NCiZndDsgZXh0cmE9e30pOjxicj4NCiZndDsg
LcKgwqDCoMKgwqDCoMKgIHNlbGYuX3NldF9tb2RlKHNlbGYuTU9ERV9OT1JNQUwpPGJyPg0KJmd0
OyArwqDCoMKgwqDCoMKgwqAgbVsmcXVvdDt0YXNraGFzaCZxdW90O10gPSB0YXNraGFzaDxicj4N
CiZndDsgK8KgwqDCoMKgwqDCoMKgIG1bJnF1b3Q7bWV0aG9kJnF1b3Q7XSA9IG1ldGhvZDxicj4N
CiZndDsgK8KgwqDCoMKgwqDCoMKgIG1bJnF1b3Q7b3V0aGFzaCZxdW90O10gPSBvdXRoYXNoPGJy
Pg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgbVsmcXVvdDt1bmloYXNoJnF1b3Q7XSA9IHVuaWhhc2g8
YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gYXdhaXQgc2VsZi5zZW5kX21lc3NhZ2Uo
eyZxdW90O3JlcG9ydCZxdW90OzogbX0pPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqDCoMKgIGFz
eW5jIGRlZiByZXBvcnRfdW5paGFzaF9lcXVpdihzZWxmLCB0YXNraGFzaCwgbWV0aG9kLCB1bmlo
YXNoLDxicj4NCiZndDsgZXh0cmE9e30pOjxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIGF3YWl0
IHNlbGYuX3NldF9tb2RlKHNlbGYuTU9ERV9OT1JNQUwpPGJyPg0KJmd0OyDCoMKgwqDCoMKgwqDC
oMKgIG0gPSBleHRyYS5jb3B5KCk8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCBtWyYjMzk7dGFz
a2hhc2gmIzM5O10gPSB0YXNraGFzaDxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgIG1bJiMzOTtt
ZXRob2QmIzM5O10gPSBtZXRob2Q8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCBtWyYjMzk7dW5p
aGFzaCYjMzk7XSA9IHVuaWhhc2g8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gc2Vs
Zi5zZW5kX21lc3NhZ2UoeyYjMzk7cmVwb3J0LWVxdWl2JiMzOTs6IG19KTxicj4NCiZndDsgLTxi
cj4NCiZndDsgLcKgwqDCoCBkZWYgZ2V0X3Rhc2toYXNoKHNlbGYsIG1ldGhvZCwgdGFza2hhc2gs
IGFsbF9wcm9wZXJ0aWVzPUZhbHNlKTo8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCBzZWxmLl9z
ZXRfbW9kZShzZWxmLk1PREVfTk9STUFMKTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgIHJldHVy
biBzZWxmLnNlbmRfbWVzc2FnZSh7JiMzOTtnZXQmIzM5Ozogezxicj4NCiZndDsgLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgJiMzOTt0YXNraGFzaCYjMzk7OiB0YXNraGFzaCw8YnI+DQomZ3Q7IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICYjMzk7bWV0aG9kJiMzOTs6IG1ldGhvZCw8YnI+DQomZ3Q7
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICYjMzk7YWxsJiMzOTs6IGFsbF9wcm9wZXJ0aWVzPGJy
Pg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgfX0pPGJyPg0KJmd0OyAtPGJyPg0KJmd0OyAtwqDCoMKg
IGRlZiBnZXRfc3RhdHMoc2VsZik6PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqAgc2VsZi5fc2V0
X21vZGUoc2VsZi5NT0RFX05PUk1BTCk8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4g
c2VsZi5zZW5kX21lc3NhZ2UoeyYjMzk7Z2V0LXN0YXRzJiMzOTs6IE5vbmV9KTxicj4NCiZndDsg
LTxicj4NCiZndDsgLcKgwqDCoCBkZWYgcmVzZXRfc3RhdHMoc2VsZik6PGJyPg0KJmd0OyAtwqDC
oMKgwqDCoMKgwqAgc2VsZi5fc2V0X21vZGUoc2VsZi5NT0RFX05PUk1BTCk8YnI+DQomZ3Q7IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm4gc2VsZi5zZW5kX21lc3NhZ2UoeyYjMzk7cmVzZXQtc3RhdHMm
IzM5OzogTm9uZX0pPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgbVsmcXVvdDt0YXNraGFzaCZx
dW90O10gPSB0YXNraGFzaDxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIG1bJnF1b3Q7bWV0aG9k
JnF1b3Q7XSA9IG1ldGhvZDxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIG1bJnF1b3Q7dW5paGFz
aCZxdW90O10gPSB1bmloYXNoPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGF3YWl0
IHNlbGYuc2VuZF9tZXNzYWdlKHsmcXVvdDtyZXBvcnQtZXF1aXYmcXVvdDs6IG19KTxicj4NCiZn
dDsgKzxicj4NCiZndDsgK8KgwqDCoCBhc3luYyBkZWYgZ2V0X3Rhc2toYXNoKHNlbGYsIG1ldGhv
ZCwgdGFza2hhc2gsPGJyPg0KJmd0OyBhbGxfcHJvcGVydGllcz1GYWxzZSk6PGJyPg0KJmd0OyAr
wqDCoMKgwqDCoMKgwqAgYXdhaXQgc2VsZi5fc2V0X21vZGUoc2VsZi5NT0RFX05PUk1BTCk8YnI+
DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gYXdhaXQgc2VsZi5zZW5kX21lc3NhZ2UoPGJy
Pg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7JnF1b3Q7Z2V0JnF1b3Q7OiB7JnF1b3Q7
dGFza2hhc2gmcXVvdDs6IHRhc2toYXNoLCAmcXVvdDttZXRob2QmcXVvdDs6IG1ldGhvZCwgJnF1
b3Q7YWxsJnF1b3Q7Ojxicj4NCiZndDsgYWxsX3Byb3BlcnRpZXN9fTxicj4NCiZndDsgK8KgwqDC
oMKgwqDCoMKgICk8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoMKgwqAgYXN5bmMgZGVmIGdldF9z
dGF0cyhzZWxmKTo8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCBhd2FpdCBzZWxmLl9zZXRfbW9k
ZShzZWxmLk1PREVfTk9STUFMKTxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIHJldHVybiBhd2Fp
dCBzZWxmLnNlbmRfbWVzc2FnZSh7JnF1b3Q7Z2V0LXN0YXRzJnF1b3Q7OiBOb25lfSk8YnI+DQom
Z3Q7ICs8YnI+DQomZ3Q7ICvCoMKgwqAgYXN5bmMgZGVmIHJlc2V0X3N0YXRzKHNlbGYpOjxicj4N
CiZndDsgK8KgwqDCoMKgwqDCoMKgIGF3YWl0IHNlbGYuX3NldF9tb2RlKHNlbGYuTU9ERV9OT1JN
QUwpPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGF3YWl0IHNlbGYuc2VuZF9tZXNz
YWdlKHsmcXVvdDtyZXNldC1zdGF0cyZxdW90OzogTm9uZX0pPGJyPg0KJmd0OyArPGJyPg0KJmd0
OyArPGJyPg0KJmd0OyArY2xhc3MgQ2xpZW50KG9iamVjdCk6PGJyPg0KJmd0OyArwqDCoMKgIGRl
ZiBfX2luaXRfXyhzZWxmKTo8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudCA9
IEFzeW5jQ2xpZW50KCk8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmxvb3AgPSBhc3lu
Y2lvLm5ld19ldmVudF9sb29wKCk8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDC
oCBkZWYgZ2V0X3dyYXBwZXIoc2VsZiwgZG93bmNhbGwpOjxicj4NCiZndDsgK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGVmIHdyYXBwZXIoKmFyZ3MsICoqa3dhcmdzKTo8YnI+DQomZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNlbGYubG9vcC5ydW5fdW50aWxfY29t
cGxldGUoZG93bmNhbGwoKmFyZ3MsPGJyPg0KJmd0OyAqKmt3YXJncykpPGJyPg0KJmd0OyArPGJy
Pg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gd3JhcHBlcjxicj4NCiZndDsg
Kzxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgIGZvciBjYWxsIGluICg8YnI+DQomZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICZxdW90O2Nvbm5lY3RfdGNwJnF1b3Q7LDxicj4NCiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgJnF1b3Q7Y29ubmVjdF91bml4JnF1b3Q7LDxicj4NCiZndDsg
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnF1b3Q7Y2xvc2UmcXVvdDssPGJyPg0KJmd0OyArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmcXVvdDtnZXRfdW5paGFzaCZxdW90Oyw8YnI+DQomZ3Q7ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZxdW90O3JlcG9ydF91bmloYXNoJnF1b3Q7LDxicj4NCiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnF1b3Q7cmVwb3J0X3VuaWhhc2hfZXF1aXYmcXVv
dDssPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcXVvdDtnZXRfdGFza2hhc2gm
cXVvdDssPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcXVvdDtnZXRfc3RhdHMm
cXVvdDssPGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcXVvdDtyZXNldF9zdGF0
cyZxdW90Oyw8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoCApOjxicj4NCiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZG93bmNhbGwgPSBnZXRhdHRyKHNlbGYuY2xpZW50LCBjYWxsKTxicj4N
CiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0YXR0cihzZWxmLCBjYWxsLCBnZXRfd3Jh
cHBlcihzZWxmLCBkb3duY2FsbCkpPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqDCoMKgIEBwcm9w
ZXJ0eTxicj4NCiZndDsgK8KgwqDCoCBkZWYgbWF4X2NodW5rKHNlbGYpOjxicj4NCiZndDsgK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiBzZWxmLmNsaWVudC5tYXhfY2h1bms8YnI+DQomZ3Q7ICs8YnI+
DQomZ3Q7ICvCoMKgwqAgQG1heF9jaHVuay5zZXR0ZXI8YnI+DQomZ3Q7ICvCoMKgwqAgZGVmIG1h
eF9jaHVuayhzZWxmLCB2YWx1ZSk6PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqAgc2VsZi5jbGll
bnQubWF4X2NodW5rID0gdmFsdWU8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+
DQo8YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+
DQo=

--000000000000d087d005b5049818--
