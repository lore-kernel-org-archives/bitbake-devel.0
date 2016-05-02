Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id BD2D56E666
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 May 2016 19:59:08 +0000 (UTC)
Received: by mail-pf0-f173.google.com with SMTP id c189so85441144pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 May 2016 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=j7t2Goab1WBNqfLDu02x6WtpFQK4FkMKmNeX7d6iQA8=;
	b=GJSFMUZVbt/bAcMIgt47dJBMOmZJtj4MwsR5JSMtryrvKlNuZhemNdaT3H+RAjadw/
	lZjFXteAj/D0PSh+EKZ7i32yL9JJ/eEFKfRXkkxFilRjwtKdCksgeiJtJzYwpdrD/lYX
	XunzdheMCj9j4fyukSDKgkarQKYznoFugPIojeXRdMNKkqE5Yu0Lf/JXIePUDMlf3swH
	4A1/RFG7UXtFHJYog1xYOPgqkmqssgY7riDxlxcmp7yoy6Dai+ajGRT5oI4pqAMtmwGl
	TdbWGYlxEOL4GEiPRP8dQHTykyetgxfgsmSWsPQSBRbLm2GYzeyzdw29QNmVsWiYqRLY
	gE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=j7t2Goab1WBNqfLDu02x6WtpFQK4FkMKmNeX7d6iQA8=;
	b=lXxsNWGu+B1REwlS9feiiZsUKwEx5gU3hkAa7hwUA/bpquGRRPjEAsfLo92M1XXe96
	FKNp4He+YlIc+sDKk1zcVlFEAODm6qLeeMF0GJTVhjCHfzhtwPudlISEAAj7wVaDPat1
	UzSH26pnOo6B90xVzdMEAzZWlbRZdqKjtBDFsTJA6GZq/aViJrU75vFGUtX3fZHBY5uA
	779A5ZLeCKRivmxZGsh4RayDYhWXNFeVvI3YjDT11wAljs8LUNzADxfGTzKuUhEg+Idz
	UJk5MDH6dM2B4FHMFz7YlsZYiUzciXqm/VZNmsQpj3AkNnp731MWxRxj+rgiEFrSYLBf
	UT/A==
X-Gm-Message-State: AOPr4FXiTp+HKPqcOEbhPY7wph01gITXEbLvaOrhrq/zRGzkUh0Rz2AuI/cl0Rq/2vgO9A==
X-Received: by 10.98.76.216 with SMTP id e85mr54255391pfj.121.1462219148868;
	Mon, 02 May 2016 12:59:08 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	s23sm47413654pfj.86.2016.05.02.12.59.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 02 May 2016 12:59:06 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 May 2016 12:58:58 -0700
Message-Id: <1462219138-14469-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462045891-13511-1-git-send-email-kergoth@gmail.com>
References: <1462045891-13511-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCHv3] bb.fetch.git: add support for shallow mirror tarballs
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
X-List-Received-Date: Mon, 02 May 2016 19:59:09 -0000

From: Christopher Larson <chris_larson@mentor.com>

This adds support to the git fetcher for fetching and generating mirror
tarballs of shallow git repositories, with the specified revisions / depths.

This implements support for shallow mirror tarballs, not shallow clones.
Supporting shallow clones directly would be rather more problematic, as we'd
need to hardcode the depth between branch HEAD and the SRCREV, and that depth
would change as the branch is updated. Sadly, git's remote protocol is
extremely limited.

When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow
mirror tarball. If the shallow mirror tarball cannot be fetched, it will try
to fetch the full mirror tarball and use that.

Multiple variables exist to exert control over what revisions and refs are
kept at what are not.

BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean
BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults to 1 (the top commit alone). This can be set to 0 or the empty string.
BB_GIT_SHALLOW_DEPTH_<name>: specify commit depth for a specific named url/branch
BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed, beyond that specified by refs+depth
BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed. set this to 0 or the empty string to keep all refs around. this is required for linux-yocto kernel repositories, otherwise the branch checking done by the kernel scripts will fail
BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced in SRC_URI, when TRIM_REFS is enabled
BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow mirror tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS is enabled

