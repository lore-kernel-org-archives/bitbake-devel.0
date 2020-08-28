Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web12.1813.1598641602335098523
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2020 12:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: sandra.tobajas@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EFAFF9C0296
	for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2020 15:06:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T5UIPdDQ7cNO; Fri, 28 Aug 2020 15:06:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 499499C02A2;
	Fri, 28 Aug 2020 15:06:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oEavYxAEBnoR; Fri, 28 Aug 2020 15:06:40 -0400 (EDT)
Received: from localhost.localdomain (modemcable244.108-163-184.mc.videotron.ca [184.163.108.244])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 21FAA9C0296;
	Fri, 28 Aug 2020 15:06:40 -0400 (EDT)
From: "Sandra Tobajas" <sandra.tobajas@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>
Subject: [bitbake-devel][PATCH v2] bitbake: fetch2/npm: allow to build npm package with no dependency
Date: Fri, 28 Aug 2020 15:06:35 -0400
Message-Id: <20200828190635.3393373-1-sandra.tobajas@savoirfairelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the case of an empty npm-shrinkwrap.json file (with no dependency),
the npmsw fetcher was causing a RecursionError reported in [1].

It also happened if the package has only "dev" dependencies and was built
without --npm-dev option.

Add sanity checks to ensure that the dependency list is not empty and set
the urldata proxy attribute to None if no dependency is found.

Add bb.tests.fetch.NPMTest.test_npmsw_nodeps unit test to ensure that a
npm package without dependency can be built.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13901.

Signed-off-by: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>
---
 bitbake/lib/bb/fetch2/npmsw.py | 16 ++++++++++------
 bitbake/lib/bb/tests/fetch.py  | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
index 0c3511d8ab..e06719f45b 100644
--- a/bitbake/lib/bb/fetch2/npmsw.py
+++ b/bitbake/lib/bb/fetch2/npmsw.py
@@ -177,17 +177,21 @@ class NpmShrinkWrap(FetchMethod):
         # This fetcher resolves multiple URIs from a shrinkwrap file and=
 then
         # forwards it to a proxy fetcher. The management of the donestam=
p file,
         # the lockfile and the checksums are forwarded to the proxy fetc=
her.
-        ud.proxy =3D Fetch([dep["url"] for dep in ud.deps], data)
+        if ud.deps:
+            ud.proxy =3D Fetch([dep["url"] for dep in ud.deps], data)
+        else:
+            ud.proxy =3D None
         ud.needdonestamp =3D False
=20
     @staticmethod
     def _foreach_proxy_method(ud, handle):
         returns =3D []
-        for proxy_url in ud.proxy.urls:
-            proxy_ud =3D ud.proxy.ud[proxy_url]
-            proxy_d =3D ud.proxy.d
-            proxy_ud.setup_localpath(proxy_d)
-            returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+        if ud and ud.proxy:
+            for proxy_url in ud.proxy.urls:
+                proxy_ud =3D ud.proxy.ud[proxy_url]
+                proxy_d =3D ud.proxy.d
+                proxy_ud.setup_localpath(proxy_d)
+                returns.append(handle(proxy_ud.method, proxy_ud, proxy_d=
))
         return returns
=20
     def verify_donestamp(self, ud, d):
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 13561cea9b..6251f1607a 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2308,6 +2308,26 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_mod=
ules', 'array-flatten', 'node_modules', 'content-type', 'package.json')))
         self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_mod=
ules', 'array-flatten', 'node_modules', 'content-type', 'node_modules', '=
cookie', 'package.json')))
=20
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_nodeps(self):
+        swfile =3D self.create_shrinkwrap_file({
+            'dependencies': {
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
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2',=
 'content-type-1.0.4.tgz')))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'npm-shri=
nkwrap.json')))
+
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
--=20
2.25.1

