Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web08.174.1627059920144163484
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jul 2021 10:05:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kpXBBi+b;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id x3so2006304qkl.6
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jul 2021 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=G6z7IZffILUH8L7eJDSXrQIhGgaGRfST493d9sucuoE=;
        b=kpXBBi+bOKLbly0oOiZm8fuGfrIs9MZiAGlKccdIOONMJhnIb0wkj1Kpvvk9KADxC/
         rdlQB107PQfNSSrXRgTddPY4QiIgUtTvcTIrHsjBYcXeRqZxMX+QkkLsMaNSMh7/tPA/
         ELi2MZpBIXlGbC/dcByF4IbkX2LQQ7dqrNbb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=G6z7IZffILUH8L7eJDSXrQIhGgaGRfST493d9sucuoE=;
        b=uBgrQ5d7Olhj/tFsr/D7b5ZeowhLoVLN/oWY8uZidAxg51jG77IS7QGYpFMYkZMtlH
         h187L909AWtG1a+1pFEChoHaxqbmKuVp8X/2K0JV/wiOuiIXrsV9zsgi/XcUcfQXADW6
         7D61FQ1MetWq7pXqc0HKofF6Tc+1TeLSlnUwwPf6K3xhOSweuzV3mwCOSbP08XIjyK0Z
         4XOsbY2azzD3A32xHGVlyOla4IMGfkPrHWeiwqinr4L9Ttaq5Y26URhsI8wqQ7qDRS4t
         P0uCQx3H2yqFKg17BwAXkqqF4D/IXez6aU6tj6ygqJHuyH7XQZDWPYE3IhrBvlR1eE2+
         SQqA==
X-Gm-Message-State: AOAM5300OA73h+swtIhEmeE037ydKrVWY/QN/GbOfzXlOxPFJBLQJ+tP
	zG8vl/7auRrLOYsQ3V1xHDAsfg==
X-Google-Smtp-Source: ABdhPJwpIZBKF/P6aA0WMS7USJQxzK2PsLBXejnfaGKQSj4tdGkvvrIsU7JNMDjpUms2UXGZcBFqHA==
X-Received: by 2002:a37:f510:: with SMTP id l16mr5518638qkk.205.1627059919113;
        Fri, 23 Jul 2021 10:05:19 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id i21sm10953257qtw.68.2021.07.23.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:05:18 -0700 (PDT)
