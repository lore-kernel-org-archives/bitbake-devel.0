Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBABC02180
	for <webhook@archiver.kernel.org>; Wed, 15 Jan 2025 21:30:26 +0000 (UTC)
Subject: Re: [scarthgap] bitbake extremely slow down during "Initialising tasks" #bitbake #scarthgap
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: =?UTF-8?B?U3R1dHRnYXJ0LCBCYWRlbi1Xw7xydHRlbWJlcmcsIERF?= (194.39.218.19)
X-Originating-Platform: Windows Chrome 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 13:30:24 -0800
References: <oFzD.1733010493142130647.Lr9X@lists.openembedded.org>
In-Reply-To: <oFzD.1733010493142130647.Lr9X@lists.openembedded.org>
Message-ID: <29326.1736976169205415623@lists.openembedded.org>
X-Old-Date: Wed, 15 Jan 2025 13:26:18 -0800
Content-Type: multipart/alternative; boundary="TeejHHrasQZJdvcZ22kD"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jan 2025 21:30:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17019
Message-ID: <20250115213024.GkYbJoNOJoWTJdlXyuVwtvw1ozycL2_thJi0BaXTRvw@z>

--TeejHHrasQZJdvcZ22kD
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

I started to look for some info about where could happen this slowdown effe=
ct in the bitbake lib.

In `self.rqdata.init_progress_reporter =3D bb.progress.MultiStageProcessPro=
gressReporter( ...` i enabled the `debug=3DTrue` arg/flag for getting some =
info about the elapsed time of the "Initialising tasks" and i compared it i=
n Ubuntu 22.04 and Ubuntu 20.04.

https://github.com/yoctoproject/poky/blob/scarthgap/bitbake/lib/bb/runqueue=
.py#L1565

Result is the following, i used my same ZynqMP Yocto project which released=
 from scarthgap.

Ubuntu 22.04 LTS:
```
NOTE: Fetching uninative binary shim http://downloads.yoctoproject.org/rele=
ases/uninative/4.6/x86_64-nativesdk-libc-4.6.tar.xz;sha256sum=3D6bf00154c5a=
7bc48adbf63fd17684bb87eb07f4814fbb482a3fbd817c1ccf4c5 (will check PREMIRROR=
S first)
Sstate summary: Wanted 2738 Local 0 Mirrors 0 Missed 2738 Current 0 (0% mat=
ch, 0% complete)###########################################################=
#####################################                     | ETA:  0:00:20
WARNING: Stage weights: [15, 16, 1, 4, 3, 4, 3, 4, 3, 3, 4, 3, 3, 221, 4, 6=
, 5, 3, 3, 5, 3, 17331, 4, 2, 4, 3, 82]
WARNING: Stage times:
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:828: 15
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:925: 16
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1007: 1
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1054: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1095: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1103: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1120: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1127: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1227: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1228: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1241: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1258: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1271: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1574: 221
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1579: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1588: 6
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2930: 5
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2941: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2955: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2984: 5
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3009: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3021: 17331
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3052: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3054: 2
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3072: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3080: 3
  Up to finish: 82
Initialising tasks: 100% |#################################################=
###########################################################################=
#########################################################| Time: 0:02:57
NOTE: Executing Tasks
```

Ubuntu 20.04 LTS:
```
NOTE: Fetching uninative binary shim http://downloads.yoctoproject.org/rele=
ases/uninative/4.6/x86_64-nativesdk-libc-4.6.tar.xz;sha256sum=3D6bf00154c5a=
7bc48adbf63fd17684bb87eb07f4814fbb482a3fbd817c1ccf4c5 (will check PREMIRROR=
S first)
Sstate summary: Wanted 2738 Local 0 Mirrors 0 Missed 2738 Current 0 (0% mat=
ch, 0% complete)###########################################################=
####################################                     | ETA:  0:00:00
WARNING: Stage weights: [10, 28, 2, 2, 1, 1, 1, 2, 3, 1, 1, 1, 1, 122, 7, 6=
, 4, 2, 2, 3, 1, 37, 2, 1, 1, 1, 96]
WARNING: Stage times:
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:828: 10
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:925: 28
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1007: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1054: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1095: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1103: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1120: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1127: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1227: 3
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1228: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1241: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1258: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1271: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1574: 12=
2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1579: 7
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1588: 6
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2930: 4
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2941: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2955: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2984: 3
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3009: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3021: 37
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3052: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3054: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3072: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3080: 1
  Up to finish: 96
Initialising tasks: 100% |#################################################=
###########################################################################=
#########################################################| Time: 0:00:03
NOTE: Executing Tasks
```

Can somebody help and say more info about what does it mean that `runqueue.=
py:3021` is much faster executed or reached in Ubuntu 20.04 then in 22.04?

https://github.com/yoctoproject/poky/blame/scarthgap/bitbake/lib/bb/runqueu=
e.py#L3021

Before line 3021 `runqueue.py` code is really mature, there were no any cha=
nge, except this in 2 years ago:

https://github.com/yoctoproject/poky/commit/b6e49784eac40a13b894839d17e89ef=
69a777a5d

Can it cause any speed issue in the complex while and for loop to seeking "=
unskippable" tasks?

