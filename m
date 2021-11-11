Return-Path: <michail.kurochkin@zorachka.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A1C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 23:42:55 +0000 (UTC)
Subject: eSDK 'setscene whitelist'
To: bitbake-devel@lists.openembedded.org
From: "Michail Kurochkin" <michail.kurochkin@zorachka.com>
X-Originating-Location: BY (91.149.141.6)
X-Originating-Platform: Linux Chrome 80
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 11 Nov 2021 15:42:55 -0800
Message-ID: <kbp1.1636674175283754737.sZv2@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="A58i5n9Xh33mikTvZ5aH"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 23:42:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13027

--A58i5n9Xh33mikTvZ5aH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,
I am writing to ask if you could possibly help me to resolve error during b=
uilding eSDK.

During building eSDK I faced an error: failed with exit code 'setscene whit=
elist'.

Preconditions:
- Yocto dunfell
- used SoC vendor's layer xarina-sdk
- distro: xarina-s-evb-distro based on poky version: 3.1.11
- machine: xarina-s-evb cortexa9hf-neon

- The issue is reproduced on:
distro: xarina-s-evb-distro
machine: xarina-s-evb
target: xarina-s-evb-image-debug

- The issue is not reproduced on:
distro: poky
machine:qemux86-64
target: core-image-minimal

During processing 'bitbake xarina-s-evb-image-debug -c populate_sdk_ext' th=
e new build-system is generated to the directory 'xarina-build-dunfell/tmp/=
work/xarina_s_evb-poky-linux-gnueabi/xarina-s-evb-image-debug/1.0-r0/sdk-ex=
t/image/tmp-renamed-sdk'.

After that in 'tmp-renamed-sdk' is executed 'BB_SETSCENE_ENFORCE=3D1 bitbak=
e -n xarina-s-evb-image-debug'. But it fails with 'setscene whitelist' erro=
r. Bitbake attempts to execute a task 'linux-xarina:do_fetch'. But this tas=
k is not under the whitelist established for 'tmp-renamed-sdk'. Bitbake att=
empts to execute 'linux-xarina:do_fetch' because it depends on another task=
 'xarina-s-evb-image-debug:do_image_complete' that is not covered. But it i=
s supposed to be covered by the time of creation 'tmp-renamed-sdk'.

I have the following stamp files for the task 'xarina-s-evb-image-debug:do_=
image_complete':
In the original build system stamp files:
do_image_complete.4016b0b3eca996a1bf85306886e895555affb655a5c66cd7042760749=
b372a04.xarina_s_evb
do_image_complete_setscene.sigbasedata.4ad046af069b754c70e9c791b62e737777b4=
1f04dc4354eb65255d39118844a1
do_image_complete.sigbasedata.3262e62d12c0460539aa7d4696957b662f39ee172e135=
1e8a60d845df8e3fdd4
do_image_complete.sigbasedata.954712fcd44e248587d7287939ba449453f56581e21d7=
eb80e766b9fd67113b2
do_image_complete.sigbasedata.bab4a6d4ae8ff5b8ee789fb5b4c3a386b751d8fa04b85=
a32c76648190471d6b8
do_image_complete.sigbasedata.e77b9b9468bb8e687a77739091458e8384ddbc5708396=
470d8fdf1fccf6cbaea
do_image_complete.sigdata.1bdf5d197c3795c552a2f01b0b7e5cf12c406c5002301a7ca=
b12bd2ca39558b5
do_image_complete.sigdata.4016b0b3eca996a1bf85306886e895555affb655a5c66cd70=
42760749b372a04

And in the 'tmp-renamed-sdk' build system stamp files:
do_image_complete_setscene.sigbasedata.46473df9fc35eb915d83681fbcdf70188886=
46d2e8aeca00f826a3340fbe8564
do_image_complete.sigbasedata.954712fcd44e248587d7287939ba449453f56581e21d7=
eb80e766b9fd67113b2

Why is 'xarina-s-evb-image-debug:do_image_complete' is not covered? How to =
find out why it is not covered? What could help me to find out this?

This issue make me crazy. I have spent a lot of time for this.
During investigation the issue I have got some questions. It would be appre=
ciated if you could help me to find answers to the following questions:
1) A task have a taskhash. Why do we need a basehash and a unihash for a ta=
sk ? What is the point of these hashes?
2) Stamp files. In the stamp files directory there are four types of files:
- do_xxx.hash
- do_xxx.sigbasedata.hash
- do_xxx.sigdata.hash
- do_xxx.siginfo.hash
I guess the first one indicates that the task is complete.
I heard of utilities =E2=80=9Cbitbake-dumpsig=E2=80=9D and =E2=80=9Cbitbake=
-diffsig=E2=80=9D that could help me to find out the reason of the differen=
ce between tasks sources, that leads to different stamp files. But the util=
ities do not work if the task does not have a *.sigdata.* stamp file. In my=
 case mostly *.sigdata.* files are absent for the tasks. Why some tasks do =
have *.sigdata.* stamp files but other don=E2=80=99t? In the build director=
y tmp-renamed-sdk I did not find any *.sigdata.* stamp files at all.

