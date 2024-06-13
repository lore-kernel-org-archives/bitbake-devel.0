Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8CC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 08:55:31 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.3716.1718268923622222804
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jun 2024 01:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WKoY2F16;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso119764766b.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Jun 2024 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268922; x=1718873722; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oe2KS9Ua9fbOU5Uhk+mZQJRCspE6K6AFOfP0rQHv044=;
        b=WKoY2F162OAeVSX2F6dSjBbJajA4qcKSdWmiA8jj4P9BDsja5nr3XmxZZJiQbpVkbB
         0eYFWV4jeOkLRu3MmTeyvUUBR0t5jOlDQD+hdv2TF3l4h0EvXfoV5aX9gYD7+DGdUkLy
         1mbWWt5D6OOwtqduEmuFPApxwTAiGPsPVYc5umfLpFUnxEIgcgdCl9bXkOTr95O8/z9I
         RKIycznuoAg3UirG/DyWrr1QigywUEBxfkGgyNh0rM7e9D3pE7apix+edo6oKcBgnBpy
         ZWtXUnS1nUeR9kF96hv5bwIuzm13NriWVm0Ii8ZC2MG/Rp+4Uggl1UZ0EzIM/IT8A5F2
         1o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268922; x=1718873722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe2KS9Ua9fbOU5Uhk+mZQJRCspE6K6AFOfP0rQHv044=;
        b=ZxHlKO0JwEzAqZDBBDBuEdguyeAoB/4o4PMgYDB4OK2fkyw0WuHwVkFedU5b11NuEC
         /U7nhe6syMS5PURaALw4BGuEt1BIMbg524/KXvuSB5WWKjvImQgIh5rpRnCOu1wUfGmx
         YIxfWAi9Bbtr4G+aLQZVsEDjcam4klC/t+RexdWbxzi/rWR9vaki4aagKcutpRJqr2eO
         QMkFdFO8CiXFQo2pK/2qAlh/vajJpH2vO93Ckqgxko6cWtz/p7YwV8AUK8NmN/FGaupE
         NvER3Pp80LD3wmJfsi3ANq1JefeRACxaOoHhJ5JTDHJbRF85gAMidWNeGqaPTOH6DY8E
         O4Ww==
X-Gm-Message-State: AOJu0YwUQKtaAIeFLJhyO+7jW5LlNkZM6/G7HQP5qDm6XlQpVb8VzrF7
	6nkIZMNPJYqATHV89wNTSd8ffOz43c9g6K6Mc+CD1Lh0FZPOeHiyUescFg==
X-Google-Smtp-Source: AGHT+IEwf7M2k5EqRJmOFFLfja3nLhio8+0kaEnf0ILuEgxTpiIms5aXnQPLiJuKlY4iJFOQE0f8tw==
X-Received: by 2002:a17:906:c454:b0:a6f:55e8:b361 with SMTP id a640c23a62f3a-a6f55e8e638mr78681866b.41.1718268921654;
        Thu, 13 Jun 2024 01:55:21 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed3679sm48645366b.122.2024.06.13.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:55:21 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [RFC][PATCH v2] siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes
Date: Thu, 13 Jun 2024 10:55:16 +0200
Message-ID: <20240613085516.2577338-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jun 2024 08:55:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16356

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

v2: move enumerate(query_tids) back outside "if query_tids" to avoid
    indentation change to make it easier to review over e-mail
    (otherwise -w can be used to hide whitespace changes)

 lib/bb/siggen.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 89b70fb6a..8f2453552 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -704,8 +704,12 @@ class SignatureGeneratorUniHashMixIn(object):
                 query_tids.append(tid)
 
         if query_tids:
-            with self.client() as client:
-                unihashes = client.get_unihash_batch((self._get_method(tid), self.taskhash[tid]) for tid in query_tids)
+            unihashes = []
+            try:
+                with self.client() as client:
+                    unihashes = client.get_unihash_batch((self._get_method(tid), self.taskhash[tid]) for tid in query_tids)
+            except (ConnectionError, FileNotFoundError) as e:
+                bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
         for idx, tid in enumerate(query_tids):
             # In the absence of being able to discover a unique hash from the
@@ -722,9 +726,9 @@ class SignatureGeneratorUniHashMixIn(object):
             #    to the server, there is a better chance that they will agree on
             #    the unique hash.
             taskhash = self.taskhash[tid]
-            unihash = unihashes[idx]
 
-            if unihash:
+            if unihashes and unihashes[idx]:
+                unihash = unihashes[idx]
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
@@ -733,7 +737,6 @@ class SignatureGeneratorUniHashMixIn(object):
                 hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
                 unihash = taskhash
 
-
             self.set_unihash(tid, unihash)
             self.unihash[tid] = unihash
             result[tid] = unihash
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

