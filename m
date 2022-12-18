Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7043C4332F
	for <webhook@archiver.kernel.org>; Sun, 18 Dec 2022 00:10:44 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.19867.1671322237307599000
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Dec 2022 16:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=QMFvrnra;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A20EC82162;
	Sun, 18 Dec 2022 01:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1671322235;
	bh=f5MHOf61ireUwtce3C6Y+bBxBy5W1HrZucv2WXRkU0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=QMFvrnrafiEaVc6zNeEuUAOl/MR983+MOc9ix7xD/37bV2/UrNXeK8gxitjRPqwa/
	 tUaQpCFy0k472Bg9oe53vHcEb8A2hbecHDashepIEV/eJ56llEfsATJ0nWxbmUudsa
	 h3jWeYREcm4D3WzRHWjNrIpnpFM0okicjzgz2oNPUMeE3MvW75GzA7BVoJQXZ46jN7
	 Rie3LyQO0mtnbA24yZHq9TjNqRFQh3FnC7o+HPTrwS34jY0jUDIcYYBXXMKjweeXB8
	 NmGVyBRG50M5m/L6yJ2sKSOJjd9YnjF8hgC93dyKYkyT6F06Vk9YBnhsEhsaADz5Ul
	 XnRFyyTB9R68Q==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: Marek Vasut <marex@denx.de>,
	Quentin Schulz <foss+yocto@0leil.net>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Martin Jansa <martin.jansa@gmail.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v4] bitbake-user-manual: Document override :append, :prepend, :remove order
Date: Sun, 18 Dec 2022 01:10:30 +0100
Message-Id: <20221218001030.158054-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Dec 2022 00:10:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14194

The application order of override syntax :append, :prepend, :remove is
inobvious and undocumented. The order does not match variable parse
history, i.e. output of "bitbake -e", either.

Add note documenting the exact order in which :append, :prepend, :remove
are applied to variable in lib/bb/data_smart.py getVarFlag(). Add note
that this order does not match the variable parse history order. This
is mostly to prevent others from running into this and scratching their
heads, trying to find out what is going on.

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Quentin Schulz <foss+yocto@0leil.net>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
V2: - Add RB from Quentin
    - Mention un-remove implementation
    - Reference :remove order in append/prepend override syntax
V3: - Reword the note per suggestion from Quentin
    - Use explicit FOOREMOVE per suggestion from Peter
V4: - Rebase on latest bitbake, resend
---
 .../bitbake-user-manual-metadata.rst          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b839e669..deb7afad 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -319,6 +319,10 @@ The variable ``D`` becomes "dvaladditional data".
=20
    You must control all spacing when you use the override syntax.
=20
+.. note::
+
+   The overrides are applied in this order, ":append", ":prepend", ":rem=
ove".
+
 It is also possible to append and prepend to shell functions and
 BitBake-style Python functions. See the ":ref:`bitbake-user-manual/bitba=
ke-user-manual-metadata:shell functions`" and ":ref:`bitbake-user-manual/=
bitbake-user-manual-metadata:bitbake-style python functions`"
 sections for examples.
@@ -352,6 +356,28 @@ The variable ``FOO`` becomes
 Like ":append" and ":prepend", ":remove" is applied at variable
 expansion time.
=20
+.. note::
+
+   The overrides are applied in this order, ":append", ":prepend", ":rem=
ove".
+   This implies it is not possible to re-append previously removed strin=
gs.
+   However, one can undo a ":remove" by using an intermediate variable w=
hose
+   content is passed to the ":remove" so that modifying the intermediate
+   variable equals to keeping the string in::
+
+     FOOREMOVE =3D "123 456 789"
+     FOO:remove =3D "${FOOREMOVE}"
+     ...
+     FOOREMOVE =3D "123 789"
+
+   This expands to ``FOO:remove =3D "123 789"``.
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


