Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B48C83F25
	for <webhook@archiver.kernel.org>; Mon, 21 Jul 2025 19:40:25 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.50938.1753126824988422922
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Jul 2025 12:40:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DCaG9bDf;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73e82d2ea1dso2187716a34.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 21 Jul 2025 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753126823; x=1753731623; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wShffz9K3vZuEHg1dwaIPWcAsLBJOTeSyvcosQhKD8M=;
        b=DCaG9bDfFdPyVL7AINxe9ItzFiD22H3hiqjvUIi+XQXbMRG/EfbqTemRqNii1eEe0T
         iu1MeKoTBOOo/krvmCyE/bL50N+bLZFZ3yYVC2DQZG4f8Uogcq3Z+JiPvVJFJ/A6MaBw
         hR1erpfuBm+2ZGA9MNO+0YyZH9a5SaAoKI2tOCm1nFUgyIFiFedfyZ7pZnErck2HjgF4
         +kbG3A6HbTHO/sZ9s5Gm2ucUpsJrs3GMUNYEyscyHOMx0KZT4ZEOMMoCPi0KeIiKan6R
         Yecq5sxI6Tle2Kc/XcG1dV/FKxf4/V4EaiZTYpTM2ep90Bf16Zqvo1QYLIGSEatDRSvD
         XnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126823; x=1753731623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wShffz9K3vZuEHg1dwaIPWcAsLBJOTeSyvcosQhKD8M=;
        b=wYWOdj2irXFnNDfYOcUb9rPCrsmCpb/n+bUZdl2s0Lp8BGacTlkipcHas51Z6S+PIA
         z8H4C91q8TNqzAk4VOopHRzkkmm6tDWfMXSEQSsM7pdrUATuHSiYdh9S+qsqpm8U9QYV
         /GVRWZA21hxH9l9TOIWFeZqkxgJVk3rEAqzrFL/fByflVEvw7vWM4rnEfSu9UbN90e8w
         Cg5I9BiDph+9NVB65BsjAqNa42TiGOiuK7dii9WFg/RMSHApLElwv8L+CuBr1hBJo+Qy
         aY9oTqNCZu3XjCSQtYsV02ESSV0gWUpLVsxWSWt1cDYHhMdIb8vtPSF3BlQla4W1RQij
         73gQ==
X-Gm-Message-State: AOJu0Yzv3VBPDBgcleYczDGDyMfx6ZskglLYxuyvnLkiAIF9Ljo9XCck
	0Pb2IWNiq8Y5fyhr9zIDqJNZ4+tdz29IO3/VV+G6TUw2TgZVGpEN8FxHXY57nA==
X-Gm-Gg: ASbGnctCcZvryvjaGlRZJCT1DoXRgZtDOc9iWGVYt90WfkY2PekMypTOD3qMqT0jxNE
	b9I+lCpTMJl81qjKBGj18XbCnH+hE3euS6LhfbpZhuQTiVvGCOD9EdfSyan9JtStq56xneicVrS
	w2GjARsmNkDHO5I7r15uyLElR9qHyVAX3wpKT2oG9HP/kF8clvsPDUgzV1gHvzR8Eq3Y+RNdv7q
	XntmNovaWVwCAf8mQJ94Ek4yjHx7E1A3AMhxA5iLWCo1PSfEwCSvOlzHA9hRBh6MR3vhNqabzht
	0jtA5CgtZ8LEcnbjSpD3t2DzP6ojGsWRN7bhNJKCPDVPDTTa5vQ+b424RYHutMbDiO470iQbZH+
	W92k+LszOzB0eRMWlPpCV
X-Google-Smtp-Source: AGHT+IGRPJ4ilt77XkNRFaoyWxFsJrCy+JSqbulcpCrnrrrgAD8yVUpL6J6hYufRwlYP0twryfO6KQ==
X-Received: by 2002:a05:6830:7309:b0:72c:3235:9c5a with SMTP id 46e09a7af769-73e66003860mr15986323a34.1.1753126823605;
        Mon, 21 Jul 2025 12:40:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::bc4c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8a7edab2sm2787797a34.40.2025.07.21.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:40:22 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] Use a "fork" multiprocessing context
Date: Mon, 21 Jul 2025 13:40:18 -0600
Message-ID: <20250721194018.883462-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Jul 2025 19:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17800

Python 3.14 changes the default multiprocessing context from "fork" to
"forkserver"; however bitbake heavily relies on "fork" to efficiently
pass data to the child processes. As such, make "fork" context in the bb
namespace and use it in place of the normal multiprocessing module.

Note that multiprocessing contexts were added in Python 3.4, so this
should be safe to use even before Python 3.14

[YOCTO #15858]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py                 | 28 ++++++++++++++++++++++
 bitbake/lib/bb/asyncrpc/serv.py            |  2 +-
 bitbake/lib/bb/cooker.py                   |  2 +-
 bitbake/lib/bb/server/process.py           |  2 +-
 bitbake/lib/bb/tests/support/httpserver.py |  4 ++--
 bitbake/lib/bb/utils.py                    |  4 +---
 bitbake/lib/hashserv/tests.py              |  2 +-
 7 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index bf4c54d829e..3c98b835c6b 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
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
diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index 35e93f7c969..bd1aded8db3 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
@@ -11,7 +11,7 @@ import os
 import signal
 import socket
 import sys
-import multiprocessing
+from bb import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection
 from .exceptions import ClientError, ServerError, ConnectionClosedError, InvokeError
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index fe33a4f34c5..d16998686a2 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -12,7 +12,7 @@ import enum
 import sys, os, glob, os.path, re, time
 import itertools
 import logging
-import multiprocessing
+from bb import multiprocessing
 import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 7d1b38f78c2..d0f73590cc0 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -13,7 +13,7 @@
 import bb
 import bb.event
 import logging
-import multiprocessing
+from bb import multiprocessing
 import threading
 import array
 import os
diff --git a/bitbake/lib/bb/tests/support/httpserver.py b/bitbake/lib/bb/tests/support/httpserver.py
index 78f7660053d..03327e923b4 100644
--- a/bitbake/lib/bb/tests/support/httpserver.py
+++ b/bitbake/lib/bb/tests/support/httpserver.py
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
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index f688f7dd687..6afc4be34d7 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -12,7 +12,7 @@ import sys
 import errno
 import logging
 import locale
-import multiprocessing
+from bb import multiprocessing
 import importlib
 import importlib.machinery
 import importlib.util
@@ -1470,8 +1470,6 @@ def process_profilelog(fn, pout = None):
 #
 def multiprocessingpool(*args, **kwargs):
 
-    import multiprocessing.pool
-    #import multiprocessing.util
     #multiprocessing.util.log_to_stderr(10)
     # Deal with a multiprocessing bug where signals to the processes would be delayed until the work
     # completes. Putting in a timeout means the signals (like SIGINT/SIGTERM) get processed.
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index da3f8e08844..124d8aa0056 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -10,7 +10,7 @@ from .server import DEFAULT_ANON_PERMS, ALL_PERMISSIONS
 from bb.asyncrpc import InvokeError
 import hashlib
 import logging
-import multiprocessing
+from bb import multiprocessing
 import os
 import sys
 import tempfile
-- 
2.49.0


