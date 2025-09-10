Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD09CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:59:22 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.22771.1757519962286307407
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 08:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=LOtO/sVH;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c784130e6so78595505ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757519961; x=1758124761; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2E8Xah+NevlT/en1Le59hSqyMcWsGEXV1qmguU1AoA=;
        b=LOtO/sVH9OOGIh+tFAK8y1YjDZcaHnWrgdlD5ySkaL/NfA7FcOqz55dT5PINrDt7no
         k8mBZ9buPJ7ZTwNOF64aeYvW7uoavHyjC74+krp4/i8c42f0Ho9YmKGkQBRSCy5K6MGP
         66XS0lggPnH0oTtXl9l4k5vvBIFTY9p5YQkW1o5cxcl+iN+RbFvcO8BWv4sCH/x4Q1Gk
         +hF78HDDErfkI1Tq00wPBPZxuknqeMZgq08grRDDyQirbss+yazbt+nPrwG202J0RhTb
         N54oYFe/TSZ4cD5mC8sLQVJPRVSatqQ8njmbwGqOzL5vbbPCE/TuKZMMDFsq9SzZazPT
         nOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519961; x=1758124761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2E8Xah+NevlT/en1Le59hSqyMcWsGEXV1qmguU1AoA=;
        b=VtjwPm2sC2sODPqSF9rqlafduQf/+EcFPJropnz5paFfB8GVJxuWC5GvOn67mBS8UT
         Sgk06byNhuZUUwsir+GHf151vi+/PEIFmoLPdxjEEKkws7q3dOGw2noQGwHhy/h0aEiK
         X3DbkNxroBlCUtrB1zkfnRDyxCxfoASKluQ14yvbyyLQMqw/wznrIYgclQscwk0ZsWRB
         rij5FfTesEFyyLrQgnA8chO88HK5c2wzRBV5tgSwCl1rpWLaS7oFpV8L9Ii62JmZ54rf
         sQj1jOIwMD5Jhmi0Zzgyarx7OA+bB+ztf0WvHpYs+5ZW+blAaZNYEhDNUMNQVS9huZU9
         UZmQ==
X-Gm-Message-State: AOJu0Yxcxhi6l6NqrXGopPp/OSzlIpG24FmkZfY81Y+5pZNOEdDrZ5O3
	roeUFJUbmD0ySj4cbJluaVgWmeua0JOYnh4nuD9R2/JMwGFdpZjaYn1Kjsrjuj90XL0ER5pihi2
	pg/gT
X-Gm-Gg: ASbGncuE7VnIE6FQrDuMXOIC96TGowlqgjpBoukrmQyLPR/VRnalFvGDEhIE7c7JR5u
	OuWWgXRY6geIqOlWcUoYrH8ob9qrRgaEnjM6mUhwBT+RtBtF/vEsZQoON6JtGVqkkNMoS0MV5c6
	s+mxVSblXe6Bqvu5KMBH9hTKQfRFxI/EXhIp4g8iwlr0qdqmVxMsFoJhiw2jJkkcPmh0FcviTOF
	/Ibjrl9K+u++jI4oxef6zd4W4dQaT1Q465pzIb/7eyM5xkAPg+uZ4d+h82RaKLBZGH5nIOn4iYR
	cRHIN8f6Llt+gG5C97QYfkIEPh/+CG4+AtU2pnlg67J3c14rbkbYk+4dNJkynMfNtBoGT3QlCFn
	UjMZ6teos8vzuA0a5umMXRqMY
X-Google-Smtp-Source: AGHT+IErRoDoA9VHf7EWtdXBwhPvIkJgLhasmBJPSFXPUtL22nzlYyzrlBjQMs6vbP2mA9vNz7TIYg==
X-Received: by 2002:a17:902:ec8f:b0:24c:7862:41e2 with SMTP id d9443c01a7336-25171cbdecemr244187605ad.31.1757519961260;
        Wed, 10 Sep 2025 08:59:21 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff4c4sm31235405ad.124.2025.09.10.08.59.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:59:20 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/2] Use a "fork" multiprocessing context
Date: Wed, 10 Sep 2025 08:59:13 -0700
Message-ID: <aed7ceadf6a3566b4aaf3059022ec54bf7ac8e74.1757519842.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519842.git.steve@sakoman.com>
References: <cover.1757519842.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 15:59:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18001

From: Joshua Watt <JPEWhacker@gmail.com>

