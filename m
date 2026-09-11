Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE1C88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 22:18:22 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50927.1789165091942869887
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 15:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=QYfB0q0h;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so15587015e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789165090; x=1789769890; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kkI2oZvPkujyEJtYMkC2DwOuibdL1lKhe8C44FKDAeA=;
        b=QYfB0q0hodJ47ZSw35UhpmRnpLUjx2EfUDRvDamtpOpnd9nAvfTe23Y+59VBQjUUlZ
         faNGeHWdrS3Kqk7e80DNTqkC6tYrbkUnjLDFnnyyYkQPgR1SR2cVQxSmTZbHwOmZYyst
         2B133cEa/aOUTr7a7ZeS37WdRM8STR6SznLuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165090; x=1789769890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kkI2oZvPkujyEJtYMkC2DwOuibdL1lKhe8C44FKDAeA=;
        b=H8cVsYIP3BuCR5nIYxuKHiUX3Pq0Vl09LzZYuFHWvot5fSIi1GPEjQygMtVeqeHHX8
         FLnw4aZ4/VdR82XbZdWwbrLV0Nt6Wm7o/MLodmccpbhOXkxRyt832xWsxON+gVmbUSO6
         iI2gjGjXwfuD7UIO3NGze7Kt5w1vGnhlXqw1sWt+76/UXHS4H9uAsYAhKePEgH1jxVvm
         V9TkWDA4M+iQo6m6LyS0ChyMhy69uIf6/X6nkdHQljMYP26nXh50goEG0blUHvtqg6mj
         +A5KqMKdjn5I6HPltRuj927hqlBMfeyDod5Cu/60UwopnOhSx1MpknAPUIfMSlvkmUNK
         TOnw==
X-Gm-Message-State: AFuF++l8lvXB58UHQtZErv3BobD4JDI8ljMvEzFE0EEV84HwpDBDtr1G
	OwKjqA7GUxghZucGZOMR+PWoUib6LGWgLKX6Qpl3FQJ1pDV4F653NZGZXG5/Hx/eaujKcc2xcJM
	blA881mk=
X-Gm-Gg: AYBFou2XrgqxDy28j5pW4XP/YlkEL0Gy2SMrjPnjhko0gqERciZP/LJ82T8hzvNAQak
	AEPyTqcj3nkIYo23HfAvjLyRCsa1yrry7CrcZLfSklXFXbB7H42rqpXmSJ9l5KW2lOydC7ZxV9p
	DvUccV2Yw2loEIYL+HPO3ffdHTn8zMDNdv60w295vxEQ8Qv5umfHIg0uP+NzLB1YF+DY2XZXX6U
	UTmwJocmAGWtLR0CNKownYvSE8PZdLFGxHA+ll/Jjwees5c491kgyWpUpvwaMnTeB7WVMkLQtv3
	AzVPkxC6RQ3ccRfdz55ejYMnrtaW6XMtYSSkLMdDttHRVCHBte11t0qy6C6LnpKBkAMlJZreax3
	44JXZOFEINiwfobZL2xZUkBr2l4pjkjQoWJ6ou+VAcwxhrh0KwrwaWTQCixslStaUz+F9zBhxpY
	zPVHU5MjtZgNCuK7uahaUQ9HuUW2KJt6NjxP30sj/yM3tc3oDK++npmE8kaPQgkXVvkprxTWfe+
	HDb5U2YAC8tC4r0TlnnKeJpOELmcXaetpiHPQaj90wZqLu6nnA77344NtVJsi+51Bfq0Li+Sag=
X-Received: by 2002:a05:600d:6501:20b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49e61988e73mr53699555e9.11.1789165090122;
        Fri, 11 Sep 2026 15:18:10 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33e34sm78235165e9.0.2026.09.11.15.18.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:18:09 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/4] fetch/gitsm: Store the original url data to fix relative gitsm paths
Date: Sat, 12 Sep 2026 00:18:04 +0200
Message-ID: <ecfde933b848b5120858b922236f57238a6e1fed.1789165002.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789165002.git.yoann.congal@smile.fr>
References: <cover.1789165002.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 22:18:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20185

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the gitsm:// url contains a git submodule with a relative "../" path
and the fetcher is configured to use a premirror, it will fail as the
host name encoded in the original url is lost and the correct paths
can't be found.

Save the original url data in the new data so that it can be consulted to
fix this kind of edge case.

The test case change that follows this provides a test of this functionality.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 58872250f72f5760b4126552bdec5497f5a1a1f4)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 1 +
 lib/bb/fetch2/gitsm.py    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f2835397a..e89f5be2a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1011,6 +1011,7 @@ def build_mirroruris(origud, mirrors, ld):
                     newud = FetchData(newuri, ld)
                     newud.ignore_checksums = True
                     newud.setup_localpath(ld)
+                    newud.origud = ud
                 except bb.fetch2.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
                     logger.debug(str(e))
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index ef1905333..e866edeb8 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -89,7 +89,10 @@ class GitSM(Git):
 
                 # Convert relative to absolute uri based on parent uri
                 if  uris[m].startswith('..') or uris[m].startswith('./'):
-                    newud = copy.copy(ud)
+                    if hasattr(ud, "origud"):
+                        newud = copy.copy(ud.origud)
+                    else:
+                        newud = copy.copy(ud)
                     newud.path = os.path.normpath(os.path.join(newud.path, uris[m]))
                     uris[m] = Git._get_repo_url(self, newud)
 

