Return-Path: <o.mandel@menlosystems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6612C433F5
	for <webhook@archiver.kernel.org>; Mon, 28 Mar 2022 17:36:33 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web10.70.1648488988606656835
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 10:36:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: menlosystems.com, ip: 212.18.0.9,
 mailfrom: o.mandel@menlosystems.com)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4KS0HF5NTDz1qyJv;
	Mon, 28 Mar 2022 19:36:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 4KS0HF3RkGz1qqkB;
	Mon, 28 Mar 2022 19:36:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
	with ESMTP id jmWhjxNoVM4K; Mon, 28 Mar 2022 19:36:24 +0200 (CEST)
X-Auth-Info: h+LeOe8FUPabDJN8zMKke00eScCV60tXdAtAGjP+ZYDUQAQc+tD7kR7JjCUG0vq/
Received: from menlobuildserver.MenloSystems.local
 (host-82-135-125-165.customer.m-online.net [82.135.125.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon, 28 Mar 2022 19:36:24 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH v3] fetch2/git: stop generated tarballs from leaking info
Date: Mon, 28 Mar 2022 19:36:18 +0200
Message-Id: <20220328173618.960965-1-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324164759.4097867-1-o.mandel@menlosystems.com>
References: <20220324164759.4097867-1-o.mandel@menlosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Mar 2022 17:36:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13525

When using BB_GENERATE_MIRROR_TARBALLS=3D"1" to generate mirror tarballs
of git repositories, they leaked local information: username, group and
time of the last fetch. Remove all these by setting fixed information:

 * uname =3D pokybuild (6000)
 * gname =3D users (100)
 * mtime =3D committer time of newest commit in repo

The username and group value were taken from the archives available on
the downloads.yoctoproject.org mirror. The modification time is chosen
so it still retains some relationship to the contents of the archive.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/bb/fetch2/git.py  |  5 ++++-
 lib/bb/tests/fetch.py | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f6f6b63a..727cebdc 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -448,7 +448,10 @@ class Git(FetchMethod):
=20
             logger.info("Creating tarball of git repository")
             with create_atomic(ud.fullmirror) as tfile:
-                runfetchcmd("tar -czf %s ." % tfile, d, workdir=3Dud.clo=
nedir)
+                mtime =3D runfetchcmd("git log --all -1 --format=3D%cD",=
 d,
+                        quiet=3DTrue, workdir=3Dud.clonedir)
+                runfetchcmd("tar -czf %s --owner pokybuild:6000 --group =
users:100 --mtime \"%s\" ."
+                        % (tfile, mtime), d, workdir=3Dud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
=20
     def clone_shallow_local(self, ud, dest, d):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 301c4683..68934e79 100644
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
@@ -584,6 +585,37 @@ class GitShallowTarballNamingTest(FetcherTest):
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
+            self.assertEqual(member.uid, 6000)
+            self.assertEqual(member.gname, 'users')
+            self.assertEqual(member.gid, 100)
+            self.assertEqual(member.mtime, mtime)
+
+
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
         def touch(fn):
--=20
2.25.1


