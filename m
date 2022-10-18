Return-Path: <quantenkeks@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625DDC4332F
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 17:46:44 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web12.22.1666115201160064275
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Oct 2022 10:46:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Kh9RnFFc;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: quantenkeks@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id s30so21637242eds.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Oct 2022 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8J5g19bzDd/yFC3F6f3oDgwAY8ZA+dBu3PhLV1FErU=;
        b=Kh9RnFFc3PV9o5pGQ25szxLnxEZGmqdSC9osMk7tEz8n1oETZ26CfUlhgBBXEehqh1
         sXyr+fJJABrXS8Aq0ufLsEdF5SL50m45BhNfh2c5qBpCK9nbD+MPs1NhYB3PJd0vEuuV
         MVcV9xo6z39VIIINUdoFlas8XW0MwqvOylGHLn0mEkzjlFLK0Ojg+dPwSrFufioJSotE
         eYQ2hl0f2zR8TD+Fc0e4cFFREUaiGg7tyWMgDQsI6vxjaGGeQ6xSAyDHIsFTjzT6TCfv
         lfhtrfr/NMUBwkAm+1gXQbE/9aOGauSojZOfKFtCT7UAghaAppweSptdUjCaHpszTGVq
         Jlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8J5g19bzDd/yFC3F6f3oDgwAY8ZA+dBu3PhLV1FErU=;
        b=bYhwLx0I8MR2I2Pn/5JNb7jzf7zpxiDyEdoenQ1NGj2Fuu+a/HOa+LfCYyCUv8yAZ+
         RSpr+/FTl8OXgS0pBwZyk/or1glONWdTLZK4ex9FLthP2f1IkR1YZlHbYdFzQxPNUl3+
         cVhwmQNudjXepBRuh/7fvKrau78GH/IkOblsq9AwT4bisRyLBtpu7ZbwyVOsBVet5oO4
         QEg+uZrkJsWet2felvORcyuXW8adKKWoN4D3P6kMofG9fjdwp0gJO1vAPjlqtO5b165S
         xBTXLVHhJNquGJ4FeCgJaDu0+jhFN8kbv2fPaBSkgs24jyJDr0WPe27zaEgK7a7CYndJ
         oh5A==
X-Gm-Message-State: ACrzQf2B6yeS+znB+QDJYwluatXoWHUV4/TDzdMo0gCPlFjwUmVLRGUR
	YTWvCOxIcSqunCk3OeGqsTU4LdYIgxpJdA==
X-Google-Smtp-Source: AMsMyM7+pJruK68lQ2km23Io2nOL6lTKnqNgB8AlsDBcJtfosKOAxTQ6iCLMg0T/9jAg0RjPeIjWNA==
X-Received: by 2002:a05:6402:154c:b0:459:b29:da88 with SMTP id p12-20020a056402154c00b004590b29da88mr3770019edx.296.1666115199686;
        Tue, 18 Oct 2022 10:46:39 -0700 (PDT)
Received: from apu.fritz.box (p200300d0ff191200c3bc5fa022caa84e.dip0.t-ipconnect.de. [2003:d0:ff19:1200:c3bc:5fa0:22ca:a84e])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b0078ddb518a90sm7713147ejt.223.2022.10.18.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:46:39 -0700 (PDT)
From: Oliver Lang <quantenkeks@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Oliver Lang <quantenkeks@gmail.com>
Subject: [PATCH 2/2] runqueue: fix a typo
Date: Tue, 18 Oct 2022 19:46:12 +0200
Message-Id: <20221018174612.98621-2-quantenkeks@gmail.com>
In-Reply-To: <20221018174612.98621-1-quantenkeks@gmail.com>
References: <20221018174612.98621-1-quantenkeks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Oct 2022 17:46:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14041

Signed-off-by: Oliver Lang <quantenkeks@gmail.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 48e25401..338d1fe3 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2256,7 +2256,7 @@ class RunQueueExecute:
         if self.sq_deferred:
             deferred_tid = list(self.sq_deferred.keys())[0]
             blocking_tid = self.sq_deferred.pop(deferred_tid)
-            logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s blocked by %s" % (deferred_tid, blocking_tid))
+            logger.warning("Runqueue deadlocked on deferred tasks, forcing task %s blocked by %s" % (deferred_tid, blocking_tid))
             return True
 
         if self.failed_tids:
-- 
2.25.1


