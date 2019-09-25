Return-Path: <grzegorz.heldt@gmail.com>
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
	[209.85.217.53])
	by mail.openembedded.org (Postfix) with ESMTP id C9EC06C216
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Sep 2019 20:38:23 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id p13so60111vsr.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Sep 2019 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=/lLaF9lviHovhoe7YopCISB09j/qhggGh3c+UwWFxg8=;
	b=ZWaubP8CLTZ5FjU3FKAZZ906EIuULfp6ra2Yqcy6AWsS2/I3a8aeObUsUhci3lyiQ2
	RTnc20+meHX4roR6LF1zEqLZSIO0HQtvBvzcbzoRFkMl8G1a8PaA+e1HHDWX3BaBioQ7
	CMO8ALyxXJjtRmXlB51PiWvSbaph0gdwhzrocYWiIlZybbsx4uXKSsbg7P3aj9Tvy+vm
	+iKSfGj1vOH15t//P+4GgZNl5SAHsoGHh9i3rNbwiB4t+xGJkp/OtJ6ODW9CvyxUi4kR
	m/pE6AwB/V9ly8HfPQ/U2y7UgakUmi9bUelfTtWGReiFdmF2AUXdE0S8PuP5cXjaA/OV
	EGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=/lLaF9lviHovhoe7YopCISB09j/qhggGh3c+UwWFxg8=;
	b=bbAfJQS9Sk9pPckJMb5/FLxK25nMY92bSzUakLbY4O+xHE+ozz8kT2kYZlckssYs2h
	QcnmJ7QZ7bhtEG1eAlloVwS7LyM8DmmP/6p4Rsz98IaorAGbkSQun5pYmBgth32zmrrI
	OZs+PWwF8v7T1dW3A779b9i3tlcZkMnGlUlm8xCoxTYsykV90MxeF+n9lGWtpipzO7EU
	Qz1/B9yeWmb/wq9EZALcdJZ6DmiKkBkuSRYNYK5YLic0KaM5NgxraSQaCgKEyKjUmHqK
	8fgB4UXboC5C9ZTcKqJ1p59RbuElepE+DGXnChdybTUB9geRWjwTbw5ZKGbc0RQIQoMP
	Y84w==
X-Gm-Message-State: APjAAAXsL+hj94zRZ/jAAYGwutgJ17pk96Iv8Cuoz4J/7UrS2JD4SLco
	IhTZNaijWRwhZYWqvACBWQhg3gxB1KMOJ4J9UrRTbe9OetI=
X-Google-Smtp-Source: APXvYqy6DZsElr/z05u7BF2ULgrsABtLsTBG0VmVO2CzT6587BnQLxh5gZogeIx/ghlZr4Jwn2TEyX4AxxqUtbGIYDc=
X-Received: by 2002:a67:6404:: with SMTP id y4mr6293463vsb.120.1569443904297; 
	Wed, 25 Sep 2019 13:38:24 -0700 (PDT)
MIME-Version: 1.0
From: Grzegorz Heldt <grzegorz.heldt@gmail.com>
Date: Wed, 25 Sep 2019 22:38:10 +0200
Message-ID: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 26 Sep 2019 20:40:06 +0000
Subject: bitbake-layers add-layer issue
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
X-List-Received-Date: Wed, 25 Sep 2019 20:38:24 -0000
Content-Type: multipart/alternative; boundary="000000000000691d84059366a2b9"

--000000000000691d84059366a2b9
Content-Type: text/plain; charset="UTF-8"

Hello.

To setup my projects im usually using bash scripts like that performs
following steps:

-------------------------------
wiesniak@desk:~/projects/yocto-rasp/poky/build/conf$ cat ../../../setup
#!/bin/bash

BRANCH=warrior
git clone git://git.yoctoproject.org/meta-raspberrypi -b $BRANCH
git clone git://git.yoctoproject.org/poky -b $BRANCH
git clone git://git.openembedded.org/meta-openembedded -b $BRANCH

cd poky
. oe-init-build-env
bitbake-layers add-layer ../../meta-raspberrypi/
bitbake-layers add-layer ../../meta-openembedded/meta-python/
bitbake-layers add-layer ../../meta-openembedded/meta-oe/
bitbake-layers add-layer ../../meta-openembedded/meta-multimedia/
bitbake-layers add-layer ../../meta-openembedded/meta-networking/

echo INHERIT += \"rm_work\" >> conf/local.conf
echo DL_DIR = \"/home/yocto-downloads\" >> conf/local.conf

-----------------------------

The problem is that at one of steps that invokes bitbake-layers add-layer,
issue is reported and script fails.

Im not sure whether this issue is related to layers, or bitbake-layers
command.

