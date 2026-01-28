Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD81D3F09C
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 17:11:22 +0000 (UTC)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2699.1769620279245507406
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 09:11:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1TM91chkzJKS;
	Wed, 28 Jan 2026 18:11:17 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1TM707YpzSx2;
	Wed, 28 Jan 2026 18:11:14 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 28 Jan 2026 18:11:06 +0100
Subject: [PATCH] doc: bitbake-user-manual-intro: improve bbappend file
 matching doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-bbappend-matching-v1-1-29fef2d63489@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBN0wP6uEi00p5xFJhoRSHdPW
 n6L9wpkSkwZpqZAopszn6FCtQ2s3oSdBLtqQImdVDgIa02MFJw4zLV6Drtw0mrUaJTqR6hdTLT
 x8z/n5X0/RCqg0WMAAAA=
X-Change-ID: 20260128-bbappend-matching-d0b5252a1179
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Robert P. J. Day" <rpjday@crashcourse.ca>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 17:11:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18920

From: Quentin Schulz <quentin.schulz@cherry.de>

The recipe name matching wasn't fully explained and were missing a few
important corner cases such as recipes without a version, or using the %
character outside of the version part of the filename for example.

This adds the last missing bits to cover every append naming scenario
that exist today.

This was derived from lib/bb/cooker.py:get_file_appends().

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-intro.rst                  | 51 +++++++++++++++++-----
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index baad71304..c971976d3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -271,12 +271,9 @@ same root filename. The filenames can differ only in the file type
 suffix used (e.g. ``formfactor_0.0.bb`` and
 ``formfactor_0.0.bbappend``).
 
-Information in append files extends or overrides the information in the
-underlying, similarly-named recipe files.
-
 When you name an append file, you can use the "``%``" wildcard character
-to allow for matching recipe names. For example, suppose you have an
-append file named as follows::
+to allow for a less strict recipe name matching. For example, suppose you have
+an append file named as follows::
 
   busybox_1.21.%.bbappend
 
@@ -290,12 +287,6 @@ the append file would match the following recipe names::
   busybox_1.21.10.bb
   busybox_1.21.11.bb
 
-.. note::
-
-   The use of the " % " character is limited in that it only works directly in
-   front of the .bbappend portion of the append file's name. You cannot use the
-   wildcard character in any other location of the name.
-
 If the ``busybox`` recipe was updated to ``busybox_1.3.0.bb``, the
 append name would not match. However, if you named the append file
 ``busybox_1.%.bbappend``, then you would have a match.
@@ -303,6 +294,44 @@ append name would not match. However, if you named the append file
 In the most general case, you could name the append file something as
 simple as ``busybox_%.bbappend`` to be entirely version independent.
 
+The "``%``" character is a marker for BitBake, and everything after that marker
+will not be used for matching recipe names. That is, an append file named::
+
+   busybox_1.%.11.bb
+
+will match recipes named::
+
+   busybox_1.0.11.bb
+   busybox_1.2.bb
+   busybox_1.3.48.bb
+
+Note that the "``%``" character is not specific to the version part of the
+recipe name. That is, an append file named::
+
+   linux-yocto%.bbappend
+
+will match recipes named::
+
+   linux-yocto.bb
+   linux-yocto_6.18.bb
+   linux-yocto-tiny_6.12.bb
+   linux-yocto-rt_6.16.bb
+
+While it can be useful to append to similar recipes with slightly different
+names, it is highly discouraged to do so as recipes from other layers may be
+named similarly enough that the append file would unwittingly match them.
+
+A recipe named without a version may only be appended by an append file named
+exactly the same. That is, a recipe named::
+
+   mesa.bb
+
+can only be appended by an append file named::
+
+   mesa.bbappend
+
+That is, ``mesa_%.bbappend`` append file will not match ``mesa.bb`` recipe.
+
 Obtaining BitBake
 =================
 

---
base-commit: cdd79c1768ac396a9c6577e38098da4331507f24
change-id: 20260128-bbappend-matching-d0b5252a1179

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


