Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id B1B896E831
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 16:49:50 +0000 (UTC)
Received: by mail-ob0-f169.google.com with SMTP id wo20so6711956obc.14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 08:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-type;
	bh=XLdBhQUGR89epJvYyMUIFCFr0Dr3w+5V4vc3PbBXu1M=;
	b=JvnPT/72E/fwY+Et8BUlmW3YMgNARsNQwGW9paIUQBxzzhp17Xlb4NH3UPWvzYh4zF
	j7cQUhk+Ult2OJuRRqGFSlH6m1Ib3iTs3UKqgLK8UKkCttHGLYPG8kC2Mp+nz7cBgghj
	nOc28YGbbwg8SzAzzJsVxx4ByjveWuX8GQ1hDN2w9kVcHtKTsNUp03aj1jnQv2g6zyOt
	+pED8CeXNRkHpY7wTVcvjkZAAHvYptV5dA34SKYpwH1+l2Oy7DVkBoxbrE++V6vtpvAJ
	DOz/tDXnwy4NMo/bCoPuR0a5r2qfKl0+90suitiV73p+bOGMN68+clQorcchn972A/vd
	tRLQ==
X-Gm-Message-State: ALoCoQnZq8A/vSPk8XMq8fDfVWadIkIlD0D/Q9wdyjLpnfZaewrLMGf2yv9YJ3gpat2naV05rpgZ
X-Received: by 10.182.29.66 with SMTP id i2mr24406472obh.23.1390841391467;
	Mon, 27 Jan 2014 08:49:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.86.193 with HTTP; Mon, 27 Jan 2014 08:49:31 -0800 (PST)
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 27 Jan 2014 16:49:31 +0000
Message-ID: <CAJ2CSBtYQ6fMSboyGDzFPR8OpANbrxxUdMKYeHjx4dw1b=PwgQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: patchset for toaster, upstream from toaster/master
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
X-List-Received-Date: Mon, 27 Jan 2014 16:49:52 -0000
Content-Type: multipart/alternative; boundary=001a11c2bbdc13e26e04f0f67f75

--001a11c2bbdc13e26e04f0f67f75
Content-Type: text/plain; charset=UTF-8

Hello,

This is a pull-request for a patchset on toaster.

The patchset is a subset of poky-contrib/toaster/master, filtered for just
the bitbake relevant patches.

The patchset has passed multiple reviews by me and Paul Eggleton.

Can you please pull:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/submission27012014

Thank you,
Alex

-- 
Alex Damian
Yocto Project
SSG / OTC

--001a11c2bbdc13e26e04f0f67f75
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">

This is a pull-request for a patchset on toaster.=C2=A0</div><div class=3D"=
gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">The patchset is =
a subset of poky-contrib/toaster/master, filtered for just the bitbake rele=
vant patches.=C2=A0</div>

<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Th=
e patchset has passed multiple reviews by me and Paul Eggleton.</div><div c=
lass=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">

<br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-ser=
if">Can you please pull:</div><div class=3D"gmail_default" style=3D"font-fa=
mily:tahoma,sans-serif"><br></div><div class=3D"gmail_default"><font face=
=3D"tahoma, sans-serif"><a href=3D"http://git.yoctoproject.org/cgit/cgit.cg=
i/poky-contrib/log/?h=3Dadamian/submission27012014">http://git.yoctoproject=
.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dadamian/submission27012014</a></fo=
nt><br>

</div><div class=3D"gmail_default"><font face=3D"tahoma, sans-serif"><br></=
font></div><div class=3D"gmail_default"><font face=3D"tahoma, sans-serif">T=
hank you,</font></div><div class=3D"gmail_default"><font face=3D"tahoma, sa=
ns-serif">Alex</font></div>

<div><br></div>-- <br><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></d=
iv><div>SSG / OTC=C2=A0</div></div>
</div>

--001a11c2bbdc13e26e04f0f67f75--
