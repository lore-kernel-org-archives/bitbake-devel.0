Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1RscvV-0007Rn-30
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 17:20:53 +0100
Received: by eaal10 with SMTP id l10so87457eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Feb 2012 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=1XWT0dGnQqxDzU9px8Fw74GpUFKqXHTz3nv7M8ZfQtg=;
	b=Gbw0pbiBXOay8jGPT2PNw0QdUxGqBUldPpYu06cvmeyZiV756gZ/oENGOxziOzb0uO
	dYAzYZmUz4GDvMXnqOGUXANqOpVMkuw0Kjf6U4oBmxSkwJMJF4+JhFbLoVNfJ9JJrsNv
	FiGyTd/IxZQNUbs7Hc9ObJEpw3dKfijQDZv/w=
Received: by 10.213.109.6 with SMTP id h6mr4178205ebp.137.1328112777934;
	Wed, 01 Feb 2012 08:12:57 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id b49sm100489050eec.9.2012.02.01.08.12.55
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 01 Feb 2012 08:12:56 -0800 (PST)
Date: Wed, 1 Feb 2012 17:12:54 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20120201161254.GB6969@jama.jama.net>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Patches and discussions about the oe-core layer
	<openembedded-core@lists.linuxtogo.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 16:20:53 -0000
X-Groupsio-MsgNum: 936
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline

--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2012 at 08:04:14AM -0800, Khem Raj wrote:
> Hi
>=20
> patchwork instance that we have currently handles patches for
> oe-devel, oe-core and bitbake
> layers which use oe-devel maintain and use the patch queues ok so it
> makes sense to have it
> there. But patch flow for oe-core and bitbake is handled differently
> via pull requests. Would it
> make sense to turn it off for these two projects. Is someone using
> patchwork and/or finds
> it useful to have the patchwork catch those patches please let me know

I'm using it sometimes to check if some patch I've sent to list wasn't
overlooked.

But I can live without it if it adds some administrative or other burden
on servers.

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEUEARECAAYFAk8pZIYACgkQN1Ujt2V2gBywSACXffc0SbtlAIoYBjnQ12f9ZmEG
BwCgufxpbN5EdRNY7rrEnlH1rquV4yw=
=9q37
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
