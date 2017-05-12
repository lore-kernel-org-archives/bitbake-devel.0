Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 3FCE777D19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:42 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id u26so8301879pfd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=QLJWpa9+VqKyd/Twm+5IzKOaaBULbmvRacx8VkjsQ88=;
	b=nzG3fSR1o/zSZsvxfNo7m9jE2M0X+74+rxNBihmf5CgPlnuHrhCc0X9MtP5sFeV0VO
	iT1jBtrAOjNCE0gjjdT0sSBSWksd+lkyU+HNON6LRZoktHdoOs9fLwCGPDkMNR7AvVxl
	PinrugeVVsssf6TK2eeIdAk4b7pWarPF+z4SXmlXDO5yNiQqwy1mrWy2hDRaSMtZ/5hS
	SLUFpyIjdJ2C5ri4zWyo9zEPUHOrWaBoeOjz9rz3lnNrqPd8WwSRIQro0m+7XZznZ5La
	yyiDU3ItjK8VtCgbV7EWtT3ZczBUYz95R0uHBgd9gj2A/p8zAo8S5Ylz1CknxaNPR/rR
	T0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=QLJWpa9+VqKyd/Twm+5IzKOaaBULbmvRacx8VkjsQ88=;
	b=lEyqzcQy1wbI4mdpQR12FplFnQc8OPSgf/mbFTV3Urw4/BSmQu5I07/c+vAwFEUXQp
	r2eHou10OCJV7QQh6RVV0hsaBOISNmNwqPMPHemDVOHomDirOR/t+InswQgmu2BNwTt2
	eIXLtGzhwlH349oyN3iaAE0hJYfwApdZAWVBJkzzEfIBpUkslfwC8XzEP1JD3ZRue5gd
	at/ZHXKnmLa3cnN2p1Lv1aQXZBCUKAwNgeBArRNxlqKAl3pfXH2kbS2MTnJwRYVWeRHe
	yE5ema2JXJVvBA2CKJYP7F2KJ67hg1Q2u5kBQkAtdkWjOi5m0zMVLgpDFShEnDaUB5c2
	6XDA==
X-Gm-Message-State: AODbwcCDctykUgdStnZF3AIJY1qLiiKiAZMUxgtErtb3BKT8JdZegHJi
	9l/f57cZQckbNQ==
X-Received: by 10.84.222.136 with SMTP id x8mr8636120pls.50.1494625604221;
	Fri, 12 May 2017 14:46:44 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:42 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:26 +0500
Message-Id: <e045a84d2856d22fd92c9533df331ed17b83d37f.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/8] fetch: support multiple mirror tarball filenames
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
X-List-Received-Date: Fri, 12 May 2017 21:46:43 -0000

Remove ud.mirrortarball in favor of ud.mirrortarballs. Each tarball will be
attempted, in order, and the first available will be used. This is needed for
git shallow mirror tarball support, as we want to be able to use either
a shallow or full mirror tarball.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 72 ++++++++++++++++++++++++-----------------------
 lib/bb/fetch2/git.py      |  5 ++--
 lib/bb/fetch2/hg.py       |  5 ++--
 lib/bb/fetch2/npm.py      |  7 +++--
 4 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 136fc29c..35902988 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -425,7 +425,7 @@ def encodeurl(decoded):
 
     return url
 
-def uri_replace(ud, uri_find, uri_replace, replacements, d):
+def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     if not ud.url or not uri_find or not uri_replace:
         logger.error("uri_replace: passed an undefined value, not replacing")
         return None
@@ -464,9 +464,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d):
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
@@ -892,45 +892,47 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["BASENAME"] = origud.path.split("/")[-1]
     replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
 
-    def adduri(ud, uris, uds, mirrors):
+    def adduri(ud, uris, uds, mirrors, tarballs):
         for line in mirrors:
             try:
                 (find, replace) = line
             except ValueError:
                 continue
-            newuri = uri_replace(ud, find, replace, replacements, ld)
-            if not newuri or newuri in uris or newuri == origud.url:
-                continue
 
-            if not trusted_network(ld, newuri):
-                logger.debug(1, "Mirror %s not in the list of trusted networks, skipping" %  (newuri))
-                continue
+            for tarball in tarballs:
+                newuri = uri_replace(ud, find, replace, replacements, ld, tarball)
+                if not newuri or newuri in uris or newuri == origud.url:
+                    continue
 
