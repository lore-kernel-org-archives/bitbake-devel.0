Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D759CD37AC
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 21:59:42 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8726.1778709575450165553
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 14:59:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Fpnf9CGS;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso83023595e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778709574; x=1779314374; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kflq12mqJSreOcA4DhpgzQ00XWdjyCTeUOl31UI1no=;
        b=Fpnf9CGSOe/91fMSMqiojSrejE97/0W+smtoG5ItqwFaCX2U0CaVZFJ3HHOvWTN5xG
         9pVHxrHAMlPm0e/tZ+pOL1HPB2YQM3POj9+7ZwwOAXpc+uke/hllg9JckUIoK44bvgH6
         y7aS++5DYUnQOAhAd4+dOIbfF5Yj0kFP8D5ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709574; x=1779314374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kflq12mqJSreOcA4DhpgzQ00XWdjyCTeUOl31UI1no=;
        b=oc4P7f229tYX3uBG6hG01b7JDVUQDFw1fdqvYlATl6RWsygs/JrIW+H49JcE/CB8Cf
         5rrur+YJ0Y871WE4sjGTjFolFPIe5EBg0xt3T9gQJNFTNLxuxRmOFVKoZDzizhXIxWOP
         OgirtuUNohNYj0hnsievWr+o+ByVY+UAn6EwlUpvZ9KKQDcFED2vM4TVXxskO7D3YbeC
         AymvBy/JNlvM6pCZR3aXI9QCeSxB96jyHaT475ekwM6oWDLFKpc1+6pKnuYPlsdfbPXY
         df62kZBbv85+mwBicFnb2iu+Adct+0JCgahEC2SOWMX34GMeI43w5+zyuAgRCeXxV49u
         WGdg==
X-Gm-Message-State: AOJu0YzanoE7x8E5w84rF1yNZ7jtUAoogUClK2Zs+LM5Z+dmYU7xCT0e
	cWoEMuUBu3PPDIrPPsYPisRDHfpyP4EfubREIOilAP2y7k2TlWXin+5Os7bec27wXVXR9MJ17Sd
	+zL+wNgU=
X-Gm-Gg: Acq92OHWpqzttSlUGL1QODrpenJCynAOd9vcF0RaOW9QeueZ5uTX9tGW/YCT4PcEpJD
	Taid7oRHvGLBX881BKOLe3QCh9hC7ynhHPnMzQzPY3S0i9kBiegJzjy0YRElhWNGfJQ0ZTyMa04
	KmTd5tkE1KneA+bgXChCbhHOLBVV1A6KQ4Nvp/KcclWRVZTlgRHj3XlhsBenX+Ids/BxZEydbjL
	aQF0PL2FdqicvkiFQEQQjxMQch+CcgTP9jq+gJdHQXOoqsIEEQXpzxJYFRxYgqixhbb6aw3P3zr
	OhZQ+9VSeoJu/3AuEGcczXUz/KzlOGJe5iBFNzA/X1e5ofjHnG5GVhnPpUsIau0xODNAWl2lusa
	zSr3jXgEAAmQbg9rrAUpkJFLFePb5GsmGahB9E5nJn4QJ7ArldQREB+c8spFca0UPu6Yq2LF/zt
	Ag2WymEJDIdR/P6Xj9ctiFOlkkyRZnsrWd8R+S
X-Received: by 2002:a05:600c:8b86:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-48fce9ab28emr68060235e9.8.1778709573684;
        Wed, 13 May 2026 14:59:33 -0700 (PDT)
Received: from localhost.localdomain ([45.11.68.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7184d1fsm4919815e9.4.2026.05.13.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:59:33 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.8][scarthgap][PATCH] tests/fetch: Avoid using git protocol in tests
Date: Wed, 13 May 2026 23:56:59 +0200
Message-ID: <20260513215657.2885852-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 21:59:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19516

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Two of the tests were still using git protocol to access git services.
For the submodule test, the upstream repo has been updated.

In the other case, we need to pass the correct command to the manual
git commandline, we can't use a recipe url that previously just happened
to work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5d722b5d65e4eef7befe6376983385421e993f86)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
This backport fixes failures seen during 5.0.18rc3 build:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3818

 lib/bb/tests/fetch.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b57cf511a..3775ab0f3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1107,7 +1107,7 @@ class FetcherNetworkTest(FetcherTest):
         # URL with ssh submodules
         url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master;protocol=https"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master;protocol=https"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -3267,6 +3267,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.reponame = "fstests"
         self.clonedir = os.path.join(self.tempdir, "git")
         self.gitdir = os.path.join(self.tempdir, "git", "{}.git".format(self.reponame))
+        self.giturl = "https://git.yoctoproject.org/fstests"
         self.recipe_url = "git://git.yoctoproject.org/fstests;protocol=https"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "0")
@@ -3276,7 +3277,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         import shutil
         self.mirrorname = "git2_git.yoctoproject.org.fstests.tar.gz"
         os.makedirs(self.clonedir)
-        self.git("clone --bare --shallow-since=\"01.01.2013\" {}".format(self.recipe_url), self.clonedir)
+        self.git("clone --bare --shallow-since=\"01.01.2013\" {}".format(self.giturl), self.clonedir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
         shutil.rmtree(self.clonedir)
 

