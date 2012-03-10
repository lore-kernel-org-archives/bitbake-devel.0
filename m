Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S6H6d-0001uY-Nd
	for bitbake-devel@lists.openembedded.org;
	Sat, 10 Mar 2012 08:52:48 +0100
Received: by ggcy3 with SMTP id y3so1428653ggc.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Mar 2012 23:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=rdpZsnCpjgprlH7QCD6XUkPZ7vXYBlzOY8Bv39opltI=;
	b=yVu6x+YZ2T4eZJiRvMr/GZeWIGo22LyHBApDIsVB9WQFHahcUCE/iALs0lLy/t8the
	+5ITgoTgRVrGmpqfwTy2RZp80KYfskH0nZLXRi8cfCZhd93763nyHDccNrJSoX4UDQg/
	IXvIl3SMwMK1n30dYv0tMUtLUHCIUiyCpWeMBCB1XOBCOLLvtK9qRWEh8BvUjmgBu/hi
	x8864BuugEWZU+wKtRd6jZV1uc0cBgYbAWqEnKFq5MxpPFNP74e2lGhjJC2sqUAFw3n9
	CXpQLOXvPZYRiyCXsLeffdyXSAMGPBXbBLanJ6I8crAX7msCVJitiejiAmmh+th2THn8
	+Tig==
MIME-Version: 1.0
Received: by 10.100.225.18 with SMTP id x18mr1865929ang.48.1331365447034; Fri,
	09 Mar 2012 23:44:07 -0800 (PST)
Received: by 10.236.102.177 with HTTP; Fri, 9 Mar 2012 23:44:06 -0800 (PST)
In-Reply-To: <1330153006.1957.10.camel@dongxiao-osel>
References: <4F48217F.6040406@opendreambox.org>
	<1330153006.1957.10.camel@dongxiao-osel>
Date: Sat, 10 Mar 2012 08:44:06 +0100
Message-ID: <CA+chaQc2o276Mxh8_3fnLTdqkUEZdb2476WEt7pY2=mitj1S1w@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
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
X-List-Received-Date: Sat, 10 Mar 2012 07:52:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2012 at 7:56 AM, Xu, Dongxiao <dongxiao.xu@intel.com> wrote=
:
> On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
>> Hi,
>>
>> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
>> dependency cache for me, i.e. it parses all recipes on every invocation
>> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache didn't
>> help. Reverting this commit restores the functionality.
>
> Hi Andreas,
>
> Sorry for the inconvenience that this commit brought to you.
>
> Could you help to try the following and send me your "/tmp/1.log
> and /tmp/2.log"?
>
> 1) apply the attached "cache_debug.patch"
> 2) remove tmp/cache
> 3) bitbake -p &> /tmp/1.log
> 4) bitbake -p &> /tmp/2.log
>
> Besides, you can have a try of the attached cache_whitelist.patch to see
> if it fixes your problem.

Today I noticed another cache rebuild, here is diff from parse output:

3286c3286
< XAUTHORITY: /root/.xauthljqB8X
---
> XAUTHORITY: /root/.xauth1of3YX
3532c3532
< PSEUDO_BUILD: 2
---
> PSEUDO_BUILD: 0
5223c5222
< _: /OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin/pseudo
---
> _: /usr/bin/bitbake

and long one BBINCLUDED where only order of some items was changed:
@@ -21,13 +21,14 @@
 /OE/shr-core/meta-smartphone/meta-shr/classes/shr-mirrors.bbclass
 /OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.inc
 /OE/shr-core/meta-smartphone/meta-openmoko/conf/machine/om-gta02.conf
-/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
 /OE/shr-core/openembedded-core/meta/classes/package.bbclass
 /OE/shr-core/openembedded-core/meta/conf/abi_version.conf
 /OE/shr-core/meta-handheld/conf/layer.conf
 /OE/shr-core/openembedded-core/meta/classes/license.bbclass
 /OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/preferred-shr-ve=
rsions.inc
+/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
 /OE/shr-core/openembedded-core/meta/conf/distro/include/default-versions.i=
nc
+/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
 /OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.inc
 /OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.in=
c
 /OE/shr-core/meta-smartphone/meta-samsung/conf/layer.conf
@@ -37,7 +38,6 @@
 /OE/shr-core/openembedded-core/meta/conf/distro/defaultsetup.conf
 /OE/shr-core/meta-jama/conf/layer.conf
 /OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf
-/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
 /OE/shr-core/meta-smartphone/meta-aurora/conf/layer.conf
 /OE/shr-core/openembedded-core/meta/classes/debian.bbclass
 /OE/shr-core/openembedded-core/meta/conf/layer.conf

