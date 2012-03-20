Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>) id 1S9yFD-0006gt-3O
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 13:32:55 +0100
Received: by wera1 with SMTP id a1so6779137wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Mar 2012 05:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=subject:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to:x-mailer
	:x-gm-message-state;
	bh=AOqsSOsv/SKmqBRLkFD/RyQFBXy/84zNYGY9QiWrKWA=;
	b=hvHofgG5iGEIx1H/8JF1T7MOO/oBAuDFEfaNuXftWQ4XSaQx4zQN6kjg146b8zT5kz
	SwYzNurk0b52eDhHh0jSIVw9qzDcfGgpSIj31bJ5E0bB27IR5UhSCk8eEsX7vSYfcKRU
	ih0QyryYpgOMuSUy3xdGKAnjdR2KC3yLSLbBTlBWJw406TmpPtzbzkm4azk0kuZDFEX0
	AZ6mR7QzkKIOMur8NNTV1eaiEsu9qLS2O4xTTkSmh2E5QnOgJQ1n58EnOYQnnbuCAROL
	M9zAr5dymGquYtBtF6R+ra88c8BJBerOWFBvX9dHiJygQngaU/lDU+DMqXb959RzHftV
	FWUg==
Received: by 10.216.133.39 with SMTP id p39mr8965392wei.40.1332246242797;
	Tue, 20 Mar 2012 05:24:02 -0700 (PDT)
Received: from [172.20.0.96] (ip545070eb.adsl-surfen.hetnet.nl.
	[84.80.112.235])
	by mx.google.com with ESMTPS id e6sm33637840wix.8.2012.03.20.05.24.01
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 20 Mar 2012 05:24:01 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1257)
From: Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <1331852164.18586.166.camel@ted>
Date: Tue, 20 Mar 2012 13:24:00 +0100
Message-Id: <A4FAC08D-E547-40BF-9CAF-98D82B152CE9@dominion.thruhere.net>
References: <1331852164.18586.166.camel@ted>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
X-Mailer: Apple Mail (2.1257)
X-Gm-Message-State: ALoCoQlbzja+J2VymYGDGIKn29ioe3j/JmcVnNA51DaNjEGfnazNMsHhVTJNIxSXDduZ8ojnl8YE
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] ui/knotty: Add a footer to the build output for interactive terminals
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 20 Mar 2012 12:32:55 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Op 15 mrt. 2012, om 23:56 heeft Richard Purdie het volgende geschreven:

> I've sent this before, this is an updated version with several =
bugfixes
> and improvements. Its a major change but one I think people will like
> overall as I hear a lot of complaints about the verbose console
> messages. v0 never got complaints so I will merge this fairly quickly
> unless there are objections.
>=20
> ---
> On terminals which support it, add summary information to the end of =
the
> build output about the number of tasks currently running and how many =
tasks
> we've run so far.
>=20
> This provides a summary at a glace of what the current state of the =
build is
> and what the build is currently doing which is lacking in the current =
UI.
>=20
> Also disable echo of characters on stdin since this corrupts the =
disable,
> particularly Crtl+C.
>=20
> The "waiting for X tasks" code can be merged into this code too since
> that is only useful on interactive terminals and this improves the
> readability of that output too.
>=20
> Improvements since v0:
>=20
> * The tasks are ordered in execution order.
> * The display is only updated when the list of tasks changes or there
>  is output above the footer.
> * Errors early in the init process don't corrupt the terminal
> * Running task x of y and package messages are suppressed from the =
console

I like it a lot, but there is one missing thing. Have a look at the =
following output:

-------------------------------------------
Loading cache: 100% =
|#########################################################################=
##########################################################################=
##########################################################################=
##########################################################################=
##########################################################################=
###################| ETA:  00:00:00
Loaded 2642 entries from dependency cache.

OE Build Configuration:
BB_VERSION        =3D "1.15.1"
TARGET_ARCH       =3D "arm"
TARGET_OS         =3D "linux-gnueabi"
MACHINE           =3D "beaglebone"
DISTRO            =3D "angstrom"
DISTRO_VERSION    =3D "v2012.03-core"
TUNE_FEATURES     =3D "armv7a vfp neon cortexa8"
TARGET_FPU        =3D "vfp-neon"
meta-angstrom     =3D "master:51ba0dd081af1d7de56ffc9fb318044bc3c7c47e"
meta-oe          =20
meta-efl         =20
meta-gpe         =20
meta-gnome       =20
meta-xfce        =20
meta-initramfs    =3D "master:b0a7f2e761f79e8967b1d3f7c67177283805bf75"
meta-opie         =3D "master:efa3892b20a4ef80274e56e5633ebd62c16f9731"
meta-java         =3D "master:e90110b85733f9cdda26861bc29588257173c11c"
meta-ti           =3D "master:8f1fc028be8567c57ed7d40b1800ece37128b9ac"
meta-efikamx      =3D "master:2c09a3a780b23448e8a6ca964256ff7f5ccba65d"
meta-nslu2        =3D "master:3d9fc951b05b4df476374b6fc3085ebac7f293ee"
meta-htc         =20
meta-nokia       =20
meta-openmoko    =20
meta-palm         =3D "master:57cd9600e285f394873b943644879b166a256769"
meta-handheld     =3D "master:f2904e00c9c709d1f40e4a93f0f552f882bacf4f"
meta-intel       =20
meta-sugarbay    =20
meta-crownbay    =20
meta-emenlow     =20
meta-fishriver   =20
meta-jasperforest=20
meta-n450         =3D "master:9124870a6bcd99ebaeb0342f4fedf14dc1afebd8"
meta              =3D "master:c981fa4fad8a457882293157b7bdca05aad5a778"

NOTE: Resolving any missing task queue dependencies
NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 3179 tasks of which 3165 didn't need to =
be rerun and all succeeded.
-------------------------------------------

What did I just build? A mention of the '<foo>' in 'bitbake <foo>' would =
be nice :)

regards,

Koen=


