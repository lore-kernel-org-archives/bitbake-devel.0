Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF0C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 12:54:35 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web10.10228.1636635271894831214
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 04:54:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=aiL2WzAL;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: jasper@fancydomain.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636635269;
	bh=rP8fJzQ7HhypY3ybYI0fERwX1SsQVUX1iBFOfE/p/A8=;
	h=From:To:Cc:Subject;
	b=aiL2WzALwX65tLbBALvuVe8TkSS2tVy5g0MGn2cxistd8zIBwa1UL3sJa0SM47os4
	 s04W9Vw1TQt9wVFPFGzfxE/k1G8ThN8SqevfFfEZgW8sqyOxUPu1A4T/wRaBdwOoNm
	 DOjjwfZb9xynMh2sgnQKDbwKYc9QTIgLoI6OQsz9Iz+4hBsJviJpICtAOq1z3LWRfG
	 1tLDCdrCnx2Tf7iWSf6BSbiuZLVxfWIf1MrstVouGrJja8HSJ82jGI4nHt7Ldu6do+
	 PHkVCWJKsrKIgq7L2slI1snFJW6kBfyjvaguYAKZdK50QxfJoHsRTPX1vnn9ZFi4nD
	 dIHZxWb0GUlkw==
To: bitbake-devel@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com,
	openembedded-core@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [PATCH v2] fetch2/repo: Implement AUTOREV for repo fetcher
Date: Thu, 11 Nov 2021 13:53:52 +0100
Message-Id: <20211111125352.1224557-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 12:54:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13021

From: Martin Koppehel <martin@mko.dev>

- Implement AUTOINC and submodule support for REPO provider
- Implement full srcrev support
- Add comments and fixup empty DL_DIR initialization
- Distinguish between artificial and plain rev
- Comments/documentation

The previous implementation of the repo fetcher could not handle updates
to the repo manifest file, nor deal with dynamic refspecs within this
manifest.

This patch fixes these shortcomings as follows:
During the recipe parsing phase, the repository containing the repo
manifest is cloned. This is done, as we need to parse the XML file
contained within, in order to discover all involved git repositories. A
combined hash is then calculated from the manifest repo, as well as any
git repo specified in the manifest. This hash is used for determining the
necessity of an update.

Additionally, the recipe will throw an error if the repo source is set to
a fixed revision but one or more repositories within the manifest
reference a dynamic refspec. This is done to ensure the reproducibility
of a version-pinned recipe.

Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
---
 lib/bb/fetch2/repo.py | 259 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 230 insertions(+), 29 deletions(-)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fa4cb814..b2e1ba8c 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -3,6 +3,7 @@ BitBake "Fetch" repo (git) implementation
=20
 """
=20
+# Copyright (C) 2021 Martin Koppehel <martin@mko.dev>, iris-GmbH infrare=
d & intelligent sensors
 # Copyright (C) 2009 Tom Rini <trini@embeddedalley.com>
 #
 # Based on git.py which is:
@@ -13,9 +14,11 @@ BitBake "Fetch" repo (git) implementation
=20
 import os
 import bb
+import hashlib
+import xml.etree.ElementTree as ET
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
+
=20
 class Repo(FetchMethod):
     """Class to fetch a module or modules from repo (git) repositories""=
"
@@ -27,46 +30,84 @@ class Repo(FetchMethod):
=20
     def urldata_init(self, ud, d):
         """
-        We don"t care about the git rev of the manifests repository, but
-        we do care about the manifest to use.  The default is "default".
-        We also care about the branch or tag to be used.  The default is
-        "master".
+        We do care about the rev of the manifests repository, as well as=
 the
+        manifest file. However, when SRCREV=3DAUTOINC, then we use the s=
pecified
+        branch in SRC_URI, with a fallback to master.
+        use sm=3Dfetch to fetch possibly referenced submodules in reposi=
tories.
         """
=20
         ud.basecmd =3D d.getVar("FETCHCMD_repo") or "/usr/bin/env repo"
+        ud.gitcmd =3D d.getVar("FETCHCMD_git") or "git -c core.fsyncobje=
ctfiles=3D0"
=20
         ud.proto =3D ud.parm.get('protocol', 'git')
         ud.branch =3D ud.parm.get('branch', 'master')
+
+        ud.submodules =3D ud.parm.get('sm', 'fetch')
         ud.manifest =3D ud.parm.get('manifest', 'default.xml')
         if not ud.manifest.endswith('.xml'):
             ud.manifest +=3D '.xml'
