Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S8Sgk-0005f9-Ef
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 09:39:07 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 16 Mar 2012 01:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121577993"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 16 Mar 2012 01:30:13 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Martin Jansa <martin.jansa@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
In-Reply-To: <CA+chaQc2o276Mxh8_3fnLTdqkUEZdb2476WEt7pY2=mitj1S1w@mail.gmail.com>
References: <4F48217F.6040406@opendreambox.org>
	<1330153006.1957.10.camel@dongxiao-osel>
	<CA+chaQc2o276Mxh8_3fnLTdqkUEZdb2476WEt7pY2=mitj1S1w@mail.gmail.com>
Date: Fri, 16 Mar 2012 16:28:16 +0800
Message-ID: <1331886496.1977.8.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
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
X-List-Received-Date: Fri, 16 Mar 2012 08:39:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-03-10 at 08:44 +0100, Martin Jansa wrote:
> On Sat, Feb 25, 2012 at 7:56 AM, Xu, Dongxiao <dongxiao.xu@intel.com> wro=
te:
> > On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
> >> Hi,
> >>
> >> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
> >> dependency cache for me, i.e. it parses all recipes on every invocatio=
n
> >> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache didn=
't
> >> help. Reverting this commit restores the functionality.
> >
> > Hi Andreas,
> >
> > Sorry for the inconvenience that this commit brought to you.
> >
> > Could you help to try the following and send me your "/tmp/1.log
> > and /tmp/2.log"?
> >
> > 1) apply the attached "cache_debug.patch"
> > 2) remove tmp/cache
> > 3) bitbake -p &> /tmp/1.log
> > 4) bitbake -p &> /tmp/2.log
> >
> > Besides, you can have a try of the attached cache_whitelist.patch to se=
e
> > if it fixes your problem.
>=20
> Today I noticed another cache rebuild, here is diff from parse output:

Hi Martin,

Could this issue be reproduced stably in your environment? Or it happens
occasionally?

It seems that this kind of order change in variable values will also
impact the siggen result. Richard, do you have any comment on this one?

Thanks,
Dongxiao

