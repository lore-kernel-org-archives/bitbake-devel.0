Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7641EC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 08:31:31 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.3398.1718267489515678676
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jun 2024 01:31:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l9bzCmPz;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso664222a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Jun 2024 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718267488; x=1718872288; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ZZlpJ1jnXZLMq38PCsa91WaVVKDQLo1ZN09SxV70s=;
        b=l9bzCmPznK5BlA3oCfbWyLOukxgFsTrQHvYYbkLQHNvWKc4pHTDmAyiTwpL2nzA+Yq
         hg9QFGsUVQ9NIobv+gQ7qhTcU6RphxTWTkkHkcM+Mwn3WZ8s8xAwiHi3gugBRdjLXhKM
         2xEILPMoJPVqRYMDpiD/wD+d6fhdPmaaekD+VbrtREOv9RPaNB2FQOZA+tWxKpDoxJ5V
         w7eSIa9Iez5e6XyGHAMu33M4QslnAsui4QBdnJYQs6mZu2pSm5d09hbEORRjYoTl+uRT
         oNR8StiKJTOn8rnrRazgNqvfD9A3arX9aM6xQyqkS4HWNlTov73qy+++TDomYQHtiNa5
         InPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267488; x=1718872288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8ZZlpJ1jnXZLMq38PCsa91WaVVKDQLo1ZN09SxV70s=;
        b=GNf0Kzb6Su4sC+Ob/aW02HY1MT8MxwEAbR8XD1D6bbKIziD8PI1OyXcbjzpQwBthfc
         0N2obl809BJOJ3tFU0Z/nc87mNgM2Fxm4KOZcjvnVMYcID7HYMzGQEHY3n2nN6CrsjSJ
         a+uTN8jhYfpuU4Ig0PdZnvfnaRR4FKioliXCEdsGCgNoLFo10X39jEw8dvyJoORJlNAg
         rNGBcucz2HLvEQbWl2+AiGGMl3wgc5TaqDj2Uhgd9xsQ0sRys//XDDamoUUUvOacXnxR
         12hRK0pQn5A2l3BDusqYL8zOTCkk6lncd+QGHzus3PlRXBQPrzbUmr2RRCb1ja94LrBt
         jEzg==
X-Gm-Message-State: AOJu0YwrA2BrKE+bCZlUX8ZsSZFGZoiS0441QQamNfM/i1couUjLOX/+
	P/piWqGkXXcDLYMh+5Td4yB2CET+R25sqtN2YUlrorVnOhaIH/5AL6Uhtw==
X-Google-Smtp-Source: AGHT+IGvnjYBEnDiTrp+ULMRPTiPiApEhBxS6AMWbKqjW+ArulFPBf4tLzTv3Bnngo1nkISk8VeMuQ==
X-Received: by 2002:a17:906:6a02:b0:a5a:1562:518c with SMTP id a640c23a62f3a-a6f47d56e31mr334528166b.48.1718267487275;
        Thu, 13 Jun 2024 01:31:27 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42801sm46491566b.166.2024.06.13.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:31:26 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [RFC][PATCH] siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes
Date: Thu, 13 Jun 2024 10:31:16 +0200
Message-ID: <20240613083116.2554617-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jun 2024 08:31:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16355

* avoids long trace when BB_HASHSERVE points to non-existent socket
  file, e.g.:
  BB_HASHSERVE = "unix:///OE/no-socket.sock"
  or when running the build before starting the bin/bitbake-hashserv.

* now it shows just warnings like it did in kirkstone
  many of them, e.g. 6 just for rebuilding zlib-native, but better than long trace

  for nonexistent socket file:
  WARNING: zlib-native-1.3.1-r0 do_create_spdx: Error contacting Hash Equivalence Server unix:///OE/no-socket.sock: [Errno 2] No such file or directory
  for existing file, but before starting bin/bitbake-hashserv:
  WARNING: zlib-native-1.3.1-r0 do_create_spdx: Error contacting Hash Equivalence Server unix:///OE/hashserv.sock: [Errno 111] Connection refused

