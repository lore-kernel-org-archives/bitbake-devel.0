Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE3CD37AC
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 18:22:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18245.1778782934971796616
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 11:22:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JtDcxXjr;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so138078835e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778782933; x=1779387733; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMs3HwGCH52TgocaJ1vnFmeY2mvyQxAKzqUVi58bnV0=;
        b=JtDcxXjrJ2JgWUlnxCbGKQ/2xChqYe/Nm9W9at5V0iKWlPHPg3qJHnJ81GcEr17LtP
         TzA7iLtp0VYB944W25PVTHmlnnTHL/ikocxjEL2kmmamLkad6gQprN5Eh9SxWucPXGcs
         BJgrN6+I/3Ozayw1CxHiXMARSwzopHSbSBQiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782933; x=1779387733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMs3HwGCH52TgocaJ1vnFmeY2mvyQxAKzqUVi58bnV0=;
        b=nmOsRm1QYDVznmgTnehidQ2ovBrDAk6a3gvG3c7aWAE451wE1uPXLtwKj2WwwegvoQ
         jvXPF43ZtMw4k4Jp7EFRneE0izowF4KkNwdDmZq8dUT9eHYslqTSAEFsPCVvK8WHCV7I
         fApbKks3asEaJY4n7V4X5yEUEbc8hsK/w8jEDT5Iy54kAYrtfVCOjHJctsjrZOoyAuOu
         gNl2tMQk/pEvJ5SDgaWZpU/sOPCIqqaZsHksts2ZtecrcnL2+7oFsMWeQX8dUGk5lQEe
         OvOmbaky3sC5ng9Qyh64c5+gaMMUFxnU32ziwiNASycnqeQ/IxPUFRacrKCUxh5Bwpst
         +Ngw==
X-Gm-Message-State: AOJu0YzWwjXK4n5YhYYAxyBaIYNhQdJNhQ1TVsjr0pOvRz6rZidFebUi
	Z3/uOhwzxrUZBQASQdJU4Fq+UDLzwI3RmRu7WqyJFdePliGMeXxunzbPPUJ7AQvBCiXrfcAPDtr
	gEDPa5JM=
X-Gm-Gg: Acq92OFVIZbNLHQn5Zjx5z616gwjP/0xP/cV996YonBmy/l9hm2AHMXeoWyYdLJG/Qw
	1DEzMcaedj7aHtQPqXZfs53r4SGOM/lDbMxHTG8Ib1ON86kqEFuDOkCwSjiTFBR/6hAZz4ueHCW
	BUTuo4RSxnY2c/OrIiFThRsm3dsV0jaOWZLe1xOG7Sd8yCqKSpGAcGtgBBOK1lo0aRMnLBbRRg0
	tBvoFDIkrF8Wn0JwRQphpf6FsupJj84m6r40NoM5OUE6HDpwud8YjJUd4A8MphBCt7ixg5hVsmN
	5wRX54gpuviAScW+bL/ZtVAg09t3fkyq65sli9FfkiWUESNysmIeJ9mrE0tZt32sigwd2SrAiQq
	gwAbOohzSnvVjmq7Ybl7wjPJUSAfVkGxP8+BT7XMCEa86X8+914oDckO1Vi6ebeQfDS/cELdFzz
	/tClzNqmZdSUxBnMWkNqrUvhNhbEzG3EoISJrjJpO8oeuF1D0=
X-Received: by 2002:a05:600c:a417:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48fe65168a7mr5930045e9.25.1778782933400;
        Thu, 14 May 2026 11:22:13 -0700 (PDT)
Received: from localhost.localdomain ([45.11.68.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53804aesm7806275e9.15.2026.05.14.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:22:12 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] tests/fetch: Avoid using git protocol in tests
Date: Thu, 14 May 2026 20:20:53 +0200
Message-ID: <82abbfcdbda949851a03bb2cb2049ea689564ad6.1778782313.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778782313.git.yoann.congal@smile.fr>
References: <cover.1778782313.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 18:22:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19524

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
 

