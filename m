Return-Path: <michail.kurochkin@zorachka.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC45C433F5
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 15:24:15 +0000 (UTC)
Subject: Re: eSDK 'setscene whitelist'
To: bitbake-devel@lists.openembedded.org
From: "Michail Kurochkin" <michail.kurochkin@zorachka.com>
X-Originating-Location: BY (91.149.141.6)
X-Originating-Platform: Linux Chrome 80
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 23 Nov 2021 07:24:15 -0800
References: <f2be03cd-259c-bb13-3927-9a08f6011920@kernel.crashing.org>
In-Reply-To: <f2be03cd-259c-bb13-3927-9a08f6011920@kernel.crashing.org>
Message-ID: <9659.1637681055128271957@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Rl7HHD0dkL72C852DGD2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Nov 2021 15:24:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13096

--Rl7HHD0dkL72C852DGD2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank for your responses.

I have rechecked all recipes and found out that AUTOREV is not used there, =
including linux-xarina recipe.=C2=A0 I found out that linux-xarina.do_fetch=
 is included in 'unskippable' tasks list (runqueue.py:build_scenequeue_data=
()).
Because of this, the task linux-xarina.do_fetch is included in 'not_covered=
' tasks list. This is the reason of the eSDK build failures.

I discivered that linux-xarina.do_fetch is included into 'unskippable' list=
 because 'unskippable' list contains 'xarina-s-evb-image-debug.do_build' ta=
sk.
But the task 'xarina-s-evb-image-debug.do_build' is allowed in the whitelis=
t:
BB_SETSCENE_ENFORCE_WHITELIST =3D 'xarina-s-evb-image-debug:*', '*:do_share=
d_workdir', '*:do_rm_work', 'wic-tools:*', '*:do_addto_recipe_sysroot'
This is expected.

Then I found out that 'xarina-s-evb-image-debug.do_build' depends on other =
*.do_build tasks that are not allowed in the 'whitelist'. But these tasks h=
ave '_setscene' vesrsion and then in the source code are excluded from the =
'unskippable' list.

And 'linux-xarina.do_build' depends on corresponding '_setscene' tasks (aka=
 do_build, do_populate_sysroot and etc.). This list also includes 'linux-xa=
rina.do_kernel_add_regdb' task that does not have '_setscene' version and i=
t depends on 'linux-xarina.do_configure' that depends on 'linux-xarina.do_f=
etch'.

As the result all these tasks are included in the 'unskippable' list:
xarina-s-evb-image-debug.do_build -> linux-xarina.do_build -> linux-xarina.=
do_kernel_add_regdb -> linux-xarina.do_configure -> linux-xarina.do_unpack =
-> linux-xarina.do_fetch
This is the core reason of the build failure.

Here is the 'linux-xarina' recipe:

```
require recipes-kernel/linux/linux.inc
inherit kernel_wireless_regdb

DESCRIPTION =3D "Linux kernel for Xarina"

FILESEXTRAPATHS_prepend :=3D "${THISDIR}/files:${THISDIR}/files/dtsi:"

COMPATIBLE_MACHINE =3D "xarina-s-evb"

SRCREV =3D "0e62087ecc399256624095f82e8b90c95c0e3b36"

SRC_URI =3D "${HOMAM_GIT_URI}/xarina-kernel-source.git;protocol=3D${HOMAM_G=
IT_PROTOCOL};nobranch=3D1"

SRC_URI +=3D "file://xarina-s-evb-standard.scc \
file://xarina-s-evb-user-config.cfg \
file://defconfig \
"
S =3D "${WORKDIR}/git"

LINUX_VERSION =3D "3.14.62"
LOCALVERSION =3D "-fido1.8-xarina"

PV =3D "${LINUX_VERSION}+git${SRCPV}"
PR =3D "r1"

DEPENDS +=3D "lzop-native xz-native"
DEPENDS +=3D "mtd-utils-native"

UBIFS_TMPDIR =3D "linux_tmp"

```
The code above includes 'kernel_wireless_regdb.bbclass' file.

The 'kernel_wireless_regdb' recipe implementation is located in meta-openem=
bedded layer: https://github.com/openembedded/meta-openembedded/blob/master=
/meta-networking/classes/kernel_wireless_regdb.bbclass

Here you can see the dependence:
addtask kernel_add_regdb before do_build after do_configure
That breaks eSDK build.

I tried to add '_setscene' version of the task 'do_kernel_add_regdb' but it=
 does not help:

```
python do_kernel_add_regdb_setscene () {
sstate_setscene(d)
}
addtask do_kernel_add_regdb_setscene
SSTATETASKS +=3D "kernel_add_regdb"
```

If I exlude the line with 'inherit kernel_wireless_regdb' then eSDK built w=
ith success.
But unfortunately we can not exclude WIFI CRDA list in our project.

Could you please suggest a proper solution for this bug, not using a custom=
 workaround?

Thank you in advance,
Michail.

--Rl7HHD0dkL72C852DGD2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Thank for your responses.</div>
<div>&nbsp;</div>
<div>I have rechecked all recipes and found out that AUTOREV is not used th=
ere, including linux-xarina recipe.&nbsp; I found out that linux-xarina.do_=
fetch is included in 'unskippable' tasks list (runqueue.py:build_scenequeue=
_data()).</div>
<div>Because of this, the task linux-xarina.do_fetch is included in 'not_co=
vered' tasks list. This is the reason of the eSDK build failures.</div>
<div>&nbsp;</div>
<div>I discivered that linux-xarina.do_fetch is included into 'unskippable'=
 list because 'unskippable' list contains 'xarina-s-evb-image-debug.do_buil=
