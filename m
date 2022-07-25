Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3876EC433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 10:57:37 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.26696.1658746649760100781
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 03:57:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=VVcBMWOq;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B43BA83E13;
	Mon, 25 Jul 2022 12:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658746647;
	bh=ylROLmbsSyMMre4ewN41iF8sOV0Eakw9Ot3RIg2wvZM=;
	h=From:To:Cc:Subject:Date:From;
	b=VVcBMWOqclBPKOPhb0P9gLXqGeRe7qHhx2L7X3r27s1hAwsyQzW6ZtfxoNXErWsBw
	 ARYXnVjnkvSXG1/AWXE7Sg2kutNxQ/lWSktEg3iWT0ebp5STYCqzwVAKmwBgQCfaRl
	 eQWEYndadIBdedx+yojFXNJ2xCRunoons9dOXHeAMBu6xm7sqktYgMI2hoZOtEy3FI
	 jicb7KwNOxHboVT63OWu+lonbMhAeOU5Ya+aDMdeAfInArnuiobtNg9tiwYL8BP+9m
	 0mQLTP0TuLYro+4IQqzDQqDHJNSx6/QjsoimRyQ2g2p4j7bkYjzwdqYpQVogwAjxwx
	 fjG3/SHcnL+yg==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Marek Vasut <marex@denx.de>,
	Quentin Schulz <foss+yocto@0leil.net>,
	Martin Jansa <martin.jansa@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v2] bitbake-user-manual: Document override :append, :prepend,
 :remove order
Date: Mon, 25 Jul 2022 12:57:15 +0200
Message-Id: <20220725105715.89474-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 10:57:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13842

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
Cc: Quentin Schulz <foss+yocto@0leil.net>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
V2: - Add RB from Quentin
    - Mention un-remove implementation
    - Reference :remove order in append/prepend override syntax
---
 .../bitbake-user-manual-metadata.rst          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 33782161..4da18826 100644
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
@@ -351,6 +355,27 @@ The variable ``FOO`` becomes
 Like ":append" and ":prepend", ":remove" is applied at variable
 expansion time.
=20
+.. note::
+
+   The overrides are applied in this order, ":append", ":prepend", ":rem=
ove".
+   This implies it is not possible to re-append previously removed strin=
gs.
+   While it is not possible to re-append strings, it is possible to remo=
ve
+   strings from separate variable which contains the string remove list =
to
+   achieve the same effect using un-remove::
+
+     FOOREMOVE =3D "123 456 789"
+     FOO:remove =3D "${FOOREMOVE}"
+     FOOREMOVE:remove =3D "456"
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


