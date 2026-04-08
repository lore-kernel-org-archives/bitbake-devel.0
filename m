Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED2FD5F81
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 06:31:32 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.100362.1775629881717708037
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 23:31:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b2D03PR5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso29833595e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 23:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775629879; x=1776234679; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQx3NhFbgug23PgZREp/JkNrTjV2vcSiBY92N4lH4Es=;
        b=b2D03PR5Y98ek15eB5pz2WVk4Lg/tS1PzaJ5ycCJxABkWVFJnYSOhHQ0Vrlg7BUOGA
         qwewEZCFwXx2SYz17iLQDqC7KRCuwrVeY5jZR7VKh+xmn/RvvknbOUKWC42ur5I7WcO3
         ly/875yDcGKhssyRPU3rXfEktI+J3VtKGsTd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629879; x=1776234679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQx3NhFbgug23PgZREp/JkNrTjV2vcSiBY92N4lH4Es=;
        b=qQg+b60cTcEU9TSTtXNJ1191bLORvgf0x5bcBSzfYgo5yMU/sAfEBo5c0LIlMb32o7
         WPpTNDFAhs6Yxp9ZKqGLuLqlTfvB4kezryVW6BFKhowY1k5O7hR475n4knwXU+Y+gXdC
         QDaoX757fcwA1Vu0bM5cOUoMDY+fbHos8yTlIOcuzX5g3xhyr+3YzGK/ar4KKoT/B5rG
         V7H6GeOD6wS3cbO2BjY8/h1o9hY3Gb4dzPjAC6jV8jjktVzHAfPYSs2uxPg7/Pv5dKus
         Dq9svR2Yjf7nqpI+HFNZsGYyPlnyru8rK8glXZ9AY/6rwr7VdC7Q9CIS6m/D0+gC3TSd
         5OHw==
X-Gm-Message-State: AOJu0YzMOpoDF6J9O0VvxrmoiwJEKgnx9Gf9nuZn01XAnnq5vsqsHhim
	TRySQiU5iH1sFaFoLdrtsv68L4ewvJT2vpcidXgMW73EK+xKc279MXZkNRqEfWzQHcqsC6yhvbn
	b9Q0m2Ck=
X-Gm-Gg: AeBDiesslMLANw0V80B14e4bo5xOelkyARxKRyhtVrCS6safio+LvzrjCzp3/k2sXXt
	P+sjx6zI1QboA9kNsdCooeBXswO1lXpAXU7cKVDS3OYlHlUjOnw69cc8SA3gzcV1kAEkyX3kOxR
	agURqmK+8QSyA5rzFncWgDghg1Vd9hJm08nUHfdkLCOleGURzFFVbVXDltzLAGBZKz7DcghCLWX
	lUYvIk30rxhGV8bpv39mRu5H3ZA281o4jMI794zdd3h7JChGxjWrp2EIXqqsWGCJkCwFMK5dysU
	wphq/w0jK+VGEGDdJdbG62Y1La9hjS5jUYFwqIOaO7IQ+xZ2SKEppiCLduPi0BpBqsnDAN+tsnv
	nsASll2B2IKXcRx0Kh5Mm88Jx1PubEZfhca6VJXg1vukLB2NaiGMetjrfu2y1NHdEo9QuT+jTeW
	hKiEdrYtZqh6+ac9Edj6iQ8Eyqg0aruj1NCYhJPyOs9ddYP9xYs7gF
X-Received: by 2002:a05:600c:a413:b0:485:6bcc:87dc with SMTP id 5b1f17b1804b1-488997b3a9amr206324055e9.14.1775629879345;
        Tue, 07 Apr 2026 23:31:19 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3a70:3593:db41:cfe4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5db2ba8sm10394995e9.24.2026.04.07.23.31.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:31:18 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Avoid using git protocol in tests
Date: Wed,  8 Apr 2026 07:31:17 +0100
Message-ID: <20260408063117.1336484-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Apr 2026 06:31:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19355

Two of the tests were still using git protocol to access git services.
For the submodule test, the upstream repo has been updated.

In the other case, we need to pass the correct command to the manual
git commandline, we can't use a recipe url that previously just happened
to work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5b3fc8a4191..077f741e1d3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1114,7 +1114,7 @@ class FetcherNetworkTest(FetcherTest):
         # URL with ssh submodules
         url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master;protocol=https"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master;protocol=https"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -3482,6 +3482,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.reponame = "fstests"
         self.clonedir = os.path.join(self.tempdir, "git")
         self.gitdir = os.path.join(self.tempdir, "git", "{}.git".format(self.reponame))
+        self.giturl = "https://git.yoctoproject.org/fstests"
         self.recipe_url = "git://git.yoctoproject.org/fstests;protocol=https;branch=master"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "0")
@@ -3490,7 +3491,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
     def make_git_repo(self):
         self.mirrorname = "git2_git.yoctoproject.org.fstests.tar.gz"
         os.makedirs(self.clonedir)
-        self.git("clone --bare {}".format(self.recipe_url), self.clonedir)
+        self.git("clone --bare {}".format(self.giturl), self.clonedir)
         self.git("update-ref HEAD 15413486df1f5a5b5af699b6f3ba5f0984e52a9f", self.gitdir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
         shutil.rmtree(self.clonedir)

