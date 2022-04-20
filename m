Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1248C54EFD
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.7557.1650460936460769471
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SSWR/V92;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id y21so1194954wmi.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DtP5hvd97d2Ceil/a80jbnVE7gYOnRA1kiOcqF+OLk0=;
        b=SSWR/V92TfUFex7oGsZclEXpyrS2AiCNAYFe8c2Ps6kwZ4D8tLRqacw6jgpwhQUCOI
         AJhzRlCtwWFBvK6Doujp8yXvCVpjLc92v1WoumBGmfsC+ozd463+fO/J2RmS1lqMQJ4S
         0jI8Sc8S35CdhDFbg6MyaIpJMOkphCGI4PeOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtP5hvd97d2Ceil/a80jbnVE7gYOnRA1kiOcqF+OLk0=;
        b=EaHKBdpVh8YWFmpRLrYCbdhZqevnzZ/8FJob+NIvLAzefMODknH8uCO7aNx7IElK3K
         Ym5VNdOwxkxxibEF8rZ5fMOyFuyzvBCW+wqn46gjFjxq9/wOyjJowlpTcG0raVpnFRJ5
         4NM+QZmoFT0DQHi3GVOlgRferBenvbcUcGMhF8+0VwPtoTm2sPjuUoyN5gGg24QjoSW6
         J5hrSh9URNZt7xYs6iwdz1fDdpI7qRyc8GaDI6ZlNo6JBWFY+ET/QeK+c/J/z2idFec2
         ALDvukcq+lir0hR+iAUELVZf+LWGZDKYemzZDAlitZ1D+RU6a8vwx2IYyoG2Uvi2smen
         +lWw==
X-Gm-Message-State: AOAM5338/N6WHsu9qBhi4AP6GoOlqyL9PAAEpHqNY3VMZfCrQMx0Cwjk
	h5zDWOhE+cEi/Hm+Ip9GcGdgdB6HvxhymA==
X-Google-Smtp-Source: 
 ABdhPJyShx37z5clt/7ycyUyw+JrRco28BEaIZIX2sMwXo0Rj7KOdPFGCM+CPw4+TQvJVPtLxj/KDg==
X-Received: by 2002:a05:600c:1e86:b0:391:62c4:fb72 with SMTP id
 be6-20020a05600c1e8600b0039162c4fb72mr3588534wmb.119.1650460934387;
        Wed, 20 Apr 2022 06:22:14 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 05/11] buildinfohelper: Drop unused function
Date: Wed, 20 Apr 2022 14:21:59 +0100
Message-Id: <20220420132205.2530591-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13647

The function has a loop where the variable is never used which I was going
to fix but the entire function never seems to be called so remove it entirely.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/buildinfohelper.py | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 9c4215f9a2..c4ca267783 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1062,27 +1062,6 @@ class BuildInfoHelper(object):
 
         return recipe_info
 
-    def _get_path_information(self, task_object):
-        self._ensure_build()
-
-        assert isinstance(task_object, Task)
-        build_stats_format = "{tmpdir}/buildstats/{buildname}/{package}/"
-        build_stats_path = []
-
-        for t in self.internal_state['targets']:
-            buildname = self.internal_state['build'].build_name
-            pe, pv = task_object.recipe.version.split(":",1)
-            if pe:
-                package = task_object.recipe.name + "-" + pe + "_" + pv
-            else:
-                package = task_object.recipe.name + "-" + pv
-
-            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir,
-                                                     buildname=buildname,
-                                                     package=package))
-
-        return build_stats_path
-
 
     ################################
     ## external available methods to store information
-- 
2.32.0


