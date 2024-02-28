Return-Path: <u.oelmann@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D4C54E41
	for <webhook@archiver.kernel.org>; Wed, 28 Feb 2024 06:48:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.7860.1709102920300652947
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 22:48:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: uol@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <uol@pengutronix.de>)
	id 1rfDk6-0002aF-DY; Wed, 28 Feb 2024 07:48:38 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <uol@pengutronix.de>)
	id 1rfDk5-003LFd-AC; Wed, 28 Feb 2024 07:48:37 +0100
Received: from uol by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <uol@pengutronix.de>)
	id 1rfDk5-004B6Q-0W;
	Wed, 28 Feb 2024 07:48:37 +0100
From: =?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: yocto@pengutronix.de,
	=?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
Subject: [PATCH] taskexp_ncurses: fix execution example in introductory comment
Date: Wed, 28 Feb 2024 07:48:16 +0100
Message-Id: <20240228064816.995961-1-u.oelmann@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: uol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 06:48:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15973

Drop the ".py" file extension from the "-u" option's argument that has been
overlooked while applying the original patch (see [1]) to make the example work.
While at it sort the recipes' names consistently with respect to what is found
in the self-test examples below.

[1] https://lore.kernel.org/bitbake-devel/6f2645a7c4db2ae149d387544d2b94209cfed3f4.camel@linuxfoundation.org/

Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
---
 lib/bb/ui/taskexp_ncurses.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/taskexp_ncurses.py b/lib/bb/ui/taskexp_ncurses.py
index dd91d26bc3b1..ea94a4987f97 100755
--- a/lib/bb/ui/taskexp_ncurses.py
+++ b/lib/bb/ui/taskexp_ncurses.py
@@ -12,7 +12,7 @@
 
 #
 # Execution example:
-#   $ bitbake -g -u taskexp_ncurses.py acl zlib
+#   $ bitbake -g -u taskexp_ncurses zlib acl
 #
 # Self-test example (executes a script of GUI actions):
 #   $ TASK_EXP_UNIT_TEST=1 bitbake -g -u taskexp_ncurses zlib acl
-- 
2.39.2


