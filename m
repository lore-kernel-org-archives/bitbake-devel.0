Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666D8E67484
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:44 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36924.1768235799536132764
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLY6rQfzkrj;
	Mon, 12 Jan 2026 17:36:37 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLY42V7zfPD;
	Mon, 12 Jan 2026 17:36:37 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:12 +0100
Subject: [PATCH 8/8] doc: bitbake-user-manual-metadata: expand locating
 files example for include_all directive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-8-b23923cfce89@cherry.de>
References: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
In-Reply-To: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 16:36:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18742

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds a separate example for the include_all directive which also
highlights that the current directory isn't searched (unlike when using
the include or require directive).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-metadata.rst               | 32 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index cbad4df99..18f293f4b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1074,11 +1074,6 @@ BitBake also uses the :term:`BBPATH` variable.
 
 For these two directives, BitBake includes the first file it finds.
 
-.. note::
-
-   It is also possible to include *all* occurences of a file with the same name
-   with the :ref:`include_all <ref-include-all-directive>` directive.
-
 Let's consider the following statement called from a recipe file located in
 ``/layers/meta-custom2/recipes-example/example/example_0.1.bb``::
 
@@ -1129,6 +1124,33 @@ In this case, the following paths would be searched::
    In the above examples, the exact same search order applies for the
    :ref:`include <ref-include-directive>` directive.
 
+It is also possible to include *all* occurences of a file with the same name
+with the :ref:`include_all <ref-include-all-directive>` directive.
+
+Let's consider the following statement called from a recipe file located in
+``/layers/meta-custom2/recipes-example/example/exampleall_0.1.bb``::
+
+   include_all all.inc
+
+Where multiple ``all.inc`` are in located in ``/layers/meta-custom2`` and
+``/layers/meta-custom1``.
+
+And let's assume that the value of :term:`BBPATH` is
+``/layers/meta-custom1:/layers/meta-custom2``. Then BitBake will try to include
+all ``all.inc`` in this order::
+
+   /layers/meta-custom1/all.inc
+   /layers/meta-custom2/all.inc
+
+In this case the first ``/layers/meta-custom1/all.inc`` would be included, and
+then ``/layers/meta-custom2/all.inc`` if both are found.
+
+.. note::
+
+   The same logic as for the :ref:`ref-include-directive` applies, except that
+   the path relative to the file where the directive is specified is not
+   searched when using the ``include_all`` directive.
+
 Locating Class Files
 --------------------
 

-- 
2.52.0


