Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E92C4332F
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 09:17:30 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web08.4476.1648545449361575126
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 02:17:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ZRKNlZdm;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 9D55D60007;
	Tue, 29 Mar 2022 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648545446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mB2mlQQMB7A6tx4MC2bVnI7Qw5qYa3+IHDrz4mAyJYM=;
	b=ZRKNlZdmRz+CBHahxNb+DyWbgauqrhISG9N6UE5pyTrifLBNH8aS6OWntGbWLreefxSrMl
	odjk2aY/xzM/a0bkq5NzVpCfw3TjB/Ib7G9/bdYWS4cw8Fa8pc/PKy3hhIqrEfJN5n0SW5
	e+r7niqTDVX/YZtyTn3JwU1CdQD9te588ZVcw/42alrB7gsQfBwKWjqWC+3YocXN3AC9da
	B2FxGxCDZYhmuiZECN6x8wQAfrVaiu6o98FAsuVydhHiF3LCTrZ9F433RIbxMbYQFUqofE
	hqTzpjA4B+MXSDCPulrcvKTzFzMin4YCe8ixVEgNXs06rJ6r7d81SSQZTMWmpg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: fix broken links to manual releases
Date: Tue, 29 Mar 2022 11:17:21 +0200
Message-Id: <20220329091721.350606-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 09:17:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13529

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Due to the fact that Sphinx documentation is only built
for BitBake branches (1.48, 1.50...)

Available pre-Sphinx documentation is kept.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/releases.rst | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index 6635032c..216dbe10 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -8,40 +8,23 @@
 Release Series 3.4 (honister)
 ******************************
 
-- :yocto_docs:`3.4 BitBake User Manual </3.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.4.1 BitBake User Manual </3.4.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.4.2 BitBake User Manual </3.4.2/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`BitBake 1.52 User Manual </bitbake/1.52/>`
 
 ******************************
 Release Series 3.3 (hardknott)
 ******************************
 
-- :yocto_docs:`3.3 BitBake User Manual </3.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.1 BitBake User Manual </3.3.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.2 BitBake User Manual </3.3.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.3 BitBake User Manual </3.3.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.4 BitBake User Manual </3.3.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.3.5 BitBake User Manual </3.3.5/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`BitBake 1.50 User Manual </bitbake/1.50/>`
 
 ****************************
 Release Series 3.1 (dunfell)
 ****************************
 
+- :yocto_docs:`BitBake 1.46 User Manual </bitbake/1.46/>`
 - :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.3 BitBake User Manual </3.1.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.4 BitBake User Manual </3.1.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.5 BitBake User Manual </3.1.5/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.6 BitBake User Manual </3.1.6/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.7 BitBake User Manual </3.1.7/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.8 BitBake User Manual </3.1.8/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.9 BitBake User Manual </3.1.9/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.10 BitBake User Manual </3.1.10/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.11 BitBake User Manual </3.1.11/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.12 BitBake User Manual </3.1.12/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.13 BitBake User Manual </3.1.13/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.14 BitBake User Manual </3.1.14/bitbake-user-manual/bitbake-user-manual.html>`
 
 ==========================
  Outdated Release Manuals
@@ -51,11 +34,7 @@ Release Series 3.1 (dunfell)
 Release Series 3.2 (gatesgarth)
 *******************************
 
-- :yocto_docs:`3.2 BitBake User Manual </3.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.1 BitBake User Manual </3.2.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.2 BitBake User Manual </3.2.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.3 BitBake User Manual </3.2.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.2.4 BitBake User Manual </3.2.4/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`BitBake 1.48 User Manual </bitbake/1.48/>`
 
 *************************
 Release Series 3.0 (zeus)
-- 
2.25.1


