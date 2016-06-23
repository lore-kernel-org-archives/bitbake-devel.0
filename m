Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id C1A546FFCE;
	Thu, 23 Jun 2016 10:21:10 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id a66so9616536wme.2;
	Thu, 23 Jun 2016 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=qP7FBmyOFKII4gJ51w5TWStakw4luCd27DlbxFvcs3A=;
	b=y1RQu1GlTFph4Ctfk665zYKbs8DHRizgwlHnzl3/FF2scWCQcT9XKCEo+JLx8gHdUF
	cwfJOPq3dAJIXLFU3EK2H0tXLpJSKOBDu8DvUQcOQoAwJ2OHb8xHBohQJy0/7YODAL6r
	bM51bi9DT614tPZJw8I8prBv9qqm3PrY9/qqty3T+EM1xx+vQ0WUlejTUAXbVEw8dRiX
	VZFVwZ7Q3GZg+g8WcllfkaziJaYO2pNOTNt1aCqQCfZuraDIcR2bhBBzt7MOOnOnvxfi
	pO+oEdmyqfpVjV5Wk+xst9wGVaB7zOD9IhVREeCWP1s4wY6p/rHr87ehE81UQF0cpdvL
	ua+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=qP7FBmyOFKII4gJ51w5TWStakw4luCd27DlbxFvcs3A=;
	b=Nk5iPFsTMeFCs0VF/xrRAVinr1R/Rc8xtBb8LhYYeZRyopzt9mBcLwRlk8fAW03Ugd
	uVX5kAaMVUdgTneL3WIHH9LAOgVJ5wNj5fkwQYaQ7IvnXSMwN7b6UrAuLulzitN8t+SO
	YCSel3hXMt4AhiquYt3NPPUBd1X5n/PkfFxEhQ+GlaNVtqtZjMWbu3M3vawYoY7K9VY1
	Ogu8s2Mh5nlJunH6p0411+tXFuOYr32xtHALwHWZtlZJU9kLCgT75LQRZY85jemWCcGC
	sczLeLRSHHxg7PAL315VS6WpJMIgcWqNHDwrwpRbPHfBDOsTTDrkP2RGyubJStTF0BoK
	IW+Q==
X-Gm-Message-State: ALyK8tK0rAo66Vs/xDqhbkYHZAVEchuKVvRtZE1cYdxcQWdaDOGDi9ByaXOhdUjjuPR/zw==
X-Received: by 10.28.224.69 with SMTP id x66mr13034142wmg.89.1466677271460;
	Thu, 23 Jun 2016 03:21:11 -0700 (PDT)
Received: from localhost (ip-89-176-104-169.net.upcbroadband.cz.
	[89.176.104.169])
	by smtp.gmail.com with ESMTPSA id k6sm3650133wjz.28.2016.06.23.03.21.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 Jun 2016 03:21:10 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Thu, 23 Jun 2016 12:21:38 +0200
To: Michael Halstead <mhalstead@linuxfoundation.org>
Message-ID: <20160623102138.GA2567@jama>
References: <13986bd3-af12-4768-0a4c-78447c33c8b6@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <13986bd3-af12-4768-0a4c-78447c33c8b6@linuxfoundation.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Cc: yocto@yoctoproject.org, Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel@lists.openembedded.org,
	Openembedded-devel@lists.openembedded.org,
	Openembedded-core@lists.openembedded.org
Subject: Re: [yocto] Patchwork users: Help test new version
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
X-List-Received-Date: Thu, 23 Jun 2016 10:21:15 -0000
X-Groupsio-MsgNum: 7602
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2016 at 10:47:16AM -0700, Michael Halstead wrote:
> Hello,
>=20
> OpenEmbedded is nearly ready to upgrade to a new version of Patchwork.
> The new version offers several new features that will allow OpenEmbedded
> to improve developer workflow and automated checks on incoming patches.
>=20
> If you are a Patchwork user please visit
> https://patchwork-next.openembedded.org/ and take a look. If you find
> anything amiss please e-mail me directly and include patchwork in the
> subject line.
>=20
> Thank you for your help upgrading this important system!

I was using it to update meta-oe/master-next in last few days and it
seems to work the same as old patchwork for me.

But quite often I've noticed very slow response, is it running on
slower HW while testing or is the new version just a lot slower?

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAldruCgACgkQN1Ujt2V2gBwgPQCfYHbLjnHn3pjTP/YHXoUHWAVZ
KocAoKj1yLQp5ooBXz9WUaXJypP1TJDT
=ANzc
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
