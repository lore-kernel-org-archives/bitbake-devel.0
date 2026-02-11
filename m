Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA40ECD6E5
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 18:06:39 +0000 (UTC)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25759.1770833193617857991
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 10:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=iIIT0Dk4;
 spf=pass (domain: 0leil.net, ip: 84.16.66.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fB5wS0JYhzCGP;
	Wed, 11 Feb 2026 19:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1770833191;
	bh=8yracizhFTpk2jwkZvN9xVDFHx4zIygI4BovBEUAn3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iIIT0Dk47OSF3OOTKS5RFQNTDV90hKG7XOrlWTvqnUbu4YvB/PjjhAwijgyWYRXMI
	 IbxMdru2gg2mnvVVj7P2llVJkbvZ+7Cak/qvsxoI+2FUGyFwlTmejwCj16rftdss5O
	 JimydP1BSL6B/NZwVpd89NCLK5cHGInmRRkAepP/P0gJ4FI9sSOZvmfCBHuYRiYkzL
	 7oYOdFNwbDymHUqNZ3kOXSE4PN3LM0JKknh7jyewXH7/nDTuf1XEMeCYzwCD1YTATE
	 bhU4DGeMi2OvUD6nPlaRNQ7RMBVZfhbgqQ2wmaxSIcZgEQFl2GEIiXuqWbJUucn8R/
	 UPg2dG+pDzmZg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fB5wR3Qz0zf9T;
	Wed, 11 Feb 2026 19:06:31 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 11 Feb 2026 19:06:23 +0100
Subject: [PATCH 4/4] doc: bitbake-user-manual-ref-variables: update BBMASK
 example with current meta-ti
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-bbmask-slashes-v1-4-b72161c647ef@cherry.de>
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
In-Reply-To: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 18:06:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19012

From: Quentin Schulz <quentin.schulz@cherry.de>

meta-ti git repo now has multiple layers in it since kirkstone, so let's
update the examples to match the current state of meta-ti by using
meta-ti-bsp.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-ref-variables.rst                | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 6612dcc03..e8563bc97 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1052,15 +1052,15 @@ overview of their function and contents.
 
       The following example uses a complete regular expression to tell
       BitBake to ignore all recipe and recipe append files in
-      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
+      ``meta-ti-bsp/recipes-ti/`` directories (and their subdirectories)::
 
-         BBMASK = "/meta-ti/recipes-misc/"
+         BBMASK = "/meta-ti-bsp/recipes-ti/"
 
       If you want to mask out multiple directories or recipes, you can
       specify multiple regular expression fragments. This next example
       masks out multiple directories and individual recipes::
 
-         BBMASK += "/meta-ti/recipes-ti/packagegroup/"
+         BBMASK += "/meta-ti-bsp/recipes-graphics/powervr-umlibs/"
          BBMASK += "/meta-oe/recipes-support/"
          BBMASK += "/meta-foo/.*/openldap"
          BBMASK += "opencv.*\.bbappend"
@@ -1077,21 +1077,21 @@ overview of their function and contents.
          mean the path is absolute. It simply forces the directory to be named
          exactly that. Take::
 
-            BBMASK = "meta-ti/recipes-bsp/"
+            BBMASK = "meta-ti-bsp/recipes-ti/"
 
-        If you happen to have a directory ``my-meta-ti/recipes-bsp``, it will
+        If you happen to have a directory ``my-meta-ti-bsp/recipes-ti``, it will
         be matched.
 
         Leading with a slash::
 
-           BBMASK = "/meta-ti/recipes-bsp/"
+           BBMASK = "/meta-ti-bsp/recipes-ti/"
 
         makes sure that doesn't happen. However, this doesn't prevent matching a
-        directory ``meta-foo/meta-ti/recipes-bsp``. For that, use the
+        directory ``meta-foo/meta-ti-bsp/recipes-ti``. For that, use the
         appropriate :term:`BBFILE_PATTERN` to only match a directory from one
         specific layer::
 
-           BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
+           BBMASK = "${BBFILE_PATTERN_meta-ti-bsp}/recipes-bsp/"
 
    :term:`BBMULTICONFIG`
       Enables BitBake to perform multiple configuration builds and lists

-- 
2.53.0


