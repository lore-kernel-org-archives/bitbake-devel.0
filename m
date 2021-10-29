Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB4C433FE
	for <webhook@archiver.kernel.org>; Fri, 29 Oct 2021 18:50:00 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.9746.1635533399220776106
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Oct 2021 11:50:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=RT+Uf7Mx;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1635533399;
  x=1667069399;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RRIWRCKNeaMUf6tcDaUS6lC31BVQDy3ZMuAcdO04gDs=;
  b=RT+Uf7MxN809HRNvqkGLsifWqrK3xjo2fNhmhaD3BdEVO3HTVtiiBWgJ
   uYr44mbT8YXYE/I8bga8GzldFhI3AO/wCkLOa5j18gnfb2tJ8oqFA6Yuy
   vILRNpB74IMRdABlcaF0I6Lj+W1RPBuee0De0XQLukMjH3tVGm7inm3Up
   vMpox50iXnlJ9vkkaC696zqQJQ6zwdQH8Py9g6NC0Wb3kBi5l0fyw1rdQ
   7lxz1RuiUlok2/T9RnBPK5kocSlfn+ogtg2Srg/TA/162yD2g15pSv8sD
   QjpY9M4jJGLaRQE5h0F76YoNAf3pGSQXmgrd+ikFCvTP9XxX/6HA1C7Ud
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch2/git: Add a warning asking users to
 set a branch in git urls
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git: Add a warning asking users
 to set a branch in git urls
Thread-Index: AQHXzMSesSvrfcDF40+4Lq9pVGr70KvqUHAQ
Date: Fri, 29 Oct 2021 18:49:55 +0000
Message-ID: <f8e3d52f7f03496e81dab1693de88527@axis.com>
References: <20211029125759.3422953-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20211029125759.3422953-1-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Oct 2021 18:50:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12848

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 29 oktober 2021 14:58
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] fetch2/git: Add a warning asking users t=
o
> set a branch in git urls
>=20
> There is much uncertainty around what tools and hosting providers will
> do about default git branch naming in the future. To help ensure we
> can handle the various scenarios, we will make branch names required in
> SRC_URI. To start that process, show users a warning if it isn't set.
> This may also allow us to change the default at some point in the future.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 51b616bad7..17a7927e52 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -165,7 +165,10 @@ class Git(FetchMethod):
>              ud.nocheckout =3D 1
>=20
>          ud.unresolvedrev =3D {}
> -        branches =3D ud.parm.get("branch", "master").split(',')
> +        branches =3D ud.parm.get("branch", "").split(',')
> +        if branches =3D=3D [""]:
> +            bb.warn("URL: %s does not have any branch set. The
> uncertainty around the default branch used by tools and repositories mean=
s
> we will soon require this in all git urls so please add it." % ud.url)
> +            branches =3D ["master"]
>          if len(branches) !=3D len(ud.names):
>              raise bb.fetch2.ParameterError("The number of name and branc=
h
> parameters is not balanced", ud.url)
>=20
> --
> 2.32.0

What about nobranch=3D1? We use that for all our Git recipes (~1500). I wou=
ld=20
really hate to have to add branch=3Dmaster to all of them when we really do=
=20
not care about what branch the SRCREV happens to be on (especially as it=20
often is a Gerrit review reference).

//Peter


