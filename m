Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C5BC433F5
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 18:00:19 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.1636.1635876018037308668
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 11:00:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=XSVmst2U;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1635876018;
  x=1667412018;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UTtLY+E1G7uSWWzeU9CqxVPYgvSqQKpIxLB6Ysw9mck=;
  b=XSVmst2U9naF/xXAW9ZEdzC/EBOsg79x7+diW6XzdCVEaHMW9yGo7itL
   dv/Yf8r36GL4407wS5VtVYHuSEIPytzMc9qyjZdryzQGQ40mQoc3pPuTy
   nL//4k1nDRzrCOKvDdyQjH0M7lzELvVRq33RZeNkYo5T+RttRIKd+VITy
   IOysWEnatoksZ6Us5A6GCWTvZ82Jj6s2V+Bab2kTPHXwUZwTCCu56e1kj
   5u0CK7mbW5e8qnMGKZnO4vpJoh9YzdxSK3Sqd/qydlD4p8JzQGyQ8MTkc
   IaVIpXW+01g7s7+OfTBBzgEUQw3duHll4uEGaZ8ZmYtzE0+aAowHfRV6w
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
Thread-Topic: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
Thread-Index: AQHXz+d3lMVYNMgRBkqv79NKJI01HKvwhgEQ
Date: Tue, 2 Nov 2021 18:00:13 +0000
Message-ID: <5f1da11f834f496da0944ea65f140460@axis.com>
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 18:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12869

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 2 november 2021 13:45
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
> git:// support
>=20
> github is dropping support for git procotol iun git urls. Add code to rem=
ap

Typo: procotol iun -> protocol in

> this to https in a way that could be used in older bitbake versions.

Though I would have written:

github is dropping support for the Git protocol in Git URLs. Add code to=20
remap this to HTTPS in a way that can be used in older bitbake versions.

//Peter

>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index e974445fbe..f5be24d6ab 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -142,6 +142,10 @@ class Git(FetchMethod):
>              ud.proto =3D 'file'
>          else:
>              ud.proto =3D "git"
> +        if ud.host =3D=3D "github.com" and ud.proto =3D=3D "git":
> +            # github stopped supporting git protocol
> +            # https://github.blog/2021-09-01-improving-git-protocol-secu=
rity-github/#no-more-unauthenticated-git
> +            ud.proto =3D "https"
>=20
>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsyn=
c'):
>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.u=
rl)
> --
> 2.32.0