Date: Fri, 23 Jul 2021 13:05:17 -0400 (EDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Subject: Re: [bitbake-devel][PATCH] bitbake: asyncrpc: Catch early SIGTERM
In-Reply-To: <20210722161937.4880-1-JPEWhacker@gmail.com>
Message-ID: <3446612c-bb76-3454-4e8a-e3e15b6ee494@spiteful.org>
References: <20210722161937.4880-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Jul 2021, Joshua Watt wrote:

> If the SIGTERM signal is sent to an asyncrpc server before it has
> installed the SIGTERM handler in the main loop, it may miss the signal
> which will can cause the calling process to wait forever on the join().
> To resolve this, the calling process should mask of SIGTERM before
> forking the server process and the server should unmask the signal only
> after the handler is installed. To simplify the usage of the server, an
> new helper function called serve_as_process() is added to do this
> automatically and correctly.
>
> Thanks: Scott Murray <scott.murray@konsulko.com> for helping debug
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

I did some runs of parallelized oe-selftest with stock poky (so hash equiv
server in auto mode) with this change added, and it did clear up the test
failures I was previously seeing from stuck bitbake-server processes, so
also:

Tested-by: Scott Murray <scott.murray@konsulko.com>

I'm going to rebase the PR server rework on top and do some test runs.

> ---
>  bitbake/lib/bb/asyncrpc/serv.py | 21 +++++++++++++
>  bitbake/lib/bb/cooker.py        |  3 +-
>  bitbake/lib/hashserv/tests.py   | 54 +++++++++++++++++++++++++--------
>  3 files changed, 64 insertions(+), 14 deletions(-)
>
> diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
> index ef20cb71df..4084f300df 100644
> --- a/bitbake/lib/bb/asyncrpc/serv.py
> +++ b/bitbake/lib/bb/asyncrpc/serv.py
> @@ -9,6 +9,7 @@ import os
>  import signal
>  import socket
>  import sys
> +import multiprocessing
>  from . import chunkify, DEFAULT_MAX_CHUNK
>
>
> @@ -201,12 +202,14 @@ class AsyncServer(object):
>              pass
>
>      def signal_handler(self):
> +        self.logger.debug("Got exit signal")
>          self.loop.stop()
>
>      def serve_forever(self):
>          asyncio.set_event_loop(self.loop)
>          try:
>              self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
> +            signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
>
>              self.run_loop_forever()
>              self.server.close()
> @@ -221,3 +224,21 @@ class AsyncServer(object):
>
>              if self._cleanup_socket is not None:
>                  self._cleanup_socket()
> +
> +    def serve_as_process(self, *, prefunc=None, args=()):
> +        def run():
> +            if prefunc is not None:
> +                prefunc(self, *args)
> +            self.serve_forever()
> +
> +        # Temporarily block SIGTERM. The server process will inherit this
> +        # block which will ensure it doesn't receive the SIGTERM until the
> +        # handler is ready for it
> +        mask = signal.pthread_sigmask(signal.SIG_BLOCK, [signal.SIGTERM])
> +        try:
> +            self.process = multiprocessing.Process(target=run)
> +            self.process.start()
> +
> +            return self.process
> +        finally:
> +            signal.pthread_sigmask(signal.SIG_SETMASK, mask)
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 39e10e6133..b2d69c28cf 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -390,8 +390,7 @@ class BBCooker:
>                  dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
>                  self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
>                  self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
> -                self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
> -                self.hashserv.process.start()
> +                self.hashserv.serve_as_process()
>              self.data.setVar("BB_HASHSERVE", self.hashservaddr)
>              self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
>              self.databuilder.data.setVar("BB_HASHSERVE", self.hashservaddr)
> diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
> index e2b762dbf0..e851535c59 100644
> --- a/bitbake/lib/hashserv/tests.py
> +++ b/bitbake/lib/hashserv/tests.py
> @@ -15,28 +15,32 @@ import tempfile
>  import threading
>  import unittest
>  import socket
> +import time
> +import signal
>
> -def _run_server(server, idx):
> -    # logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
> -    #                     format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
> +def server_prefunc(server, idx):
> +    logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
> +                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
> +    server.logger.debug("Running server %d" % idx)
>      sys.stdout = open('bbhashserv-%d.log' % idx, 'w')
>      sys.stderr = sys.stdout
> -    server.serve_forever()
> -
>
>  class HashEquivalenceTestSetup(object):
>      METHOD = 'TestMethod'
>
>      server_index = 0
>
> -    def start_server(self, dbpath=None, upstream=None, read_only=False):
> +    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc):
>          self.server_index += 1
>          if dbpath is None:
>              dbpath = os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
>
> -        def cleanup_thread(thread):
> -            thread.terminate()
> -            thread.join()
> +        def cleanup_server(server):
> +            if server.process.exitcode is not None:
> +                return
> +
> +            server.process.terminate()
> +            server.process.join()
>
>          server = create_server(self.get_server_addr(self.server_index),
>                                 dbpath,
> @@ -44,9 +48,8 @@ class HashEquivalenceTestSetup(object):
>                                 read_only=read_only)
>          server.dbpath = dbpath
>
> -        server.thread = multiprocessing.Process(target=_run_server, args=(server, self.server_index))
> -        server.thread.start()
> -        self.addCleanup(cleanup_thread, server.thread)
> +        server.serve_as_process(prefunc=prefunc, args=(self.server_index,))
> +        self.addCleanup(cleanup_server, server)
>
>          def cleanup_client(client):
>              client.close()
> @@ -283,6 +286,33 @@ class HashEquivalenceCommonTests(object):
>          self.assertClientGetHash(self.client, taskhash2, None)
>
>
> +    def test_slow_server_start(self):
> +        """
> +        Ensures that the server will exit correctly even if it gets a SIGTERM
> +        before entering the main loop
> +        """
> +
> +        event = multiprocessing.Event()
> +
> +        def prefunc(server, idx):
> +            nonlocal event
> +            server_prefunc(server, idx)
> +            event.wait()
> +
> +        def do_nothing(signum, frame):
> +            pass
> +
> +        old_signal = signal.signal(signal.SIGTERM, do_nothing)
> +        self.addCleanup(signal.signal, signal.SIGTERM, old_signal)
> +
> +        _, server = self.start_server(prefunc=prefunc)
> +        server.process.terminate()
> +        time.sleep(30)
> +        event.set()
> +        server.process.join(300)
> +        self.assertIsNotNone(server.process.exitcode, "Server did not exit in a timely manner!")
> +
> +
>  class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
>      def get_server_addr(self, server_idx):
>          return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
>
