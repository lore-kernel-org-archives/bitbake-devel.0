Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169B3CA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 16:56:43 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.24163.1757523402483562239
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 09:56:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=qvOjJq0T;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77256e75eacso6401896b3a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757523402; x=1758128202; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2E8Xah+NevlT/en1Le59hSqyMcWsGEXV1qmguU1AoA=;
        b=qvOjJq0TSefxu+wQ97nzmYHjaQAJ473/xnKUcuuRlN3/RC3MtlwuCKdlmP3GbffrJJ
         yD9AvhPg9XktDt0i+uZc+TKrlKfVhVvQxncHOGVxM4HC1RAxyosa6d3dpc+5vaGbs0OB
         XbxeMxMMU7g6UU1A1LY7NHfGzvlsJmA9veg9nA+dspOt41QXhs/4eDbzmzJ3DRkZtK7U
         yCkyYuhUDBxBUsOWRwSEDe8qWFp6zY4Hq9f2XW3LGLKeC/tyv4yKYOsDpM96W33Qw9a6
         hMJg1lk4lvECCyvaBwD+pEXtI73x2Qdj7HuJBnnYC4YsQ8Lbr7PgNWeKNDoVYHNfEfDx
         0Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757523402; x=1758128202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2E8Xah+NevlT/en1Le59hSqyMcWsGEXV1qmguU1AoA=;
        b=P8YV8r/8Wcih6hsaAfCPTx75Jb3zoRCALrC+wZbxbbFtpc0aPeCfJ3AV9J9nSB5nDv
         MckGSyCtuq8U0UBTkHXQBvkZJ13vmOF9LYWRkA8y4cFMeBSB70xyFkEHdCBfG4KlWfsn
         m2sJ5MOCC3jICwJL9goot4fmFeoh+qiYOWUUvomcf7QAqa/nJvdcLr/deMTryZNCxSMq
         SxC04nky8XWSFsqJlxH3hZF9Rp9IegZFl+ai99/7ptgU5di1S8/s7pjuJVlxvzzfie+k
         lJRhw1HHl2kcB1y8d0kMkyUVuCcI/HXGXN07TkIVlI/xFAq4EuWlvzM2pn6j8bhlIYpJ
         Z1+g==
X-Gm-Message-State: AOJu0YxkJ4usGsxJU7dUynQlk78L0Lvo3BI6WbSDnMwjldfJXBbMDmiz
	Z+/HAdCcsaUhCkNjYWe0ShCLLnfmDfNkPj/2RkkMaGv2ltVTqAwttqM1lhLHgwDa9SG/3bJvIKG
	x5pT6
X-Gm-Gg: ASbGnctSKM1Pii/VOt8MXEYsjVxVkALBG9CEkyE/+c7haIthog+AXOkMTyResZ87/IM
	IWLWKN7VvT0K4MVAGmJG1Pr87qKTlrqafj/VjfEDSU6cxYMVlnNfB9y+iT4sA2GSH9WINApw8sx
	rwU+0IbAEoAelc5HsEIKqLG8TGci6vkx8yDJkdkwX+8C3zsZvAEltdxQUxHDCueu8N9ST3wHIEJ
	1wb3ZsgyQo4x93NTovU4p8VOz0C8v/VCbIJwXRMdPfRFUR3pqxWMk41AGuX7W4F9igXchIxJhrH
	4zJwIVm3+oNXydPZe8BuyjLg0nz6xQwZAKalL08fJmqP7qFoDLK9Y9gGiNYPAQ2AuH8X9uJx6/y
	yd9tra82QSjSSfw==
X-Google-Smtp-Source: AGHT+IEfx6atLT2prUeH1YR1VVPF/OspeLXqfcKKj+q0v1L7l55dX0Y/DpCeoM1Se8oIDnkMKCOvcQ==
X-Received: by 2002:a05:6a21:6d9f:b0:24e:a19:7eb1 with SMTP id adf61e73a8af0-2533d5fec6bmr19018646637.6.1757523401302;
        Wed, 10 Sep 2025 09:56:41 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466118071sm5673608b3a.24.2025.09.10.09.56.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:56:41 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/3] Use a "fork" multiprocessing context
Date: Wed, 10 Sep 2025 09:56:33 -0700
Message-ID: <aed7ceadf6a3566b4aaf3059022ec54bf7ac8e74.1757523235.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757523235.git.steve@sakoman.com>
References: <cover.1757523235.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 16:56:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18004

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


