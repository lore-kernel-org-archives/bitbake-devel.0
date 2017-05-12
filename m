Return-Path: <ahubchak@yukon.cv.ua>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id A3D28600B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:22:29 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id d127so16748679wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yukon-cv-ua.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to;
	bh=pxac5SHjbeRpc3tqPHdbA6TtKnaudCLcy+/0LZYQu3g=;
	b=bXsM+OACJjVpj+31bwmjb3WjisStPPbaHu06FTgz1CiijTuAvaK0+YG/fy/rpzjVvG
	XgbenjPdbuEfVFa5qQhnZ5qNgEDDgNp/w86As7R/eluvDNWf0ukczyDYncilprC3ziaz
	P23AgJhHVNwRpDiMZfke1JfTd0W6L7DLbFwPjFDW9w5oVOAVgSNDM0s1u/FwY8mCFotB
	7Bd5HedwSs6Qx1+AAKhdU6HdTGYQkCeKTt4GE/kljC+65oZVGLdW2oBpUw2OGqCOQkTD
	iU1Rezo6DxaH53dcUwm5SgKIC7mDK5PjItZVVXZIh7ykw2LIh5+pQyUw3geh/Vs5pAIQ
	lYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=pxac5SHjbeRpc3tqPHdbA6TtKnaudCLcy+/0LZYQu3g=;
	b=O8y7fHVmC4GF5MslXDpYhXV+4tnqa9A32ako9nTJFMYhdEFz2DnbLQEJ2lK0TPOwyC
	7DqUfmtrLAvP2w/nmDWoxOSnRIwa7BZab3L06wLoDQsLlyyatz0sj6JiYSAxSFJ0eLvb
	7flWr8EH27LF62NJy9ZpvoJve5qdd++XkFssPBwCvV2PGrlKnyDg0DayWYCGbrA8ggjB
	mO3cHHb1moW8h7MO2bVPn4FzXsPfSFZt36utsfU7aEyB6BKdyC7TEqQ2CvkCaygZIM3L
	aNiaeT84ne99CiMd4CSlOwyzTHE3dDNBRP5RCjp2HVWBd6LvPJFacuTIMluCvW7nV6Sd
	W8/w==
X-Gm-Message-State: AODbwcAD+HRJv/69gc7pi65Ruy13G+S5GrHQzzlCtf2mqAJTe2SS88+3
	9aLR93qhUd6SxD0uWL03ZhaRQEkNhQ==
X-Received: by 10.28.30.215 with SMTP id e206mr1973807wme.142.1494598949808;
	Fri, 12 May 2017 07:22:29 -0700 (PDT)
MIME-Version: 1.0
From: Andriy Hubchak <ahubchak@yukon.cv.ua>
Message-ID: <CAHaLjd2x1+F=t=YihqoAr3FVd99h7QVyA9w5ZMTeY5ougYavPg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sat, 10 Jun 2017 07:41:56 +0000
Subject: Problems with bitbake
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
Date: Fri, 12 May 2017 14:22:35 -0000
X-Original-Date: Fri, 12 May 2017 14:22:19 +0000
X-List-Received-Date: Fri, 12 May 2017 14:22:35 -0000
Content-Type: multipart/alternative; boundary="001a114b29d67c5743054f546fde"

--001a114b29d67c5743054f546fde
Content-Type: text/plain; charset="UTF-8"

Hello,

I am really new to OpenEmbedded and bitbake and have some problems with it.
When I use"bitbake -c menuconfig virtual/kernel " for some reason my image
is not recompiling.Could maybe someone help with this?
I just need to set Append_device_Tree to the kernel and compile dts files
and append it to the kernel but it does not seem to work in my case.

Kind Regards,

-- 
Andrew Hubchak
Embedded Software Engineer / Embedded Team Lead

Yukon Software LTD
Chernivtsi, Ukraine
Tel: +38-(095)-879-57-21  <+38-(095)-879-57-21>
URL: www.yukon.cv.ua
Mail to: ahubchak@yukon.cv.ua

--001a114b29d67c5743054f546fde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"inbox-inbox-linestyle1 inbox-inbox-colourlin=
e" style=3D"font-family:consolas,&quot;lucida console&quot;,monospace;paddi=
ng-left:7px;word-wrap:break-word;font-size:12.8px">Hello,</div><div class=
=3D"inbox-inbox-linestyle1 inbox-inbox-colourline" style=3D"font-family:con=
solas,&quot;lucida console&quot;,monospace;padding-left:7px;word-wrap:break=
-word;font-size:12.8px"><br>I am really new to OpenEmbedded and bitbake=C2=
=A0<span style=3D"font-size:12.8px">and have some problems with </span>it.<=
/div><div class=3D"inbox-inbox-linestyle1 inbox-inbox-colourline" style=3D"=
font-family:consolas,&quot;lucida console&quot;,monospace;padding-left:7px;=
word-wrap:break-word;font-size:12.8px">When I use&quot;bitbake -c menuconfi=
g virtual/kernel &quot; for some reason my image is not recompiling.C<span =
style=3D"font-size:12.8px">ould maybe someone help with this?</span></div><=
div class=3D"inbox-inbox-linestyle1 inbox-inbox-colourline" style=3D"font-f=
amily:consolas,&quot;lucida console&quot;,monospace;padding-left:7px;word-w=
rap:break-word;font-size:12.8px">I just need to set Append_device_Tree to t=
he kernel=C2=A0<span style=3D"font-size:12.8px">and compile </span>dts<span=
 style=3D"font-size:12.8px"> files and </span>append<span style=3D"font-siz=
e:12.8px"> it to the kernel</span><span style=3D"font-size:12.8px">=C2=A0bu=
t it does not seem to work in my case.<br><br>Kind Regards,<br><br></span><=
/div></div><div dir=3D"ltr">-- <br></div><div data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div style=3D"color:rgb(117,117,117);font-family:san=
s-serif"><font color=3D"#888888">Andrew Hubchak<br>Embedded Software Engine=
er / Embedded Team Lead<br><br>Yukon Software LTD<br>Chernivtsi, Ukraine<br=
></font></div><div style=3D"color:rgb(117,117,117);font-family:sans-serif">=
<font color=3D"#888888">Tel:=C2=A0<a href=3D"mailto:+38-(095)-879-57-21" ta=
rget=3D"_blank">+38-(095)-879-57-21<span class=3D"inbox-inbox-inbox-inbox-i=
nbox-Apple-converted-space">=C2=A0</span></a><br></font></div><div style=3D=
"color:rgb(117,117,117);font-family:sans-serif"><font color=3D"#888888">URL=
:=C2=A0<a href=3D"http://www.yukon.cv.ua/" target=3D"_blank">www.yukon.cv.u=
a</a><br>Mail to:=C2=A0<a href=3D"mailto:ahubchak@yukon.cv.ua" target=3D"_b=
lank"><span style=3D"background-color:rgba(251,246,167,0.498039);outline:tr=
ansparent dashed 1px">ahubchak@yukon.cv.ua</span></a></font></div></div></d=
iv>

--001a114b29d67c5743054f546fde--