Example usage:

    BB_GIT_SHALLOW ?= "1"
    BB_GIT_SHALLOW_DEPTH ?= "1"

    # Usage in a recipe with multiple named uris or multiple named branches
    BB_GIT_SHALLOW_DEPTH_doc = ""

    # Remove the upstream history from our kernel repo, keeping our own
    BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 = "v3.14"
    BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 = ""

    # Keep the branches in linux-yocto repositories
    BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto = "0"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 244 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 224 insertions(+), 20 deletions(-)

v2 changes: drop indirectionsymlink bits which were an artifact of the rebase
onto recent upstream
v3 changes: fix tarball filename to replace '/' in branch names. this was an
accidental regression when doing some refactoring

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 526668b..6289fad 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -66,9 +66,13 @@ Supported SRC_URI options are:
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import collections
 import errno
+import itertools
 import os
 import re
+import subprocess
+import tempfile
 import bb
 import errno
 from   bb    import data
@@ -76,6 +80,23 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
+
+def iter_except(func, exception, start=None):
+    """Yield a function repeatedly until it raises an exception."""
+    try:
+        if start is not None:
+            yield start()
+        while True:
+            yield func()
+    except exception:
+        pass
+
+
+def iter_extend(iterable, length, obj=None):
+    """Ensure that iterable is the specified length by extending with obj"""
+    return itertools.islice(itertools.chain(iterable, itertools.repeat(obj)), length)
+
+
 class Git(FetchMethod):
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
@@ -120,15 +141,43 @@ class Git(FetchMethod):
         branches = ud.parm.get("branch", "master").split(',')
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
+
+        ud.shallow = d.getVar("BB_GIT_SHALLOW", True) == "1"
+        ud.shallow_revs = (d.getVar("BB_GIT_SHALLOW_REVS", True) or "").split()
+        trim_refs = d.getVar("BB_GIT_SHALLOW_TRIM_REFS", True)
+        ud.trim_refs = not trim_refs or trim_refs == "0"
+        ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS", True) or "").split()
+
+        depth_default = d.getVar("BB_GIT_SHALLOW_DEPTH", True)
+        if depth_default is not None:
+            try:
+                depth_default = int(depth_default)
+            except ValueError:
+                raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % depth_default)
+        else:
+            depth_default = 1
+        ud.shallow_depths = collections.defaultdict(lambda: depth_default)
+
         ud.branches = {}
-        for name in ud.names:
-            branch = branches[ud.names.index(name)]
+        for pos, name in enumerate(ud.names):
+            branch = branches[pos]
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
+            shallow_depth = d.getVar("BB_GIT_SHALLOW_DEPTH_%s" % name, True)
+            if shallow_depth and shallow_depth != "0":
+                try:
+                    shallow_depth = int(shallow_depth)
+                except ValueError:
+                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (name, shallow_depth))
+                else:
+                    ud.shallow_depths[name] = shallow_depth
+
         ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"
 
-        ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
+        write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS", True) or "0"
+        ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
+        ud.write_shallow_tarballs = (d.getVar("BB_GENERATE_SHALLOW_TARBALLS", True) or write_tarballs) != "0"
 
         ud.setup_revisons(d)
 
@@ -150,13 +199,36 @@ class Git(FetchMethod):
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
+        if ud.shallow:
+            tarballname = gitsrcname
+            if ud.shallow_revs:
+                tarballname = "%s_%s" % (tarballname, "_".join(sorted(ud.shallow_revs)))
+
+            for name, revision in sorted(ud.revisions.iteritems()):
+                tarballname = "%s_%s" % (tarballname, ud.revisions[name][:7])
+                depth = ud.shallow_depths[name]
+                if depth:
+                    tarballname = "%s-%s" % (tarballname, depth)
+
+            if ud.trim_refs:
+                if not ud.nobranch:
+                    shallow_refs = ud.branches.itervalues()
+                    shallow_refs = itertools.chain(shallow_refs, ud.shallow_extra_refs)
+                    tarballname = "%s_%s" % (tarballname, "_".join(sorted(shallow_refs)).replace('/', '.'))
+                ud.shallowtarball = 'gitshallow_%s.tar.gz' % tarballname
+            else:
+                ud.shallowtarball = 'gitshallowall_%s.tar.gz' % tarballname
+            ud.fullshallow = os.path.join(dl_dir, ud.shallowtarball)
+            ud.mirrortarballs = [ud.shallowtarball, ud.mirrortarball]
+
     def localpath(self, ud, d):
         return ud.clonedir
 
