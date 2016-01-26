Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id EFC9E731AF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 10:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 7AF11180CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:20:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id lDA0tO3GruI4 for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 0A7761810D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id E53601477
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id D9AF4FDA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id D7A2734057
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u0QAJwDk002154
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 11:19:58 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u0QAJwpX002153
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jan 2016 11:19:58 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 11:19:56 +0100
Message-Id: <0852fa81c039a5aeebe75c402f41718a2b362bad.1453803559.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1453803559.git.pkj@axis.com>
References: <cover.1453803559.git.pkj@axis.com>
In-Reply-To: <cover.1453803559.git.pkj@axis.com>
References: <cover.1453803559.git.pkj@axis.com>
Subject: [PATCH 1/1] fetch2: Simplify logic in verify_checksum()
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
X-List-Received-Date: Tue, 26 Jan 2016 10:20:01 -0000

The recent change to verify_checksum() to only show checksum warnings
if no checksums are supplied made it possible to simplify the logic a
bit more.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 5b416ab..dd1a197 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -574,10 +574,10 @@ def verify_checksum(ud, d, precomputed={}):
     else:
         sha256data = bb.utils.sha256_file(ud.localpath)
 
-    if ud.method.recommends_checksum(ud):
+    if ud.method.recommends_checksum(ud) and not ud.md5_expected and not ud.sha256_expected:
         # If strict checking enabled and neither sum defined, raise error
         strict = d.getVar("BB_STRICT_CHECKSUM", True) or "0"
-        if (strict == "1") and not (ud.md5_expected or ud.sha256_expected):
+        if strict == "1":
             logger.error('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
@@ -585,32 +585,22 @@ def verify_checksum(ud, d, precomputed={}):
             raise NoChecksumError('Missing SRC_URI checksum', ud.url)
 
         # Log missing sums so user can more easily add them
-        if not ud.md5_expected and not ud.sha256_expected:
-            logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
-                        'SRC_URI[%s] = "%s"',
-                        ud.localpath, ud.md5_name, md5data)
-            logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
-                        'SRC_URI[%s] = "%s"',
-                        ud.localpath, ud.sha256_name, sha256data)
-
-    md5mismatch = False
-    sha256mismatch = False
-
-    if ud.md5_expected != md5data:
-        md5mismatch = True
-
-    if ud.sha256_expected != sha256data:
-        sha256mismatch = True
+        logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
+                    'SRC_URI[%s] = "%s"',
+                    ud.localpath, ud.md5_name, md5data)
+        logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
+                    'SRC_URI[%s] = "%s"',
+                    ud.localpath, ud.sha256_name, sha256data)
 
     # We want to alert the user if a checksum is defined in the recipe but
     # it does not match.
     msg = ""
     mismatch = False
-    if md5mismatch and ud.md5_expected:
+    if ud.md5_expected and ud.md5_expected != md5data:
         msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'md5', md5data, ud.md5_expected)
         mismatch = True;
 
-    if sha256mismatch and ud.sha256_expected:
+    if ud.sha256_expected and ud.sha256_expected != sha256data:
         msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected)
         mismatch = True;
 
-- 
2.1.0


