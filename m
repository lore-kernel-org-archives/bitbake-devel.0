Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 7FBBC76BEA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:25 +0000 (UTC)
Received: by pabzx8 with SMTP id zx8so75121084pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lTnONK0lUciFj9br/o8w2Xzn/S59xYS2KcAFWNj6VJk=;
	b=A3d6Nrkj9OFVIK83HDg3GgOU4/wJHaRYo+Y+mIN1Ug9QfQDc90GQI5rb+M/0rWwKcM
	0QQBpxUZY96I+GqIIDP9599V8rhwFfdYT6nzdRZWPgJHkmu6ZGv6EFSZhs0kksHsYhm3
	YU+h5rAJ7DKUAbvkYE/J10cN0jbJ6NHAF9Cv3du2dLKRZn+cr7hHvGcDvVQni4o4u6v4
	aiubYmkBzMWqbrMfi0FpbC4rcb3EbOExcIkv4qqFqU1Eeo6QikCzk0nbr5UpKC5wsBlQ
	4j4cSoJX95OEkKkqcEydy9XQWk/Jz+6iI3McvFK8ADd5lF1Lz43j0C8xwQMJwDRfG7o/
	QeQA==
X-Received: by 10.68.177.4 with SMTP id cm4mr70445702pbc.76.1440607045616;
	Wed, 26 Aug 2015 09:37:25 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	qe3sm25214673pbc.73.2015.08.26.09.37.23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:24 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:38:07 -0700
Message-Id: <1440607088-14563-4-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
References: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 3/4] bb.fetch.git: add support for shallow mirror tarballs
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:25 -0000

From: Christopher Larson <chris_larson@mentor.com>

The shallow mirror tarball filename includes branch, revision, and depth. To
enable, use the BB_GIT_SHALLOW variable, or BB_GIT_SHALLOW_<name> for specific
URLs. This variable can hold either a clone depth (e.g. 1 to just get SRCREV),
or a ref or commit, in which case we keep history up to that commit.

Example:

    BB_GIT_SHALLOW ?= "1"
    BB_GIT_SHALLOW_pn-linux-yocto = ""
    BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
    BB_GIT_SHALLOW_pn-testrepo = "testbranch"

Example in a recipe with multiple named uris, or multiple named branches in a
single git URI:

    BB_GIT_SHALLOW_main = "1"
    BB_GIT_SHALLOW_doc = ""

BB_GIT_SHALLOW affects both the tarballs being fetched and the mirror tarball
which is created when BB_GENERATE_MIRROR_TARBALLS is enabled. If the shallow
mirror tarball cannot be fetched, it will try to fetch the full mirror tarball
and use that.

Limitations:

The shallow support will not, at this time, function correctly for
linux-yocto, due to its branching scheme & validation.

This implements support for shallow mirror tarballs, not shallow clones.
Supporting shallow clones directly would be rather more problematic, as we'd
need to hardcode the depth between branch HEAD and the SRCREV, and that depth
would change as the branch is updated.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 173 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 133 insertions(+), 40 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 40658ff..99cc508 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -66,8 +66,10 @@ Supported SRC_URI options are:
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import itertools
 import os
 import re
+import tempfile
 import bb
 from   bb    import data
 from   bb.fetch2 import FetchMethod
@@ -118,12 +120,24 @@ class Git(FetchMethod):
         branches = ud.parm.get("branch", "master").split(',')
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
+
+        shallow_default = d.getVar("BB_GIT_SHALLOW", True)
+        ud.shallows = {}
         ud.branches = {}
-        for name in ud.names:
-            branch = branches[ud.names.index(name)]
+        for pos, name in enumerate(ud.names):
+            branch = branches[pos]
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
+            shallow = d.getVar("BB_GIT_SHALLOW_%s" % name, True) or shallow_default
+            if shallow == "0":
+                shallow = None
+            ud.shallows[name] = shallow
+
+        if not shallow_default and not filter(None, ud.shallows.itervalues()):
+            # No shallows
+            ud.shallows = None
+
         ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"
 
         ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
