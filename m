Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 162367FA2E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0F88E9C0453;
	Fri, 17 Jan 2020 11:46:08 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id KqzmBhM6fHCU; Fri, 17 Jan 2020 11:46:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B19229C0476;
	Fri, 17 Jan 2020 11:46:06 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id Tq05usHYi54H; Fri, 17 Jan 2020 11:46:06 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CF9EC9C0472;
	Fri, 17 Jan 2020 11:46:05 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:48 +0100
Message-Id: <20200117164548.28453-13-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 12/12] bitbake: tests/fetch: add npmsw tests
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:10 -0000
Content-Transfer-Encoding: quoted-printable

This commit adds some tests to validate the npmsw fetcher:

     - bb.tests.fetch.NPMTest.test_npmsw
     - bb.tests.fetch.NPMTest.test_npmsw_bad_checksum
     - bb.tests.fetch.NPMTest.test_npmsw_destsuffix
     - bb.tests.fetch.NPMTest.test_npmsw_dev
     - bb.tests.fetch.NPMTest.test_npmsw_mirrors
     - bb.tests.fetch.NPMTest.test_npmsw_no_network_no_tarball
     - bb.tests.fetch.NPMTest.test_npmsw_no_network_with_tarball
     - bb.tests.fetch.NPMTest.test_npmsw_npm_reusability
     - bb.tests.fetch.NPMTest.test_npmsw_premirrors

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/tests/fetch.py | 251 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e88eaa7e..f33c4c0b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2191,3 +2191,254 @@ class NPMTest(FetcherTest):
         url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example'
         with self.assertRaises(bb.fetch2.MissingParameterError):
             fetcher =3D bb.fetch.Fetch([url], self.d)
+
+    def create_shrinkwrap_file(self, data):
+        import json
+        datadir =3D os.path.join(self.tempdir, 'data')
+        swfile =3D os.path.join(datadir, 'npm-shrinkwrap.json')
+        bb.utils.mkdirhier(datadir)
+        with open(swfile, 'w') as f:
+            json.dump(data, f)
+        # Also configure the S directory
+        self.sdir =3D os.path.join(self.unpackdir, 'S')
+        self.d.setVar('S', self.sdir)
+        return swfile
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw(self):
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D',
+                    'dependencies': {
+                        'content-type': {
+                            'version': 'https://registry.npmjs.org/conte=
nt-type/-/content-type-1.0.4.tgz',
+                            'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwO=
Aps4mk2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
+                            'dependencies': {
+                                'cookie': {
+                                    'version': 'git+https://github.com/j=
shttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09',
+                                    'from': 'git+https://github.com/jsht=
tp/cookie.git'
+                                }
+                            }
+                        }
+                    }
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', =
'array-flatten-1.1.1.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', =
'content-type-1.0.4.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', =
'github.com.jshttp.cookie.git')))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'npm-shri=
nkwrap.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_mod=
ules', 'array-flatten', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_mod=
ules', 'array-flatten', 'node_modules', 'content-type', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_mod=
ules', 'array-flatten', 'node_modules', 'content-type', 'node_modules', '=
cookie', 'package.json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_dev(self):
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                },
+                'content-type': {
+                    'version': '1.0.4',
+                    'resolved': 'https://registry.npmjs.org/content-type=
/-/content-type-1.0.4.tgz',
+                    'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Z=
ob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
+                    'dev': True
+                }
+            }
+        })
+        # Fetch with dev disabled
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', =
'array-flatten-1.1.1.tgz')))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2',=
 'content-type-1.0.4.tgz')))
+        # Fetch with dev enabled
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile + ';dev=3D1'], s=
elf.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', =
'array-flatten-1.1.1.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', =
'content-type-1.0.4.tgz')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_destsuffix(self):
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile + ';destsuffix=3D=
foo/bar'], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo=
', 'bar', 'node_modules', 'array-flatten', 'package.json')))
+
+    def test_npmsw_no_network_no_tarball(self):
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        self.d.setVar('BB_NO_NETWORK', '1')
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_no_network_with_tarball(self):
+        # Fetch once to get a tarball
+        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3D=
array-flatten;version=3D1.1.1'], self.d)
+        fetcher.download()
+        # Disable network access
+        self.d.setVar('BB_NO_NETWORK', '1')
+        # Fetch again
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_mod=
ules', 'array-flatten', 'package.json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_npm_reusability(self):
+        # Fetch once with npmsw
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        # Disable network access
+        self.d.setVar('BB_NO_NETWORK', '1')
+        # Fetch again with npm
+        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3D=
array-flatten;version=3D1.1.1'], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm=
', 'package.json')))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_bad_checksum(self):
+        # Try to fetch with bad checksum
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-gfNEp2hqgLTFKT6P3AsBYMgsBqg=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+        # Fetch correctly to get a tarball
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        localpath =3D os.path.join(self.dldir, 'npm2', 'array-flatten-1.=
1.1.tgz')
+        self.assertTrue(os.path.exists(localpath))
+        # Modify the tarball
+        bad =3D b'bad checksum'
+        with open(localpath, 'wb') as f:
+            f.write(bad)
+        # Verify that the tarball is fetched again
+        fetcher.download()
+        badsum =3D hashlib.sha1(bad).hexdigest()
+        self.assertTrue(os.path.exists(localpath + '_bad-checksum_' + ba=
dsum))
+        self.assertTrue(os.path.exists(localpath))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_premirrors(self):
+        # Fetch once to get a tarball
+        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3D=
array-flatten;version=3D1.1.1'], self.d)
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
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatte=
n/-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_mirrors(self):
+        # Fetch once to get a tarball
+        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3D=
array-flatten;version=3D1.1.1'], self.d)
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
+        # Fetch again with invalid url
+        self.assertFalse(os.path.exists(ud.localpath))
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
+                'array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://invalid',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                }
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
--=20
2.20.1


