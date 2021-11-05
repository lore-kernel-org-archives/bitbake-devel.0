Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58EBC433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 13:31:00 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web11.5533.1636119058934751874
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 06:31:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=uAhEm9NA;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: Jasper Orschulko <jasper@fancydomain.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636119056;
	bh=v8kt4QaUdu96c5FE30fgdTunEkEUS8py46UsFWI9vVk=;
	h=From:To:Cc:Subject;
	b=uAhEm9NAD3WGk1IkYJEJHKh4B8znzEeBEps4R4iMC2lnfhLZy36p+7dBjqX/oQ6/M
	 zzeR6UVEiHXcoZ9xWHJwsCzXJXgdidPCxVLvTWZtgoAVL3/vz3w6SbeZJaJSul5E5l
	 EY06rKi8gP1NW85Lf4QAGeIc+/UbRcEl3LpjDZIrNg8VswC3WIEL6TyhjrdZXeqyzf
	 k/5txbSZSMCA5X6EKDfpJDmdMSMfnXoifzDxj+GG+E1GMYr3BpiubnNTvFVuNlKaAJ
	 g/mbYwKvVCDRexd6W/e1BNBwvHluVTdoDDH+rD8nUIaEWWGKBuLjKxKCZ+wYv3Q8pK
	 p/6fiLpV6AvoQ==
To: bitbake-devel@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.net,
	openembedded-core@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [PATCH 1/2] fetch2/repo: Implement AUTOREV for repo fetcher
Date: Fri,  5 Nov 2021 14:30:47 +0100
Message-Id: <20211105133048.19879-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 13:31:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12891

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
 lib/bb/fetch2/repo.py | 226 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 198 insertions(+), 28 deletions(-)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index fa4cb814..22ee5b80 100644
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
@@ -13,10 +14,13 @@ BitBake "Fetch" repo (git) implementation
=20
 import os
 import bb
+import hashlib
+import xml.etree.ElementTree as ET
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
=20
+
 class Repo(FetchMethod):
     """Class to fetch a module or modules from repo (git) repositories""=
"
     def supports(self, ud, d):
@@ -27,46 +31,74 @@ class Repo(FetchMethod):
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
-
-        repodir =3D d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo"=
)
-        gitsrcname =3D "%s%s" % (ud.host, ud.path.replace("/", "."))
-        codir =3D os.path.join(repodir, gitsrcname, ud.manifest)
+        bb.utils.mkdirhier(ud.repodir)
=20
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
+
+        # fixup the revision -> when it starts with underscore, it's an =
artificial one
+        # therefore we then use the specified remote branch used to gene=
rate
+        # the artificial revision in _latest_revision
+        realRevision =3D ud.revision
+        if ud.revision.startswith("_"):
+            realRevision =3D ud.branch
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
+        # always run repo init, because we might want to switch branch o=
r manifests.
+        bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s" % =
(ud.basecmd, ud.manifest, realRevision, ud.remoteRepo), ud.url)
+        runfetchcmd("%s init -m %s -b %s -u %s" % (ud.basecmd, ud.manife=
st, realRevision, ud.remoteRepo), d, workdir=3Dud.repodir)
=20
-        bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud=
.url), ud.url)
-        runfetchcmd("%s sync" % ud.basecmd, d, workdir=3Drepodir)
+        bb.fetch2.check_network_access(d, "%s sync %s %s" % (ud.basecmd,=
 submodules, ud.url), ud.url)
+        runfetchcmd("%s sync %s" % (ud.basecmd, submodules), d, workdir=3D=
ud.repodir)
=20
         scmdata =3D ud.parm.get("scmdata", "")
         if scmdata =3D=3D "keep":
@@ -75,13 +107,151 @@ class Repo(FetchMethod):
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
+    def _checkBranch(self, ud, d, name, repo):
+        output =3D self._lsremote(ud, d, name, repo)
+        searchstring =3D "refs/heads/%s" % name
+        found =3D False
+        for line in output.strip().split('\n'):
+            sha1, ref =3D line.split()
+            if searchstring =3D=3D ref:
+                logger.debug(1, "resolved %s@%s to %s", repo, name, sha1=
)
+                return sha1
+                break
+
+        if not found:
+            raise bb.fetch2.FetchError("Could not determine remote ref!"=
)
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
+        sha1 =3D self._checkBranch(ud, d, ud.branch, ud.remoteRepo)
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
+            # parse the specified XML manifest
+            xml =3D ET.parse("%s/%s" % (ud.tempdir, ud.manifest))
+
+            # repo manifest *may* specify a <default> element, specifyin=
g fallback remotes and revisions
+            defaultObject =3D xml.find('default')
+
+            # parse all remotes and their corresponding default revision=
s
+            remotes =3D {}
+            remoteRevisions =3D {}
+            for remote in xml.findall('remote'):
+                remotes[remote.get('name')] =3D remote.get('fetch')
+                remoteRevisions[remote.get('name')] =3D remote.get('revi=
sion')
+
+            # iterate through the <project> elements, resolving the corr=
ect remote
+            # and revision
+            for project in xml.findall('project'):
+
+                # resolve the remote of the project
+                # when no remote is specified in the project take the on=
e from <default>
+                # when both aren't specified, throw
+                remoteName =3D project.get('remote')
+                if remoteName is None and defaultObject is not None:
+                    remoteName =3D defaultObject.get('remote')
+                if remoteName is None:
+                    raise bb.fetch2.FetchError("repo manifest specifies =
no remote for %s" % project.get('name'))
+
+                # resolve the remoteName to a git remote URL and optiona=
lly
+                # the revision if it was specified in <remote>
+                if remotes[remoteName] is not None:
+                    remoteRev =3D remoteRevisions[remoteName]
+                    remote =3D remotes[remoteName]
+
+                # use revision in the project, when not specified use th=
e one from <remote>
+                # when that is not specified use <default> and when we n=
ot have anything specified
+                # throw an exception
+                revision =3D project.get('revision') or remoteRev
+                if revision is None and defaultObject is not None:
+                    revision =3D defaultObject.get('revision')
+                if revision is None:
+                    raise bb.fetch2.FetchError("repo manifest specifies =
no revision for %s" % project.get('name'))
+
+                # perform an ls-remote on the branch, update the checksu=
m with the commit hash
+                gitRemotePath =3D "%s/%s" % (remote, project.get('name')=
)
+
+                sha1 =3D self._checkBranch(ud, d, revision, gitRemotePat=
h)
+                hashUpdate =3D bytes(sha1, 'utf-8')
+                hashCalc.update(hashUpdate)
+
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