>=20
> 3286c3286
> < XAUTHORITY: /root/.xauthljqB8X
> ---
> > XAUTHORITY: /root/.xauth1of3YX
> 3532c3532
> < PSEUDO_BUILD: 2
> ---
> > PSEUDO_BUILD: 0
> 5223c5222
> < _: /OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin/pseudo
> ---
> > _: /usr/bin/bitbake
>=20
> and long one BBINCLUDED where only order of some items was changed:
> @@ -21,13 +21,14 @@
>  /OE/shr-core/meta-smartphone/meta-shr/classes/shr-mirrors.bbclass
>  /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.in=
c
>  /OE/shr-core/meta-smartphone/meta-openmoko/conf/machine/om-gta02.conf
> -/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
>  /OE/shr-core/openembedded-core/meta/classes/package.bbclass
>  /OE/shr-core/openembedded-core/meta/conf/abi_version.conf
>  /OE/shr-core/meta-handheld/conf/layer.conf
>  /OE/shr-core/openembedded-core/meta/classes/license.bbclass
>  /OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/preferred-shr-=
versions.inc
> +/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
>  /OE/shr-core/openembedded-core/meta/conf/distro/include/default-versions=
.inc
> +/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
>  /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.i=
nc
>  /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.=
inc
>  /OE/shr-core/meta-smartphone/meta-samsung/conf/layer.conf
> @@ -37,7 +38,6 @@
>  /OE/shr-core/openembedded-core/meta/conf/distro/defaultsetup.conf
>  /OE/shr-core/meta-jama/conf/layer.conf
>  /OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf
> -/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
>  /OE/shr-core/meta-smartphone/meta-aurora/conf/layer.conf
>  /OE/shr-core/openembedded-core/meta/classes/debian.bbclass
>  /OE/shr-core/openembedded-core/meta/conf/layer.conf
>=20
> 391c391
> < BBINCLUDED: /OE/shr-core/conf/local.conf
> /OE/shr-core/conf/local-builds.inc
> /OE/shr-core/openembedded-core/meta/classes/patch.bbclass
> /OE/shr-core/openembedded-core/meta/conf/machine-sdk/x86_64.conf
> /OE/shr-core/meta-smartphone/meta-palm/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/conf/documentation.conf
> /OE/shr-core/meta-openembedded/meta-oe/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/conf/distro/include/tclibc-eglibc.inc
> /OE/shr-core/openembedded-core/meta/classes/packagedata.bbclass
> /OE/shr-core/openembedded-core/meta/conf/distro/include/default-providers=
.inc
> /OE/shr-core/openembedded-core/meta/classes/package_ipk.bbclass
> /OE/shr-core/openembedded-core/meta/classes/logging.bbclass
> /OE/shr-core/openembedded-core/meta/classes/devshell.bbclass
> /OE/shr-core/openembedded-core/meta/classes/insane.bbclass
> /OE/shr-core/openembedded-core/meta/classes/sstate.bbclass
> /OE/shr-core/openembedded-core/meta/conf/distro/include/as-needed.inc
> /OE/shr-core/meta-openembedded/meta-gpe/conf/layer.conf
> /OE/shr-core/meta-smartphone/meta-htc/conf/layer.conf
> /OE/shr-core/meta-smartphone/meta-openmoko/conf/layer.conf
> /OE/shr-core/conf/bblayers.conf
> /OE/shr-core/meta-smartphone/meta-shr/classes/shr-mirrors.bbclass
> /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.inc
> /OE/shr-core/meta-smartphone/meta-openmoko/conf/machine/om-gta02.conf
> /OE/shr-core/openembedded-core/meta/conf/bitbake.conf
> /OE/shr-core/openembedded-core/meta/classes/package.bbclass
> /OE/shr-core/openembedded-core/meta/conf/abi_version.conf
> /OE/shr-core/meta-handheld/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/classes/license.bbclass
> /OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/preferred-shr-v=
ersions.inc
> /OE/shr-core/openembedded-core/meta/conf/distro/include/default-versions.=
inc
> /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.in=
c
> /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.i=
nc
> /OE/shr-core/meta-smartphone/meta-samsung/conf/layer.conf
> /OE/shr-core/conf/auto.conf
> /OE/shr-core/meta-smartphone/meta-fso/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/classes/staging.bbclass
> /OE/shr-core/openembedded-core/meta/conf/distro/defaultsetup.conf
> /OE/shr-core/meta-jama/conf/layer.conf
> /OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf
> /OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
> /OE/shr-core/meta-smartphone/meta-aurora/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/classes/debian.bbclass
> /OE/shr-core/openembedded-core/meta/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/conf/distro/include/world-broken.inc
> /OE/shr-core/meta-openembedded/meta-initramfs/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/classes/prserv.bbclass
> /OE/shr-core/openembedded-core/meta/classes/rm_work.bbclass
> /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-arm.inc
> /OE/shr-core/openembedded-core/meta/classes/utility-tasks.bbclass
> /OE/shr-core/meta-openembedded/meta-efl/conf/distro/include/efl-from-svn.=
inc
> /OE/shr-core/openembedded-core/meta/conf/sanity.conf
> /OE/shr-core/openembedded-core/meta/classes/metadata_scm.bbclass
> /OE/shr-core/openembedded-core/meta/classes/utils.bbclass
> /OE/shr-core/openembedded-core/meta/classes/buildhistory.bbclass
> /OE/shr-core/openembedded-core/meta/conf/distro/include/default-distrovar=
s.inc
> /OE/shr-core/openembedded-core/meta/classes/terminal.bbclass
> /OE/shr-core/openembedded-core/meta/classes/sanity.bbclass
> /OE/shr-core/conf/site.conf
> /OE/shr-core/openembedded-core/meta/classes/mirrors.bbclass
> /OE/shr-core/meta-smartphone/meta-nokia/conf/layer.conf
> /OE/shr-core/meta-openembedded/meta-oe/classes/blacklist.bbclass
> /OE/shr-core/meta-openembedded/meta-efl/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/classes/base.bbclass
> /OE/shr-core/meta-mozilla/conf/layer.conf
> /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/feature-arm-=
thumb.inc
> /OE/shr-core/meta-smartphone/meta-shr/conf/layer.conf
> ---
> > BBINCLUDED: /OE/shr-core/conf/local.conf /OE/shr-core/conf/local-builds=
.inc /OE/shr-core/openembedded-core/meta/classes/patch.bbclass /OE/shr-core=
/openembedded-core/meta/conf/machine-sdk/x86_64.conf /OE/shr-core/meta-smar=
tphone/meta-palm/conf/layer.conf /OE/shr-core/openembedded-core/meta/conf/d=
ocumentation.conf /OE/shr-core/meta-openembedded/meta-oe/conf/layer.conf /O=
E/shr-core/openembedded-core/meta/conf/distro/include/tclibc-eglibc.inc /OE=
/shr-core/openembedded-core/meta/classes/packagedata.bbclass /OE/shr-core/o=
penembedded-core/meta/conf/distro/include/default-providers.inc /OE/shr-cor=
e/openembedded-core/meta/classes/package_ipk.bbclass /OE/shr-core/openembed=
ded-core/meta/classes/logging.bbclass /OE/shr-core/openembedded-core/meta/c=
lasses/devshell.bbclass /OE/shr-core/openembedded-core/meta/classes/insane.=
bbclass /OE/shr-core/openembedded-core/meta/classes/sstate.bbclass /OE/shr-=
core/openembedded-core/meta/conf/distro/include/as-needed.inc /OE/shr-core/=
meta-openembedded/meta-gpe/conf/layer.conf /OE/shr-core/meta-smartphone/met=
a-htc/conf/layer.conf /OE/shr-core/meta-smartphone/meta-openmoko/conf/layer=
.conf /OE/shr-core/conf/bblayers.conf /OE/shr-core/meta-smartphone/meta-shr=
/classes/shr-mirrors.bbclass /OE/shr-core/openembedded-core/meta/conf/machi=
ne/include/tune-arm920t.inc /OE/shr-core/meta-smartphone/meta-openmoko/conf=
/machine/om-gta02.conf /OE/shr-core/openembedded-core/meta/classes/package.=
bbclass /OE/shr-core/openembedded-core/meta/conf/abi_version.conf /OE/shr-c=
ore/meta-handheld/conf/layer.conf /OE/shr-core/openembedded-core/meta/class=
es/license.bbclass /OE/shr-core/meta-smartphone/meta-shr/conf/distro/includ=
e/preferred-shr-versions.inc /OE/shr-core/meta-smartphone/meta-shr/conf/dis=
tro/shr.conf /OE/shr-core/openembedded-core/meta/conf/distro/include/defaul=
t-versions.inc /OE/shr-core/openembedded-core/meta/conf/bitbake.conf /OE/sh=
r-core/openembedded-core/meta/conf/distro/include/tcmode-default.inc /OE/sh=
r-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.inc /OE/s=
hr-core/meta-smartphone/meta-samsung/conf/layer.conf /OE/shr-core/conf/auto=
.conf /OE/shr-core/meta-smartphone/meta-fso/conf/layer.conf /OE/shr-core/op=
enembedded-core/meta/classes/staging.bbclass /OE/shr-core/openembedded-core=
/meta/conf/distro/defaultsetup.conf /OE/shr-core/meta-jama/conf/layer.conf =
/OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf /OE/shr-core/meta=
-smartphone/meta-aurora/conf/layer.conf /OE/shr-core/openembedded-core/meta=
/classes/debian.bbclass /OE/shr-core/openembedded-core/meta/conf/layer.conf=
 /OE/shr-core/openembedded-core/meta/conf/distro/include/world-broken.inc /=
