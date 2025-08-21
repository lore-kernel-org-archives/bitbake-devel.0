Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B85ECA0EFA
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 22:40:55 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.2480.1755816044792788842
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 15:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J+MyqADG;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61a8f452c43so2289543a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755816043; x=1756420843; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1vd2zZgFcFInVNXJ3slib+vBiNkRNg9kqBYIJOSJA=;
        b=J+MyqADG03mEp7AOXO7GaZ9hg6tB1uKdXyHjvmogJFkeLQ3JqvkNZ8ZOVWiUFLNMoV
         sNpNj2X13e/RYKMMdQy+jLrtc2VdawyRznS7LpUneMr1s7RXWpVCgTmJSQRWMfDWosEq
         g/nwO/cwixSL7PWtjcHRkO0MsMYjkUyURr5kDwohE20aiZi3BnnAUuBxKVKqZzjm99Ob
         u6RqSzlKid2Ov0TUawLHvDbAyOak/4VsANkZPoAMUPf+C16sjBaPdg7WM5RK6O++l6V9
         4IMQ7M79silTSFtVlfhidMi/QkreNo2D0mxvmE7Ln8Cg59MoAZaxu3KRYfMDp/fAlmzk
         78cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755816043; x=1756420843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bu1vd2zZgFcFInVNXJ3slib+vBiNkRNg9kqBYIJOSJA=;
        b=sR8nyifrQbMf+uSHop2Z+Nk+YNp9a2krzf0XHuRLE1RY3c85PcKFa9h1Eam3FWpWfH
         rfGhI0ODVvBR/76FJ741CyN+id4XWBp6M5/fXsDom0/jEGo5QHQXtyfMaJSpq2p8u0Xp
         t7Xx/VFDbzeEPz5ptuLnr9A6Xbnae29GPJ8lNyFGvMEG6viUWSr/CfoL5uLZpS3ofmNG
         0M/xBT75nma8+6A0fXvXawVgfOPtNzTZLI2CnOMRRiery5EPwKvZ8twygqBiDRxaqe/D
         yWx76+xvgWxRK4XxG79AcwRWOdOCqJ+w5Zwqgxvfk5uqnPRIl9Q4azaYfzUBhyoSrlNC
         6/pA==
X-Gm-Message-State: AOJu0Yxix2+eKVOMzSrQ2rgY4Fbn9eTrgcqaQEJz/Y1IfvPaLWF9w4Bt
	GJLy+QF1UeBJYFn44TEivBfs4tBTeBCBEwxfZqVEBv5+nVDfr3ZBewmNyfN4kQ==
X-Gm-Gg: ASbGncuS2uX8p/EA1DswxGHjdRVETJoeBt1y6caWRHp6fqSG4FyGfPcytGuamziCZpR
	7W/IlxYqIM6Do8hZVUzTs21ibcRrUO13VSlJ7dL7LsbTeF3wNgcVwbjymnG86P/sDact8TtTENV
	DKY/MIYRN+DuhMJw7Cpu7EssntBQ+W9+LcgSYf7HALs8HsUGC7/k3AzHLdposlmwp8fX1Mluq4x
	uVvIlo+Hs01XqyQsDntYR0gy7RQIZc1cm8lSrG6eru9hJ35oTcaBO/Lb0ugydT8clXwJwDKaVB5
	9Pdjvbb8TAfJok1lDXE6J7jFDffDg0SSEELC3ArBLcf6kcMMHz1HDL0AUPk2vrLZjF2UUY7Gaj2
	+cVmYDeh+Iyz92iFED5WblDnVV0Co4FhX7DTAU7XFyJ5SbVEC73W5pzRjfXEuwrWi/Os=
X-Google-Smtp-Source: AGHT+IFllxGxISK2J1a0ZIEtwZjwTJSi4lWzkDd8eStGcXuk1lvCVzK3qgixDfqD8xacoCweF3ljUQ==
X-Received: by 2002:a05:6402:649:b0:61a:ba92:f0ba with SMTP id 4fb4d7f45d1cf-61bf98e13demr2419841a12.9.1755816042996;
        Thu, 21 Aug 2025 15:40:42 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a75774618sm5930801a12.33.2025.08.21.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:40:42 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Joshua Watt <JPEWhacker@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.12][PATCH] Use a "fork" multiprocessing context
Date: Fri, 22 Aug 2025 00:40:37 +0200
Message-ID: <20250821224037.1673015-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 22:40:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17911

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

