Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F34C433EF
	for <webhook@archiver.kernel.org>; Mon, 11 Oct 2021 09:58:59 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.9860.1633946338442486009
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EkKKUk3z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id m22so54426120wrb.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmoh7cwu/1MdDJeLQTLPbNacgxQKFOP5/sYKmCXfnFE=;
        b=EkKKUk3zrd43DjzuzuPybehOTIUQ+pYoawIa51ZoY0VsRRnkrDzX/us/yagWqVpT6e
         17tgA/8akvq2cdD6Nmp50XVg+k9/rELnF6HTaJmSixFcIuyJTnHnkHs27EdHXKjU/6fX
         dKL+jf/VbX5Tao5ULkVGIZ3eoLIcgbvwRoUbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmoh7cwu/1MdDJeLQTLPbNacgxQKFOP5/sYKmCXfnFE=;
        b=qt4p67EiEuRbpKjT75g2jKg3ZYZuis3IaOFBuYO8dewTGZdloCaZOZC/7WkZHYYeLS
         304oRyEMEkx/p/msJc/uHq6dI22vobH4J3B0wpKoUxHH6l7BVsh9E74Cbx6QJi2GPapI
         kAL2B3jr2yFPlTZiZghsf+Z7XdjyVhDMvidTpQ6V5caBfFMNQwHQbD1+abIaR674KKHo
         9JrC4hQz+6JAYQMO/DNT1lKFJI2xSiIzid4RkHsBYVN/rXYYWQALtA6PLp79swG22PWz
         sdF4NEc5lCjN92LCJ6gT6g3Fq8kDY5wLcLe1mw80gC7qQJ1cCKuczjb7g/dt7uaNEAs+
         tWHQ==
X-Gm-Message-State: AOAM532Z9i8j5W3oizBRpwgZNOiaBEzOCruHLMO1C1qtP30rkmDnUZPb
	SjZbBBqhry4sKJWLfAtCVRA7VjKGFZ3VSQ==
X-Google-Smtp-Source: 
 ABdhPJzeARQQACTBXaDc+8qh2F5+k/5XS6tS0A9wnJ8FThbVsprOSeDAZGltsBy1yVyZIzWlpzWvdw==
X-Received: by 2002:adf:ff91:: with SMTP id
 j17mr22968203wrr.132.1633946336738;
        Mon, 11 Oct 2021 02:58:56 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:86d0:36d0:28d3:a79a])
        by smtp.gmail.com with ESMTPSA id
 k22sm7533057wrd.59.2021.10.11.02.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:58:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 1/4] async: Close sync client event loop
Date: Mon, 11 Oct 2021 10:58:52 +0100
Message-Id: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Oct 2021 09:58:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12760

From: Joshua Watt <JPEWhacker@gmail.com>

Prevents `ResourceWarning: unclosed event loop` warnings when using the
synchronous client and python exits

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/asyncrpc/client.py | 9 ++++++++-
 lib/hashserv/client.py    | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 50e60d5c31..34960197d1 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -7,6 +7,7 @@ import asyncio
 import json
 import os
 import socket
+import sys
 from . import chunkify, DEFAULT_MAX_CHUNK
 
 
@@ -129,7 +130,7 @@ class Client(object):
         # required (but harmless) with it.
         asyncio.set_event_loop(self.loop)
 
-        self._add_methods('connect_tcp', 'close', 'ping')
+        self._add_methods('connect_tcp', 'ping')
 
     @abc.abstractmethod
     def _get_async_client(self):
@@ -163,3 +164,9 @@ class Client(object):
     @max_chunk.setter
     def max_chunk(self, value):
         self.client.max_chunk = value
+
+    def close(self):
+        self.loop.run_until_complete(self.client.close())
+        if sys.version_info >= (3, 6):
+            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+        self.loop.close()
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 1a67c6982d..8cfd90d6a8 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -107,7 +107,6 @@ class Client(bb.asyncrpc.Client):
         super().__init__()
         self._add_methods(
             "connect_tcp",
-            "close",
             "get_unihash",
             "report_unihash",
             "report_unihash_equiv",
-- 
2.32.0


