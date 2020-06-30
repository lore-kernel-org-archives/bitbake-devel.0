Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
 by mx.groups.io with SMTP id smtpd.web11.16083.1593525942103737706
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jun 2020 07:05:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=zNJnA8Vq;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.65, mailfrom: steve@sakoman.com)
Received: by mail-ed1-f65.google.com with SMTP id n2so7322078edr.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2020 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKpshXCIMBRw2ZgpZ9muDctD5nvGHLnHgt7lon1YZiU=;
        b=zNJnA8VqCqthosIx36kHcDhKVc2mAdtnf7OKEMccMWJzOBKJ7f6bPqYIYzDIVjqxAg
         YikJtFIRgJ3gGVl+lOUl897t6MWWoMWfBaEVOvlX+V8CGKgAoZdF7ToJ5xFJQkpw2Mdh
         5+6hhpaSvCtrPhcDKVsPqGrzyn61GVsaNiIcmMV3Aq8cG2tdu6ZPtZ9XE5JThloFhqou
         Fp+Vdda3foQhKUGVYMTfJqOjvcsxFfGElaqosnbfXCwXm+kIqm/ttkChp5zLGILv9HpT
         MOIgJpsoF8FUGfxxImpJMthFpn/tgsaEP6wlCGcVbGqgWMIC0MHjeUXsBw30TuT/ur/9
         EeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKpshXCIMBRw2ZgpZ9muDctD5nvGHLnHgt7lon1YZiU=;
        b=ucWnabNY18xxI/j+h9aW/CK3gbYbJvKqDSfX03CCok1X6X8IERvJ9y7B0EWCKZQRFI
         GnncI1oartJ7Q73MWLUqD4FCFq5nH3YO3QoKdoZ8yiveZ7FLnu76UL8TIfLNWIlBs0n7
         6M4P2wDCa/BsxAaAURpNEFqAkcLp4LKajsh+JXSXc1kVmDZGTaq69BmQHgZBsdrIN0JF
         QwQkQPiVvr/KaNW7HQ+mBfrhaA8PKxOF5v7iJpIJUzwhq4SpRejaalnVM6AJfHAAW0LQ
         OCdVPY8R1unLH1ah7zsy2EjR4ifXLUY+VLgZ9oZvZMfD1iDzTOFbPqaEZUQjYrR6qCsc
         RvNQ==
X-Gm-Message-State: AOAM532wXQhEmrKrErJRtOZBHgIRzC23mAjda8W1gPF19N3SwEnlKU0g
	GpkKkm9e+PP7Io1xeQ755lEuLnRHk3J2yvnuov3QgA==
X-Google-Smtp-Source: ABdhPJz7Yn8Vf5dLgZ2HL6yXyEf495xez6YuP39icfMkqJisuQd1l4JzfvrdVbtzYlWOo0dpxG0CXbDc0qG+F4Px13A=
X-Received: by 2002:a50:d7c1:: with SMTP id m1mr23666143edj.217.1593525940139;
 Tue, 30 Jun 2020 07:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593486375.git.steve@sakoman.com> <224ed6abbfa7b9c2d968fbbb75cc0dc6a3129813.1593486375.git.steve@sakoman.com>
 <CAM9ZRVvTyP3r6+JewPfpPiYAKrFBZcZxk9pOZebyb0ygcxaLfQ@mail.gmail.com>
