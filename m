Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF110AB81C
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 19:23:59 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57031.1774553030076229924
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 12:23:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=SKCSkJlQ;
 spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fhYbm3SQpzGHr;
	Thu, 26 Mar 2026 20:23:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1774553028;
	bh=07SGn0O4d4/7peMA7R3b/Ybjektv3nvxlO40CCP19NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SKCSkJlQQU3+CNSLLwkOT/mgQaILBEWuZW3teoY+TtYo6n5vfu0WhNOnquDQcXTLo
	 jnX0bplHzTl/CcmGOau2uqcu4VF/0uvLf5uZWsUxPbm5r2l9+VrXqzWIu7IWWed+kv
	 iZ8s3rn8o6Fnc2j57FUcV4Y0bzqXxLkfMGr0OsGHdZIcDNb4Jb/32tbUpVXhOcTJdf
	 Deh7eNvAoA4mC7AcSnljtv7R5RDns4xKFww0zcw1KffXOxp5G8AOWnV9YTHbdjRzBB
	 wIvcyjnQAmHXhz6rN0eQX1CylAV1QHFt3XhCB2mgCJvzpB2qBhPcjatjaEatmkgzVE
	 vufyP5f46XQUw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fhYbl6w6MzLjy;
	Thu, 26 Mar 2026 20:23:47 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 26 Mar 2026 20:23:33 +0100
Subject: [PATCH 3/3] doc: bitbake-user-manual-metadata: fix indentation
 consistency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-metadata-code-blk-v1-3-051530f9a051@cherry.de>
References: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
In-Reply-To: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 19:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19260

From: Quentin Schulz <quentin.schulz@cherry.de>

We've decided bullet lists should be started by a dash followed by two
whitespaces and the other lines in the bullet list should be indented
at that level, that is with three whitespaces compared to the parent
block. This only has two while the rest of the file has three, so let's
add the missing whitespace. This is cosmetic in the sources only, it
doesn't change the output.

Fixes: 6bc65e6402a7 ("documentation: bitbake: add file-checksums to varflags section")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-metadata.rst               | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 4909b0d75..40cae6b05 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1771,22 +1771,22 @@ functionality of the task:
    directory listed is used as the current working directory for the
    task.
 
-- ``[file-checksums]``: Controls the file dependencies for a task. The
-  baseline file list is the set of files associated with
-  :term:`SRC_URI`. May be used to set additional dependencies on
-  files not associated with :term:`SRC_URI`.
+-  ``[file-checksums]``: Controls the file dependencies for a task. The
+   baseline file list is the set of files associated with
+   :term:`SRC_URI`. May be used to set additional dependencies on
+   files not associated with :term:`SRC_URI`.
 
-  The value set to the list is a file-boolean pair where the first
-  value is the file name and the second is whether or not it
-  physically exists on the filesystem. ::
+   The value set to the list is a file-boolean pair where the first
+   value is the file name and the second is whether or not it
+   physically exists on the filesystem. ::
 
-    do_configure[file-checksums] += "${MY_DIRPATH}/my-file.txt:True"
+      do_configure[file-checksums] += "${MY_DIRPATH}/my-file.txt:True"
 
-  It is important to record any paths which the task looked at and
-  which didn't exist. This means that if these do exist at a later
-  time, the task can be rerun with the new additional files. The
-  "exists" True or False value after the path allows this to be
-  handled.
+   It is important to record any paths which the task looked at and
+   which didn't exist. This means that if these do exist at a later
+   time, the task can be rerun with the new additional files. The
+   "exists" True or False value after the path allows this to be
+   handled.
 
 -  ``[lockfiles]``: Specifies one or more lockfiles to lock while the
    task executes. Only one task may hold a lockfile, and any task that

-- 
2.53.0