However, if I add those layers manually to build/conf/bblayers.conf :
--------------------------
wiesniak@desk:~/projects/yocto-rasp/poky/build/conf$ cat bblayers.conf
# POKY_BBLAYERS_CONF_VERSION is increased each time build/conf/bblayers.conf
# changes incompatibly
POKY_BBLAYERS_CONF_VERSION = "2"

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
  /home/wiesniak/projects/yocto-rasp/poky/meta \
  /home/wiesniak/projects/yocto-rasp/poky/meta-poky \
  /home/wiesniak/projects/yocto-rasp/poky/meta-yocto-bsp \
  /home/wiesniak/projects/yocto-rasp/meta-raspberrypi \
  /home/wiesniak/projects/yocto-rasp/meta-openembedded/meta-python \
  /home/wiesniak/projects/yocto-rasp/meta-openembedded/meta-oe/ \
  /home/wiesniak/projects/yocto-rasp/meta-openembedded/meta-multimedia/ \
  /home/wiesniak/projects/yocto-rasp/meta-openembedded/meta-networking/ \
"
------------------------------

Then the build can finish sucessfully, so I believe this problem is related
to bitbake-layers command.

Can someone give me some advice ?
I found using bitbake-layers command much more convenient that manually
adding layers to bblayers.conf.

Best Regards
Greg.

--000000000000691d84059366a2b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello.<div><br></div><div>To setup my projects im usually =
using bash scripts like that performs following steps:</div><div><br></div>=
<div>-------------------------------</div><div>wiesniak@desk:~/projects/yoc=
to-rasp/poky/build/conf$ cat ../../../setup <br>#!/bin/bash<br><br>BRANCH=
=3Dwarrior<br>git clone git://<a href=3D"http://git.yoctoproject.org/meta-r=
aspberrypi">git.yoctoproject.org/meta-raspberrypi</a> -b $BRANCH<br>git clo=
ne git://<a href=3D"http://git.yoctoproject.org/poky">git.yoctoproject.org/=
poky</a> -b $BRANCH<br>git clone git://<a href=3D"http://git.openembedded.o=
rg/meta-openembedded">git.openembedded.org/meta-openembedded</a> -b $BRANCH=
<br><br>cd poky<br>. oe-init-build-env<br>bitbake-layers add-layer ../../me=
ta-raspberrypi/<br>bitbake-layers add-layer ../../meta-openembedded/meta-py=
thon/<br>bitbake-layers add-layer ../../meta-openembedded/meta-oe/<br>bitba=
ke-layers add-layer ../../meta-openembedded/meta-multimedia/<br>bitbake-lay=
ers add-layer ../../meta-openembedded/meta-networking/<br><br></div><div>ec=
ho INHERIT +=3D \&quot;rm_work\&quot; &gt;&gt; conf/local.conf<br>echo DL_D=
IR =3D \&quot;/home/yocto-downloads\&quot; &gt;&gt; conf/local.conf<br><br>=
<div>-----------------------------</div><div><br></div><div>The problem is =
that at one of steps that invokes bitbake-layers add-layer, issue is report=
ed and script fails.</div><div><br></div><div>Im not sure whether this issu=
e is related to layers, or bitbake-layers command.</div><div><br></div><div=
>However, if I add those layers manually to build/conf/bblayers.conf :</div=
><div>--------------------------</div><div>wiesniak@desk:~/projects/yocto-r=
asp/poky/build/conf$ cat bblayers.conf <br># POKY_BBLAYERS_CONF_VERSION is =
increased each time build/conf/bblayers.conf<br># changes incompatibly<br>P=
OKY_BBLAYERS_CONF_VERSION =3D &quot;2&quot;<br><br>BBPATH =3D &quot;${TOPDI=
R}&quot;<br>BBFILES ?=3D &quot;&quot;<br><br>BBLAYERS ?=3D &quot; \<br>=C2=
=A0 /home/wiesniak/projects/yocto-rasp/poky/meta \<br>=C2=A0 /home/wiesniak=
/projects/yocto-rasp/poky/meta-poky \<br>=C2=A0 /home/wiesniak/projects/yoc=
to-rasp/poky/meta-yocto-bsp \<br>=C2=A0 /home/wiesniak/projects/yocto-rasp/=
meta-raspberrypi \<br>=C2=A0 /home/wiesniak/projects/yocto-rasp/meta-openem=
bedded/meta-python \<br>=C2=A0 /home/wiesniak/projects/yocto-rasp/meta-open=
embedded/meta-oe/ \<br>=C2=A0 /home/wiesniak/projects/yocto-rasp/meta-opene=
mbedded/meta-multimedia/ \<br>=C2=A0 /home/wiesniak/projects/yocto-rasp/met=
a-openembedded/meta-networking/ \<br>&quot;<br>----------------------------=
--</div><div><br></div><div>Then the build can finish sucessfully, so I bel=
ieve this problem is related to bitbake-layers command.</div><div><br></div=
><div>Can someone give me some advice ?</div><div>I found using bitbake-lay=
ers command much more convenient that manually adding layers to bblayers.co=
nf.</div><div><br></div><div>Best Regards</div><div>Greg.</div><div><br></d=
iv><br></div></div>

--000000000000691d84059366a2b9--
