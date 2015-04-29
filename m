Return-Path: <katutxakurra@gmail.com>
Received: from mail-yh0-f42.google.com (mail-yh0-f42.google.com
	[209.85.213.42])
	by mail.openembedded.org (Postfix) with ESMTP id ECAD57382F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Apr 2015 06:24:39 +0000 (UTC)
Received: by yhw29 with SMTP id 29so3787756yhw.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=6asl3yDos+K1E2LNeFDkFmZI/NMOYzWRaWwgbx6Wcwo=;
	b=jjHet548izPYma0BaFosM0xhX7S4M0qAku6aoFc5VG96l0NaG/YqDzopDqRtRRQIZi
	4ZzYStT0l7mRKTkEd2m8kxi1BPsJCo+2Zv5RcbMaoLgLnTaexEXoSEZDuTMNLWALeVUV
	RZqPG233KL8kfi6BFdeaTLtwfPaVn/YqpHzSFLVnO/DZEADR+E5+sGJW6UnM6gD9xlh1
	trXRkQlpjDoGTsFwjGExjmpftQYVLFAosrCPHHoW/8YVycQMR5kghbskeMkTwi0QRZJH
	W0RZWXyEDfucoGPaRHhf7MKCnLIjg9t7jZNuMgMOmjtFsJW8rMNJ8Z1wmc/K5dG3lUy2
	tS8Q==
MIME-Version: 1.0
X-Received: by 10.170.115.145 with SMTP id h139mr9719922ykb.119.1430288680628; 
	Tue, 28 Apr 2015 23:24:40 -0700 (PDT)
Received: by 10.129.78.208 with HTTP; Tue, 28 Apr 2015 23:24:40 -0700 (PDT)
In-Reply-To: <1430239855.13022.243.camel@linuxfoundation.org>
References: <CAM1ZcoWg_S6ens4kumJSJzX3fdJio19tw3SUXEPFYpDoR6rAjw@mail.gmail.com>
	<1430239855.13022.243.camel@linuxfoundation.org>
Date: Wed, 29 Apr 2015 07:24:40 +0100
Message-ID: <CAM1ZcoVk8KcwNXgv_Sxxr1Wm=LgGiHtUV3W9hP=8EqcCANPK_A@mail.gmail.com>
From: Katu Txakur <katutxakurra@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: List available kernel modules
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
X-List-Received-Date: Wed, 29 Apr 2015 06:24:40 -0000
Content-Type: multipart/alternative; boundary=001a11390826bc38210514d708fb

--001a11390826bc38210514d708fb
Content-Type: text/plain; charset=UTF-8

Thanks for your answer Richard,
I did wonder which list was more appropriated for... but I got it wrong :)
I will ask in the Yocto list as the kernel-modules that I wan to list are
the available ones in the recipes. the ones in the deployed area, I assume,
are the ones enabled in the config file, but not all of them.

Cheers,
Katu

2015-04-28 17:50 GMT+01:00 Richard Purdie <
richard.purdie@linuxfoundation.org>:

> On Tue, 2015-04-28 at 15:43 +0100, Katu Txakur wrote:
> > Hi,
> >
> >
> > I'm using Yocto to bitbake a kernel and I would like to list the
> > available kernel modules to decide which ones should I include. Could
> > somebody please point me to the documentation explaining this. I've
> > failed to find it.
> >
> >
> > I know how to use the menuconfig, but I would like to see the list.
> > Something similar to checking the list of packages that a recipe
> > builds with
> > bitbake -e myrecipe | grep ^PACKAGES=
> >
> This question is more appropriate for the yocto list really. You can see
> the list of build packages by looking at the list of files in
> tmp/deploy/<package manager> and kernel modules are prefixed
> "kernel-module-" so something like:
>
> ls tmp/deploy/ipk/qemux86/kernel-module-*
>
> will give you a list assuming ipk packaging and qemux86 as the machine.
>
> Cheers,
>
> Richard
>
>
>

--001a11390826bc38210514d708fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for your answer Richard,<div>I did wonder which lis=
t was more appropriated for... but I got it wrong :)</div><div>I will ask i=
n the Yocto list as the kernel-modules that I wan to list are the available=
 ones in the recipes. the ones in the deployed area, I assume, are the ones=
 enabled in the config file, but not all of them.</div><div><br></div><div>=
Cheers,</div><div>Katu</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2015-04-28 17:50 GMT+01:00 Richard Purdie <span dir=3D"ltr=
">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blan=
k">richard.purdie@linuxfoundation.org</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Tue, 2015-04-28 at=
 15:43 +0100, Katu Txakur wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt; I&#39;m using Yocto to bitbake a kernel and I would like to list the<b=
r>
&gt; available kernel modules to decide which ones should I include. Could<=
br>
&gt; somebody please point me to the documentation explaining this. I&#39;v=
e<br>
&gt; failed to find it.<br>
&gt;<br>
&gt;<br>
&gt; I know how to use the menuconfig, but I would like to see the list.<br=
>
&gt; Something similar to checking the list of packages that a recipe<br>
&gt; builds with<br>
&gt; bitbake -e myrecipe | grep ^PACKAGES=3D<br>
&gt;<br>
</div></div>This question is more appropriate for the yocto list really. Yo=
u can see<br>
the list of build packages by looking at the list of files in<br>
tmp/deploy/&lt;package manager&gt; and kernel modules are prefixed<br>
&quot;kernel-module-&quot; so something like:<br>
<br>
ls tmp/deploy/ipk/qemux86/kernel-module-*<br>
<br>
will give you a list assuming ipk packaging and qemux86 as the machine.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br></div>

--001a11390826bc38210514d708fb--
