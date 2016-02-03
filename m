Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id AC81B77348;
	Wed,  3 Feb 2016 15:03:27 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id p63so74555008wmp.1;
	Wed, 03 Feb 2016 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=cwIU89taT8eUVTyQKwQghsyv4kYL0A0T6bpq8+3aNFo=;
	b=JS4HYRZomP/qA0U3GQKxeGDEb3tWmZ1OQ1l2Tt5cbDwnqfc/nK0yoo62UYonQ22xNB
	EFz+j3/2OOdf8QcBWSCdI4ZiUj1/6ATkwEoDOgZWX8h9d5pcMMOScbWGTxWowyxAPS5O
	LQQdhv4uVVzrB0FFkkcruxJncTKpz1vJC/F020rAp5yJXYrDo9XG9YGoDgcxT2OvBzOm
	XVID7SK1SQeCfJEGtR+UQoDXrPGQw+Ey6yuvisMo21+W0REhWXViLFBkw2ZdHsY+E+SZ
	VpN4pWeLr/7+B1UHfMDfFsmVPBJAUEtsgAHwwahT1XT46bsHAPR1DFOkwkceuMdHnELz
	M19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent;
	bh=cwIU89taT8eUVTyQKwQghsyv4kYL0A0T6bpq8+3aNFo=;
	b=GAz3F6wikk7pdYPl6umrJjc3WaMSdHrimlbFGe5HZyU+RpyNOPbAXlkrtL9lrTOZqE
	hNgLWM+YDibI3RqhU7WbYk/fYZ7nSdKXJnCi+iZxbAsv0ZWspksGfatZO+kDarnnjZ2H
	eCleVwTjzBve86/gL1HKEdDw38CvKZRE1w5WzZgpgFE4xocx+H6+CI6cFyBzPwi5PTGY
	OjESr2ZLT03YcP+owiUSKS4wtNOkNuFpLLlm8FL83nbYbJ0k8V5kj2hidd5rB9a6AHXg
	f8jYHm9nKNXSmewri0HXFbhdfpsnanQmhsE5khKQRwPCHu/laWvA/iEfytgR//nHff9H
	/pyQ==
X-Gm-Message-State: AG10YORtFHiwrnDaWQbn08odivP3E0Q6/LCAvQtQRP9Iga/bNtcjAgxrpreIqTfcGldkww==
X-Received: by 10.194.112.41 with SMTP id in9mr2400670wjb.139.1454511808000;
	Wed, 03 Feb 2016 07:03:28 -0800 (PST)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	z127sm21907547wme.2.2016.02.03.07.03.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 03 Feb 2016 07:03:27 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 3 Feb 2016 16:06:38 +0100
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20160203150638.GB2567@jama>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
	<1454498556.27087.180.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1454498556.27087.180.camel@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio.salvador@ossystems.com.br>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 15:03:30 -0000
X-Groupsio-MsgNum: 6984
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 11:22:36AM +0000, Richard Purdie wrote:
> On Wed, 2016-02-03 at 08:11 -0200, Otavio Salvador wrote:
> > On Tue, Feb 2, 2016 at 9:55 PM, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > At some point in the future, getVar should expand by default. To
> > > get
> > > there from the current position, we need a period of time where the
> > > expand parameter is mandatory.
> > >=20
> > > This patch starts that process. Clear errors will result from any
> > > code
> > > which doesn't provide this. Layers can be fixed with an expression
> > > like:
> > >=20
> > > sed -e 's:\(\.getVar([^,()]*, [^,()]*\)):\1, False):g' -i `grep=20
> > > -ril getVar *`
> > >=20
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> >=20
> > I am in favor of making it mandatory but I fail to see what we gain=20
> > in making it expand by default in future.
>=20
> Less ugly syntax, in 99.9% of usages, you would want expand=3DTrue and
> getVar("X") is neater than getVar("X", True).

Consistent indentation is also neater than mixing tabs and spaces, but
you were refusing to take such cosmetic change and now you're proposing
neater getVar syntax which is (in some cases silently) breaking existing
metadata and make backporting changes more difficult?

I'm not opposing the change, just don't understand why the same
arguments work here and not for indentation.

Regards,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlayF30ACgkQN1Ujt2V2gBxmygCguU40y1IX2LOwthREwoUZlt7E
B/oAniGtAJK0dqXPRLo6PlFY/FjUzsHz
=YJf4
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
