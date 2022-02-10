Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CF9C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 13:56:39 +0000 (UTC)
Received: from forward104p.mail.yandex.net (forward104p.mail.yandex.net
 [77.88.28.107])
 by mx.groups.io with SMTP id smtpd.web10.10273.1644501394855615794
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:56:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@zhukoff.net
 header.s=mail header.b=zYFwwLbn;
 spf=pass (domain: zhukoff.net, ip: 77.88.28.107, mailfrom: pavel@zhukoff.net)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
	by forward104p.mail.yandex.net (Yandex) with ESMTP id EA1043C1F2C9;
	Thu, 10 Feb 2022 16:56:30 +0300 (MSK)
Received: from vla1-68d3ce55e22b.qloud-c.yandex.net
 (vla1-68d3ce55e22b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3385:0:640:68d3:ce55])
	by forward100q.mail.yandex.net (Yandex) with ESMTP id E65936F40007;
	Thu, 10 Feb 2022 16:56:30 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net
 (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
	by vla1-68d3ce55e22b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 N4a7c99Wpl-uUcWotw7;
	Thu, 10 Feb 2022 16:56:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; s=mail;
 t=1644501390;
	bh=pV53t+wZSNGJNrpHLiZC8ZfrOVPuPNvThtZlBNsLx/4=;
	h=Date:Subject:To:From:Message-Id:Cc;
	b=zYFwwLbn4LG/p6XKDgA84+ylL5K/Xe1trcJwQUieLBgakmtKFxkEKIJ4A078ytKyV
	 Q0v9DlE4bgRPv9ArNSJMfTODLXdR0QoGZIFEHtf1sJOxvZgSy5xnb42A89PZ2u2byz
	 Zn6uF9j7Qt1piP+4hcQh7ZLuMYlsi7c5XWZdT8NQ=
Authentication-Results: vla1-68d3ce55e22b.qloud-c.yandex.net;
 dkim=pass header.i=@zhukoff.net
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id T8NKxsQPSr-uTHeGXug;
	Thu, 10 Feb 2022 16:56:29 +0300
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Fwd: 2
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH] Do not try upstream if BB_FETCH_PREMIRRORONLY was specified
Date: Thu, 10 Feb 2022 14:56:11 +0100
Message-Id: <20220210135610.10216-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 13:56:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13331

This should fix [Yocto 13353] and related to [Yocto 13233] as well.
Previously if git repo mirror has been updated in between of two builds
fetcher of the second build didn't try updated mirror but switched to
git clone from upstream instead. This is problem for offline builds.
Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
specified by the mirror doesn't contain SRC_REV.
Note if SRC_REV is nonSHA1 revision when it will fail without the
network due to `ls-remote`.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/__init__.py | 10 ++++++
 lib/bb/fetch2/git.py      | 18 +++++-----
 lib/bb/tests/fetch.py     | 70 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d3717418..452f1469 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -133,6 +133,12 @@ class NonLocalMethod(Exception):
     def __init__(self):
         Exception.__init__(self)
=20
+class MirrorException(BBFetchException):
+    """Exception raises when BB_FETCH_PREMIRRORONLY was specified but mi=
rrors don't have SRCREV"""
+    def __init__(self, message):
+        BBFetchException.__init__(self, message)
+
+
 class MissingChecksumEvent(bb.event.Event):
     def __init__(self, url, **checksums):
         self.url =3D url
@@ -1066,6 +1072,8 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):
                 rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
+        elif isinstance(e, MirrorException):
+            logger.warning(str(e))
         else:
             logger.debug("Mirror fetch failure for url %s (original url:=
 %s)" % (ud.url, origud.url))
             logger.debug(str(e))
@@ -1729,6 +1737,8 @@ class Fetch(object):
                             done =3D False
=20
                 if premirroronly:
+                    if not done:
+                        raise MirrorException("Failed to download premir=
ror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVa=
r("PREMIRRORS")))
                     self.d.setVar("BB_NO_NETWORK", "1")
