Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.4183.1619425006675319245
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:16:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Q3StZ77E;
 spf=pass (domain: konsulko.com, ip: 209.85.128.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f50.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so2786049wmg.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4BEobQV24qOVMTm2YIypA34sn+2ekyNyTfJ/wy+Jio=;
        b=Q3StZ77E7UMJDPqTPZdbFCR+RKh32VMLQuoWC6Ih2prHKMNDbGwIk9QDdJmkaFYX73
         Ga2kMJBZkfP4bGw7wTEATW3ohOGdQHmNUH8DIceW52871nEkA/PAujqeA50qSurhYyPl
         W6HB9ZTtfJxSUZxDKuK6zBdA/QS512BuqvUds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4BEobQV24qOVMTm2YIypA34sn+2ekyNyTfJ/wy+Jio=;
        b=E4U3NYHeVlxkLDFFwvm2djQn5ca88oLdHOf2ddHjs5TlOj2E2LesglT94Z/a2I2/GT
         gI3PdqhVz0RukOJhpPesEJuhKqupxxt/mweZ9Z/DWf2YXbGN+y0bKConx/adBfv9F2Wf
         ctzhGOIq4kw4baVIdGnESmtM2yFZsmgiNsjI+j+UyOk3EyHDswXkBGKELNkJhxm/McLB
         fQf+Jpv6eWHtra3yGD+TXY1Nqf8H9ZgP+Hh0IMhpMomLUqKFp3UBTZIqU2bI1jTQWuYa
         qpib7SbNIJsBztt+D9GIxSm1w6FyxFqcj5e3O5XKW+VtEuYqAUyHZIk51Ew2whVuUdgw
         stWg==
X-Gm-Message-State: AOAM5324H8taLhdurKKvzt4FpWw0fAeP7g+ab0xPi7qR58vgh9ovh73f
	Raseiv1IrgpX8yVcsQY0fAqPctC05Q+vRA==
X-Google-Smtp-Source: ABdhPJzO5ezGTdPK42Cr/uzyPcc18n/U7ppYBzWF9QBqHCvKhQG98OHdZqwSi/sRDa2k2xPGUbqvgg==
X-Received: by 2002:a1c:9a83:: with SMTP id c125mr7020711wme.62.1619425004896;
        Mon, 26 Apr 2021 01:16:44 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id a9sm4631320wrw.26.2021.04.26.01.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:16:44 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 1/6] hashserv: Use generic ConnectionError
Date: Mon, 26 Apr 2021 09:16:28 +0100
Message-Id: <20210426081633.5020-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426081633.5020-1-pbarker@konsulko.com>
References: <20210426081633.5020-1-pbarker@konsulko.com>
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

