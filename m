Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web12.11014.1612366566795936783
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 07:36:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@bmw.de header.s=mailing1 header.b=E4+YBaS6;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=661aacca0=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1612366566; x=1643902566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PDJrKsOg+BUHEpf5+On3/13ibj2VUiu3tQErPdI4Yco=;
  b=E4+YBaS6bFWD6cOFXfAAzhLKbPbZH7t0Ifcv1FUUPHxHnSyDtMfPLRQt
   mWY1gnRLI9gLlMGlkYeN034RZLyx444Kx/1wQgE/46GM21ijC/9oLTGuJ
   gFSWbcTHm6b5yWPFhfDmu3rw1qPsG7/V43o8nbTBvDEl8fxvcnt3u1voG
   g=;
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 03 Feb 2021 16:36:04 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw4.muc with ESMTP/TLS;
 03 Feb 2021 16:36:01 +0100
Received: from smucm33k.bmwgroup.net (HELO smucm33k.europe.bmw.corp) ([160.46.167.67])
 by esabb6.muc with ESMTP/TLS; 03 Feb 2021 16:36:01 +0100
Received: from smucm33l.europe.bmw.corp (160.46.167.68) by smucm33k.europe.bmw.corp
 (160.46.167.67) with Microsoft SMTP Server (TLS;
 Wed, 3 Feb 2021 16:36:00 +0100
Received: from smucm33l.europe.bmw.corp ([160.46.167.68]) by
 smucm33l.europe.bmw.corp ([160.46.167.68]) with mapi id 15.00.1497.010; Wed,
 3 Feb 2021 16:36:00 +0100
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: <steve@sakoman.com>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 0/4] Patch review
Thread-Topic: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 0/4] Patch review
Thread-Index: AQHW+jgO++g+gW85rUel15YZkuTDQKpGf1SA
Date: Wed, 3 Feb 2021 15:36:00 +0000
Message-ID: <YBrC3TDqXZ9bdllo@korppu>
References: <cover.1612361853.git.steve@sakoman.com>
In-Reply-To: <cover.1612361853.git.steve@sakoman.com>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <AD23DFDDD46A1541BF7917B3C42D2EAB@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 03, 2021 at 04:22:05AM -1000, Steve Sakoman wrote:
> Please review this set of patches for dunfell/1.46 and have comments back=
 by
> end of day Friday.
>=20
> Passed a-full on autobuilder:
>=20
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1815
>=20
> The following changes since commit 418c00c570a60845556204b4f52de047b284dd=
8e:
>=20
>   data_smart: Ensure hash reflects vardepvalue flags correctly (2021-01-2=
6 15:45:01 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://git.openembedded.org/bitbake-contrib stable/1.46-nut
>   http://cgit.openembedded.org/bitbake-contrib/log/?h=3Dstable/1.46-nut
>=20
> Matt Hoosier (1):
>   fetch/git: download LFS content too during do_fetch
>=20
> Mauro Queir=F3s (3):
>   git.py: skip smudging if lfs=3D0 is set
>   git.py: LFS bitbake note should not be printed if need_lfs is not set.
>   git.py: Use the correct branch to check if the repository has LFS
>     objects.

Acked-by: Mikko Rapeli <mikko.rapeli@bmw.de>

FWIW, I'm using git lfs on dunfell with only patches:

git.py: Search for LFS objects on the correct branch.
git.py: skip smudging if lfs=3D0 is set
bitbake: fetch2/svn: Fix SVN repository concurrent update race

but I don't see any harm in adding the fourth patch:

bitbake: git.py: LFS bitbake note should not be printed if need_lfs is not =
set.

Cheers,

-Mikko=
