Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975DDCF45AA
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:44 +0000 (UTC)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37255.1768235798753049155
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLY1J7JznmJ;
	Mon, 12 Jan 2026 17:36:37 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLX5Yrvzg2W;
	Mon, 12 Jan 2026 17:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:10 +0100
Subject: [PATCH 6/8] doc: bitbake-user-manual-metadata: fix incorrect path
 in example for locating files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-6-b23923cfce89@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18740

From: Quentin Schulz <quentin.schulz@cherry.de>

The paths listed in the example are missing an "example" subdirectory to
match the searched paths in the example, let's fix this oversight.

Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 44a1e519b..719689150 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1080,11 +1080,11 @@ For these two directives, BitBake includes the first file it finds.
    with the :ref:`include_all <ref-include-all-directive>` directive.
 
 Let's consider the following statement called from a recipe file located in
-``/layers/meta-custom2/recipes-example/example_0.1.bb``::
+``/layers/meta-custom2/recipes-example/example/example_0.1.bb``::
 
    require myfile.inc
 
-Where ``myfile.inc`` is located in ``/layers/meta-custom2/recipes-example/``.
+Where ``myfile.inc`` is located in ``/layers/meta-custom2/recipes-example/example``.
 
 And let's assume that the value of :term:`BBPATH` is
 ``/layers/meta-custom1:/layers/meta-custom2``. Then BitBake will try to find

-- 
2.52.0


