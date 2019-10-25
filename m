Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 1B1977FA63
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 08:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2F4779C0365;
	Fri, 25 Oct 2019 04:39:36 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 0lS1dLJP5Lj4; Fri, 25 Oct 2019 04:39:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6B2499C0325;
	Fri, 25 Oct 2019 04:39:35 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id JthCatWFglWK; Fri, 25 Oct 2019 04:39:35 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9828B9C0365;
	Fri, 25 Oct 2019 04:39:34 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Oct 2019 10:39:25 +0200
Message-Id: <20191025083925.14535-4-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [RFC][PATCH v2 3/3] tests/fetch.py: add npm tests
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Oct 2019 08:39:35 -0000
Content-Transfer-Encoding: quoted-printable

This commit adds some basic tests for the npm fetcher.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/tests/fetch.py | 82 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a0b656b6..781226d2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1988,3 +1988,85 @@ class GitLfsTest(FetcherTest):
         ud.method._find_git_lfs =3D lambda d: False
         shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
         fetcher.unpack(self.d.getVar('WORKDIR'))
+
+class NPMTest(FetcherTest):
+    def skipIfNoNpm():
+        import shutil
+        if not shutil.which('npm'):
+            return unittest.skip('npm not installed, tests being skipped=
')
+        return lambda f: f
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm(self):
+        url =3D 'npm://registry.npmjs.org;name=3D@savoirfairelinux/node-=
server-example;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        unpackdir =3D os.path.join(self.unpackdir, 'npm')
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.=
json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_registry_alternate(self):
+        url =3D 'npm://registry.freajs.org;name=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        unpackdir =3D os.path.join(self.unpackdir, 'npm')
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.=
json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_version_latest(self):
+        url =3D 'npm://registry.npmjs.org;name=3D@savoirfairelinux/node-=
server-example;version=3Dlatest'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        unpackdir =3D os.path.join(self.unpackdir, 'npm')
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.=
json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_registry_invalid(self):
+        url =3D 'npm://registry.invalid.org;name=3D@savoirfairelinux/nod=
e-server-example;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_name_invalid(self):
+        url =3D 'npm://registry.npmjs.org;name=3D@savoirfairelinux/inval=
id;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_version_invalid(self):
+        url =3D 'npm://registry.npmjs.org;name=3D@savoirfairelinux/node-=
server-example;version=3Dinvalid'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_registry_none(self):
+        url =3D 'npm://;name=3D@savoirfairelinux/node-server-example;ver=
sion=3D1.0.0'
+        with self.assertRaises(bb.fetch2.MalformedUrl):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_name_none(self):
+        url =3D 'npm://registry.npmjs.org;version=3D1.0.0'
+        with self.assertRaises(AttributeError):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_version_none(self):
+        url =3D 'npm://registry.npmjs.org;name=3D@savoirfairelinux/node-=
server-example'
+        with self.assertRaises(AttributeError):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
--=20
2.20.1


