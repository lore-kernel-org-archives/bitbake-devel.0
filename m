Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 9A9DE7F10F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:13:50 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id n9so9955845wrr.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SiIM9iVV1c6Yh1A+2P/BAkC5ME/5JZ8jB/mAu8QbmMQ=;
	b=TOjVX4FYZDCvsW/kWJYLmJRLhvjNfhD3efCizoKK6yfuxlEIyBdcbcqbb7rBakEea1
	x4XBF/2maLKrS5K5c3I+TP5pRDstU5RyYNMxg2pWBjw3Fl3KjqG3ZXKxatWQEGppDid/
	BEB0FwjHODA3uf0dJ8U9cbPP9or2K+6PE/1i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SiIM9iVV1c6Yh1A+2P/BAkC5ME/5JZ8jB/mAu8QbmMQ=;
	b=pXeFszCt9TtigCY9HN3rzIEEi7OM5oMCsBz96a9agbvryhb5Xv5+kf2EuLTYIK1Xc/
	oO/ygXQB9vOnR7ofUOrIH7hbksP2X5cVcAZY94jnTTw9CVLgsXMInvFZxjOmzNAKizE8
	WEfxovgZvSmVFl6Iedvzw+Wstjb7bqBPtxHUvRLoN8zz0RpFdOKK+DzAeXxBmvC1Wik1
	fSr5sA2A7QQakwRGM8NozdYF5q/h2Adm3f+F0rTyPMhmFs9HqHY0CaTLBfML2RanDbHX
	X/bT9nbSb3Z9vU/X0Ba791uBldaZrI2YI1Fl7TxBmd/tH8MnXKv/9iBEzh+NbMDtzehS
	XGQw==
X-Gm-Message-State: APjAAAXRAEm+3HbSq20vVsCfYvraCZyJ6j98royZej52Tr6gDcE2qw/3
	qLxl8AhIy6AcV1lplnbi86i3nzZ+mHc=
X-Google-Smtp-Source: APXvYqzawh4bqL3jso7l5IzN+Gc3v1iezsa9nBT2VTdbjqtzREUQorBnl7IhOrOwcpqiausdjl1Xog==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr11565694wrv.219.1562937231158; 
	Fri, 12 Jul 2019 06:13:51 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k9sm6015169wmi.33.2019.07.12.06.13.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 06:13:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 14:13:43 +0100
Message-Id: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/7] runqueue: Simplify some convoluted logic
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
X-List-Received-Date: Fri, 12 Jul 2019 13:13:50 -0000
Content-Transfer-Encoding: 8bit

This was left from when task IDs complicated the code, simplify.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index db0d852c54..48b668abc1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1908,12 +1908,7 @@ class RunQueueExecute:
                     if nexttask in self.sqdata.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
-                        fn = fn_from_tid(nexttask)
-                        foundtarget = False
-
-                        if nexttask in self.rqdata.target_tids:
-                            foundtarget = True
-                        if not foundtarget:
+                        if nexttask not in self.rqdata.target_tids:
                             logger.debug(2, "Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
-- 
2.20.1


