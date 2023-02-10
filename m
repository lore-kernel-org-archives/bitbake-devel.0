Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8237C05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 13:39:55 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by mx.groups.io with SMTP id smtpd.web11.14545.1676036390875516840
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Feb 2023 05:39:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=m/0ej24P;
 spf=pass (domain: myneves.com, ip: 185.70.40.18, mailfrom: paulo@myneves.com)
Date: Fri, 10 Feb 2023 13:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676036389; x=1676295589;
	bh=czVpG46lY1GrlnQ034Q45SgYoLYdlSOAzJs+ZgGrK0U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m/0ej24PqtbK4NPmlHtXLa8RGGEbzTbCf+LqBW+iNYkc+sdIhs0AfYNg1P4wMHrQ8
	 cCJdu+piLIog0rkTnq6HmuXXC8MaE87ry6Hol0lAdXxD179scL/yfUFhCeXfzReay1
	 4klla8eeqjk+8HGpHBEgqdWL9toA+txHM1tH89GU01cI+ePY4gBayuU4J3MSWP6RUq
	 IK1xYVvOL65PVamJnImJmVc7O906ym1M+pnOCgBlHQ+V2v7qyyXueJjZ49g4BMxx5T
	 EvNQk4NGz+3AA8DwyqlGChhzne323u2RHuG3XUf+O6piEMN3qTprsPYJqUd3Grod2d
	 01iiYA2FsYluA==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 3/3] tests: Make sure test_lfs_enabled is ran with git lfs available
Message-ID: <20230210133921.1268885-3-paulo@myneves.com>
In-Reply-To: <20230210133921.1268885-1-paulo@myneves.com>
References: <20230210133921.1268885-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Feb 2023 13:39:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14393

If git lfs does not exist in the host the test does not run all
the code paths possible, thus is not reproducile

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/tests/fetch.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a9ad247d9..9b18f159d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2243,13 +2243,12 @@ class GitLfsTest(FetcherTest):
         # we know whether git-lfs is installed.
         fetcher, ud =3D self.fetch(uri=3DNone, download=3DFalse)
         self.assertIsNotNone(ud.method._find_git_lfs)
+        self.assertTrue(ud.method._find_git_lfs(self.d),
+                msg=3D"git-lfs not found. Cannot test git-lfs without git-=
lfs in the PATH")

-        # If git-lfs can be found, the unpack should be successful. Only
-        # attempt this with the real live copy of git-lfs installed.
-        if ud.method._find_git_lfs(self.d):
-            fetcher.download()
-            shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
+        fetcher.download()
+        shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
+        fetcher.unpack(self.d.getVar('WORKDIR'))

         # If git-lfs cannot be found, the unpack should throw an error
         with self.assertRaises(bb.fetch2.FetchError):
--
2.34.1



