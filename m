Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id C79616E665
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 09:15:08 +0000 (UTC)
Received: by wmec201 with SMTP id c201so15606634wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=N1R60SuSQHTtkH08f5cHmWC55eHf0TBzigohjSY7Thk=;
	b=CXPBbKNIkLepovtMXvLDd1KDYovwPtaymOJGgVroA59/Ip+IToiKvwAu7sp9UDoREc
	xssjK7eCPRhkctMbebj6zv0kj1joVfr2pL6coPl3i0iCzs6DwQphyGb7dfSxXs4nUUUD
	D7xumBu9uQ+1DiNjxs7kx3rM4142FuiZnX5HR8rK8gM6/UKvJ4RGLGSnepNyGHf2+C5v
	ha/HO2GFgkonScCm9ygLTl6Gb1GvGv1d9ON4i7L79eHIfkyTXLmTm3fkIvXIEpxl1Qpr
	VL+aIfSHKJlrzl/MKuYCdYZ6f1xtwWkuV7gclwsXrqPv2MDhij+KSg+pMoGzXrbcacgP
	6f7g==
X-Received: by 10.194.114.34 with SMTP id jd2mr11523144wjb.12.1449738908579;
	Thu, 10 Dec 2015 01:15:08 -0800 (PST)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	q6sm11398861wjx.28.2015.12.10.01.15.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 10 Dec 2015 01:15:07 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Thu, 10 Dec 2015 10:16:51 +0100
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Message-ID: <20151210091651.GE2246@jama>
References: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
	<CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: PREFERRED_VERSION with % wildcard picking unexpected version
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
X-List-Received-Date: Thu, 10 Dec 2015 09:15:11 -0000
X-Groupsio-MsgNum: 6744
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline

--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2015 at 12:27:36AM +0100, Nicolas Dechesne wrote:
> On Tue, Dec 1, 2015 at 6:13 AM, Andre McCurdy <armccurdy@gmail.com> wrote:
> > I have two recipes within a single layer:
> >
> >   stblinux_3.14-1.7.bb
> >   stblinux_3.14-1.8.bb
> >
> > If PREFERRED_VERSION_stblinux is set to "3.14%", then I would expect
> > the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
> > selected instead.
> >
> > Reversing the order of files stored in pkg_pn[pn] seems to help. Is it
> > a reasonable solution?
>=20
>=20
> I have a somewhat similar issue..
>=20
> in oe-core we have GCCVERSION set to 5.%, if I add meta-linaro layer
> which has gcc_5.1.bb (while OE has gcc_5.2.bb), I am seeing this:
>=20
> $ bitbake -e gcc | grep ^PV
> PV=3D"5.1.0"
>=20
> While I would expect 5.2.0 to be picked up.
>=20
> This patch does not fix this issue, btw.
>=20
> If I remove gcc_5.1.bb from my layers, then I can see:
>=20
> $ bitbake -e gcc | grep ^PV
> PV=3D"5.2.0"

PREFERRED_VERSION was always meant to identify only 1 provider, the wildcard
is used only to say that you cannot specify the exact value - e.g. for
floating versions from SCM.

So if you have a layer with another recipe with version matching "5.%"
you're supposed to set PREFERRED_VERSION to more specific version.

See longer explanation in:
http://comments.gmane.org/gmane.comp.sysutils.bitbake.devel/1038

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZpQwIACgkQN1Ujt2V2gByzSwCcCYmt1GLQrLqH6uVjmnyakXdx
UgQAn0GP4GFUPmCn6R/X3Nlp6LVX3Pv+
=XM8d
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
