Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E6C5479D
	for <webhook@archiver.kernel.org>; Wed, 11 Jan 2023 17:51:11 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.31119.1673459462869185826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 09:51:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UYH+lgAG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso13331900wmq.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54OEdukqKEOfMbADDKl5J4CKxi77QrkgEnNnZwmTOS0=;
        b=UYH+lgAGavmY7MsYYQhDf+7MFthS1GX1kkLY+DPKEy3QjvN3nvgGJnL2kMmUrWr5uq
         0iy3zfsNrF+LgOCSEb1BT/1cQBYSIXT9MtSVvdwqoJjrN9CwRG+7XsOoPgBhqwz3GE5+
         GcoeYgs0lgslED53dIHoIi4ka3sLfIRp/+1DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54OEdukqKEOfMbADDKl5J4CKxi77QrkgEnNnZwmTOS0=;
        b=LByWTxkZzYw4ZA6W0A1hQmIz33GyjtURrpdRRLsTKNXhXenqcZNYKaUtQ+lg1JK1x6
         Ai7MjdJeXwS/yVF0TuDgk6D6XBVXpvx4HJcpFUKuDPszAlmWny6UHEr7oylfQV8uyUsM
         iXbpPttGNaI48t/u9RGpC5hyFgc0RBpKzUJYLqJfC/ZzHiyBW6PXTEwE9z6WPJgQ/Dkz
         cKvMthwQkz3nfL5ikqyDQL9i3NYN4Jc+SuZCvPpjZ9BYStCDYItR43LRvyIszQBKwydQ
         dgPBXR5e0zIYg4w++3/DHMX/ZS3X48q8xG02NbkEmMQvp+MnyzB6XnboKq4buXGLBDLc
         ko2w==
X-Gm-Message-State: AFqh2kolpTY257/nYZ6QsDOqNiioNdAET+h3TrppqknafyZ+mtg8r46x
	sPQP2c2kuIGcPC8JSi5zmTxj4b2J7DT+9U/k
X-Google-Smtp-Source: AMrXdXtkt3+qRF7BZkZIqfdCLeZjjJlFHB1KJTG2l86FRlRaL7c2CcK0cJp0Of4VtKKZXlnmK2OhSw==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr54065642wmj.30.1673459460664;
        Wed, 11 Jan 2023 09:51:00 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a11f:4d56:748b:c178])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003d9f14e9085sm11689624wms.17.2023.01.11.09.51.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:51:00 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] server/process: Move heartbeat to idle thread
Date: Wed, 11 Jan 2023 17:50:56 +0000
Message-Id: <20230111175058.1526619-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
References: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 17:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14302

Rather than risk the heartbeat event code locking up the server control
socket, handle it in the 'idle' thread with the other work. The aim
is to remove it as a possible issue with some ongoing hangs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index a44ec36139..588a3ae04d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -441,6 +441,28 @@ class ProcessServer():
                     serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
                     self.quit = True
 
+            # Create new heartbeat event?
+            now = time.time()
+            if bb.event._heartbeat_enabled and now >= self.next_heartbeat:
+                # We might have missed heartbeats. Just trigger once in
+                # that case and continue after the usual delay.
+                self.next_heartbeat += self.heartbeat_seconds
+                if self.next_heartbeat <= now:
+                    self.next_heartbeat = now + self.heartbeat_seconds
+                if hasattr(self.cooker, "data"):
+                    heartbeat = bb.event.HeartbeatEvent(now)
+                    try:
+                        bb.event.fire(heartbeat, self.cooker.data)
+                    except Exception as exc:
+                        if not isinstance(exc, bb.BBHandledException):
+                            logger.exception('Running heartbeat function')
+                        serverlog("Exception %s broke in idle_thread, exiting" % traceback.format_exc())
+                        self.quit = True
+            if nextsleep and bb.event._heartbeat_enabled and now + nextsleep > self.next_heartbeat:
+                # Shorten timeout so that we we wake up in time for
+                # the heartbeat.
+                nextsleep = self.next_heartbeat - now
+
             if time.time() > (lastdebug + 60):
                 lastdebug = time.time()
                 with bb.utils.lock_timeout(self._idlefuncsLock):
@@ -459,28 +481,6 @@ class ProcessServer():
             self.idle = threading.Thread(target=self.idle_thread)
             self.idle.start()
 
-        # Create new heartbeat event?
-        now = time.time()
-        if bb.event._heartbeat_enabled and now >= self.next_heartbeat:
-            # We might have missed heartbeats. Just trigger once in
-            # that case and continue after the usual delay.
-            self.next_heartbeat += self.heartbeat_seconds
-            if self.next_heartbeat <= now:
-                self.next_heartbeat = now + self.heartbeat_seconds
-            if hasattr(self.cooker, "data"):
-                heartbeat = bb.event.HeartbeatEvent(now)
-                try:
-                    bb.event.fire(heartbeat, self.cooker.data)
-                except Exception as exc:
-                    if not isinstance(exc, bb.BBHandledException):
-                        logger.exception('Running heartbeat function')
-                    serverlog("Exception %s broke in idle_commands, exiting" % traceback.format_exc())
-                    self.quit = True
-        if nextsleep and bb.event._heartbeat_enabled and now + nextsleep > self.next_heartbeat:
-            # Shorten timeout so that we we wake up in time for
-            # the heartbeat.
-            nextsleep = self.next_heartbeat - now
-
         if nextsleep is not None:
             if self.xmlrpc:
                 nextsleep = self.xmlrpc.get_timeout(nextsleep)
-- 
2.37.2


