Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S7xDn-00088p-T4
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 00:03:07 +0100
Received: by wibhj13 with SMTP id hj13so2983295wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2012 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=b56piZn0R/bD9g7uTgPjcXLPOBCyo1ynjKrsQOVeTD8=;
	b=X8pavb4UGUz3R+BcmllH8hlAjyOnw5b6d3mtro/ARzX0VEu6Vx/utmhC+OoGJ0OKg4
	Y4W28paSzXRIAWXcrk0NSPY4ZKySyk64ZvUoKvKVKJ3ZIo3B/fkXWuvm9KoNJ4kigslW
	AYZdjXnA2XP8kl7P66CLhvZwq5+Ro2l0BrWibojjLQS/bOXzob2g1K8Fn7RZseF47AR9
	tZ009vNqZ50wIFmV8x3YazsDo3rj8pbe0yMJzWUyhdGicXDZCNYQudw7xoDQihqM6LWf
	h78JG5IkWS6icicvUinSVsvFAz84R0hHNHydIQXf6tTUgy8xOVrmux34sIH7iQ/I8nwu
	2meQ==
Received: by 10.180.85.70 with SMTP id f6mr21115597wiz.5.1331765662104;
	Wed, 14 Mar 2012 15:54:22 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id k7sm123583wia.5.2012.03.14.15.54.20
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 14 Mar 2012 15:54:21 -0700 (PDT)
Date: Wed, 14 Mar 2012 23:54:18 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Andreas Oberritter <obi@opendreambox.org>
Message-ID: <20120314225418.GB3823@jama.jama.net>
References: <4F610F03.1070201@opendreambox.org>
MIME-Version: 1.0
In-Reply-To: <4F610F03.1070201@opendreambox.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: PREFERRED_VERSION and wildcards
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
X-List-Received-Date: Wed, 14 Mar 2012 23:03:08 -0000
X-Groupsio-MsgNum: 1270
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline

--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2012 at 10:34:59PM +0100, Andreas Oberritter wrote:
> Hi,
>=20
> I just tried using wildcards, like it's done for gcc, e.g.:
>=20
> PREFERRED_VERSION_foo =3D "1.2%"
>=20
> Now, if I have two foo recipes, foo_1.2.1.bb and foo_1.2.3.bb, in the
> same directory, then Bitbake always chooses 1.2.1 instead of the one
> with the higher version number. Does bitbake always choose the first
> matching version it can find? Is this a general limitation of wildcards,
> or is this a problem that can get corrected? I'd expect it to choose the
> highest matching version.

If you want highest then why do you specify P_V at all? or are those
1.2% foo with e.g. negative D_P? or is there 1.3 you don't want?

It will use first provider which matches (in highest usable prio/D_P group).

    sortpkg_pn =3D sortPriorities(pn, dataCache, pkg_pn)
    # Find the highest priority provider with a PREFERRED_VERSION set
    (preferred_ver, preferred_file) =3D findPreferredProvider(pn, cfgData, =
dataCache, sortpkg_pn, item)
    # Find the latest version of the highest priority provider
    (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataCache, sortp=
kg_pn[0])

    if preferred_file is None:
        preferred_file =3D latest_f
        preferred_ver =3D latest

It was added mostly to cover use case with e.g. 1.2+svnr1337 or 1.2+gitrCAF=
EBABE where=20
you don't care about exact revision, but you know that you want 1.2 from sc=
m (and there
is just one which matches).

See this thread for details:
http://lists.linuxtogo.org/pipermail/bitbake-devel/2009-September/000458.ht=
ml

Cheers,

>=20
> Regards,
> Andreas
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9hIZoACgkQN1Ujt2V2gBzUzQCgkvF1/Z7c9KnPliQqH0RQK8fg
N8MAnjrmmRFFspZ2k1Z9eO4Zc4yPgBAD
=v+/o
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