=20
-        ud.localfile =3D d.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, u=
d.path.replace("/", "."), ud.manifest, ud.branch))
+        repodir =3D d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo"=
)
+        gitsrcname =3D "%s%s.%s" % (ud.host, ud.path.replace("/", "."), =
ud.manifest)
+        ud.codir =3D os.path.join(repodir, d.getVar("BPN"), gitsrcname)
+
+        if ud.user:
+            ud.username =3D ud.user + "@"
+        else:
+            ud.username =3D ""
+        ud.remoteRepo =3D "%s://%s%s%s" % (ud.proto, ud.username, ud.hos=
t, ud.path)
+
+        ud.repodir =3D os.path.join(ud.codir, "repo")
+        # a temporary directory to compute _latest_revision
+        ud.tempdir =3D os.path.join(ud.codir, "temp")
+        ud.stampfile =3D os.path.join(ud.codir, "__hash.txt")
+        ud.setup_revisions(d)
+
+        # ud.localfile is used to fill localpath, where the downloaded t=
arball is stored.
+        # in our case, we want something like repo_$GIT_URL_$MANIFEST_$S=
RCREV
+        # todo: do we want the packagename?
+        ud.localfile =3D "repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.re=
place("/", "."), ud.manifest, d.getVar("SRCREV"))
+
+    def need_update(self, ud, d):
+        if d.getVar("SRCREV") =3D=3D "AUTOINC":
+            return True
+        return os.path.exists(ud.localfile)
=20
     def download(self, ud, d):
         """Fetch url"""
=20
-        if os.access(os.path.join(d.getVar("DL_DIR"), ud.localfile), os.=
R_OK):
-            logger.debug("%s already exists (or was stashed). Skipping r=
epo init / sync.", ud.localpath)
-            return
+        bb.utils.mkdirhier(ud.repodir)
=20
-        repodir =3D d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo"=
)
-        gitsrcname =3D "%s%s" % (ud.host, ud.path.replace("/", "."))
-        codir =3D os.path.join(repodir, gitsrcname, ud.manifest)
-
-        if ud.user:
-            username =3D ud.user + "@"
+        # we want to run a repo init *always* in case the branch or mani=
fest name changes.
+        # if not os.path.exists(os.path.join(repodir, ".repo")):
+        if ud.submodules =3D=3D "fetch":
+            submodules =3D "--fetch-submodules"
         else:
-            username =3D ""
+            submodules =3D ""
=20
-        repodir =3D os.path.join(codir, "repo")
-        bb.utils.mkdirhier(repodir)
-        if not os.path.exists(os.path.join(repodir, ".repo")):
-            bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s=
://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.=
host, ud.path), ud.url)
-            runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s" % (ud.basec=
md, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, wor=
kdir=3Drepodir)
+        # fixup the revision -> when it starts with underscore, it's an =
artificial one
+        # therefore we then use the specified remote branch used to gene=
rate
+        # the artificial revision in _latest_revision
+        realRevision =3D ud.revision
+        if ud.revision.startswith("_"):
+            realRevision =3D ud.branch
=20
-        bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud=
.url), ud.url)
-        runfetchcmd("%s sync" % ud.basecmd, d, workdir=3Drepodir)
+        # always run repo init, because we might want to switch branch o=
r manifests.
+        bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s" % =
(ud.basecmd, ud.manifest, realRevision, ud.remoteRepo), ud.url)
+        runfetchcmd("%s init -m %s -b %s -u %s" % (ud.basecmd, ud.manife=
st, realRevision, ud.remoteRepo), d, workdir=3Dud.repodir)
+
+        bb.fetch2.check_network_access(d, "%s sync %s %s" % (ud.basecmd,=
 submodules, ud.url), ud.url)