=20
                 firsterr =3D None
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 30da8e95..26923f78 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -335,11 +335,7 @@ class Git(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only p=
remirrors
         # is not possible
-        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
-            return True
-        if os.path.exists(ud.clonedir):
-            return False
-        return True
+        return bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")) o=
r not os.path.exists(ud.clonedir)
=20
     def download(self, ud, d):
         """Fetch url"""
@@ -350,10 +346,14 @@ class Git(FetchMethod):
         if ud.shallow and os.path.exists(ud.fullshallow) and self.need_u=
pdate(ud, d):
             ud.localpath =3D ud.fullshallow
             return
-        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clo=
nedir):
-            bb.utils.mkdirhier(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud.c=
lonedir)
-
+        if os.path.exists(ud.fullmirror):
+            if self.try_premirror(ud, d) and self.need_update(ud, d):
+                bb.utils.mkdirhier(ud.clonedir)
+                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3D=
ud.clonedir)
+                if self.need_update(ud, d) and \
+                   bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY"=
)):
+                    raise bb.fetch2.MirrorException("Premirror doesn't c=
ontain revisions {} and "\
+                                                          "upstream cann=
ot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
         repourl =3D self._get_repo_url(ud)
=20
         # If the repo still doesn't exist, fallback to cloning it
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ec7d83c9..471e4b7f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2776,3 +2776,73 @@ class GitSharedTest(FetcherTest):
         fetcher.unpack(self.unpackdir)
         alt =3D os.path.join(self.unpackdir, 'git/.git/objects/info/alte=
rnates')
         self.assertFalse(os.path.exists(alt))
+
+
+class FetchPremirroronlyLocalTest(FetcherTest):
+
+    def git(self, cmd, cwd=3DNone):
+        if isinstance(cmd, str):
+            cmd =3D 'git ' + cmd
+        else:
+            cmd =3D ['git'] + cmd
+        if cwd is None:
+            cwd =3D self.gitdir
+        return bb.process.run(cmd, cwd=3Dcwd)[0]
+
+    def setUp(self):
+        super(FetchPremirroronlyLocalTest, self).setUp()
+        self.mirrordir =3D os.path.join(self.tempdir, "mirrors")
+        os.mkdir(self.mirrordir)
+        self.reponame =3D "bitbake"
+        self.gitdir =3D os.path.join(self.tempdir, "git", self.reponame)
+        self.recipe_url =3D "git://git.fake.repo/bitbake"
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "1")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".=
format(self.mirrordir) + " \n")
+
+    def make_git_repo(self):
+        self.mirrorname =3D "git2_git.fake.repo.bitbake.tar.gz"
+        recipeurl =3D "git:/git.fake.repo/bitbake"
+        os.makedirs(self.gitdir)
+        self.git("init", self.gitdir)
+        for i in range(0):
+            self.git_new_commit()
+        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrord=
ir, self.mirrorname)), cwd =3D  self.gitdir)
+
+    def git_new_commit(self):
+        import random
+        testfilename =3D "bibake-fetch.test"
+        os.unlink(os.path.join(self.mirrordir, self.mirrorname))
+        with open(os.path.join(self.gitdir, testfilename), "w") as testf=
ile:
+            testfile.write("Useless random data {}".format(random.random=
()))
+        self.git("add {}".format(testfilename), self.gitdir)
+        self.git("commit -a -m \"This random commit {}. I'm useless.\"".=
format(random.random()), self.gitdir)
+        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrord=
ir, self.mirrorname)), cwd =3D  self.gitdir)
+        return self.git("rev-parse HEAD", self.gitdir).strip()
+
+    def test_mirror_commit_nonexistent(self):
+        self.make_git_repo()
+        self.d.setVar("SRCREV", "0"*40)
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        if hasattr(bb.fetch2, "MirrorException"):
+            with self.assertRaises(bb.fetch2.MirrorException):
+                fetcher.download()
+        else:
+            fetcher.download()
+
+    def test_mirror_commit_exists(self):
+        self.make_git_repo()
+        self.d.setVar("SRCREV", self.git_new_commit())
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+    def test_mirror_tarball_nonexistent(self):
+        self.d.setVar("SRCREV", "0"*40)
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        if hasattr(bb.fetch2, "MirrorException"):
+            with self.assertRaises(bb.fetch2.MirrorException):
+                fetcher.download()
+        else:
+            fetcher.download()
+
--=20
2.34.1


