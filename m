Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S8T3y-0006Mz-Fg
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 10:03:07 +0100
Received: by wera1 with SMTP id a1so3713952wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Mar 2012 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=+Doo/q86v3onVaqMWe7c88I7XKDLGlXdPk0AwIvLVH8=;
	b=z9PRWWlr8jljXiHrJcgBnhEEIyI6wg3gM+mac/oORSj2BkimpaJbo57s7i+ixRzBeR
	p9RDBoBcJhRCWGH6XfZOIqqlrRcLyOOIZcfFJ0xg+DXVlpQrwvtzm658/ithCHotCX7r
	lKEHxj0YFv8S1TMQZFiXvQt0dhCudBTy4Vb08QtcYEYhQ6RcRTvUBEVI2vwYLOTFPd0O
	2TmR8qE9maQYc/8JJO6N5+lA57ObDhVsveDlYDI0zsMFO1YrKe3YBfYZcvcikp0ltmdq
	n/OTdQGiUUbNFpyk9v+0+xJ1WMvd6/WMkyZ6ncPdszRFaxZt+syKc8GtbnFTkgI9V/+S
	XNXQ==
Received: by 10.216.132.202 with SMTP id o52mr991480wei.106.1331888059203;
	Fri, 16 Mar 2012 01:54:19 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id fw5sm12124085wib.0.2012.03.16.01.54.17
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Mar 2012 01:54:18 -0700 (PDT)
Date: Fri, 16 Mar 2012 09:54:16 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Message-ID: <20120316085416.GC3855@jama.jama.net>
References: <4F48217F.6040406@opendreambox.org>
	<1330153006.1957.10.camel@dongxiao-osel>
	<CA+chaQc2o276Mxh8_3fnLTdqkUEZdb2476WEt7pY2=mitj1S1w@mail.gmail.com>
	<1331886496.1977.8.camel@dongxiao-osel>
MIME-Version: 1.0
In-Reply-To: <1331886496.1977.8.camel@dongxiao-osel>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 16 Mar 2012 09:03:07 -0000
X-Groupsio-MsgNum: 1308
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 04:28:16PM +0800, Xu, Dongxiao wrote:
> On Sat, 2012-03-10 at 08:44 +0100, Martin Jansa wrote:
> > On Sat, Feb 25, 2012 at 7:56 AM, Xu, Dongxiao <dongxiao.xu@intel.com> w=
rote:
> > > On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
> > >> Hi,
> > >>
> > >> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
> > >> dependency cache for me, i.e. it parses all recipes on every invocat=
ion
> > >> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache di=
dn't
> > >> help. Reverting this commit restores the functionality.
> > >
> > > Hi Andreas,
> > >
> > > Sorry for the inconvenience that this commit brought to you.
> > >
> > > Could you help to try the following and send me your "/tmp/1.log
> > > and /tmp/2.log"?
> > >
> > > 1) apply the attached "cache_debug.patch"
> > > 2) remove tmp/cache
> > > 3) bitbake -p &> /tmp/1.log
> > > 4) bitbake -p &> /tmp/2.log
> > >
> > > Besides, you can have a try of the attached cache_whitelist.patch to =
see
> > > if it fixes your problem.
> >=20
> > Today I noticed another cache rebuild, here is diff from parse output:
>=20
> Hi Martin,
>=20
> Could this issue be reproduced stably in your environment? Or it happens
> occasionally?

I can reproduce XAUTHORITY change very easily, will try to reproduce
BBINCLUDED ordering change.

Cheers,

