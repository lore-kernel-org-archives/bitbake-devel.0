Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C125DC282DE
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 12:01:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.9453.1741348863520494091
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 04:01:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNx-0006hM-R1; Fri, 07 Mar 2025 13:01:01 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNw-004Tkx-2s;
	Fri, 07 Mar 2025 13:01:00 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNw-0088ry-2e;
	Fri, 07 Mar 2025 13:01:00 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH v3 4/5] tests: fetch: add status test for the GitHub release artifact fetcher
Date: Fri,  7 Mar 2025 13:00:54 +0100
Message-Id: <20250307120055.1816436-5-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307120055.1816436-1-l.goehrs@pengutronix.de>
References: <20250307120055.1816436-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 12:01:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17405

This re-uses the same URL that is already used by the download test of the
same fetcher.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 lib/bb/tests/fetch.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 517894881..cf5ce2ebd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1606,7 +1606,8 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
                       # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
-                      "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
+                      "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz",
+                      "ghra://github.com/kergoth/tslib/1.1/tslib-1.1.tar.xz"
                       ]
 
     @skipIfNoNetwork()
-- 
2.39.5


