Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A8C5DF85
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 19:16:15 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4015.1787166969579671534
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 12:16:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Gmb5mm6X;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 05FF13D818AE;
	Wed, 19 Aug 2026 15:16:08 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gX31LQCJ9ZHO; Wed, 19 Aug 2026 15:16:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2E9CC3D818E8;
	Wed, 19 Aug 2026 15:16:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2E9CC3D818E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1787166967; bh=SmWIdZ09ufmBoZ5Seyy0LO7E1Gv65Sx/6cHeZ46HOCY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Gmb5mm6Xt6QSP0nNQviiJEGyRq5kZXLi30J5ZP6URCwQWIeJK6cc/VUBJthVNW7Bt
	 D1ICfJsmcqOy9fbsQfZXDVmfNSqmF5ARLse02rhs04xZz2cgDeE7jA+8fth9uGONe2
	 38dzpc8BOUU3G2ILXfpBiYMgbe1PZ3vOniE4lmyqxdrXtaIknpwz0cWkYxXQ9M4qhR
	 T5N6shlPlhP2GUDE4jrsgaxqGCgmPx3foWxYkHn63qq3n75UFHAunzwscOToiCwL0b
	 SB9EnW2h0j4YiPElsE6SO+GLQSKBwnljjgeQEuIR0P6fkmAn+ZrcjX/hFp5/9JcWnd
	 AD9qsCK0hD0Vw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NCRTI1D1vXI9; Wed, 19 Aug 2026 15:16:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0DA073D818AE;
	Wed, 19 Aug 2026 15:16:07 -0400 (EDT)
Date: Wed, 19 Aug 2026 15:16:07 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <1319358081.1239871.1787166966997.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <58e087a5908a808a3557f92d3844f79b1cce61cd.camel@linuxfoundation.org>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com> <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org> <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com> <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org> <1200355947.1128688.1786996086820.JavaMail.zimbra@savoirfairelinux.com> <8558d54fda8e977ea6e677693db0586b8e10e80a.camel@linuxfoundation.org> <515257189.1172159.1787078030404.JavaMail.zimbra@savoirfairelinux.com> <58e087a5908a808a3557f92d3844f79b1cce61cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.15_GA_0126 (ZimbraWebClient - FF153 (Linux)/10.1.15_GA_0126)
Thread-Topic: toaster: Add recipe variables view
Thread-Index: eCJRBCkMieQ9V/1m2BMKW1R/Z1MRdQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 19:16:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20003

Hi Richard,

Thank you for the feedback, and sorry=E2=80=94the previous approach was too=
 intrusive
in BitBake=E2=80=99s parsing and cache machinery.

I have reworked it so that no recipe-variable data is added to BitBake=E2=
=80=99s parse
cache or dependency events. Toaster now records the recipe files selected f=
or
the runqueue and, after the build completes, acts as a client of the BitBak=
e
server. It calls a new read-only command for each recipe, which uses BitBak=
e=E2=80=99s
normal parser to create a temporary recipe datastore and returns the resolv=
ed
variables to Toaster. Toaster then compresses and stores the result in its =
own
database.

The history-based selection has also been removed, so indirect changes such=
 as
X =3D "${Y}" are represented correctly. Functions and values requiring inli=
ne
Python expansion are currently omitted to avoid execution side effects, so =
the
result is a safely expanded subset rather than a byte-for-byte equivalent o=
f
bitbake -e.

This approach does require reparsing the runqueue recipes after the build. =
In a
preliminary cached imx-image-core test, it added approximately 42 seconds
compared with unmodified Toaster. I am continuing to evaluate that cost.

I hope this provides a better compromise by keeping the data out of BitBake=
=E2=80=99s
normal cache and build flow while allowing Toaster to query BitBake through=
 a
defined API. I do not currently see a less intrusive way for Toaster to obt=
ain
build-specific recipe values.

If the general approach seems viable to you, I can send the incremental cha=
nges
for review.

Thank you again for your feedback.

Have a great day, =20
Paolo