-            # Create a local copy of the mirrors minus the current line
-            # this will prevent us from recursively processing the same line
-            # as well as indirect recursion A -> B -> C -> A
-            localmirrors = list(mirrors)
-            localmirrors.remove(line)
+                if not trusted_network(ld, newuri):
+                    logger.debug(1, "Mirror %s not in the list of trusted networks, skipping" %  (newuri))
+                    continue
+
+                # Create a local copy of the mirrors minus the current line
+                # this will prevent us from recursively processing the same line
+                # as well as indirect recursion A -> B -> C -> A
+                localmirrors = list(mirrors)
+                localmirrors.remove(line)
 
-            try:
-                newud = FetchData(newuri, ld)
-                newud.setup_localpath(ld)
-            except bb.fetch2.BBFetchException as e:
-                logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
-                logger.debug(1, str(e))
                 try:
-                    # setup_localpath of file:// urls may fail, we should still see 
-                    # if mirrors of the url exist
-                    adduri(newud, uris, uds, localmirrors)
-                except UnboundLocalError:
-                    pass
-                continue   
-            uris.append(newuri)
-            uds.append(newud)
+                    newud = FetchData(newuri, ld)
+                    newud.setup_localpath(ld)
+                except bb.fetch2.BBFetchException as e:
+                    logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
+                    logger.debug(1, str(e))
+                    try:
+                        # setup_localpath of file:// urls may fail, we should still see 
+                        # if mirrors of the url exist
+                        adduri(newud, uris, uds, localmirrors, tarballs)
+                    except UnboundLocalError:
+                        pass
+                    continue
+                uris.append(newuri)
+                uds.append(newud)
 
-            adduri(newud, uris, uds, localmirrors)
+                adduri(newud, uris, uds, localmirrors, tarballs)
 
-    adduri(origud, uris, uds, mirrors)
+    adduri(origud, uris, uds, mirrors, origud.mirrortarballs or [None])
 
     return uris, uds
 
@@ -975,8 +977,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         # We may be obtaining a mirror tarball which needs further processing by the real fetcher
         # If that tarball is a local file:// we need to provide a symlink to it
         dldir = ld.getVar("DL_DIR")
-        if origud.mirrortarball and os.path.basename(ud.localpath) == os.path.basename(origud.mirrortarball) \
-                and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+
+        if origud.mirrortarballs and os.path.basename(ud.localpath) in origud.mirrortarballs and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
             # Create donestamp in old format to avoid triggering a re-download
             if ud.donestamp:
                 bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
@@ -993,7 +995,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                     pass
             if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
-                if hasattr(origud.method,"build_mirror_data"):
+                if hasattr(origud.method, "build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
@@ -1190,7 +1192,7 @@ class FetchData(object):
         self.localfile = ""
         self.localpath = None
         self.lockfile = None
-        self.mirrortarball = None
+        self.mirrortarballs = []
         self.basename = None
         self.basepath = None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2550bde8..01d4bbdc 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -205,8 +205,9 @@ class Git(FetchMethod):
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
-        ud.mirrortarball = 'git2_%s.tar.gz' % gitsrcname
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
+        mirrortarball = 'git2_%s.tar.gz' % gitsrcname
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
+        ud.mirrortarballs = [mirrortarball]
         gitdir = d.getVar("GITDIR") or (d.getVar("DL_DIR") + "/git2/")
         ud.clonedir = os.path.join(gitdir, gitsrcname)
 
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index b5f26860..d0857e63 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -76,8 +76,9 @@ class Hg(FetchMethod):
         # Create paths to mercurial checkouts
         hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
                             ud.host, ud.path.replace('/', '.'))
-        ud.mirrortarball = 'hg_%s.tar.gz' % hgsrcname
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
+        mirrortarball = 'hg_%s.tar.gz' % hgsrcname
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
+        ud.mirrortarballs = [mirrortarball]
 
         hgdir = d.getVar("HGDIR") or (d.getVar("DL_DIR") + "/hg/")
         ud.pkgdir = os.path.join(hgdir, hgsrcname)
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 73a75fe9..5f799724 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -91,9 +91,10 @@ class Npm(FetchMethod):
         ud.prefixdir = prefixdir
 
         ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0")
-        ud.mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
-        ud.mirrortarball = ud.mirrortarball.replace('/', '-')
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
+        mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
+        mirrortarball = ud.mirrortarball.replace('/', '-')
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
+        ud.mirrortarballs = [mirrortarball]
 
     def need_update(self, ud, d):
         if os.path.exists(ud.localpath):
-- 
2.11.1


