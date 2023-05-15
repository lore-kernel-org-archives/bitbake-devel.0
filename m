Return-Path: <peter@berginkonsult.se>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD5EC77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 06:47:10 +0000 (UTC)
Received: from mailrelay2-2.pub.mailoutpod2-cph3.one.com (mailrelay2-2.pub.mailoutpod2-cph3.one.com [46.30.211.183])
 by mx.groups.io with SMTP id smtpd.web10.82718.1684133220097063810
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 May 2023 23:47:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@berginkonsult.se header.s=rsa2 header.b=wXPt3S8/;
 spf=none, err=permanent DNS error (domain: berginkonsult.se, ip: 46.30.211.183, mailfrom: peter@berginkonsult.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=berginkonsult.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=CI3zH4TepuNNvEo8aMVAIOnows560jBTP32POz/knEc=;
	b=wXPt3S8/O/RNCsDdd0NYvWFjfuP0miJtnbA1BuKxW9f8jt30DOHkAsUe0zrLIb39Xua5Sk3wTn3Qt
	 YzogurmRgdBESzcMMwgPS42w7U4kgUtUt3SXvzleVA0zk7/GrqpkAT5a5DNvCAQTu+uqsVWQp6eapu
	 AEw9JSxZiTiodVCF7w/+W4N6nJN1hth0yERb3sG+FwwIdXK5gmUsk02QDz+XRdyhi+fcTxVTmiQdKr
	 46CZ2hdGBAZzATzPlfellhDQeVvrE3P12I3wdyeDBy9e4KXJ8Di0F4YEwhYzj8rZX5mkZkOCiysra8
	 txQVDvh3LELF9WmVycKjrVsaTGRpKng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=berginkonsult.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=CI3zH4TepuNNvEo8aMVAIOnows560jBTP32POz/knEc=;
	b=QQxE0E882ofXQP2Z9Ls2qbC1Ef8DWVGvU82o52KY55StefSJTBSLpmnOV7Wi/DbAWDgAzCT+BUkGl
	 zbC/A6dBQ==
X-HalOne-ID: 46b3571b-f2ec-11ed-a885-13111ccb208d
Received: from arn-pbergin-l1.. (c-799071d5.44006-0-69747578.bbcust.telenor.se [213.113.144.121])
	by mailrelay2 (Halon) with ESMTPSA
	id 46b3571b-f2ec-11ed-a885-13111ccb208d;
	Mon, 15 May 2023 06:46:57 +0000 (UTC)
From: peter@berginkonsult.se
To: bitbake-devel@lists.openembedded.org
Cc: "Bergin, Peter" <Peter.Bergin@windriver.com>,
	Peter Bergin <peter.bergin@windriver.com>,
	Peter Bergin <peter@berginkonsult.se>
Subject: [PATCH v2] lib/bb/tests/fetch.py: set initial branch
Date: Mon, 15 May 2023 08:46:50 +0200
Message-Id: <20230515064650.261681-1-peter@berginkonsult.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 May 2023 06:47:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14787

From: "Bergin, Peter" <Peter.Bergin@windriver.com>

If you have a host where the git config for initial branch
name is something else than 'master' the unittest will fail
as they assume the default branch name is 'master'. Fix this
by explicitly set the intial branch name at 'git init'.

Signed-off-by: Peter Bergin <peter.bergin@windriver.com>
Signed-off-by: Peter Bergin <peter@berginkonsult.se>
---
 lib/bb/tests/fetch.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 532adb941..132cd8e80 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -424,6 +424,10 @@ class FetcherTest(unittest.TestCase):
 
     def git_init(self, cwd=None):
         self.git('init', cwd=cwd)
+        # Explicitly set initial branch to master as
+        # a common setup is to use other default
+        # branch than master.
+        self.git(['checkout', '-b', 'master'], cwd=cwd)
         if not self.git(['config', 'user.email'], cwd=cwd):
             self.git(['config', 'user.email', 'you@example.com'], cwd=cwd)
         if not self.git(['config', 'user.name'], cwd=cwd):
-- 
2.34.1


