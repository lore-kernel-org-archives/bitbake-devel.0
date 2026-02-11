Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E902ECD6E4
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 18:06:39 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25757.1770833192712114149
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 10:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=NdodwDyF;
 spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fB5wR2kKCz8kZ;
	Wed, 11 Feb 2026 19:06:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1770833191;
	bh=WP2DxU/9nzBdnkjibxjUuRGyFd55gkXphqsiHgtKkYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NdodwDyFGfYQIX4Cn+a9FPHqBHMB6SQmZtcZkUqX87jkFEP0M+PgvLDFCThl0XBi7
	 MyCCVYrGH3IatiVmLnW1DE+pUi+2icIpK5GwHWgpeaCimHHt4sGMHnY5h4y/JyI3eE
	 oMHcNd93HCXu+/pHWpMIf8zqm57zyi9A3FANLV5TKzMoPceshHx2rvFX2DYngqWOQb
	 6iIY0m0XzvQPCCcqBzsDl/jEhgwnIZA+uEGFnSGGRRe5bjXL96nWtfqBy9Ygx5zee6
	 SqjVjWJ9X43L1A/CWI5xPwU8j/+UYBTGoj9kHTPHc99p7nlckV9ZQ/qZT7bva7y0t2
	 bjo32e4lKcNFw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fB5wQ69ngzhdp;
	Wed, 11 Feb 2026 19:06:30 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 11 Feb 2026 19:06:22 +0100
Subject: [PATCH 3/4] doc: bitbake-user-manual-ref-variables: clarify BBMASK
 matching patterns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-bbmask-slashes-v1-3-b72161c647ef@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19011

From: Quentin Schulz <quentin.schulz@cherry.de>

The documentation doesn't explain the side-effect of putting a leading
slash, only the trailing slash.

The leading slash is not for making the regular expression match an
absolute path, but to force the match on the directory or file that
exactly starts (and ends if there is a trailing slash) with the
specified string.

Finally, this also explains that this still doesn't prevent more than
the intended path to be caught up, specifically because it is NOT a
regular expression matching an absolute path. For that though, the user
can use BBFILE_PATTERN set for the layer they want to mask the recipe or
append files to BitBake. This is typically a regex starting with
^${LAYERDIR}, making it an absolute path matching.

Let's document those limitations.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-ref-variables.rst          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index f20a9012c..6612dcc03 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1071,6 +1071,28 @@ overview of their function and contents.
          When specifying a directory name, use the trailing slash character
          to ensure you match just that directory name.
 
+      .. note::
+
+         The leading slash in a regular expression in :term:`BBMASK` does not
+         mean the path is absolute. It simply forces the directory to be named
+         exactly that. Take::
+
+            BBMASK = "meta-ti/recipes-bsp/"
+
+        If you happen to have a directory ``my-meta-ti/recipes-bsp``, it will
+        be matched.
+
+        Leading with a slash::
+
+           BBMASK = "/meta-ti/recipes-bsp/"
+
+        makes sure that doesn't happen. However, this doesn't prevent matching a
+        directory ``meta-foo/meta-ti/recipes-bsp``. For that, use the
+        appropriate :term:`BBFILE_PATTERN` to only match a directory from one
+        specific layer::
+
+           BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
+
    :term:`BBMULTICONFIG`
       Enables BitBake to perform multiple configuration builds and lists
       each separate configuration (multiconfig). You can use this variable

-- 
2.53.0


