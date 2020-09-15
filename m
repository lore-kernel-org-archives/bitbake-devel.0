Received: from MTA-14-4.privateemail.com (MTA-14-4.privateemail.com [198.54.118.206])
 by mx.groups.io with SMTP id smtpd.web11.7316.1600204370534671685
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Sep 2020 14:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 198.54.118.206, mailfrom: charles.davies@whitetree.xyz)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 1497680062;
	Tue, 15 Sep 2020 17:12:50 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.210])
	by mta-14.privateemail.com (Postfix) with ESMTPA id 050828005C;
	Tue, 15 Sep 2020 21:12:48 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH] bitbake: fetch/git: add support for SRC_URI containing spaces in url
Date: Tue, 15 Sep 2020 22:12:14 +0100
Message-Id: <20200915211214.140434-1-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Microsoft's TFS VCS system allows for spaces in a git repository url.
An example of a valid url is:

ssh://tfs-my-company.org:22/tfs/My Projects/FooBar

This commit adds support for such urls by implementing two changes.
Firstly, when bitbake makes a git command line call the url is
surrounded by quotes so that the url, regardless of spaces, is
treated as one argument. Secondly, additional parsing of various
filepath variables, which are based off of the url, are now
completed with any spaces in the url replaced with underscores.

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/fetch2/git.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 644ba9238b..07064c694f 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -236,7 +236,7 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] =3D ud.revisions[name]
                 ud.revisions[name] =3D self.latest_revision(ud, d, name)
=20
-        gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.repl=
ace('/', '.').replace('*', '.'))
+        gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.repl=
ace('/', '.').replace('*', '.').replace(' ','_'))
         if gitsrcname.startswith('.'):
             gitsrcname =3D gitsrcname[1:]
=20
@@ -342,7 +342,7 @@ class Git(FetchMethod):
             # We do this since git will use a "-l" option automatically =
for local urls where possible
             if repourl.startswith("file://"):
                 repourl =3D repourl[7:]
-            clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --pro=
gress" % (ud.basecmd, repourl, ud.clonedir)
+            clone_cmd =3D "LANG=3DC %s clone --bare --mirror \"%s\" %s -=
-progress" % (ud.basecmd, repourl, ud.clonedir)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
@@ -354,8 +354,8 @@ class Git(FetchMethod):
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
=20
-            runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, repourl), d, workdir=3Dud.clonedir)
-            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, repourl)
+            runfetchcmd("%s remote add --mirror=3Dfetch origin \"%s\"" %=
 (ud.basecmd, repourl), d, workdir=3Dud.clonedir)
+            fetch_cmd =3D "LANG=3DC %s fetch -f --progress \"%s\" refs/*=
:refs/*" % (ud.basecmd, repourl)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
@@ -504,7 +504,7 @@ class Git(FetchMethod):
             raise bb.fetch2.UnpackError("No up to date source found: " +=
 "; ".join(source_error), ud.url)
=20
         repourl =3D self._get_repo_url(ud)
-        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl=
), d, workdir=3Ddestdir)
+        runfetchcmd("%s remote set-url origin \"%s\"" % (ud.basecmd, rep=
ourl), d, workdir=3Ddestdir)
=20
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
@@ -623,7 +623,7 @@ class Git(FetchMethod):
         d.setVar('_BB_GIT_IN_LSREMOTE', '1')
         try:
             repourl =3D self._get_repo_url(ud)
-            cmd =3D "%s ls-remote %s %s" % \
+            cmd =3D "%s ls-remote \"%s\" %s" % \
                 (ud.basecmd, repourl, search)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, cmd, repourl)
--=20
2.28.0

