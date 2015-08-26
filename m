Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 75B2776DFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:23 +0000 (UTC)
Received: by pacti10 with SMTP id ti10so93270075pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=G/ojRpWQWDpXK7Hz3i9B3MTGADqb0YM2SNhS9aaka2c=;
	b=fbFvyOLIcpprF7o2ca4280z5fYnyojo9HT0Zc5zHebu1XdakbkdCuNDuSP4/98lNFE
	zkX6yb9uHsMlLv28NGXZNgpXhcSJwd6KUryCA4Je7DC1TidHt6K23QPRP+7s0OYgbx8k
	mGRVjZESM+46NMOo4n3RzS44p71nVJmQKd9YeyjT8VFrGVLccgfvg4FIvrQxkx76kc+a
	trBvscrhUyWmqPVH9cJL/hRCsrb/uksMiPRoIeEk1kJhLh5fAakC912waKGocltFym4D
	LxKlJn8oQ9ngJFS/5ZV2CcLmUAmLTU4EUI+DvL7yLqLyqoOIzWgE8wFsSc77YpJU0Udx
	7nHQ==
X-Received: by 10.68.69.7 with SMTP id a7mr71885121pbu.78.1440607043886;
	Wed, 26 Aug 2015 09:37:23 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	qe3sm25214673pbc.73.2015.08.26.09.37.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:22 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:38:06 -0700
Message-Id: <1440607088-14563-3-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
References: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/4] bb.fetch: support ud.mirrortarballs
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:23 -0000

From: Christopher Larson <chris_larson@mentor.com>

This lets us support multiple mirror tarball filenames. The main use case for
this at this time is for git, to be able to support both shallow and full git
mirror tarballs.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 04d9679..e1737e4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -429,7 +429,7 @@ def encodeurl(decoded):
 
     return url
 
-def uri_replace(ud, uri_find, uri_replace, replacements, d):
+def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     if not ud.url or not uri_find or not uri_replace:
         logger.error("uri_replace: passed an undefined value, not replacing")
         return None
@@ -468,9 +468,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d):
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-                if uri_decoded[0] != uri_replace_decoded[0] and ud.mirrortarball:
+                if uri_decoded[0] != uri_replace_decoded[0] and mirrortarball:
                     # If the source and destination url types differ, must be a mirrortarball mapping
-                    basename = os.path.basename(ud.mirrortarball)
+                    basename = os.path.basename(mirrortarball)
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
@@ -862,13 +862,13 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["BASENAME"] = origud.path.split("/")[-1]
     replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
 
-    def adduri(ud, uris, uds):
+    def adduri(ud, uris, uds, tarball):
         for line in mirrors:
             try:
                 (find, replace) = line
             except ValueError:
                 continue
-            newuri = uri_replace(ud, find, replace, replacements, ld)
+            newuri = uri_replace(ud, find, replace, replacements, ld, tarball)
             if not newuri or newuri in uris or newuri == origud.url:
                 continue
 
@@ -885,16 +885,20 @@ def build_mirroruris(origud, mirrors, ld):
                 try:
                     # setup_localpath of file:// urls may fail, we should still see 
                     # if mirrors of the url exist
-                    adduri(newud, uris, uds)
+                    adduri(newud, uris, uds, tarball)
                 except UnboundLocalError:
                     pass
-                continue   
+                continue
             uris.append(newuri)
             uds.append(newud)
 
-            adduri(newud, uris, uds)
+            adduri(newud, uris, uds, tarball)
 
-    adduri(origud, uris, uds)
+    if hasattr(origud, 'mirrortarballs'):
+        for tarball in origud.mirrortarballs:
+            adduri(origud, uris, uds, tarball)
+    else:
+        adduri(origud, uris, uds, getattr(origud, 'mirrortarball', None))
 
     return uris, uds
 
-- 
2.2.1


