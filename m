Return-Path: <evadeflow@gmail.com>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id C01A5605BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Sep 2016 21:03:07 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id c198so3453838ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Sep 2016 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=ueGl+kGMPqLS+ccLsYXaUwZUZIMRcclTNHG17iLTyvA=;
	b=X49sJQz0APOne7wCYMFIPe8A36H6fiKa0uNxfG3vY5PoqicFugGBiH6JWQCokztrx9
	SMMUNZEpRMbsaK9GdnPUMwPGXJyZi8r4R1Z4uce7U+k8Q4BB16LfUXPElQMsQ4nCpFR1
	sK9W5AuB2XMdppxOIr06tEiksHrSBAvdUpnO9SmzgTWuho6TnGpZkNcWePwWDsUguI5G
	oKtxG69fBx7AOPSZmHDr44kKEMkNOZlZ2X3Dx8bKNfaQgoJ0PRzsEx08tezBgZUsRE+U
	Sr853/l0fMErqPhIViktFtPzRdwQAbjGU3Y3vEx3btad0LCPPdIMQm1zvp0V5EXQFBd/
	dLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=ueGl+kGMPqLS+ccLsYXaUwZUZIMRcclTNHG17iLTyvA=;
	b=KwOKK34jhfes2bF9w6+QQ5D20CfZWbf6jae9Ai45ZN4OMvFVqFKiggiHbt+3d22oKE
	RX73l4n/4CeEqlVzHGM0qJj9RDuA+w/vmxf7bO0a4iY70eW/tuyrd5wewoDdgBiN/fy0
	ZjmMB3fAWpJJddw25d5DQsrE/JNwrYIbRuT6CxA/WC4qy1bTaPFGlQYFHCVR5+TDvku7
	nI34LDyXcwtzCibDb7KF1Vtsd8V9vAYG66Ix6bQyNI2/bfcnZO4PGKQiiIcNy+mfmDpF
	OA/SMuHCu5s5VSA3MObDNBspXK2rvrtjIhZljK/nPrDg+bXEPvYXwO8zAMcQLmyeXWUD
	mC4w==
X-Gm-Message-State: AE9vXwPpi5rIRGZjiWVr7c5WwjXI3Q5mgqdjqdcOYyN6251CBjP0PFcLFH+EVHxiQlwMkWO/AeehDg/+aZrGkA==
X-Received: by 10.36.41.205 with SMTP id p196mr44738545itp.76.1472763786695;
	Thu, 01 Sep 2016 14:03:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.147.4 with HTTP; Thu, 1 Sep 2016 14:03:06 -0700 (PDT)
In-Reply-To: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
References: <CAMAb8ZNGCbyo+49tXBPZJy-jvSbwgShfbFjZ18OU4kARRLqVNw@mail.gmail.com>
From: Evade Flow <evadeflow@gmail.com>
Date: Thu, 1 Sep 2016 17:03:06 -0400
Message-ID: <CAMAb8ZPneH6tk2Nx9Epcb4XVeMScv+O+jt4WXK16JWLvh7QHVA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: Conditionally inherit own-mirrors and set SOURCE_MIRROR_URL?
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
X-List-Received-Date: Thu, 01 Sep 2016 21:03:08 -0000
Content-Type: multipart/alternative; boundary=001a113f6d5e58208e053b788a39

--001a113f6d5e58208e053b788a39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Is there some way I can use a specific (and *invariant*) local source
mirror folder *only if it exists*, and use our internal HTTP pre-mirror
otherwise?

Apologies, it seems I may have posted this to the 'wrong' list. Anyway, I
see that both poky and oe-core have an 'own-mirrors' class. Since I'm using
a Yocto-based distro... I guess I should have posted to
https://lists.yoctoproject.org/listinfo/poky...

On Thu, Sep 1, 2016 at 11:29 AM, Evade Flow <evadeflow@gmail.com> wrote:

