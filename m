Return-Path: <kergoth@gmail.com>
Received: from mail-pg0-f45.google.com (mail-pg0-f45.google.com [74.125.83.45])
	by mail.openembedded.org (Postfix) with ESMTP id 28A4577D11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:49 +0000 (UTC)
Received: by mail-pg0-f45.google.com with SMTP id u187so35664527pgb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=CQZe1rSN0a7ZzdsMsyy8zDvvQoVTf4Kh6Pwd0KZAIrc=;
	b=ZYisAb0EDAhvOA5e/mj8K+S3vMZ5vDGjkfi7lsz7HUMDAe/uRt+ei7Z7jrGLRyoiwy
	6PQr1ySqgWy+5aM/NL0o3I1ypktkl49IRptnaUW3rpBpM1Pyx1AWJcs0k/hoW4oig054
	q2GmX0Ct5Cxg89d2VflZ2vfL3qiMs85ig5K+tBGI9Pb6wNBhji006U/h3zhxqopK0AWt
	rQI5oaww/zQR5cSVZ5Fnswy95WmSiu1xKxBYOgrdl7Vqj7EN/3/myhF5BVlhpueRRg7a
	Mu1rZgy3Fol0+uUBGj1f6DOVVhSE42UKycpEmZAcM7XR9vAnqn9EI1WytPVvD2QQGGAd
	vZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CQZe1rSN0a7ZzdsMsyy8zDvvQoVTf4Kh6Pwd0KZAIrc=;
	b=YKJH00iSpjkMsSJ2R7syV98+Y+0okFlCNxOekfp6mzL/c3Bk+nqC4DKkEfCxw96y+1
	KNJJ+IvMXPJi+u+QQqzl0deG+YcJGWyNPeWIyObsc/GZm0FLhgfqmu0NRveqIN1g6HD3
	07OQ4/QLhbBMBVF5jLJwyHLI++N97LPlOiWl2NWXLWEFu31s+cQ6km6/F9t7qIMVl+Xi
	OLpJjCdCIfAplt41+qCbO1QxMRydWIP+k43eCpHTnhNS1spPzRyORWDj+98ZTumOe2Wy
	iHgZ5Xbu2m1RojRJy/jE9S8ouE09OR35/qMi1uo4U8hcn93GK1s6xHhy/f5vNnNgazDl
	xEpQ==
X-Gm-Message-State: AODbwcCXRHhh8HZA3o4qtseYc/fOMdanhA8jIoozVVWR5nny2NhySR/X
	8zDCA/1RZM/FlbVne9w=
X-Received: by 10.99.102.7 with SMTP id a7mr6349886pgc.216.1494625610473;
	Fri, 12 May 2017 14:46:50 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:49 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:28 +0500
Message-Id: <87563fb22284eba1f5fc459c7d7968c9cfbe2f89.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 3/8] fetch/git: add support for shallow mirror tarballs
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
X-List-Received-Date: Fri, 12 May 2017 21:46:49 -0000

This adds support to the git fetcher for fetching, using, and generating
mirror tarballs of shallow git repositories. The external git-make-shallow
script is used for shallow mirror tarball creation.

This implements support for shallow mirror tarballs, not shallow clones.
Supporting shallow clones directly is not really doable for us, as we'd need
to hardcode the depth between branch HEAD and the SRCREV, and that depth would
change as the branch is updated.

When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow
mirror tarball. If the shallow mirror tarball cannot be fetched, it will try
to fetch the full mirror tarball and use that. If a shallow tarball is to be
used, it will be unpacked directly at `do_unpack` time, rather than extracting
it to DL_DIR at `do_fetch` time and cloning from there, to keep things simple.
There's no value in keeping a shallow repository in DL_DIR, and dealing with
the state for when to convert the clonedir to/from shallow is not worthwhile.

To clarify when shallow is used vs a real repository, a current clone is
preferred to either tarball, a shallow tarball is preferred to an out of date
clone, and a missing clone will use either tarball (attempting the shallow one
first).

All referenced branches are truncated to SRCREV (that is, commits *after*
SRCREV but before HEAD are removed) to further shrink the repository. By
default, the shallow construction process removes all unused refs
(branches/tags) from the repository, other than those referenced by the URL.

