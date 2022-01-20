Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B6DC433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 21:38:41 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web09.2962.1642714720454055254
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 13:38:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=TSRl8VSL;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.52,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f52.google.com with SMTP id d5so4974660pjk.5
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 13:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SQLs4SS7bRl8Y3RxnML6Wmo4MGoP76/qgYNnzbPUeJg=;
        b=TSRl8VSLESBcnDY09XowFriKiDeWvfDA5W6yDaKb0uaT7l8CqF/9qpWLNTlMVaXnRi
         L7LTpax7igBPwxcBT56jYDoGK1Wh+PFwKdHzkJIInXxIPXBb9Fs08nqLqDlQXelvTg4M
         79XbqVhpd8qye8ruQeBdn8hewM4am8CUyFyfsTKY6jYRkJBB8FcaXZBT5Xbqh4ePpZX6
         SAThBTu+KZS819lB/etkZjYz8fi60dPTWQoAX4Ql2eyMKocByyUlddgnNVDWNPjyDusa
         NsgJUBJHPI7ojk5mFt3Ac+DtuCulazFeOI8Xe9JZIjPSl7QjZLQw0LWwEhCwTInyoiML
         GfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQLs4SS7bRl8Y3RxnML6Wmo4MGoP76/qgYNnzbPUeJg=;
        b=4lITcXSqIpwxHzH1kr7DKzjuMvYSsb1uRr4V6Z0iYmoXfO77S0c6infQgfOTHYVWa8
         JqMPXUO5gpbU8WRFZIdwzGLbQfi2tnZWbu5CUiNIDhLmOGwRwgRywdpc6m7nHUtaU3P/
         KnDGIUAXCJRYm7VpfnHVl4EhNy2Tvv/DzmlE+cGxVvBto+f4GbRWY3RQ6vxV1++DdoWN
         y+CGvyMhBWhrAbnzTCGnrQd0T/tvszeF0GS19rDjQuCULmLTLEPORTAVfHCPsqOv85dk
         DnWEQMt9t2VcmLd2JVlq8mccVcRmfikj/c/Lh2a2N3TEAhUXqrpWxem6RlbdppEQzp1U
         ++WQ==
X-Gm-Message-State: AOAM531Kp5kWwTC+I/M+uYM9uOXnHGBPRfGDsXHL+u393DbGijgpqp6U
	BBy4kNGInGSIyEZDopXvUOC9CNBY2iJPqfvGI0E=
X-Google-Smtp-Source: 
 ABdhPJwTprQnS3dHxM47zJ9hYl0vTAuimjIO3XHQXNMiq+HJ2uNmH6ExbsZcTHEft0L1r6kz7dparw==
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr13141567pjb.94.1642714719475;
        Thu, 20 Jan 2022 13:38:39 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 mt14sm3085215pjb.21.2022.01.20.13.38.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:38:38 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] hashserv: specify loop for
 asyncio in python < 3.7
Date: Thu, 20 Jan 2022 11:38:24 -1000
Message-Id: 
 <336395a20bded6633fa679332e537e1bd0f6b3b0.1642714447.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642714447.git.steve@sakoman.com>
References: <cover.1642714447.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 21:38:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13264

From: Jate Sujjavanich <jatedev@gmail.com>

Detect python version 3.6 and below restoring loop argument where
it is still required. In 3.7 auto loop detection is available.

Bitbake 1.46 is used in dunfell which requires a minimum python version
of 3.5. Omitting this argument leads to a regression and hang during
"Initialising tasks" at 44%.

Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/hashserv/server.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 56f354bd..04a48c39 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -12,6 +12,7 @@ import math
 import os
 import signal
 import socket
+import sys
 import time
 from . import chunkify, DEFAULT_MAX_CHUNK
 
@@ -419,9 +420,14 @@ class Server(object):
         self._cleanup_socket = None
 
     def start_tcp_server(self, host, port):
-        self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port)
-        )
+        if sys.version_info[0] == 3 and sys.version_info[1] < 7:
+            self.server = self.loop.run_until_complete(
+                asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+            )
+        else:
+            self.server = self.loop.run_until_complete(
+                asyncio.start_server(self.handle_client, host, port)
+            )
 
         for s in self.server.sockets:
             logger.info('Listening on %r' % (s.getsockname(),))
@@ -444,9 +450,14 @@ class Server(object):
         try:
             # Work around path length limits in AF_UNIX
             os.chdir(os.path.dirname(path))
-            self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
-            )
+            if sys.version_info[0] == 3 and sys.version_info[1] < 7:
+                self.server = self.loop.run_until_complete(
+                    asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
+                )
+            else:
+                self.server = self.loop.run_until_complete(
+                    asyncio.start_unix_server(self.handle_client, os.path.basename(path))
+                )
         finally:
             os.chdir(cwd)
 
-- 
2.25.1


