Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF3C433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 15:56:48 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.29982.1658764604780671104
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 08:56:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=W0bu7+fr;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4FF108409F;
	Mon, 25 Jul 2022 17:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658764602;
	bh=ugkPK63M8zd1GJpoJpsofC9/PUCXCkxcEpMwer0vk2o=;
	h=From:To:Cc:Subject:Date:From;
	b=W0bu7+frhuH880Fn5hndoj3Pa6LB4N96Jpu4PHJucc90nquUwZcvKuJ3lCg4kN3VI
	 938KRRpZXh5mi0excnPdH5To9hYTUni5Mv/RbY8frVWssGqLNA2Zbq3lQNVV6P8JO4
	 kdXiteSdAHj/ZsIy69pPYYDSpUe6ZjveKbs0R14xDN1DbdLM6lwvNp1G/11SWP6f68
	 l+qsfcr+7pBIqC96QiHXNbpDdmt5IUHwq0ua+nbWGyPJZD7XJ/A9sMGLxOrytw+fpd
	 gIxQySYtDNpXSBD89p4Eaym9Z77vhAkRmSmyQaGuSKPd6hl77CkeZz2tRq7CIIrVyV
	 q11Wpt4JBcSng==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Marek Vasut <marex@denx.de>,
	Quentin Schulz <foss+yocto@0leil.net>,
	Martin Jansa <martin.jansa@gmail.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v3] bitbake-user-manual: Document override :append, :prepend,
 :remove order
Date: Mon, 25 Jul 2022 17:56:25 +0200
Message-Id: <20220725155625.381756-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 15:56:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13845

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
---
 .../bitbake-user-manual-metadata.rst          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 33782161..587c9120 100644
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
@@ -351,6 +355,28 @@ The variable ``FOO`` becomes
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


