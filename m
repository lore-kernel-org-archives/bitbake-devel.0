Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B04C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 11:54:19 +0000 (UTC)
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net
 [5.45.198.246])
 by mx.groups.io with SMTP id smtpd.web10.21207.1644234857360430316
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 03:54:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@zhukoff.net
 header.s=mail header.b=jr2F7VXq;
 spf=pass (domain: zhukoff.net, ip: 5.45.198.246, mailfrom: pavel@zhukoff.net)
Received: from iva5-76c5c16f2a53.qloud-c.yandex.net
 (iva5-76c5c16f2a53.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:7bae:0:640:76c5:c16f])
	by forward103j.mail.yandex.net (Yandex) with ESMTP id 5969F100F87;
	Mon,  7 Feb 2022 14:54:13 +0300 (MSK)
Received: from iva1-dcde80888020.qloud-c.yandex.net
 (iva1-dcde80888020.qloud-c.yandex.net [2a02:6b8:c0c:7695:0:640:dcde:8088])
	by iva5-76c5c16f2a53.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 fTw8HBXthv-sDcmmG3s;
	Mon, 07 Feb 2022 14:54:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; s=mail;
 t=1644234853;
	bh=SfXQHRTJc6jWa2bwAY81YdRpz1b9EEDeMFKFO89+F18=;
	h=Date:Subject:To:From:Message-Id:Cc;
	b=jr2F7VXq48BsCudVruzS0Ezf3dwpTCpTOwuiJTZTBGUkRe//t2t3ZIJNsPK/u1vQE
	 5E3dOFF6rL3TXZYd4Kdj5Asj1IDQ3aG91GfvbJPYgn1EMQaUKvxlrR6MjnCZ6tpQZl
	 ZsuOKQJ8qK59u+AQSM0BBbheKGT8cITYq7kzSIWA=
Authentication-Results: iva5-76c5c16f2a53.qloud-c.yandex.net;
 dkim=pass header.i=@zhukoff.net
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id Gx9x2MIwvS-sCHqAuJM;
	Mon, 07 Feb 2022 14:54:12 +0300
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Fwd: 2
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH] fetch: Use git rev-parse if network is not available
Date: Mon,  7 Feb 2022 12:53:23 +0100
Message-Id: <20220207115322.28209-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Feb 2022 11:54:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13317

Sometimes Fetcher is initialized while network is disabled (unpack() is
one of such cases) and Fetcher fails to map non SHA1 SRCREV to SHA1 one.
In such cases git ls-remote cannot be used to determinate latest
revision and git rev-parse can be used instead. This approach doesn't
work with rebaseable repos so exception will occur for such repos.

