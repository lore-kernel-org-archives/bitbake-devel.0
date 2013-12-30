Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f172.google.com (mail-ea0-f172.google.com
	[209.85.215.172])
	by mail.openembedded.org (Postfix) with ESMTP id 18BE16B4F0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 16:35:32 +0000 (UTC)
Received: by mail-ea0-f172.google.com with SMTP id q10so4423022ead.17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=g5XxKd7dAgcujtkc21iHf0MFqpueE9f1FBi9lt1MYeI=;
	b=CH+W1WKxrtUBlNXDP+DcUItOSeLAUH0TtO2UbRdpWEJj5HaE3fukM+AlA05bSjKO34
	EWfimk/VaGsWcCqjCv2HD/Kn/U3m7C9nBrSqVw80DYwd+jjUTMh+0gyQQNHSbDJ+YYBx
	dgzStOfPn/eJc0Q+l7wRyWVCHW1vk5b9tuxNeEmSBsMmbz8I9PqbAUHoRWbX4Er3fMx5
	GRTu6VugHRKKZAjgXcPze1PQlR05/9kePWFDbb/PgcMQMam5q5o+3w6So5gELGY7CkT3
	C1cqJHc60ewK1Gge+uqEpWm4/3HRRNv+neNGaTPuccIW5Kx9BorYpuHIKrNj43u1MWVk
	SgIg==
X-Received: by 10.14.99.129 with SMTP id x1mr2522640eef.89.1388421333654;
	Mon, 30 Dec 2013 08:35:33 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107]) by mx.google.com with ESMTPSA id
	b41sm110139175eef.16.2013.12.30.08.35.32 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 30 Dec 2013 08:35:32 -0800 (PST)
Date: Mon, 30 Dec 2013 17:35:34 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Message-ID: <20131230163534.GB3719@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 30 Dec 2013 16:35:34 -0000
X-Groupsio-MsgNum: 4264
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline

--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2013 at 09:29:38AM -0700, Chris Larson wrote:
> On Mon, Dec 30, 2013 at 9:18 AM, Chris Larson <clarson@kergoth.com> wrote:
>=20
> > On Sat, Dec 28, 2013 at 6:24 AM, Martin Jansa <martin.jansa@gmail.com>w=
rote:
> >
> >> On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie wrote:
> >> > Its useful to understand where the delta starts against an existing
> >> sstate cache
> >> > for a given target. Adding this to the output of the -S option seems
> >> like a
> >> > natural fit.
> >> >
> >> > We use the hashvalidate function to figure this out and assume it can
> >> find siginfo
> >> > files for more than just the setscene tasks.
> >>
> >> I haven't tried to find smaller reproducer or exact part of code where
> >> it happends, but in bigger builds I have it fails with
> >>
> >> I'll try to reproduce and narrow it a bit, but if you have tip where
> >> to look first..
> >>
> >> IndexError: list index out of range:
> >
> >
> > I=E2=80=99m hitting this now as well.
>=20
>=20
> To clarify further, I=E2=80=99m hitting this with stock poky master, qemu=
x86,
> bitbake -S core-image-base.
>=20
> Actually, this is getting in my way trying to do something I don=E2=80=99=
t want it
> doing anyway. I want to dump the signature data from one config, and use
> bitbake-whatchanged from another build. If I wanted to compare something
> right here, I=E2=80=99d have run bitbake-whatchanged. This change confuse=
s me a
> bit. -S emits signature data, according to the bitbake help and the
> semantics of the command. Are we trying to kill bitbake-whatchanged in
> favor of making -S do both jobs, emit and compare?

Same here, I'm using bitbake -S from
oe-core/scripts/sstate-diff-machines.sh

and this added analysis and output is IMHO very useful, but it would be
nice to control it with some new option (and keep default -S behavior
fast and simple).

It looks like the error is triggered for every task which wasn't built
before (e.g. running bitbake -S with empty sstate-cache/tmp-eglibc or
bitbake -S world after bitbake some-image).

I see it for many do_fetch and do_rm_work_all tasks.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLBoNYACgkQN1Ujt2V2gBxQegCgihAGFWkmKOFw9ZqUZS341eEb
BzIAoKzwnNSsYyz8Sn2miu+ABuMkvIw2
=95dk
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
