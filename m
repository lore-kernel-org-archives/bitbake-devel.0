Return-Path: <martin.jansa@gmail.com>
Received: from mail-ve0-f180.google.com (mail-ve0-f180.google.com
	[209.85.128.180])
	by mail.openembedded.org (Postfix) with ESMTP id C915B65D20;
	Tue,  6 May 2014 18:09:06 +0000 (UTC)
Received: by mail-ve0-f180.google.com with SMTP id db12so7669116veb.11
	for <multiple recipients>; Tue, 06 May 2014 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=J9ENx/wUtye5UCGmeCN3scVT5wMDfc/8nofhZzUxoGE=;
	b=q2mclvJ6g1nbI/R2AUQeGZVBpb0kJDMqHifb0fT5DuGntosb2VO097FSVVhsYgSn6P
	RzOK00nwDJZB6cQqvhmUmTo7tqpLhI6uUWrrl3/6EewjHd9aQCXVePKYKvahywD+44XV
	QNXf2r8xRe+PdgYKjTeL4LLiL75qwqpWxlknSXpMpJWzsrQxied0FRis41//vwXD8hYK
	+iJIijR4/9blyZvOMIT+ykk5Wj/npt+RYN3doYKXR0u8yWuPI1XPCDz8R0F+X6aJpD1m
	GxVgIGjiesMb6rsAshyUn7sngNr9YJSGLZZr+Rc5uYEbd2nq0baClfsgikgMeu2y70mr
	YK4A==
X-Received: by 10.52.72.4 with SMTP id z4mr1618194vdu.71.1399399747118;
	Tue, 06 May 2014 11:09:07 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	xr10sm17305670vec.2.2014.05.06.11.09.05 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 May 2014 11:09:06 -0700 (PDT)
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 6 May 2014 20:09:26 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20140506180926.GB30955@jama>
References: <53691266.2090107@intel.com>
	<CAMKF1so2Zrx0D39wkGj0xYSbGOKu7Kd3iMS6D=6_+yjj2vGYXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMKF1so2Zrx0D39wkGj0xYSbGOKu7Kd3iMS6D=6_+yjj2vGYXA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>,
	Yocto Project Discussion <yocto@yoctoproject.org>,
	"poky@yoctoproject.org" <poky@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Saul Wold <saul.wold@intel.com>
Subject: Re: [OE-core] Daisy Stable Branch - open for patch suggestions
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
X-List-Received-Date: Tue, 06 May 2014 18:09:11 -0000
X-Groupsio-MsgNum: 4702
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2014 at 10:55:59AM -0700, Khem Raj wrote:
> Saul
>=20
> On Tue, May 6, 2014 at 9:48 AM, Saul Wold <saul.wold@intel.com> wrote:
> >
> > [Sorry for the overlap, want to make sure I hit a broad audience]
> >
> > Hi Everyone!
> >
> > I will be the stable maintainer for the Daisy branch, and it is now ope=
n for
> > suggestions of backport patches.  I am starting to generate a list of
> > patches that are already in master.
>=20
> Thanks for helping with 1.6/daisy
>=20
> >
> > The following wiki page has the Policies and process for requesting a f=
ix in
> > a stable branch, please review that before sending a patch.
> >
> > https://wiki.yoctoproject.org/wiki/Stable_branch_maintenance
> >
> > Please remember to include [daisy] in any request (backport or commit).
> >
>=20
> I already have a patch posted for daisy back port.
> see http://comments.gmane.org/gmane.comp.handhelds.openembedded.core/50627

I'm preparing patches I would like to see in daisy in
contrib/jansa/daisy-backports branch, I'll send it to ML when I consider
them ready, e.g. top 7 commits:
http://git.openembedded.org/openembedded-core-contrib/log/?h=3Djansa/daisy-=
backports

> > We do not have a hard date for this yet, but likely be in late May - ea=
rly
> > June time frame for the 1.6.1 release.
> >
> > Thanks to all for your efforts.
> >
> > Sau!
> > --
> > _______________________________________________
> > Openembedded-core mailing list
> > Openembedded-core@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/openembedded-core
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlNpJVYACgkQN1Ujt2V2gBzEVQCfcZ3wSzmF4QQcwPmLccmGy57x
NvMAoIgXLZPhU5UDYTpfdutvfB0yY9Tz
=MM9P
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