+        runfetchcmd("%s sync %s" % (ud.basecmd, submodules), d, workdir=3D=
ud.repodir)
+
+        # at this point, we have a checked out version, so make sure tha=
t revisions are pinned if the user requests that
+        if self._checkIsFixedRevision(ud, d, realRevision, ud.repodir):
+            # our manifest repo has a tag or a fixed sha revision =3D> e=
nsure all linked repos have the same.
+            def projectIterator(project, remote, revision):
+                if not self._checkIsFixedRevision(ud, d, revision, os.pa=
th.join(ud.repodir, project.get("path"))):
+                    raise bb.fetch2.FetchError("repo recipe is set to a =
fixed revision but project %s has variable revision %s.\nTo fix this, spe=
cify tags or SHA-hashes in your repo manifest file.\nThis is important to=
 guarantee reproducibility." % (project.get('name'), revision), ud.url)
+
+            output =3D runfetchcmd("%s manifest" % ud.basecmd, d, workdi=
r=3Dud.repodir)
+            self._scanRepoManifest(ud, d, output, projectIterator, conte=
nt=3DTrue)
=20
         scmdata =3D ud.parm.get("scmdata", "")
         if scmdata =3D=3D "keep":
@@ -75,13 +116,173 @@ class Repo(FetchMethod):
             tar_flags =3D "--exclude=3D'.repo' --exclude=3D'.git'"
=20
         # Create a cache
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.p=
ath.join(".", "*") ), d, workdir=3Dcodir)
+        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.p=
ath.join(".", "*")), d, workdir=3Dud.codir)
=20
     def supports_srcrev(self):