> This might be an 'X-Y' problem, so I should explain what I'm trying to
> achieve. We have a somewhat beefy build server with 32 cores that most of
> my team likes to `ssh` into to do builds of our Yocto/OE-based BSP. But a
> few of us build on different machines often enough that I recently spun u=
p
> a web server=E2=80=94on the 32-core build machine=E2=80=94to act as a 'pr=
e-mirror' to
> statically serve  our dependencies for remote builds. The web server is
> serving the exact same folder that I've been pointing `SOURCE_MIRROR_URL`
> at, as described at: https://wiki.yoctoproject.org/
> wiki/How_do_I#Q:_How_do_I_create_my_own_source_download_mirror_.3F
>
> When I went to integrate support for the HTTP pre-mirror, I ran into the
> following problem: if I assign `SOURCE_MIRROR_URL` and the specified fold=
er
> doesn't exist (as will be the case for remote builds), the build *fails*.=
 I
> had hoped that bitbake would 'fall through' to searching other pre-mirror=
s,
> but that doesn't appear to be the case(?)
>
> IIs there some way I can use a specific (and *invariant*) local source
> mirror folder *only if it exists*, and use our internal HTTP pre-mirror
> otherwise?
>
> ```
> $ bitbake --version
> BitBake Build Tool Core version 1.28.0
> ```
>
>

--001a113f6d5e58208e053b788a39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; Is there some way I can use a specific (and *inv=
ariant*) local source=20
mirror folder *only if it exists*, and use our internal HTTP pre-mirror=20
otherwise?<br><br></div>Apologies, it seems I may have posted this to the &=
#39;wrong&#39; list. Anyway, I see that both poky and oe-core have an &#39;=
own-mirrors&#39; class. Since I&#39;m using a Yocto-based distro... I guess=
 I should have posted to <a href=3D"https://lists.yoctoproject.org/listinfo=
/poky.">https://lists.yoctoproject.org/listinfo/poky.</a>..<br></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Sep 1, 2016 at =
11:29 AM, Evade Flow <span dir=3D"ltr">&lt;<a href=3D"mailto:evadeflow@gmai=
l.com" target=3D"_blank">evadeflow@gmail.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div dir=3D"ltr"><div><div>This might be an &#39;=
X-Y&#39; problem, so I should explain what I&#39;m trying to achieve. We ha=
ve a somewhat beefy build server with 32 cores that most of my team likes t=
o `ssh` into to do builds of our Yocto/OE-based BSP. But a few of us build =
on different machines often enough that I recently spun up a web server=E2=
=80=94on the 32-core build machine=E2=80=94to act as a &#39;pre-mirror&#39;=
 to statically serve=C2=A0 our dependencies for remote builds. The web serv=
er is serving the exact same folder that I&#39;ve been pointing `SOURCE_MIR=
ROR_URL` at, as described at: <a href=3D"https://wiki.yoctoproject.org/wiki=
/How_do_I#Q:_How_do_I_create_my_own_source_download_mirror_.3F" target=3D"_=
blank">https://wiki.yoctoproject.org/<wbr>wiki/How_do_I#Q:_How_do_I_<wbr>cr=
eate_my_own_source_download_<wbr>mirror_.3F</a><br><br></div>When I went to=
 integrate support for the HTTP pre-mirror, I ran into the following proble=
m: if I assign `SOURCE_MIRROR_URL` and the specified folder doesn&#39;t exi=
st (as will be the case for remote builds), the build *fails*. I had hoped =
that bitbake would &#39;fall through&#39; to searching other pre-mirrors, b=
ut that doesn&#39;t appear to be the case(?)<br><br></div>IIs there some wa=
y I can use a specific (and *invariant*) local source mirror folder *only i=
f it exists*, and use our internal HTTP pre-mirror otherwise?<br><br>```<br=
>$ bitbake --version<br>BitBake Build Tool Core version 1.28.0<br>```<br><b=
r></div>
</blockquote></div><br></div>

--001a113f6d5e58208e053b788a39--
