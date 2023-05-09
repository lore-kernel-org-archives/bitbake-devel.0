Return-Path: <peter@berginkonsult.se>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3CC77B7C
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 12:18:02 +0000 (UTC)
Received: from mailrelay6-2.pub.mailoutpod2-cph3.one.com (mailrelay6-2.pub.mailoutpod2-cph3.one.com [46.30.211.187])
 by mx.groups.io with SMTP id smtpd.web10.30424.1683634672373788501
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 May 2023 05:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@berginkonsult.se header.s=rsa2 header.b=Bh6XhaSp;
 spf=none, err=permanent DNS error (domain: berginkonsult.se, ip: 46.30.211.187, mailfrom: peter@berginkonsult.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=berginkonsult.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=jFp92Ut/goG/lTfqSDJjAmMte/jNvtwGjveMONDPJkU=;
	b=Bh6XhaSpMzXu2HXGPEtTk0xpE0K1WrdAaRp1gwSwxSfU+rIfbW7o9hDjzJfOIFKBeGkCJ98DVm0tz
	 Tnrk+hTkWB82ueQ2LA7sBmFKJ9BB2ILJ4ZHlRH2lmELngMTzSVFcMexccoWJHoBX6XVFhOfsj2L32J
	 FCWkbhlkW/4wkAhd+htZMQNO1i5WVEWq7hPkPQhX+Yqo6z8gFEKdA78HwafSQ62P1kW9Ivv6mqc9wD
	 PWMXWP/ug1M4IfnkeJCkZ1Kb+KsLcMM/V3ESkA9jUY6MGYDgljtTeA79uKDBS3gCo8HAophW9saBOv
	 +mw9vxXCCLt8hcnikQ8/uAd5xHwBUoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=berginkonsult.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=jFp92Ut/goG/lTfqSDJjAmMte/jNvtwGjveMONDPJkU=;
	b=uc65YoRU8rSzsKu2DcBuxYppYyZOt01UAV1A9AdZBNrBGT61V2KzrhhKP/GOoRszEghsQZpBrqf3f
	 cJ8m3c7Dg==
X-HalOne-ID: 80f58830-ee63-11ed-8b9f-6f01c1d0a443
Received: from arn-pbergin-l1.corp.ad.wrs.com (c-799071d5.44006-0-69747578.bbcust.telenor.se [213.113.144.121])
	by mailrelay6 (Halon) with ESMTPSA
	id 80f58830-ee63-11ed-8b9f-6f01c1d0a443;
	Tue, 09 May 2023 12:17:49 +0000 (UTC)
From: peter@berginkonsult.se
To: bitbake-devel@lists.openembedded.org
Cc: "Bergin, Peter" <Peter.Bergin@windriver.com>,
	Peter Bergin <peter.bergin@windriver.com>,
	Peter Bergin <peter@berginkonsult.se>
Subject: [PATCH] lib/bb/tests/fetch.py: set initial branch
Date: Tue,  9 May 2023 14:17:17 +0200
Message-Id: <20230509121717.1862519-1-peter@berginkonsult.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 May 2023 12:18:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14769

From: "Bergin, Peter" <Peter.Bergin@windriver.com>

If you have a host where the git config for initial branch
name is something else than 'master' the unittest will fail
as they assume the default branch name is 'master'. Fix this
by explicitly set the intial branch name at 'git init'.

Signed-off-by: Peter Bergin <peter.bergin@windriver.com>
Signed-off-by: Peter Bergin <peter@berginkonsult.se>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 532adb941..f71d0d10c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -423,7 +423,7 @@ class FetcherTest(unittest.TestCase):
         return bb.process.run(cmd, cwd=cwd)[0]
 
     def git_init(self, cwd=None):
-        self.git('init', cwd=cwd)
+        self.git(['init', '--initial-branch=master'], cwd=cwd)
         if not self.git(['config', 'user.email'], cwd=cwd):
             self.git(['config', 'user.email', 'you@example.com'], cwd=cwd)
         if not self.git(['config', 'user.name'], cwd=cwd):
-- 
2.34.1