OE/shr-core/meta-openembedded/meta-initramfs/conf/layer.conf /OE/shr-core/o=
penembedded-core/meta/classes/prserv.bbclass /OE/shr-core/openembedded-core=
/meta/classes/rm_work.bbclass /OE/shr-core/openembedded-core/meta/conf/mach=
ine/include/arm/arch-arm.inc /OE/shr-core/openembedded-core/meta/classes/ut=
ility-tasks.bbclass /OE/shr-core/meta-openembedded/meta-efl/conf/distro/inc=
lude/efl-from-svn.inc /OE/shr-core/openembedded-core/meta/conf/sanity.conf =
/OE/shr-core/openembedded-core/meta/classes/metadata_scm.bbclass /OE/shr-co=
re/openembedded-core/meta/classes/utils.bbclass /OE/shr-core/openembedded-c=
ore/meta/classes/buildhistory.bbclass /OE/shr-core/openembedded-core/meta/c=
onf/distro/include/default-distrovars.inc /OE/shr-core/openembedded-core/me=
ta/classes/terminal.bbclass /OE/shr-core/openembedded-core/meta/classes/san=
ity.bbclass /OE/shr-core/conf/site.conf /OE/shr-core/openembedded-core/meta=
/classes/mirrors.bbclass /OE/shr-core/meta-smartphone/meta-nokia/conf/layer=
.conf /OE/shr-core/meta-openembedded/meta-oe/classes/blacklist.bbclass /OE/=
shr-core/meta-openembedded/meta-efl/conf/layer.conf /OE/shr-core/openembedd=
ed-core/meta/classes/base.bbclass /OE/shr-core/meta-mozilla/conf/layer.conf=
 /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/feature-arm-t=
humb.inc /OE/shr-core/meta-smartphone/meta-shr/conf/layer.conf
>=20
> Cheers,




