Return-Path: <davis.roman84@gmail.com>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id DAC2871A7E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Oct 2016 21:50:58 +0000 (UTC)
Received: by mail-io0-f175.google.com with SMTP id j37so12526355ioo.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Oct 2016 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=MTU4AgGXcipI1unIh9YQXsvwDECDerW7NfqabhsMZSk=;
	b=S0xk3PZrbdDLn+X8BYLMtiiRQ87QkCOMYH3mwMD6HPJiHFDanDMf6QdK7xKVlZ8zko
	iptt7fJQbD0VRsUXY8i2DwJXOdJFkCMXD+IRCcfgDOdkXpf5BF1T3vgOArWv6Sfsf7UQ
	qg8O0OkNEsCAGdaJakfggHjOjaISgbNCpjt8wIBodbXWA0fRV3nV/OK6uNeetddEzwnu
	L7qqRfEj5vBJt7+dLmTGDdHbAyNs6aIM4KqzOmKZpoPuwuMpky7+PnfdXNUiDIlYCfDS
	xXEuwlivbVj7ywmuTEX87SokumlfyHAHMkA4NO7v4DopYV1BFxurp+fD+N6ZoA3mMvlI
	diTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=MTU4AgGXcipI1unIh9YQXsvwDECDerW7NfqabhsMZSk=;
	b=CU4rapHPkeOW7ZTkJR2SKYgzzcB4TwE6kBIz0BgRuuMDJRDvNNNdo7D2mywBMZzLGH
	Fg8f1Kod5U9YmVya0kR479foqvFTKUA1NbJz3vz2+SwN+lNqzAkfCGFIuJFaBRIR5bVt
	WpiXxRtQuKWCnjU+O6DK9AcEHq8P7hN6reIVL5v7Rw0iFjiXOQHPyd3R0C+P5rqBddP8
	jj50Wv2MAk7aPvIFAboaRoPvM8kwrYOcc/8DN2IcQOyMHjLb6y2afgnZsiDhNDbw+Pnn
	4o/t9fK1i3Zlds2e6YHGrdoV7ZiTbtyV1/6m12+CSsyPJpoFVAmkiHdVLStY+Hy8yRfc
	mhwA==
X-Gm-Message-State: AA6/9RlVubbRJ1hgV55s9Frgyzl39coKFkkdEuMqAvHELnlhgalM8uBZQDdYnLEXP9IXpRCHDOT4Nzkv82AVUg==
X-Received: by 10.107.25.11 with SMTP id 11mr3367505ioz.138.1476827459383;
	Tue, 18 Oct 2016 14:50:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.36 with HTTP; Tue, 18 Oct 2016 14:50:58 -0700 (PDT)
From: Davis Roman <davis.roman84@gmail.com>
Date: Tue, 18 Oct 2016 17:50:58 -0400
Message-ID: <CACfi_Z10fp9_iL9FX_jHSgES=N6CF+uBv2ouVSyb-ab9wtbLcQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 20 Oct 2016 09:23:21 +0000
Subject: Difference between inclusion and inheritance
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
X-List-Received-Date: Tue, 18 Oct 2016 21:51:01 -0000
Content-Type: multipart/alternative; boundary=001a114097aa1c7b86053f2ab077

--001a114097aa1c7b86053f2ab077
Content-Type: text/plain; charset=UTF-8

Hello Bitbake community,

I'm a bitbake newbie and so naturally I'm becoming familiar with the
bitbake documentation.

I came across something confusing ( well atleast for me ) regarding the
difference between optional/required Inclusion versus inheritance.

As far as optional/required inclusion is concerned, the documentation
states quite clearly that the main difference is that the former will not
issue an error message if the specified file is not found while the latter
will so there is no issue here.

My issue has to do with the 'inherit' command. Sounds to me like 'include'
and 'require' already do the trick so I'm curious to know what value does
'inherit' bring ?

Any clarification would be extremely appreciated.

Thank you,

Davis

--001a114097aa1c7b86053f2ab077
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"monospace, monospace">Hello Bitbake communit=
y,</font><div><font face=3D"monospace, monospace"><br></font></div><div><fo=
nt face=3D"monospace, monospace">I&#39;m a bitbake newbie and so naturally =
I&#39;m becoming familiar with the bitbake documentation.=C2=A0</font></div=
><div><font face=3D"monospace, monospace"><br></font></div><div><font face=
=3D"monospace, monospace">I came across something confusing ( well atleast =
for me ) regarding the difference between optional/required Inclusion versu=
s inheritance.</font></div><div><font face=3D"monospace, monospace"><br></f=
ont></div><div><font face=3D"monospace, monospace">As far as optional/requi=
red inclusion is concerned, the documentation states quite clearly that the=
 main difference is that the former will not issue an error message if the =
specified file is not found while the latter will so there is no issue here=
.</font></div><div><font face=3D"monospace, monospace"><br></font></div><di=
v><font face=3D"monospace, monospace">My issue has to do with the &#39;inhe=
rit&#39; command. Sounds to me like &#39;include&#39; and &#39;require&#39;=
 already do the trick so I&#39;m curious to know what value does &#39;inher=
it&#39; bring ?</font></div><div><font face=3D"monospace, monospace"><br></=
font></div><div><font face=3D"monospace, monospace">Any clarification would=
 be extremely appreciated.</font></div><div><font face=3D"monospace, monosp=
ace"><br></font></div><div><font face=3D"monospace, monospace">Thank you,</=
font></div><div><font face=3D"monospace, monospace"><br></font></div><div><=
font face=3D"monospace, monospace">Davis</font></div><div><br></div><div><b=
r></div></div>

--001a114097aa1c7b86053f2ab077--