@@ -148,13 +162,24 @@ class Git(FetchMethod):
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
-        ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
-        gitdir = d.getVar("GITDIR", True) or (d.getVar("DL_DIR", True) + "/git2/")
-        ud.clonedir = os.path.join(gitdir, gitsrcname)
 
+        dl_dir = d.getVar("DL_DIR", True)
+        gitdir = d.getVar("GITDIR", True) or (dl_dir + "/git2/")
+        ud.clonedir = os.path.join(gitdir, gitsrcname)
         ud.localfile = ud.clonedir
 
+        ud.mirrortarball = 'git2_%s.tar.gz' % gitsrcname
+        ud.fullmirror = os.path.join(dl_dir, ud.mirrortarball)
+        if ud.shallows:
+            tarballname = gitsrcname
+            for name, shallow in ud.shallows.iteritems():
+                tarballname = '%s_%s_%s' % (tarballname, ud.branches[name].replace('/', '.'), ud.revisions[name])
+                if shallow:
+                    tarballname = tarballname + "_" + shallow
+            ud.shallowtarball = 'git2_%s.tar.gz' % tarballname
+            ud.fullshallow = os.path.join(dl_dir, ud.shallowtarball)
+            ud.mirrortarballs = [ud.shallowtarball, ud.mirrortarball]
+
     def localpath(self, ud, d):
         return ud.clonedir
 
@@ -165,7 +190,7 @@ class Git(FetchMethod):
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
                 return True
-        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
+        if ud.write_tarballs and not os.path.exists(ud.fullmirror if not ud.shallows else ud.fullshallow):
             return True
         return False
 
