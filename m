Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA8CC3DA40
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.7355.1686919104968426625
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:38:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D6821FB;
	Fri, 16 Jun 2023 05:39:08 -0700 (PDT)
Received: from e125920.arm.com (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043E03F71E;
	Fri, 16 Jun 2023 05:38:23 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 3/5] bitbake: tests/fetch: Set git config if not already set
Date: Fri, 16 Jun 2023 13:36:49 +0100
Message-Id: <20230616123651.915234-4-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616123651.915234-1-peter.hoyes@arm.com>
References: <20230616123651.915234-1-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:38:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14841

From: Peter Hoyes <Peter.Hoyes@arm.com>

git config returns an error code if user.email or user.name are not set,
so bb.process.run raises an ExecutionError, failing the test.

Improve the logic by catching the ExectionError and using this to set a
default value.

Change a direct invocation of 'git init' to use self.git_init so that
it follows the code path above.

Remove the related comment from the README now that git sets up the user
details automatically.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
---
 bitbake/README                |  3 +--
 bitbake/lib/bb/tests/fetch.py | 12 +++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/bitbake/README b/bitbake/README
index a5f5c1b64f..bdb1e81dc1 100644
--- a/bitbake/README
+++ b/bitbake/README
@@ -45,8 +45,7 @@ it has so many corner cases. The datastore has many tes=
ts too. Testing with the
 recommended before submitting patches, particularly to the fetcher and d=
atastore. We also
 appreciate new test cases and may require them for more obscure issues.
=20
-To run the tests "zstd" and "git" must be installed. Git must be correct=
ly configured, in
-particular the user.email and user.name values must be set.
+To run the tests "zstd" and "git" must be installed.
=20
 The assumption is made that this testsuite is run from an initialized Op=
enEmbedded build
 environment (i.e. `source oe-init-build-env` is used). If this is not th=
e case, run the
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 871c174e82..8ca7e6c155 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -429,9 +429,15 @@ class FetcherTest(unittest.TestCase):
         # a common setup is to use other default
         # branch than master.
         self.git(['checkout', '-b', 'master'], cwd=3Dcwd)
-        if not self.git(['config', 'user.email'], cwd=3Dcwd):
+
+        try:
+            self.git(['config', 'user.email'], cwd=3Dcwd)
+        except bb.process.ExecutionError:
             self.git(['config', 'user.email', 'you@example.com'], cwd=3D=
cwd)
-        if not self.git(['config', 'user.name'], cwd=3Dcwd):
+
+        try:
+            self.git(['config', 'user.name'], cwd=3Dcwd)
+        except bb.process.ExecutionError:
             self.git(['config', 'user.name', 'Your Name'], cwd=3Dcwd)
=20
 class MirrorUriTest(FetcherTest):
@@ -3038,7 +3044,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         self.mirrorname =3D "git2_git.fake.repo.bitbake.tar.gz"
         recipeurl =3D "git:/git.fake.repo/bitbake"
         os.makedirs(self.gitdir)
-        self.git("init", self.gitdir)
+        self.git_init(cwd=3Dself.gitdir)
         for i in range(0):
             self.git_new_commit()
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrord=
ir, self.mirrorname)), cwd =3D  self.gitdir)
--=20
2.34.1