Example usage:

    BB_GIT_SHALLOW ?= "1"

    # Keep only the top commit
    BB_GIT_SHALLOW_DEPTH ?= "1"

    # This defaults to enabled if both BB_GIT_SHALLOW and
    # BB_GENERATE_MIRROR_TARBALLS are enabled
    BB_GENERATE_SHALLOW_TARBALLS ?= "1"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py  | 133 +++++++++++++++++++---
 lib/bb/tests/fetch.py | 299 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 417 insertions(+), 15 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 01d4bbdc..0412f9ff 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -73,8 +73,9 @@ Supported SRC_URI options are:
 import errno
 import os
 import re
+import subprocess
+import tempfile
 import bb
-import errno
 import bb.progress
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
@@ -172,6 +173,11 @@ class Git(FetchMethod):
         branches = ud.parm.get("branch", "master").split(',')
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
+
+        ud.cloneflags = "-s -n"
+        if ud.bareclone:
+            ud.cloneflags += " --mirror"
+
         ud.branches = {}
         for pos, name in enumerate(ud.names):
             branch = branches[pos]
@@ -183,7 +189,9 @@ class Git(FetchMethod):
 
         ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
 
-        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0") or ud.rebaseable
+        write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
+        ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
+        ud.write_shallow_tarballs = (d.getVar("BB_GENERATE_SHALLOW_TARBALLS") or write_tarballs) != "0"
 
         ud.setup_revisions(d)
 
@@ -205,13 +213,48 @@ class Git(FetchMethod):
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
+
+        dl_dir = d.getVar("DL_DIR")
+        gitdir = d.getVar("GITDIR") or (dl_dir + "/git2/")
+        ud.clonedir = os.path.join(gitdir, gitsrcname)
+        ud.localfile = ud.clonedir
+
         mirrortarball = 'git2_%s.tar.gz' % gitsrcname
-        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
+        ud.fullmirror = os.path.join(dl_dir, mirrortarball)
         ud.mirrortarballs = [mirrortarball]
-        gitdir = d.getVar("GITDIR") or (d.getVar("DL_DIR") + "/git2/")
-        ud.clonedir = os.path.join(gitdir, gitsrcname)
 
-        ud.localfile = ud.clonedir
+        ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
+        if ud.shallow:
+            ud.shallow_depth = d.getVar("BB_GIT_SHALLOW_DEPTH")
+            if ud.shallow_depth is not None:
+                try:
+                    ud.shallow_depth = int(ud.shallow_depth or 0)
+                except ValueError:
+                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % ud.shallow_depth)
+                else:
+                    if not ud.shallow_depth:
+                        ud.shallow = False
+                    elif ud.shallow_depth < 0:
+                        raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % ud.shallow_depth)
+            else:
+                ud.shallow_depth = 1
+
+        if ud.shallow:
+            tarballname = gitsrcname
+            if ud.bareclone:
+                tarballname = "%s_bare" % tarballname
+
+            for name, revision in sorted(ud.revisions.items()):
+                tarballname = "%s_%s" % (tarballname, ud.revisions[name][:7])
+                if not ud.nobranch:
+                    tarballname = "%s-%s" % (tarballname, ud.branches[name])
+
+            tarballname = "%s-%s" % (tarballname, ud.shallow_depth)
+
+            fetcher = self.__class__.__name__.lower()
+            ud.shallowtarball = '%sshallow_%s.tar.gz' % (fetcher, tarballname)
+            ud.fullshallow = os.path.join(dl_dir, ud.shallowtarball)
+            ud.mirrortarballs.insert(0, ud.shallowtarball)
 
     def localpath(self, ud, d):
         return ud.clonedir
@@ -222,6 +265,8 @@ class Git(FetchMethod):
         for name in ud.names:
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 return True
+        if ud.shallow and ud.write_shallow_tarballs and not os.path.exists(ud.fullshallow):
+            return True
         if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             return True
         return False
