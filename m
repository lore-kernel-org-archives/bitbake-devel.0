Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3EC636D6
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 17:00:35 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.web11.11712.1676653229564130668
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 09:00:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=WTUdqrII;
 spf=pass (domain: myneves.com, ip: 185.70.43.23, mailfrom: paulo@myneves.com)
Date: Fri, 17 Feb 2023 17:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676653227; x=1676912427;
	bh=B4QxJYOBZ83ED7NjutyYOcTTHtptQViXkiWz5HnE97w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WTUdqrIIm2eqq8PARc76sqZIvBNN/7vCP2yGfdNRG77Nk03U49+WFMlwca+xwKAhk
	 guu+Rz+ZHJTh30cHTSnLc5hlSceqfBNtnusEGxLYQjyzogL5K8jUJBNxhDQrPZxbvM
	 fs+2Vd/NjKd13pEFpQhusFT9Hxnf3AO2I+T32cBBfhOqcWxcRVAhv5HahCg9/Jwlj4
	 3hkj44HXIduh6A3vEB83CN1h0fX0s+h0HOr/OcI/pSgGgQfNxZVstns9HHH08TWaNf
	 uzIilRTmuml/yIXDD+yBo2g8OCaKH4zLNoX361nl7CugANx0ZNv/c7zGaMFSCKlwlV
	 9wDuIsTFTH0ZA==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 1/5] tests: git-lfs: Restore _find_git_lfs
Message-ID: <20230217170009.58707-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 17:00:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14460

Not restoring the mocked _find_git_lfs leads to other tests
failing.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/tests/fetch.py | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f3890321d..6d16cf59a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2250,12 +2250,16 @@ class GitLfsTest(FetcherTest):
             shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
             fetcher.unpack(self.d.getVar('WORKDIR'))

-        # If git-lfs cannot be found, the unpack should throw an error
-        with self.assertRaises(bb.fetch2.FetchError):
-            fetcher.download()
-            ud.method._find_git_lfs =3D lambda d: False
-            shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
+        old_find_git_lfs =3D ud.method._find_git_lfs
+        try:
+            # If git-lfs cannot be found, the unpack should throw an error
+            with self.assertRaises(bb.fetch2.FetchError):
+                fetcher.download()
+                ud.method._find_git_lfs =3D lambda d: False
+                shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
+                fetcher.unpack(self.d.getVar('WORKDIR'))
+        finally:
+            ud.method._find_git_lfs =3D old_find_git_lfs

     def test_lfs_disabled(self):
         import shutil
@@ -2270,17 +2274,21 @@ class GitLfsTest(FetcherTest):
         fetcher, ud =3D self.fetch()
         self.assertIsNotNone(ud.method._find_git_lfs)

-        # If git-lfs can be found, the unpack should be successful. A
-        # live copy of git-lfs is not required for this case, so
-        # unconditionally forge its presence.
-        ud.method._find_git_lfs =3D lambda d: True
-        shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
-        fetcher.unpack(self.d.getVar('WORKDIR'))
+        old_find_git_lfs =3D ud.method._find_git_lfs
+        try:
+            # If git-lfs can be found, the unpack should be successful. A
+            # live copy of git-lfs is not required for this case, so
+            # unconditionally forge its presence.
+            ud.method._find_git_lfs =3D lambda d: True
+            shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
+            # If git-lfs cannot be found, the unpack should be successful

-        # If git-lfs cannot be found, the unpack should be successful
-        ud.method._find_git_lfs =3D lambda d: False
-        shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
-        fetcher.unpack(self.d.getVar('WORKDIR'))
+            ud.method._find_git_lfs =3D lambda d: False
+            shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
+        finally:
+            ud.method._find_git_lfs =3D old_find_git_lfs

 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls =3D {
--
2.34.1



