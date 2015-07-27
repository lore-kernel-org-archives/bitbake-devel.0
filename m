Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id EE38573217
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jul 2015 18:02:23 +0000 (UTC)
Received: by wibud3 with SMTP id ud3so126981806wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jul 2015 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=LJFI7sCrt6BIDHOvQNK744I0/0DIdL031JV4uzqXLTM=;
	b=TsQxSjnRKTwjp1o1PtM7CBWiJ4Dy3hkqOzmX96oLUja4FHp+1gU0c9FR/aeIYh4LWX
	rbdQmPk+0cNogkrjSuS7uy4shMQAXeZpmG6Hyy0HKnD04UDjDhH1CyeZmhap/w5vAcpY
	L0pTWQZ0qDykDW1qarTK+Wolj14CE1G3PDJI5b+5svOoRSBIqcKjus8AzN2oHZbEsihW
	g3rhzCOArRdd7lB6mD+K+TYEn8fHAL3zk1w+ntZR+v0T38xbYkKiQa3HPp7OKoo4avDc
	EbgEXXYpipr8xnUMjm3fveN5mdTRtk1YkdQFPxhBkGnkL8HlYeNS86LxV1B32YVO95VI
	+HkA==
X-Received: by 10.194.58.130 with SMTP id r2mr57011833wjq.72.1438020143436;
	Mon, 27 Jul 2015 11:02:23 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	s16sm14808728wib.16.2015.07.27.11.02.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 Jul 2015 11:02:22 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Mon, 27 Jul 2015 20:02:26 +0200
To: bitbake-devel@lists.openembedded.org,
	Horace Cheung <Horace.Cheung@Arthrex.com>
Message-ID: <20150727180226.GF307@jama>
References: <A25829B3236F8A42BEC026E5505D82F31C70B6@inc-s-exc001.arthrex.local>
	<20150726223137.GB9504@jama>
	<A25829B3236F8A42BEC026E5505D82F31C81BB@inc-s-exc001.arthrex.local>
	<A25829B3236F8A42BEC026E5505D82F31C81E5@inc-s-exc001.arthrex.local>
MIME-Version: 1.0
In-Reply-To: <A25829B3236F8A42BEC026E5505D82F31C81E5@inc-s-exc001.arthrex.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: "joe_macdonald@mentor.com" <joe_macdonald@mentor.com>,
	Geoffrey Parker <Geoffrey.Parker@Arthrex.com>,
	"rongqing.li@windriver.com" <rongqing.li@windriver.com>
Subject: [1.26][backport-request] Mercurial fetcher fix Was: Inquiry about why vim_7.4.481.bb doesn't have checksum
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
X-List-Received-Date: Mon, 27 Jul 2015 18:02:26 -0000
X-Groupsio-MsgNum: 6036
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline

--XStn23h1fwudRqtG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 04:12:56PM +0000, Horace Cheung wrote:
> Martin,
>=20
> I have 1 more request. We're currently using fido branch to prototype & t=
est OE our build system migration. Since this is only 1 file change (lib/bb=
/fetch2/hg.py): https://github.com/openembedded/bitbake/commit/378647281ae8=
83dd726f1e1b775dd35ef6a0e8d1
>=20
> Is there anyway you can cherry-pick this change back to fido branch so th=
at all future poky download (https://www.yoctoproject.org/downloads/yocto-p=
roject) can include this change then? (if there is any procedure I can help=
 to make this happen, pls let me know and I can make it happen as well :)).=
=20

This belongs to bitbake-devel ML with [1.26] tag.

I believe it's this commit which fixes your issue:
commit 0e2f7e7663309daa46716e274fd85e9011120a7f
Author: Ash Charles <ashcharles@gmail.com>
Date:   Fri May 22 08:39:30 2015 -0700

    fetch/hg: Disable checksums for archived downloads

Please test it in your environment and confirm, if it's not enough, then
there are 3 more mercurial fetcher commits in bitbake/master which are miss=
ing in 1.26:

3786472 bitbake: fetch2/hg.py: fix unpack error and mirror tarball
2df35a2 fetch/hg: Disable checksums for archived downloads
0276330 fetch2/hg.py: add clean function
f002b1c fetch/hg: support submodules

Regards,

