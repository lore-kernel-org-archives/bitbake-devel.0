Return-Path: <ross.burton@intel.com>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
	[209.85.216.173])
	by mail.openembedded.org (Postfix) with ESMTP id 1F85E6AC12
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 19:18:01 +0000 (UTC)
Received: by qcmi9 with SMTP id i9so8647558qcm.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 12:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=p2sQnlNugJypqY+LGSDS+6D77fLP/EjtYkRkcn7Z0jo=;
	b=EyEOXYY8Y373nEpvJ0ZsO+hlDm6q0i8EVxL6uivg22/zE4dS299a0BHkiRgX8Nv2XG
	ATBHLBSvH5v1RSSOHlvi7BW056cG2q/r/lI6ys7rIkxfkLldZOsP2UadgZVbuhB+vZ8z
	T7nTQBaaDZj7YO6CAiCuR2ehZ2FTfcbts/ZkOi7DpQwDxJh5Oo7Lzm/h1x420vaNE7ee
	mXDdV+UNC7jeRySufuCPVNQyyw4BJ4aBl7ypjEA6eIeP2SPwJPqNd2MVhCUNDweXeHJn
	qnlJVekPHNoYbCkgsOzzVenC7+B+xtW6vFmyhyqOvK+vI2ZJTjtYK6cpf+bVsEjVhG2P
	Ay/A==
X-Gm-Message-State: ALoCoQlOBGSvhVGrIEkfJ/Mpi2Nh5vOuDvSmgjKs8p2EMAPViCg3WuaqdRYbvA8GV+6bk64WVmWO
X-Received: by 10.140.89.104 with SMTP id u95mr26418976qgd.15.1433359082390;
	Wed, 03 Jun 2015 12:18:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Wed, 3 Jun 2015 12:17:41 -0700 (PDT)
In-Reply-To: <CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 3 Jun 2015 20:17:41 +0100
Message-ID: <CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
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
X-List-Received-Date: Wed, 03 Jun 2015 19:18:02 -0000
Content-Type: multipart/alternative; boundary=001a11c135f6f11f380517a1ea9e

--001a11c135f6f11f380517a1ea9e
Content-Type: text/plain; charset=UTF-8

On 3 June 2015 at 20:07, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> WARNING: QA Issue: gst-plugin-linux-user: Files/directories were installed
> but not shipped
>   /lib/gstreamer-0.10
>   /lib/gstreamer-0.10/libgst................
>
> so I have added these lines to bb file:
>
> FILES_${PN} += "${libdir}/gstreamer-0.10/"
> FILES_${PN}-dbg += "${libdir}/gstreamer-0.10/.debug"
> FILES_${PN}-dev += "${libdir}/gstreamer-0.10/"
>
> Now library is not going to rootfs at all and no Warning is there. Earlier
> it was installing to "/lib" in rootfs. I want the lib to install to
> "/usr/lib/gstreamer-0.10" in rootfs. Please provide your suggestions.
>

Remove FILES_PN-dev, there's nothing in that directory that makes sense in
the context of development and as PN-dev is packaged before PN all your
files are in that package.

Ross

--001a11c135f6f11f380517a1ea9e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 3 June 2015 at 20:07, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div><span style=
=3D"font-size:12.8000001907349px">WARNING: QA Issue: gst-plugin-linux-user:=
 Files/directories were installed but not shipped</span></div><div><span st=
yle=3D"font-size:12.8000001907349px">=C2=A0 /lib/gstreamer-0.10</span></div=
><div><span style=3D"font-size:12.8000001907349px">=C2=A0 /lib/gstreamer-0.=
10/libgst................</span></div></div><div><span style=3D"font-size:1=
2.8000001907349px"><br></span></div><div><span style=3D"font-size:12.800000=
1907349px">so I have added these lines to bb file:</span></div><div><span s=
tyle=3D"font-size:12.8000001907349px"><br></span></div><div><span class=3D"=
"><div>FILES_${PN} +=3D &quot;${libdir}/gstreamer-0.10/&quot;</div><div>FIL=
ES_${PN}-dbg +=3D &quot;${libdir}/gstreamer-0.10/.debug&quot;</div></span><=
div>FILES_${PN}-dev +=3D &quot;${libdir}/gstreamer-0.10/&quot;</div><div><b=
r></div><div>Now library is not going to rootfs at all and no Warning is th=
ere. Earlier it was installing to &quot;/lib&quot; in rootfs. I want the li=
b to install to &quot;/usr/lib/gstreamer-0.10&quot; in rootfs. Please provi=
de your suggestions.</div></div></blockquote></div><br></div><div class=3D"=
gmail_extra">Remove FILES_PN-dev, there&#39;s nothing in that directory tha=
t makes sense in the context of development and as PN-dev is packaged befor=
e PN all your files are in that package.</div><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">Ross</div></div>

--001a11c135f6f11f380517a1ea9e--
