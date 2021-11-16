Return-Path: <michail.kurochkin@zorachka.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD4AC433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 22:15:15 +0000 (UTC)
Subject: Re: eSDK 'setscene whitelist'
To: bitbake-devel@lists.openembedded.org
From: "Michail Kurochkin" <michail.kurochkin@zorachka.com>
X-Originating-Location: BY (91.149.141.6)
X-Originating-Platform: Linux Chrome 80
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 16 Nov 2021 14:15:15 -0800
References: 
 <e234dbfabaaf26b609a594cf0d0e9aa5035350c7.camel@linuxfoundation.org>
In-Reply-To: 
 <e234dbfabaaf26b609a594cf0d0e9aa5035350c7.camel@linuxfoundation.org>
Message-ID: <2793.1637100915461282223@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="aAl0f4MxKJJuBd0aRT6h"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 22:15:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13064

--aAl0f4MxKJJuBd0aRT6h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for the detail response. You clarified a lot of things.

Really the problem is not in xarina-s-evb-image-debug.bb:do_image_complete.
The problem is that in the buildable tasks list for some reason there is a =
task linux-xarina_git.bb:do_fetch that must not be there.

Before execute populate_sdk_ext I disabled initramfs in defconfig. After po=
pulate_sdk_ext I made sure that it is disabled:
xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/linux-xarina/=
3.14.62+gitAUTOINC+0e62087ecc-r1/build/.config
# CONFIG_BLK_DEV_INITRD is not set

I added displaying variable DISTRO_FEATURES in bitbake execute() function t=
o make sure that thereis no feature 'ram' there.
DISTRO_FEATURES =3D acl alsa argp bluetooth ext2 ipv4 ipv6 largefile=C2=A0 =
=C2=A0usbhost wifi xattr nfs zeroconf=C2=A0 =C2=A0 =C2=A0vfat largefile=C2=
=A0 ptest multiarch=C2=A0 =C2=A0systemd bluetooth bluez5 alsa wifi ext2 vfa=
t usbhost systemd bluetooth bluez5 alsa wifi ext2 vfat usbhost
IMAGE_FSTYPES =3D=C2=A0 ext4

Then in the directory tmp-renamed-sdk I run bitbake -n:
cd xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s-e=
vb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk
rm -rf tmp
PYTHONDONTWRITEBYTECODE=3D1 PSEUDO_DISABLED=3D1 BB_SETSCENE_ENFORCE=3D1 bit=
bake -n xarina-s-evb-image-debug

In the result I got the errors:

ERROR: Task linux-xarina.do_fetch attempted to execute unexpectedly
Task xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s=
-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina-sdk/met=
a-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-debug.bb:do_deploy_s=
ource_date_epoch, unihash 0b0a62440b45184cf9d01d14b4b4cb8ffa19b248f02e9494a=
cbe2ac0d753cd69, taskhash 0b0a62440b45184cf9d01d14b4b4cb8ffa19b248f02e9494a=
cbe2ac0d753cd69
Task xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s=
-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina-sdk/met=
a-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-debug.bb:do_image_qa=
, unihash dabb90c211e53448968cb0ca017471b0029d9b86a8625c23b68c1ea24716a7c4,=
 taskhash dabb90c211e53448968cb0ca017471b0029d9b86a8625c23b68c1ea24716a7c4
