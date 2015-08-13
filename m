Return-Path: <kergoth@gmail.com>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id EF93976708
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 23:46:47 +0000 (UTC)
Received: by pdco4 with SMTP id o4so24924888pdc.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=wv+zE9LOmihA64Jtk+hOh+i4rryMo5qPPqUlmiI/Oh0=;
	b=BkmiPbq4M/QncXkL1ejQUjM5muIxsEL7b+WnV/qT7s6uTZEeMHJzgEVjI66WW5kVep
	lFjTiQpFoIE6LBvNUjb+/BwVtj5imi1hqoCrWnWh/Bp5inn2mvnMbVPYxAOHDjCJffz5
	wzRD5iLvt0Y4aa8hY5DBaUpxYH5kDpPxZjOzv0UB4vK26cZYnHUPWaZaiPkK+3mX2VQg
	kWyVYPA6/NeRrC1WxqCEKJW2QHMj7Xdl++Dd2Oq81P7sE6/jiRyMk6Xr4NR+zwpQoALo
	H64RQiWj8hAUTZO1nkO71IPy3ezDTtNMwE2nRbaVk0rcetpjXadS1oq3ZjMdfaLyXv/B
	5n1w==
X-Received: by 10.70.54.196 with SMTP id l4mr82310180pdp.42.1439509607805;
	Thu, 13 Aug 2015 16:46:47 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i10sm3883933pdr.78.2015.08.13.16.46.46
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Aug 2015 16:46:46 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2015 16:46:39 -0700
Message-Id: <01c1164fe4b54d5f3de1fd4863808af88f06c144.1439509247.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
Subject: [RFC PATCH 5/5] bb.fetch.git: use ud.mirrortarballs
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
X-List-Received-Date: Thu, 13 Aug 2015 23:46:48 -0000

From: Christopher Larson <chris_larson@mentor.com>

If the shallow tarball isn't available, fall back to the full tarball.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 56 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c19b111..cb2e9a7 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -156,12 +156,7 @@ class Git(FetchMethod):
         # per revision, so that even the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still
         # contains the revision
-        if ud.shallows:
-            for name, shallow in ud.shallows.iteritems():
-                gitsrcname = '%s_%s_%s' % (gitsrcname, ud.branches[name].replace('/', '.'), ud.revisions[name])
-                if shallow:
-                    gitsrcname = gitsrcname + "_" + shallow
-        elif ud.rebaseable:
+        if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
 
@@ -172,15 +167,24 @@ class Git(FetchMethod):
 
         ud.mirrortarball = 'git2_%s.tar.gz' % gitsrcname
         ud.fullmirror = os.path.join(dl_dir, ud.mirrortarball)
+        if ud.shallows:
+            tarballname = gitsrcname
+            for name, shallow in ud.shallows.iteritems():
+                tarballname = '%s_%s_%s' % (tarballname, ud.branches[name].replace('/', '.'), ud.revisions[name])
+                if shallow:
+                    tarballname = tarballname + "_" + shallow
+            ud.shallowtarball = 'git2_%s.tar.gz' % tarballname
+            ud.fullshallow = os.path.join(dl_dir, ud.shallowtarball)
+            ud.mirrortarballs = [ud.shallowtarball, ud.mirrortarball]
 
     def localpath(self, ud, d):
-        if ud.shallows and os.path.exists(ud.fullmirror):
-            return ud.fullmirror
+        if ud.shallows and os.path.exists(ud.fullshallow):
+            return ud.fullshallow
         else:
             return ud.clonedir
 
     def need_update(self, ud, d):
-        if ud.shallows and os.path.exists(ud.fullmirror):
+        if ud.shallows and os.path.exists(ud.fullshallow):
             return False
         if not os.path.exists(ud.clonedir):
             return True
@@ -188,7 +192,7 @@ class Git(FetchMethod):
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
                 return True
-        if ud.write_tarballs and not os.path.exists(ud.fullmirror if not ud.shallows else ud.fullmirror):
+        if ud.write_tarballs and not os.path.exists(ud.fullmirror if not ud.shallows else ud.fullshallow):
             return True
         return False
 
@@ -207,12 +211,12 @@ class Git(FetchMethod):
         ud.repochanged = not os.path.exists(ud.fullmirror)
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
-        if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
-            if ud.shallows:
-                ud.localpath = ud.fullmirror
+        if not os.path.exists(ud.clonedir):
+            if ud.shallows and os.path.exists(ud.fullshallow):
+                ud.localpath = ud.fullshallow
                 ud.ignore_checksums = True
                 return
-            else:
+            elif os.path.exists(ud.fullmirror):
                 bb.utils.mkdirhier(ud.clonedir)
                 os.chdir(ud.clonedir)
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d)
@@ -257,14 +261,16 @@ class Git(FetchMethod):
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
         if ud.shallows:
-            should_write = not os.path.exists(ud.fullmirror)
+            tarball = ud.fullshallow
+            should_write = not os.path.exists(ud.fullshallow)
         else:
+            tarball = ud.fullmirror
             should_write = ud.repochanged or not os.path.exists(ud.fullmirror)
 
-        if ud.write_ud.fullmirrors and should_write:
+        if ud.write_tarballs and should_write:
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
-            if os.path.islink(ud.fullmirror):
-                os.unlink(ud.fullmirror)
+            if os.path.islink(tarball):
+                os.unlink(tarball)
 
             if ud.shallows:
                 tempdir = tempfile.mkdtemp()
@@ -306,16 +312,16 @@ class Git(FetchMethod):
 
                     repourl = self._get_repo_url(ud)
                     runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
-                    logger.info("Creating ud.fullmirror of git repository")
-                    runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".")), d)
-                    runfetchcmd("touch %s.done" % ud.fullmirror, d)
+                    logger.info("Creating tarball of git repository")
+                    runfetchcmd("tar -czf %s %s" % (tarball, os.path.join(".")), d)
+                    runfetchcmd("touch %s.done" % tarball, d)
                 finally:
                     bb.utils.remove(tempdir, recurse=True)
             else:
                 os.chdir(ud.clonedir)
-                logger.info("Creating ud.fullmirror of git repository")
-                runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".")), d)
-                runfetchcmd("touch %s.done" % ud.fullmirror, d)
+                logger.info("Creating tarball of git repository")
+                runfetchcmd("tar -czf %s %s" % (tarball, os.path.join(".")), d)
+                runfetchcmd("touch %s.done" % tarball, d)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
@@ -337,7 +343,7 @@ class Git(FetchMethod):
             gitdir = os.path.join(destdir, '.git')
             bb.utils.mkdirhier(gitdir)
             os.chdir(gitdir)
-            runfetchcmd("tar -xzf %s" % ud.fullmirror, d)
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d)
             runfetchcmd("git config core.bare false", d)
         else:
             cloneflags = "-s -n"
-- 
2.2.1