d' task.</div>
<div>But the task 'xarina-s-evb-image-debug.do_build' is allowed in the whi=
telist:</div>
<div>&nbsp; &nbsp; BB_SETSCENE_ENFORCE_WHITELIST =3D 'xarina-s-evb-image-de=
bug:*', '*:do_shared_workdir', '*:do_rm_work', 'wic-tools:*', '*:do_addto_r=
ecipe_sysroot'</div>
<div>This is expected.</div>
<div>&nbsp;</div>
<div>Then I found out that 'xarina-s-evb-image-debug.do_build' depends on o=
ther *.do_build tasks that are not allowed in the 'whitelist'. But these ta=
sks have '_setscene' vesrsion and then in the source code are excluded from=
 the 'unskippable' list.</div>
<div>&nbsp;</div>
<div>And 'linux-xarina.do_build' depends on corresponding '_setscene' tasks=
 (aka do_build, do_populate_sysroot and etc.). This list also includes 'lin=
ux-xarina.do_kernel_add_regdb' task that does not have '_setscene' version =
and it depends on 'linux-xarina.do_configure' that depends on 'linux-xarina=
.do_fetch'.</div>
<div>&nbsp;</div>
<div>As the result all these tasks are included in the 'unskippable' list:<=
/div>
<div>&nbsp; &nbsp; xarina-s-evb-image-debug.do_build -&gt; linux-xarina.do_=
build -&gt; linux-xarina.do_kernel_add_regdb -&gt; linux-xarina.do_configur=
e -&gt; linux-xarina.do_unpack -&gt; linux-xarina.do_fetch</div>
<div>This is the core reason of the build failure.</div>
<div>&nbsp;</div>
<div>Here is the 'linux-xarina' recipe:</div>
<div>&nbsp;</div>
<div>```</div>
<div>&nbsp; &nbsp; &nbsp; require recipes-kernel/linux/linux.inc</div>
<div>&nbsp; &nbsp; &nbsp; inherit kernel_wireless_regdb</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; DESCRIPTION =3D "Linux kernel for Xarina"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; FILESEXTRAPATHS_prepend :=3D "${THISDIR}/files:${=
THISDIR}/files/dtsi:"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; COMPATIBLE_MACHINE =3D "xarina-s-evb"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; SRCREV =3D "0e62087ecc399256624095f82e8b90c95c0e3=
b36"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; SRC_URI =3D "${HOMAM_GIT_URI}/xarina-kernel-sourc=
e.git;protocol=3D${HOMAM_GIT_PROTOCOL};nobranch=3D1"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; SRC_URI +=3D "file://xarina-s-evb-standard.scc \<=
/div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file://=
xarina-s-evb-user-config.cfg \</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file://=
defconfig \</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"</div>
<div>&nbsp; &nbsp; &nbsp; S =3D "${WORKDIR}/git"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; LINUX_VERSION =3D "3.14.62"</div>
<div>&nbsp; &nbsp; &nbsp; LOCALVERSION =3D "-fido1.8-xarina"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; PV =3D "${LINUX_VERSION}+git${SRCPV}"</div>
<div>&nbsp; &nbsp; &nbsp; PR =3D "r1"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; DEPENDS +=3D "lzop-native xz-native"</div>
<div>&nbsp; &nbsp; &nbsp; DEPENDS +=3D "mtd-utils-native"</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; UBIFS_TMPDIR =3D "linux_tmp"</div>
<div>&nbsp;</div>
<div>```</div>
<div>The code above includes 'kernel_wireless_regdb.bbclass' file.</div>
<div>&nbsp;</div>
<div>The 'kernel_wireless_regdb' recipe implementation is located in meta-o=
penembedded layer: https://github.com/openembedded/meta-openembedded/blob/m=
aster/meta-networking/classes/kernel_wireless_regdb.bbclass</div>
<div>&nbsp;</div>
<div>Here you can see the dependence:</div>
<div>&nbsp; &nbsp; addtask kernel_add_regdb before do_build after do_config=
ure</div>
<div>That breaks eSDK build.</div>
<div>&nbsp;</div>
<div>I tried to add '_setscene' version of the task 'do_kernel_add_regdb' b=
ut it does not help:</div>
<div>&nbsp;</div>
<div>```</div>
<div>&nbsp; &nbsp; python do_kernel_add_regdb_setscene () {</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; sstate_setscene(d)</div>
<div>&nbsp; &nbsp; }</div>
<div>&nbsp; &nbsp; addtask do_kernel_add_regdb_setscene</div>
<div>&nbsp; &nbsp; SSTATETASKS +=3D "kernel_add_regdb"</div>
<div>```</div>
<div>&nbsp;</div>
<div>If I exlude the line with 'inherit kernel_wireless_regdb' then eSDK bu=
ilt with success.</div>
<div>But unfortunately we can not exclude WIFI CRDA list in our project.</d=
iv>
<div>&nbsp;</div>
<div>Could you please suggest a proper solution for this bug, not using a c=
ustom workaround?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thank you in advance,<br />Michail.<br /><br /></div>

--Rl7HHD0dkL72C852DGD2--