See [YOCTO #14707] for more details. Note: the issue doesn't occur each
time in unpack() because in normal flow (fetch->unpack in one build)
URI_HEADREVs are cached.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/git.py  | 61 +++++++++++++++++++++++++++++++++----------
 lib/bb/tests/fetch.py | 43 ++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 30da8e95..5f56d9fe 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -122,6 +122,10 @@ class Git(FetchMethod):
     def init(self, d):
         pass
=20
+    @staticmethod
+    def _is_sha1(name):
+        return len(name) =3D=3D 40  and (True in [c in "abcdef0123456789=
" for c in name])
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
@@ -135,6 +139,8 @@ class Git(FetchMethod):
         """
         init git specific variable within url data
         so that the git method like latest_revision() can work
+        NOTE: This function may be called from do_unpack and in that cas=
e network is not available
+        avoid using network operations here or guard them properly.
         """
         if 'protocol' in ud.parm:
             ud.proto =3D ud.parm['protocol']
@@ -248,28 +254,33 @@ class Git(FetchMethod):
=20
         ud.setup_revisions(d)
=20
-        for name in ud.names:
-            # Ensure anything that doesn't look like a sha256 checksum/r=
evision is translated into one
-            if not ud.revisions[name] or len(ud.revisions[name]) !=3D 40=
  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
-                if ud.revisions[name]:
-                    ud.unresolvedrev[name] =3D ud.revisions[name]
-                ud.revisions[name] =3D self.latest_revision(ud, d, name)
-
         gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.repl=
ace('/', '.').replace('*', '.').replace(' ','_'))
         if gitsrcname.startswith('.'):
             gitsrcname =3D gitsrcname[1:]
=20
-        # for rebaseable git repo, it is necessary to keep mirror tar ba=
ll
-        # per revision, so that even the revision disappears from the
-        # upstream repo in the future, the mirror will remain intact and=
 still
-        # contains the revision
-        if ud.rebaseable:
-            for name in ud.names:
-                gitsrcname =3D gitsrcname + '_' + ud.revisions[name]
=20
         dl_dir =3D d.getVar("DL_DIR")
         gitdir =3D d.getVar("GITDIR") or (dl_dir + "/git2")
+
+
+        ## We need clonedir to be defined before latest_revision call fo=
r unpack routine to use rev-parse instead of ls-remote
         ud.clonedir =3D os.path.join(gitdir, gitsrcname)
+
+        for name in ud.names:
+            # Ensure anything that doesn't look like a sha1 checksum/rev=
ision is translated into one
+            if not ud.revisions[name] or not self._is_sha1(ud.revisions[=
name]):
+                if ud.revisions[name]:
+                    ud.unresolvedrev[name] =3D ud.revisions[name]
+                ud.revisions[name] =3D self.latest_revision(ud, d, name)
+            if ud.rebaseable:
+                # for rebaseable git repo, it is necessary to keep mirro=
r tar ball
+                # per revision, so that even the revision disappears fro=
m the
+                # upstream repo in the future, the mirror will remain in=
tact and still
+                # contains the revision
+                gitsrcname =3D gitsrcname + '_' + ud.revisions[name]
+        if ud.rebaseable:
+            ud.clonedir =3D os.path.join(gitdir, gitsrcname)
+
         ud.localfile =3D ud.clonedir
=20
         mirrortarball =3D 'git2_%s.tar.gz' % gitsrcname
@@ -697,6 +708,14 @@ class Git(FetchMethod):
         slash_re =3D re.compile(r"/+")
         return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unreso=
lvedrev[name]
=20
+    def _revparse(self, ud, d, rev):
+        """
+        Return latest revision (SHA) for the refs specified by branch/ta=
g/etc
+        """
+        cmd =3D '{basecmd} rev-parse -q --verify {rev}'.format(basecmd =3D=
 ud.basecmd, rev =3D rev)
+        output =3D runfetchcmd(cmd, d, quiet=3DTrue, workdir =3D ud.clon=
edir)
+        return output.strip()
+
     def _lsremote(self, ud, d, search):
         """
         Run git ls-remote with the specified search string
@@ -727,6 +746,20 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
+
+        ## Network is not availble and we missed the cache. Try rev-pars=
e
+        if d.getVar("BB_NO_NETWORK"):
+            if ud.rebaseable:
+                raise bb.fetch.UnpackError("Unable to map revision \"{na=
me}\" to SHA1 revision without a network. "  \
+                                           "SHA1 revision must be specif=
ied for rebaseable repos "\
+                                           "or \"BB_SRCREV_POLICY\" set =
to \"cache\". ".format(name=3Dud.unresolvedrev[name]),ud.host+ud.path)
+            rev =3D self._revparse(ud, d, ud.unresolvedrev[name])
+            if rev is None:
+                raise bb.fetch2.FetchError("Unable to resolve '%s' in lo=
cal clone of repository in git rev-parse output for %s" % \
+                                           (ud.unresolvedrev[name], ud.h=
ost+ud.path))
+            return rev
+
+
         output =3D self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other f=
orm
         if ud.unresolvedrev[name][:5] =3D=3D "refs/" or ud.usehead:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ec7d83c9..1fcf3466 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2776,3 +2776,46 @@ class GitSharedTest(FetcherTest):
         fetcher.unpack(self.unpackdir)
         alt =3D os.path.join(self.unpackdir, 'git/.git/objects/info/alte=
rnates')
         self.assertFalse(os.path.exists(alt))
+
+class GitUnpackOfflineTest(FetcherTest):
+
+    def setUp(self):
+        super(GitUnpackOfflineTest, self).setUp()
+        self.tempdir =3D self.tempdir
+        self.persistdir =3D os.path.join(self.tempdir, "persistdata")
+
+    def setData(self):
+        self.recipe_url =3D "git://github.com/lz4/lz4.git;branch=3Drelea=
se;protocol=3Dhttps;"
+        self.d.setVar('SRCREV', 'v1.9.0')
+        self.d.setVar("PERSISTENT_DIR", self.persistdir)
+        self.d.setVar("DL_DIR", self.dldir)
+
+    @skipIfNoNetwork()
+    def test_unpack_offline(self):
+        self.setData()
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        bb.fetch.fetcher_init(self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        ## emulate do_unpack (disable network)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        unpacker =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        bb.fetch.fetcher_init(self.d)
+        unpacker.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_unpack_rebaseable(self):
+        self.setData()
+        self.recipe_url +=3D "rebaseable=3D1;"
+
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        bb.fetch.fetcher_init(self.d)
+        fetcher.download()
+
+        ## emulate do_unpack (disable network)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        with self.assertRaises(bb.fetch2.UnpackError):
+            unpacker =3D bb.fetch.Fetch([self.recipe_url], self.d)
+            bb.fetch.fetcher_init(self.d)
+            fetcher.unpack()
--=20
2.34.1


