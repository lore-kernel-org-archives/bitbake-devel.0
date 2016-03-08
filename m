Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 106986018C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 12:33:41 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id p65so25561612wmp.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Mar 2016 04:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=BjFMoade30//1xZhPrwxF3cXqaxB1Ht9RflJnXk8g04=;
	b=r7WKDWPcyemUbdfNK3SV4IOeE56SrzvN1M8gBkuA+IIB5qn1b4/tAqAVetJp6+3J2C
	tZmAw18ivlpD/JunnMMzfK1cpM93av5ggdWhAEWth8OUDT2GfE1FrgessvhG1Z0lrItO
	uHJRNCreKVy8qtG3mwrY5fD/70wf7N6SwUIR+0hK9Svv34E8Iug9F6J/9s/Mi6rCYXkI
	rmDheSOGk2NJnX6IByIT7ZEfChxmJeYKsh/F4g9kASasUqrxkUTI4iRlXrvtq2iy7ppP
	EcApThZaZVBduNQAZnM77QzE9owBbPz3bQS3Gc60EFKG2NAMlfFbR/x3s6TGWcgQjvNC
	qMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=BjFMoade30//1xZhPrwxF3cXqaxB1Ht9RflJnXk8g04=;
	b=OcOTO6nD52/TduEpH2RzgW4ZmmFPfSr87zdhpE3IUsNxvA2gU3GB96h+5b95HfbBCu
	/TTCHQfUFKPFY4/+Z2i1NbrZ5pAZc5v/U+7ICLq9dFyt8XyyFYFj+gzBgXOuvc63CrYP
	CeHSOYdnd7ZgKwcId/d9SoxLTl4mQgOYaok5TPE/3lBAEquW3Ynp+FcB/ABc3CmsU9Z8
	zodMCKf7tBEQWnFHohGfEhQ8OUVJKNfe0DCBL6RdCGHyX4hYo0rk84u3udfpaGazRQxg
	h/+8XluOL3R8Zoj5J7nUln6gdA0uB/7waJuRgr489nd3Sr9QxSJCwwhKwf13mV0N1hW6
	aOtw==
X-Gm-Message-State: AD7BkJIPlGrHjhT4iA2Oc9XauYdAAwUg9EYhtlo0qtVgifJ7OWfgKuzmZQR7zUYppohCTw==
X-Received: by 10.194.58.234 with SMTP id u10mr28816400wjq.174.1457440421881; 
	Tue, 08 Mar 2016 04:33:41 -0800 (PST)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	73sm18731669wmy.22.2016.03.08.04.33.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 08 Mar 2016 04:33:40 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 8 Mar 2016 13:36:21 +0100
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Message-ID: <20160308123621.GB2551@jama>
References: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
	<1457087406.3285.3.camel@linux.intel.com>
	<20160307192120.GA5834@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20160307192120.GA5834@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] xmlrpc: fix bug in setting XMLRPCServer.single_use
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
X-List-Received-Date: Tue, 08 Mar 2016 12:33:42 -0000
X-Groupsio-MsgNum: 7159
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 09:21:20PM +0200, Ed Bartosh wrote:
> On Fri, Mar 04, 2016 at 10:30:06AM +0000, Joshua G Lock wrote:
> > On Fri, 2016-03-04 at 10:13 +0200, Ed Bartosh wrote:
> > > XMLRPCServer.single_use attribute was always set to False.
> > > This caused xmlrpc server to keep running after build is done as
> > > BitBakeServerCommands.removeClient only shuts down server if its
> > > single_use attribute is set to True.
> > >=20
> > > Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> > > ---
> > > =A0bitbake/lib/bb/server/xmlrpc.py | 3 ++-
> > > =A01 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/bitbake/lib/bb/server/xmlrpc.py
> > > b/bitbake/lib/bb/server/xmlrpc.py
> > > index 1ceca51..d627550 100644
> > > --- a/bitbake/lib/bb/server/xmlrpc.py
> > > +++ b/bitbake/lib/bb/server/xmlrpc.py
> > > @@ -193,6 +193,8 @@ class XMLRPCServer(SimpleXMLRPCServer,
> > > BaseImplServer):
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0BaseImplServer.__init__(self)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (interface[1] =3D=3D 0):=A0=A0=A0=A0=A0=
# anonymous port, not getting
> > > reused
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0self.single_use =3D True
> > > +=A0=A0=A0=A0=A0=A0=A0=A0else:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0self.singe_use =3D False
> >=20
> > This won't work, right? Typo.
> >
> Why do you think so? It works for me so far :)

Then this change is useless, isn't it? Nothing is using singe_use
variable (with missing "l").

>=20
> --
> Regards,
> Ed
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlbex0QACgkQN1Ujt2V2gBwa2gCfZPe+LC7whjA2336ZGV3/DwXF
LJAAoKStT+xW/9mB9tt61jmT2p/6Wat4
=6jCq
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
