Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15031.1794913101023309254
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 02:58:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=RLpFm1vr;
 spf=pass (domain: snapchat.com, ip: 209.85.221.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so608223f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794913099; x=1795517899; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o90wfCEH2o8W42FKQ9O2tOtcUWe75P+6Pxri3+7UfME=;
        b=RLpFm1vrEDmjzv6ZTTxNcloD6vsyOA0gUpNTNqYTFHfVL9Ga28hqaNXTUE5LySDNys
         LhIYFOPl7hs/gaH5J934nsPBXwzBOdF3ZYaWXvUIMjnancrCkXrrU7OdlcbmiGQPERV4
         wwz3lRwAbSHPRsfQcwx268DIs007vpYIGhj00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913099; x=1795517899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o90wfCEH2o8W42FKQ9O2tOtcUWe75P+6Pxri3+7UfME=;
        b=M6IEg2Otw+FmlepCoj561dv+IwiwAiVgnts81cNEeZuJv4caiMd5+Is2u2TFdOVq+R
         QO+EpsjKC7EX9WeteBRUJj4vm6LDE0xnDnzTvGLlce2GY041EYH90Pd7xLA312yDCVzX
         8DqUXZjctTcQfKAbw3LYmTEdtdHaRTojRKJyyvRXbh/BO5060tur9+fTWXcCAkzC1kst
         BYKZXBf1Q7pWAtY/q07ETXEUn0A2WPmNQJmxwnoJ92fLp1ukI0Ok4mCxol7iPlJK0ZOr
         wQSX1yCRppLbPNY69+amjhdqlNbZATGYAGfcmnIrfa+wky1r+KxsZBLiiKhsVOgoKMIg
         VOtw==
X-Gm-Message-State: APuU4Z8kLqmHJzkd1kpsNoISTsiK+xEpQ4IhSacbkbB5BP36OhfeRIL7
	M04XcXNew7amPLzTFxblp8FAzAJPykG04IqGIk6F4HhP29PxrlCeJOA+YSIjlXA52Jec9hL7kX/
	CU2ZIsUg=
X-Gm-Gg: AZFdTZcwogoKlEm6QpxPC8VYhwKV/iwq5yGQB4Mzz+gBxRD3eKuL+sdgC2tHjeywLTm
	FJ03u/2yzOFU41WtmaI69hQhc4TwZz3+Th9K4UppapUtdkSFYFtPPIchoG17Kn+KSVfco+X5Tan
	TnzlRX+IuYuh2oz2BguQlrTDksZWYbV+nD1WAIixgYvK2SQxciMAYdZo/5+xfb1iV7Tr+XiIVbs
	Y3nUtiRLG06b65NGSxpnSKesbzGu3/c+8xqVPxr0uc/KDFxktXMDFlWC8qdMWxeaNW/RExlAvKl
	/SFe5E50vyZNTQfCrpjgcuTkEKWR94TfEm4GV4EppSUupKkAFqVZrxSKNQ0gcvfL00jFvy47TIs
	ExUFs7onvGmXEkMnXysSiuEbHsI9dD2rylf8WigTdek74YXXTwtk5Le7j7f7eBHZHG3MaMzwyWI
	KlzIgoE/cSDtUbWCQUYh5R5LCdZbNbOPu2g8LUFioihz9XJyIA0mlDN97T7ZQN75QLes82r13ZU
	suUaZTWm1im9wIjyzMCnjhQJYdMquW1+3eDOLMzDVz0Zjoaz+AUlY4l9wOsnfgbWGC5QW1Whafo
	43JP89hEZ44Ftymw8ihZxiSB4LheENXTxJ53x9HFcWGsNyoP4QnzjAlAbVKN2RCnZIHOwiPv/u5
	KM/JPMjGWErQs2VcdlPEupTQL3R6YQ65J
X-Received: by 2002:a05:6000:26ce:b0:48b:e50:7159 with SMTP id ffacd0b85a97d-49c71b5bfbemr27633833f8f.30.1794913098907;
        Tue, 17 Nov 2026 02:58:18 -0800 (PST)
Return-Path: <ecordonnier@snapchat.com>
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm27519460f8f.9.2026.11.17.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:58:18 -0800 (PST)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] fetch/git: return the shallow tarball as localpath when there is no clone
Date: Tue, 17 Nov 2026 11:58:02 +0100
Message-ID: <20261117105802.3828411-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 10:58:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20444
Content-Type: text/plain; charset="utf-8"