>=20
> Thanks!
> Horace
> ________________________________________
> From: Horace Cheung
> Sent: Monday, July 27, 2015 8:43 AM
> To: Martin Jansa
> Cc: rongqing.li@windriver.com; joe_macdonald@mentor.com; Geoffrey Parker
> Subject: RE: Inquiry about why vim_7.4.481.bb doesn't have checksum
>=20
> Thanks Martin. I'll check the commit history of mercurial fetcher in bitb=
ake and update the bitbake version and retest then.
>=20
> Regards,
> Horace
>=20
> ________________________________________
> From: Martin Jansa [martin.jansa@gmail.com]
> Sent: Sunday, July 26, 2015 3:31 PM
> To: Horace Cheung
> Cc: rongqing.li@windriver.com; joe_macdonald@mentor.com; Geoffrey Parker
> Subject: Re: Inquiry about why vim_7.4.481.bb doesn't have checksum
>=20
> On Mon, Jul 20, 2015 at 11:58:49PM +0000, Horace Cheung wrote:
> > Hello Rong, Joe and Martin,
> >
> > This is Horace Cheung (DevOps engineer) from Arthrex. We're currently w=
orking to transition using poky as the latest bulld version. During our pro=
totype build test, we've encountered a specific checksum error message on V=
IM package:
> >
> > ERROR: No checksum specified for /home/horace/sw-dev/yocto/poky/build/d=
ownloads/vim_vim.googlecode.com_.hg._v7-4-481.tar.gz, please add at least o=
ne to the recipe:
> > SRC_URI[md5sum] =3D "16591d520c75375570db53101afd48c9"
> > SRC_URI[sha256sum] =3D "c9120bdf0701eec9c3cfec9a16c783f68fe24708aa58b25=
979304271f190dbad"
> > ERROR: Function failed: Fetcher failure for URL: 'http://downloads.yoct=
oproject.org/mirror/sources/vim_vim.googlecode.com_.hg._v7-4-481.tar.gz;pro=
tocol=3Dhttps;module=3Dvim'. Missing SRC_URI checksum
> > ERROR: Logfile of failure stored in: /home/horace/sw-dev/yocto/poky/bui=
ld/tmp/work/armv7a-vfp-neon-poky-linux-gnueabi/vim/7.4.481-r0/temp/log.do_f=
etch.5797
> > ERROR: Task 645 (/home/horace/sw-dev/yocto/poky/meta-openembedded/meta-=
oe/recipes-support/vim/vim_7.4.481.bb, do_fetch) failed with exit code '1'
> >
> > Can you guys clarify why for this specific recipe, there is no need to =
capture the md5sum & sha256sum (i.e. SRC_URI[xxx]) into the recipe? What's =
the recommendation from the upstream community to get rid of this error wit=
hout specifying the SRC_URI checksum into the recipe?
>=20
> All recipes with SRC_URI pointing to some SCM aren't using checksums.
>=20
> mercurial fetcher in bitbake was broken for a while, you need to upgrade
> bitbake to get the fix for mercurial fetcher incorrectly requiring the
> checksums.
>=20
> >
> > Thanks & Best Regards,
> > Horace Cheung
> > 460 Ward Drive, Santa Barbara, CA 93111
> > horace.cheung@Arthrex.com | Office: (800) 933 =E2=80=93 7001 ext. 79206=
 | Cell: (805) 403 =E2=80=93 5712
> >
> > This e-mail and any files transmitted with it are the property of Arthr=
ex, Inc. and/or its affiliates, are confidential, and are intended solely f=
or the use of the individual or entity to whom this e-mail is addressed. If=
 you are not one of the named recipient(s) or otherwise have reason to beli=
eve that you have received this message in error, please notify the sender =
at 239-643-5553 and delete this message immediately from your computer. Any=
 other use, retention, dissemination forwarding, printing or copying of thi=
s e-mail is strictly prohibited. Please note that any views or opinions pre=
sented in this email are solely those of the author and do not necessarily =
represent those of the company. Finally, while Arthrex uses virus protectio=
n, the recipient should check this email and any attachments for the presen=
ce of viruses. The company accepts no liability for any damage caused by an=
y virus transmitted by this email.
>=20
> --
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlW2cjIACgkQN1Ujt2V2gBwL3QCfbtOwMctNlMII2CSztx4TnpdA
dLoAoLVrPgHsLIg3+tklSyL0KR7I6/TP
=rCzS
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
