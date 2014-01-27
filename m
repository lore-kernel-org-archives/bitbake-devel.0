Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f181.google.com (mail-ea0-f181.google.com
	[209.85.215.181])
	by mail.openembedded.org (Postfix) with ESMTP id 658896C76F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 08:52:28 +0000 (UTC)
Received: by mail-ea0-f181.google.com with SMTP id m10so2144696eaj.40
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=my4hZPbUowtl3xY9C3RhndqfVI03QGYdB9kLYcZpsI0=;
	b=eiWzQ6WaqqqTdwYuvuZIw69xGSIPmHGFFTBbxa52vghO3gVw1AvuGLXMRlYDF0ap93
	1Cjsh5oD/mOhQW+vycghd3TRWsCOzgei+tOgp6zN4ASfnAfqBXJefI/8wkmPnzJy22Up
	ZjakMFcxjvkse044hVpO6sFvB6sIOFuLkoxAJ7kzg58yE2kZqIw8zcoLPp4A/lxSjvjS
	JGKv+u7NB4RHPRbW7ro1JhZG1uFbbmZfDgoWiMHIW2/wxcWUlnaG6vOLER1wzu0k8wJD
	NJSFm17TTKIvHJOuL5ngIy5hvd1q7YgkLp294A96dN//c/PhmK0xOQSQ0M3pEWx9Kg9f
	LHQA==
X-Received: by 10.14.175.2 with SMTP id y2mr7562297eel.75.1390812748624;
	Mon, 27 Jan 2014 00:52:28 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107]) by mx.google.com with ESMTPSA id
	j46sm39641014eew.18.2014.01.27.00.52.26 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 Jan 2014 00:52:26 -0800 (PST)
Date: Mon, 27 Jan 2014 09:52:32 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140127085232.GE3718@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
	<1388619481.11527.98.camel@ted> <20140110141417.GR3709@jama>
MIME-Version: 1.0
In-Reply-To: <20140110141417.GR3709@jama>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Mon, 27 Jan 2014 08:52:29 -0000
X-Groupsio-MsgNum: 4369
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline

--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 03:14:17PM +0100, Martin Jansa wrote:
> On Wed, Jan 01, 2014 at 11:38:01PM +0000, Richard Purdie wrote:
> > So can we find the "least delta" fast? Its not actually that hard
> > computationally or on resources, at least in the experiments I've made.
> > We know the hashes of the current target's tasks and we can quickly tell
> > which are in the cache and which are not (using the same function sstate
> > uses for that purpose).
>=20
> I've finally got some numbers to support my claim that it "feels" slower
> with this added functionality.
>=20
> My script is calling
> openembedded-core/scripts/sstate-diff-machines.sh --machines=3D"qemuarm q=
emux86 qemux86copy" --targets=3Dworld --tmpdir=3Dtmp-eglibc/;
>=20
> which in turn runs
> bitbake -S world
> three times (once for each machine).
>=20
> The script on jenkins doing world builds is completely crazy (I've
> killed it in last run assuming it was stuck, but it wasn't just terribly
> slow).
> http://jenkins.nas-admin.org/job/oe_world_compare_signatures/11/
> Running 21 hours already and doing 2nd machine from 3 (maybe because
> longer SSTATE_MIRROR?). There is one python process using 100% cpu.

FWIW: this jenkins job was completed yesterday after 16 days

small part of strace:
http://logs.nslu2-linux.org/buildlogs/oe/oe-shr-core-branches/log.world.201=
40109_144047.log/log.strace

complete log:
http://logs.nslu2-linux.org/buildlogs/oe/oe-shr-core-branches/log.world.201=
40109_144047.log/signatures.sstate-diff-machines

Previous runs of the same job took 25-40 minutes

> In local builds without SSTATE_MIRROR it's not so bad, but still
> significantly slower with each release (dylan-dora-master).
>=20
> Master builds have that WIP patch included in order to finish.
>=20
> It's not very accurate, because it was running on my desktop and each one=
 has
> different metadata, but at least the layers included are similar (only
> systems which got separated in dora and removal
> of meta-webos-backports which isn't needed for dora and newer).
>=20
> At least I've executed each test twice.
>=20
> dylan:
> real   9m37.271s
> user   6m37.104s
> sys    3m12.625s
>=20
> real   10m5.787s
> user   6m37.832s
> sys    3m23.614s
>=20
> dora:
> real   26m11.374s
> user   9m7.325s
> sys    3m0.048s
>=20
> real   28m10.606s
> user   8m27.895s
> sys    2m57.497s
>=20
> master:
> real   38m17.641s
> user   17m46.905s
> sys    5m12.061s
>=20
> real    36m12.748s
> user    16m32.961s
> sys     4m43.103s
>=20
> master-without-S-changes:
> real    27m34.228s
> user    8m6.811s
> sys     2m53.724s
>=20
> real    27m49.752s
> user    8m25.026s
> sys     2m50.921s
>=20
> --=20
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com



--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLmHlAACgkQN1Ujt2V2gBwMNgCdFJTTUrJnGnKkYTaYE0Ao4uxO
1i8AniL9PU3PPGcbjaZkfGGKaa+DB+Y6
=xboT
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