From: Etienne Cordonnier <ecordonnier@snap.com>

Usually localpath() exists once do_fetch has completed, but not for a
shallow fetch which uses the shallow tarball without creating the clone:
either the fast initial shallow clone, or a restore from a mirror.
download() sets ud.localpath to the tarball, but a new Fetch object, as in
the archiver, gets the non-existent clone from localpath() again.

Return the shallow tarball from localpath() when the clone does not exist.
If the clone exists, even if it is outdated, localpath() still returns it.

The names of the .done and .lock files are derived from localpath, so they
would then depend on whether the clone exists, and fetchers of the same url
would not exclude each other. Add FetchMethod.stamppath(), which defaults to
localpath, and let git always use the clone.

Do not follow the symlink of the shallow tarball in clean(), which would
remove the tarball in the mirror.

AI-Generated: Claude Sonnet 5.5
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch/__init__.py | 17 ++++++++---
 lib/bb/fetch/git.py      | 14 +++++++--
 lib/bb/tests/fetch.py    | 66 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index ce2bd62ad..88c244ba4 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1387,10 +1387,11 @@ class FetchData(object):
             return
 
         # Note: .done and .lock files should always be in DL_DIR whereas localpath may not be.
-        if self.localpath and self.localpath.startswith(dldir):
-            basepath = self.localpath
-        elif self.localpath:
-            basepath = dldir + os.sep + os.path.basename(self.localpath)
+        stamppath = self.method.stamppath(self, d) if self.localpath else None
+        if stamppath and stamppath.startswith(dldir):
+            basepath = stamppath
+        elif stamppath:
+            basepath = dldir + os.sep + os.path.basename(stamppath)
         elif self.basepath or self.basename:
             basepath = dldir + os.sep + (self.basepath or self.basename)
         else:
