Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 759207719D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 17:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 517E31811A;
	Wed, 27 Jan 2016 18:23:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ET8nGVzBot0Z; Wed, 27 Jan 2016 18:23:42 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id EF9E618098;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id D92621335;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id CD442158E;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id C76CA3E48C;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u0RHNf6v001801;
	Wed, 27 Jan 2016 18:23:41 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u0RHNfxA001800;
	Wed, 27 Jan 2016 18:23:41 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org, poky@yoctoproject.org
Date: Wed, 27 Jan 2016 18:23:28 +0100
Message-Id: <8c8081c64d996b42d062e648f866b191579dfbae.1453915249.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1453915249.git.pkj@axis.com>
References: <cover.1453915249.git.pkj@axis.com>
In-Reply-To: <cover.1453915249.git.pkj@axis.com>
References: <cover.1453915249.git.pkj@axis.com>
Subject: [PATCH 2/5] bitbake-user-manual-ref-variables: Update the help for BBMASK
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Jan 2016 17:23:45 -0000

Update the help for BBMASK to reflect that it is now allowed to
contain multiple regular expressions. Also changed the examples for
BBMASK to be a bit more diverse.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 .../bitbake-user-manual-ref-variables.xml            | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index e5aeffc..ae7e4ce 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1142,14 +1142,14 @@
                     to "hide" these <filename>.bb</filename> and
                     <filename>.bbappend</filename> files.
                     BitBake ignores any recipe or recipe append files that
-                    match the expression.
+                    match any of the expressions.
                     It is as if BitBake does not see them at all.
                     Consequently, matching files are not parsed or otherwise
                     used by BitBake.</para>
                 <para>
-                    The value you provide is passed to Python's regular
+                    The values you provide are passed to Python's regular
                     expression compiler.
-                    The expression is compared against the full paths to
+                    The expressions are compared against the full paths to
                     the files.
                     For complete syntax information, see Python's
                     documentation at
@@ -1165,18 +1165,16 @@
      BBMASK = "meta-ti/recipes-misc/"
                     </literallayout>
                     If you want to mask out multiple directories or recipes,
-                    use the vertical bar to separate the regular expression
-                    fragments.
+                    you can specify multiple regular expression fragments.
                     This next example masks out multiple directories and
                     individual recipes:
                     <literallayout class='monospaced'>
-     BBMASK = "meta-ti/recipes-misc/|meta-ti/recipes-ti/packagegroup/"
-     BBMASK .= "|.*meta-oe/recipes-support/"
-     BBMASK .= "|.*openldap"
-     BBMASK .= "|.*opencv"
-     BBMASK .= "|.*lzma"
+     BBMASK += "/meta-ti/recipes-misc/ meta-ti/recipes-ti/packagegroup/"
+     BBMASK += "/meta-oe/recipes-support/"
+     BBMASK += "/meta-foo/.*/openldap"
+     BBMASK += "opencv.*\.bbappend"
+     BBMASK += "lzma"
                     </literallayout>
-                    Notice how the vertical bar is used to append the fragments.
                     <note>
                         When specifying a directory name, use the trailing
                         slash character to ensure you match just that directory
-- 
2.1.0


