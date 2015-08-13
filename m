Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 28E1F765A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 23:46:45 +0000 (UTC)
Received: by pacrr5 with SMTP id rr5so47294336pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=KNuzF5S13RUhZmp3xceOiZdqhc4SGFCz5Gx/RyqUW7I=;
	b=T9cpOQdHTXP2OBKlDLeHo0YwV2VGYvInDlKCRvOfYlAcM2zcampkql6MztWopIcFtJ
	Egsj8HvVc44Lu2KnZOJX1QaN5E72CAn1KeaLTcIIagf27AzsOVcQ2vL0O+X5O4sBWq0h
	Qh30qjz9KbxcPjIhJVxosQlW++BHIchwJADVBI2usJ+LkuKD1R7DyD4J+iY0LylmP4+E
	zmOIJImd2F5oAsa92ZAbjYLkOw1c/pOUf6YUutLXzeLKDAuRxhO0ZcJsehshlWeE6RaC
	AVqTQ/+Yfo+WLGlR3ra7Au0yzJB6U+GGs1KzDo/cRSakE9gUVfj8W14TvBlPkW9z2C6A
	C+KA==
X-Received: by 10.68.243.103 with SMTP id wx7mr34870396pbc.60.1439509606446;
	Thu, 13 Aug 2015 16:46:46 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i10sm3883933pdr.78.2015.08.13.16.46.45
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Aug 2015 16:46:45 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2015 16:46:38 -0700
Message-Id: <24e81640726aa1075617c1bbc3234a4d22f0a4f4.1439509247.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
Subject: [RFC PATCH 4/5] bb.fetch: support ud.mirrortarballs
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
X-List-Received-Date: Thu, 13 Aug 2015 23:46:46 -0000

From: Christopher Larson <chris_larson@mentor.com>

This lets us support multiple types of mirror tarballs. The main use case for
this at this time is for git, to be able to support both shallow and full git
mirror tarballs.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c5e1758..207c4e4 100644
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
@@ -858,13 +858,13 @@ def build_mirroruris(origud, mirrors, ld):
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
 
@@ -881,16 +881,20 @@ def build_mirroruris(origud, mirrors, ld):
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


