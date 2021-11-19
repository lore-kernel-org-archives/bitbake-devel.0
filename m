Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2689C433FE
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 17:06:00 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web09.11943.1637341558731057441
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Nov 2021 09:05:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C0A911BF209;
	Fri, 19 Nov 2021 17:05:56 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: fix backslash issues
Date: Fri, 19 Nov 2021 18:05:54 +0100
Message-Id: <20211119170554.1972442-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Nov 2021 17:06:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13077

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-fetching.rst          | 20 +++++++++----------
 .../bitbake-user-manual-metadata.rst          | 10 +++++-----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 4396830a..260d43ab 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -84,18 +84,18 @@ fetcher does know how to use HTTP as a transport.
 Here are some examples that show commonly used mirror definitions::
 
    PREMIRRORS ?= "\
-      bzr://.*/.\*  http://somemirror.org/sources/ \\n \
-      cvs://.*/.\*  http://somemirror.org/sources/ \\n \
-      git://.*/.\*  http://somemirror.org/sources/ \\n \
-      hg://.*/.\*   http://somemirror.org/sources/ \\n \
-      osc://.*/.\*  http://somemirror.org/sources/ \\n \
-      p4://.*/.\*   http://somemirror.org/sources/ \\n \
-     svn://.*/.\*   http://somemirror.org/sources/ \\n"
+      bzr://.*/.\*  http://somemirror.org/sources/ \n \
+      cvs://.*/.\*  http://somemirror.org/sources/ \n \
+      git://.*/.\*  http://somemirror.org/sources/ \n \
+      hg://.*/.\*   http://somemirror.org/sources/ \n \
+      osc://.*/.\*  http://somemirror.org/sources/ \n \
+      p4://.*/.\*   http://somemirror.org/sources/ \n \
+     svn://.*/.\*   http://somemirror.org/sources/ \n"
 
    MIRRORS =+ "\
-      ftp://.*/.\*   http://somemirror.org/sources/ \\n \
-      http://.*/.\*  http://somemirror.org/sources/ \\n \
-      https://.*/.\* http://somemirror.org/sources/ \\n"
+      ftp://.*/.\*   http://somemirror.org/sources/ \n \
+      http://.*/.\*  http://somemirror.org/sources/ \n \
+      https://.*/.\* http://somemirror.org/sources/ \n"
 
 It is useful to note that BitBake
 supports cross-URLs. It is possible to mirror a Git repository on an
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 119720d5..46bcfa60 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -104,15 +104,15 @@ Line Joining
 
 Outside of :ref:`functions <bitbake-user-manual/bitbake-user-manual-metadata:functions>`,
 BitBake joins any line ending in
-a backslash character ("\") with the following line before parsing
-statements. The most common use for the "\" character is to split
+a backslash character ("\\") with the following line before parsing
+statements. The most common use for the "\\" character is to split
 variable assignments over multiple lines, as in the following example::
 
    FOO = "bar \
           baz \
           qaz"
 
-Both the "\" character and the newline
+Both the "\\" character and the newline
 character that follow it are removed when joining lines. Thus, no
 newline characters end up in the value of ``FOO``.
 
@@ -125,7 +125,7 @@ Consider this additional example where the two assignments both assign
 
 .. note::
 
-   BitBake does not interpret escape sequences like "\n" in variable
+   BitBake does not interpret escape sequences like "\\n" in variable
    values. For these to have an effect, the value must be passed to some
    utility that interprets escape sequences, such as
    ``printf`` or ``echo -n``.
@@ -159,7 +159,7 @@ behavior::
    C = "qux"
    *At this point, ${A} equals "qux bar baz"*
    B = "norf"
-   *At this point, ${A} equals "norf baz"\*
+   *At this point, ${A} equals "norf baz"*
 
 Contrast this behavior with the
 :ref:`bitbake-user-manual/bitbake-user-manual-metadata:immediate variable
-- 
2.25.1


