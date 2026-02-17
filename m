Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE368E909AF
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 13:36:46 +0000 (UTC)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11929.1771335399576646130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 05:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=jUvGvAwR;
 spf=pass (domain: 0leil.net, ip: 84.16.66.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFgfF6vpXzbW;
	Tue, 17 Feb 2026 14:36:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771335397;
	bh=ojPXlupufFwg1IqvPPEU1fP2ILHsAWs6J+D+sG74MR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jUvGvAwRLys4wmsTpnWjYdKqVrBTP3Gy5K7Z8RvZWHtfie7kbcz9trKUQSQuu14Vr
	 ZICkawas0wAd0RxKCn5CKt+hQBQrfqjk7GaXsEDujz94gjJlbKWbIS20fsYGzXmTOy
	 rj/a2OJiBa5CTFsrQ6CK4KwoOJcTRUQNUA4qzr8kh36Xko0Pk7PuDd78ZKbzS2uCin
	 YmOTXjIZ/TmXzxjJqgrDXuLAdwuIf9B+enuIKAg8fiwHEzXiu6Qswa1qbdVzSgVtFN
	 G7wTR2dxNe6Z/TjDYvZizR4w5atph5AywUQ4O4Ug46uu1AagOOqrU62mG+C5j2Nj3h
	 9CTSmhSp+dPSA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFgfF3j7PzZXt;
	Tue, 17 Feb 2026 14:36:37 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 17 Feb 2026 14:36:30 +0100
Subject: [PATCH v3 4/5] doc: bitbake-user-manual-ref-variables: update
 BBMASK example with current meta-ti
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-bbmask-slashes-v3-4-6a02cde9fdab@cherry.de>
References: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
In-Reply-To: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 13:36:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19051

From: Quentin Schulz <quentin.schulz@cherry.de>

meta-ti git repo now has multiple layers in it since kirkstone, so let's
update the examples to match the current state of meta-ti by using
meta-ti-bsp.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-ref-variables.rst          | 34 +++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 2564a21a0..bab5252e9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1052,30 +1052,30 @@ overview of their function and contents.
 
       The following example uses a complete regular expression to tell
       BitBake to ignore all recipe and recipe append files in
-      ``recipes-bsp`` directory (recursively) of ``meta-ti``::
+      ``recipes-bsp`` directory (recursively) of ``meta-ti-bsp``::
 
-         BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
+         BBMASK = "${BBFILE_PATTERN_meta-ti-bsp}/recipes-bsp/"
 
       If you want to mask out multiple directories or recipes, you can
       specify multiple regular expression fragments. This next example
       masks out multiple directories and individual recipes::
 
-         BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/"
+         BBMASK += "${BBFILE_PATTERN_meta-ti-bsp}/recipes-graphics/libgal/"
          BBMASK += "${BBFILE_PATTERN_openembedded-layer}/recipes-support/"
          BBMASK += "${BBFILE_PATTERN_openembedded-layer}/.*/openldap"
-         BBMASK += "${BBFILE_PATTERN_meta-ti}/.*/optee.*\.bbappend"
+         BBMASK += "${BBFILE_PATTERN_meta-ti-bsp}/.*/optee.*\.bbappend"
 
       This masks:
 
       - everything under the ``recipes-graphics/libgal/`` directory from
-        ``meta-ti``,
+        ``meta-ti-bsp``,
       - everything under the ``recipes-support/`` directory in ``meta-oe``,
       - everything under a directory whose name starts with ``openldap``, and
         every file with the same naming scheme, in ``meta-oe`` at any directory
         depth > 1 (e.g. in ``meta-oe``, ``recipes-foo/openldap-stuff/`` or
         ``recipes-bar/baz/openldap_0.1.bb`` but not ``openldap/``),
-      - every append file whose name starts with ``optee`` in ``meta-ti`` at any
-        directory depth > 1 (e.g. ``optee/optee-examples_%.bbappend`` and
+      - every append file whose name starts with ``optee`` in ``meta-ti-bsp`` at
+        any directory depth > 1 (e.g. ``optee/optee-examples_%.bbappend`` and
         ``recipes-security/optee/optee-client_%.bbappend``).
 
       .. note::
@@ -1084,24 +1084,24 @@ overview of their function and contents.
          directory and not a file, you must end the expression with a trailing
          slash. That is::
 
-            BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/"
+            BBMASK += "${BBFILE_PATTERN_meta-ti-bsp}/recipes-graphics/libgal/"
 
          Will match anything under ``recipes-graphics/ligbal/`` directory of
-         ``meta-ti``. And::
+         ``meta-ti-bsp``. And::
 
-            BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal"
+            BBMASK += "${BBFILE_PATTERN_meta-ti-bsp}/recipes-graphics/libgal"
 
-         Will match in ``meta-ti`` any file prefixed with ``libgal`` in
+         Will match in ``meta-ti-bsp`` any file prefixed with ``libgal`` in
          ``recipes-graphics/`` and any directory (recursively; and its
          recipes and recipe append files regardless how they are named) prefixed
          with ``libgal`` in ``recipes-graphics/``. That is, provided your layers
          are available at ``/bitbake-builds/poky-master/layers/``, it'll match::
 
-            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal.bb
-            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal_%.bbappend
-            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal-foo/foo.bb
-            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal-foo/foo/bz.bbappend
-            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal/bar.bb
+            /bitbake-builds/poky-master/layers/meta-ti/meta-ti-bsp/recipes-graphics/libgal.bb
+            /bitbake-builds/poky-master/layers/meta-ti/meta-ti-bsp/recipes-graphics/libgal_%.bbappend
+            /bitbake-builds/poky-master/layers/meta-ti/meta-ti-bsp/recipes-graphics/libgal-foo/foo.bb
+            /bitbake-builds/poky-master/layers/meta-ti/meta-ti-bsp/recipes-graphics/libgal-foo/foo/bz.bbappend
+            /bitbake-builds/poky-master/layers/meta-ti/meta-ti-bsp/recipes-graphics/libgal/bar.bb
 
       .. note::
 
@@ -1116,7 +1116,7 @@ overview of their function and contents.
          ``recipes-graphics/libgal/``, meaning (considering your layers are
          available at ``/bitbake-builds/poky-master/layers/``)::
 
-            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal/
+            /bitbake-builds/poky-master/layers/meta-ti/meta-ti-bsp/recipes-graphics/libgal/
             /bitbake-builds/poky-master/layers/my-layer/foo-recipes-graphics/libgal/
 
          will be both matched. This may be a more relaxed way of matching

-- 
2.53.0


