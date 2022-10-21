Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A03BC433FE
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 08:34:16 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web09.7835.1666341246372482039
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Oct 2022 01:34:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=I3dDNRPQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C2D1A1C0003;
	Fri, 21 Oct 2022 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1666341243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SfAk9ZzcRvmgO5cH8zr+lBIbP23smvZtjaRuX3GhXRI=;
	b=I3dDNRPQiBhq40LHCK6jOYzWA2Ff7QI4WXq7GXbOs501uzjGrkj3GBmroRgVbJgK5sMytJ
	2HLQlHuSWWra6MtKikzkyG8KfAumy5B7e1P2S6zR/KEII/9prvI0fjM6NjWO0jCNWSKHXq
	RDM2tSXQvi0F1TwaWHKr/rcZH076uight7LJW6bd/MuxPQmgdG2xFrzRYenJv8n4E2jJZ+
	7BIwpPMP9l/H139D+wUW4OAnTeK1+vESOiN288g74CgG/SUVzyy/GiOOQuD6TXtXAlsLYi
	n7K02nBg8VLD7kJxAoN++Jq2VGVDLtFXYng6uOCITuXU9iGM4uPr5TnxVF58nw==
From: alexandre.belloni@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] bb.tests.fetch.GitShallowTest: always allow file transport
Date: Fri, 21 Oct 2022 10:34:01 +0200
Message-Id: <20221021083401.2940299-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 08:34:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14044

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Following CVE-2022-39253, distributions are disabling file:// transport for
submodules. See https://git.launchpad.net/ubuntu/+source/git/tree/debian/patches/CVE-2022-39253-11.patch?h=applied/ubuntu/jammy-security

[YOCTO #14941]

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 lib/bb/tests/fetch.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b4ed691f3319..4ef2ed2b66b8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1865,6 +1865,9 @@ class GitShallowTest(FetcherTest):
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
+
+        self.d.setVar('FETCHCMD_git', "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat -c protocol.file.allow=always")
+
         self.add_empty_file('asub', cwd=smdir)
         self.add_empty_file('bsub', cwd=smdir)
 
@@ -1898,6 +1901,8 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('asub', cwd=smdir)
         self.add_empty_file('bsub', cwd=smdir)
 
+        self.d.setVar('FETCHCMD_git', "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat -c protocol.file.allow=always")
+
         self.git('submodule init', cwd=self.srcdir)
         self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
         self.git('submodule update', cwd=self.srcdir)
-- 
2.37.3


