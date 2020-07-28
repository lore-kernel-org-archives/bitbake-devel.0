Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.1312.1595977157777561624
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jul 2020 15:59:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=TFDIc2VB;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.49, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f49.google.com with SMTP id mt12so863530pjb.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2020 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=g2XibcHqImATj/GdqDxPC/HJ3EYuiRii5Z5As5vL4Iw=;
        b=TFDIc2VBsFV/gzMR7M05o4pHtJwYCb2r6vbEkIADPxI3fzs2ZCRWFlrgOV12Nu+nid
         VcACBFEiObJvAG6UHHzkgZAgJej8xngf0HvyE3630ld4xyzGL45570QlFsP7mmpNfiDa
         +QEfZ+0m7Aawi3ILO9b1MxcMBJcvDestglz2Gbuz3XYaESL4Jdf1VT8+GrZ9ynWt4nIb
         CNW0IPXSxjqIsComnBSulzdFMBTFsKKfmZTc5QWxt/UqYDEVAJosGZ7OxsdfE0VOkgrl
         n/vbGz2jl6MDB4S6wO/ZqZmWpVHg+ze7++qmVb4u7FWCBUufoJRfLLT85eiY8EPbHpWa
         2zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=g2XibcHqImATj/GdqDxPC/HJ3EYuiRii5Z5As5vL4Iw=;
        b=XTmU8jWhPDRMgoSGTV3q3jJidyXZJZSbMUljhwpsL1FJtpFU77uKZn8p22o41kO+Pq
         /pH2LdOB08ikzIpz5zBMHmWwBS8g+aFtuyGD4IFmeDBDVsYPR8XtmMI2lr8lcmS1AmZx
         Hfnnfvyu+4yZQz6wl5tPjavtTFz7uYgFNxbE6VhHG78Fa6uSC4zkfNgkjRX8dqmXoUjn
         IFHIr066kWWzSvp3ev5ghIbWahsxipBqaHjfzWXqcH8vkZRCZp7E9C918NFDULjOn/Qx
         LspPRq2d32vDpv6egVx437VDxkfiFZiY900EA8ZKeyfeyA5JcvBVAXHfNXxb68lM3Hdn
         QSug==
X-Gm-Message-State: AOAM530pJlygMLZa43sR+yJEE4OEEU9Z596DeLOkAm10fKRTCPZUs9Y+
	mABTJFZ3qeuJLEPvKN1qYk2yhypTlLc=
X-Google-Smtp-Source: ABdhPJxXNWwuwFnyA1sgoz+wqoAJvcX11B4h7e451Agrd3Qhy+5+34StwM2q8GeZQyfBdZtEuUBSFg==
X-Received: by 2002:a17:90a:318c:: with SMTP id j12mr6414663pjb.25.1595977156422;
        Tue, 28 Jul 2020 15:59:16 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id p11sm157658pjb.3.2020.07.28.15.59.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:59:15 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] server/process: Fix UI first connection tracking
Date: Tue, 28 Jul 2020 12:58:56 -1000
Message-Id: <e6c02aa8eb2e91bd2b02e4274952d3e064a89998.1595977046.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1595977046.git.steve@sakoman.com>
References: <cover.1595977046.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We're only meant to be doing UI connection timeouts on the first connection
but haveui changes for each connection. We need to add a specific variable
to track this correctly and get the intended behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e7c387c2e2fb2cc3ca1dc9d2029362909c326d72)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 9ec79f5b..5a87f082 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -47,6 +47,7 @@ class ProcessServer(multiprocessing.Process):
         self.next_heartbeat = time.time()
 
         self.event_handle = None
+        self.hadanyui = False
         self.haveui = False
         self.maxuiwait = 30
         self.xmlrpc = False
@@ -188,6 +189,7 @@ class ProcessServer(multiprocessing.Process):
                     self.command_channel_reply = writer
 
                     self.haveui = True
+                    self.hadanyui = True
 
                 except (EOFError, OSError):
                     disconnect_client(self, fds)
@@ -200,7 +202,7 @@ class ProcessServer(multiprocessing.Process):
             # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
             # one. We have had issue with processes hanging indefinitely so timing out UI-less
             # servers is useful.
-            if not self.haveui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
+            if not self.hadanyui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
                 print("No UI connection within max timeout, exiting to avoid infinite loop.")
                 self.quit = True
 
-- 
2.17.1

