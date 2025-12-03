Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EBD1BDC2
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 17:07:08 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20770.1764781622194367001
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 09:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM3w44GHvzKbC;
	Wed,  3 Dec 2025 18:07:00 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dM3w4199mzJV1;
	Wed,  3 Dec 2025 18:07:00 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 03 Dec 2025 18:06:50 +0100
Subject: [PATCH 1/3] doc: fix a few typos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-doc-file-include-require-v1-1-fc708832b475@cherry.de>
References: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
In-Reply-To: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 17:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18534

From: Quentin Schulz <quentin.schulz@cherry.de>

Some spurious whitespaces, bad grammar and typo are fixed here.

Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst    | 4 ++--
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 9837b009e..2875e18f3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -213,7 +213,7 @@ BitBake supports class files installed in three different directories:
 
 -  ``classes-global/``: these classes must be inherited globally through the
    :term:`INHERIT` variable in a :ref:`configuration file
-   <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`.  These
+   <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`. These
    classes are included for every recipe being built. For example, you would use
    the global class named ``myclass`` like so::
 
@@ -227,7 +227,7 @@ BitBake supports class files installed in three different directories:
       inherit myclass
 
 -  ``classes/``: this final directory is meant for classes that can be used in
-   the two contexts explain above. In other words, they can be inherit either
+   the two contexts explain above. In other words, they can be inherited either
    globally or in a recipe.
 
 For details on how BitBake locates class files, see the
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index e5075a346..ef8ab024d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1060,7 +1060,7 @@ Additionally, BitBake searches the current directory for :ref:`include
 
 .. note::
 
-   The BBPATH variable is analogous to the environment variable PATH .
+   The BBPATH variable is analogous to the environment variable PATH.
 
 For these two directives, BitBake includes the first file it finds.
 
@@ -1135,7 +1135,7 @@ would be searched in this order::
 
 .. note::
 
-   Note that the order of the list above does not depend on where the class in
+   Note that the order of the list above does not depend on where the class is
    inherited from.
 
 Likewise, for classes inherited with the :term:`INHERIT` variable, the

-- 
2.52.0


