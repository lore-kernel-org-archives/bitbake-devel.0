Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 292177FE1D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 17:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4DE379C02D7;
	Fri, 24 Jan 2020 12:08:32 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id ZUl6m--sJXdj; Fri, 24 Jan 2020 12:08:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2267A9C02EE;
	Fri, 24 Jan 2020 12:08:31 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id e2mXbwBdw_tf; Fri, 24 Jan 2020 12:08:30 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 10FC59C02F3;
	Fri, 24 Jan 2020 12:08:29 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2020 18:08:12 +0100
Message-Id: <20200124170814.20510-11-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, rennes-dev@savoirfairelinux.com
Subject: [PATCH v6 10/12] tests/fetch: add npm tests
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
X-List-Received-Date: Fri, 24 Jan 2020 17:08:31 -0000
Content-Transfer-Encoding: quoted-printable

This commit adds some tests to validate the npm fetcher:

     - bb.tests.fetch.NPMTest.test_npm
     - bb.tests.fetch.NPMTest.test_npm_bad_checksum
     - bb.tests.fetch.NPMTest.test_npm_destsuffix_downloadfilename
     - bb.tests.fetch.NPMTest.test_npm_mirrors
     - bb.tests.fetch.NPMTest.test_npm_no_network_no_tarball
     - bb.tests.fetch.NPMTest.test_npm_no_network_with_tarball
     - bb.tests.fetch.NPMTest.test_npm_package_invalid
     - bb.tests.fetch.NPMTest.test_npm_package_none
     - bb.tests.fetch.NPMTest.test_npm_premirrors
     - bb.tests.fetch.NPMTest.test_npm_registry_alternate
     - bb.tests.fetch.NPMTest.test_npm_registry_invalid
     - bb.tests.fetch.NPMTest.test_npm_registry_none
     - bb.tests.fetch.NPMTest.test_npm_version_invalid
     - bb.tests.fetch.NPMTest.test_npm_version_latest
     - bb.tests.fetch.NPMTest.test_npm_version_none

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/tests/fetch.py | 183 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index fa0c5c5a..5eeb64c5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2037,3 +2037,186 @@ class GitLfsTest(FetcherTest):
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
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        ud =3D fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+        self.assertTrue(os.path.exists(ud.localpath + '.done'))
+        self.assertTrue(os.path.exists(ud.resolvefile))
+        fetcher.unpack(self.unpackdir)
+        unpackdir =3D os.path.join(self.unpackdir, 'npm')
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.=
json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_bad_checksum(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
+        # Fetch once to get a tarball
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        ud =3D fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+        # Modify the tarball
+        bad =3D b'bad checksum'
+        with open(ud.localpath, 'wb') as f:
+            f.write(bad)
+        # Verify that the tarball is fetched again
+        fetcher.download()
+        badsum =3D hashlib.sha512(bad).hexdigest()
+        self.assertTrue(os.path.exists(ud.localpath + '_bad-checksum_' +=
 badsum))
+        self.assertTrue(os.path.exists(ud.localpath))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_premirrors(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
+        # Fetch once to get a tarball
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        ud =3D fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+        # Setup the mirror
+        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        bb.utils.mkdirhier(mirrordir)
+        os.replace(ud.localpath, os.path.join(mirrordir, os.path.basenam=
e(ud.localpath)))
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/\n' % mir=
rordir)
+        self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+        # Fetch again
+        self.assertFalse(os.path.exists(ud.localpath))
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_mirrors(self):
+        # Fetch once to get a tarball
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        ud =3D fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+        # Setup the mirror
+        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        bb.utils.mkdirhier(mirrordir)
+        os.replace(ud.localpath, os.path.join(mirrordir, os.path.basenam=
e(ud.localpath)))
+        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/\n' % mirror=
dir)
+        # Update the resolved url to an invalid url
+        with open(ud.resolvefile, 'r') as f:
+            url =3D f.read()
+        uri =3D URI(url)
+        uri.path =3D '/invalid'
+        with open(ud.resolvefile, 'w') as f:
+            f.write(str(uri))
+        # Fetch again
+        self.assertFalse(os.path.exists(ud.localpath))
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_destsuffix_downloadfilename(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3D=
foo-bar.tgz'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'foo-bar=
.tgz')))
+        fetcher.unpack(self.unpackdir)
+        unpackdir =3D os.path.join(self.unpackdir, 'foo', 'bar')
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.=
json')))
+
+    def test_npm_no_network_no_tarball(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
+        self.d.setVar('BB_NO_NETWORK', '1')
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_no_network_with_tarball(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
+        # Fetch once to get a tarball
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Disable network access
+        self.d.setVar('BB_NO_NETWORK', '1')
+        # Fetch again
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        unpackdir =3D os.path.join(self.unpackdir, 'npm')
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.=
json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_registry_alternate(self):
+        url =3D 'npm://registry.freajs.org;package=3D@savoirfairelinux/n=
ode-server-example;version=3D1.0.0'
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
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dlatest'
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
+        url =3D 'npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_package_invalid(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0'
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_version_invalid(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid'
+        with self.assertRaises(bb.fetch2.ParameterError):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_registry_none(self):
+        url =3D 'npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0'
+        with self.assertRaises(bb.fetch2.MalformedUrl):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_package_none(self):
+        url =3D 'npm://registry.npmjs.org;version=3D1.0.0'
+        with self.assertRaises(bb.fetch2.MissingParameterError):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_version_none(self):
+        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example'
+        with self.assertRaises(bb.fetch2.MissingParameterError):
+            fetcher =3D bb.fetch.Fetch([url], self.d)
--=20
2.20.1


