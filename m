Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A110A88E2
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 15:59:26 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51833.1774540756885852298
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 08:59:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N1qwsdVu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso10548675e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774540755; x=1775145555; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMw+bI+OU0jSKeXlW9PH+G6r7b4v29EbzTHPMqGV+7g=;
        b=N1qwsdVuEgDcM3EDT+iuSWZlQY+4AoZR3gE4Z6Ovfv7WOiKNmBWShvQqRPIinKGtVp
         YVt79+fwyaAgG2z6pvIpSQfbckZ4ZvUWFgVfKOGrexyfoqwJ7dk2AWajlHMExJlRuM5H
         qK11IYHdCofAsbihWbLCh0oe6GELM2HSb1BTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540755; x=1775145555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMw+bI+OU0jSKeXlW9PH+G6r7b4v29EbzTHPMqGV+7g=;
        b=K19lsiHgSFPxGyrgQKECfhGlDSK9Tokh+/yOCVWfxR9uTemu78NiqEzUr5jsJh+hIs
         pIoIhNFKUoRJFQh81rWzstVvJDTM0FMZDHEd755lsknwCBx/MOBBUjsiznWJCvNgVXD6
         dGatyhr+7W7PjQpQ12SCZFemXhHMWoVsrp7hP0gLxg/a+rR7j8FlfRhQVN5lRGSa7pRi
         IXyV5hd7ZENJfUZulaWz8o6v90ziP8l8MQHnpXWK1p6MVRqqAUIwcxfepjxIUg8mGEFk
         IATKcw4MxCmQ0dYcPARZZO1V444gYnKiMebOTBYct3kqllDMoGfKJhHc6jF5oU+RE43C
         WaIg==
X-Gm-Message-State: AOJu0Yyrk7QqAJv/D+TID1bMGFHzZzLSC0l6+sGbUk3tRLPORAwP3Woa
	j9eP0l9m3vclK2U6FvZrbBI/Go4o/3sZkkRFvM0PINTniBlQc3skxAPcDAT5R1gdeBdy5ir/6QR
	TwvVZ
X-Gm-Gg: ATEYQzyyTBe9ipJW+FVykiuhH/BIsDehyKDPDW+He8ckjBZuSfWt25OuXlc3Emt4HfQ
	DBbwSVrvn2wjQFdY0Pjl9L+6uEFr1ptqw2iaeZWzQiJkErsHNEwO96NbGUnPw4443SLf6LD0pW1
	2sW2IBAQEAI1RyDR6dYllIDfEj6NqpZ0Q36YqgmGqAiQ9NSfzrJxNvNipj1a55bdDAIHjOs6AmN
	2NiCFVcfwFwmypipmnfE1YSyXien9YkrRo8WAgnPBAFJaC3x1bbMdy02Cbw5VdOFXmXUfutgDtA
	uV9B1xbqP0nhCnrSMfu8K2w8Gt/FRTw2u40YalIYiZF0tmGePCE5gA/WZNYNITJUZB5ixiVXdMu
	c/cogmKLprp3HV57q4gE+SKN3gwS8IZKZS+LO6yJxb93a9S1ta/yF0/tK9fP0WFZkGCujnG7nOk
	NunZ/c7JA4fHE+y11CQoeYiq8WDFOMvM8NVu2rdbvRR42i3OpKSno=
X-Received: by 2002:a05:600c:c177:b0:487:2e8:69c5 with SMTP id 5b1f17b1804b1-48715fe2aa7mr120830525e9.15.1774540754526;
        Thu, 26 Mar 2026 08:59:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cc7b:6351:8dda:ecd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm84637215e9.11.2026.03.26.08.59.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:59:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git: Update packing commands to match modern git
Date: Thu, 26 Mar 2026 15:59:12 +0000
Message-ID: <20260326155912.1504786-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 15:59:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19239

We are using a git command, "git pack-redundant" which is due to be removed
from git. There is discussion about bitbake's usage here:

https://lore.kernel.org/git/CANYiYbHOczhRoJkOofFNQ6VA3BiyOF=QjffFBDvLn43Ts8B67w@mail.gmail.com/T/#t

As mentioned, we should switch to use git repack -adk. We need the k option
since we do need to keep unreachable object to retain history.

As per the manuals, we still need to run prune-packed to remove loose
objects which are now in the pack files.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 84fecdad07e..6457463402c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -475,9 +475,9 @@ class Git(FetchMethod):
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
             runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
-            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
+            runfetchcmd("%s repack -adk" % ud.basecmd, d, workdir=ud.clonedir)
             runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
-            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
+            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
             try:
                 os.unlink(ud.fullmirror)
             except OSError as exc:

