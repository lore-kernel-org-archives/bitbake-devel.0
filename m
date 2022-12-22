Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9AFC3DA7A
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:34 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.60903.1671752851891527583
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BVQAvzxY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id l26so991997wme.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfSl+kt8RGg2crfqf5/uzyzyb3yLXfwRohuX1rbJIVg=;
        b=BVQAvzxY7KNY6c5WzRBSBYfMIlDos27bnEKKQTVF1STEXGjvh8Gx94BwAKbjur1qPH
         cel311oYH1dRvK6Jzi7pQnTi1l1Hi9BEE51Db5KFcpTC1ut+xU7YbMS2FOtWIBIyJGfo
         6ZoP9sDcrtR0FOqrF8lNoT14GwU2PhIgOi56U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfSl+kt8RGg2crfqf5/uzyzyb3yLXfwRohuX1rbJIVg=;
        b=y7/kHsB8TQCdGOZnLR6ZpOO9vPMCiAMeCj1loPcyl0p0AL7A5fTkxWCHTqSoaUG++p
         Nfrrisg4LG67rNyC1qSXYa+eoBCR+9kL33WGjxzl33suUoTJpbvMJK4vFNfMAiXnibQW
         bAHhL/QB5T75Ak71CtIA980qIezfWRsHpvQftTwYsYfo97uz51hPowA2lmyMLO19ObL5
         wENdRVayoJfS4hq9ihGsD1fPx09DD4ADIahmvSAqJ2b8zvOS1muvS49RwbKTfuWaYilJ
         Hcc1W8xMqcjIw19JlPvYaA3qeLM++5MnZVh+N0lsx+3cQk8eCMIWZa4d+74Q1gBy5SGa
         NcjQ==
X-Gm-Message-State: AFqh2kpIyP/bzXfbGUi76mTjFnkg/BGoqkB3dvBn/bA5I8m61KulWrdg
	aGhmJHzbVJviDeeIZ9wCE0EXpLLnVqVzrzTf
X-Google-Smtp-Source: AMrXdXurBr1ZtSiUarI2aY/dPANjzxXmwMbuwaLL3i+pU0LPZj7z/Zt/NWLwubg8xxoXzjY2fJKnGg==
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr8203809wmq.5.1671752850267;
        Thu, 22 Dec 2022 15:47:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 05/10] process: Improve client disconnect/idle sync
Date: Thu, 22 Dec 2022 23:47:21 +0000
Message-Id: <20221222234726.579702-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
References: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14235

When clients are disconnecting, we need to ensure things are in sync with
the idle thread. Use a threading event to show when things drop back to
idle (there is only one always present idle handler for inotify). Later
patches should be able to clean up the inotify handler to work differently
and avoid hardcoded values.

If we're not idle at client disconnect, shut down the server to solve
the dilemma. Not ideal but shouldn't happen much in practise and would be
restarted.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 6f43330fae..895e39cd0f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -90,6 +90,7 @@ class ProcessServer():
 
         self.idle = None
         self._idlefuns = {}
+        self.is_idle = threading.Event()
 
         self.bitbake_lock = lock
         self.bitbake_lock_name = lockname
@@ -169,6 +170,13 @@ class ProcessServer():
                 self.controllersock.close()
                 self.controllersock = False
             if self.haveui:
+                # Wait for the idle loop to have cleared (30s max)
+                self.is_idle.clear()
+                self.is_idle.wait(timeout=30)
+                if self.cooker.command.currentAsyncCommand is not None:
+                    serverlog("Idle loop didn't finish queued commands after 30s, exiting.")
+                    self.quit = True
+
                 fds.remove(self.command_channel)
                 bb.event.unregister_UIHhandler(self.event_handle, True)
                 self.command_channel_reply.writer.close()
@@ -180,7 +188,7 @@ class ProcessServer():
                 self.cooker.clientComplete()
                 self.haveui = False
             ready = select.select(fds,[],[],0)[0]
-            if newconnections:
+            if newconnections and not self.quit:
                 serverlog("Starting new client")
                 conn = newconnections.pop(-1)
                 fds.append(conn)
@@ -384,6 +392,10 @@ class ProcessServer():
                     del self._idlefuns[function]
                     self.quit = True
 
+            # FIXME - the 1 is the inotify processing in cooker which always runs
+            if len(self._idlefuns) <= 1:
+                self.is_idle.set()
+
             if nextsleep is not None:
                 select.select(fds,[],[],nextsleep)[0]
 
-- 
2.37.2


