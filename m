Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ECC43334
	for <webhook@archiver.kernel.org>; Sat, 23 Jul 2022 01:13:20 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.2160.1658538795428060053
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jul 2022 18:13:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=LNTnn1s3;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 55EA28021D;
	Sat, 23 Jul 2022 03:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658538792;
	bh=9ZWxkz5f+hdFJug7W+y6nxnI/kmu7kDml5BK010xgW8=;
	h=From:To:Cc:Subject:Date:From;
	b=LNTnn1s3Ja+T3ysQlA9fKBx620ah2g4T1DQfTx7SMw2C4kylBfAhK7C3ZVYJWs9uu
	 JWOyL+vfmBCthQVcE0CcrxAEz43mpyGSfjpgjLeLDiDkTUttxmUmucIo5zZxzHlnL6
	 KUKFasTEje5343TEAqMT6i82Oh+gV0FONjgaHjrTVP7Uq+xtCzoLyCWjAfqbDiBf43
	 FD1Dlbxv4gQzcmmgFUGctxk/UIFLuExJGBUlQOzSDIZiWoVaYdkOseMW38cG8nBH+5
	 qRybtdC/nqiS+5tlJ6l5QsClP7GGJk9F5vQHJkIsAP0ioMn6Ab/OHPkW572eJwR70p
	 jRxMf7VshjTQA==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Marek Vasut <marex@denx.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] bitbake-user-manual: Document override :append, :prepend,
 :remove order
Date: Sat, 23 Jul 2022 03:13:05 +0200
Message-Id: <20220723011305.311655-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 23 Jul 2022 01:13:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13837

The application order of override syntax :append, :prepend, :remove is
inobvious and undocumented. The order does not match variable parse
history, i.e. output of "bitbake -e", either.

Add note documenting the exact order in which :append, :prepend, :remove
are applied to variable in lib/bb/data_smart.py getVarFlag(). Add note
that this order does not match the variable parse history order. This
is mostly to prevent others from running into this and scratching their
heads, trying to find out what is going on.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-metadata.rst                 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 33782161..651116ce 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -351,6 +351,18 @@ The variable ``FOO`` becomes
 Like ":append" and ":prepend", ":remove" is applied at variable
 expansion time.
=20
+.. note::
+
+   The overrides are applied in this order, ":append", ":prepend", ":rem=
ove".
+   This implies it is not possible to re-append previously removed strin=
gs.
+
+.. note::
+
+   Override application order may not match variable parse history, i.e.
+   the output of ``bitbake -e`` may contain ":remove" before ":append",
+   but the result will be removed string, because ":remove" is handled
+   last.
+
 Override Style Operation Advantages
 -----------------------------------
=20
--=20
2.35.1


