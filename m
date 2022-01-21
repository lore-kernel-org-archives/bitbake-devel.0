Return-Path: <jatedev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B0C433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 14:52:18 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.12890.1642776738182266692
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 06:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oy6smDqQ;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: jatedev@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id hu2so10611719qvb.8
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvru5MqR8BRHozmhYvkeLTAd8zRRu0/vLZcqCp+MEiY=;
        b=oy6smDqQw8nyFMhvN6y6WCtjdlOAVdSiqcK1MwW/1Rh4TvZXQ760KkXObKEnl6lnij
         5ILpKSDj2xK59GcGitdndrNeKwDQvn48vBan3jCYPZWD1yO52UH4kQyord70Wy8BPs2l
         4QX01vlLhTC9DjVz0gun+Xz1iYCzXPlElzGrD07/mmZpPGcbJv+E/7+AQrQfGAa9CG5/
         LX7ctG8yuS692wkWvZowD314SIhqUzTfOCJXI3FSVSK2ZCjvQNoq4M+vVY31msxT1nr5
         w/Yswamt/QJbDNldhhrEBjB676PVn+FqpyqXpRPjOj1WM9LC+oVNmoIW7uosz6urDFzq
         7Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvru5MqR8BRHozmhYvkeLTAd8zRRu0/vLZcqCp+MEiY=;
        b=b/efmoJMmEa25yn0Vt0ulELiWXKBkL2f0PUGKKah4bQPZhpiIqbhPg2clUQqrohpq/
         0f9YqOng0DWL3J6OUdoUGJXBETZy96PP6tg08tvOnvxrXYA2n51f45l2fM88E8242Kzu
         pthg1gYROa/K6TQAAbBX0ik1KtPsW/z6J6Jsio3Wiva1kHoRFsQ/f2rhOM+ZL1Im2s8c
         lUhxhVWEaTMIm/PzoB5zIsyOGT/paA1LEiW/D2cwduCRzfszxFWZDlhihaUngExi3I9n
         zP5HYsbg2WNFo9fWVYisD2h/KAei8JY0m3pAKQuI95CUbzTr+H3bNOA/NFP5EfprKOAE
         UBOw==
X-Gm-Message-State: AOAM531d7Jk5ct74+6pyVdyjsdtqW4rBm27+UrL2NCXzhDxSTQLn7wgN
	LcnxG0A+Or3/o/te1KDHoVlfafbifjw=
X-Google-Smtp-Source: 
 ABdhPJx+LTHUyPZwG3rYy++1gn/r+tupb5AvjxCplK0yhnLFXdnWZVhNCdBNQc7ejc0pnCndcs24oQ==
X-Received: by 2002:ad4:5f06:: with SMTP id fo6mr2071053qvb.100.1642776737071;
        Fri, 21 Jan 2022 06:52:17 -0800 (PST)
Received: from localhost.localdomain ([63.148.217.19])
        by smtp.gmail.com with ESMTPSA id
 bm34sm3230693qkb.7.2022.01.21.06.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 06:52:16 -0800 (PST)
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	steve@sakoman.com
Cc: Jate Sujjavanich <jatedev@gmail.com>
Subject: [bitbake][dunfell][1.46][PATCH v2] hashserv: specify loop for asyncio
 in python < 3.6
Date: Fri, 21 Jan 2022 14:51:42 +0000
Message-Id: <20220121145142.763-1-jatedev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 14:52:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13268

[YOCTO #14697]

Detect python version 3.5 restoring loop argument where
it is still required. In 3.6 auto loop detection is available.

Bitbake 1.46 is used in dunfell which lists a minimum python version
of 3.5. Omitting this argument leads to a regression and hang during
"Initialising tasks" at 44%.

Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
---
 lib/hashserv/server.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 56f354bd..f38a22ad 100644
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
+        if sys.version_info[0] == 3 and sys.version_info[1] < 6:
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
+            if sys.version_info[0] == 3 and sys.version_info[1] < 6:
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


