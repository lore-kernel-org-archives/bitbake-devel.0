Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB4C4332F
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 12:50:32 +0000 (UTC)
Received: from forward107p.mail.yandex.net (forward107p.mail.yandex.net
 [77.88.28.115])
 by mx.groups.io with SMTP id smtpd.web11.21502.1644238230600435919
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 04:50:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@zhukoff.net
 header.s=mail header.b=wlatkXis;
 spf=pass (domain: zhukoff.net, ip: 77.88.28.115, mailfrom: pavel@zhukoff.net)
Received: from myt5-da0aad1c0099.qloud-c.yandex.net
 (myt5-da0aad1c0099.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:570c:0:640:da0a:ad1c])
	by forward107p.mail.yandex.net (Yandex) with ESMTP id BC3BF556DD2D;
	Mon,  7 Feb 2022 15:50:27 +0300 (MSK)
Received: from myt6-265321db07ea.qloud-c.yandex.net
 (myt6-265321db07ea.qloud-c.yandex.net [2a02:6b8:c12:2626:0:640:2653:21db])
	by myt5-da0aad1c0099.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 gFnqSVoVBq-oRcW3IKJ;
	Mon, 07 Feb 2022 15:50:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; s=mail;
 t=1644238227;
	bh=zvroUh/rRVMmE9O29UHpUx87u2E60nGeEiIRugJKDhk=;
	h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
	b=wlatkXisAKPnjUlwTNlVzDYfU3fwaraNEAf1XSr10RPpMEnsiIgEtv+x15AMEfnGa
	 cM6LAI66Cadw9OaY3M6wqKCReIeR/jWdfpU/2KHQUPQOdDBitZFwNPOpr6AEsgv6RO
	 9+ky0kC1OuZRMnvBDOJohejuvr4nsAL6CMq6ktGg=
Authentication-Results: myt5-da0aad1c0099.qloud-c.yandex.net;
 dkim=pass header.i=@zhukoff.net
Received: by myt6-265321db07ea.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id dG7iDxzkq1-oQHKAVll;
	Mon, 07 Feb 2022 15:50:26 +0300
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Fwd: 2
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH v3] fetch: Use git rev-parse if network is not available
Date: Mon,  7 Feb 2022 13:50:19 +0100
Message-Id: <20220207125018.2894-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: 
 <803e4c5c9ffe5b8a347826aa4cf86e979ebe54d0.camel@linuxfoundation.org>
References: 
 <803e4c5c9ffe5b8a347826aa4cf86e979ebe54d0.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Feb 2022 12:50:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13321

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
 lib/bb/fetch2/git.py  | 62 +++++++++++++++++++++++++++++++++----------
 lib/bb/tests/fetch.py | 44 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 30da8e95..490dcaf4 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -118,10 +118,15 @@ class Git(FetchMethod):
     bitbake_dir =3D os.path.abspath(os.path.join(os.path.dirname(os.path=
.join(os.path.abspath(__file__))), '..', '..', '..'))
     make_shallow_path =3D os.path.join(bitbake_dir, 'bin', 'git-make-sha=
llow')
=20
+    sha1_pattern =3D re.compile(r'\b[0-9a-fA-F]{40}\b')
+
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
         pass
=20
+    def _is_sha1(self, name):
+        return len(name) =3D=3D 40 and re.match(self.sha1_pattern, name)
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
@@ -135,6 +140,8 @@ class Git(FetchMethod):
         """
         init git specific variable within url data
         so that the git method like latest_revision() can work
+        NOTE: This function may be called from do_unpack and in that cas=
e network is not available
+        avoid using network operations here or guard them properly.
         """
         if 'protocol' in ud.parm:
             ud.proto =3D ud.parm['protocol']
@@ -248,28 +255,33 @@ class Git(FetchMethod):
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
@@ -697,6 +709,14 @@ class Git(FetchMethod):
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
@@ -727,6 +747,20 @@ class Git(FetchMethod):
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
index ec7d83c9..f7f847dd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2776,3 +2776,47 @@ class GitSharedTest(FetcherTest):
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
+        # emulate do_fetch followed by do_unpack
+        self.setData()
+        bb.fetch.fetcher_init(self.d)
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        ## emulate do_unpack (disable network) withot previous fetch
+        self.d.setVar("BB_NO_NETWORK", "1")
+        bb.fetch.fetcher_init(self.d)
+        unpacker =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        unpacker.unpack(self.unpackdir)
+
+    @skipIfNoNetwork()
+    def test_unpack_rebaseable(self):
+        self.setData()
+        self.recipe_url +=3D "rebaseable=3D1;"
+
+        bb.fetch.fetcher_init(self.d)
+        fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+
+        ## emulate do_unpack (disable network)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        bb.fetch.fetcher_init(self.d)
+        with self.assertRaises(bb.fetch2.UnpackError):
+            unpacker =3D bb.fetch.Fetch([self.recipe_url], self.d)
+            fetcher.unpack()
--=20
2.34.1


