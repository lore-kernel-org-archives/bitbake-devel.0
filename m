Return-Path: <bnousilal@gmail.com>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id 7DB6E7319C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 04:04:43 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id l65so100544797oib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 21:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=4qW6LM7utLVyASdShvavhj5axzYRRMCdiLkY57sP5R4=;
	b=F5fxUxyq2NqBDt6cEx7zr+bBUyqb5smAK2GHHolAY1rOFfUUWkEj2XYj3G0gbdgtb6
	Pt1Q/B9HfwR9V6hZjAdbvSxSFrmSch7FLdomKH20DwRFz0WAutRH5prL+hf6UutlwFv1
	uW9gpfkmq8ZZU0H90veDpqiPOUs36lUgAoGw82RXt7RlFt7jY+4NA12P1w4aQrdoRVWw
	sCHfYApyOYU2jBAqOi4Uyj0UV52ConM9OjTZ12z1Yp4/FbcdNq4VUe6hFXZPXeA+AgWC
	O1hQyXFBe9Go8VyZMuQOlsMidvB2h5z3owPBb2fJsXxnj9bhGDrd4yqVySLFCTuf1ADM
	W75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=4qW6LM7utLVyASdShvavhj5axzYRRMCdiLkY57sP5R4=;
	b=OQOozaWS0FV8VoJwys8sWw0y0osSdqlqA7COjUckYx4aLlxFu2dbEJlGVJDTpF3R9M
	aRzo108g2iEL6riikgTVeoKVevlws7tBWFlQllYr0G68t5BIM93ugr6RkBKHIgwl4cxp
	hUQ229mDx0TWGlHt9fD9+zfTlB/NEQUDfdPtvgMOQkM5rTt06ERUMPLR2GLtDhThxx/T
	hytcrTA/xcWtJP/Vet/Tw2Gjka5nLQIwfSKW3PMGCfnxv6hPLKa19HBOJwhDRlxDl3Rv
	/5xNw7c+3yvxtEimHPOuXOLVZVTTg36iLKEGqNMXXGwMKTvJCQsSY8GD5mPwsfrS020M
	WVmQ==
X-Gm-Message-State: ALyK8tLuzjJzMPDMhVycHyc9zG911TQDef70BF7o8Adwkz4I1UkVi+CnTEmsBg/ZtU3jaTsVxrfGf911409mSw==
MIME-Version: 1.0
X-Received: by 10.157.14.5 with SMTP id c5mr30167379otc.55.1469073883826; Wed,
	20 Jul 2016 21:04:43 -0700 (PDT)
Received: by 10.157.42.168 with HTTP; Wed, 20 Jul 2016 21:04:43 -0700 (PDT)
Received: by 10.157.42.168 with HTTP; Wed, 20 Jul 2016 21:04:43 -0700 (PDT)
In-Reply-To: <DB6PR0401MB2630808F7A718CC38A2291ADEE090@DB6PR0401MB2630.eurprd04.prod.outlook.com>
References: <CAJ5vXcR+QuZ3KTBgY5TFHfetTzLvvC6moYdDDa4fRV385tKwsA@mail.gmail.com>
	<DB6PR0401MB2630808F7A718CC38A2291ADEE090@DB6PR0401MB2630.eurprd04.prod.outlook.com>
Date: Thu, 21 Jul 2016 09:34:43 +0530
Message-ID: <CAJ5vXcRVydhANmw69aLDuZBCkWy+BnysEKDhD5+RhjoY6jY4eQ@mail.gmail.com>
From: nousi <bnousilal@gmail.com>
To: Zhenhua Luo <zhenhua.luo@nxp.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: source modification and re-build
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
X-List-Received-Date: Thu, 21 Jul 2016 04:04:44 -0000
Content-Type: multipart/alternative; boundary=001a11414dcefe8e8505381d6a79

--001a11414dcefe8e8505381d6a79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you.

