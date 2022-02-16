Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDFDC433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 16:22:17 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.1209.1645028535479051371
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 08:22:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=gsKR1QY6;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1645028536;
  x=1676564536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=klbbGELagccNdvw/0qDFwQ1WXyGGh6Sa99NkK92YlcI=;
  b=gsKR1QY6PjC9yrSphpoYkZUm4R0J/QI9gFozMVJ66kfZYM8YBDbLj3iK
   Sa4Kzv5ZXlhe8FnTQvfbebETG/lrmMkusOxac3CI1fUge0JaVGT0QN953
   qc036oRE4SJNPGE8BirI8ko6rfriqfzlobtZ0drm4kPWaH8fyvL6Adotb
   xNrDzKf8tdRJb4l2B3AiMo0dOjVLwWRmLK2P0m1fPpLWJGYHPPt7bE2+G
   c5xMcrxsxO6zCQ5YgZhXJ1Cp49mzMvl5H2gM1wOpgq/O3V0Gf1Ob8eEGq
   3KyFZkudpacDte+21KCk84+XpBJrP3vWBmggLBdpfVc37yxiCXR7XH1ld
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Joshua Watt <JPEWhacker@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: RE: [bitbake-devel][PATCH] bitbake: msg: Add bb.warnonce() and
 bb.erroronce() log methods
Thread-Topic: [bitbake-devel][PATCH] bitbake: msg: Add bb.warnonce() and
 bb.erroronce() log methods
Thread-Index: AQHYI0x29QOMbLJsBUWGEoHc6PE4P6yWWSBA
Date: Wed, 16 Feb 2022 16:22:12 +0000
Message-ID: <b4859a1015a64948b9326c6800fd70f4@axis.com>
References: <20220216154646.2499980-1-JPEWhacker@gmail.com>
In-Reply-To: <20220216154646.2499980-1-JPEWhacker@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 16:22:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13358

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Joshua Watt
> Sent: den 16 februari 2022 16:47
> To: bitbake-devel@lists.openembedded.org
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>; Joshua Watt
> <JPEWhacker@gmail.com>
> Subject: [bitbake-devel][PATCH] bitbake: msg: Add bb.warnonce() and
> bb.erroronce() log methods
>=20
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> This adds a log level and logging function call to use it where the
> warning or error will only be displayed once, regardless of how many
> times the message is logged.
>=20
> This has to be done either in the cooker or on the UI side. I've opted
> for the UI side since display control is really a UI issue but it uses
> a common library filter function to enable it which can be reused
> elsewhere.
>=20
> The knotty message displayed as the build summary is tweaked to
> make sense when the numbers won't match since it will still count
> the number of times it was logged and this is probably helpful
> for debugging in some cases so I've deliberately left it that way.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/__init__.py  | 13 +++++++++++++
>  bitbake/lib/bb/msg.py       | 32 +++++++++++++++++++++++++++++++-
>  bitbake/lib/bb/ui/knotty.py | 14 +++++++-------
>  3 files changed, 51 insertions(+), 8 deletions(-)

[cut]

> diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
> index 291b38ff7f..512ec1f5c1 100644
> --- a/bitbake/lib/bb/msg.py
> +++ b/bitbake/lib/bb/msg.py
> @@ -30,7 +30,9 @@ class BBLogFormatter(logging.Formatter):
>      PLAIN =3D logging.INFO + 1
>      VERBNOTE =3D logging.INFO + 2
>      ERROR =3D logging.ERROR
> +    ERRORONCE =3D logging.ERROR - 1
>      WARNING =3D logging.WARNING
> +    WARNONCE =3D logging.WARNING - 1
>      CRITICAL =3D logging.CRITICAL
>=20
>      levelnames =3D {
> @@ -42,7 +44,9 @@ class BBLogFormatter(logging.Formatter):
>          PLAIN  : '',
>          VERBNOTE: 'NOTE',
>          WARNING : 'WARNING',
> +        WARNONCE : 'WARNING',
>          ERROR   : 'ERROR',
> +        ERRORONCE   : 'ERROR',
>          CRITICAL: 'ERROR',
>      }
>=20
> @@ -58,7 +62,9 @@ class BBLogFormatter(logging.Formatter):
>          PLAIN   : BASECOLOR,
>          VERBNOTE: BASECOLOR,
>          WARNING : YELLOW,
> +        WARNONCE : YELLOW,
>          ERROR   : RED,
> +        ERRORONCE : RED,
>          CRITICAL: RED,
>      }
>=20

A qualified guess is that those colons above were once expected to=20
line up...


//Peter

