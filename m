Return-Path: <jatedev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEA1C433EF
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 01:05:57 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web09.2768.1642035956913138754
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Jan 2022 17:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ncMAIKck;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: jatedev@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id v7so5192231qtw.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Jan 2022 17:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rV1E5mTwh9zb48D3vruqHoTbeczAiV+QLQCxeuartao=;
        b=ncMAIKckhx5s0y4FWWWpIL4mu6Z1Xco9fhDTbCgsTk06PbWb8G3I6TMVFnesp2Wi+H
         /2/N36l0q30wbmc3/Y+GUzJgyEeV8WqDpPuKbevZKl5BND9UdPNahZcMR9NUFWux3BI7
         F2Q1daHAmw8i1ET173JBW4XBpnFNTpWr5zhSq9lLJ0gSot2JwS3k1RsTVVwCBVmoT8SM
         SwFctNks3qq9E9ZKM1r5pEqxK2LAx4P96qN1zc2FAzeE2NAgT6idXW6CbwbQ0fgvcwUU
         4yjCWOytiiEzJqXcyIgP0gsqoE6Ni5yiYD5a+WNfddd8C4h0w33ycsk5KUqPGAVdM2TJ
         DhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rV1E5mTwh9zb48D3vruqHoTbeczAiV+QLQCxeuartao=;
        b=0LBB8EizLfxy9gF5CgN2w+nK6Y7h1s/l4gtgIcqVnUhIEaebZi/IQCsbFDd+/W4/D8
         3AOhR8niXqSaCaTxORvcYNG0fIiYE18ddV344CVMWdHsOZ2w6scvzaaWN97l0D6xfDMj
         luGrdEeE5CEyVy+/lLc3XnH/mRNcwFIJvm8S4bCBUB+FFB6WqOktiOJ6OndNb0S5RZ4p
         Lnsg3bC1timEsM4DYgPzsfmdEVR/RWPFCtJrVtyRSzjK4iZx+xq0M9WwqBLKhgkKts0X
         48mtsFh7//TcxWQzI8yS6PdzxdE8vdS1fTnRCspMSEJpMPb5Y8j5pJ/er2O9bP5oJ1XW
         Qc4g==
X-Gm-Message-State: AOAM530Rnv2na12hyuKnzPOhANBjpaheSNztJ+TqXK8UYEEpR4tBAOxp
	nlDfUbKEDBUiA4TMazd5GdOD6vGEeNc=
X-Google-Smtp-Source: 
 ABdhPJyawe2SLHmngqXsV9QeV9DnGECsLENagnlHdeyUEKAuU/cCy/7KFM8wJrAd/Ld95NfaYia+RA==
X-Received: by 2002:a05:622a:506:: with SMTP id
 l6mr1903478qtx.61.1642035955869;
        Wed, 12 Jan 2022 17:05:55 -0800 (PST)
Received: from localhost.localdomain ([63.148.217.19])
        by smtp.gmail.com with ESMTPSA id l9sm838680qkj.37.2022.01.12.17.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 17:05:55 -0800 (PST)
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Jate Sujjavanich <jatedev@gmail.com>
Subject: [1.46][PATCH] hashserv: specify loop for asyncio in python < 3.7
Date: Thu, 13 Jan 2022 01:05:27 +0000
Message-Id: <20220113010527.181-1-jatedev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jan 2022 01:05:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13229

Detect python version 3.6 and below restoring loop argument where
it is still required. In 3.7 auto loop detection is available.

Bitbake 1.46 is used in dunfell which requires a minimum python version
of 3.5. Omitting this argument leads to a regression and hang during
"Initialising tasks" at 44%.

Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
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


