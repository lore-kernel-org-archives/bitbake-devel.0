Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E77C44506
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 18:13:43 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18305.1769019218043206380
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 10:13:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DLrxYjRN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so1225275e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769019216; x=1769624016; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii1fuv2xtjJuf/Jnh7AsHPVBrbrXnjoMAXH6nrEjf4A=;
        b=DLrxYjRNYlRaGJPfaLXvz5q6inucCFCyQtmvjWt51uY9l4lcoToRxKnuez/P8BqUO0
         hH6Sxgv9a/N3FTG5WvBWbeGfgmzqum/4ppX0KMjTkOgKsfkrGVncckX8H8MpINTc2vCo
         8oo/L2vPVszB4gH0AJghD3sljcNU4KUGckEpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769019216; x=1769624016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ii1fuv2xtjJuf/Jnh7AsHPVBrbrXnjoMAXH6nrEjf4A=;
        b=pegI+dQTMUyYUrwPUxmk1xesb7e2bUT/cGnxshXoeYyiH/stMppcWTNdDQ0FPNe1FQ
         vg0WpQg5tl1qm4Z82hjFHjxJdgtWYRDnjhzbtploLOgxUGD+wouuMgAdPddRHmGW+xpZ
         RffZFdU+knBAd/qJNqW4oEfNGPgHJFUP9EqKpJzvhSloy4Jd/JfLXdXo4eC0NnxC6BA5
         NPUftuzBlfjcTjtXDBMNqfh2s4m0u0W9oL//U8FoozjNuIPRARJyjsVMmcMvR6jbevF2
         OfxkaWe7elAJQ7GjPFCsVFuRy/KJObPSeiYhdFetGLHd/4XKDg7H1SGmkkmkdqzoMOkn
         5/RA==
X-Gm-Message-State: AOJu0YxV968RPFatuRhf18wc0lL25wMspA96D/xR+P8DXkmyz5wYi7Wg
	SP4soiH/DEVGxth8PJ9eiYwQkW/WxS/JbBhKblXj56sMEVYEhxWAV1jm4aDYG3J7WHT7W7aQY6Y
	PP/9eaZc=
X-Gm-Gg: AZuq6aI7r5/nODbCueNvcvSeTTsL9zMBiQ4oSUaETyUwMJQNeod2G8sCGu7bO7hhMiY
	N7ZZTmbU3xTvCu5lpk0NtPLKN0X+7sUJ39LVhUayBNt+f8zh03eqRN7tDPqar1AojpTOozfUcem
	rvWV6r7r+PmqeR1sjE6YHx9o2fIy62vgefExpzICp4OxAMIoPurWwohpezXdFXXEqmxB0cwYX3m
	e9Pc/YcFiJ2qMaeKCZAh0y6GmhumVAa1+VCxMDcLdKmTTW1UK7IlKNcyf/BmDqLDjYCRK+dm6uy
	jM4yHGDkGmssdlSrIPJ9J5uoTtZk84RlxxSLwbcQxXgEE1kj/UimrIzB5VXhSwsnPeK/6EdNkb0
	AkUVkHJULYzdQc/yUiVXQMYMMUyN9ISlIUmEuaXKtn4XeBInvsKu5Vlh8uY+uZa2TXF2yWrN+yz
	lii/nidmpSwiSdy1Nhe1I+nRnmf+6Iin89AdvfbkQ=
X-Received: by 2002:a05:600c:4f4d:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-480279e9e70mr250183515e9.29.1769019215781;
        Wed, 21 Jan 2026 10:13:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b41a:7081:80dc:66f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424b18cesm28840955e9.4.2026.01.21.10.13.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:13:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/npm/npmsw: Disable npm and npmsw fetchers due to security concerns
Date: Wed, 21 Jan 2026 18:13:34 +0000
Message-ID: <20260121181334.1616926-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 18:13:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18839

We've been made aware that are security issues within the npm/npmsw fetchers.
The issue is that the code accepts data like checksums from the upstream
servers, rather than verifying it against local data from the recipes. This
means the upstream servers could feed aritrary data into the build.

There have been maintainance issues on these fetchers for a while and despite
asking in multiple forums, we've been unable to find anyone to help fix the
issues. Until that issue is resolved and we can be convinced the fetcher is
secure and modelling best practices for reproduciblity (inc. mirroring), this
patch disables the fetchers. This has been discussed and agreed by the OE TSC.

Parsing will not show errors but the recipes using these fetchers will not be
available. Recipes will be skipped at parsing amd will show an error if a user
tries to build a recipe using them.

[YOCTO #16105]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/npm.py   | 5 ++++-
 lib/bb/fetch2/npmsw.py | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e469d667687..15057da7d3f 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -39,6 +39,7 @@ from bb.fetch2 import URI
 from bb.fetch2 import check_network_access
 from bb.fetch2 import runfetchcmd
 from bb.utils import is_semver
+from bb.parse import SkipRecipe
 
 def npm_package(package):
     """Convert the npm package name to remove unsupported character"""
@@ -150,7 +151,9 @@ class Npm(FetchMethod):
 
     def supports(self, ud, d):
         """Check if a given url can be fetched with npm"""
-        return ud.type in ["npm"]
+        #return ud.type in ["npm"]
+        if ud.type in ["npm"]:
+            raise SkipRecipe("The npm fetcher has been disabled due to security issues and there is maintainer to address them")
 
     def urldata_init(self, ud, d):
         """Init npm specific variables within url data"""
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 2f9599ee9e2..5cd16ce5d23 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -32,6 +32,7 @@ from bb.fetch2.npm import npm_unpack
 from bb.utils import is_semver
 from bb.utils import lockfile
 from bb.utils import unlockfile
+from bb.parse import SkipRecipe
 
 def foreach_dependencies(shrinkwrap, callback=None, dev=False):
     """
@@ -64,6 +65,9 @@ class NpmShrinkWrap(FetchMethod):
     def supports(self, ud, d):
         """Check if a given url can be fetched with npmsw"""
         return ud.type in ["npmsw"]
+        if ud.type in ["npmsw"]:
+            raise SkipRecipe("The npmsw fetcher has been disabled due to security issues and there is maintainer to address them")
+        return False
 
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""