@@ -181,14 +206,22 @@ class Git(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        ud.repochanged = not os.path.exists(ud.fullmirror)
+        no_clone = not os.path.exists(ud.clonedir)
+        need_update = no_clone or self.need_update(ud, d)
 
-        # If the checkout doesn't exist and the mirror tarball does, extract it
-        if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
+        # A current clone is preferred to either tarball, a shallow tarball is
+        # preferred to an out of date clone, and a missing clone will use
+        # either tarball.
+        if ud.shallows and os.path.exists(ud.fullshallow) and need_update:
+            ud.localpath = ud.fullshallow
+            return
+        elif os.path.exists(ud.fullmirror) and no_clone:
             bb.utils.mkdirhier(ud.clonedir)
             os.chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
 
+        ud.repochanged = not os.path.exists(ud.fullmirror)
+
         repourl = self._get_repo_url(ud)
 
         # If the repo still doesn't exist, fallback to cloning it
@@ -226,24 +259,76 @@ class Git(FetchMethod):
             if not self._contains_ref(ud, d, name):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
+    def _populate_shallowclone(self, repourl, source, dest, gitcmd, branchinfo, d):
+        os.makedirs(dest)
+        os.chdir(dest)
+        runfetchcmd("%s init --bare" % gitcmd, d)
+        with open('shallow', 'w') as f:
+            for name, (shallow, revision, branch) in branchinfo.iteritems():
+                if not shallow:
+                    continue
+
+                for rev in [shallow + "^{}", shallow]:
+                    try:
+                        revision = runfetchcmd("GIT_DIR=%s %s rev-parse %s" % (source, gitcmd, rev), d)
+                    except bb.fetch2.FetchError:
+                        pass
+                    else:
+                        break
+                else:
+                    try:
+                        shallow = int(shallow)
+                    except ValueError:
+                        raise bb.fetch2.FetchError("Invalid BB_GIT_SHALLOW_%s: %s" % (name, shallow))
+                    else:
+                        revision = runfetchcmd("GIT_DIR=%s %s rev-parse %s~%d" % (source, gitcmd, revision, shallow - 1), d)
+
+                f.write(revision)
+
+        runfetchcmd("%s remote add origin %s" % (gitcmd, source), d)
+        for name, (shallow, revision, branch) in branchinfo.iteritems():
+            runfetchcmd("%s fetch -a origin %s" % (gitcmd, branch), d)
+        runfetchcmd("%s remote set-url origin %s" % (gitcmd, repourl), d)
+
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
-        if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
-            # it's possible that this symlink points to read-only filesystem with PREMIRROR
-            if os.path.islink(ud.fullmirror):
-                os.unlink(ud.fullmirror)
+        if ud.shallows:
+            tarball = ud.fullshallow
+            should_write = not os.path.exists(ud.fullshallow)
+        else:
+            tarball = ud.fullmirror
+            should_write = ud.repochanged or not os.path.exists(ud.fullmirror)
 
-            os.chdir(ud.clonedir)
-            logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+        if ud.write_tarballs and should_write:
+            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+            if os.path.islink(tarball):
+                os.unlink(tarball)
+
+            if ud.shallows:
+                tempdir = tempfile.mkdtemp()
+                shallowclone = os.path.join(tempdir, 'git')
+                try:
+                    repourl = self._get_repo_url(ud)
+                    branchinfo = dict((name, (ud.shallows[name], ud.revisions[name], ud.branches[name])) for name in ud.names)
+                    self._populate_shallowclone(repourl, ud.clonedir, shallowclone, ud.basecmd, branchinfo, d)
+
+                    logger.info("Creating tarball of git repository")
+                    runfetchcmd("tar -czf %s %s" % (tarball, os.path.join(".")), d)
+                    runfetchcmd("touch %s.done" % tarball, d)
+                finally:
+                    bb.utils.remove(tempdir, recurse=True)
+            else:
+                os.chdir(ud.clonedir)
+                logger.info("Creating tarball of git repository")
+                runfetchcmd("tar -czf %s %s" % (tarball, os.path.join(".")), d)
+                runfetchcmd("touch %s.done" % tarball, d)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
 
         subdir = ud.parm.get("subpath", "")
         if subdir != "":
-            readpathspec = ":%s" % (subdir)
+            readpathspec = ":%s" % subdir
             def_destsuffix = "%s/" % os.path.basename(subdir.rstrip('/'))
         else:
             readpathspec = ""
@@ -254,27 +339,35 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        cloneflags = "-s -n"
-        if ud.bareclone:
-            cloneflags += " --mirror"
-
-        # Versions of git prior to 1.7.9.2 have issues where foo.git and foo get confused
-        # and you end up with some horrible union of the two when you attempt to clone it
-        # The least invasive workaround seems to be a symlink to the real directory to
-        # fool git into ignoring any .git version that may also be present.
-        #
-        # The issue is fixed in more recent versions of git so we can drop this hack in future
-        # when that version becomes common enough.
-        clonedir = ud.clonedir
-        if not ud.path.endswith(".git"):
-            indirectiondir = destdir[:-1] + ".indirectionsymlink"
-            if os.path.exists(indirectiondir):
-                os.remove(indirectiondir)
-            bb.utils.mkdirhier(os.path.dirname(indirectiondir))
-            os.symlink(ud.clonedir, indirectiondir)
-            clonedir = indirectiondir
-
-        runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, clonedir, destdir), d)
+        if ud.shallows and (not os.path.exists(ud.clonedir) or self.need_update(ud, d)):
+            gitdir = os.path.join(destdir, '.git')
+            bb.utils.mkdirhier(gitdir)
+            os.chdir(gitdir)
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d)
+            runfetchcmd("git config core.bare false", d)
+        else:
+            cloneflags = "-s -n"
+            if ud.bareclone:
+                cloneflags += " --mirror"
+
+            # Versions of git prior to 1.7.9.2 have issues where foo.git and foo get confused
+            # and you end up with some horrible union of the two when you attempt to clone it
+            # The least invasive workaround seems to be a symlink to the real directory to
+            # fool git into ignoring any .git version that may also be present.
+            #
+            # The issue is fixed in more recent versions of git so we can drop this hack in future
+            # when that version becomes common enough.
+            clonedir = ud.clonedir
+            if not ud.path.endswith(".git"):
+                indirectiondir = destdir[:-1] + ".indirectionsymlink"
+                if os.path.exists(indirectiondir):
+                    os.remove(indirectiondir)
+                bb.utils.mkdirhier(os.path.dirname(indirectiondir))
+                os.symlink(ud.clonedir, indirectiondir)
+                clonedir = indirectiondir
+
+            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, clonedir, destdir), d)
+
         os.chdir(destdir)
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
-- 
2.2.1