@@ -1431,6 +1432,14 @@ class FetchMethod(object):
         """
         return 0
 
+    def stamppath(self, urldata, d):
+        """
+        Return the path which the names of the .done and .lock files are based
+        on. This must not change between calls, as the lock is only effective
+        if every fetcher of the same url uses the same lock file.
+        """
+        return urldata.localpath
+
     def localpath(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
diff --git a/lib/bb/fetch/git.py b/lib/bb/fetch/git.py
index 75ce1eda0..4a12c4bfa 100644
--- a/lib/bb/fetch/git.py
+++ b/lib/bb/fetch/git.py
@@ -308,7 +308,16 @@ class Git(FetchMethod):
             ud.fullshallow = os.path.join(dl_dir, ud.shallowtarball)
             ud.mirrortarballs.insert(0, ud.shallowtarball)
 
+    def stamppath(self, ud, d):
+        # localpath() depends on whether the clone exists, the stamp and lock
+        # file names must not.
+        return ud.clonedir
+
     def localpath(self, ud, d):
+        # When do_fetch used the shallow tarball without creating the clone,
+        # the tarball is the result of the fetch.
+        if ud.shallow and not os.path.exists(ud.clonedir) and os.path.exists(ud.fullshallow):
+            return ud.fullshallow
         return ud.clonedir
 
     def need_update(self, ud, d):
@@ -805,8 +814,9 @@ class Git(FetchMethod):
 
         to_remove = [ud.localpath, ud.fullmirror, ud.fullmirror + ".done"]
         # The localpath is a symlink to clonedir when it is cloned from a
-        # mirror, so remove both of them.
-        if os.path.islink(ud.localpath):
+        # mirror, so remove both of them. When it is the shallow tarball, it
+        # can be a symlink to the tarball in the mirror, which must be kept.
+        if not (ud.shallow and ud.localpath == ud.fullshallow) and os.path.islink(ud.localpath):
             clonedir = os.path.realpath(ud.localpath)
             to_remove.append(clonedir)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 61dc06660..5f8256fba 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2335,6 +2335,72 @@ class GitShallowTest(FetcherTest):
         self.fetch_and_unpack()
         self.assertRevCount(1)
 
+    def test_shallow_mirrors_localpath(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch once to generate the shallow tarball
+        fetcher, ud = self.fetch()
+        mirrortarball = ud.mirrortarballs[0]
+
+        # Set up the mirror
+        mirrordir = os.path.join(self.tempdir, 'mirror')
+        bb.utils.mkdirhier(mirrordir)
+        self.d.setVar('PREMIRRORS', 'git://.*/.* file://%s/' % mirrordir)
+
+        bb.utils.rename(os.path.join(self.dldir, mirrortarball),
+                  os.path.join(mirrordir, mirrortarball))
+
+        # Fetch from the mirror, which does not create a clone
+        bb.utils.remove(self.dldir, recurse=True)
+        bb.utils.remove(self.gitdir, recurse=True)
+        fetcher, ud = self.fetch()
+        self.assertFalse(os.path.exists(ud.clonedir))
+
+        # A new fetcher must find the result of the previous fetch
+        url = self.d.getVar('SRC_URI').split()[0]
+        fetcher = bb.fetch.Fetch([url], self.d)
+        self.assertTrue(os.path.exists(fetcher.localpath(url)))
+
+        # The lock and done stamp must not depend on whether the clone exists,
+        # or fetchers would not exclude each other.
+        self.assertEqual(fetcher.ud[url].lockfile, ud.lockfile)
+        self.assertEqual(fetcher.ud[url].donestamp, ud.donestamp)
+        self.assertEqual(fetcher.ud[url].lockfile, ud.clonedir + '.lock')
+
+    def test_clean(self):
+        self.add_empty_file('a')
+
+        # Cleaning must work with and without shallow tarballs
+        for shallow in ('0', '1'):
+            self.d.setVar('BB_GIT_SHALLOW', shallow)
+            fetcher, ud = self.fetch()
+            fetcher.clean()
+            self.assertFalse(os.path.exists(ud.clonedir))
+            self.assertFalse(os.path.exists(os.path.join(self.dldir, ud.mirrortarballs[0])))
+
+    def test_shallow_mirrors_clean_keeps_mirror(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        fetcher, ud = self.fetch()
+        mirrortarball = ud.mirrortarballs[0]
+        mirrordir = os.path.join(self.tempdir, 'mirror')
+        bb.utils.mkdirhier(mirrordir)
+        self.d.setVar('PREMIRRORS', 'git://.*/.* file://%s/' % mirrordir)
+        bb.utils.rename(os.path.join(self.dldir, mirrortarball),
+                  os.path.join(mirrordir, mirrortarball))
+
+        # Fetch from the mirror, which links to the tarball in the mirror
+        bb.utils.remove(self.dldir, recurse=True)
+        bb.utils.remove(self.gitdir, recurse=True)
+        fetcher, ud = self.fetch()
+        fetcher = bb.fetch.Fetch([self.d.getVar('SRC_URI').split()[0]], self.d)
+        fetcher.clean()
+
+        # Cleaning DL_DIR must not remove the tarball in the mirror
+        self.assertTrue(os.path.exists(os.path.join(mirrordir, mirrortarball)))
+
     @skipIfNoNetwork()
     def test_shallow_mirrors_with_multiple_same_urls(self):
         url = "git://git.openembedded.org/bitbake;branch=master;protocol=https;rev=82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40"
-- 
2.43.0

