Return-Path: <u.oelmann@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C89C77B7C
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 13:06:52 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
 by mx.groups.io with SMTP id smtpd.web11.19865.1682600809547874220
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Apr 2023 06:06:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: pengutronix.de, ip: 85.220.165.71, mailfrom: uol@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <uol@pengutronix.de>)
	id 1ps1Kh-0007ev-Gp; Thu, 27 Apr 2023 15:06:47 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <uol@pengutronix.de>)
	id 1ps1Kf-00E9nn-JQ; Thu, 27 Apr 2023 15:06:45 +0200
Received: from uol by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <uol@pengutronix.de>)
	id 1ps1Ke-00GttV-PD; Thu, 27 Apr 2023 15:06:44 +0200
From: =?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de,
	=?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
Subject: [PATCH] bitbake-user-manual: fix BB_RUNFMT's default value
Date: Thu, 27 Apr 2023 15:06:36 +0200
Message-Id: <20230427130636.4028096-1-u.oelmann@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: uol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 13:06:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14752

According to the code the default value is slightly different (see [1] which
reflects the current tip commit at the time of writing).

[1] https://git.openembedded.org/bitbake/tree/lib/bb/build.py?id=d97d62e2cbe4bae17f0886f3b4759e8f9ba6d38c#n237

Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 6ccf58b21234..01d4f8d14a35 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -563,7 +563,7 @@ overview of their function and contents.
       :term:`BB_RUNFMT` variable is undefined and the run filenames get
       created using the following form::
 
-         run.{task}.{pid}
+         run.{func}.{pid}
 
       If you want to force run files to take a specific name, you can set this
       variable in a configuration file.
-- 
2.39.2


