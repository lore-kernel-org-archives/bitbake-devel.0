Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09191C36005
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 12:25:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.64424.1742905493874459455
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 05:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6880C1756
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 05:24:59 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10BB63F58B
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 05:24:52 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 2/6] fetch2/wget: use long arguments for clarity
Date: Tue, 25 Mar 2025 12:24:36 +0000
Message-ID: <20250325122441.2521891-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325122441.2521891-1-ross.burton@arm.com>
References: <20250325122441.2521891-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 12:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17487

It's best practise to use long-form arguments in scripts where the
conciseness of short arguments is less useful than in an interactive
terminal.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index df3e649312f..7b9eb6ed096 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -82,7 +82,7 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile =3D ud.host + ud.path.replace("/", ".")
=20
-        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 100"
+        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 --tries=3D2 --timeout=3D100"
=20
         if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
             self.basecmd +=3D " --passive-ftp"
@@ -96,7 +96,7 @@ class Wget(FetchMethod):
=20
         logger.debug2("Fetching %s using command '%s'" % (ud.url, comman=
d))
         bb.fetch2.check_network_access(d, command, ud.url)
-        runfetchcmd(command + ' --progress=3Ddot -v', d, quiet, log=3Dpr=
ogresshandler, workdir=3Dworkdir)
+        runfetchcmd(command + ' --progress=3Ddot --verbose', d, quiet, l=
og=3Dprogresshandler, workdir=3Dworkdir)
=20
     def download(self, ud, d):
         """Fetch urls"""
@@ -106,7 +106,7 @@ class Wget(FetchMethod):
         dldir =3D os.path.realpath(d.getVar("DL_DIR"))
         localpath =3D os.path.join(dldir, ud.localfile) + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
-        fetchcmd +=3D " -O %s" % shlex.quote(localpath)
+        fetchcmd +=3D " --output-document-%s" % shlex.quote(localpath)
=20
         if ud.user and ud.pswd:
             fetchcmd +=3D " --auth-no-challenge"
@@ -124,9 +124,9 @@ class Wget(FetchMethod):
         uri =3D ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd +=3D " -c -P " + dldir + " '" + uri + "'"
+            fetchcmd +=3D " --continue --directory-prefix=3D" + dldir + =
" '" + uri + "'"
         else:
-            fetchcmd +=3D " -P " + dldir + " '" + uri + "'"
+            fetchcmd +=3D " --directory-prefix=3D" + dldir + " '" + uri =
+ "'"
=20
         self._runwget(ud, d, fetchcmd, False)
=20
@@ -490,7 +490,7 @@ class Wget(FetchMethod):
         f =3D tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix=3D"wget-index-") as work=
dir, tempfile.NamedTemporaryFile(dir=3Dworkdir, prefix=3D"wget-listing-")=
 as f:
             fetchcmd =3D self.basecmd
-            fetchcmd +=3D " -O " + f.name + " '" + uri + "'"
+            fetchcmd +=3D " --output-document=3D%s '%s'" % (f.name, uri)
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=3Dworkdir)
                 fetchresult =3D f.read()
--=20
2.43.0


