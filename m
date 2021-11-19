Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016FC433FE
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 18:50:30 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web08.13226.1637347829323967030
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Nov 2021 10:50:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 68FE11C0009;
	Fri, 19 Nov 2021 18:50:27 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: add missing reference
Date: Fri, 19 Nov 2021 19:50:25 +0100
Message-Id: <20211119185025.1975182-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Nov 2021 18:50:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13080

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-execution.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index a4b1efbe..7b37f661 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -435,7 +435,7 @@ BitBake writes a shell script to
 executes the script. The generated shell script contains all the
 exported variables, and the shell functions with all variables expanded.
 Output from the shell script goes to the file
-``${T}/log.do_taskname.pid``. Looking at the expanded shell functions in
+``${``\ :term:`T`\ ``}/log.do_taskname.pid``. Looking at the expanded shell functions in
 the run file and the output in the log files is a useful debugging
 technique.
 
-- 
2.25.1


