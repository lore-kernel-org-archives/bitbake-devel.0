Received: from esa7.hc324-48.eu.iphmx.com (esa7.hc324-48.eu.iphmx.com [207.54.71.126])
 by mx.groups.io with SMTP id smtpd.web10.9090.1594210361422514027
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2020 05:12:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@bmw.de header.s=mailing1 header.b=Ym+WtOAS;
 spf=pass (domain: bmw.de, ip: 207.54.71.126, mailfrom: prvs=45173159e=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1594210361; x=1625746361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PrRkoEDN3eE6pJCNQnsaTDNMf+IvsHrAtexF96pOy9o=;
  b=Ym+WtOAS2z4j1KV5ECcdB4RLUgj0In1f21Vu6xvmlsMvtj3fKkLnAmt4
   gnBVJzHvOnZeqfyKC2CtUIKI+5pcOQtEVkt+joxOuMokzRiTwOxfpM3Eo
   zAZPV79bw21SXiqLG4bGwvzrYyEmyPLnz7YJVQrjrzDp5K4hGPesPqp03
   8=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 08 Jul 2020 14:12:39 +0200
Received: from esabb5.muc ([160.50.100.47])  by esagw3.muc with ESMTP/TLS;
 08 Jul 2020 14:12:38 +0200
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp) ([160.48.96.47])
 by esabb5.muc with ESMTP/TLS; 08 Jul 2020 14:12:38 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by smucm10k.europe.bmw.corp
 (160.48.96.47) with Microsoft SMTP Server (TLS;
 Wed, 8 Jul 2020 14:12:37 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
 smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1497.006; Wed, 8
 Jul 2020 14:12:37 +0200
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: <richard.purdie@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Change git fetcher not to destroy old references
Thread-Topic: [bitbake-devel] [PATCH] fetch2: Change git fetcher not to
 destroy old references
Thread-Index: AQHWVRiqjE3lK+w+mE2dyRS+YyhYhaj9dmkA
Date: Wed, 8 Jul 2020 12:12:37 +0000
Message-ID: <20200708121236.GA108868@korppu>
References: <20200708111215.375782-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20200708111215.375782-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <496D34CA08DCBD40B4F54E53E39DDC5A@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 12:12:15PM +0100, Richard Purdie wrote:
> It looks like we're about to see a lot of changes in branch names in repo=
s. If
> we have the prune option here, those old names are lost, the changes prop=
agate
> to our source mirrors and our old releases break.
>=20
> We have the force option so any replaced references should be replaced, i=
ts only
> orphaned branches which will now be preerved.

Typo: reserved.

>=20
> I believe this behaviour will cause use fewer problems given the changes =
that
> look likely to happen.

Typo: us

Thanks for this patch!

I too hope this will cause less issues when upstreams tingle with branches =
in their repos.

What annoys me slightly is that we expect a commit-id to always be in a spe=
cific branch
and don't fall back to using the commit-id from an older release tag for ex=
ample if upstream
decides to wipe all branches but still keeps the old release tags in repo. =
Of course
sometimes when this happens with our own repos it's nice to see a build fai=
lure...

Reviewed-by: Mikko Rapeli <mikko.rapeli@bmw.de>

Cheers,

-Mikko

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index dbf8715674..644ba9238b 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -355,7 +355,7 @@ class Git(FetchMethod):
>                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
> =20
>              runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, repourl), d, workdir=3Dud.clonedir)
> -            fetch_cmd =3D "LANG=3DC %s fetch -f --prune --progress %s re=
fs/*:refs/*" % (ud.basecmd, repourl)
> +            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, repourl)
>              if ud.proto.lower() !=3D 'file':
>                  bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
>              progresshandler =3D GitProgressHandler(d)
> --=20
> 2.25.1=
