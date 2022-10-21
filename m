Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B219FC4332F
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 09:30:46 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web09.8129.1666344638714893909
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Oct 2022 02:30:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ScstuF+X;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A6CD3240015;
	Fri, 21 Oct 2022 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1666344637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gWHNE/tlGY7tE83jChW+YqwkbajXn4UstXScaruPxic=;
	b=ScstuF+X8zPOBJDacxNqNBQ1DRraG849z99sgROoQN9485ZKdA5KVVDEvCRcIrLSfAU4c1
	zrfiCGIMtapoOF5B6MWJ5JFOfCddqKALo3TvHoI3RTtFbOEAlkJvQP912P/OscH2TCrUtq
	R4lUaiFoOdIeCOHVRmzUEUyCA6CcolRzf4aiDi27Nke+hDy8bLOJ0N7ByhOZrH04K5dPzr
	eCHcUxjpWNAYHzQDnJLIAvGIjwSLCVw+iJtu4rx1Vt2yrEjepv2xPXgP6OqLYPOGAQxQrB
	J87TZOvGLypMfD9ngaD5G54IuQNdwBRcu8KzXJ7NRbiVyQVEeRs+BpOECcTRqw==
From: alexandre.belloni@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] tests: bb.tests.fetch.GitShallowTest: allow file transport
Date: Fri, 21 Oct 2022 11:30:33 +0200
Message-Id: <20221021093033.2949077-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 09:30:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14047

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Following CVE-2022-39253, distributions are disabling file:// transport for
submodules. See https://git.launchpad.net/ubuntu/+source/git/tree/debian/patches/CVE-2022-39253-11.patch?h=applied/ubuntu/jammy-security

[YOCTO #14941]

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 lib/bb/tests/fetch.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c5f6ce9dabdb..d91bb595699e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1870,6 +1870,8 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('asub', cwd=smdir)
         self.add_empty_file('bsub', cwd=smdir)
 
+        self.d.appendVar('FETCHCMD_git', " -c protocol.file.allow=always")
+
         self.git('submodule init', cwd=self.srcdir)
         self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
         self.git('submodule update', cwd=self.srcdir)
@@ -1900,6 +1902,8 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('asub', cwd=smdir)
         self.add_empty_file('bsub', cwd=smdir)
 
+        self.d.appendVar('FETCHCMD_git', " -c protocol.file.allow=always")
+
         self.git('submodule init', cwd=self.srcdir)
         self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
         self.git('submodule update', cwd=self.srcdir)
-- 
2.37.3


