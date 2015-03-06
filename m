Return-Path: <martin.jansa@gmail.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id C985D6017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 12:22:32 +0000 (UTC)
Received: by wggx13 with SMTP id x13so19536626wgg.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Mar 2015 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=h9mjrhGcVze09Oh5jyVKNtvkW/RHmBo79z+ESOGYrGA=;
	b=DlmMoN9YRwa19q+zGekAESup3NAeoZdTi3kVTar1qvyr8XQ2O9jiWgJ2yVrZBki06r
	frIVifsDYacGFgZ86TepQLQck+wvr9LLyO2qZB+465MVgykoDzUf5EyUhJzSdD2pi7na
	rb1xGyiE56cz831Hi2mTbNu6rujVFrohPPnfD2dmCb0cbdZ3P75hJjgfjO+RiXCBTgOw
	RwHQMy6PI8gN4J90u+oxWlhaE4nEs6388/PoFlSAsSlRowc839dXqqaz+CznN207yJh7
	URG1PD0ClHwDD9OwDJtG72DVRPmLzqfKT/Xdpz6X2g4Z7IScoYzQOO56WvSSN9ZbBmso
	jn5g==
X-Received: by 10.194.75.168 with SMTP id d8mr29145962wjw.87.1425644554038;
	Fri, 06 Mar 2015 04:22:34 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	md2sm5891293wic.19.2015.03.06.04.22.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Mar 2015 04:22:32 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Fri, 6 Mar 2015 13:22:38 +0100
To: Clemens Lang <clemens.lang@bmw-carit.de>
Message-ID: <20150306122238.GF2337@jama>
References: <20150227120026.GA13973@ulm-bmuc496424.bmw-carit.de>
	<20150306114328.GN5023@ulm-bmuc496424.bmw-carit.de>
MIME-Version: 1.0
In-Reply-To: <20150306114328.GN5023@ulm-bmuc496424.bmw-carit.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571
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
X-List-Received-Date: Fri, 06 Mar 2015 12:22:34 -0000
X-Groupsio-MsgNum: 5498
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NpJxosW6I2mTcxQ7"
Content-Disposition: inline

--NpJxosW6I2mTcxQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 12:43:28PM +0100, Clemens Lang wrote:
> Hello,
>=20
> On Fri, Feb 27, 2015 at 01:00:26PM +0100, Clemens Lang wrote:
> > Here's the patch, please review and consider applying:
>=20
> Any feedback on this? Anything I can do to get this reviewed?

FWIW: I like this, we were hit by this issue when the archive is
modified in premirror and builders are happily using it, because there
is .done file next to it.

This will at least fix the case when the file is intentionally modified
and checksums are updated in recipe to prevent re-using stalled file
=66rom some premirror.

Using pickle is much better than counting the checksums on every
do_fetch.. we have GBs of sources and we don't want to spend extra
minutes on the build to re-check them if they are identical. Maybe add
the file time stamp as well, if the file was modified then .done could
be invalidated and checksums re-verified.

Regards,
--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--NpJxosW6I2mTcxQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlT5nA4ACgkQN1Ujt2V2gBwexwCfdEi/qSRahmzdwcH5uEzmsvby
kS8AnjPoY9tkhc4ptSxfLs56Jp8pgogH
=ixmj
-----END PGP SIGNATURE-----

--NpJxosW6I2mTcxQ7--
