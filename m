Return-Path: <raj.khem@gmail.com>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
	[209.85.216.170])
	by mail.openembedded.org (Postfix) with ESMTP id A54AD7570D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 06:25:14 +0000 (UTC)
Received: by qcxw10 with SMTP id w10so14222163qcx.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:content-type:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=T5Bxr4/nlN1dri2FwKcESnByE5zEKBij7Izn4+Gx5do=;
	b=r6cjYMSoSYZuvn+baTfK22J7Ei3Xgy+C6vf+Z3gr3zFJlCG+4sdkxxlwItoEMhk2xl
	89npIcRCe77RknXh3bcheMUzabhBJlwwoNJk90Nj4BZ6K4aHzNCcxwS8l3ySUmykwcjK
	I5CiYf0TNLTr/7kgZF0RPjwLCTmB/gXcV+8PKJ6ILSEsAT7NA4sjgpzUCVD1z2ylPmja
	QiNY2SZt7URC3uetPEABl1wUkgEhEHGODUgjUtKK65SOAtKsF0lyzx9cK/lIyv/+MzmR
	efj4dk4bdxkrqml6elMCOepvTMkEhC2XyzToJeb/+ZgzYIRmkhVsVogAcPOG/zX5pclW
	Cn3A==
X-Received: by 10.140.144.73 with SMTP id 70mr41969859qhq.91.1433399115381;
	Wed, 03 Jun 2015 23:25:15 -0700 (PDT)
Received: from ?IPv6:2601:9:3580:84c:243b:97d2:82f:b7e8?
	([2601:9:3580:84c:243b:97d2:82f:b7e8])
	by mx.google.com with ESMTPSA id g6sm1858494qgd.10.2015.06.03.23.25.14
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 03 Jun 2015 23:25:14 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
X-Pgp-Agent: GPGMail 2.5b6
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
Date: Wed, 3 Jun 2015 23:25:08 -0700
Message-Id: <B8A83673-75A0-4880-97BE-1712A4093058@gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
	<CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
	<CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
X-Mailer: Apple Mail (2.2098)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Thu, 04 Jun 2015 06:25:18 -0000
X-Groupsio-MsgNum: 5819
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F7312BD0-61EC-45DE-97D5-510887B465DF";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_F7312BD0-61EC-45DE-97D5-510887B465DF
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_9AE15857-9E0A-4B54-835E-5B647E92135C"

--Apple-Mail=_9AE15857-9E0A-4B54-835E-5B647E92135C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jun 3, 2015, at 2:47 PM, Burton, Ross <ross.burton@intel.com> =
wrote:
>=20
> That QA test is over-keen and that's a false-positive, but the real =
fix is in your makefile.  Pass -module -avoid-version to libtool as =
you're building modules, not libraries.
>=20

you will then hit the .so not being symlink QA errors

--Apple-Mail=_9AE15857-9E0A-4B54-835E-5B647E92135C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jun 3, 2015, at 2:47 PM, Burton, Ross &lt;<a =
href=3D"mailto:ross.burton@intel.com" =
class=3D"">ross.burton@intel.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div =
style=3D"font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D"">That QA test is =
over-keen and that's a false-positive, but the real fix is in your =
makefile.&nbsp; Pass -module -avoid-version to libtool as you're =
building modules, not libraries.</div><br =
class=3D"Apple-interchange-newline"></div></blockquote></div><br =
class=3D""><div class=3D"">you will then hit the .so not being symlink =
QA errors</div></body></html>=

--Apple-Mail=_9AE15857-9E0A-4B54-835E-5B647E92135C--

--Apple-Mail=_F7312BD0-61EC-45DE-97D5-510887B465DF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlVv70gACgkQuwUzVZGdMxQg5ACeO296cCFc2MGyl6bGOFQAmcTe
/jMAn3rWyvckJ7MQ1Csk/K4Sk1W4N1hG
=IJ5u
-----END PGP SIGNATURE-----

--Apple-Mail=_F7312BD0-61EC-45DE-97D5-510887B465DF--
