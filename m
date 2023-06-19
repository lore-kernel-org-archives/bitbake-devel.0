Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A76EB64DA
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 16:06:35 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.11390.1687190785738032662
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Jun 2023 09:06:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LS65RebZ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687190783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vEH1E3JotfaNoDYE2DXPWWe5BNTvpbxLwHxtz5RSGaY=;
	b=LS65RebZlOdLKP6o29XYYSjexBnfy0Bx2j2ZuHz5XWifKM71HEJx4QztfTQjgFBu61mm+t
	UGBtBRpKT5tfxEBE774b0/csiN4KkMIQrsprK0lXAwldauzlhmM82L3i71z/Kj+zLAK2AU
	9ramkpZGUWe0Bjhr/yWM6MYre+80fyntb2vUZnwI5MjJXIYj9tcEuVxM7d/KQPogRabYFE
	kCM+LOpduo5WuHuVMGz4uoswsB7s/lyTV+xjkAHmaJtUsjggmL4wODKRKrl0szy5mGlpar
	SngbQLTrhDndTGkf+BcpEIQHpaNVvZ6dnVcyyd+72a651NUCJB1C/tf1ipgxTQ==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 686E32000E;
	Mon, 19 Jun 2023 16:06:23 +0000 (UTC)
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: explicit variables taking a colon separated list
Date: Mon, 19 Jun 2023 18:06:14 +0200
Message-Id: <20230619160614.909233-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Jun 2023 16:06:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14846

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

[YOCTO #15128]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 01d4f8d1..ee5d7ba8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -920,9 +920,9 @@ overview of their function and contents.
       section.
 
    :term:`BBPATH`
-      Used by BitBake to locate class (``.bbclass``) and configuration
-      (``.conf``) files. This variable is analogous to the ``PATH``
-      variable.
+      A colon-separated list used by BitBake to locate class (``.bbclass``)
+      and configuration (``.conf``) files. This variable is analogous to the
+      ``PATH`` variable.
 
       If you run BitBake from a directory outside of the build directory,
       you must be sure to set :term:`BBPATH` to point to the build directory.
@@ -1165,8 +1165,8 @@ overview of their function and contents.
       order.
 
    :term:`OVERRIDES`
-      BitBake uses :term:`OVERRIDES` to control what variables are overridden
-      after BitBake parses recipes and configuration files.
+      A colon-separated list that BitBake uses to control what variables are
+      overridden after BitBake parses recipes and configuration files.
 
       Following is a simple example that uses an overrides list based on
       machine architectures: OVERRIDES = "arm:x86:mips:powerpc" You can
@@ -1225,9 +1225,9 @@ overview of their function and contents.
          PREFERRED_PROVIDER_virtual/libgl ?= "mesa"
 
    :term:`PREFERRED_PROVIDERS`
-      Determines which recipe should be given preference for cases where
-      multiple recipes provide the same item. Functionally,
-      :term:`PREFERRED_PROVIDERS` is identical to
+      A colon-separated list to determine which recipe should be given
+      preference for cases where multiple recipes provide the same item.
+      Functionally, :term:`PREFERRED_PROVIDERS` is identical to
       :term:`PREFERRED_PROVIDER`. However, the :term:`PREFERRED_PROVIDERS` variable
       lets you define preferences for multiple situations using the following
       form::
-- 
2.34.1