In-Reply-To: <CAM9ZRVvTyP3r6+JewPfpPiYAKrFBZcZxk9pOZebyb0ygcxaLfQ@mail.gmail.com>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Tue, 30 Jun 2020 04:05:27 -1000
Message-ID: <CAOSpxdbcn+-gV8E+WT4KwkwrScPS42topwthkMRQ0U3chViHcQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 3/6] hashserv: Chunkify large messages
To: Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 30, 2020 at 3:33 AM Paul Barker <pbarker@konsulko.com> wrote:
>
> On Tue, 30 Jun 2020 at 04:09, Steve Sakoman <steve@sakoman.com> wrote:
> >
> > From: Joshua Watt <JPEWhacker@gmail.com>
> >
> > The hash equivalence client and server can occasionally send messages
> > that are too large for the server to fit in the receive buffer (64 KB).
> > To prevent this, support is added to the protocol to "chunkify" the
> > stream and break it up into manageable pieces that the server can each
> > side can back together.
> >
> > Ideally, this would be negotiated by the client and server, but it's
> > currently hard coded to 32 KB to prevent the round-trip delay.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (cherry picked from commit e27a28c1e40e886ee68ba4b99b537ffc9c3577d4)
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > ---
> >  lib/hashserv/__init__.py |  22 ++++++++
> >  lib/hashserv/client.py   |  43 +++++++++++++---
> >  lib/hashserv/server.py   | 105 +++++++++++++++++++++++++++------------
> >  lib/hashserv/tests.py    |  23 +++++++++
> >  4 files changed, 152 insertions(+), 41 deletions(-)
> >
> > diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
> > index c3318620..f95e8f43 100644
> > --- a/lib/hashserv/__init__.py
> > +++ b/lib/hashserv/__init__.py
> > @@ -6,12 +6,20 @@
> >  from contextlib import closing
> >  import re
> >  import sqlite3
> > +import itertools
> > +import json
> >
> >  UNIX_PREFIX = "unix://"
> >
> >  ADDR_TYPE_UNIX = 0
> >  ADDR_TYPE_TCP = 1
> >
> > +# The Python async server defaults to a 64K receive buffer, so we hardcode our
> > +# maximum chunk size. It would be better if the client and server reported to
> > +# each other what the maximum chunk sizes were, but that will slow down the
> > +# connection setup with a round trip delay so I'd rather not do that unless it
> > +# is necessary
> > +DEFAULT_MAX_CHUNK = 32 * 1024
> >
> >  def setup_database(database, sync=True):
> >      db = sqlite3.connect(database)
> > @@ -66,6 +74,20 @@ def parse_address(addr):
> >          return (ADDR_TYPE_TCP, (host, int(port)))
> >
> >
> > +def chunkify(msg, max_chunk):
> > +    if len(msg) < max_chunk - 1:
> > +        yield ''.join((msg, "\n"))
> > +    else:
> > +        yield ''.join((json.dumps({
> > +                'chunk-stream': None
> > +            }), "\n"))
> > +
> > +        args = [iter(msg)] * (max_chunk - 1)
> > +        for m in map(''.join, itertools.zip_longest(*args, fillvalue='')):
> > +            yield ''.join(itertools.chain(m, "\n"))
> > +        yield "\n"
> > +
> > +
> >  def create_server(addr, dbname, *, sync=True):
> >      from . import server
> >      db = setup_database(dbname, sync=sync)
> > diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> > index 46085d64..a29af836 100644
> > --- a/lib/hashserv/client.py
> > +++ b/lib/hashserv/client.py
> > @@ -7,6 +7,7 @@ import json
> >  import logging
> >  import socket
> >  import os
> > +from . import chunkify, DEFAULT_MAX_CHUNK
> >
> >
> >  logger = logging.getLogger('hashserv.client')
> > @@ -25,6 +26,7 @@ class Client(object):
> >          self.reader = None
> >          self.writer = None
> >          self.mode = self.MODE_NORMAL
> > +        self.max_chunk = DEFAULT_MAX_CHUNK
> >
> >      def connect_tcp(self, address, port):
> >          def connect_sock():
> > @@ -58,7 +60,7 @@ class Client(object):
> >              self.reader = self._socket.makefile('r', encoding='utf-8')
> >              self.writer = self._socket.makefile('w', encoding='utf-8')
> >
> > -            self.writer.write('OEHASHEQUIV 1.0\n\n')
> > +            self.writer.write('OEHASHEQUIV 1.1\n\n')
> >              self.writer.flush()
> >
> >              # Restore mode if the socket is being re-created
> > @@ -91,18 +93,35 @@ class Client(object):
> >                  count += 1
> >
> >      def send_message(self, msg):
> > +        def get_line():
> > +            line = self.reader.readline()
> > +            if not line:
> > +                raise HashConnectionError('Connection closed')
> > +
> > +            if not line.endswith('\n'):
> > +                raise HashConnectionError('Bad message %r' % message)
> > +
> > +            return line
> > +
> >          def proc():
> > -            self.writer.write('%s\n' % json.dumps(msg))
> > +            for c in chunkify(json.dumps(msg), self.max_chunk):
> > +                self.writer.write(c)
> >              self.writer.flush()
> >
> > -            l = self.reader.readline()
> > -            if not l:
> > -                raise HashConnectionError('Connection closed')
> > +            l = get_line()
> >
> > -            if not l.endswith('\n'):
> > -                raise HashConnectionError('Bad message %r' % message)
> > +            m = json.loads(l)
> > +            if 'chunk-stream' in m:
> > +                lines = []
> > +                while True:
> > +                    l = get_line().rstrip('\n')
> > +                    if not l:
> > +                        break
> > +                    lines.append(l)
> >
> > -            return json.loads(l)
> > +                m = json.loads(''.join(lines))
> > +
> > +            return m
> >
> >          return self._send_wrapper(proc)
> >
> > @@ -155,6 +174,14 @@ class Client(object):
> >          m['unihash'] = unihash
> >          return self.send_message({'report-equiv': m})
> >
> > +    def get_taskhash(self, method, taskhash, all_properties=False):
> > +        self._set_mode(self.MODE_NORMAL)
> > +        return self.send_message({'get': {
> > +            'taskhash': taskhash,
> > +            'method': method,
> > +            'all': all_properties
> > +        }})
> > +
> >      def get_stats(self):
> >          self._set_mode(self.MODE_NORMAL)
> >          return self.send_message({'get-stats': None})
> > diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> > index cc7e4823..81050715 100644
> > --- a/lib/hashserv/server.py
> > +++ b/lib/hashserv/server.py
> > @@ -13,6 +13,7 @@ import os
> >  import signal
> >  import socket
> >  import time
> > +from . import chunkify, DEFAULT_MAX_CHUNK
> >
> >  logger = logging.getLogger('hashserv.server')
> >
> > @@ -107,12 +108,29 @@ class Stats(object):
> >          return {k: getattr(self, k) for k in ('num', 'total_time', 'max_time', 'average', 'stdev')}
> >
> >
> > +class ClientError(Exception):
> > +    pass
> > +
> >  class ServerClient(object):
> > +    FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
> > +    ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
> > +
> >      def __init__(self, reader, writer, db, request_stats):
> >          self.reader = reader
> >          self.writer = writer
> >          self.db = db
> >          self.request_stats = request_stats
> > +        self.max_chunk = DEFAULT_MAX_CHUNK
> > +
> > +        self.handlers = {
> > +            'get': self.handle_get,
> > +            'report': self.handle_report,
> > +            'report-equiv': self.handle_equivreport,
> > +            'get-stream': self.handle_get_stream,
> > +            'get-stats': self.handle_get_stats,
> > +            'reset-stats': self.handle_reset_stats,
> > +            'chunk-stream': self.handle_chunk,
> > +        }
> >
> >      async def process_requests(self):
> >          try:
> > @@ -125,7 +143,11 @@ class ServerClient(object):
> >                  return
> >
> >              (proto_name, proto_version) = protocol.decode('utf-8').rstrip().split()
> > -            if proto_name != 'OEHASHEQUIV' or proto_version != '1.0':
> > +            if proto_name != 'OEHASHEQUIV':
> > +                return
> > +
> > +            proto_version = tuple(int(v) for v in proto_version.split('.'))
> > +            if proto_version < (1, 0) or proto_version > (1, 1):
> >                  return
> >
> >              # Read headers. Currently, no headers are implemented, so look for
> > @@ -140,40 +162,34 @@ class ServerClient(object):
> >                      break
> >
> >              # Handle messages
> > -            handlers = {
> > -                'get': self.handle_get,
> > -                'report': self.handle_report,
> > -                'report-equiv': self.handle_equivreport,
> > -                'get-stream': self.handle_get_stream,
> > -                'get-stats': self.handle_get_stats,
> > -                'reset-stats': self.handle_reset_stats,
> > -            }
> > -
> >              while True:
> >                  d = await self.read_message()
> >                  if d is None:
> >                      break
> > -
> > -                for k in handlers.keys():
> > -                    if k in d:
> > -                        logger.debug('Handling %s' % k)
> > -                        if 'stream' in k:
> > -                            await handlers[k](d[k])
> > -                        else:
> > -                            with self.request_stats.start_sample() as self.request_sample, \
> > -                                    self.request_sample.measure():
> > -                                await handlers[k](d[k])
> > -                        break
> > -                else:
> > -                    logger.warning("Unrecognized command %r" % d)
> > -                    break
> > -
> > +                await self.dispatch_message(d)
> >                  await self.writer.drain()
> > +        except ClientError as e:
> > +            logger.error(str(e))
> >          finally:
> >              self.writer.close()
> >
> > +    async def dispatch_message(self, msg):
> > +        for k in self.handlers.keys():
> > +            if k in msg:
> > +                logger.debug('Handling %s' % k)
> > +                if 'stream' in k:
> > +                    await self.handlers[k](msg[k])
> > +                else:
> > +                    with self.request_stats.start_sample() as self.request_sample, \
> > +                            self.request_sample.measure():
> > +                        await self.handlers[k](msg[k])
> > +                return
> > +
> > +        raise ClientError("Unrecognized command %r" % msg)
> > +
> >      def write_message(self, msg):
> > -        self.writer.write(('%s\n' % json.dumps(msg)).encode('utf-8'))
> > +        for c in chunkify(json.dumps(msg), self.max_chunk):
> > +            self.writer.write(c.encode('utf-8'))
> >
> >      async def read_message(self):
> >          l = await self.reader.readline()
> > @@ -191,14 +207,38 @@ class ServerClient(object):
> >              logger.error('Bad message from client: %r' % message)
> >              raise e
> >
> > +    async def handle_chunk(self, request):
> > +        lines = []
> > +        try:
> > +            while True:
> > +                l = await self.reader.readline()
> > +                l = l.rstrip(b"\n").decode("utf-8")
> > +                if not l:
> > +                    break
> > +                lines.append(l)
> > +
> > +            msg = json.loads(''.join(lines))
> > +        except (json.JSONDecodeError, UnicodeDecodeError) as e:
> > +            logger.error('Bad message from client: %r' % message)
> > +            raise e
> > +
> > +        if 'chunk-stream' in msg:
> > +            raise ClientError("Nested chunks are not allowed")
> > +
> > +        await self.dispatch_message(msg)
> > +
> >      async def handle_get(self, request):
> >          method = request['method']
> >          taskhash = request['taskhash']
> >
> > -        row = self.query_equivalent(method, taskhash)
> > +        if request.get('all', False):
> > +            row = self.query_equivalent(method, taskhash, self.ALL_QUERY)
> > +        else:
> > +            row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
> > +
> >          if row is not None:
> >              logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
> > -            d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
> > +            d = {k: row[k] for k in row.keys()}
> >
> >              self.write_message(d)
> >          else:
> > @@ -228,7 +268,7 @@ class ServerClient(object):
> >
> >                  (method, taskhash) = l.split()
> >                  #logger.debug('Looking up %s %s' % (method, taskhash))
> > -                row = self.query_equivalent(method, taskhash)
> > +                row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
> >                  if row is not None:
> >                      msg = ('%s\n' % row['unihash']).encode('utf-8')
> >                      #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
> > @@ -328,7 +368,7 @@ class ServerClient(object):
> >              # Fetch the unihash that will be reported for the taskhash. If the
> >              # unihash matches, it means this row was inserted (or the mapping
> >              # was already valid)
> > -            row = self.query_equivalent(data['method'], data['taskhash'])
> > +            row = self.query_equivalent(data['method'], data['taskhash'], self.FAST_QUERY)
> >
> >              if row['unihash'] == data['unihash']:
> >                  logger.info('Adding taskhash equivalence for %s with unihash %s',
> > @@ -354,12 +394,11 @@ class ServerClient(object):
> >          self.request_stats.reset()
> >          self.write_message(d)
> >
> > -    def query_equivalent(self, method, taskhash):
> > +    def query_equivalent(self, method, taskhash, query):
> >          # This is part of the inner loop and must be as fast as possible
> >          try:
> >              cursor = self.db.cursor()
> > -            cursor.execute('SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
> > -                           {'method': method, 'taskhash': taskhash})
> > +            cursor.execute(query, {'method': method, 'taskhash': taskhash})
> >              return cursor.fetchone()
> >          except:
> >              cursor.close()
> > diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
> > index a5472a99..6e862950 100644
> > --- a/lib/hashserv/tests.py
> > +++ b/lib/hashserv/tests.py
> > @@ -99,6 +99,29 @@ class TestHashEquivalenceServer(object):
> >          result = self.client.get_unihash(self.METHOD, taskhash)
> >          self.assertEqual(result, unihash)
> >
> > +    def test_huge_message(self):
> > +        # Simple test that hashes can be created
> > +        taskhash = 'c665584ee6817aa99edfc77a44dd853828279370'
> > +        outhash = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
> > +        unihash = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
> > +
> > +        result = self.client.get_unihash(self.METHOD, taskhash)
> > +        self.assertIsNone(result, msg='Found unexpected task, %r' % result)
> > +
> > +        siginfo = "0" * (self.client.max_chunk * 4)
> > +
> > +        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash, {
> > +            'outhash_siginfo': siginfo
> > +        })
> > +        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
> > +
> > +        result = self.client.get_taskhash(self.METHOD, taskhash, True)
> > +        self.assertEqual(result['taskhash'], taskhash)
> > +        self.assertEqual(result['unihash'], unihash)
> > +        self.assertEqual(result['method'], self.METHOD)
> > +        self.assertEqual(result['outhash'], outhash)
> > +        self.assertEqual(result['outhash_siginfo'], siginfo)
> > +
> >      def test_stress(self):
> >          def query_server(failures):
> >              client = Client(self.server.address)
> > --
> > 2.17.1
>
> My understanding of
> https://lists.openembedded.org/g/bitbake-devel/message/11453 is that
> this isn't suitable for backporting to the LTS. I may be wrong though,
> probably worth getting confirmation from Joshua or Richard (Cc'd).

Richard was the one who suggested I take this patch, but definitely
worth getting confirmation!

Steve
