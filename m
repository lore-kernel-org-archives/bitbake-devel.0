Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B8C00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 10:32:59 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.5415.1659695558968168310
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 03:32:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IIjoopaR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id h13so2764265wrf.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=xSuBCUQ5IyT8jvvSu5L3m+qUQyNgc+pMau4xWSucHo4=;
        b=IIjoopaRdkJ+3beGiv9q4gKGxpM6lNKb1iMWtXzGzms1tOPzAZ40IepKZgRDt9JyiO
         WoqjZZJm/s8YAFUtfqar9VcxldldNOJUCQg9E3LdWb3MxQCPVaPzdiFSqu0P4ca0eFkS
         m8Pyvbp46d6s6/bsDyHDNrMT0HxJYLvsekS8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=xSuBCUQ5IyT8jvvSu5L3m+qUQyNgc+pMau4xWSucHo4=;
        b=21KQRu7sWS6Y/mhLkGhfjm0Sk680NMvWRFPL8gftRiIMPuG1g7eAXSgTQm5wJmTSom
         grIa9SGiMlZsdh7pFYWh6PqbvYguj3u/CBFN7AkaFUxmK45/xAKRaYEcReVFM51V4sO9
         8fvIoxKu+lXuUxTbxEUagOfBBGMP9evWVt/wFPvMn1wMB2OdEQwgeW8lKb4OQhiG7yTy
         a1ppWvAp4/2OALKCxyv0FkKOD1mdJIh/LnwCGjZj8H+nr5GVYJshk8D9B9xbomDUDHgx
         FBB48ClYDMhhBnbXKyTva/VKHg8PHHRrO7YEulAm4cnmU4qNyXIiLY5PkJAZ8JpRoQ6j
         TC1g==
X-Gm-Message-State: ACgBeo0uAnezZWfE77PFQZLAvsjKq17RgAo7nK/isugOWB0WJupYsGfg
	u2K0hcj9+Ul57OkSKHP6Ka7wLmCdH1XdCA==
X-Google-Smtp-Source: 
 AA6agR5llCBPD78COLFQMjCLRCPwKD9VRkUs1RWWbX9daQB8JRNUhHwNXVOpZhDd+B+K6Sc8Tp3j7g==
X-Received: by 2002:a05:6000:118b:b0:21f:110d:99a9 with SMTP id
 g11-20020a056000118b00b0021f110d99a9mr3682404wrx.505.1659695557043;
        Fri, 05 Aug 2022 03:32:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f483:fcb0:1452:5a5a])
        by smtp.gmail.com with ESMTPSA id
 e12-20020a5d65cc000000b002207a8773b7sm4501401wrw.27.2022.08.05.03.32.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:32:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] runqueue: Drop deadlock breaking force fail
Date: Fri,  5 Aug 2022 11:32:32 +0100
Message-Id: <20220805103232.3674163-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220805103232.3674163-1-richard.purdie@linuxfoundation.org>
References: <20220805103232.3674163-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Aug 2022 10:32:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13875

I'm 99% certain this failing of a scenequeue task corrupts runqueue and
causes all kinds of breakage. I'd rather runqueue deadlocked than corrupted
and did weird things so drop this code.

We've seen builds where the deadlock triggers and it then tries to run tasks
where the SQ task already ran with very confusing failures. It is likely it
is this code causing it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e06246f741..98b73223c6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2240,9 +2240,6 @@ class RunQueueExecute:
             deferred_tid = list(self.sq_deferred.keys())[0]
             blocking_tid = self.sq_deferred.pop(deferred_tid)
             logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s blocked by %s" % (deferred_tid, blocking_tid))
-            if blocking_tid not in self.runq_complete:
-                logger.warning("Failing blocking task %s" % (blocking_tid))
-                self.sq_task_failoutright(blocking_tid)
             return True
 
         if self.failed_tids:
-- 
2.34.1


