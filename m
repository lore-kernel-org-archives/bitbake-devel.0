Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8CC54EBD
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.209995.1672333656344471503
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WNe1WN4d;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id co23so17908703wrb.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPLeies7zgP/LVrJy8QhnmJjtMZCF7Pb0/MpC5IRMok=;
        b=WNe1WN4drTnSjcBUIoiz+k7QER5mmpsWSX03IS6o7uTODppiwQu3XgAXHcZ3BPqYdD
         zblAijtxqOMHNiPRYxC2m0mi2+koHl7Pl+MU2EbQncx5Q3rqO3YoE0J6wbuEqeiRkf8j
         JCrhye34nzs3hylBI+PQaWMYxFYmTYpmcGmEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPLeies7zgP/LVrJy8QhnmJjtMZCF7Pb0/MpC5IRMok=;
        b=BTixzUQrxmTxEZVerjKoxdQp8zm5Ax0qRr2HLWYSbrLZmm3H4k6TlwkPPrlNkfRyR9
         9cfWRaIFiGv6sQatDJgy6F+bm/uti7A8FIkI/8C7sqNdNHZ6Uuod29YyKf06HKwK6LVs
         Y1r5LfR80RnRU37ljJVh7EvLOSdCmJ3/MDyfiPmduDoKg5sTV2G1sKKiz115hZz86D0S
         R6bvX4WoU8yKBFBVE0A2+j7a+X3y3rsQZaChpnpfB0+puUrgIruJ+jHtnyUsWgw7ksbV
         L34PSpu52UNs6KF03hJbkCLesuJbM5iS6jcsEnpgkrsiDIWFkdgUDpPFexU29XQW/zwF
         qs/w==
X-Gm-Message-State: AFqh2konwHzIYwXPt5gTqCi8swZBvAP1yDsSvcolGjJQ78o7R7c+nzwq
	3zCHyH7PzVjRJH61VyEvA22ncqpbKNhqXQMH
X-Google-Smtp-Source: AMrXdXvYDgCmLC0ZcxG4maPkIaRAb4tgz20rkwYqusc02vZPkH9eRuJxGqNmj+qDBac+ikT2VLFZfw==
X-Received: by 2002:a05:6000:80b:b0:274:c846:4211 with SMTP id bt11-20020a056000080b00b00274c8464211mr19116093wrb.54.1672333654638;
        Thu, 29 Dec 2022 09:07:34 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/15] process: Improve client disconnect/idle sync
Date: Thu, 29 Dec 2022 17:07:20 +0000
Message-Id: <20221229170728.880367-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14250

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
index 3c909942aa..503d5dd686 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -94,6 +94,7 @@ class ProcessServer():
 
         self.idle = None
         self._idlefuns = {}
+        self.is_idle = threading.Event()
 
         self.bitbake_lock = lock
         self.bitbake_lock_name = lockname
@@ -173,6 +174,13 @@ class ProcessServer():
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
@@ -184,7 +192,7 @@ class ProcessServer():
                 self.cooker.clientComplete()
                 self.haveui = False
             ready = select.select(fds,[],[],0)[0]
-            if newconnections:
+            if newconnections and not self.quit:
                 serverlog("Starting new client")
                 conn = newconnections.pop(-1)
                 fds.append(conn)
@@ -392,6 +400,10 @@ class ProcessServer():
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


