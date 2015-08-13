Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id F0B1F765A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 23:46:42 +0000 (UTC)
Received: by pacrr5 with SMTP id rr5so47293479pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 16:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=bqFn7DsTrS72ka9oDrknUnrkchvf/acfpnBcELyRt9U=;
	b=0XDWp2S1KeW1poJ7rz7EPHKiGvLF+qF6AaaYC6Qd5DF0ivPXwtry0uHt9kA2uJGLDV
	difY3lhq8F0H/OP0hBVMc7vcfvoVG91d9Hwin0VLyDyxYGpRL3cCWSQf0CQLSEePQD9N
	XnKfYU8t7E2I7kVXlDSevXedw1vbLNY+37G3ymnNSDJctnsOzq11kNDxMMuQ0rMqg0Oc
	AxJ1wAF/Xzwa8sld4qy/0CTGeIBqQlFMJikHlEfvgj+umEmguuFVcmCuXPs5GjEcX+KW
	pWSRBV7qQEe8VN0B0zg9hmfJaT6fLNgzbXuy2Z6YerhtbpvvsMoJpi2H+zTxgrNnoMcw
	UyPQ==
X-Received: by 10.66.66.1 with SMTP id b1mr82194327pat.112.1439509603009;
	Thu, 13 Aug 2015 16:46:43 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i10sm3883933pdr.78.2015.08.13.16.46.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Aug 2015 16:46:42 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2015 16:46:35 -0700
Message-Id: <1c56f262908a88d6ea7484b3252e68be399cf85d.1439509247.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
Subject: [RFC PATCH 1/5] bb.fetch.git: add support for shallow mirror tarballs
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
X-List-Received-Date: Thu, 13 Aug 2015 23:46:43 -0000

From: Christopher Larson <chris_larson@mentor.com>

The mirror tarball filename includes branch, revision, and depth. To enable,
use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for specific
URLs. This variable can hold either a clone depth (e.g. `1` to just get
SRCREV), or a ref or commit, in which case we keep history up to that commit.

The shallow support will not, at this time, function correctly for
linux-yocto, due to its branching scheme & validation.

Example:

    BB_GIT_SHALLOW ?= "1"
    BB_GIT_SHALLOW_pn-linux-yocto = ""
    BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
    BB_GIT_SHALLOW_pn-testrepo = "testbranch"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 165 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 125 insertions(+), 40 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 374d846..e88736d 100644
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
@@ -137,32 +151,44 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
+        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
         # for rebaseable git repo, it is necessary to keep mirror tar ball
         # per revision, so that even the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still
         # contains the revision
-        if ud.rebaseable:
+        if ud.shallows:
+            for name, shallow in ud.shallows.iteritems():
+                gitsrcname = '%s_%s_%s' % (gitsrcname, ud.branches[name].replace('/', '.'), ud.revisions[name])
+                if shallow:
+                    gitsrcname = gitsrcname + "_" + shallow
+        elif ud.rebaseable:
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
+
     def localpath(self, ud, d):
-        return ud.clonedir
+        if ud.shallows and os.path.exists(ud.fullmirror):
+            return ud.fullmirror
+        else:
+            return ud.clonedir
 
     def need_update(self, ud, d):
+        if ud.shallows and os.path.exists(ud.fullmirror):
+            return False
         if not os.path.exists(ud.clonedir):
             return True
         os.chdir(ud.clonedir)
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
                 return True
-        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
+        if ud.write_tarballs and not os.path.exists(ud.fullmirror if not ud.shallows else ud.fullmirror):
             return True
         return False
 
@@ -182,9 +208,14 @@ class Git(FetchMethod):
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
-            bb.utils.mkdirhier(ud.clonedir)
-            os.chdir(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
+            if ud.shallows:
+                ud.localpath = ud.fullmirror
+                ud.ignore_checksums = True
+                return
+            else:
+                bb.utils.mkdirhier(ud.clonedir)
+                os.chdir(ud.clonedir)
+                runfetchcmd("tar -xzf %s" % ud.fullmirror, d)
 
         repourl = self._get_repo_url(ud)
 
@@ -225,22 +256,68 @@ class Git(FetchMethod):
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
-        if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+        if ud.shallows:
+            should_write = not os.path.exists(ud.fullmirror)
+        else:
+            should_write = ud.repochanged or not os.path.exists(ud.fullmirror)
+
+        if ud.write_ud.fullmirrors and should_write:
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
 
-            os.chdir(ud.clonedir)
-            logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+            if ud.shallows:
+                tempdir = tempfile.mkdtemp()
+                shallowclone = os.path.join(tempdir, 'git')
+                os.makedirs(shallowclone)
+                try:
+                    os.chdir(shallowclone)
+                    runfetchcmd("%s init --bare" % ud.basecmd, d)
+                    with open(os.path.join(shallowclone, 'shallow'), 'w') as f:
+                        for name, shallow in ud.shallows.iteritems():
+                            if not shallow:
+                                continue
+                            revision = ud.revisions[name]
+
+                            for rev in [shallow + "^{}", shallow]:
+                                try:
+                                    revision = runfetchcmd("GIT_DIR=%s %s rev-parse %s" % (ud.clonedir, ud.basecmd, rev), d)
+                                except bb.fetch2.FetchError:
+                                    pass
+                                else:
+                                    break
+                            else:
+                                try:
+                                    shallow = int(shallow)
+                                except ValueError:
+                                    raise bb.fetch2.FetchError("Invalid shallow= parameter value '%s' in %s" % (shallow, ud.url))
+                                else:
+                                    revision = runfetchcmd("GIT_DIR=%s %s rev-parse %s~%d" % (ud.clonedir, ud.basecmd, revision, shallow - 1), d)
+
+                            f.write(revision)
+
+                    runfetchcmd("%s remote add origin %s" % (ud.basecmd, ud.clonedir), d)
+                    for name, branch in ud.branches.iteritems():
+                        runfetchcmd("%s fetch -a origin %s" % (ud.basecmd, branch), d)
+                    repourl = self._get_repo_url(ud)
+                    runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
+                    logger.info("Creating ud.fullmirror of git repository")
+                    runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".")), d)
+                    runfetchcmd("touch %s.done" % ud.fullmirror, d)
+                finally:
+                    bb.utils.remove(tempdir, recurse=True)
+            else:
+                os.chdir(ud.clonedir)
+                logger.info("Creating ud.fullmirror of git repository")
+                runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".")), d)
+                runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
 
         subdir = ud.parm.get("subpath", "")
         if subdir != "":
-            readpathspec = ":%s" % (subdir)
+            readpathspec = ":%s" % subdir
             def_destsuffix = "%s/" % os.path.basename(subdir.rstrip('/'))
         else:
             readpathspec = ""
@@ -251,27 +328,35 @@ class Git(FetchMethod):
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
+        if ud.shallows and not os.path.exists(ud.clonedir):
+            gitdir = os.path.join(destdir, '.git')
+            bb.utils.mkdirhier(gitdir)
+            os.chdir(gitdir)
+            runfetchcmd("tar -xzf %s" % ud.fullmirror, d)
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


