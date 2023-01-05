Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18693C3DA7D
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 11:52:01 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.10982.1672919519735209988
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Jan 2023 03:52:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V4fFsTU3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1119197wmb.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Jan 2023 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s178e0ho5oi4zYnwmLT1VGJlaIUAqDM6uI6iDoIF6q4=;
        b=V4fFsTU3KPuxbtCentmczLcCGBl4cx+p/ABtYTKi0bf+fAILrTJUsa8dGUlN2G0RcQ
         kLPrjka79kTFDtYs8+D2/YOQBKttMw1fSJjYG6jcpCfllNYL87SyGBtQvGEYpkgNqFuh
         I5nXgcak7C7vHimnq5iy8+wuvjm19eO8XQZuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s178e0ho5oi4zYnwmLT1VGJlaIUAqDM6uI6iDoIF6q4=;
        b=Ppoa4heggJedUw45pIyMVYU7KA+XLPuG7wd5WzOfRJXrUOaX7arArA+dKRqibv4J6v
         wO9DMzGcEItwkEUirUDmB1DyghGRIJqPpHBX6TVq64AXResm238aHq8L1DDc6AjaGCOY
         ki6Tri1tAY8JOJcJtVivWi/+OKALnVeEb2m3B4tYH+kpikFFqasJXZJxGovblnvGppn5
         7nIHBf09g6zlVd0a/RWaV3RmYQaxuwLhfmcRdhun7VU9LvhG7YYVKF/nuxi9rtrNeQUI
         1gJdLYpe4vzNmXCEGnhkjQ9csyctIEhH2l4QkLtBNhUYxJA46XJLO106+ALK3XmVjClt
         cxCg==
X-Gm-Message-State: AFqh2kpCYEXzN0vhrvhzhwGBAPCCYqPiBqTSnsobidYP8G4o8lq4Lbne
	xEFfAJAFVnSQ3cA7t2KqEIR0mM4eM/bFx+Sv
X-Google-Smtp-Source: AMrXdXvAAFCjOc0LC0O6KN82UBpKTqfVTd0450UISvF/nffx/nnu8itkUuITrMyDXTzuTRWuDWNlzw==
X-Received: by 2002:a05:600c:3485:b0:3d0:761b:f86 with SMTP id a5-20020a05600c348500b003d0761b0f86mr35550682wmq.28.1672919517988;
        Thu, 05 Jan 2023 03:51:57 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:990c:167e:ef8f:7586])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm2363988wmn.28.2023.01.05.03.51.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 03:51:57 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker: Clean up inotify idle handler
Date: Thu,  5 Jan 2023 11:51:56 +0000
Message-Id: <20230105115156.1212181-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230105115156.1212181-1-richard.purdie@linuxfoundation.org>
References: <20230105115156.1212181-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Jan 2023 11:52:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14288

We no longer need to abstract the inotify callback handler, remove the
abstraction and simplify/clean up the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 6 ------
 lib/bb/server/process.py | 5 +++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1d347ddc52..d2c42c858d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -190,12 +190,6 @@ class BBCooker:
 
         self.inotify_modified_files = []
 
-        def _process_inotify_updates(server, cooker, halt):
-            cooker.process_inotify_updates()
-            return 1.0
-
-        self.idleCallBackRegister(_process_inotify_updates, self)
-
         # TOSTOP must not be set or our children will hang when they output
         try:
             fd = sys.stdout.fileno()
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 78fdc6cf71..4422fd7311 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -158,8 +158,7 @@ class ProcessServer():
     def wait_for_idle(self, timeout=30):
         # Wait for the idle loop to have cleared
         with self.idle_cond:
-            # FIXME - the 1 is the inotify processing in cooker which always runs
-            self.idle_cond.wait_for(lambda: len(self._idlefuns) <= 1, timeout)
+            self.idle_cond.wait_for(lambda: len(self._idlefuns) == 0, timeout)
 
     def main(self):
         self.cooker.pre_serve()
@@ -389,6 +388,8 @@ class ProcessServer():
             nextsleep = 0.1
             fds = []
 
+            self.cooker.process_inotify_updates()
+
             with bb.utils.lock_timeout(self._idlefuncsLock):
                 items = list(self._idlefuns.items())
 
-- 
2.37.2