3) I have read a lot of documentations about setscene. But it does not make=
 much sense for me.
3.1) How, when and depending on what is generated the source code for a tas=
k =E2=80=9Cxxx_setscene=E2=80=9D? Is there any source code of =E2=80=9Cxxx_=
setscene=E2=80=9D task?=C2=A0 Or is "_setscene" just a text string (mark/su=
ffix) meaning that there is no need to execute a task =E2=80=9Cxxx=E2=80=9D=
 and instead of execution it is needed to unpack the task =E2=80=9Cxxx=E2=
=80=9D artifacts from the sstate-cache?

3.2) Some tasks can have '_setscene' versions and others can not. How does =
bitbake determines that a task can have a '_setscene' version or the task c=
annot have it in general? Can I create a 'xxx_setscene' task directly?

3.3) What do mean hashes in the names of stamp files for the tasks 'xxx_set=
scene'? What is the difference between them and those I mentioned in the po=
int 1 and 2?

4) Is there any documentation for bitbake-core that could in details descri=
be internal structure, logic and algorithms for: task-shedulers, resipe-dep=
endencies, resipe-caches, stamp files, sstate-cache etc. ?

Unfortunately documentations =E2=80=9CYocto Mega Manual=E2=80=9Dand =E2=80=
=9CBitbalke User Manual=E2=80=9D describes these topics superficially. Perh=
aps is there any additional documentation for internal logic and algorithms=
 of Bitbake?

It would be much appreciated if you could help me to find a solution to sol=
ve eSDK issue and help me to find the answers about Bitbake internal struct=
ure.

Thank you in advance,
Michail

--A58i5n9Xh33mikTvZ5aH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hello all,</div>
<div>I am writing to ask if you could possibly help me to resolve error dur=
ing building eSDK.</div>
<div>&nbsp;</div>
<div>During building eSDK I faced an error: failed with exit code 'setscene=
 whitelist'.</div>
<div>&nbsp;</div>
<div>Preconditions:</div>
<div>&nbsp; - Yocto dunfell</div>
<div>&nbsp; - used SoC vendor's layer xarina-sdk</div>
<div>&nbsp; - distro: xarina-s-evb-distro based on poky version: 3.1.11</di=
v>
<div>&nbsp; - machine: xarina-s-evb cortexa9hf-neon</div>
<div>&nbsp;</div>
<div>&nbsp; - The issue is reproduced on:</div>
<div>&nbsp; &nbsp; &nbsp; distro: xarina-s-evb-distro</div>
<div>&nbsp; &nbsp; &nbsp; machine: xarina-s-evb</div>
<div>&nbsp; &nbsp; &nbsp; target: xarina-s-evb-image-debug</div>
<div>&nbsp;</div>
<div>&nbsp; - The issue is not reproduced on:</div>
<div>&nbsp; &nbsp; &nbsp; distro: poky</div>
<div>&nbsp; &nbsp; &nbsp; machine:qemux86-64</div>
<div>&nbsp; &nbsp; &nbsp; target: core-image-minimal</div>
<div>&nbsp;</div>
<div>During processing 'bitbake xarina-s-evb-image-debug -c populate_sdk_ex=
t' the new build-system is generated to the directory 'xarina-build-dunfell=
/tmp/work/xarina_s_evb-poky-linux-gnueabi/xarina-s-evb-image-debug/1.0-r0/s=
dk-ext/image/tmp-renamed-sdk'.</div>
<div>&nbsp;</div>
<div>After that in 'tmp-renamed-sdk' is executed 'BB_SETSCENE_ENFORCE=3D1 b=
itbake -n xarina-s-evb-image-debug'. But it fails with 'setscene whitelist'=
 error. Bitbake attempts to execute a task 'linux-xarina:do_fetch'. But thi=
s task is not under the whitelist established for 'tmp-renamed-sdk'. Bitbak=
e attempts to execute 'linux-xarina:do_fetch' because it depends on another=
 task 'xarina-s-evb-image-debug:do_image_complete' that is not covered. But=
 it is supposed to be covered by the time of creation 'tmp-renamed-sdk'.</d=