Task xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s=
-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina-sdk/met=
a-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-debug.bb:do_image_co=
mplete, unihash 926c79419b748a7e8532ac1737d933fcc8c2f2c74992eccd3c4421e87b0=
bef5c, taskhash 926c79419b748a7e8532ac1737d933fcc8c2f2c74992eccd3c4421e87b0=
bef5c
This is usually due to missing setscene tasks. Those missing in this build =
were: {'xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarin=
a-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina-sdk/=
meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-debug.bb:do_deplo=
y_source_date_epoch',
'xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s-evb=
-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina-sdk/meta-xa=
rina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-debug.bb:do_image_comple=
te',
'xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s-evb=
-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina-sdk/meta-xa=
rina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-debug.bb:do_image_qa'}
ERROR: Task (xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/=
xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/layers/xarina=
-sdk/meta-xarina-bsp-evb/recipes-kernel/linux/linux-xarina_git.bb:do_fetch)=
 failed with exit code 'setscene whitelist'

After that in the stamp directory there are only sigbasedata including _set=
scene tasks.
xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s-evb-=
image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/tmp/stamps/xarina_s_evb-po=
ky-linux-gnueabi/linux-xarina :

3.14.62+gitAUTOINC+0e62087ecc-r1.do_build.sigbasedata.f7e0581ab0862694e68d7=
0c3ea75af4cd09d12d2dc80c578e3020d5d84004d24
3.14.62+gitAUTOINC+0e62087ecc-r1.do_bundle_initramfs.sigbasedata.35dd9ae928=
f13ec025a03d1bbedb2ea05cbf9013809110ba4f94b3b20a21647a
3.14.62+gitAUTOINC+0e62087ecc-r1.do_checkuri.sigbasedata.7f538038d85f831a62=
9e7fe35e6de396b1d42d345aa8591ee64886ae348553af
3.14.62+gitAUTOINC+0e62087ecc-r1.do_cleanall.sigbasedata.6bb9b07c233ac448fc=
38b389fb344b2875592d24f2a37fa8694251bde29e1256
3.14.62+gitAUTOINC+0e62087ecc-r1.do_clean.sigbasedata.d4b156e81ae2a9174326f=
4483b96aa9eab52dc9a6a87fc684dcfc1445dae2e2c
3.14.62+gitAUTOINC+0e62087ecc-r1.do_cleansstate.sigbasedata.b0fe786786fa0c3=
d5d3db669923b4130e81db33565ed100210af3bceff93d4e8
3.14.62+gitAUTOINC+0e62087ecc-r1.do_compile_kernelmodules.sigbasedata.88bce=
b2a9a223a010146ff1d0bd867c9f3d4b5e488df17a6b06bc306bcd59423
3.14.62+gitAUTOINC+0e62087ecc-r1.do_compile.sigbasedata.6ed8f6a2676ba19f343=
0b823b6a72ec0232e0743f32dd7d34abbee2781f3efae
3.14.62+gitAUTOINC+0e62087ecc-r1.do_configure.sigbasedata.339bae90c84c715c1=
d50b160e01bbd6db9cd837016eb84574ae723e1fd32aa64
3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy_setscene.sigbasedata.e78ab72e883=
eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy.sigbasedata.5c2ec19c5f16a3ccf72b=
dcc77244f69ecf06fcf4c3a30545c419ea9bacbee240
3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy_source_date_epoch_setscene.sigba=
sedata.763845042a23224650a503fabc4287e00eb81ff349cf28dda0047e8757c7110a
3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy_source_date_epoch.sigbasedata.0f=
69f14c141d908c721a5b1ccda17e7b1b88ae838de137857c270c2ffb820d8c
3.14.62+gitAUTOINC+0e62087ecc-r1.do_devpyshell.sigbasedata.2a74e89c8c0360cd=
6e1281da39d0a66c11fd7e571fd2bd7eebc02f6766fbe207
3.14.62+gitAUTOINC+0e62087ecc-r1.do_devshell.sigbasedata.4e8d2f6444ba0c9919=
cae79927e8e16c2ed777b892501d7a04cbc8b2939e85ac
3.14.62+gitAUTOINC+0e62087ecc-r1.do_diffconfig.sigbasedata.86ed27cdd5c5b393=
4e12296bca72c40b52a332f9b3d6cb350531d7970f412874
3.14.62+gitAUTOINC+0e62087ecc-r1.do_fetch.sigbasedata.5ab1a7e486a31a9944c59=
446c4c4135bf5d6961d767aa0456d140c6dd10ee1d8
3.14.62+gitAUTOINC+0e62087ecc-r1.do_install.sigbasedata.6fb52d153045a9b2233=
d31c90bd04f69f3baf2357893ceb1290c31a67f882a0d
3.14.62+gitAUTOINC+0e62087ecc-r1.do_kernel_add_regdb.sigbasedata.947c5189bf=
c6b4c01a42a1ba9d3052f85bdd332e907b667fc2565d0b356a88d4
3.14.62+gitAUTOINC+0e62087ecc-r1.do_kernel_link_images.sigbasedata.fa358fea=
f63e05aa2ade4a650c479a1feb4f74c176df2873607854894f51645a
3.14.62+gitAUTOINC+0e62087ecc-r1.do_listtasks.sigbasedata.12ae738d3561f977d=
3dc38ff7b21073cd916045f993f8be8e394b5b683ed26c9
3.14.62+gitAUTOINC+0e62087ecc-r1.do_menuconfig.sigbasedata.f4fd7c2860d845a7=
fdfbea5a727c24fa2373fa6b23eb99c3fac2e498639babfd
3.14.62+gitAUTOINC+0e62087ecc-r1.do_packagedata_setscene.sigbasedata.e78ab7=
2e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
3.14.62+gitAUTOINC+0e62087ecc-r1.do_packagedata.sigbasedata.6ecebd0eeb15e79=
63358218b990028456d039258ec81a3e277006f5fead0ecda
3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_qa_setscene.sigbasedata.e78ab72=
e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_qa.sigbasedata.15718e73ab4f2b0f=
47f4c3c0ffb0ae82117842f7e40eaedb4b9f666b7df9469c
3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_setscene.sigbasedata.3e1a33a2a4=
13b5cf8e7da487da52b7a64a5366e3d1eb1238a16cddc4f8fb98b8
3.14.62+gitAUTOINC+0e62087ecc-r1.do_package.sigbasedata.5d3b8b09899dfa40991=
11a1c1dd6df1f58dc0cd11eaf3c900cb81cb94a48c5b5
3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_write_ipk_setscene.sigbasedata.=
64385b8d67399fcf96686c998012e79a3934afa900a4793fdaaba066c249d794
3.14.62+gitAUTOINC+0e62087ecc-r1.do_package_write_ipk.sigbasedata.192ebe1c2=
ae834f8fffe0c840c39b62ee0b1423256595547674653c42988a576
3.14.62+gitAUTOINC+0e62087ecc-r1.do_patch.sigbasedata.249ec0cba88dd64fcb1c9=
f3507736f78734ef3c2e5703747e442c95c87800df8
3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_lic_setscene.sigbasedata.e78ab=
72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_lic.sigbasedata.b47980ee2cc961=
c089105d66ebb7e1689de782e3bc118e4e28aa23bf1d78dffb
3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_sysroot_setscene.sigbasedata.e=
78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8fb432beac783
3.14.62+gitAUTOINC+0e62087ecc-r1.do_populate_sysroot.sigbasedata.8c218fc932=
7c9f6f3353e4559d037d9b76c3fc65a9ec7c8374c07aca6938200a
3.14.62+gitAUTOINC+0e62087ecc-r1.do_prepare_recipe_sysroot.sigbasedata.4b27=
24167c5932203819023a5b7d39de232f015d4a6cc77269955c2738f6c65f
3.14.62+gitAUTOINC+0e62087ecc-r1.do_savedefconfig.sigbasedata.67d8b6f786936=
f07bed92cc8ccd9f6cc7aae56e6e7f82a5cd78bd67f8814b638
3.14.62+gitAUTOINC+0e62087ecc-r1.do_shared_workdir_setscene.sigbasedata.211=
3500ee55f4ee47685992a4fb70d0443710300b540846e9d95bc9a2d1d3f21
3.14.62+gitAUTOINC+0e62087ecc-r1.do_shared_workdir.sigbasedata.599b889326c0=
fdc255a5285271fcce91acaa8473d6d2f6ff485b001c4a30887a
3.14.62+gitAUTOINC+0e62087ecc-r1.do_sizecheck.sigbasedata.d3ca1d63314915c51=
f7c6737e33b1d3a993e33d9c3bab5b1833a79b2a16ec679
3.14.62+gitAUTOINC+0e62087ecc-r1.do_strip.sigbasedata.78ed0d14f18b848f3fd93=
9d98b20912780332d726bb0dce7146d5f982142de88
3.14.62+gitAUTOINC+0e62087ecc-r1.do_symlink_kernsrc.sigbasedata.3548437dcad=
16ec9f5534906726b7b038bde4d514fad220fac0888af916de3a9
3.14.62+gitAUTOINC+0e62087ecc-r1.do_unpack.sigbasedata.d8e25fffc33ef8e1d517=
784ef4d27f20a5af7eb18d3bdce2cf7de7335f7936d8

I see that none of _setscene tasks was executed.

I am really at a dead end. Could you please advice what can I do next to fi=
nd out the reason of this.

I am a bit confused about your answer for 3.3
>>> It tells us if the task was run in entirety or whether it was restored =
from sstate.

Marking that _setscene task was or was not executed is definded in the same=
 way as for other tasks? I mean if there is a file xxx_setscene.sigbasedata=
.stamp does it mean that task was executed? And if there is not such a file=
 the task was not executed. It is right?

Looking forward to any help
Thanks.

Best Regards,
Michail

--aAl0f4MxKJJuBd0aRT6h
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Thanks a lot for the detail response. You clarified a lot of things.</=
div>
<div>&nbsp;</div>
<div>Really the problem is not in xarina-s-evb-image-debug.bb:do_image_comp=
lete.</div>
<div>The problem is that in the buildable tasks list for some reason there =
is a task linux-xarina_git.bb:do_fetch that must not be there.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Before execute populate_sdk_ext I disabled initramfs in defconfig. Aft=
er populate_sdk_ext I made sure that it is disabled:</div>
<div>xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gnueabi/linux-xa=
rina/3.14.62+gitAUTOINC+0e62087ecc-r1/build/.config</div>
<div># CONFIG_BLK_DEV_INITRD is not set</div>
<div>&nbsp;</div>
<div>I added displaying variable DISTRO_FEATURES in bitbake execute() funct=
ion to make sure that thereis no feature 'ram' there.</div>
<div>&nbsp; &nbsp; DISTRO_FEATURES =3D acl alsa argp bluetooth ext2 ipv4 ip=
v6 largefile&nbsp; &nbsp;usbhost wifi xattr nfs zeroconf&nbsp; &nbsp; &nbsp=
;vfat largefile&nbsp; ptest multiarch&nbsp; &nbsp;systemd bluetooth bluez5 =
alsa wifi ext2 vfat usbhost systemd bluetooth bluez5 alsa wifi ext2 vfat us=
bhost</div>
<div>&nbsp; &nbsp; IMAGE_FSTYPES =3D&nbsp; ext4</div>
<div>&nbsp;</div>
<div>Then in the directory tmp-renamed-sdk I run bitbake -n:</div>
<div>&nbsp; &nbsp; cd xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux=
-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk</div=
>
<div>&nbsp; &nbsp; rm -rf tmp</div>
<div>&nbsp; &nbsp; PYTHONDONTWRITEBYTECODE=3D1 PSEUDO_DISABLED=3D1 BB_SETSC=
ENE_ENFORCE=3D1 bitbake -n xarina-s-evb-image-debug</div>
<div>&nbsp;</div>
<div>In the result I got the errors:</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; ERROR: Task linux-xarina.do_fetch attempted to execute u=
nexpectedly</div>
<div>&nbsp; &nbsp; Task xarina-build-dunfell/tmp/work/xarina_s_evb-poky-lin=
ux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/la=
yers/xarina-sdk/meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-d=
ebug.bb:do_deploy_source_date_epoch, unihash 0b0a62440b45184cf9d01d14b4b4cb=
8ffa19b248f02e9494acbe2ac0d753cd69, taskhash 0b0a62440b45184cf9d01d14b4b4cb=
8ffa19b248f02e9494acbe2ac0d753cd69</div>
<div>&nbsp; &nbsp; Task xarina-build-dunfell/tmp/work/xarina_s_evb-poky-lin=
ux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/la=
yers/xarina-sdk/meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-d=
ebug.bb:do_image_qa, unihash dabb90c211e53448968cb0ca017471b0029d9b86a8625c=
23b68c1ea24716a7c4, taskhash dabb90c211e53448968cb0ca017471b0029d9b86a8625c=
23b68c1ea24716a7c4</div>
<div>&nbsp; &nbsp; Task xarina-build-dunfell/tmp/work/xarina_s_evb-poky-lin=
ux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/la=
yers/xarina-sdk/meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image-d=
ebug.bb:do_image_complete, unihash 926c79419b748a7e8532ac1737d933fcc8c2f2c7=
4992eccd3c4421e87b0bef5c, taskhash 926c79419b748a7e8532ac1737d933fcc8c2f2c7=
4992eccd3c4421e87b0bef5c</div>
<div>&nbsp; &nbsp; This is usually due to missing setscene tasks. Those mis=
sing in this build were: {'xarina-build-dunfell/tmp/work/xarina_s_evb-poky-=
linux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk=
/layers/xarina-sdk/meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-imag=
e-debug.bb:do_deploy_source_date_epoch',</div>
<div>&nbsp; &nbsp; &nbsp;'xarina-build-dunfell/tmp/work/xarina_s_evb-poky-l=
inux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/=
layers/xarina-sdk/meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image=
-debug.bb:do_image_complete',</div>
<div>&nbsp; &nbsp; &nbsp;'xarina-build-dunfell/tmp/work/xarina_s_evb-poky-l=
inux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/=
layers/xarina-sdk/meta-xarina-bsp-evb/recipes-bsp/images/xarina-s-evb-image=
-debug.bb:do_image_qa'}</div>
<div>&nbsp; &nbsp; ERROR: Task (xarina-build-dunfell/tmp/work/xarina_s_evb-=
poky-linux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-rename=
d-sdk/layers/xarina-sdk/meta-xarina-bsp-evb/recipes-kernel/linux/linux-xari=
na_git.bb:do_fetch) failed with exit code 'setscene whitelist'</div>
<div>&nbsp;</div>
<div>After that in the stamp directory there are only sigbasedata including=
 _setscene tasks.</div>
<div>&nbsp; &nbsp; xarina-build-dunfell/tmp/work/xarina_s_evb-poky-linux-gn=
ueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ext/image/tmp-renamed-sdk/tmp/sta=
mps/xarina_s_evb-poky-linux-gnueabi/linux-xarina :</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_build.=
sigbasedata.f7e0581ab0862694e68d70c3ea75af4cd09d12d2dc80c578e3020d5d84004d2=
4</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_bundle=
_initramfs.sigbasedata.35dd9ae928f13ec025a03d1bbedb2ea05cbf9013809110ba4f94=
b3b20a21647a</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_checku=
ri.sigbasedata.7f538038d85f831a629e7fe35e6de396b1d42d345aa8591ee64886ae3485=
53af</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_cleana=
ll.sigbasedata.6bb9b07c233ac448fc38b389fb344b2875592d24f2a37fa8694251bde29e=
1256</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_clean.=
sigbasedata.d4b156e81ae2a9174326f4483b96aa9eab52dc9a6a87fc684dcfc1445dae2e2=
c</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_cleans=
state.sigbasedata.b0fe786786fa0c3d5d3db669923b4130e81db33565ed100210af3bcef=
f93d4e8</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_compil=
e_kernelmodules.sigbasedata.88bceb2a9a223a010146ff1d0bd867c9f3d4b5e488df17a=
6b06bc306bcd59423</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_compil=
e.sigbasedata.6ed8f6a2676ba19f3430b823b6a72ec0232e0743f32dd7d34abbee2781f3e=
fae</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_config=
ure.sigbasedata.339bae90c84c715c1d50b160e01bbd6db9cd837016eb84574ae723e1fd3=
2aa64</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy=
_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d8e8f=
b432beac783</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy=
.sigbasedata.5c2ec19c5f16a3ccf72bdcc77244f69ecf06fcf4c3a30545c419ea9bacbee2=
40</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy=
_source_date_epoch_setscene.sigbasedata.763845042a23224650a503fabc4287e00eb=
81ff349cf28dda0047e8757c7110a</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_deploy=
_source_date_epoch.sigbasedata.0f69f14c141d908c721a5b1ccda17e7b1b88ae838de1=
37857c270c2ffb820d8c</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_devpys=
hell.sigbasedata.2a74e89c8c0360cd6e1281da39d0a66c11fd7e571fd2bd7eebc02f6766=
fbe207</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_devshe=
ll.sigbasedata.4e8d2f6444ba0c9919cae79927e8e16c2ed777b892501d7a04cbc8b2939e=
85ac</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_diffco=
nfig.sigbasedata.86ed27cdd5c5b3934e12296bca72c40b52a332f9b3d6cb350531d7970f=
412874</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_fetch.=
sigbasedata.5ab1a7e486a31a9944c59446c4c4135bf5d6961d767aa0456d140c6dd10ee1d=
8</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_instal=
l.sigbasedata.6fb52d153045a9b2233d31c90bd04f69f3baf2357893ceb1290c31a67f882=
a0d</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_kernel=
_add_regdb.sigbasedata.947c5189bfc6b4c01a42a1ba9d3052f85bdd332e907b667fc256=
5d0b356a88d4</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_kernel=
_link_images.sigbasedata.fa358feaf63e05aa2ade4a650c479a1feb4f74c176df287360=
7854894f51645a</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_listta=
sks.sigbasedata.12ae738d3561f977d3dc38ff7b21073cd916045f993f8be8e394b5b683e=
d26c9</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_menuco=
nfig.sigbasedata.f4fd7c2860d845a7fdfbea5a727c24fa2373fa6b23eb99c3fac2e49863=
9babfd</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
edata_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889=
d8e8fb432beac783</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
edata.sigbasedata.6ecebd0eeb15e7963358218b990028456d039258ec81a3e277006f5fe=
ad0ecda</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
e_qa_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d5889d=
8e8fb432beac783</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
e_qa.sigbasedata.15718e73ab4f2b0f47f4c3c0ffb0ae82117842f7e40eaedb4b9f666b7d=
f9469c</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
e_setscene.sigbasedata.3e1a33a2a413b5cf8e7da487da52b7a64a5366e3d1eb1238a16c=
ddc4f8fb98b8</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
e.sigbasedata.5d3b8b09899dfa4099111a1c1dd6df1f58dc0cd11eaf3c900cb81cb94a48c=
5b5</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
e_write_ipk_setscene.sigbasedata.64385b8d67399fcf96686c998012e79a3934afa900=
a4793fdaaba066c249d794</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_packag=
e_write_ipk.sigbasedata.192ebe1c2ae834f8fffe0c840c39b62ee0b1423256595547674=
653c42988a576</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_patch.=
sigbasedata.249ec0cba88dd64fcb1c9f3507736f78734ef3c2e5703747e442c95c87800df=
8</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_popula=
te_lic_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7d588=
9d8e8fb432beac783</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_popula=
te_lic.sigbasedata.b47980ee2cc961c089105d66ebb7e1689de782e3bc118e4e28aa23bf=
1d78dffb</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_popula=
te_sysroot_setscene.sigbasedata.e78ab72e883eb6d98f3ab9cde98112204a9a1ff16b7=
d5889d8e8fb432beac783</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_popula=
te_sysroot.sigbasedata.8c218fc9327c9f6f3353e4559d037d9b76c3fc65a9ec7c8374c0=
7aca6938200a</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_prepar=
e_recipe_sysroot.sigbasedata.4b2724167c5932203819023a5b7d39de232f015d4a6cc7=
7269955c2738f6c65f</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_savede=
fconfig.sigbasedata.67d8b6f786936f07bed92cc8ccd9f6cc7aae56e6e7f82a5cd78bd67=
f8814b638</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_shared=
_workdir_setscene.sigbasedata.2113500ee55f4ee47685992a4fb70d0443710300b5408=
46e9d95bc9a2d1d3f21</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_shared=
_workdir.sigbasedata.599b889326c0fdc255a5285271fcce91acaa8473d6d2f6ff485b00=
1c4a30887a</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_sizech=
eck.sigbasedata.d3ca1d63314915c51f7c6737e33b1d3a993e33d9c3bab5b1833a79b2a16=
ec679</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_strip.=
sigbasedata.78ed0d14f18b848f3fd939d98b20912780332d726bb0dce7146d5f982142de8=
8</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_symlin=
k_kernsrc.sigbasedata.3548437dcad16ec9f5534906726b7b038bde4d514fad220fac088=
8af916de3a9</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; 3.14.62+gitAUTOINC+0e62087ecc-r1.do_unpack=
.sigbasedata.d8e25fffc33ef8e1d517784ef4d27f20a5af7eb18d3bdce2cf7de7335f7936=
d8</div>
<div>&nbsp;</div>
<div>I see that none of _setscene tasks was executed.</div>
<div>&nbsp;</div>
<div>I am really at a dead end. Could you please advice what can I do next =
to find out the reason of this.</div>
<div>&nbsp;</div>
<div>I am a bit confused about your answer for 3.3</div>
<div>&gt;&gt;&gt; It tells us if the task was run in entirety or whether it=
 was restored from sstate.</div>
<div>&nbsp;</div>
<div>Marking that _setscene task was or was not executed is definded in the=
 same way as for other tasks? I mean if there is a file xxx_setscene.sigbas=
edata.stamp does it mean that task was executed? And if there is not such a=
 file the task was not executed. It is right?</div>
<div>&nbsp;</div>
<div>Looking forward to any help</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>Best Regards,</div>
<div>Michail</div>
<div>&nbsp;</div>

--aAl0f4MxKJJuBd0aRT6h--

