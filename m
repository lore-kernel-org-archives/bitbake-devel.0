Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.31089.1618227719248860154
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:41:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RX2oOPbJ;
 spf=pass (domain: konsulko.com, ip: 209.85.221.53, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f53.google.com with SMTP id 12so12593802wrz.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4BEobQV24qOVMTm2YIypA34sn+2ekyNyTfJ/wy+Jio=;
        b=RX2oOPbJEvKXhgGT49yk4hsjVe8OAWlRoQrd7qZ1mdybKRTGRZ65Upnwna6fEEum2v
         G76kchdGnD0Y4kmpZKoQs2wZ4qP0sDqHwPqH4jiwxlU56BF/oMpkTOh5ig+0PjyZjve4
         ifRDA6WbK00FLfhSkaTQPf8t5QBZN0UuP237s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4BEobQV24qOVMTm2YIypA34sn+2ekyNyTfJ/wy+Jio=;
        b=tn70/k2pXO6L87Hr7GOvDQnm3enrfiDaBj/a9FFk522VthouSdC8CWI742Wexjh3ay
         gb9lnLa95q8m14hTcsNsXEMoED3QCiI9AnSEcb1Pi1fIx8FlhsAT+atUdK0roEICuHRm
         mlprhA2e9H+xF3VejXH94rDBTXM+MB43oUls/Zxp6AtqXDNV8pkBF/sBK1SPNeYaHn9O
         3qdSRX2y7pgX4oNOdAyr+gZWAL6jvOfvsJwctFmsehnwWPrJZixTskmVuyZBYDidJHxK
         E9pi3pgUDmF55hMKTsgbu3/y3O3IpAQcQ8sF5/JAAIaaJW9QStc7rhgk+GDlYfuiB9QV
         TKbQ==
X-Gm-Message-State: AOAM532Addwhv+OCmDJHfjXTZtU72ExqvSBns5NnopAKgmIh3wlMApMA
	bs6uWrEawRkTGLDqKzF4nCF4vSgddwOccA==
X-Google-Smtp-Source: ABdhPJytW26x6YvtG08hxnR9aLcHW67HEUW267fTErX8xi/l69V4Tox+C/Hf70L6AA1Ep8Weo7fBRw==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr31596202wrt.243.1618227717573;
        Mon, 12 Apr 2021 04:41:57 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:41:57 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 01/11] hashserv: Use generic ConnectionError
Date: Mon, 12 Apr 2021 12:41:39 +0100
Message-Id: <20210412114149.4750-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Python built-in ConnectionError type can be used instead of a custom
HashConnectionError type. This will make code refactoring simpler.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/siggen.py       |  6 +++---
 lib/hashserv/client.py | 20 ++++++++------------
 lib/hashserv/tests.py  |  3 +--
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0d88c6ec6..f3fa3000f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -542,7 +542,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 hashequiv_logger.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
                 hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
-        except hashserv.client.HashConnectionError as e:
+        except ConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
         self.set_unihash(tid, unihash)
@@ -621,7 +621,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     d.setVar('BB_UNIHASH', new_unihash)
                 else:
                     hashequiv_logger.debug('Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
-            except hashserv.client.HashConnectionError as e:
+            except ConnectionError as e:
                 bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
         finally:
             if sigfile:
@@ -661,7 +661,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 # TODO: What to do here?
                 hashequiv_logger.verbose('Task %s unihash reported as unwanted hash %s' % (tid, finalunihash))
 
-        except hashserv.client.HashConnectionError as e:
+        except ConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
         return False
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index e05c1eb56..f370cba63 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -14,10 +14,6 @@ from . import chunkify, DEFAULT_MAX_CHUNK, create_async_client
 logger = logging.getLogger("hashserv.client")
 
 
-class HashConnectionError(Exception):
-    pass
-
-
 class AsyncClient(object):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
@@ -66,14 +62,14 @@ class AsyncClient(object):
                 return await proc()
             except (
                 OSError,
-                HashConnectionError,
+                ConnectionError,
                 json.JSONDecodeError,
                 UnicodeDecodeError,
             ) as e:
                 logger.warning("Error talking to server: %s" % e)
                 if count >= 3:
-                    if not isinstance(e, HashConnectionError):
-                        raise HashConnectionError(str(e))
+                    if not isinstance(e, ConnectionError):
+                        raise ConnectionError(str(e))
                     raise e
                 await self.close()
                 count += 1
@@ -82,12 +78,12 @@ class AsyncClient(object):
         async def get_line():
             line = await self.reader.readline()
             if not line:
-                raise HashConnectionError("Connection closed")
+                raise ConnectionError("Connection closed")
 
             line = line.decode("utf-8")
 
             if not line.endswith("\n"):
-                raise HashConnectionError("Bad message %r" % message)
+                raise ConnectionError("Bad message %r" % message)
 
             return line
 
@@ -119,7 +115,7 @@ class AsyncClient(object):
             await self.writer.drain()
             l = await self.reader.readline()
             if not l:
-                raise HashConnectionError("Connection closed")
+                raise ConnectionError("Connection closed")
             return l.decode("utf-8").rstrip()
 
         return await self._send_wrapper(proc)
@@ -128,11 +124,11 @@ class AsyncClient(object):
         if new_mode == self.MODE_NORMAL and self.mode == self.MODE_GET_STREAM:
             r = await self.send_stream("END")
             if r != "ok":
-                raise HashConnectionError("Bad response from server %r" % r)
+                raise ConnectionError("Bad response from server %r" % r)
         elif new_mode == self.MODE_GET_STREAM and self.mode == self.MODE_NORMAL:
             r = await self.send_message({"get-stream": None})
             if r != "ok":
-                raise HashConnectionError("Bad response from server %r" % r)
+                raise ConnectionError("Bad response from server %r" % r)
         elif new_mode != self.mode:
             raise Exception(
                 "Undefined mode transition %r -> %r" % (self.mode, new_mode)
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 1a696481e..e2b762dbf 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -6,7 +6,6 @@
 #
 
 from . import create_server, create_client
-from .client import HashConnectionError
 import hashlib
 import logging
 import multiprocessing
@@ -277,7 +276,7 @@ class HashEquivalenceCommonTests(object):
         outhash2 = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
         unihash2 = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
 
-        with self.assertRaises(HashConnectionError):
+        with self.assertRaises(ConnectionError):
             ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
 
         # Ensure that the database was not modified
-- 
2.26.2

