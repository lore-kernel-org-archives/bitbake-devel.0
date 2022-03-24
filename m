Return-Path: <o.mandel@menlosystems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623D3C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 16:48:08 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web12.13453.1648140486418111125
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Mar 2022 09:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: menlosystems.com, ip: 212.18.0.9,
 mailfrom: o.mandel@menlosystems.com)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4KPWPH4cK9z1qyJG;
	Thu, 24 Mar 2022 17:48:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 4KPWPH3Tyjz1qqkD;
	Thu, 24 Mar 2022 17:48:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
	with ESMTP id aahfkdXoNCwD; Thu, 24 Mar 2022 17:48:02 +0100 (CET)
X-Auth-Info: ECygsBGjIrPu0YiohmtwYxfG/0suoviPVVVst64awKkYsQTmYkWIIvJnzIycpm06
Received: from menlobuildserver.MenloSystems.local
 (host-82-135-125-165.customer.m-online.net [82.135.125.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu, 24 Mar 2022 17:48:02 +0100 (CET)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH] fetch2/git: stop generated tarballs from leaking info
Date: Thu, 24 Mar 2022 17:47:59 +0100
Message-Id: <20220324164759.4097867-1-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Mar 2022 16:48:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13501

When using BB_GENERATE_MIRROR_TARBALLS=3D"1" to generate mirror tarballs
of git repositories, they leaked local information: username, group and
time of the last fetch. Remove all these by setting fixed information:

 * uname =3D pokybuild
 * gname =3D users
 * mtime =3D committer time of newest commit in repo

The username and group value were taken from the archives available on
the downloads.yoctoproject.org mirror. The modification time is chosen
so it still retains some relationship to the contents of the archive.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/bb/fetch2/git.py  |  5 ++++-
 lib/bb/tests/fetch.py | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b3c5e6da..4d06a571 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -462,7 +462,10 @@ class Git(FetchMethod):
=20
             logger.info("Creating tarball of git repository")
             with create_atomic(ud.fullmirror) as tfile:
-                runfetchcmd("tar -czf %s ." % tfile, d, workdir=3Dud.clo=
nedir)
+                mtime =3D runfetchcmd("git log --all -1 --format=3D%cD",=
 d,
+                        quiet=3DTrue, workdir=3Dud.clonedir)
+                runfetchcmd("tar -czf %s --owner pokybuild --group users=
 --mtime \"%s\" ."
+                        % (tfile, mtime), d, workdir=3Dud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
=20
     def clone_shallow_local(self, ud, dest, d):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index eff12b7c..233ecae7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -11,6 +11,7 @@ import hashlib
 import tempfile
 import collections
 import os
+import tarfile
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 import bb
@@ -628,6 +629,35 @@ class GitShallowTarballNamingTest(FetcherTest):
         self.assertIn(self.mirror_tarball, dir)
=20
=20
+class CleanTarballTest(FetcherTest):
+    def setUp(self):
+        super(CleanTarballTest, self).setUp()
+        self.recipe_url =3D "git://git.openembedded.org/bitbake"
+        self.recipe_tarball =3D "git2_git.openembedded.org.bitbake.tar.g=
z"
+
+        self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c4=
0')
+
+    @skipIfNoNetwork()
+    def test_that_the_tarball_contents_does_not_leak_info(self):
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+
+        fetcher.download()
+
+        fetcher.unpack(self.unpackdir)
+        mtime =3D bb.process.run('git log --all -1 --format=3D%ct',
+                cwd=3Dos.path.join(self.unpackdir, 'git'))
+        self.assertEqual(len(mtime), 2)
+        mtime =3D int(mtime[0])
+
+        archive =3D tarfile.open(os.path.join(self.dldir, self.recipe_ta=
rball))
+        self.assertNotEqual(len(archive.members), 0)
+        for member in archive.members:
+            self.assertEqual(member.uname, 'pokybuild')
+            self.assertEqual(member.gname, 'users')
+            self.assertEqual(member.mtime, mtime)
+
+
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
         def touch(fn):
--=20
2.25.1


