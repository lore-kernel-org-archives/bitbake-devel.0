Return-Path: <bnousilal@gmail.com>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
	[209.85.218.45])
	by mail.openembedded.org (Postfix) with ESMTP id 6474A606A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 06:18:13 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id w18so57754868oiw.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 23:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=yRSN0pjx8f0SUTCatnERFoYR6uOwSlMAQBT1iL9wSXo=;
	b=juy5z3+JreJ4OrF+dxRKaQMtwlzmmzxlQvp8wEjRxARGZuvma4zWTPppv0F6DEhmD1
	p5Is48Le2JFcEEqA6FIPr3KQTPJEswjXmIddepeM17KrCxTTU7QjiGFF0zsMNj4/8oT1
	QxxwhaBx/LjFEz9b9BAp+jFtMeFfQK//uqTOMLq2zx3XVXcqmChS1EBkFPqQSDO+dW8t
	86PjykFnzI7+K6+2x5OtBNb0m5wL/A2rHZk6/CFKx8waUAJ3kKEkzyKVXyLHtRrGhViR
	Mw+S0HXlbby0M1oVuW6T2pRM8/+19xucuKtXgHCUwCdtXfH0ccOOjYZlDmOGgl+rhjqe
	r+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=yRSN0pjx8f0SUTCatnERFoYR6uOwSlMAQBT1iL9wSXo=;
	b=W44P7sywQfdHFX34jf3GT1DL1qNgwv0h+JhnmXraiLguOTWsGc5/FkaB9oqhCXbc5p
	xAYe4zn570Asp0pqpGqGbPGW+ErF3ncNF+LQv+9f4MNGI17KW+qCxbxwn3zqI1nZkZyK
	BpedIRSXDITUk/7KDON7OpVccc8AJLNDFphBJRuUPBbB89pxvhevwbUrZdgnqScE8D13
	tyawAO9iPRv0/5rO3rsVZP6XaWLpNks2FQD4RAaUlEm8RTsedhx94SkVz0OSZ9Uo7E/a
	NC2BLTekp1wZJJWLf2BtVoJeAyNh2QXeBMmREHoNGe1ZCDzMjeWGuxoIXwhQF/sB0rxl
	4VXA==
X-Gm-Message-State: ALyK8tI5DxHNJfj89UNs+TL8O9LT4rzZw4hA2HhCnqAln+XGSDRQmdE/tV205pRhyaMgjRi7NzV53luPb6QXvA==
X-Received: by 10.202.192.214 with SMTP id q205mr21611387oif.176.1468995493490;
	Tue, 19 Jul 2016 23:18:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.42.168 with HTTP; Tue, 19 Jul 2016 23:18:13 -0700 (PDT)
From: nousi <bnousilal@gmail.com>
Date: Wed, 20 Jul 2016 11:48:13 +0530
Message-ID: <CAJ5vXcR+QuZ3KTBgY5TFHfetTzLvvC6moYdDDa4fRV385tKwsA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Wed, 20 Jul 2016 09:40:42 +0000
Subject: source modification and re-build
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
X-List-Received-Date: Wed, 20 Jul 2016 06:18:19 -0000
Content-Type: multipart/alternative; boundary=001a113ddff290f67f05380b2a82

--001a113ddff290f67f05380b2a82
Content-Type: text/plain; charset=UTF-8

Hi All,

Am new to yocto environment, please let me know the process to change
kernel source using "bitbake nousi-linux -c menuconfig".

I can able to make changes using "bitbake nousi-linux -c menuconfig" this
command but my changes were not included in the new re-built image.
Am using the development linux source code.
Any help is appreciated.

-- 


*Thanks & Regards,B.Nousilal,*

--001a113ddff290f67f05380b2a82
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>Am new to=C2=A0yocto environmen=
t, please let me know the process to change kernel source using &quot;bitba=
ke nousi-linux -c menuconfig&quot;.</div><div><br></div><div>I can able to =
make changes using=C2=A0&quot;bitbake=C2=A0nousi-linux=C2=A0-c menuconfig&q=
uot; this command but my changes were not included in the new re-built imag=
e.</div><div>Am using the=C2=A0development linux source code.<br clear=3D"a=
ll"><div>Any help is appreciated.</div><div><br></div>-- <br><div class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature"><i style=3D"color:rgb(5=
1,51,255)"><font style=3D"font-family:arial,helvetica,sans-serif" size=3D"2=
">Thanks &amp; Regards,<br>B.Nousilal,<br></font></i><br></div>
</div></div>

--001a113ddff290f67f05380b2a82--
