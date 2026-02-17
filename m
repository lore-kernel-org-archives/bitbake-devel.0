Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C760CE909B1
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 13:36:46 +0000 (UTC)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11927.1771335399128878806
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 05:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=li/Csh63;
 spf=pass (domain: 0leil.net, ip: 83.166.143.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFgfF3n5vznH;
	Tue, 17 Feb 2026 14:36:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771335397;
	bh=id8SiOAGFjGWBmcLsTtJLidAqXNzNFdf/q+9CyPmELI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=li/Csh63CTbkfsyIq4Tow3pcg0shfzg4j4pvqj/FQdmGN+aDnX+RWmWgZ9Wc8K8V5
	 gXU42m5fry/uhX2bzJzAeSbO7GccJpLVnL8syTE+KxmwqApPxIbMdYV4lR8fa/nf7H
	 mbcpWVzv136DPqBZOPMqrmPJJVHukLNQ5Iggf6EWoaNAR82XkrbMIlvTdsOP27ukHP
	 ryHsVwDoE1zhTnk0SpHT7mi2/1cp3UqNT/D+Io9W6q79dCHOiOk3DMRcGzvF3SvPlE
	 pGt62GfbzTJIAzqdh51oaAyyTgjFh89oE1dNSySFH/wo+zp/mmsf41PsODj3gCyIBl
	 ihScXttYUa5AA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFgfF0s8XzZMC;
	Tue, 17 Feb 2026 14:36:37 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 17 Feb 2026 14:36:29 +0100
Subject: [PATCH v3 3/5] doc: bitbake-user-manual-ref-variables: expand and
 reorganize BBMASK explanations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-bbmask-slashes-v3-3-6a02cde9fdab@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19052

From: Quentin Schulz <quentin.schulz@cherry.de>

The documentation doesn't explain the side-effect of putting a leading
slash, only the trailing slash.

The leading slash is not for making the regular expression match an
absolute path, but to force the match on the directory or file that
exactly starts (and ends if there is a trailing slash) with the
specified string. So let's explain that.

This also explains that this doesn't prevent more than the intended path
to be caught, specifically because it is NOT a regular expression
matching an absolute path.

Because any pattern not starting with a ^ character can match multiple
directories from multiple layers, let's make the usage of
BBFILE_PATTERN_my-layer the recommended one. Keep the rest as hints at
what can happen when not using the variable but reiterate that users
should be really be using that variable.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-ref-variables.rst          | 91 +++++++++++++++++++---
 1 file changed, 82 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index f20a9012c..2564a21a0 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1052,24 +1052,97 @@ overview of their function and contents.
 
       The following example uses a complete regular expression to tell
       BitBake to ignore all recipe and recipe append files in
-      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
+      ``recipes-bsp`` directory (recursively) of ``meta-ti``::
 
-         BBMASK = "/meta-ti/recipes-misc/"
+         BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
 
       If you want to mask out multiple directories or recipes, you can
       specify multiple regular expression fragments. This next example
       masks out multiple directories and individual recipes::
 
-         BBMASK += "/meta-ti/recipes-ti/packagegroup/"
-         BBMASK += "/meta-oe/recipes-support/"
-         BBMASK += "/meta-foo/.*/openldap"
-         BBMASK += "opencv.*\.bbappend"
-         BBMASK += "lzma"
+         BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/"
+         BBMASK += "${BBFILE_PATTERN_openembedded-layer}/recipes-support/"
+         BBMASK += "${BBFILE_PATTERN_openembedded-layer}/.*/openldap"
+         BBMASK += "${BBFILE_PATTERN_meta-ti}/.*/optee.*\.bbappend"
+
+      This masks:
+
+      - everything under the ``recipes-graphics/libgal/`` directory from
+        ``meta-ti``,
+      - everything under the ``recipes-support/`` directory in ``meta-oe``,
+      - everything under a directory whose name starts with ``openldap``, and
+        every file with the same naming scheme, in ``meta-oe`` at any directory
+        depth > 1 (e.g. in ``meta-oe``, ``recipes-foo/openldap-stuff/`` or
+        ``recipes-bar/baz/openldap_0.1.bb`` but not ``openldap/``),
+      - every append file whose name starts with ``optee`` in ``meta-ti`` at any
+        directory depth > 1 (e.g. ``optee/optee-examples_%.bbappend`` and
+        ``recipes-security/optee/optee-client_%.bbappend``).
 
       .. note::
 
-         When specifying a directory name, use the trailing slash character
-         to ensure you match just that directory name.
+         Because these are complete regular expressions, if you want to match a
+         directory and not a file, you must end the expression with a trailing
+         slash. That is::
+
+            BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal/"
+
+         Will match anything under ``recipes-graphics/ligbal/`` directory of
+         ``meta-ti``. And::
+
+            BBMASK += "${BBFILE_PATTERN_meta-ti}/recipes-graphics/libgal"
+
+         Will match in ``meta-ti`` any file prefixed with ``libgal`` in
+         ``recipes-graphics/`` and any directory (recursively; and its
+         recipes and recipe append files regardless how they are named) prefixed
+         with ``libgal`` in ``recipes-graphics/``. That is, provided your layers
+         are available at ``/bitbake-builds/poky-master/layers/``, it'll match::
+
+            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal.bb
+            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal_%.bbappend
+            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal-foo/foo.bb
+            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal-foo/foo/bz.bbappend
+            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal/bar.bb
+
+      .. note::
+
+         Because these are complete regular expressions, failing to start the
+         pattern with a ``^`` sign (which is usually the first character in
+         :term:`BBFILE_PATTERN`) means it can match *any* portion of a path.
+         Take the following as an example::
+
+            BBMASK = "recipes-graphics/libgal/"
+
+         This will match subdirectories and files in any path containing
+         ``recipes-graphics/libgal/``, meaning (considering your layers are
+         available at ``/bitbake-builds/poky-master/layers/``)::
+
+            /bitbake-builds/poky-master/layers/meta-ti/recipes-graphics/libgal/
+            /bitbake-builds/poky-master/layers/my-layer/foo-recipes-graphics/libgal/
+
+         will be both matched. This may be a more relaxed way of matching
+         directories, recipes and recipe append files from any third party layer
+         but is generally discouraged as it may be casting too wide of a net.
+
+      .. note::
+
+         Because these are complete regular expressions, a leading slash does
+         not mean the path is absolute. It simply forces the directory to be
+         named exactly that. Take::
+
+            BBMASK = "recipes-graphics/libgal/"
+
+         If you happen to have a directory ``foo-recipes-graphics/libgal/``, it
+         will be matched.
+
+         Leading with a slash::
+
+            BBMASK = "/recipes-graphics/libgal/"
+
+         makes sure that doesn't happen. However, this doesn't prevent matching
+         a directory ``recipes-graphics/libgal/`` from another layer.
+
+         Again, we highly recommend using :term:`BBFILE_PATTERN` in the
+         expressions to specify absolute paths specific to one layer.
 
    :term:`BBMULTICONFIG`
       Enables BitBake to perform multiple configuration builds and lists

-- 
2.53.0