@@ -238,8 +283,16 @@ class Git(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        # If the checkout doesn't exist and the mirror tarball does, extract it
-        if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
+        no_clone = not os.path.exists(ud.clonedir)
+        need_update = no_clone or self.need_update(ud, d)
+
+        # A current clone is preferred to either tarball, a shallow tarball is
+        # preferred to an out of date clone, and a missing clone will use
+        # either tarball.
+        if ud.shallow and os.path.exists(ud.fullshallow) and need_update:
+            ud.localpath = ud.fullshallow
+            return
+        elif os.path.exists(ud.fullmirror) and no_clone:
             bb.utils.mkdirhier(ud.clonedir)
             runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
 
@@ -285,9 +338,21 @@ class Git(FetchMethod):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
-        # Generate a mirror tarball if needed
-        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
-            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+        if ud.shallow and ud.write_shallow_tarballs:
+            if not os.path.exists(ud.fullshallow):
+                if os.path.islink(ud.fullshallow):
+                    os.unlink(ud.fullshallow)
+                tempdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
+                shallowclone = os.path.join(tempdir, 'git')
+                try:
+                    self.clone_shallow_local(ud, shallowclone, d)
+
+                    logger.info("Creating tarball of git repository")
+                    runfetchcmd("tar -czf %s ." % ud.fullshallow, d, workdir=shallowclone)
+                    runfetchcmd("touch %s.done" % ud.fullshallow, d)
+                finally:
+                    bb.utils.remove(tempdir, recurse=True)
+        elif ud.write_tarballs and not os.path.exists(ud.fullmirror):
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
 
@@ -295,6 +360,43 @@ class Git(FetchMethod):
             runfetchcmd("tar -czf %s ." % ud.fullmirror, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
+    def clone_shallow_local(self, ud, dest, d):
+        """Clone the repo and make it shallow.
+
+        The upstream url of the new clone isn't set at this time, as it'll be
+        set correctly when unpacked."""
+        runfetchcmd("%s clone %s %s %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, dest), d)
+
+        to_parse, shallow_branches = [], []
+        for name in ud.names:
+            revision = ud.revisions[name]
+            to_parse.append('%s~%d^{}' % (revision, ud.shallow_depth - 1))
+
+            # For nobranch, we need a ref, otherwise the commits will be
+            # removed, and for non-nobranch, we truncate the branch to our
+            # srcrev, to avoid keeping unnecessary history beyond that.
+            branch = ud.branches[name]
+            if ud.nobranch:
+                ref = "refs/shallow/%s" % name
+            elif ud.bareclone:
+                ref = "refs/heads/%s" % branch
+            else:
+                ref = "refs/remotes/origin/%s" % branch
+
+            shallow_branches.append(ref)
+            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
+
+        # Map srcrev+depths to revisions
+        shallow_revisions = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join(to_parse)), d, workdir=dest).splitlines()
+
+        # Make the repository shallow
+        shallow_cmd = ['git', 'make-shallow', '-s']
+        for b in shallow_branches:
+            shallow_cmd.append('-r')
+            shallow_cmd.append(b)
+        shallow_cmd.extend(shallow_revisions)
+        runfetchcmd(subprocess.list2cmdline(shallow_cmd), d, workdir=dest)
+
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
 
@@ -311,11 +413,12 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        cloneflags = "-s -n"
-        if ud.bareclone:
-            cloneflags += " --mirror"
+        if ud.shallow and (not os.path.exists(ud.clonedir) or self.need_update(ud, d)):
+            bb.utils.mkdirhier(destdir)
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
+        else:
+            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
 
-        runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, ud.clonedir, destdir), d)
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
         if not ud.nocheckout:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 510071d2..019f22a1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -979,3 +979,302 @@ class GitMakeShallowTest(FetcherTest):
             orig_revs = len(self.git('rev-list --all').splitlines())
             self.make_shallow(['refs/tags/1.10.0'])
             self.assertRevCount(orig_revs - 1746, ['--all'])
