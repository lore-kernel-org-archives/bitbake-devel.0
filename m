Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web08.4413.1627406518975937341
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 10:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JGe0slnz;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id b1so10135963qtx.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2Zk1CLgIaQu23jNuiQv2DkbeeXsAyHpUu5vV7TGTR04=;
        b=JGe0slnzvX/tXbOMYjEXYxM5qXh/sd1ySLH14vXOSd+AOFjJBURvKc8J39SmAMfjvY
         U1REG4R6WSn49eEDVXZfQa4+FfWpzut2jxmJr068OwoN7NIb34OjwrmhTqjjHDzm+r8Z
         qBvPWuLXJ52KfOYQZJ5gCZqein8b12I4kNa/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Zk1CLgIaQu23jNuiQv2DkbeeXsAyHpUu5vV7TGTR04=;
        b=c7KkOu7dM+Z5K9BdGnzxGThACTp/1olHntq7SgLgb1E2iBM9niWf3CDbTZ3fYVfHKS
         bWUC9n5ZuLQOcRLgZEp1/oOAYUWzNa9MXRC+0RAnSg16YQyyejZGKyGv3ynzr7flOQLM
         RuRG5r6w2ZJ3AOuzYLVnYfGCJYr4SfmiI42aV8pZzr3/lZuRsNcr9Yt7aT2NjE4hxE5r
         RPPiYo7iwCd62JwMq/jSlSTxEECmm+8U5ZxDAgaGtWTENOuWdtvywjCUf6b1hvKMJFiA
         P03XfxlFEgptjM+EeGpeof5hgwBe3Tyz55+Bash35QgZ+RcS0JBfX2sfICqtDpx/1AW7
         2EbQ==
X-Gm-Message-State: AOAM532HVICCxD6FE/hFofMx0rFuRhwSmapXf2gTCGrqYzutUZ13s/Ny
	MOUwaPSCO0nC9mIHKVxj+7ofhQKesbnUMw==
X-Google-Smtp-Source: ABdhPJxwobmutub8GDRP/P0NSKPwFbZXeKDEaU5du2AY3rFJLwVovmmT8zfjf5vrnI7M6xKvlXkJIA==
X-Received: by 2002:a05:622a:183:: with SMTP id s3mr19997680qtw.169.1627406517885;
        Tue, 27 Jul 2021 10:21:57 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id f2sm1648719qth.11.2021.07.27.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:21:57 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v5 1/5] asyncrpc: Wait on writers to close with Python 3.7+
Date: Tue, 27 Jul 2021 13:21:41 -0400
Message-Id: <7fbe0a840ad544ec0f4e84a376bae3423da1c7a5.1627405824.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627405824.git.scott.murray@konsulko.com>
References: <cover.1627405824.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

The close() method of an asyncio stream writer is not synchronous and so
may return before the writer has finished closing. In Python 3.7 the
wait_closed() method was added which can be used to ensure that a writer
has finished closing before continuing. Sadly in Python 3.6 and earlier
there is no way to guarantee that a writer has finished closing before
moving on.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/client.py | 3 +++
 lib/bb/asyncrpc/serv.py   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 3eb4fdde..82b6068a 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -7,6 +7,7 @@ import asyncio
 import json
 import os
 import socket
+import sys
 from . import chunkify, DEFAULT_MAX_CHUNK
 
 
@@ -47,6 +48,8 @@ class AsyncClient(object):
 
         if self.writer is not None:
             self.writer.close()
+            if sys.version_info >= (3, 7):
+                await self.writer.wait_closed()
             self.writer = None
 
     async def _send_wrapper(self, proc):
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 4084f300..2c219c1e 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -75,6 +75,8 @@ class AsyncServerConnection(object):
             self.logger.error(str(e))
         finally:
             self.writer.close()
+            if sys.version_info >= (3, 7):
+                await self.writer.wait_closed()
 
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
@@ -193,6 +195,8 @@ class AsyncServer(object):
             self.logger.error('Error from client: %s' % str(e), exc_info=True)
             traceback.print_exc()
             writer.close()
+            if sys.version_info >= (3, 7):
+                await writer.wait_closed()
         self.logger.debug('Client disconnected')
 
     def run_loop_forever(self):
-- 
2.20.1

