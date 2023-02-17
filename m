Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F2C05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 17:01:15 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.web11.11736.1676653269687568188
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 09:01:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=kS0av9DQ;
 spf=pass (domain: myneves.com, ip: 185.70.43.23, mailfrom: paulo@myneves.com)
Date: Fri, 17 Feb 2023 17:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676653267; x=1676912467;
	bh=nL2BFtyRnRMsipC0tdgdOUkhOEuPoq7UM9OSXeEWMVM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kS0av9DQmwRzMV9f/JjaTZrSEHUTmGrKtJMZS7hiG7jCkrrJw8i1Zt1yXNZdR6i9O
	 x6BNMwSc9zJitoCKjZH79mw//PVfcI/4dEGLYFyX4Mc+TzhPOuC+dz/pX2uU/OW1iG
	 12umG0mXdX9qjFUNolZSnkKfC0unaJbwWiTbBSc42jQKl0kZMOGaOaQEvRBZGBbrOt
	 S/rHQFFZfcslt5bow7zhBiP+/ScDSE+3P+4FOBVySc8t5nJf8hNGUwH8F3HEbf45Tm
	 6bWEt4MD3Zc98U1MSFmepWo0wQUIOFTs41xdVtmlXRe9gCZY6YG1kQbz9Pqq+2ygUU
	 UxpQWqxS98iQA==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 4/5] git.py: @_contains_lfs: Removed unused variables
Message-ID: <20230217170009.58707-4-paulo@myneves.com>
In-Reply-To: <20230217170009.58707-1-paulo@myneves.com>
References: <20230217170009.58707-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 17:01:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14463

branchname was set but never used in the context of _contains_lfs
method.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/fetch2/git.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index a3f29d2b9..fcd70fdcf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -660,11 +660,6 @@ class Git(FetchMethod):
         Check if the repository has 'lfs' (large file) content
         """

-        if not ud.nobranch:
-            branchname =3D ud.branches[ud.names[0]]
-        else:
-            branchname =3D "master"
-
         # The bare clonedir doesn't use the remote names; it has the branc=
h immediately.
         if wd =3D=3D ud.clonedir:
             refname =3D ud.branches[ud.names[0]]
--
2.34.1