@@ -167,6 +239,8 @@ class Git(FetchMethod):
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
                 return True
+        if ud.shallow and ud.write_shallow_tarballs and not os.path.exists(ud.fullshallow):
+            return True
         if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             return True
         return False
@@ -183,8 +257,16 @@ class Git(FetchMethod):
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
             os.chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
@@ -231,23 +313,139 @@ class Git(FetchMethod):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
-        # Generate a mirror tarball if needed
-        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
-            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+        if ud.shallow and ud.write_shallow_tarballs:
+            if not os.path.exists(ud.fullshallow):
+                if os.path.islink(ud.fullshallow):
+                    os.unlink(ud.fullshallow)
+                tempdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR', True))
+                shallowclone = os.path.join(tempdir, 'git')
+                try:
+                    repourl = self._get_repo_url(ud)
+                    branchinfo = dict((name, (ud.shallow_depths[name], ud.revisions[name], ud.branches[name])) for name in ud.names)
+                    self._populate_shallowclone(repourl, ud.clonedir, shallowclone, ud.basecmd, branchinfo, ud.nobranch, ud.trim_refs, ud.shallow_extra_refs, ud.shallow_revs, ud.bareclone, d)
+
+                    logger.info("Creating tarball of git repository")
+                    runfetchcmd("tar -czf %s %s" % (ud.fullshallow, os.path.join(".")), d)
+                    runfetchcmd("touch %s.done" % ud.fullshallow, d)
+                finally:
+                    bb.utils.remove(tempdir, recurse=True)
+        elif ud.write_tarballs and not os.path.exists(ud.fullmirror):
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
-
             os.chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
