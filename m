Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129BDC636D4
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 13:39:46 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by mx.groups.io with SMTP id smtpd.web11.14536.1676036378903985717
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Feb 2023 05:39:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=OcLbxt9Z;
 spf=pass (domain: myneves.com, ip: 185.70.43.17, mailfrom: paulo@myneves.com)
Date: Fri, 10 Feb 2023 13:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676036375; x=1676295575;
	bh=xRpanUN3+ZS604yK7epgoSd8VsAiBy9OE8XMTnEZTBE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OcLbxt9ZKw8Nfgeqxj9YYZcTYQ+ExkUhDlXS7d/Tjp6TX068qmc3Gg4hmj268mQOA
	 uD4RID/aYORE8jA4wPCDyrNOV3JzD6j+LH0KkucdnUl5bydH6rI6qkPQlhxt+fgDUG
	 1F76EzEU8gtpeZnQEkekcex0gMLv9i2cNGOmf7h0EzuCf1InqQCgJeGwLBhGoqCPve
	 pL6bOjuAiYG8RrDCjLaCRbLvWJ9hbFEd4d+V4F7UdtIqCW+kzEqT5TIPuVaYlvW1ji
	 VK3cMnTSYFgVy6ZZPuYWWk1pnzZGaVxBfd8jGdksCJpy2EyXZuZcZdBYRG8sdYHMRe
	 VwQ4PRFo9r31A==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 1/3] tests: Remove redundant lfs=1 URI paramter
Message-ID: <20230210133921.1268885-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Feb 2023 13:39:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14391

lfs=3D1 is assumed unless explicitly disabled with lfs=3D0
This way we test the implicit case, which is also the
default for most users.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f3890321d..122d7e05f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2235,7 +2235,7 @@ class GitLfsTest(FetcherTest):
     def test_lfs_enabled(self):
         import shutil

-        uri =3D 'git://%s;protocol=3Dfile;lfs=3D1;branch=3Dmaster' % self.=
srcdir
+        uri =3D 'git://%s;protocol=3Dfile;branch=3Dmaster' % self.srcdir
         self.d.setVar('SRC_URI', uri)

         # Careful: suppress initial attempt at downloading until
--
2.34.1



