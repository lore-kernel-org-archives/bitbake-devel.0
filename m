Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 3A0E275546
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 01:11:14 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so15745949wrw.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=L5763iNDVVvHRIYrUPZcHw5NrR1hGuNlZuAXxIx75xc=;
	b=Aae5ElMIZTO7GlnVOfmDjD7abem6U9uheJm9x2GNjqwdK87oig7590Ko1N5fpiVgoU
	gKIc7git1FxOO7BvDW24ZVlGuwOfAh2fbbbNv5YwH4DdhHaZr1CxNSji8AiNzfif216D
	ByzEtja7oosHtLTYWzWxCRWWunuSquvRBFPVaADJP0s+jkjv9r0mnzocvgDajO3OvpHx
	44AULLrlNNWoncwNu0jsrR2fTykKso5BK+RLSZhBUbPy/BvtZMY8BuhKW9Pke7j7XmWZ
	gwwtsdfMKNL6k6zN4dEQBoij5Hcc90k22b5WTI5nIfkNu3rtt36zUJRm9WOoNo7y8n+W
	40Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=L5763iNDVVvHRIYrUPZcHw5NrR1hGuNlZuAXxIx75xc=;
	b=PHtMP0iQntFQDMb7pgrQ3pXoOr8qc2KxlbPMrXBWY1laslDI7YtDYgo7yJLu7Mz0AN
	43E/N8WIfrzNKdsA0iiKFoZZSu/rj6knMPshN7EpqtbZHLGCyjZwMsBBB9llOkOREfBH
	ElYBGkiZE4B5Krk9oEsb9yS1N+OMsnLfuml6RP7xKnY/NHehMLNkPO3t7OoCEJpM0lO1
	aOaLQBvCyPTAd46O8CSz+jSUmlyc7lHhzqkEpUiVGGgfgDpEDPturIOOXP8EVxZ13/IO
	OGWhQ3j9h1jIiOL77khWZn0E6h/hs81pWitrnLOoA+kV7368z+X+ltr+nUWQwGfroxGa
	4+ag==
X-Gm-Message-State: AOUpUlGqthU7t2uKgIdEy2oOAejJrLXjGSTB3DiMJ1jBvlGVT/ZkL8og
	P+F0WLuyjPXhmi1exqL21Zw=
X-Google-Smtp-Source: AA+uWPw3E/2cYzCpU4R2Y71NzI9X+ivI0eN/STLSUe1l+woIwzS//LKRgQpwR614Yk+Ae6SSVy9JYQ==
X-Received: by 2002:a5d:63c1:: with SMTP id
	c1-v6mr11863646wrw.106.1534209074915; 
	Mon, 13 Aug 2018 18:11:14 -0700 (PDT)
Received: from localhost ([217.30.68.212]) by smtp.gmail.com with ESMTPSA id
	m68-v6sm26292283wmb.10.2018.08.13.18.11.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 Aug 2018 18:11:13 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 14 Aug 2018 03:11:19 +0200
To: Alexander Kanavin <alex.kanavin@gmail.com>
Message-ID: <20180814011119.GA1391@jama>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 01:11:14 -0000
X-Groupsio-MsgNum: 9493
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 11:20:50PM +0200, Alexander Kanavin wrote:
> 2018-08-13 23:04 GMT+02:00 Andreas M=FCller <schnitzeltony@gmail.com>:
> > To get most out of build host, bitbake now detects if the CPU workload =
is low.
> > If so, additional tasks are spawned. Maximum 'dynamic' tasks are set by
> > BB_NUMBER_THREADS_LOW_CPU.
>=20
> So the best improvement is going from 114.5 minutes to 113.5 minutes?
> I don't think it's worth the trouble. Maybe it's time to invest in 16
> (or even 32!) core amd threadripper? :)

IMHO the best improvement was for 3 BB_NUMBER_THREADS and possibly even
bigger improvement for 2 BB_NUMBER_THREADS.


>  2                 | 156m48.741s
> ------------------------------------
>  3                 | 126m27.426s
> ------------------------------------

=2E..

> With the patch applied and BB_NUMBER_THREADS_LOW_CPU =3D "20" (as
> written in docs
> for max thread count)
>=20
>  BB_NUMBER_THREADS | Build time [s]
> ------------------------------------
>  3                 | 114m48.105s

I'm running with 2 BB_NUMBER_THREADS on similar HW (8core Bulldozer
FX(tm)-8120, 32GB ram), because it leaves the desktop usable for other
stuff while some build is running on background.

With 4 BB_NUMBER_THREADS, big build and a bit of bad luck I was getting
4 do_compile tasks like qtbase, chromium, firefox and gimp at the same
time which either makes me drink too much coffee or even invites uncle
OOMK.

I quite like the idea behind BB_NUMBER_THREADS_LOW_CPU.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCW3IsNgAKCRA3VSO3ZXaA
HOHNAJ4usn2DtJLs4BJRzNtzm2t88u/oNQCfZswbp0SifIaxXcpgKbWzLRHqiWs=
=zAaZ
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
