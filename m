Return-Path: <evadeflow@gmail.com>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
	[209.85.214.53])
	by mail.openembedded.org (Postfix) with ESMTP id DB03B73243
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Sep 2016 15:29:15 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id e124so109366720ith.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Sep 2016 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=nS46kRKuOsd/NzxoFvJX3myp2llnqIWedbg0BKLtMI0=;
	b=P7gYo34v0KjKCjeYsxSATFU9oHRBtWMfU7qwcER88O+9CUyskTqBmhoyfGT36Ya13x
	T6/2t2GuM+VYVfeG/V2G1LPMX0STT6QITgRIXpfWNnvh0gkGFAUnFJn2yXUj9bPY9MX7
	gbmo8FZQwtArOGdvc8MhpqhKu687MKHFBMWr2e67Uc2apKw5ie5Z5WpTNLOUOPzj3nqr
	lgGWJn3Oi23C00/g2rQtz86fvi8QiimT6+EFnPALKz7q2REgleqCT6TWGTxjoUmbhmVy
	uiI50XODJzUaQtSJ6wRS81tPa71I98vh9Djz6jQitMq2qcgaeIRSUDnZhv59uzQ+ZsA3
	oLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=nS46kRKuOsd/NzxoFvJX3myp2llnqIWedbg0BKLtMI0=;
	b=lG7yY+ErFIg7lch8IvfxAlnB0sBakHvI/vc2QalPQFQJeGuJIF7DwsXxE7GSYjXcfs
	h2LG6zLg+383CAtuTK925H0DVZ4JkWUdFB+paZA5CFNfazjRKQ1tWsjYSmPGkXQ/FIe9
	GlxQq1SlS1v/sbcOcfWOV6lR6dEt3VQwB+154TYUkccFdsJGYzocuuwY+qkra5yjz1bp
	yaCfN+mKw4Z1Xh3b2fek4SHZoz5SaSb2EBzJLbJFpacb2tUt4uP6JpMZlPv2ICBheB3k
	Vp0bAkAoXDfQZn8d/RmZpAPNDdAENstxOA2bZHUdjqIOsaNUaqqB/m+xlrjzoiBbPfDo
	bahw==
X-Gm-Message-State: AE9vXwO/hR9+fwnGzrgiusoHtCBmgmhSPPdp2UNtRm1Zrf6Kn40akQMKcsoZu5oaUMP+SiSnCllTs882xmuUwA==
X-Received: by 10.36.34.204 with SMTP id o195mr21154265ito.29.1472743755811;
	Thu, 01 Sep 2016 08:29:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.147.4 with HTTP; Thu, 1 Sep 2016 08:29:15 -0700 (PDT)
From: Evade Flow <evadeflow@gmail.com>
Date: Thu, 1 Sep 2016 11:29:15 -0400
Message-ID: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Conditionally inherit own-mirrors and set SOURCE_MIRROR_URL?
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
X-List-Received-Date: Thu, 01 Sep 2016 15:29:16 -0000
Content-Type: multipart/alternative; boundary=001a114057486911a8053b73e0ce

--001a114057486911a8053b73e0ce
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This might be an 'X-Y' problem, so I should explain what I'm trying to
achieve. We have a somewhat beefy build server with 32 cores that most of
my team likes to `ssh` into to do builds of our Yocto/OE-based BSP. But a
few of us build on different machines often enough that I recently spun up
a web server=E2=80=94on the 32-core build machine=E2=80=94to act as a 'pre-=
mirror' to
statically serve  our dependencies for remote builds. The web server is
serving the exact same folder that I've been pointing `SOURCE_MIRROR_URL`
at, as described at:
https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_sourc=
e_download_mirror_.3F

When I went to integrate support for the HTTP pre-mirror, I ran into the
following problem: if I assign `SOURCE_MIRROR_URL` and the specified folder
doesn't exist (as will be the case for remote builds), the build *fails*. I
had hoped that bitbake would 'fall through' to searching other pre-mirrors,
but that doesn't appear to be the case(?)

IIs there some way I can use a specific (and *invariant*) local source
mirror folder *only if it exists*, and use our internal HTTP pre-mirror
otherwise?

```
$ bitbake --version
BitBake Build Tool Core version 1.28.0
```

--001a114057486911a8053b73e0ce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>This might be an &#39;X-Y&#39; problem, so I sho=
uld explain what I&#39;m trying to achieve. We have a somewhat beefy build =
server with 32 cores that most of my team likes to `ssh` into to do builds =
of our Yocto/OE-based BSP. But a few of us build on different machines ofte=
n enough that I recently spun up a web server=E2=80=94on the 32-core build =
machine=E2=80=94to act as a &#39;pre-mirror&#39; to statically serve=C2=A0 =
our dependencies for remote builds. The web server is serving the exact sam=
e folder that I&#39;ve been pointing `SOURCE_MIRROR_URL` at, as described a=
t: <a href=3D"https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_creat=
e_my_own_source_download_mirror_.3F">https://wiki.yoctoproject.org/wiki/How=
_do_I#Q:_How_do_I_create_my_own_source_download_mirror_.3F</a><br><br></div=
>When I went to integrate support for the HTTP pre-mirror, I ran into the f=
ollowing problem: if I assign `SOURCE_MIRROR_URL` and the specified folder =
doesn&#39;t exist (as will be the case for remote builds), the build *fails=
*. I had hoped that bitbake would &#39;fall through&#39; to searching other=
 pre-mirrors, but that doesn&#39;t appear to be the case(?)<br><br></div>II=
s there some way I can use a specific (and *invariant*) local source mirror=
 folder *only if it exists*, and use our internal HTTP pre-mirror otherwise=
?<br><br>```<br>$ bitbake --version<br>BitBake Build Tool Core version 1.28=
.0<br>```<br><br></div>

--001a114057486911a8053b73e0ce--