-        return False
+        return True
+
+    def clean(self, ud, d):
+        """ clean the repo directory """
+
+        to_remove =3D [ud.localpath, ud.repodir, ud.tempdir, ud.stampfil=
e]
+        # The localpath is a symlink to clonedir when it is cloned from =
a
+        # mirror, so remove both of them.
+        if os.path.islink(ud.localpath):
+            clonedir =3D os.path.realpath(ud.localpath)
+            to_remove.append(clonedir)
+
+        for r in to_remove:
+            if os.path.exists(r):
+                bb.utils.remove(r, True)
+
+    # this is taken from the git fetcher
+    def _lsremote(self, ud, d, search, repo):
+        """
+        Run git ls-remote with the specified search string
+        """
+        # Prevent recursion e.g. in OE if SRCPV is in PV, PV is in WORKD=
IR,
+        # and WORKDIR is in PATH (as a result of RSS), our call to
+        # runfetchcmd() exports PATH so this function will get called ag=
ain (!)
+        # In this scenario the return call of the function isn't actuall=
y
+        # important - WORKDIR isn't needed in PATH to call git ls-remote
+        # anyway.
+        if d.getVar('_BB_REPO_IN_LSREMOTE', False):
+            return ''
+        d.setVar('_BB_REPO_IN_LSREMOTE', '1')
+        try:
+            cmd =3D "%s ls-remote \"%s\" %s" % \
+                (ud.gitcmd, repo, search)
+            if ud.proto.lower() !=3D 'file':
+                bb.fetch2.check_network_access(d, cmd, ud.remoteRepo)
+            output =3D runfetchcmd(cmd, d, True)
+            if not output:
+                raise bb.fetch2.FetchError("The command %s gave empty ou=
tput unexpectedly" % cmd, ud.url)
+        finally:
+            d.delVar('_BB_REPO_IN_LSREMOTE')
+        return output
+
+    # simple helper function to check if a specific object exists.
+    # used to check that things reference commits
+    def _revParse(self, ud, d, obj, repoDir, expect):
+        try:
+            cmd =3D "%s rev-parse -q %s" % (ud.gitcmd, obj)
+            runfetchcmd(cmd, d, workdir =3D repoDir)
+        except:
+            return not expect
+        return expect
+
+    # checks that the given revision is *not* a branch.
+    def _checkIsFixedRevision(self, ud, d, commithash, repodir):
+        if not self._revParse(ud, d, "refs/heads/%s" % commithash, repod=
ir, False):
+            return False
+        return self._revParse(ud, d, "refs/tags/%s" % commithash, repodi=
r, True) or self._revParse(ud, d, commithash, repodir, True)
+
+    def _resolveBranchToSHA1(self, ud, d, name, repo):
+        output =3D self._lsremote(ud, d, name, repo)
+        searchstring =3D "refs/heads/%s" % name
+        found =3D False
+        for line in output.strip().split('\n'):
+            sha1, ref =3D line.split()
+            if searchstring =3D=3D ref:
+                return sha1
+                break
+
+        if not found:
+            raise bb.fetch2.FetchError("Could not determine remote ref!"=
)
+
+    def _scanRepoManifest(self, ud, d, path, callback, content=3DFalse):
+        # parse the specified XML manifest
+        if content:
+          xml =3D ET.fromstring(path)
+        else:
+          xml =3D ET.parse(path)
+
+        # repo manifest *may* specify a <default> element, specifying fa=
llback remotes and revisions
+        defaultObject =3D xml.find('default')
+
+        # parse all remotes and their corresponding default revisions
+        remotes =3D {}
+        remoteRevisions =3D {}
+        for remote in xml.findall('remote'):
+            remotes[remote.get('name')] =3D remote.get('fetch')
+            remoteRevisions[remote.get('name')] =3D remote.get('revision=
')
+
+
+        # iterate through the <project> elements, resolving the correct =
remote
+        # and revision
+        for project in xml.findall('project'):
+            # resolve the remote of the project
+            # when no remote is specified in the project take the one fr=
om <default>
+            # when both aren't specified, throw
+            remoteName =3D project.get('remote')
+            if remoteName is None and defaultObject is not None:
+                remoteName =3D defaultObject.get('remote')
+            if remoteName is None:
+                raise bb.fetch2.FetchError("repo manifest specifies no r=
emote for %s" % project.get('name'))
+
+            # resolve the remoteName to a git remote URL and optionally
+            # the revision if it was specified in <remote>
+            if remotes[remoteName] is not None:
+                remoteRev =3D remoteRevisions[remoteName]
+                remote =3D remotes[remoteName]
+
+            # use revision in the project, when not specified use the on=
e from <remote>
+            # when that is not specified use <default> and when we not h=
ave anything specified
+            # throw an exception
+            revision =3D project.get('revision') or remoteRev
+            if revision is None and defaultObject is not None:
+                revision =3D defaultObject.get('revision')
+            if revision is None:
+                raise bb.fetch2.FetchError("repo manifest specifies no r=
evision for %s" % project.get('name'))
+            callback(project, remote, revision)
+
+    def _build_revision(self, ud, d, name):
+        return ud.revisions[name]
+
+    def _revision_key(self, ud, d, name):
+        return "%s-%s" % (d.getVar("BPN"), name)
+
+    def _latest_revision(self, ud, d, name):
+        """
+        Computes an artificial revision from the manifest repository and=
 all
+        referenced repositories and their remote revisions.
+        name is ignored because we can only have a single branch/name
+        """
+        if d.getVar('_BB_REPO_IN_LATEST_REV', False):
+            return ''
+        d.setVar('_BB_REPO_IN_LATEST_REV', '1')
+
+        # we use a sha256 to mixup all the hashes we have
+        hashCalc =3D hashlib.sha256()
+
+        # first, add the hash of the repo itself
+        sha1 =3D self._resolveBranchToSHA1(ud, d, ud.branch, ud.remoteRe=
po)
+        hashUpdate =3D bytes(sha1, 'utf-8')
+        hashCalc.update(hashUpdate)
+
+        # Parse the repo XML files, remove things
+        try:
+            # create/cleanup temporary dir where to clone the repo-manif=
est URL
+            if os.path.isdir(ud.tempdir):
+                bb.utils.prunedir(ud.tempdir)
+            bb.utils.mkdirhier(ud.tempdir)
+
+            # clone the manifest repo to the temporary dir we just set u=
p
+            bb.fetch2.check_network_access(d, "%s clone -b %s --depth 1 =
--single-branch %s ." % (ud.gitcmd, ud.branch, ud.remoteRepo), ud.url)
+            runfetchcmd("%s clone -b %s --depth 1 --single-branch %s %s"=
 % (ud.gitcmd, ud.branch, ud.remoteRepo, ud.tempdir), d, workdir=3Dud.tem=
pdir)
+
+            def projectIterator(project, remote, revision):
+                # perform an ls-remote on the branch, update the checksu=
m with the commit hash
+                gitRemotePath =3D "%s/%s" % (remote, project.get('name')=
)
+
+                sha1 =3D self._resolveBranchToSHA1(ud, d, revision, gitR=
emotePath)
+                hashUpdate =3D bytes(sha1, 'utf-8')
+                hashCalc.update(hashUpdate)
+
+            self._scanRepoManifest(ud, d, "%s/%s" % (ud.tempdir, ud.mani=
fest), projectIterator)
+        finally:
+            d.delVar('_BB_REPO_IN_LATEST_REV')
+        digest =3D "_" + hashCalc.hexdigest()
+        return digest
=20
-    def _build_revision(self, ud, d):
-        return ud.manifest
=20
-    def _want_sortable_revision(self, ud, d):
-        return False
--=20
2.33.1


