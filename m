Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD04CA0EFA
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 22:40:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.2440.1755816017934719097
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 15:40:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cN/YeUZ6;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb72d5409so226775866b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755816016; x=1756420816; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfwAoH/pdG8nAXfoaDOPUeJggZoPhDwBO0UcJDr9t0o=;
        b=cN/YeUZ6C5XgseSq56Y41Rwjxs3Mc2NDc5fPfWf90jN9IFzJrfNVYM5k4/cHLTtyCy
         qhwXu+oy7u2YH9921NTqCGZNkf7LYBIT66ihvElaJxtQul1/1CmRJFA0jUun+lhSH5P3
         PAnQJdJuJ4fPo9MTQUoG/1Flyzo2z+Kx44s252UDT/B7MwwrPLEpZbpOlIWDPtjT9VQt
         yPVyeN/PD8/I8oFP53sQKXqwjUqU8j1ipQhcasq6GddUx8EYAxMYsOn57p5RQg/TaFu/
         Z2vRXyKVoxSVM9s9qGfzAMhqYNkaV0AnozLaRBtGxDCArPKWux1TgCD555l08XD2kZH1
         SLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755816016; x=1756420816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfwAoH/pdG8nAXfoaDOPUeJggZoPhDwBO0UcJDr9t0o=;
        b=TJFIGbt1qKDQcbq1dKjzRCaMjY3aAd0IqJEnK7LUKbGSx/8vNS8lbVkZ5fglJLc1MI
         bWfVJYu597yLYOvPUn6JjAo0CNXHuWW7rps1XIFEjxrENL5cUxwdoriKKalpGCJVZwdW
         oehv/l2PNKj5sUJv7ERWUozvnqY4ehtN040+1HIUhrde1Nw8iueogIG9XrlHtCpZYn0n
         o0PGOroy/dGX7eueYTRz425kLS6TyXhb7SiYb4thlX7ZWQ15kmmkueLdjaD84KaAxdjd
         yl2sa03DZ860iTcLS3pGY+MbKsuZqp1+YgDgW1AePdvS2h+esDbYJsUhE/vb5nG56Kmf
         26AA==
X-Gm-Message-State: AOJu0YwP6LAmiu3ZMDw7I1wGDGdAjZ8bOh8W/cJjWO+pKKs8z+7XZ7kn
	x/ukTkyCBxtR7XwDVpHLV72FEiXVysNi6vzaDE/jC+O3Yj8ylXrbbT2TkNTT9w==
X-Gm-Gg: ASbGnctIblwu0hkvz4X4exZYjaLJc8lYMD7va9CnU9Y0X7HQBtgpDkmfr0I9PA0itaC
	2M/3eudm7mHBY6M+Gxzai5t07z6wO/snwZOXr9U1LeE3QeoicNRruUdBID+oUm/296gezVZKnSO
	gc6yw7C+L1WLSxaEa+GYHlV3XeBC2UGyxlR32oCfU63S+pymEqJ62B+XWNsYc+1e2GB9uk2utsb
	PWC+kcRRbBOU+1QQiQOzXCQOzMS0cp92QoLaInz3dfiItVRGWYynxantisUKjw0q1eEDht/objp
	xRfJb1cGQL0cZLjjLL2YqJZluaFN7Qd5JCMdOmd3aUgR+Mwd3u4k5z9ljQ9pzqr1DQJMZ8R8okx
	+IXd1OcvE6rBOMlKzK6bkw/YJXkUv1hQ9U/cAe6RkUuGjkR/nERtBu7i0
X-Google-Smtp-Source: AGHT+IG/k4MQWScNcsbgO7D7M3+P6j9Xl/KmY9dS7ki5H3MKzwwmp0L/YLKBH+A8krpgWtqopNCc7g==
X-Received: by 2002:a17:907:6d06:b0:af9:2bb9:ea36 with SMTP id a640c23a62f3a-afe28feb8eemr63152266b.7.1755816016109;
        Thu, 21 Aug 2025 15:40:16 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a7577462esm5861813a12.36.2025.08.21.15.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:40:15 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Joshua Watt <JPEWhacker@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [2.8][PATCH] Use a "fork" multiprocessing context
Date: Fri, 22 Aug 2025 00:40:06 +0200
Message-ID: <20250821224006.1672882-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 22:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17910

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
index 15b57b0ba..1a1cfb95e 100644
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

