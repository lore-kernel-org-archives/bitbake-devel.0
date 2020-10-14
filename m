Received: from MTA-05-4.privateemail.com (MTA-05-4.privateemail.com [198.54.127.60])
 by mx.groups.io with SMTP id smtpd.web10.8319.1602668965205536120
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Oct 2020 02:49:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 198.54.127.60, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-05.privateemail.com (localhost [127.0.0.1])
	by MTA-05.privateemail.com (Postfix) with ESMTP id 236566004E;
	Wed, 14 Oct 2020 05:49:24 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.217])
	by MTA-05.privateemail.com (Postfix) with ESMTPA id 2A83F6004B;
	Wed, 14 Oct 2020 09:49:22 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [master][dunfell][1.46][PATCH] bitbake: fetch/git: use shlex.quote() to support spaces in SRC_URI url
Date: Wed, 14 Oct 2020 10:48:38 +0100
Message-Id: <20201014094838.5570-1-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

This commit replaces the instances where escaped double quotes
are used to support SRC_URI url containing spaces with the more
pythonic shlex.quote().

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/fetch2/git.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 07064c694f..b97967b487 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -63,6 +63,7 @@ import errno
 import fnmatch
 import os
 import re
+import shlex
 import subprocess
 import tempfile
 import bb
@@ -342,7 +343,7 @@ class Git(FetchMethod):
             # We do this since git will use a "-l" option automatically =
for local urls where possible
             if repourl.startswith("file://"):
                 repourl =3D repourl[7:]
-            clone_cmd =3D "LANG=3DC %s clone --bare --mirror \"%s\" %s -=
-progress" % (ud.basecmd, repourl, ud.clonedir)
+            clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --pro=
gress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
@@ -354,8 +355,8 @@ class Git(FetchMethod):
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
=20
-            runfetchcmd("%s remote add --mirror=3Dfetch origin \"%s\"" %=
 (ud.basecmd, repourl), d, workdir=3Dud.clonedir)
-            fetch_cmd =3D "LANG=3DC %s fetch -f --progress \"%s\" refs/*=
:refs/*" % (ud.basecmd, repourl)
+            runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
+            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, shlex.quote(repourl))
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
@@ -504,7 +505,7 @@ class Git(FetchMethod):
             raise bb.fetch2.UnpackError("No up to date source found: " +=
 "; ".join(source_error), ud.url)
=20
         repourl =3D self._get_repo_url(ud)
-        runfetchcmd("%s remote set-url origin \"%s\"" % (ud.basecmd, rep=
ourl), d, workdir=3Ddestdir)
+        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.q=
uote(repourl)), d, workdir=3Ddestdir)
=20
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
@@ -623,8 +624,8 @@ class Git(FetchMethod):
         d.setVar('_BB_GIT_IN_LSREMOTE', '1')
         try:
             repourl =3D self._get_repo_url(ud)
-            cmd =3D "%s ls-remote \"%s\" %s" % \
-                (ud.basecmd, repourl, search)
+            cmd =3D "%s ls-remote %s %s" % \
+                (ud.basecmd, shlex.quote(repourl), search)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, cmd, repourl)
             output =3D runfetchcmd(cmd, d, True)
--=20
2.28.0

