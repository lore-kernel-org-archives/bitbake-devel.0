Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.10591.1631104577089446956
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Sep 2021 05:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Z2P/UueR;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631104577;
  x=1662640577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LbLz/kiNIYOpUv7re304QHg+qn86dwzQ02JAiSx4pw0=;
  b=Z2P/UueRAHvIC/HjJG1z9hZeeg/gGpBHPMZNFG6NYHKz5sYKI5b6Q9IY
   6DJ4iUmAzJxOfNbCdwqeBN7ZOFT93/buvWpPaqxC+haefoyQzZJu7dOfM
   XR1naiujzndD1tTskIC9h2LWIzxDGuYdUTo4IwIITgLEk6IsZFjQFN66h
   +fOZ+VtEKTrAiYMaW+/9QLWHi24QMNU8yHRJwIFlguYcDhTj+4qA+k1yN
   aSTekb9/ULLILCb2lZvoA9bhkii1iCls72HOfKY1bWdLyrRcgSs7V9of9
   wjZtOO71zXsMVKZ7MRTxi1WOp7/UY+vQl/cuNzHzauzPpuNNZ1psuhYOL
   w==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>,
	Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
Thread-Topic: [bitbake-devel] [PATCH] cooker: Only warn on potentially
 incompatible layer
Thread-Index: AQHXoNAQaBJnWwx8q0O9hdgDaJMYF6uZ7gkGgAArvYA=
Date: Wed, 8 Sep 2021 12:36:12 +0000
Message-ID: <077e555a9d32412d83eedaa347a1eff4@axis.com>
References: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl>
 <lyv93b9yr7.fsf@ensc-virt.intern.sigma-chemnitz.de>
In-Reply-To: <lyv93b9yr7.fsf@ensc-virt.intern.sigma-chemnitz.de>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Enrico Scholz via
> lists.openembedded.org
> Sent: den 8 september 2021 11:56
> To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially
> incompatible layer
>=20
> "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl> writes:
>=20
> > It frequently happens that the 3rd party layer is, in practise,
> > fully compatible with the older version of yocto. So, instead of
> > false positively reporting an error, it seems to be more
> > appropriately to just emit the warning.
>=20
> You can achieve this already now (when you are really sure that it works
> for your bsp).  Just set
>=20
> | LAYERSERIES_COMPAT:<foreign-layer>:append =3D " frodo"
>=20
> in your bblayers.conf.

Minor detail: LAYERSERIES_COMPAT is among the variables that have=20
not been changed to use the new override format, so the above should=20
be:

LAYERSERIES_COMPAT_<foreign-layer>:append =3D " frodo"

> Enrico

//Peter