Python 3.14 changes the default multiprocessing context from "fork" to
"forkserver"; however bitbake heavily relies on "fork" to efficiently
pass data to the child processes. As such, make "fork" context in the bb
namespace and use it in place of the normal multiprocessing module.

Note that multiprocessing contexts were added in Python 3.4, so this
should be safe to use even before Python 3.14

[YOCTO #15858]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/__init__.py                 | 28 ++++++++++++++++++++++++++++
 lib/bb/asyncrpc/serv.py            |  2 +-
 lib/bb/cooker.py                   |  2 +-
 lib/bb/server/process.py           |  2 +-
 lib/bb/tests/support/httpserver.py |  4 ++--
 lib/bb/utils.py                    |  4 +---
 lib/hashserv/tests.py              |  2 +-
 7 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index cdec9e4d6..f59c2515b 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -37,6 +37,34 @@ class BBHandledException(Exception):
 import os
 import logging
 from collections import namedtuple
+import multiprocessing as mp
+
+# Python 3.14 changes the default multiprocessing context from "fork" to
+# "forkserver". However, bitbake heavily relies on "fork" behavior to
+# efficiently pass data to the child processes. Places that need this should do:
+#   from bb import multiprocessing
+# in place of
+#   import multiprocessing
+
+class MultiprocessingContext(object):
+    """
+    Multiprocessing proxy object that uses the "fork" context for a property if
+    available, otherwise goes to the main multiprocessing module. This allows
+    it to be a drop-in replacement for the multiprocessing module, but use the
+    fork context
+    """
+    def __init__(self):
+        super().__setattr__("_ctx", mp.get_context("fork"))
+
+    def __getattr__(self, name):
+        if hasattr(self._ctx, name):
+            return getattr(self._ctx, name)
+        return getattr(mp, name)
+
+    def __setattr__(self, name, value):
+        raise AttributeError(f"Unable to set attribute {name}")
+
+multiprocessing = MultiprocessingContext()
 
 
 class NullHandler(logging.Handler):
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index a66117aca..953c02ef3 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -11,7 +11,7 @@ import os
 import signal
 import socket
 import sys
-import multiprocessing
+from bb import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection
 from .exceptions import ClientError, ServerError, ConnectionClosedError, InvokeError
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6fce19b46..778cbb589 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -12,7 +12,7 @@
 import sys, os, glob, os.path, re, time
 import itertools
 import logging
-import multiprocessing
+from bb import multiprocessing
 import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 76b189291..34b3a2ae9 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -13,7 +13,7 @@
 import bb
 import bb.event
 import logging
-import multiprocessing
+from bb import multiprocessing
 import threading
 import array
 import os
diff --git a/lib/bb/tests/support/httpserver.py b/lib/bb/tests/support/httpserver.py
index 78f766005..03327e923 100644
--- a/lib/bb/tests/support/httpserver.py
+++ b/lib/bb/tests/support/httpserver.py
@@ -3,7 +3,7 @@
 #
 
 import http.server
-import multiprocessing
+from bb import multiprocessing
 import os
 import traceback
 import signal
@@ -43,7 +43,7 @@ class HTTPService(object):
         self.process = multiprocessing.Process(target=self.server.server_start, args=[self.root_dir, self.logger])
 
         # The signal handler from testimage.bbclass can cause deadlocks here
-        # if the HTTPServer is terminated before it can restore the standard 
+        # if the HTTPServer is terminated before it can restore the standard
         #signal behaviour
         orig = signal.getsignal(signal.SIGTERM)
         signal.signal(signal.SIGTERM, signal.SIG_DFL)
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d2f11e437..1b4fb93a3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -14,7 +14,7 @@ import logging
 import bb
 import bb.msg
 import locale
-import multiprocessing
+from bb import multiprocessing
 import fcntl
 import importlib
 import importlib.machinery
@@ -1174,8 +1174,6 @@ def process_profilelog(fn, pout = None):
 #
 def multiprocessingpool(*args, **kwargs):
 
-    import multiprocessing.pool
-    #import multiprocessing.util
     #multiprocessing.util.log_to_stderr(10)
     # Deal with a multiprocessing bug where signals to the processes would be delayed until the work
     # completes. Putting in a timeout means the signals (like SIGINT/SIGTERM) get processed.
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 5349cd586..ed1ade749 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -11,7 +11,7 @@ from bb.asyncrpc import InvokeError
 from .client import ClientPool
 import hashlib
 import logging
-import multiprocessing
+from bb import multiprocessing
 import os
 import sys
 import tempfile
-- 
2.43.0