> It seems that this kind of order change in variable values will also
> impact the siggen result. Richard, do you have any comment on this one?
>=20
> Thanks,
> Dongxiao
>=20
> >=20
> > 3286c3286
> > < XAUTHORITY: /root/.xauthljqB8X
> > ---
> > > XAUTHORITY: /root/.xauth1of3YX
> > 3532c3532
> > < PSEUDO_BUILD: 2
> > ---
> > > PSEUDO_BUILD: 0
> > 5223c5222
> > < _: /OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin/pseudo
> > ---
> > > _: /usr/bin/bitbake
> >=20
> > and long one BBINCLUDED where only order of some items was changed:
> > @@ -21,13 +21,14 @@
> >  /OE/shr-core/meta-smartphone/meta-shr/classes/shr-mirrors.bbclass
> >  /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.=
inc
> >  /OE/shr-core/meta-smartphone/meta-openmoko/conf/machine/om-gta02.conf
> > -/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
> >  /OE/shr-core/openembedded-core/meta/classes/package.bbclass
> >  /OE/shr-core/openembedded-core/meta/conf/abi_version.conf
> >  /OE/shr-core/meta-handheld/conf/layer.conf
> >  /OE/shr-core/openembedded-core/meta/classes/license.bbclass
> >  /OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/preferred-sh=
r-versions.inc
> > +/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
> >  /OE/shr-core/openembedded-core/meta/conf/distro/include/default-versio=
ns.inc
> > +/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
> >  /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default=
=2Einc
> >  /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv=
4.inc
> >  /OE/shr-core/meta-smartphone/meta-samsung/conf/layer.conf
> > @@ -37,7 +38,6 @@
> >  /OE/shr-core/openembedded-core/meta/conf/distro/defaultsetup.conf
> >  /OE/shr-core/meta-jama/conf/layer.conf
> >  /OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf
> > -/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
> >  /OE/shr-core/meta-smartphone/meta-aurora/conf/layer.conf
> >  /OE/shr-core/openembedded-core/meta/classes/debian.bbclass
> >  /OE/shr-core/openembedded-core/meta/conf/layer.conf
> >=20
> > 391c391
> > < BBINCLUDED: /OE/shr-core/conf/local.conf
> > /OE/shr-core/conf/local-builds.inc
> > /OE/shr-core/openembedded-core/meta/classes/patch.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/machine-sdk/x86_64.conf
> > /OE/shr-core/meta-smartphone/meta-palm/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/conf/documentation.conf
> > /OE/shr-core/meta-openembedded/meta-oe/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/tclibc-eglibc.i=
nc
> > /OE/shr-core/openembedded-core/meta/classes/packagedata.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/default-provide=
rs.inc
> > /OE/shr-core/openembedded-core/meta/classes/package_ipk.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/logging.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/devshell.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/insane.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/sstate.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/as-needed.inc
> > /OE/shr-core/meta-openembedded/meta-gpe/conf/layer.conf
> > /OE/shr-core/meta-smartphone/meta-htc/conf/layer.conf
> > /OE/shr-core/meta-smartphone/meta-openmoko/conf/layer.conf
> > /OE/shr-core/conf/bblayers.conf
> > /OE/shr-core/meta-smartphone/meta-shr/classes/shr-mirrors.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.i=
nc
> > /OE/shr-core/meta-smartphone/meta-openmoko/conf/machine/om-gta02.conf
> > /OE/shr-core/openembedded-core/meta/conf/bitbake.conf
> > /OE/shr-core/openembedded-core/meta/classes/package.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/abi_version.conf
> > /OE/shr-core/meta-handheld/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/classes/license.bbclass
> > /OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/preferred-shr=
-versions.inc
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/default-version=
s.inc
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.=
inc
> > /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4=
=2Einc
> > /OE/shr-core/meta-smartphone/meta-samsung/conf/layer.conf
> > /OE/shr-core/conf/auto.conf
> > /OE/shr-core/meta-smartphone/meta-fso/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/classes/staging.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/distro/defaultsetup.conf
> > /OE/shr-core/meta-jama/conf/layer.conf
> > /OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf
> > /OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
> > /OE/shr-core/meta-smartphone/meta-aurora/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/classes/debian.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/world-broken.inc
> > /OE/shr-core/meta-openembedded/meta-initramfs/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/classes/prserv.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/rm_work.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-arm.i=
nc
> > /OE/shr-core/openembedded-core/meta/classes/utility-tasks.bbclass
> > /OE/shr-core/meta-openembedded/meta-efl/conf/distro/include/efl-from-sv=
n.inc
> > /OE/shr-core/openembedded-core/meta/conf/sanity.conf
> > /OE/shr-core/openembedded-core/meta/classes/metadata_scm.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/utils.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/buildhistory.bbclass
> > /OE/shr-core/openembedded-core/meta/conf/distro/include/default-distrov=
ars.inc
> > /OE/shr-core/openembedded-core/meta/classes/terminal.bbclass
> > /OE/shr-core/openembedded-core/meta/classes/sanity.bbclass
> > /OE/shr-core/conf/site.conf
> > /OE/shr-core/openembedded-core/meta/classes/mirrors.bbclass
> > /OE/shr-core/meta-smartphone/meta-nokia/conf/layer.conf
> > /OE/shr-core/meta-openembedded/meta-oe/classes/blacklist.bbclass
> > /OE/shr-core/meta-openembedded/meta-efl/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/classes/base.bbclass
> > /OE/shr-core/meta-mozilla/conf/layer.conf
> > /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/feature-ar=
m-thumb.inc
> > /OE/shr-core/meta-smartphone/meta-shr/conf/layer.conf
> > ---
> > > BBINCLUDED: /OE/shr-core/conf/local.conf /OE/shr-core/conf/local-buil=
ds.inc /OE/shr-core/openembedded-core/meta/classes/patch.bbclass /OE/shr-co=
re/openembedded-core/meta/conf/machine-sdk/x86_64.conf /OE/shr-core/meta-sm=
artphone/meta-palm/conf/layer.conf /OE/shr-core/openembedded-core/meta/conf=
/documentation.conf /OE/shr-core/meta-openembedded/meta-oe/conf/layer.conf =
/OE/shr-core/openembedded-core/meta/conf/distro/include/tclibc-eglibc.inc /=
OE/shr-core/openembedded-core/meta/classes/packagedata.bbclass /OE/shr-core=
/openembedded-core/meta/conf/distro/include/default-providers.inc /OE/shr-c=
ore/openembedded-core/meta/classes/package_ipk.bbclass /OE/shr-core/openemb=
edded-core/meta/classes/logging.bbclass /OE/shr-core/openembedded-core/meta=
/classes/devshell.bbclass /OE/shr-core/openembedded-core/meta/classes/insan=
e.bbclass /OE/shr-core/openembedded-core/meta/classes/sstate.bbclass /OE/sh=
r-core/openembedded-core/meta/conf/distro/include/as-needed.inc /OE/shr-cor=
e/meta-openembedded/meta-gpe/conf/layer.conf /OE/shr-core/meta-smartphone/m=
eta-htc/conf/layer.conf /OE/shr-core/meta-smartphone/meta-openmoko/conf/lay=
er.conf /OE/shr-core/conf/bblayers.conf /OE/shr-core/meta-smartphone/meta-s=
hr/classes/shr-mirrors.bbclass /OE/shr-core/openembedded-core/meta/conf/mac=
hine/include/tune-arm920t.inc /OE/shr-core/meta-smartphone/meta-openmoko/co=
nf/machine/om-gta02.conf /OE/shr-core/openembedded-core/meta/classes/packag=
e.bbclass /OE/shr-core/openembedded-core/meta/conf/abi_version.conf /OE/shr=
-core/meta-handheld/conf/layer.conf /OE/shr-core/openembedded-core/meta/cla=
sses/license.bbclass /OE/shr-core/meta-smartphone/meta-shr/conf/distro/incl=
ude/preferred-shr-versions.inc /OE/shr-core/meta-smartphone/meta-shr/conf/d=
istro/shr.conf /OE/shr-core/openembedded-core/meta/conf/distro/include/defa=
ult-versions.inc /OE/shr-core/openembedded-core/meta/conf/bitbake.conf /OE/=
shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.inc /OE/=
shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.inc /OE=
/shr-core/meta-smartph
> >=20
> > Cheers,
>=20
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9i/7gACgkQN1Ujt2V2gBxvKQCeOniRp0BN2uquXLc1m51XhQeN
fOAAmwdZDsGHwaMs8U2RdKbgxqK19tFT
=20sH
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
