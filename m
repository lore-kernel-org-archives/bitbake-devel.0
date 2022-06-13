Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C6C43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 16:57:58 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.8466.1655139474530721870
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Jun 2022 09:57:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=VkOsnxuA;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655139474;
  x=1686675474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IRNX4GjBw088sbtDGS4hbSEaUbVBL9/o0aDSBRECUkU=;
  b=VkOsnxuA3FEbc8XH+E0vrJ/kIYrj1qJMODeQ3m2rtwjepJsc63MSWkcq
   j9XJgxwVz9miW6ilZ3EWgKI9H/BZ4T3TUlbvcmpSsVNJuJiasD1+SMY2r
   1156oXo1hGCniKGPRPT0wKp6p+stzTUqDZHvIhEH6PNF212VFrsil2uLx
   yyKxZ5L2sS7Od47rBl4+MfTof6KpN/3b8+99n8Kgb68uZFOFY3HDuY/6m
   hlaHYve5EEy95038Pz/rvqYk6r+NwuFUAAYT/sQHVRe6rPNdc/F3ynShp
   vROx+8s94Ly556KYOcWgNlc/L5FQCZULJ7f/4hJwDAu1wXFANXBKJ3gwa
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Jacob Kroon <jacob.kroon@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
 description of the ??= operator
Thread-Topic: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
 description of the ??= operator
Thread-Index: AQHYfP2XdV77dEx110eNBxTsROEKeK1Njt1w
Date: Mon, 13 Jun 2022 16:57:51 +0000
Message-ID: <3f8312432bfa45e7a369e5c5a793569e@axis.com>
References: <20220610190845.181330-1-jacob.kroon@gmail.com>
In-Reply-To: <20220610190845.181330-1-jacob.kroon@gmail.com>
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
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Jun 2022 16:57:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13758

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Jacob Kroon
> Sent: den 10 juni 2022 21:09
> To: bitbake-devel@lists.openembedded.org
> Cc: docs@lists.yoctoproject.org
> Subject: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
> description of the ??=3D operator
>=20
> Stating that the assignment is done at the end of parsing is misleading.
> The weak default value is the value which a variable will expand to if no
> value
> has been assigned to it using any of the assignment operators.
>=20
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>=20
> Changes in v3:
> * Update commit message
> * Change "... via one of ..." to "... via any of ..."
>=20
> Changes in v2:
> * Add comment to line with immediate variable expansion
>=20
>  .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index af4b1358..45355b6c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable i=
s
> set to "aval".
>  Setting a weak default value (??=3D)
>  ----------------------------------
>=20
> -It is possible to use a "weaker" assignment than in the previous section
> -by using the "??=3D" operator. This assignment behaves identical to "?=
=3D"
> -except that the assignment is made at the end of the parsing process
> -rather than immediately. Consequently, when multiple "??=3D" assignments
> -exist, the last one is used. Also, any "=3D" or "?=3D" assignment will
> -override the value set with "??=3D". Here is an example::
> -
> -   A ??=3D "somevalue"
> -   A ??=3D "someothervalue"
> -
> -If ``A`` is set before the above statements are
> -parsed, the variable retains its value. If ``A`` is not set, the
> -variable is set to "someothervalue".
> -
> -Again, this assignment is a "lazy" or "weak" assignment because it does
> -not occur until the end of the parsing process.
> +The weak default value of a variable is the value which that variable
> +will expand to if no value has been assigned to it via any of the other
> +assignment operators. Here is an example::
> +
> +   W ??=3D "x"
> +   A :=3D "${W}" # Immediate variable expansion
> +   W ??=3D "y"
> +   B =3D "${W}"
> +   W ?=3D "z"
> +
> +After parsing we will have::
> +
> +   A =3D "x"
> +   B =3D "z"
> +   W =3D "z"
>=20
>  Immediate variable expansion (:=3D)
>  ---------------------------------

I think the new description is missing some of the information of the=20
original description, e.g., "when multiple "??=3D" assignments exist, the=20
last one is used". So, e.g.:

W ??=3D "x"
W ??=3D "y"

gives

W =3D "y"

Another interesting case that is easy to get wrong is:

W ??=3D "x"
W +=3D "y"

that gives

W =3D " y"
=09
and which should be compared to

W ??=3D "x"
W:append =3D " y"

that gives

W =3D "x y"

//Peter


