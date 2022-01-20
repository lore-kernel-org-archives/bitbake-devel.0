Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E4AC433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 15:44:45 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web11.13662.1642693483607663713
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 07:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 84DE2240007;
	Thu, 20 Jan 2022 15:44:41 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2] bitbake-user-manual: add "crate" fetcher
Date: Thu, 20 Jan 2022 16:44:32 +0100
Message-Id: <20220120154432.1913701-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16CC04D59D724BB9.10162@lists.yoctoproject.org>
References: <16CC04D59D724BB9.10162@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 15:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13258

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-fetching.rst             | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 77384cfd..ae790765 100644
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
+on https://crates.io/ but this fetcher supports other server hosts too.
+
+The format for the :term:`SRC_URI` setting must be::
+
+   SRC_URI = "crate://HOST/NAME/VERSION"
+
+Here is an example URL::
+
+   SRC_URI = "crate://crates.io/glob/0.2.11"
+
 Other Fetchers
 --------------
 
-- 
2.25.1


