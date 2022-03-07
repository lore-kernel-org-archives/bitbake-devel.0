Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB0C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 10:27:07 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web11.24728.1646648825958575728
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 02:27:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LcwUj5cS;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 86AC3240016;
	Mon,  7 Mar 2022 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646648823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OC0PNxr24OFTYpvKqSS5eUT2IrAUucWeQ4be1PbdBiA=;
	b=LcwUj5cSLFIuYJDXFqX80KFMSiDia+70N+anUHzxprbasjGxCufx9L40RVBAbLPSNyI/6p
	bxX1lAdqXIiuE+Bz5XnS/xy9bBieY3k04PFblIVA3yZ7knauWBh/CHm3ex5ef1NyVWWM24
	cqTQHl9eQsHOv/g1C3a+wBg735BKU19qyhsrirXLE1E0D0tYtYzKUHjpFrvHYPNNpJgrmP
	W4R4CsRr3PO9RKk4QQFAZk4FwPntnlePsF+a2T2P4OWkhxnSZTlALWw1JTTN9Rk+Nd2hOr
	39aJUHP7pkHzLkXMqdrzBrkqwLH/xlJM+z2L+Fnk94rOFBaVne9ltOjDvoyKEg==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH v3 RESEND] bitbake-user-manual: add "crate" fetcher
Date: Mon,  7 Mar 2022 11:26:53 +0100
Message-Id: <20220307102653.517505-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 10:27:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13422

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>
---
 .../bitbake-user-manual-fetching.rst             | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 77384cfd..9ff4e161 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -688,6 +688,22 @@ Here is an example URL::
 
 It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
 
+Crate Fetcher (``crate://``)
+----------------------------
+
+This submodule fetches code for
+`Rust language "crates" <https://doc.rust-lang.org/reference/glossary.html?highlight=crate#crate>`__
+corresponding to Rust libraries and programs to compile. Such crates are typically shared
+on https://crates.io/ but this fetcher supports other crate registries too.
+
+The format for the :term:`SRC_URI` setting must be::
+
+   SRC_URI = "crate://REGISTRY/NAME/VERSION"
+
+Here is an example URL::
+
+   SRC_URI = "crate://crates.io/glob/0.2.11"
+
 Other Fetchers
 --------------
 
-- 
2.25.1


