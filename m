Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id E8E437714D
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:44:20 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id p185so17792415pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=EXt1D9GfnZyQjDwPH41Jxb1l5TgSTyes9WWQEcd1/bI=;
	b=TrPRIhHs7uzaV0uecZinDB6KM+g2MkgAXX8plHm9flgEPuXqwIHkh70vvhufOJvZa8
	74rMA+RLeqsx3HVXwR8JZY9HzVSa5r9htcEumGNfrgr/EY0RrhAdQlv/romv8EFxyPww
	0tzW3vA0I3wJa7u0qRYj69ZRyImPzFe/DFTwFyzWLJx0nH+myg31VaA49O4O4Jr3JA27
	WmZbLBmaEl8DS5NXHzuNewiPeMVcbnnywEeVcGdF71ZyRtH8WHcG6K/tpBRWQenNuFY8
	aLfsvUFMC8oRR164/b69w3TfBUEvL6EJG4dvZ5ZyKLNIdOYUQE3/iG1y+m3cnkBbwvM8
	fC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EXt1D9GfnZyQjDwPH41Jxb1l5TgSTyes9WWQEcd1/bI=;
	b=aeXSvPBr8uLxvKZB6otJdhUQJZzSrARKT0WgSfsreXAJlB7JEUo4Ku+9Np2hlxMmud
	JbbMcuzcg2vxKuGa6piQPKl7/svD46FigqwRxR9Lk/n1ioP8zsOiwJ4pd6hIQK246YMs
	plrHwKxbBFW6HrvIARtV/W5+Ay28cAArU7LojT1lKVFfP6mL2Asa9oW4Soaif7rrTl8X
	woDMfv38T9zfnM/yslFQgNO5aCxcmDQK5T7SsAF8AwnJcrFgGhLiCH4uc9CDgYpDCPhz
	OPeWvQrR9wtufg3/DjnTXrh+agL0j2u8bHtrA2ftdGbOYm5riqkBw2f+wmqfxCLApZ4O
	NqOA==
X-Gm-Message-State: AOPr4FWLVP0G51o7OnXspGCNfxqnLLjufW2+tVjex1ZJd5Chm5490+nwmY0s5xZaQowI1g==
X-Received: by 10.98.41.65 with SMTP id p62mr38491382pfp.29.1462045461419;
	Sat, 30 Apr 2016 12:44:21 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	m184sm33275124pfb.22.2016.04.30.12.44.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:44:19 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:44:13 -0700
Message-Id: <449e5498ef05cc36d4f01e161c1b1093ef82d020.1462042322.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <98d64b9af58521cc7c7b33d5584720e88e673a3e.1462042322.git.chris_larson@mentor.com>
References: <98d64b9af58521cc7c7b33d5584720e88e673a3e.1462042322.git.chris_larson@mentor.com>
In-Reply-To: <cover.1462042322.git.chris_larson@mentor.com>
References: <cover.1462042322.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 2/3] bb.fetch: support ud.mirrortarballs
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
X-List-Received-Date: Sat, 30 Apr 2016 19:44:21 -0000

From: Christopher Larson <chris_larson@mentor.com>

This lets us support multiple mirror tarball filenames. The main use case for
this at this time is for git, to be able to support both shallow and full git
mirror tarballs.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1b4547d..fc38f11 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -430,7 +430,7 @@ def encodeurl(decoded):
 
     return url
 
-def uri_replace(ud, uri_find, uri_replace, replacements, d):
+def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     if not ud.url or not uri_find or not uri_replace:
         logger.error("uri_replace: passed an undefined value, not replacing")
         return None
@@ -469,9 +469,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d):
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
@@ -869,13 +869,13 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["BASENAME"] = origud.path.split("/")[-1]
     replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
 
-    def adduri(ud, uris, uds, mirrors):
+    def adduri(ud, uris, uds, mirrors, tarball):
         for line in mirrors:
             try:
                 (find, replace) = line
             except ValueError:
                 continue
-            newuri = uri_replace(ud, find, replace, replacements, ld)
+            newuri = uri_replace(ud, find, replace, replacements, ld, tarball)
             if not newuri or newuri in uris or newuri == origud.url:
                 continue
 
@@ -898,16 +898,20 @@ def build_mirroruris(origud, mirrors, ld):
                 try:
                     # setup_localpath of file:// urls may fail, we should still see 
                     # if mirrors of the url exist
-                    adduri(newud, uris, uds, localmirrors)
+                    adduri(newud, uris, uds, localmirrors, tarball)
                 except UnboundLocalError:
                     pass
-                continue   
+                continue
             uris.append(newuri)
             uds.append(newud)
 
-            adduri(newud, uris, uds, localmirrors)
+            adduri(newud, uris, uds, localmirrors, tarball)
 
-    adduri(origud, uris, uds, mirrors)
+    if hasattr(origud, 'mirrortarballs'):
+        for tarball in origud.mirrortarballs:
+            adduri(origud, uris, uds, mirrors, tarball)
+    else:
+        adduri(origud, uris, uds, mirrors, getattr(origud, 'mirrortarball', None))
 
     return uris, uds
 
-- 
2.8.0


