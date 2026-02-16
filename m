Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34208E7BD8F
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 10:36:41 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17104.1771238199789260005
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 02:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=T8O4HZCi;
 spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fDzj209M5zdFR;
	Mon, 16 Feb 2026 11:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771238197;
	bh=XRnJdpwjnZIky+4c8P3B3onh0/BvTWIgglpXN2vzRuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T8O4HZCiOkpqNG9zR/+3m9+Xcb7kg78krTDQm1PVndtCSK9pEyWb3btZ9pbr6W8S0
	 YIjAv0pkCe8IdgUXvL4EAnMRAgyOIu7ouqvx3sxBnPM3vTFOGFCeaY1J4nQTVwNdjw
	 xYR0M9sxCVeX+iNZOmxGoA+mpIrhxT2k/cVXfjZ9Cd1Xluj3VOE5BfPECNEGLbXIjy
	 GSQhuZO15K0Zgg4bqu7Jyw9x7iS1bgfcZlYwT758KnfU/4BN94nJdMinfKnk+VBxin
	 fUc8KdByN/IW8n6rkGYbhWrhRPpWVgeUX0MhiCJ/3orqY/XZCQ7wwjR/dlilxRZAM3
	 6UIif6cXeripQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fDzj13CgnzP44;
	Mon, 16 Feb 2026 11:36:37 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Feb 2026 11:36:24 +0100
Subject: [PATCH v2 3/5] doc: bitbake-user-manual-ref-variables: expand and
 reorganize BBMASK explanations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-bbmask-slashes-v2-3-b9bb52f5fd3d@cherry.de>
References: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
In-Reply-To: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 10:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19038

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
directories from multiple directories, let's make the usage of
BBFILE_PATTERN_my-layer the recommended one. Keep the rest as hints at
what can happen when not using but reiterate what users should be using.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-ref-variables.rst          | 87 +++++++++++++++++++---
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index f20a9012c..06e1112b5 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1052,24 +1052,93 @@ overview of their function and contents.
 
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
+      This masks the ``recipes-graphics/libgal/`` from ``meta-ti``, everything
+      under ``recipes-support`` in ``meta-oe``, every directory or file whose
+      name starts with ``openldap`` in ``meta-oe`` at any directory depth > 1
+      (e.g. in ``meta-oe``, ``recipes-foo/openldap-stuff/`` or
+      ``recipes-bar/baz/openldap_0.1.bb`` but not ``openldap/``), every append
+      file in ``meta-ti`` at any directory depth > 1 (e.g.
+      ``optee/optee-examples_%.bbappend`` and
+      ``recipes-security/optee/optee-client_%.bbappend``).
 
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
+         are available at ``/build/layers/``, it'll match::
+
+            /builds/layers/meta-ti/recipes-graphics/libgal.bb
+            /builds/layers/meta-ti/recipes-graphics/libgal_%.bbappend
+            /builds/layers/meta-ti/recipes-graphics/libgal-foo/foo.bb
+            /builds/layers/meta-ti/recipes-graphics/libgal-foo/foo/bz.bbappend
+            /builds/layers/meta-ti/recipes-graphics/libgal/bar.bb
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
+         available at ``/builds/layers/``)::
+
+            /builds/layers/meta-ti/recipes-graphics/libgal/
+            /builds/layers/my-layer/foo-recipes-graphics/libgal/
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


