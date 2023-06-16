Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56CEB64D8
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.7325.1686919106507514709
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:38:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C53B1FB;
	Fri, 16 Jun 2023 05:39:10 -0700 (PDT)
Received: from e125920.arm.com (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BAE3F71E;
	Fri, 16 Jun 2023 05:38:25 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 4/5] bitbake: tests: Use assertLogs to test logging output
Date: Fri, 16 Jun 2023 13:36:50 +0100
Message-Id: <20230616123651.915234-5-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616123651.915234-1-peter.hoyes@arm.com>
References: <20230616123651.915234-1-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:38:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14842

From: Peter Hoyes <Peter.Hoyes@arm.com>

By default, pytest captures all stdout and exposes it using its built-in
fixtures (capsys, caplog etc), so stdout does not support getvalue().

To support running tests using both unittest and pytest, use assertLogs
to capture logging and assert on the log output instead.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
---
 bitbake/lib/bb/tests/fetch.py |  6 +++---
 bitbake/lib/bb/tests/parse.py | 16 +++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 8ca7e6c155..20593764fd 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -3183,7 +3183,7 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
         import sys
         self.d.setVar("SRCREV", "0"*40)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs() =
as logs:
             fetcher.download()
-        stdout =3D sys.stdout.getvalue()
-        self.assertFalse(" not a git repository (or any parent up to mou=
nt point /)" in stdout)
+        output =3D "".join(logs.output)
+        self.assertFalse(" not a git repository (or any parent up to mou=
nt point /)" in output)
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.p=
y
index a3165d95bd..304bbbe222 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -186,14 +186,16 @@ deltask ${EMPTYVAR}
 """
     def test_parse_addtask_deltask(self):
         import sys
-        f =3D self.parsehelper(self.addtask_deltask)
-        d =3D bb.parse.handle(f.name, self.d)['']
=20
-        stdout =3D sys.stdout.getvalue()
-        self.assertTrue("addtask contained multiple 'before' keywords" i=
n stdout)
-        self.assertTrue("addtask contained multiple 'after' keywords" in=
 stdout)
-        self.assertTrue('addtask ignored: " do_patch"' in stdout)
-        #self.assertTrue('dependent task do_foo for do_patch does not ex=
ist' in stdout)
+        with self.assertLogs() as logs:
+            f =3D self.parsehelper(self.addtask_deltask)
+            d =3D bb.parse.handle(f.name, self.d)['']
+
+        output =3D "".join(logs.output)
+        self.assertTrue("addtask contained multiple 'before' keywords" i=
n output)
+        self.assertTrue("addtask contained multiple 'after' keywords" in=
 output)
+        self.assertTrue('addtask ignored: " do_patch"' in output)
+        #self.assertTrue('dependent task do_foo for do_patch does not ex=
ist' in output)
=20
     broken_multiline_comment =3D """
 # First line of comment \\
--=20
2.34.1


