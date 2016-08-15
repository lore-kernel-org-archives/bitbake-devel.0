Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id BB3C577142
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 14:20:55 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id i5so106411319wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=907/a39BTJ8Ok9L7EQW1ePnP0NOzaisTepUlyYiHuw8=;
	b=p30etIgFCGVM0c7wQEvEtN6p+t97UWS0kGjd5tN1T3K/ikpzXuELKI2exlU3aNiTCk
	QOia7NHLyzPXYe0atPuJCj0A3sFgVWUwDNexMwcRr9jLTXoNT1dll7KIsxnScXhp4hO9
	yV8Mlvj4G1nGJE3aqVkSbOt8v9yIiQpMU3nLqMC0I51DY27ZgYNFy6fEdR+KLUMZ1e74
	63xHThGWX3XoPCffCffps8kGOTOgxhgTSgVI71a2UQciSnLRRnYF9C6aqs7bAWn2r2Yw
	TN84wzXxle1gcDknlqXw9gG73ZnXAfn6Ogzvvkw070bkKXAzU5kEHjvk99P6qhSlJs8d
	sY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=907/a39BTJ8Ok9L7EQW1ePnP0NOzaisTepUlyYiHuw8=;
	b=I8wuw4ysUQXt4TuG1F011QPGCr0/+fvjB9dZKHxqxCOz3a2NRANCEt7RPaE1fsrF6l
	x6SnS9CdrmsLEBItiiL9W1bDvcLvFHsBoDSLC9yFx+/kCir7hmeX5kmTiFaMCYdcv5zf
	u8UyW0cyZM8PO+5QznNVc0fboUdq7OPMD7Isq1gmSN40BRayb7DbiaLsHBA5Fx3Ds7V0
	MRlRgB+Ezkn7tocRNTDZokw/yAhfvw84xrVwqYTEzWYF9xrAo4Q5bNgysrkoG32u2mBi
	5NnLl9HciJ5BYpk5pvkfcd0jBl09UsCdK5YRBbMxuCdTab69nqHiK223x9uk9LodtPpM
	mKZQ==
X-Gm-Message-State: AEkoouvg8YAe+/RFWEVJq6nZiXi398s66+wRDK5Fn1qjyCiQKYkGfrn86miuFb4gCfCKucny
X-Received: by 10.28.169.82 with SMTP id s79mr15643197wme.87.1471270854832;
	Mon, 15 Aug 2016 07:20:54 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	207sm16795935wmb.7.2016.08.15.07.20.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 15 Aug 2016 07:20:54 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Aug 2016 15:20:50 +0100
Message-Id: <1471270850-27986-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] lib/bb/tests/fetch: remove URL that doesn't exist anymore
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 15 Aug 2016 14:20:56 -0000

The CUPS ipptool URL we were checking now redirects to github where the tarball
isn't present, so remove it from the test suite.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 5ff156c..272078f 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -768,7 +768,6 @@ class FetchLatestVersionTest(FetcherTest):
 
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2",
-                      "http://www.cups.org/software/ipptool/ipptool-20130731-linux-ubuntu-i686.tar.gz",
                       "http://www.cups.org/",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-- 
2.8.1