+            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".")), d)
+            runfetchcmd("touch %s.done" % ud.fullmirror, d)
+
+    def _populate_shallowclone(self, repourl, source, dest, gitcmd, branchinfo, nobranch, trim_refs, extra_refs, shallow_revisions, bareclone, d):
+        if shallow_revisions is None:
+            shallow_revisions = []
+
+        # Map depths to revisions
+        to_parse = []
+        for depth, revision, branch in branchinfo.itervalues():
+            if not depth:
+                continue
+
+            to_parse.append('%s~%d^{}' % (revision, depth - 1))
+
+        parsed = runfetchcmd("GIT_DIR='%s' %s rev-parse %s" % (source, gitcmd, " ".join(to_parse)), d)
+        shallow_revisions.extend(parsed.splitlines())
+
+        cloneflags = "-s -n"
+        if bareclone:
+            cloneflags += " --mirror"
+        runfetchcmd("%s clone %s %s %s" % (gitcmd, cloneflags, source, dest), d)
+
+        os.chdir(dest)
+
+        shallow_branches = []
+        shallow_branches.extend(extra_refs)
+        for name, (depth, revision, branch) in branchinfo.iteritems():
+            if nobranch:
+                ref = "refs/shallow/%s" % name
+            else:
+                ref = "refs/remotes/origin/%s" % branch
+
+            if trim_refs:
+                shallow_branches.append(ref)
+            runfetchcmd("%s update-ref %s %s" % (gitcmd, ref, revision), d)
+
+        if trim_refs:
+            self.filter_refs(gitcmd, d, shallow_branches)
+
+        git_dir = runfetchcmd('%s rev-parse --git-dir' % gitcmd, d).rstrip()
+        self._make_repo_shallow(shallow_revisions, git_dir, gitcmd, d, branches=shallow_branches or None)
+
+        alternates_file = os.path.join(git_dir, "objects", "info", "alternates")
+        os.unlink(alternates_file)
+
+    def _make_repo_shallow(self, revisions, git_dir, gitcmd, d, branches=None):
+        if branches is not None:
+            refs = branches
+        else:
+            refs = self.get_all_refs(gitcmd, d, lambda r, t: not t or t == 'commit')
+
+        parsed_revs = runfetchcmd('%s rev-parse %s' % (gitcmd, ' '.join('%s^{}' % i for i in revisions)), d)
+        queue = collections.deque(r.rstrip() for r in parsed_revs.splitlines())
+        seen = set()
+
+        shallow_file = os.path.join(git_dir, 'shallow')
+        try:
+            os.unlink(shallow_file)
+        except OSError as exc:
+            if exc.errno != errno.ENOENT:
+                raise
+
+        for rev in iter_except(queue.popleft, IndexError):
+            if rev in seen:
+                continue
+
+            bb.note("Processing shallow revision: %s" % rev)
+            parent_output = runfetchcmd('%s rev-parse %s^@' % (gitcmd, rev), d)
+            parents = [p.rstrip() for p in parent_output.splitlines()]
+            with open(shallow_file, 'a') as f:
+                f.write(rev + '\n')
+            seen.add(rev)
+
+            for parent in parents:
+                for ref in refs:
+                    try:
+                        merge_base = runfetchcmd('%s merge-base %s %s' % (gitcmd, parent, ref), d).rstrip()
+                    except bb.fetch2.FetchError:
+                        continue
+                    queue.append(merge_base)
+
+        runfetchcmd('%s reflog expire --expire-unreachable=now --all' % gitcmd, d)
+        runfetchcmd('%s repack -ad' % gitcmd, d)
+        runfetchcmd('%s prune --expire now' % gitcmd, d)
+
+    @classmethod
+    def get_all_refs(cls, gitcmd, d, ref_filter=None):
+        """Return all the existing refs in this repository, optionally filtering the refs."""
+        ref_output = runfetchcmd('{} for-each-ref "--format=%(refname)" "%(*objecttype)"'.format(gitcmd), d)
+        ref_split = (tuple(iter_extend(l.rstrip().rsplit('\t', 1), 2)) for l in ref_output.splitlines())
+        if ref_filter:
+            ref_split = (e for e in ref_split if ref_filter(*e))
+        refs = [r for r, _ in ref_split]
+        return refs
+
+    @classmethod
+    def filter_refs(cls, gitcmd, d, refs):
+        """Remove all but the specified refs from the git repository."""
+        all_refs = cls.get_all_refs(gitcmd, d)
+        full_refs = runfetchcmd('%s rev-parse --symbolic-full-name %s' % (gitcmd, ' '.join(refs)), d).splitlines()
+        to_remove = set(all_refs) - set(full_refs)
+        if to_remove:
+            p = bb.process.Popen(['xargs', '-0', '-n', '1', 'git', 'update-ref', '-d', '--no-deref'], stderr=subprocess.PIPE)
+            p.communicate(''.join(l + '\0' for l in to_remove))
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
 
         subdir = ud.parm.get("subpath", "")
         if subdir != "":
-            readpathspec = ":%s" % (subdir)
+            readpathspec = ":%s" % subdir
             def_destsuffix = "%s/" % os.path.basename(subdir.rstrip('/'))
         else:
             readpathspec = ""
@@ -258,11 +456,17 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        cloneflags = "-s -n"
-        if ud.bareclone:
-            cloneflags += " --mirror"
+        if ud.shallow and (not os.path.exists(ud.clonedir) or self.need_update(ud, d)):
+            bb.utils.mkdirhier(destdir)
+            os.chdir(destdir)
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d)
+        else:
+            cloneflags = "-s -n"
+            if ud.bareclone:
+                cloneflags += " --mirror"
+
+            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, ud.clonedir, destdir), d)
 
-        runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, ud.clonedir, destdir), d)
         os.chdir(destdir)
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
-- 
2.8.0