+
+class GitShallowTest(FetcherTest):
+    def setUp(self):
+        FetcherTest.setUp(self)
+        self.gitdir = os.path.join(self.tempdir, 'git')
+        self.srcdir = os.path.join(self.tempdir, 'gitsource')
+
+        bb.utils.mkdirhier(self.srcdir)
+        self.git('init', cwd=self.srcdir)
+        self.d.setVar('WORKDIR', self.tempdir)
+        self.d.setVar('S', self.gitdir)
+        self.d.delVar('PREMIRRORS')
+        self.d.delVar('MIRRORS')
+
+        uri = 'git://%s;protocol=file;subdir=${S}' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+        self.d.setVar('SRCREV', '${AUTOREV}')
+        self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
+
+        self.d.setVar('BB_GIT_SHALLOW', '1')
+        self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '0')
+        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
+
+    def assertRefs(self, expected_refs, cwd=None):
+        if cwd is None:
+            cwd = self.gitdir
+        actual_refs = self.git(['for-each-ref', '--format=%(refname)'], cwd=cwd).splitlines()
+        full_expected = self.git(['rev-parse', '--symbolic-full-name'] + expected_refs, cwd=cwd).splitlines()
+        self.assertEqual(sorted(set(full_expected)), sorted(set(actual_refs)))
+
+    def assertRevCount(self, expected_count, args=None, cwd=None):
+        if args is None:
+            args = ['HEAD']
+        if cwd is None:
+            cwd = self.gitdir
+        revs = self.git(['rev-list'] + args, cwd=cwd)
+        actual_count = len(revs.splitlines())
+        self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
+
+    def git(self, cmd, cwd=None):
+        if isinstance(cmd, str):
+            cmd = 'git ' + cmd
+        else:
+            cmd = ['git'] + cmd
+        if cwd is None:
+            cwd = self.gitdir
+        return bb.process.run(cmd, cwd=cwd)[0]
+
+    def add_empty_file(self, path, msg=None):
+        if msg is None:
+            msg = path
+        open(os.path.join(self.srcdir, path), 'w').close()
+        self.git(['add', path], self.srcdir)
+        self.git(['commit', '-m', msg, path], self.srcdir)
+
+    def fetch(self, uri=None):
+        if uri is None:
+            uris = self.d.getVar('SRC_URI', True).split()
+            uri = uris[0]
+            d = self.d
+        else:
+            d = self.d.createCopy()
+            d.setVar('SRC_URI', uri)
+            uri = d.expand(uri)
+            uris = [uri]
+
+        fetcher = bb.fetch2.Fetch(uris, d)
+        fetcher.download()
+        ud = fetcher.ud[uri]
+        return fetcher, ud
+
+    def fetch_and_unpack(self, uri=None):
+        fetcher, ud = self.fetch(uri)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        assert os.path.exists(self.d.getVar('S'))
+        return fetcher, ud
+
+    def fetch_shallow(self, uri=None, disabled=False, keepclone=False):
+        """Fetch a uri, generating a shallow tarball, then unpack using it"""
+        fetcher, ud = self.fetch_and_unpack(uri)
+        assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) does not exist for uri %s' % (ud.clonedir, uri)
+
+        # Confirm that the unpacked repo is unshallow
+        if not disabled:
+            assert os.path.exists(os.path.join(self.dldir, ud.mirrortarballs[0]))
+
+        # fetch and unpack, from the shallow tarball
+        bb.utils.remove(self.gitdir, recurse=True)
+        bb.utils.remove(ud.clonedir, recurse=True)
+
+        # confirm that the unpacked repo is used when no git clone or git
+        # mirror tarball is available
+        fetcher, ud = self.fetch_and_unpack(uri)
+        if not disabled:
+            assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')), 'Unpacked git repository at %s is not shallow' % self.gitdir
+        else:
+            assert not os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')), 'Unpacked git repository at %s is shallow' % self.gitdir
+        return fetcher, ud
+
+    def test_shallow_disabled(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW', '0')
+        self.fetch_shallow(disabled=True)
+        self.assertRevCount(2)
+
+    def test_shallow_nobranch(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
+        self.d.setVar('SRCREV', srcrev)
+        uri = self.d.getVar('SRC_URI', True).split()[0]
+        uri = '%s;nobranch=1;bare=1' % uri
+
+        self.fetch_shallow(uri)
+        self.assertRevCount(1)
+
+        # shallow refs are used to ensure the srcrev sticks around when we
+        # have no other branches referencing it
+        self.assertRefs(['refs/shallow/default'])
+
+    def test_shallow_default_depth_1(self):
+        # Create initial git repo
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.fetch_shallow()
+        self.assertRevCount(1)
+
+    def test_shallow_depth_0_disables(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.fetch_shallow(disabled=True)
+        self.assertRevCount(2)
+
+    def test_current_shallow_out_of_date_clone(self):
+        # Create initial git repo
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.add_empty_file('c')
+        self.assertRevCount(3, cwd=self.srcdir)
+
+        # Clone and generate mirror tarball
+        fetcher, ud = self.fetch()
+
+        # Ensure we have a current mirror tarball, but an out of date clone
+        self.git('update-ref refs/heads/master refs/heads/master~1', cwd=ud.clonedir)
+        self.assertRevCount(2, cwd=ud.clonedir)
+
+        # Fetch and unpack, from the current tarball, not the out of date clone
+        bb.utils.remove(self.gitdir, recurse=True)
+        fetcher, ud = self.fetch()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        self.assertRevCount(1)
+
+    def test_shallow_single_branch_no_merge(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.fetch_shallow()
+        self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.gitdir, 'a'))
+        assert os.path.exists(os.path.join(self.gitdir, 'b'))
+
+    def test_shallow_no_dangling(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.fetch_shallow()
+        self.assertRevCount(1)
+        assert not self.git('fsck --dangling')
+
+    def test_shallow_srcrev_branch_truncation(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        b_commit = self.git('rev-parse HEAD', cwd=self.srcdir).rstrip()
+        self.add_empty_file('c')
+        self.assertRevCount(3, cwd=self.srcdir)
+
+        self.d.setVar('SRCREV', b_commit)
+        self.fetch_shallow()
+
+        # The 'c' commit was removed entirely, and 'a' was removed from history
+        self.assertRevCount(1, ['--all'])
+        self.assertEqual(self.git('rev-parse HEAD').strip(), b_commit)
+        assert os.path.exists(os.path.join(self.gitdir, 'a'))
+        assert os.path.exists(os.path.join(self.gitdir, 'b'))
+        assert not os.path.exists(os.path.join(self.gitdir, 'c'))
+
+    def test_shallow_ref_pruning(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('branch a_branch', cwd=self.srcdir)
+        self.assertRefs(['master', 'a_branch'], cwd=self.srcdir)
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.fetch_shallow()
+
+        self.assertRefs(['master', 'origin/master'])
+        self.assertRevCount(1)
+
+    def test_shallow_multi_one_uri(self):
+        # Create initial git repo
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('checkout -b a_branch', cwd=self.srcdir)
+        self.add_empty_file('c')
+        self.add_empty_file('d')
+        self.git('checkout master', cwd=self.srcdir)
+        self.add_empty_file('e')
+        self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
+        self.add_empty_file('f')
+        self.assertRevCount(7, cwd=self.srcdir)
+
+        uri = self.d.getVar('SRC_URI', True).split()[0]
+        uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '2')
+        self.d.setVar('SRCREV_master', '${AUTOREV}')
+        self.d.setVar('SRCREV_a_branch', '${AUTOREV}')
+
+        self.fetch_shallow(uri)
+
+        self.assertRevCount(3, ['--all'])
+        self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
+
+    def test_shallow_clone_preferred_over_shallow(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch once to generate the shallow tarball
+        fetcher, ud = self.fetch()
+        assert os.path.exists(os.path.join(self.dldir, ud.mirrortarballs[0]))
+
+        # Fetch and unpack with both the clonedir and shallow tarball available
+        bb.utils.remove(self.gitdir, recurse=True)
+        fetcher, ud = self.fetch_and_unpack()
+
+        # The unpacked tree should *not* be shallow
+        self.assertRevCount(2)
+        assert not os.path.exists(os.path.join(self.gitdir, '.git', 'shallow'))
+
+    def test_shallow_mirrors(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch once to generate the shallow tarball
+        fetcher, ud = self.fetch()
+        mirrortarball = ud.mirrortarballs[0]
+        assert os.path.exists(os.path.join(self.dldir, mirrortarball))
+
+        # Set up the mirror
+        mirrordir = os.path.join(self.tempdir, 'mirror')
+        bb.utils.mkdirhier(mirrordir)
+        self.d.setVar('PREMIRRORS', 'git://.*/.* file://%s/\n' % mirrordir)
+
+        os.rename(os.path.join(self.dldir, mirrortarball),
+                  os.path.join(mirrordir, mirrortarball))
+
+        # Fetch from the mirror
+        bb.utils.remove(self.dldir, recurse=True)
+        bb.utils.remove(self.gitdir, recurse=True)
+        self.fetch_and_unpack()
+        self.assertRevCount(1)
+
+    def test_shallow_invalid_depth(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '-12')
+        with self.assertRaises(bb.fetch2.FetchError):
+            self.fetch()
+
+    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+        print("Unset BB_SKIP_NETTESTS to run network tests")
+    else:
+        def test_bitbake(self):
+            self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
+            self.git('config core.bare true', cwd=self.srcdir)
+            self.git('fetch --tags', cwd=self.srcdir)
+
+            self.d.setVar('BB_GIT_SHALLOW_DEPTH', '100')
+
+            self.fetch_shallow()
+
+            orig_revs = len(self.git('rev-list master', cwd=self.srcdir).splitlines())
+            revs = len(self.git('rev-list master').splitlines())
+            self.assertNotEqual(orig_revs, revs)
+            self.assertRefs(['master', 'origin/master'])
-- 
2.11.1