On Jul 21, 2016 9:30 AM, "Zhenhua Luo" <zhenhua.luo@nxp.com> wrote:

> Hi Nousilal,
>
>
>
> =E2=80=9Cbitbake -c menuconfig nousi-linux=E2=80=9D is used for changing =
the kernel
> configs instead of modifying source code, you can run =E2=80=9Cbitbake -C=
 compile
> -f nousi-linux =E2=80=9D to force rebuild with updated kernel configs.
>
>
>
> To modify the source code, you can do it in
> tmp/work-shared/<machine>/kernel-source/, then run =E2=80=9Cbitbake -C co=
mpile =E2=80=93f
> nousi-linux=E2=80=9D to rebuild new kernel image.
>
>
>
>
>
> Best Regards,
>
>
>
> Zhenhua
>
>
>
> *From:* bitbake-devel-bounces@lists.openembedded.org [mailto:
> bitbake-devel-bounces@lists.openembedded.org] *On Behalf Of *nousi
> *Sent:* Wednesday, July 20, 2016 2:18 PM
> *To:* bitbake-devel@lists.openembedded.org
> *Subject:* [bitbake-devel] source modification and re-build
>
>
>
> Hi All,
>
>
>
> Am new to yocto environment, please let me know the process to change
> kernel source using "bitbake nousi-linux -c menuconfig".
>
>
>
> I can able to make changes using "bitbake nousi-linux -c menuconfig" this
> command but my changes were not included in the new re-built image.
>
> Am using the development linux source code.
>
> Any help is appreciated.
>
>
>
> --
>
>
> *Thanks & Regards, B.Nousilal,*
>

--001a11414dcefe8e8505381d6a79
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thank you.</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Jul 21, 2016 9=
:30 AM, &quot;Zhenhua Luo&quot; &lt;<a href=3D"mailto:zhenhua.luo@nxp.com">=
zhenhua.luo@nxp.com</a>&gt; wrote:<br type=3D"attribution"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Hi Nousilal,
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">=E2=80=9Cbitbake -c menuconfig nousi-=
linux=E2=80=9D is used for changing the kernel configs instead of modifying=
 source code, you can run =E2=80=9Cbitbake -C compile -f nousi-linux =E2=80=
=9D
 to force rebuild with updated kernel configs. <u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">To modify the source code, you can do=
 it in tmp/work-shared/&lt;machine&gt;/kernel-source/, then run =E2=80=9Cbi=
tbake -C compile =E2=80=93f nousi-linux=E2=80=9D to rebuild new kernel imag=
e.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Best Regards,<u></u><u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Zhenhua<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> <a href=3D"mailto:bitbake-deve=
l-bounces@lists.openembedded.org" target=3D"_blank">bitbake-devel-bounces@l=
ists.openembedded.org</a> [mailto:<a href=3D"mailto:bitbake-devel-bounces@l=
ists.openembedded.org" target=3D"_blank">bitbake-devel-bounces@lists.openem=
bedded.org</a>]
<b>On Behalf Of </b>nousi<br>
<b>Sent:</b> Wednesday, July 20, 2016 2:18 PM<br>
<b>To:</b> <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
<b>Subject:</b> [bitbake-devel] source modification and re-build<u></u><u><=
/u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Hi All,<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Am new to=C2=A0yocto environment, please let me know=
 the process to change kernel source using &quot;bitbake nousi-linux -c men=
uconfig&quot;.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I can able to make changes using=C2=A0&quot;bitbake=
=C2=A0nousi-linux=C2=A0-c menuconfig&quot; this command but my changes were=
 not included in the new re-built image.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Am using the=C2=A0development linux source code.<br =
clear=3D"all">
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">Any help is appreciated.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal">-- <u></u><u></u></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><i><span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#3333ff">Thank=
s &amp; Regards,<br>
B.Nousilal,</span></i><u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--001a11414dcefe8e8505381d6a79--
