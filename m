Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
	[209.85.218.41])
	by mail.openembedded.org (Postfix) with ESMTP id AB37A70A7C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 12:17:13 +0000 (UTC)
Received: by oihd6 with SMTP id d6so5551156oih.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=8Nj7qWeuaRpPW8WN4DROj3g293WlqskPylLPxcoZuq4=;
	b=eEdAX3sDaSX75Ipf2orWyJ/F4Yza6N/XS4O6FbcOVC9+VJLg0q7Kx2MLymc08xzLL7
	qdLSZss+7qaLd4BTNe8+yN0kUKoiZURkup177YkOEw6Zu+ZTHAti9gVEhyAF8vpN7B9Q
	TFoD5bH7EcjLnFHBATVwNY/C2x92yDGBTDJBD+ESTpReUKV7RolXuZ8IKcqtgkRR8F/h
	I65xmQkv//kNQVrFpN4aWOn3hM6qgAfFcbJMxIPSqWY1PWqshAfQPfoMWPJVyap+C5dG
	epYQ/oJtVl/umTlMchcg+I1Um/klaLCfBM55StYi8s0+e879g+RkpyKj5QAB64GPbBbj
	wF6Q==
X-Received: by 10.182.220.199 with SMTP id py7mr4932701obc.60.1433333834449;
	Wed, 03 Jun 2015 05:17:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Wed, 3 Jun 2015 05:16:54 -0700 (PDT)
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Wed, 3 Jun 2015 17:46:54 +0530
Message-ID: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Library not getting installed to intended path
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
X-List-Received-Date: Wed, 03 Jun 2015 12:17:13 -0000
Content-Type: multipart/alternative; boundary=001a11c334aa0c0ae605179c0a78

--001a11c334aa0c0ae605179c0a78
Content-Type: text/plain; charset=UTF-8

Hi,

I am using yocto 1.6 and I have written a component and written bitbake
recipe file for this component. When rootfs is created my library is found
in "/lib" directory but I want it to be installed to
"/usr/lib/gstreamer-0.10" directory (which is already created by open
source gstreamer packages).

Following is the content of my bb file:

DESCRIPTION = "Plugin for support in GStreamer"

LICENSE = "BSD | LGPLv2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=7e2d09b34a9cdf39567252d39ce57cca"

DEPENDS = "virtual/libc \
           system-utils \
           gstreamer \
           gst-plugins-base \
          "

PR = "r0"

TD_PKG_REPO = "td-gst-plugin"

inherit autotools td_package td_paths

Makefile.am of my component is pretty basic. It does not modify any default
installations path.
I have tried different options like adding "FILES_${PN}" to bb file and
writing do_install() function but not able to install my lib to
"/usr/lib/gstreamer-0.10". Can somebody please help me with this issue?

Thanks,
Yogesh

--001a11c334aa0c0ae605179c0a78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am using yocto 1.6 and I have wri=
tten a component and written bitbake recipe file for this component. When r=
ootfs is created my library is found in &quot;/lib&quot; directory but I wa=
nt it to be installed to &quot;/usr/lib/gstreamer-0.10&quot; directory (whi=
ch is already created by open source gstreamer packages).</div><div><br></d=
iv><div>Following is the content of my bb file:</div><div><br></div><div><d=
iv>DESCRIPTION =3D &quot;Plugin for support in GStreamer&quot;</div><div><b=
r></div><div>LICENSE =3D &quot;BSD | LGPLv2.1&quot;</div><div>LIC_FILES_CHK=
SUM =3D &quot;file://COPYING;md5=3D7e2d09b34a9cdf39567252d39ce57cca&quot;</=
div><div><br></div><div>DEPENDS =3D &quot;virtual/libc \</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system-utils \<br></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gstreamer \</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0gst-plugins-base \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;<br></div><div><br></div><div>PR =3D &quot;r0&quot;</div><=
div><br></div><div>TD_PKG_REPO =3D &quot;td-gst-plugin&quot;</div><div><br>=
</div><div>inherit autotools td_package td_paths</div><div><br></div><div>M=
akefile.am of my component is pretty basic. It does not modify any default =
installations path. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div></div><div>I have tried different optio=
ns like adding &quot;<span style=3D"color:rgb(51,51,51);font-size:13px">FIL=
ES_${PN}&quot; to bb file and writing do_install() function</span>=C2=A0but=
 not able to install my lib to &quot;/usr/lib/gstreamer-0.10&quot;. Can som=
ebody please help me with this issue?</div><div><br></div><div>Thanks,</div=
><div>Yogesh</div></div>

--001a11c334aa0c0ae605179c0a78--
