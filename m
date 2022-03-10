Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B37AC433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 10:53:58 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.7996.1646909633539909983
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 02:53:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=lrNwSXdp;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646909633;
  x=1678445633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YsVPqLgsVXLQ/gvqjzpNDw6mB/NHIgxwBGZNzLYopx0=;
  b=lrNwSXdpbJGnD6Ykf9uTXiwUJUbWbb3yVkWRbcUXFsPH4FBftG0Ua+d5
   D55/4FjVuymo9pEw/J2CrJCRGXhcwh8ZFJHZ1L38uiDwMdcw4dV6jP9vx
   L5PExTv8jLwoXh73iNTrTvD7eDiz1gsIGYCtyO+1wz30NYw002MdMC4Tr
   4MLwk5zlD4rUdsAbdhlwcgB/Kekzk8lb2soz1vNgI64V5MSr3GdtqzbLM
   HwKgFHF9D8hOTMc78Ni+jnbLfXW8CJAQCkqMTvwhdbqKdr9tJEon0DFc4
   L5o47lQJJ3kXjubBUV1Q4LksobYdGZrFgvw2g7SYMSuVTNFb3saRiikpv
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "michael.opdenacker@bootlin.com" <michael.opdenacker@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [docs] [PATCH 2/2] doc: bitbake-user-manual: branch parameter now
 mandatory in git SRC_URIs
Thread-Topic: [docs] [PATCH 2/2] doc: bitbake-user-manual: branch parameter
 now mandatory in git SRC_URIs
Thread-Index: AQHYM96fAlG5BjX800+E7kbOPWUlQay4cheg
Date: Thu, 10 Mar 2022 10:53:47 +0000
Message-ID: <a1abff5be8224e7683afab63e7f3e9fc@axis.com>
References: <20220309175319.620707-1-michael.opdenacker@bootlin.com>
 <20220309175319.620707-2-michael.opdenacker@bootlin.com>
In-Reply-To: <20220309175319.620707-2-michael.opdenacker@bootlin.com>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 10:53:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13460

> -----Original Message-----
> From: docs@lists.yoctoproject.org <docs@lists.yoctoproject.org> On Behalf
> Of Michael Opdenacker via lists.yoctoproject.org
> Sent: den 9 mars 2022 18:53
> To: bitbake-devel@lists.openembedded.org
> Cc: docs@lists.yoctoproject.org; Michael Opdenacker
> <michael.opdenacker@bootlin.com>
> Subject: [docs] [PATCH 2/2] doc: bitbake-user-manual: branch parameter no=
w
> mandatory in git SRC_URIs
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index ae2d3a17..d0c78062 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -432,8 +432,8 @@ This fetcher supports the following parameters:
>     raw Git metadata is provided. This parameter implies the "nocheckout"
>     parameter as well.
>=20
> --  *"branch":* The branch(es) of the Git tree to clone. If unset, this
> -   is assumed to be "master". The number of branch parameters much match
> +-  *"branch":* The branch(es) of the Git tree to clone. This is a
> +   mandatory parameter. The number of branch parameters must match
>     the number of name parameters.

Note that it is either branch=3D... or nobranch=3D1 that is mandatory.

>=20
>  -  *"rev":* The revision to use for the checkout. The default is
> --
> 2.25.1

//Peter


