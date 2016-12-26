Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 978F660778;
	Mon, 26 Dec 2016 07:42:58 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id m203so51976088wma.3;
	Sun, 25 Dec 2016 23:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Gkuw5kLUKDZxDLBJeICGbpEL2QNSknHHTE/+CkbGXfg=;
	b=hdQUJXl4G3Jg+W4WRvuW1PeFs0wLRzvKulAp4x7D37VS+rMHtgFJwGHCuDIyLfFI34
	0nJycxcsmtfTYnhq8Hv4YuXqY8QvKhNk26o7zPRfNHur1I3ROxexfc2BRGO1Djmp5dG0
	CU8WmnIuiRF265jA4ZBIdW9dYlizOPvktStN5g6cZz5ww/TcFkSr9wo33U6Aogp3hYEo
	zElQjroLoa8ZaAhJloveJ+qLtGwp1/EHGZe5v12rM6RA01sQ51Rq2sZlkOc1VhzbT0Yu
	QBKh6ocoyVNYW+QeIGc+XyAUAzacuBr6oRIuvcFZaVUtBGUPduEHvBPfZSIdEo2xR5nk
	3z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Gkuw5kLUKDZxDLBJeICGbpEL2QNSknHHTE/+CkbGXfg=;
	b=fPp5wjNcZYduf7u0HVzqzMGxUOG3Tfm13Eoe7/sBdb1UYi9hZXXlcXzmgHqr32gqQr
	T7XnCS0sdVjev7j3f0RWXMeU5vEa50qfQlFQcWrSidrjWNeI5TScWpjqY9ER6oKXsGPB
	cvFGNw6a0893MX8D+gIv46BzmFp8f+JV9cgwjGh1r5sWw8ep3AuLdRNIoj9vgFt44wBn
	rb63cTTXMiCMfbe/sPwBf+nQhafZpmgPY0yo4IzjvtzSRjKNLD+J1OL3JN09Ksayth5/
	nGduYKkWdf1eYIo5lIUfAfv02Z0T9vmp1gNExHGir1a1XPCgC9CbSm4NFNFNajFUYWao
	O4QA==
X-Gm-Message-State: AIkVDXIoYqYDsjLi4pM/6F9uG09eO/T2nRkCmI7WWs8tbSfdNBGvUHfHgLtthSgI5Y4U7A==
X-Received: by 10.28.111.139 with SMTP id c11mr24317738wmi.139.1482738179237; 
	Sun, 25 Dec 2016 23:42:59 -0800 (PST)
Received: from localhost ([217.30.68.212])
	by smtp.gmail.com with ESMTPSA id 6sm53537207wjt.5.2016.12.25.23.42.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 25 Dec 2016 23:42:57 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Mon, 26 Dec 2016 08:43:00 +0100
To: Michael Halstead <mhalstead@linuxfoundation.org>
Message-ID: <20161226074300.GB3242@jama>
References: <CAHQecY48gVbt4S+88MHivSbv-Xdn29WRq5RPL6+QDVGYUPCwYw@mail.gmail.com>
	<E628426E-84F8-4EA4-A296-D32C3339DF1C@gmail.com>
	<CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>
	<74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org,
	openembedded-devel@lists.openembedded.org,
	yocto-infrastructure@yoctoproject.org
Subject: Re: [oe] Infra Full Stop 12/26-12/29
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 26 Dec 2016 07:42:59 -0000
X-Groupsio-MsgNum: 8322
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 25, 2016 at 08:06:50PM -0800, Michael Halstead wrote:
> In preparation for the scheduled maintenance I have moved
> git.openembedded.org to a new server temporarily. E-mail and Patchwork
> hooks may not work correctly. All other git operations as well as
> listings at http://git.openembedded.org/ should continue working.
>=20
> If you have a git remote pointed directly at openembedded.org it will
> fail. Please update your remote to point at git.openembedded.org and try
> again.

It doesn't seem to be working here:

error: Could not fetch origin
fatal: unable to connect to git.openembedded.org:
git.openembedded.org[0: 104.236.212.160]: errno=3DConnection refused
git.openembedded.org[1: 2604:a880:800:10::2127:2001]: errno=3DNetwork is un=
reachable

But that's OK for me, I was prepared to do some holiday celebrations
thanks to planned downtime :). And I have some local mirrors in case
I got tired of celebrations before the downtime is over.

> Other services that will stay up during the maintenance are:
>=20
> Layerindex https://layers.openembedded.org/
> Mailman http://lists.openembedded.org/
> Patchwork https://patchwork.openembedded.org/
>=20
> I'd like the share my appreciation for the OpenEmbedded volunteer
> sysadmins who are taking time away from their holiday celebrations to
> make this downtime as convenient for the rest of us as possible.
>=20
>=20
> On 12/22/2016 09:19 AM, Tom King wrote:
> > Schedule is  06:00UTC 27DEC16 for the full stop.  Things will start com=
ing
> > back (estimated) about 48hrs later.
> >
> > Tom
> >
> > On Tue, Dec 20, 2016 at 11:16 AM, Khem Raj <raj.khem@gmail.com> wrote:
> >
> >>> On Dec 20, 2016, at 10:50 AM, Tom King <ka6sox@gmail.com> wrote:
> >>>
> >>> Hi All,
> >>>
> >>> We have been looking for a time when we could do a full stop of the i=
nfra
> >>> to upgrade some bits and clear out some faults.
> >>>
> >>> This will involve shutting down the main machine that we use for *mos=
t*
> >> of
> >>> the OE infra.
> >>>
> >>> Our goal is to put up a backup git master but other services such as:
> >> wiki,
> >>> patches, etc will be offline for some or all of that period.
> >>>
> >>> We have delayed doing this much needed maintenance to try to work aro=
und
> >>> Yocto and OE release schedules and it is necessary that we take this =
time
> >>> to do the work.
> >>>
> >> I guess, you need to come up with a tentative down-time schedule.
> >>
> >>> Tom
> >>> (for the OE Infra Team)
> >>> --
> >>> _______________________________________________
> >>> Openembedded-devel mailing list
> >>> Openembedded-devel@lists.openembedded.org
> >>> http://lists.openembedded.org/mailman/listinfo/openembedded-devel
> >> --
> >> _______________________________________________
> >> Openembedded-devel mailing list
> >> Openembedded-devel@lists.openembedded.org
> >> http://lists.openembedded.org/mailman/listinfo/openembedded-devel
> >>
>=20
> --=20
> Michael Halstead
> Linux Foundation / SysAdmin
>=20
>=20




> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCWGDKAwAKCRA3VSO3ZXaA
HKWuAJ0UrA+4vVn4zTpxl1wKwlTLnUicLACeIO6YJIvZiwwbZMD//8QuGeoj9LQ=
=EAJu
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
