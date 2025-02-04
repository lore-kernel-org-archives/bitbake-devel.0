Return-Path: <n.merinov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F1C02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 11:11:27 +0000 (UTC)
Received: from ksserv.inango.com (ksserv.inango.com [31.154.135.10])
 by mx.groups.io with SMTP id smtpd.web10.114135.1738667486617520428
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 03:11:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com header.s=45A440E0-D841-11E8-B985-5FCC721607E0 header.b=qldZpOK2;
 spf=pass (domain: inango-systems.com, ip: 31.154.135.10, mailfrom: n.merinov@inango-systems.com)
Received: from ksserv.inango.com (localhost [127.0.0.1])
	by ksserv.inango.com (Proxmox) with ESMTP id 0C24E2711C;
	Tue,  4 Feb 2025 13:11:23 +0200 (IST)
Received: from mail.inango-systems.com (unknown [172.31.254.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ksserv.inango.com (Proxmox) with ESMTPS id D66782711B;
	Tue,  4 Feb 2025 13:11:22 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 0DE141080308;
	Tue,  4 Feb 2025 13:11:22 +0200 (IST)
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id b7nCyrYmDkdK; Tue,  4 Feb 2025 13:11:22 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id C86BE108051C;
	Tue,  4 Feb 2025 13:11:21 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com C86BE108051C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1738667481;
	bh=maKwtLv8G1XKsVfgRvoJSceunUr7nqLJaZMSY3sEB+M=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=qldZpOK2rCXqpGYtQaJDxcWumNNWm8MJUToEbngY1/qdHoehn0AmHZJVXlLMj9R2J
	 p9s7u6L2PI4pIslslx4I1g96WhZS+mTZqjJYkCbYUCMbZOC1LLWLoisDFKkUwKlkjK
	 y9r4T33oaf2sXqvPD3g/gsmBkSbZ0+weWkLMuNjVbL5oTDb1UdeUhquVyJJ4/SyRLF
	 xqAziQ0+FB8g8cU+znxAUIlKjVF85/JKZJ7yMePc5XdLtQ8VkjkZD3MuMiaMjqxoTi
	 CskBw0ViDMzFnOw8lKXjzEa5fhoh0O3FpyAtbsLkWXhUA9vp22Wyco7eRVris+b/vV
	 Z8V7mEfeCIXcA==
X-Virus-Scanned: amavis at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TNLw3WLJvOZv; Tue,  4 Feb 2025 13:11:21 +0200 (IST)
Received: from mail.inango-systems.com (mail.inango-systems.com [172.17.220.3])
	by mail.inango-systems.com (Postfix) with ESMTP id AE0A71080308;
	Tue,  4 Feb 2025 13:11:21 +0200 (IST)
Date: Tue, 4 Feb 2025 13:11:21 +0200 (IST)
From: Nikolai Merinov <n.merinov@inango-systems.com>
To: peter kjellerstedt <peter.kjellerstedt@axis.com>
Cc: bitbake-devel@lists.openembedded.org
Message-ID: <1954040712.15183.1738667481426.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <DB5PR02MB10213AFB411A607B11EAB0B62EFE82@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250129185531.3752682-1-n.merinov@inango-systems.com> <DB5PR02MB10213AFB411A607B11EAB0B62EFE82@DB5PR02MB10213.eurprd02.prod.outlook.com>
Subject: Re: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to
 ${.}, ${+}, and ${:} variables
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC131 (Linux)/8.8.15_GA_4570)
Thread-Topic: parse: Forbid ambiguous assignments to ${.}, ${+}, and ${:} variables
Thread-Index: AQHbcn97V6EQTSVoVkG9CsTLqTeRcrMxETNgT8mfBqE=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Feb 2025 11:11:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17131

Hi Peter,

> The above made me ponder on the existence of $, { and } in the regular
> expression for the variable name and what that can be (ab)used for. I
> realized that it allows you do define really odd variables such as:
>=20
> ${} =3D "foobar"
> } =3D "foobar"
> $ =3D "foobar"
>=20
> And while you cannot access them directly using, e.g., "${$}", you can
> access them using, e.g., "${@d.getVar('$')"...
>=20
> This also allows defining variables that do not match the syntax at all,
> e.g.:
>=20
> EQUAL =3D "=3D"
> ${EQUAL} =3D "bar"
>=20
> which will define the variable "=3D" and where "${@d.getVar('=3D')}" then
> returns "bar" as expected...
>=20
> I am not sure this is a problem or working as intended, but it is a bit
> odd.

I did not aware of bitbake development history, but I believe that there
can be only one reason to do it: Makefile allow same kind of bizarre things=
.=20

    $ cat Makefile=20
    name =3D =3D=3D=E1=83=90=E1=83=A0 =E1=83=92=E1=83=90=E1=83=90=E1=83=99=
=E1=83=94=E1=83=97=E1=83=9D=3D=3D
    $(name) =3D Hello World
    all: ; echo $(=3D=3D=E1=83=90=E1=83=A0 =E1=83=92=E1=83=90=E1=83=90=E1=
=83=99=E1=83=94=E1=83=97=E1=83=9D=3D=3D)
    $ make
    echo Hello World
    Hello World
    $

Regards,
Nikolai