iv>
<div>&nbsp;</div>
<div>I have the following stamp files for the task 'xarina-s-evb-image-debu=
g:do_image_complete':</div>
<div>&nbsp; In the original build system stamp files:</div>
<div>&nbsp; &nbsp; do_image_complete.4016b0b3eca996a1bf85306886e895555affb6=
55a5c66cd7042760749b372a04.xarina_s_evb</div>
<div>&nbsp; &nbsp; do_image_complete_setscene.sigbasedata.4ad046af069b754c7=
0e9c791b62e737777b41f04dc4354eb65255d39118844a1</div>
<div>&nbsp; &nbsp; do_image_complete.sigbasedata.3262e62d12c0460539aa7d4696=
957b662f39ee172e1351e8a60d845df8e3fdd4</div>
<div>&nbsp; &nbsp; do_image_complete.sigbasedata.954712fcd44e248587d7287939=
ba449453f56581e21d7eb80e766b9fd67113b2</div>
<div>&nbsp; &nbsp; do_image_complete.sigbasedata.bab4a6d4ae8ff5b8ee789fb5b4=
c3a386b751d8fa04b85a32c76648190471d6b8</div>
<div>&nbsp; &nbsp; do_image_complete.sigbasedata.e77b9b9468bb8e687a77739091=
458e8384ddbc5708396470d8fdf1fccf6cbaea</div>
<div>&nbsp; &nbsp; do_image_complete.sigdata.1bdf5d197c3795c552a2f01b0b7e5c=
f12c406c5002301a7cab12bd2ca39558b5</div>
<div>&nbsp; &nbsp; do_image_complete.sigdata.4016b0b3eca996a1bf85306886e895=
555affb655a5c66cd7042760749b372a04</div>
<div>&nbsp;</div>
<div>&nbsp; And in the 'tmp-renamed-sdk' build system stamp files:</div>
<div>&nbsp; &nbsp; do_image_complete_setscene.sigbasedata.46473df9fc35eb915=
d83681fbcdf7018888646d2e8aeca00f826a3340fbe8564</div>
<div>&nbsp; &nbsp; do_image_complete.sigbasedata.954712fcd44e248587d7287939=
ba449453f56581e21d7eb80e766b9fd67113b2</div>
<div>&nbsp;</div>
<div>Why is 'xarina-s-evb-image-debug:do_image_complete' is not covered? Ho=
w to find out why it is not covered? What could help me to find out this?</=
div>
<div>&nbsp;</div>
<div>This issue make me crazy. I have spent a lot of time for this.</div>
<div>During investigation the issue I have got some questions. It would be =
appreciated if you could help me to find answers to the following questions=
:</div>
<div>&nbsp; 1) A task have a taskhash. Why do we need a basehash and a unih=
ash for a task ? What is the point of these hashes?</div>
<div>&nbsp; 2) Stamp files. In the stamp files directory there are four typ=
es of files:</div>
<div>&nbsp; &nbsp; &nbsp; - do_xxx.hash</div>
<div>&nbsp; &nbsp; &nbsp; - do_xxx.sigbasedata.hash</div>
<div>&nbsp; &nbsp; &nbsp; - do_xxx.sigdata.hash</div>
<div>&nbsp; &nbsp; &nbsp; - do_xxx.siginfo.hash</div>
<div>&nbsp; &nbsp; I guess the first one indicates that the task is complet=
e.</div>
<div>&nbsp; &nbsp; I heard of utilities &ldquo;bitbake-dumpsig&rdquo; and &=
ldquo;bitbake-diffsig&rdquo; that could help me to find out the reason of t=
he difference between tasks sources, that leads to different stamp files. B=
ut the utilities do not work if the task does not have a *.sigdata.* stamp =
file. In my case mostly *.sigdata.* files are absent for the tasks. Why som=
e tasks do have *.sigdata.* stamp files but other don&rsquo;t? In the build=
 directory tmp-renamed-sdk I did not find any *.sigdata.* stamp files at al=
l.</div>
<div>&nbsp;</div>
<div>&nbsp; 3) I have read a lot of documentations about setscene. But it d=
oes not make much sense for me.</div>
<div>&nbsp; &nbsp; &nbsp; 3.1) How, when and depending on what is generated=
 the source code for a task &ldquo;xxx_setscene&rdquo;? Is there any source=
 code of &ldquo;xxx_setscene&rdquo; task?&nbsp; Or is "_setscene" just a te=
xt string (mark/suffix) meaning that there is no need to execute a task &ld=
quo;xxx&rdquo; and instead of execution it is needed to unpack the task &ld=
quo;xxx&rdquo; artifacts from the sstate-cache?</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; 3.2) Some tasks can have '_setscene' versions and=
 others can not. How does bitbake determines that a task can have a '_setsc=
ene' version or the task cannot have it in general? Can I create a 'xxx_set=
scene' task directly?</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; 3.3) What do mean hashes in the names of stamp fi=
les for the tasks 'xxx_setscene'? What is the difference between them and t=
hose I mentioned in the point 1 and 2?</div>
<div>&nbsp;</div>
<div>&nbsp; 4) Is there any documentation for bitbake-core that could in de=
tails describe internal structure, logic and algorithms for: task-shedulers=
, resipe-dependencies, resipe-caches, stamp files, sstate-cache etc. ?</div=
>
<div>&nbsp;</div>
<div>Unfortunately documentations &ldquo;Yocto Mega Manual&rdquo;and &ldquo=
;Bitbalke User Manual&rdquo; describes these topics superficially. Perhaps =
is there any additional documentation for internal logic and algorithms of =
Bitbake?</div>
<div>&nbsp;</div>
<div>It would be much appreciated if you could help me to find a solution t=
o solve eSDK issue and help me to find the answers about Bitbake internal s=
tructure.</div>
<div>&nbsp;</div>
<div>Thank you in advance,</div>
<div>Michail</div>

--A58i5n9Xh33mikTvZ5aH--