ERROR: An uncaught exception occurred in runqueue###############################################################                                                                                                               | ETA:  0:00:00
Traceback (most recent call last):
  File "/OE/build/oe-core/bitbake/lib/hashserv/__init__.py", line 80, in create_client(addr='unix:///OE/no-socket.sock', username=None, password=None):
             if typ == ADDR_TYPE_UNIX:
    >            c.connect_unix(*a)
             elif typ == ADDR_TYPE_WS:
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 241, in Client.connect_unix(path='/OE/no-socket.sock'):
             self.loop.run_until_complete(self.client.connect_unix(path))
    >        self.loop.run_until_complete(self.client.connect())

  File "/usr/lib/python3.12/asyncio/base_events.py", line 687, in _UnixSelectorEventLoop.run_until_complete(future=<Task finished name='Task-6' coro=<AsyncClient.connect() done, defined at /OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.
py:150> exception=FileNotFoundError(2, 'No such file or directory')>):

    >        return future.result()

  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 152, in AsyncClient.connect():
             if self.socket is None:
    >            self.socket = await self._connect_sock()
                 await self.setup_connection()
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 85, in connect_sock:
                     sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)
    >                sock.connect(os.path.basename(path))
                 finally:
FileNotFoundError: [Errno 2] No such file or directory

ERROR: Running idle function
Traceback (most recent call last):
  File "/OE/build/oe-core/bitbake/lib/hashserv/__init__.py", line 80, in create_client(addr='unix:///OE/no-socket.sock', username=None, password=None):
             if typ == ADDR_TYPE_UNIX:
    >            c.connect_unix(*a)
             elif typ == ADDR_TYPE_WS:
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 241, in Client.connect_unix(path='/OE/no-socket.sock'):
             self.loop.run_until_complete(self.client.connect_unix(path))
    >        self.loop.run_until_complete(self.client.connect())

  File "/usr/lib/python3.12/asyncio/base_events.py", line 687, in _UnixSelectorEventLoop.run_until_complete(future=<Task finished name='Task-6' coro=<AsyncClient.connect() done, defined at /OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.
py:150> exception=FileNotFoundError(2, 'No such file or directory')>):

    >        return future.result()

  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 152, in AsyncClient.connect():
             if self.socket is None:
    >            self.socket = await self._connect_sock()
                 await self.setup_connection()
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 85, in connect_sock:
                     sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)
    >                sock.connect(os.path.basename(path))
                 finally:
FileNotFoundError: [Errno 2] No such file or directory

Summary: There were 2 ERROR messages, returning a non-zero exit code.

1605616 09:29:05.369352 Parse cache valid
1605616 09:30:14.500863 Registering idle function <function BBCooker.buildTargets.<locals>.buildTargetsIdle at 0x7f43988c09a0>
1605616 09:30:14.500927 Removing idle function <bound method Command.runAsyncCommand of <bb.command.Command object at 0x7f43a961c350>>
1605616 09:30:14.573274 Exception Traceback (most recent call last):
  File "/OE/build/oe-core/bitbake/lib/bb/server/process.py", line 435, in idle_thread_internal
    retval = function(self, data, False)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1487, in buildTargetsIdle
    retval = rq.execute_runqueue()
             ^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/runqueue.py", line 1651, in execute_runqueue
    return self._execute_runqueue()
           ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/runqueue.py", line 1567, in _execute_runqueue
    if self.rqdata.prepare() == 0:
       ^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/runqueue.py", line 1290, in prepare
    unihashes = bb.parse.siggen.get_unihashes(ready)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/siggen.py", line 713, in get_unihashes
    with self.client() as client:
  File "/usr/lib/python3.12/contextlib.py", line 137, in __enter__
    return next(self.gen)
           ^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/siggen.py", line 595, in client
    self._client = hashserv.create_client(self.server, **self.get_hashserv_creds())
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/hashserv/__init__.py", line 88, in create_client
    raise e
  File "/OE/build/oe-core/bitbake/lib/hashserv/__init__.py", line 80, in create_client
    c.connect_unix(*a)
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 241, in connect_unix
    self.loop.run_until_complete(self.client.connect())
  File "/usr/lib/python3.12/asyncio/base_events.py", line 687, in run_until_complete
    return future.result()
           ^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 152, in connect
    self.socket = await self._connect_sock()
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/OE/build/oe-core/bitbake/lib/bb/asyncrpc/client.py", line 85, in connect_sock
    sock.connect(os.path.basename(path))
FileNotFoundError: [Errno 2] No such file or directory
 broke the idle_thread, exiting
