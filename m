Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.1076.1588117954158118503
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 16:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=CmKETI0P;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1407; q=dns/txt; s=axis-central1;
  t=1588117954; x=1619653954;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BxVBxamllLwZ2hrbvPJgjw9ox+ZuWkdEEezn3uw51oU=;
  b=CmKETI0PrL34rSRNJgwvBCHq7Lk+osS5x+2GqiuJieinQYYlqCAiebMD
   y4ixbzqCxNt0hT6nVNN2JKbnks+nJjOGcq238KN/z/T4fOvBjF0D7h3oW
   WZQUiRckk0fCykzwh3wlPVO8GbaeB/9gWGW9lsBE7DxdgIYITSW5x1uXa
   k79D8XzTUHgiE73+1AFihwauk7A+4VfJiFy+Pq8nwrUyKppqzorLLiRVm
   6YWDW095u6+6gyEV2K4eAw/HR9qnoLB9VBianazQXCwQ57tjHJ/uAhgAD
   bIM6iaDKWY1DQQAurVrEZ6hGbD/8t7ctWACcY9F4QC0u2lh9+3yqg/5AP
   Q==;
IronPort-SDR: /I6FjoE23HypiBACc6Tkj5ZqmJpptHH8lhl3bzCxppL9RqK4f4ZTpK3/EIZ+DWwhB5MMTfdOP2
 s5w/XDnZjXxluTBdX768h2GeVif6kfC6+0l90pptyzNrw8udBze9ixV8g9g6COMc0Q9k6kjfqc
 rmP4n6cYZDVna0j2bcGJ0UL+uGahRkhM4296v7xQtwD79fqpX4wq/DliM+TeoYSPKL+6hxSBUc
 Hw34lcQmTITM/8ck2sb7zgj9quRSAL8xYBrZAcPewXgdbk6/HjxVIW6Secd1PjBg84SOLQ9l0o
 gTs=
X-IronPort-AV: E=Sophos;i="5.73,328,1583190000"; 
   d="scan'208";a="8190946"
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Mauro Ziliani <mauro@faresoftware.it>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Skipping recipe.bb or recipes.bbappend
Thread-Topic: [bitbake-devel] Skipping recipe.bb or recipes.bbappend
Thread-Index: AQHWHaV7bg7zCt9H+0CLDGPwSgJSaqiPMwGQ
Date: Tue, 28 Apr 2020 23:52:30 +0000
Message-ID: <9f8360317f2c4850a3861f0e091da896@XBOX03.axis.com>
References: <d744891c-c4a6-9567-e042-d3e33f84805b@faresoftware.it>
In-Reply-To: <d744891c-c4a6-9567-e042-d3e33f84805b@faresoftware.it>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Mauro Ziliani
> Sent: den 28 april 2020 23:39
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] Skipping recipe.bb or recipes.bbappend
>=20
> Hi all.
>=20
> I developed a small app for Yocto Pyro on IMX6DL, engicam platform
>=20
> Now I'd like to port the same layer to openstlinux stm32mp1.
>=20
>=20
> Some recipe.bbappend cannot be use with openstlinux layers because the
> "mother" recipe.bb is missing.
>=20
>=20
> How can I skip the recipes.bbappend uneeded?
>=20
> i.e.
>=20
> Engicam give me the recipe engicam-linux-fslc.bb and I addes
> engicam-linux-fslc.bbappend
>=20
> Now in openstlinux engicam-linux-fslc.bb doesn't exists and I need skip
> the .bbappend.
>=20
>=20
> Which is the right mode to skip engicam-linux-fslc.bbappend if I use my
> layer in openstlinux?
>=20
>=20
> Thanks to all
>=20
>=20
> MZ

You can use BBFILES_DYNAMIC to make your bbappend file available=20
depending on the presence of the engicam layer with the=20
engicam-linux-fslc.bb recipe. See meta-oe for an example of=20
BBFILES_DYNAMIC in action.

Alternatively you can use BBMASK to instruct bitbake to ignore=20
certain recipes and/or bbappend files. Notice that BBMASK is=20
made up of regular expressions.

//Peter

