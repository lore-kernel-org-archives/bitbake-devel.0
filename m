Received: from MTA-05-4.privateemail.com (MTA-05-4.privateemail.com [198.54.127.60])
 by mx.groups.io with SMTP id smtpd.web10.37978.1601911515165698561
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 08:25:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 198.54.127.60, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-05.privateemail.com (localhost [127.0.0.1])
	by MTA-05.privateemail.com (Postfix) with ESMTP id D32BB6004A;
	Mon,  5 Oct 2020 11:25:14 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.216])
	by MTA-05.privateemail.com (Postfix) with ESMTPA id 01C3C6004C;
	Mon,  5 Oct 2020 15:25:13 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [dunfell][1.46][PATCH 2/2] bitbake: tests/fetch: add unit tests for git SRC_URI with spaces in url
Date: Mon,  5 Oct 2020 16:24:32 +0100
Message-Id: <20201005152432.205556-2-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005152432.205556-1-charles.davies@whitetree.xyz>
References: <20201005152432.205556-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/tests/fetch.py | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 0ecf044f38..5f24918a96 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -223,6 +223,21 @@ class URITest(unittest.TestCase):
             'query': {},
             'relative': False
         },
+        "git://tfs-example.org:22/tfs/example%20path/example.git": {
+            'uri': 'git://tfs-example.org:22/tfs/example%20path/example.=
git',
+            'scheme': 'git',
+            'hostname': 'tfs-example.org',
+            'port': 22,
+            'hostport': 'tfs-example.org:22',
+            'path': '/tfs/example path/example.git',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'query': {},
+            'relative': False
+        },
         "http://somesite.net;someparam=3D1": {
             'uri': 'http://somesite.net;someparam=3D1',
             'scheme': 'http',
@@ -2080,6 +2095,38 @@ class GitLfsTest(FetcherTest):
         shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
         fetcher.unpack(self.d.getVar('WORKDIR'))
=20
+class GitURLWithSpacesTest(FetcherTest):
+    test_git_urls =3D {
+        "git://tfs-example.org:22/tfs/example%20path/example.git" : {
+            'url': 'git://tfs-example.org:22/tfs/example%20path/example.=
git',
+            'gitsrcname': 'tfs-example.org.22.tfs.example_path.example.g=
it',
+            'path': '/tfs/example path/example.git'
+        },
+        "git://tfs-example.org:22/tfs/example%20path/example%20repo.git"=
 : {
+            'url': 'git://tfs-example.org:22/tfs/example%20path/example%=
20repo.git',
+            'gitsrcname': 'tfs-example.org.22.tfs.example_path.example_r=
epo.git',
+            'path': '/tfs/example path/example repo.git'
+        }
+    }
+
+    def test_urls(self):
+
+        # Set fake SRCREV to stop git fetcher from trying to contact non=
-existent git repo
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c4=
0')
+
+        for test_git_url, ref in self.test_git_urls.items():
+
+            fetcher =3D bb.fetch.Fetch([test_git_url], self.d)
+            ud =3D fetcher.ud[fetcher.urls[0]]
+
+            self.assertEqual(ud.url, ref['url'])
+            self.assertEqual(ud.path, ref['path'])
+            self.assertEqual(ud.localfile, os.path.join(self.dldir, "git=
2", ref['gitsrcname']))
+            self.assertEqual(ud.localpath, os.path.join(self.dldir, "git=
2", ref['gitsrcname']))
+            self.assertEqual(ud.lockfile, os.path.join(self.dldir, "git2=
", ref['gitsrcname'] + '.lock'))
+            self.assertEqual(ud.clonedir, os.path.join(self.dldir, "git2=
", ref['gitsrcname']))
+            self.assertEqual(ud.fullmirror, os.path.join(self.dldir, "gi=
t2_" + ref['gitsrcname'] + '.tar.gz'))
+
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
         import shutil
--=20
2.28.0

