Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A8FCA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:55:22 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.22661.1757519717824790507
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 08:55:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=m3ZSnKcw;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77269d19280so6507720b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757519717; x=1758124517; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6AsV6srsKWVmuhjm2voht8OCLFBS8qEuYdyvjg17Hg=;
        b=m3ZSnKcwUgKskTQvvq5c/veiqS2pq6U5PpN+svV9gqspuBlKZ6siChz7hEdxxcdqIu
         KnpP/tUftIwHbUSD/sIKG/O9uoiouYKQdIUIFZW5aQ9qhZvdvqjF8OSCC3OSW7t9nIKq
         HLsB2WPJzqnRa72EOvuDzYPl5rbgMTG7EcOKRv+gbSeTX0tqqt+hkJ1Q++anwXS2E9tr
         EuiE0yqtE4NF8XE2a9O9rfRQHD+kjA8FrwgoeBNY1+nSFfnZIDJdtMZakWSMAkbdiagz
         zuZyAE9eCAOCvFI1T1X41ahad1lhchD0+i7fr4yezfT/wq6qaEPntCgKXPTyXlak0Tuj
         j/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519717; x=1758124517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6AsV6srsKWVmuhjm2voht8OCLFBS8qEuYdyvjg17Hg=;
        b=ir5bLyzGrZCATzqKN+n6yeMhY4th0wb+xAX2jPC5q2BYpYnRMX2rKDLi1BhMJ+VLxK
         z5Vj1BOiiET9fAwGqqrhHQYJGuhobkFxW7XLg17w1LUOfd+nbkahMDnBV7kyeVvK7adY
         ZOx4H+jJfUM34EX4J+8Tyqh2GBn9QdpdDthN15wIC8wfPevDuRMh9GWXp1pylGVDUNeA
         eGKvpx1NOISv2kTBjJvRH0i2V6PqqTQiMkoj4hZEqkjvqc43bdiRJcFK4nLR1fFkclR7
         Rk1uEBeycOxuXSsuWkTW5w+pgcvsXtyFStU4Zd/CWlgf+CSqKAUWs0mSztNo7HVx2pvC
         LHpQ==
X-Gm-Message-State: AOJu0Yw9YcqbL9HHfXG8dE0nD0Ru0A+9Sg4V1URPUCit0XtVyfmAwOjF
	yBuA7brY8vMEfdrsjWM3d/NcN01y78NQw7YrcHQV1Pn39//iS/V9RLMH29/8SR1bDGfbqYFrSHz
	0qAQy
X-Gm-Gg: ASbGncs2E9ky/utfbx6U0R1YvzXy3TEJ7vnPYdrQtiiwPRq2401DbqPvNDlD6bykIbP
	O1w7U1ZqNVBglOC0HOP0n7m7/4rtJ0pDn83pSM4VcRYRRBzOadh5XT/tNVJWy14yOfJpSHgLZxs
	OyeKSF/S1m92RVXNkxr8EPXhELmwQLh4LAKLdGgvsaQMlcpkzrFcpZYEyoOWBv3OAqMdpBFWPUQ
	UXLYPbgctUYZXPg+Lsx7Tti5nqSt3xbLzmzqAJSEZRRcWLHjbeJ10QBwwBhn4lyOO9hNTO1tunz
	7C23OL8JWzpGYTN1ljw571fv3QwCf9c0pCW5eVI6F2HYjItxXDoTLb4ZAZnzrlkB36o7wApDcuT
	7lZfy4aRbMPlNMpaIwO7/qeXW
X-Google-Smtp-Source: AGHT+IG0kMWBnJN2MLEPCJo7TXDJU6Ktcn3j7w5cs+7G6SUAx9wQofNpbeU9Lj510jINrfFshp9JHw==
X-Received: by 2002:a17:902:e54c:b0:246:b3d4:5c82 with SMTP id d9443c01a7336-2516fdc7363mr209264625ad.16.1757519716868;
        Wed, 10 Sep 2025 08:55:16 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff3efsm31211655ad.123.2025.09.10.08.55.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:55:16 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH 1/2] Use a "fork" multiprocessing context
Date: Wed, 10 Sep 2025 08:55:09 -0700
Message-ID: <a1dd672c552ad7b251bf7866e7276d0de551be7c.1757519577.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519577.git.steve@sakoman.com>
References: <cover.1757519577.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 15:55:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17998

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
index 566835573..605355e1a 100644
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
index 667217c5c..acdcaf08e 100644
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
index 1810bcc60..36659cee2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -12,7 +12,7 @@ import enum
 import sys, os, glob, os.path, re, time
 import itertools
 import logging
-import multiprocessing
+from bb import multiprocessing
 import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4b35be62c..f74b3f1bf 100644
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
index 083242268..694e79f55 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -12,7 +12,7 @@ import sys
 import errno
 import logging
 import locale
-import multiprocessing
+from bb import multiprocessing
 import importlib
 import importlib.machinery
 import importlib.util
@@ -1198,8 +1198,6 @@ def process_profilelog(fn, pout = None):
 #
 def multiprocessingpool(*args, **kwargs):
 
-    import multiprocessing.pool
-    #import multiprocessing.util
     #multiprocessing.util.log_to_stderr(10)
     # Deal with a multiprocessing bug where signals to the processes would be delayed until the work
     # completes. Putting in a timeout means the signals (like SIGINT/SIGTERM) get processed.
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index da3f8e088..124d8aa00 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
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
2.43.0


