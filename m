Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S1vg2-0000SL-7f
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 09:11:22 +0100
Received: by eekc1 with SMTP id c1so321305eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Feb 2012 00:02:56 -0800 (PST)
Received-SPF: pass (google.com: domain of martin.jansa@gmail.com designates
	10.213.35.65 as permitted sender) client-ip=10.213.35.65; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of martin.jansa@gmail.com
	designates 10.213.35.65 as permitted sender)
	smtp.mail=martin.jansa@gmail.com;
	dkim=pass header.i=martin.jansa@gmail.com
Received: from mr.google.com ([10.213.35.65])
	by 10.213.35.65 with SMTP id o1mr2963646ebd.128.1330329776516 (num_hops
	= 1); Mon, 27 Feb 2012 00:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=resent-from:resent-date:resent-message-id:resent-to:date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:content-disposition:in-reply-to:user-agent;
	bh=3frcBCldBcX0066x0tG8IBWbKsIJWhXN+0HD5a2BxMs=;
	b=SFochJZRREFhcK/hHMZJFB/0EdBW/UJpjcE3G58VO7mqnuWN0QjXLkVphbe6OZuKH2
	TpZ3/WWQNbYuFe5W1f4IfPuIEhAXsOU1yYTTw0xp2OU8hI8deVmTJZrgygz9EinBCMDD
	wD01G/wSvstsKPMiJq4iBMiU/bgcMxcjoI2do=
Received: by 10.213.35.65 with SMTP id o1mr2214497ebd.128.1330329776374;
	Mon, 27 Feb 2012 00:02:56 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id n52sm55275669eea.5.2012.02.27.00.02.55
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 27 Feb 2012 00:02:55 -0800 (PST)
Resent-From: Martin Jansa <Martin.Jansa@gmail.com>
Resent-Date: Mon, 27 Feb 2012 09:02:54 +0100
Resent-Message-ID: <20120227080254.GE3859@jama.jama.net>
Resent-To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id z7sm7853424eef.9.2012.02.26.22.48.34
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 26 Feb 2012 22:48:35 -0800 (PST)
Date: Mon, 27 Feb 2012 07:48:33 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Message-ID: <20120227064833.GD3859@jama.jama.net>
References: <4F48217F.6040406@opendreambox.org>
	<1330153006.1957.10.camel@dongxiao-osel>
	<4F4A7A46.9060104@opendreambox.org>
	<CA+chaQc0Oh1LL_P5ynnt-E6QSe9OBa-DT9UgxUeyj0SGooHpXA@mail.gmail.com>
	<1330303296.7571.13.camel@dongxiao-osel>
MIME-Version: 1.0
In-Reply-To: <1330303296.7571.13.camel@dongxiao-osel>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: cache broken in master
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
X-List-Received-Date: Mon, 27 Feb 2012 08:11:22 -0000
X-Groupsio-MsgNum: 1066
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline

--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2012 at 08:41:36AM +0800, Xu, Dongxiao wrote:
> On Mon, 2012-02-27 at 00:05 +0100, Martin Jansa wrote:
> > On Sun, Feb 26, 2012 at 7:30 PM, Andreas Oberritter
> > <obi@opendreambox.org> wrote:
> > > Hello Dongxiao,
> > >
> > > On 25.02.2012 07:56, Xu, Dongxiao wrote:
> > >> On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
> > >>> Hi,
> > >>>
> > >>> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
> > >>> dependency cache for me, i.e. it parses all recipes on every invoca=
tion
> > >>> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache d=
idn't
> > >>> help. Reverting this commit restores the functionality.
> > >>
> > >> Hi Andreas,
> > >>
> > >> Sorry for the inconvenience that this commit brought to you.
> > >>
> > >> Could you help to try the following and send me your "/tmp/1.log
> > >> and /tmp/2.log"?
> > >>
> > >> 1) apply the attached "cache_debug.patch"
> > >> 2) remove tmp/cache
> > >> 3) bitbake -p &> /tmp/1.log
> > >> 4) bitbake -p &> /tmp/2.log
> > >>
> > >> Besides, you can have a try of the attached cache_whitelist.patch to=
 see
> > >> if it fixes your problem.
> >=20
> > I see the same change in behavior here.
> >=20
> > > your patch cache_whitelist.patch fixes the problem. Thanks!
> >=20
> > unfortunately doesn't seem to fix it here.
> >=20
> > I'll send requested debug info tomorrow, unless someone beats me to it
>=20
> Thanks Martin.
>=20
> Andreas, it seems that the cache case in your side is different with
> Martin's. So hope you can also send me your debug info, I am really
> appreciate for that.

Hi,

sorry for noise, but it seems it does work with your patch now.. maybe
it was because yesterday I was fixing those quoting errors and it didn't
save cache because it found parsing error in the process and then I was
switching machines and it's probably expected to reparse all once for
each machine (as the cache is at least here in machine specific path
tmp-eglibc/cache/default-eglibc/om-gta02).

Cheers,

>=20
> Thanks,
> Dongxiao
>=20
> >=20
> > >
> > > Regards,
> > > Andreas
> > >
> > > _______________________________________________
> > > bitbake-devel mailing list
> > > bitbake-devel@lists.openembedded.org
> > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> >=20
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>=20
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9LJ0EACgkQN1Ujt2V2gBzL3ACgsGPN5M+cyuybiwq+Sapnu33D
nfAAn0gbpevwayD2xuTj0uT71hbQQDRv
=SmR4
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
