Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E21F88089
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 06:56:44 +0000 (UTC)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7710.1776322600838414142
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Apr 2026 23:56:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=fU70ruy2;
 spf=pass (domain: smile.fr, ip: 209.85.221.68, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d74086e5bso3159230f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776322599; x=1776927399; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUNajfwsU4HRcIffa6taXms3gSvKGc5MxUub1Dbvkf8=;
        b=fU70ruy2XQAjzeprz4qlqC4SiRFaemobc09jqbTLz7FRvgdLAlNIlwA/GA8Fq09zMe
         Vp/opz30I9WwOipDzmEaCKM+GcTdi0UM1iAw6Yob57NbbhtCJtEQzcIE+z0RF9FFLp3e
         CWUoD2Eq9Nz3/GwJyVGmqyzF40G2h0isqwC/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322599; x=1776927399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUNajfwsU4HRcIffa6taXms3gSvKGc5MxUub1Dbvkf8=;
        b=GVkNXI2XrEKpI96augJ5dPBXsIoI2d3QmpKgpjDYwLNF9yUNGQv6s+ekHwXObboZDZ
         ackLcVXb2OJcEjiMker0gDvSsYAeHRFV9dZ3nAc9/7SPqHRy3z54LtwhEEajWMoybs8s
         OCdwwSC3Fy8BsDbssSc3clw4ApyCYBYIo8NeZSh1y5A/Ud7Ym3q2a/t+bUiIcTlFXG3i
         AI12y1JCWCs7JxR0+pGm54kB7RVSDT9hxyCX/4VlRplQZLD4JLsjR8nzLHPCRR7u7HdV
         fw90DFmwVQ+cC9AXjYMfiUG6gcOT2xwaWRsIqLYrgK1dwag+Z4rcxZ7WWyapzdygbbtQ
         KA5g==
X-Gm-Message-State: AOJu0YxbVVf6tvgFMf6N4vBQi2vEaKRCA/qJafGFjH3nlDAA/7Ls8GIZ
	CXV1TSMOo5X/ztVq+jtoDR75EF+d1OT1PLciJZhZO8QUFikSueZ68lh7lAKE1etl47RIfQvNWmN
	sk3tHUqKWRyTd
X-Gm-Gg: AeBDievUEALWOgVX6BfGTtc90bEFJ2YSU1Ht8oqvKTqcRJaCgS5L/ERmFSoAyP+hTtg
	evDgS9xXT1hoNu2rEDH4qWBh2AqY3GokBfKMhLWk4MM7814fdKa/pjUkenM8BmUnlxLIM3lplwj
	sDRQSbwH67SG8Z9FKcVb2Lqz0FmwthAXtjO2ADyVn/y4yH8u0ST/RXRVS1B70yepruBQkE2cwRY
	mk7LRS3NALDsrn3sgxy9IC+8mh9U5Vrl480cbpJrsRdJ6XBWRqcUeFjWa/k1EMDi2CVyqHCZKn1
	vw5msVSqelhk1MtRNrKcjA9/MtvFlTCPcb+tee19NBa5PN6JqrqEv8pLSNYM6CmlF1Illryt5OK
	JL8qMxpHTyFCyS+iUa1lnuKU0DYN1snUN3uSLDLL0dg1Y/pJx413R5LQoBg6H8nzNR68MGTW9l/
	68D5ewjZaEVty88FDs48lCoTyOJVSxfn9eLxFW+B6X2t/jRcPNS0seFsy4CsU0fT9rCdtpbO6wO
	HAqSJkHfU13Sg9OTWzvty5N/d6ICUYaVq+iTg==
X-Received: by 2002:a05:6000:2010:b0:437:711c:8754 with SMTP id ffacd0b85a97d-43d642978e4mr37603776f8f.7.1776322598866;
        Wed, 15 Apr 2026 23:56:38 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e0091sm9838195f8f.25.2026.04.15.23.56.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:56:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 1/2] tests/fetch: Avoid using git protocol in tests
Date: Thu, 16 Apr 2026 08:56:31 +0200
Message-ID: <34a0e469414595ae145ee15f551245fb346d552e.1776322491.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776322491.git.yoann.congal@smile.fr>
References: <cover.1776322491.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2026 06:56:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19368

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
 lib/bb/tests/fetch.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e027705bf..3fca583e9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1148,7 +1148,7 @@ class FetcherNetworkTest(FetcherTest):
         # URL with ssh submodules
         url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master;protocol=https"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master;protocol=https"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -3487,6 +3487,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.reponame = "fstests"
         self.clonedir = os.path.join(self.tempdir, "git")
         self.gitdir = os.path.join(self.tempdir, "git", "{}.git".format(self.reponame))
+        self.giturl = "https://git.yoctoproject.org/fstests"
         self.recipe_url = "git://git.yoctoproject.org/fstests;protocol=https;branch=master"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "0")
@@ -3495,7 +3496,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
     def make_git_repo(self):
         self.mirrorname = "git2_git.yoctoproject.org.fstests.tar.gz"
         os.makedirs(self.clonedir)
-        self.git("clone --bare {}".format(self.recipe_url), self.clonedir)
+        self.git("clone --bare {}".format(self.giturl), self.clonedir)
         self.git("update-ref HEAD 15413486df1f5a5b5af699b6f3ba5f0984e52a9f", self.gitdir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
         shutil.rmtree(self.clonedir)