391c391
< BBINCLUDED: /OE/shr-core/conf/local.conf
/OE/shr-core/conf/local-builds.inc
/OE/shr-core/openembedded-core/meta/classes/patch.bbclass
/OE/shr-core/openembedded-core/meta/conf/machine-sdk/x86_64.conf
/OE/shr-core/meta-smartphone/meta-palm/conf/layer.conf
/OE/shr-core/openembedded-core/meta/conf/documentation.conf
/OE/shr-core/meta-openembedded/meta-oe/conf/layer.conf
/OE/shr-core/openembedded-core/meta/conf/distro/include/tclibc-eglibc.inc
/OE/shr-core/openembedded-core/meta/classes/packagedata.bbclass
/OE/shr-core/openembedded-core/meta/conf/distro/include/default-providers.i=
nc
/OE/shr-core/openembedded-core/meta/classes/package_ipk.bbclass
/OE/shr-core/openembedded-core/meta/classes/logging.bbclass
/OE/shr-core/openembedded-core/meta/classes/devshell.bbclass
/OE/shr-core/openembedded-core/meta/classes/insane.bbclass
/OE/shr-core/openembedded-core/meta/classes/sstate.bbclass
/OE/shr-core/openembedded-core/meta/conf/distro/include/as-needed.inc
/OE/shr-core/meta-openembedded/meta-gpe/conf/layer.conf
/OE/shr-core/meta-smartphone/meta-htc/conf/layer.conf
/OE/shr-core/meta-smartphone/meta-openmoko/conf/layer.conf
/OE/shr-core/conf/bblayers.conf
/OE/shr-core/meta-smartphone/meta-shr/classes/shr-mirrors.bbclass
/OE/shr-core/openembedded-core/meta/conf/machine/include/tune-arm920t.inc
/OE/shr-core/meta-smartphone/meta-openmoko/conf/machine/om-gta02.conf
/OE/shr-core/openembedded-core/meta/conf/bitbake.conf
/OE/shr-core/openembedded-core/meta/classes/package.bbclass
/OE/shr-core/openembedded-core/meta/conf/abi_version.conf
/OE/shr-core/meta-handheld/conf/layer.conf
/OE/shr-core/openembedded-core/meta/classes/license.bbclass
/OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/preferred-shr-ver=
sions.inc
/OE/shr-core/openembedded-core/meta/conf/distro/include/default-versions.in=
c
/OE/shr-core/openembedded-core/meta/conf/distro/include/tcmode-default.inc
/OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.inc
/OE/shr-core/meta-smartphone/meta-samsung/conf/layer.conf
/OE/shr-core/conf/auto.conf
/OE/shr-core/meta-smartphone/meta-fso/conf/layer.conf
/OE/shr-core/openembedded-core/meta/classes/staging.bbclass
/OE/shr-core/openembedded-core/meta/conf/distro/defaultsetup.conf
/OE/shr-core/meta-jama/conf/layer.conf
/OE/shr-core/meta-openembedded/meta-gnome/conf/layer.conf
/OE/shr-core/meta-smartphone/meta-shr/conf/distro/shr.conf
/OE/shr-core/meta-smartphone/meta-aurora/conf/layer.conf
/OE/shr-core/openembedded-core/meta/classes/debian.bbclass
/OE/shr-core/openembedded-core/meta/conf/layer.conf
/OE/shr-core/openembedded-core/meta/conf/distro/include/world-broken.inc
/OE/shr-core/meta-openembedded/meta-initramfs/conf/layer.conf
/OE/shr-core/openembedded-core/meta/classes/prserv.bbclass
/OE/shr-core/openembedded-core/meta/classes/rm_work.bbclass
/OE/shr-core/openembedded-core/meta/conf/machine/include/arm/arch-arm.inc
/OE/shr-core/openembedded-core/meta/classes/utility-tasks.bbclass
/OE/shr-core/meta-openembedded/meta-efl/conf/distro/include/efl-from-svn.in=
c
/OE/shr-core/openembedded-core/meta/conf/sanity.conf
/OE/shr-core/openembedded-core/meta/classes/metadata_scm.bbclass
/OE/shr-core/openembedded-core/meta/classes/utils.bbclass
/OE/shr-core/openembedded-core/meta/classes/buildhistory.bbclass
/OE/shr-core/openembedded-core/meta/conf/distro/include/default-distrovars.=
inc
/OE/shr-core/openembedded-core/meta/classes/terminal.bbclass
/OE/shr-core/openembedded-core/meta/classes/sanity.bbclass
/OE/shr-core/conf/site.conf
/OE/shr-core/openembedded-core/meta/classes/mirrors.bbclass
/OE/shr-core/meta-smartphone/meta-nokia/conf/layer.conf
/OE/shr-core/meta-openembedded/meta-oe/classes/blacklist.bbclass
/OE/shr-core/meta-openembedded/meta-efl/conf/layer.conf
/OE/shr-core/openembedded-core/meta/classes/base.bbclass
/OE/shr-core/meta-mozilla/conf/layer.conf
/OE/shr-core/openembedded-core/meta/conf/machine/include/arm/feature-arm-th=
umb.inc
/OE/shr-core/meta-smartphone/meta-shr/conf/layer.conf
---
> BBINCLUDED: /OE/shr-core/conf/local.conf /OE/shr-core/conf/local-builds.i=
nc /OE/shr-core/openembedded-core/meta/classes/patch.bbclass /OE/shr-core/o=
penembedded-core/meta/conf/machine-sdk/x86_64.conf /OE/shr-core/meta-smartp=
hone/meta-palm/conf/layer.conf /OE/shr-core/openembedded-core/meta/conf/doc=
umentation.conf /OE/shr-core/meta-openembedded/meta-oe/conf/layer.conf /OE/=
shr-core/openembedded-core/meta/conf/distro/include/tclibc-eglibc.inc /OE/s=
hr-core/openembedded-core/meta/classes/packagedata.bbclass /OE/shr-core/ope=
nembedded-core/meta/conf/distro/include/default-providers.inc /OE/shr-core/=
openembedded-core/meta/classes/package_ipk.bbclass /OE/shr-core/openembedde=
d-core/meta/classes/logging.bbclass /OE/shr-core/openembedded-core/meta/cla=
sses/devshell.bbclass /OE/shr-core/openembedded-core/meta/classes/insane.bb=
class /OE/shr-core/openembedded-core/meta/classes/sstate.bbclass /OE/shr-co=
re/openembedded-core/meta/conf/distro/include/as-needed.inc /OE/shr-core/me=
ta-openembedded/meta-gpe/conf/layer.conf /OE/shr-core/meta-smartphone/meta-=
htc/conf/layer.conf /OE/shr-core/meta-smartphone/meta-openmoko/conf/layer.c=
onf /OE/shr-core/conf/bblayers.conf /OE/shr-core/meta-smartphone/meta-shr/c=
lasses/shr-mirrors.bbclass /OE/shr-core/openembedded-core/meta/conf/machine=
/include/tune-arm920t.inc /OE/shr-core/meta-smartphone/meta-openmoko/conf/m=
achine/om-gta02.conf /OE/shr-core/openembedded-core/meta/classes/package.bb=
class /OE/shr-core/openembedded-core/meta/conf/abi_version.conf /OE/shr-cor=
e/meta-handheld/conf/layer.conf /OE/shr-core/openembedded-core/meta/classes=
/license.bbclass /OE/shr-core/meta-smartphone/meta-shr/conf/distro/include/=
preferred-shr-versions.inc /OE/shr-core/meta-smartphone/meta-shr/conf/distr=
o/shr.conf /OE/shr-core/openembedded-core/meta/conf/distro/include/default-=
versions.inc /OE/shr-core/openembedded-core/meta/conf/bitbake.conf /OE/shr-=
core/openembedded-core/meta/conf/distro/include/tcmode-default.inc /OE/shr-=
core/openembedded-core/meta/conf/machine/include/arm/arch-armv4.inc /OE/shr=
-core/meta-smartphone/meta-samsung/conf/layer.conf /OE/shr-core/conf/auto.c=
onf /OE/shr-core/meta-smartphone/meta-fso/conf/layer.conf /OE/shr-core/open=
embedded-core/meta/classes/staging.bbclass /OE/shr-core/openembedded-core/m=
eta/conf/distro/defaultsetup.conf /OE/shr-core/meta-jama/conf/layer.conf /O=
E/shr-core/meta-openembedded/meta-gnome/conf/layer.conf /OE/shr-core/meta-s=
martphone/meta-aurora/conf/layer.conf /OE/shr-core/openembedded-core/meta/c=
lasses/debian.bbclass /OE/shr-core/openembedded-core/meta/conf/layer.conf /=
OE/shr-core/openembedded-core/meta/conf/distro/include/world-broken.inc /OE=
/shr-core/meta-openembedded/meta-initramfs/conf/layer.conf /OE/shr-core/ope=
nembedded-core/meta/classes/prserv.bbclass /OE/shr-core/openembedded-core/m=
eta/classes/rm_work.bbclass /OE/shr-core/openembedded-core/meta/conf/machin=
e/include/arm/arch-arm.inc /OE/shr-core/openembedded-core/meta/classes/util=
ity-tasks.bbclass /OE/shr-core/meta-openembedded/meta-efl/conf/distro/inclu=
de/efl-from-svn.inc /OE/shr-core/openembedded-core/meta/conf/sanity.conf /O=
E/shr-core/openembedded-core/meta/classes/metadata_scm.bbclass /OE/shr-core=
/openembedded-core/meta/classes/utils.bbclass /OE/shr-core/openembedded-cor=
e/meta/classes/buildhistory.bbclass /OE/shr-core/openembedded-core/meta/con=
f/distro/include/default-distrovars.inc /OE/shr-core/openembedded-core/meta=
/classes/terminal.bbclass /OE/shr-core/openembedded-core/meta/classes/sanit=
y.bbclass /OE/shr-core/conf/site.conf /OE/shr-core/openembedded-core/meta/c=
lasses/mirrors.bbclass /OE/shr-core/meta-smartphone/meta-nokia/conf/layer.c=
onf /OE/shr-core/meta-openembedded/meta-oe/classes/blacklist.bbclass /OE/sh=
r-core/meta-openembedded/meta-efl/conf/layer.conf /OE/shr-core/openembedded=
-core/meta/classes/base.bbclass /OE/shr-core/meta-mozilla/conf/layer.conf /=
OE/shr-core/openembedded-core/meta/conf/machine/include/arm/feature-arm-thu=
mb.inc /OE/shr-core/meta-smartphone/meta-shr/conf/layer.conf

Cheers,