1605616 09:30:14.673756 Exiting (socket: True)
1605616 09:30:14.683153 Exiting as we could obtain the lock
sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name='/OE/build/oe-core/bitbake-cookerdaemon.log' mode='a+' encoding='UTF-8'>
sys:1: ResourceWarning: unclosed <socket.socket fd=17, family=1, type=1, proto=0>
ResourceWarning: Enable tracemalloc to get the object allocation traceback

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
Sending as RFC, because I'm using hashserv only with local sockets
and I might not imagine all the corner cases where this might not
be acceptable, I also didn't run selftest with this.

 lib/bb/siggen.py | 69 +++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 89b70fb6a..145d7cebc 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -704,39 +704,42 @@ class SignatureGeneratorUniHashMixIn(object):
                 query_tids.append(tid)
 
         if query_tids:
-            with self.client() as client:
-                unihashes = client.get_unihash_batch((self._get_method(tid), self.taskhash[tid]) for tid in query_tids)
-
-        for idx, tid in enumerate(query_tids):
-            # In the absence of being able to discover a unique hash from the
-            # server, make it be equivalent to the taskhash. The unique "hash" only
-            # really needs to be a unique string (not even necessarily a hash), but
-            # making it match the taskhash has a few advantages:
-            #
-            # 1) All of the sstate code that assumes hashes can be the same
-            # 2) It provides maximal compatibility with builders that don't use
-            #    an equivalency server
-            # 3) The value is easy for multiple independent builders to derive the
-            #    same unique hash from the same input. This means that if the
-            #    independent builders find the same taskhash, but it isn't reported
-            #    to the server, there is a better chance that they will agree on
-            #    the unique hash.
-            taskhash = self.taskhash[tid]
-            unihash = unihashes[idx]
-
-            if unihash:
-                # A unique hash equal to the taskhash is not very interesting,
-                # so it is reported it at debug level 2. If they differ, that
-                # is much more interesting, so it is reported at debug level 1
-                hashequiv_logger.bbdebug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
-            else:
-                hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
-                unihash = taskhash
+            unihashes = []
+            try:
+                with self.client() as client:
+                    unihashes = client.get_unihash_batch((self._get_method(tid), self.taskhash[tid]) for tid in query_tids)
+            except (ConnectionError, FileNotFoundError) as e:
+                bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
+            for idx, tid in enumerate(query_tids):
+                # In the absence of being able to discover a unique hash from the
+                # server, make it be equivalent to the taskhash. The unique "hash" only
+                # really needs to be a unique string (not even necessarily a hash), but
+                # making it match the taskhash has a few advantages:
+                #
+                # 1) All of the sstate code that assumes hashes can be the same
+                # 2) It provides maximal compatibility with builders that don't use
+                #    an equivalency server
+                # 3) The value is easy for multiple independent builders to derive the
+                #    same unique hash from the same input. This means that if the
+                #    independent builders find the same taskhash, but it isn't reported
+                #    to the server, there is a better chance that they will agree on
+                #    the unique hash.
+                taskhash = self.taskhash[tid]
+
+                if unihashes and unihashes[idx]:
+                    unihash = unihashes[idx]
+                    # A unique hash equal to the taskhash is not very interesting,
+                    # so it is reported it at debug level 2. If they differ, that
+                    # is much more interesting, so it is reported at debug level 1
+                    hashequiv_logger.bbdebug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
+                else:
+                    hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
+                    unihash = taskhash
 
-            self.set_unihash(tid, unihash)
-            self.unihash[tid] = unihash
-            result[tid] = unihash
+                self.set_unihash(tid, unihash)
+                self.unihash[tid] = unihash
+                result[tid] = unihash
 
         return result
 
@@ -814,7 +817,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     d.setVar('BB_UNIHASH', new_unihash)
                 else:
                     hashequiv_logger.debug('Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
-            except ConnectionError as e:
+            except (ConnectionError, FileNotFoundError) as e:
                 bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
         finally:
             if sigfile:
@@ -856,7 +859,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 # TODO: What to do here?
                 hashequiv_logger.verbose('Task %s unihash reported as unwanted hash %s' % (tid, finalunihash))
 
-        except ConnectionError as e:
+        except (ConnectionError, FileNotFoundError) as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
         return False