--TeejHHrasQZJdvcZ22kD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p>I started to look for some info about where could happen this slowdown e=
ffect in the bitbake lib.</p>

<p>In <code>self.rqdata.init_progress_reporter =3D bb.progress.MultiStagePr=
ocessProgressReporter( ...</code> i enabled the <code>debug=3DTrue</code> a=
rg/flag for getting some info about the elapsed time of the &quot;Initialis=
ing tasks&quot; and i compared it in Ubuntu 22.04 and Ubuntu 20.04.</p>

<p><a href=3D"https://github.com/yoctoproject/poky/blob/scarthgap/bitbake/l=
ib/bb/runqueue.py#L1565" target=3D"_blank">https://github.com/yoctoproject/=
poky/blob/scarthgap/bitbake/lib/bb/runqueue.py#L1565</a></p>

<p>Result is the following, i used my same ZynqMP Yocto project which relea=
sed from scarthgap.</p>

<p>Ubuntu 22.04 LTS:</p>
<pre class=3D"prettyprint"><code class=3D"language-unknown">NOTE: Fetching =
uninative binary shim http://downloads.yoctoproject.org/releases/uninative/=
4.6/x86_64-nativesdk-libc-4.6.tar.xz;sha256sum=3D6bf00154c5a7bc48adbf63fd17=
684bb87eb07f4814fbb482a3fbd817c1ccf4c5 (will check PREMIRRORS first)
Sstate summary: Wanted 2738 Local 0 Mirrors 0 Missed 2738 Current 0 (0% mat=
ch, 0% complete)###########################################################=
#####################################                     | ETA:  0:00:20
WARNING: Stage weights: [15, 16, 1, 4, 3, 4, 3, 4, 3, 3, 4, 3, 3, 221, 4, 6=
, 5, 3, 3, 5, 3, 17331, 4, 2, 4, 3, 82]
WARNING: Stage times:
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:828: 15
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:925: 16
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1007: 1
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1054: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1095: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1103: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1120: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1127: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1227: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1228: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1241: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1258: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1271: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1574: 221
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1579: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1588: 6
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2930: 5
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2941: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2955: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2984: 5
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3009: 3
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3021: 17331
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3052: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3054: 2
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3072: 4
  Up to /ssd/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3080: 3
  Up to finish: 82
Initialising tasks: 100% |#################################################=
###########################################################################=
#########################################################| Time: 0:02:57
NOTE: Executing Tasks
</code></pre>
<p>Ubuntu 20.04 LTS:</p>
<pre class=3D"prettyprint"><code class=3D"language-unknown">NOTE: Fetching =
uninative binary shim http://downloads.yoctoproject.org/releases/uninative/=
4.6/x86_64-nativesdk-libc-4.6.tar.xz;sha256sum=3D6bf00154c5a7bc48adbf63fd17=
684bb87eb07f4814fbb482a3fbd817c1ccf4c5 (will check PREMIRRORS first)
Sstate summary: Wanted 2738 Local 0 Mirrors 0 Missed 2738 Current 0 (0% mat=
ch, 0% complete)###########################################################=
####################################                     | ETA:  0:00:00
WARNING: Stage weights: [10, 28, 2, 2, 1, 1, 1, 2, 3, 1, 1, 1, 1, 122, 7, 6=
, 4, 2, 2, 3, 1, 37, 2, 1, 1, 1, 96]
WARNING: Stage times:
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:828: 10
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:925: 28
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1007: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1054: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1095: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1103: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1120: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1127: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1227: 3
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1228: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1241: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1258: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1271: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1574: 12=
2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1579: 7
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:1588: 6
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2930: 4
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2941: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2955: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:2984: 3
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3009: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3021: 37
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3052: 2
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3054: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3072: 1
  Up to /Xilinx-Yocto/Zynq/sources/poky/bitbake/lib/bb/runqueue.py:3080: 1
  Up to finish: 96
Initialising tasks: 100% |#################################################=
###########################################################################=
#########################################################| Time: 0:00:03
NOTE: Executing Tasks
</code></pre>
<p>Can somebody help and say more info about what does it mean that <code>r=
unqueue.py:3021</code> is much faster executed or reached in Ubuntu 20.04 t=
hen in 22.04?</p>

<p><a href=3D"https://github.com/yoctoproject/poky/blame/scarthgap/bitbake/=
lib/bb/runqueue.py#L3021" target=3D"_blank">https://github.com/yoctoproject=
/poky/blame/scarthgap/bitbake/lib/bb/runqueue.py#L3021</a></p>

<p>Before line 3021 <code>runqueue.py</code> code is really mature, there w=
ere no any change, except this in 2 years ago:</p>

<p><a href=3D"https://github.com/yoctoproject/poky/commit/b6e49784eac40a13b=
894839d17e89ef69a777a5d" target=3D"_blank">https://github.com/yoctoproject/=
poky/commit/b6e49784eac40a13b894839d17e89ef69a777a5d</a></p>

<p>Can it cause any speed issue in the complex while and for loop to seekin=
g &quot;unskippable&quot; tasks?</p>

--TeejHHrasQZJdvcZ22kD--

