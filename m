Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
	[209.85.220.182])
	by mail.openembedded.org (Postfix) with ESMTP id 2582365C9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 21:48:34 +0000 (UTC)
Received: by qkx62 with SMTP id 62so13928677qkx.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=sZ2AuI9dw16Gp9O3OY5Af9RnX17pRfxQcsbedq+ZTH8=;
	b=EKI3HFSCj3HDDKoWydmEG1qin/eKNa7FPWpi/a0xWLTvFVRrNRQIg48cC+ppldV7yO
	coU1VKnvGpRfUQT5VysAgg7VPOr3ACLzu7Qv86HNrSIa8+Du9Yu088S+AMpBVRbjU/Sl
	O5qFy/6jM30vo68bAaFT4XZWMuyYiAjBpTj/Gv7zJDehw7nzOEbofbgeuYQdaffT7s22
	Be4URIu67xBv7zfl6lipfoO/TDTkAMbDdglc4jXmB28SzEiMvhF/Arc3vjKrJ5dt0MM/
	tfVOLbBVWW+v9t4OrFmc5Xd5NK0YMrqQKP2tpv6C0p/c/obv9+iLr8Tgc3NBH7QQWvCU
	Q1MA==
X-Gm-Message-State: ALoCoQn+VYXQQxqX54032H9i0BgZH0P0z0toectEG+1Yx3Ji1inFPtlls+BqoOMa7w3D+lzVzqOE
X-Received: by 10.140.133.199 with SMTP id 190mr40642945qhf.17.1433368115921; 
	Wed, 03 Jun 2015 14:48:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Wed, 3 Jun 2015 14:48:15 -0700 (PDT)
In-Reply-To: <CADL-HDjZUp45887vfcpKKUC5FK8JD+3xA7LPxUXNa=yTPtaaYw@mail.gmail.com>
References: <CADL-HDjZUp45887vfcpKKUC5FK8JD+3xA7LPxUXNa=yTPtaaYw@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 3 Jun 2015 22:48:15 +0100
Message-ID: <CAJTo0LY7+qWs6f4RwGFSuKrSK6Z=rfmhaqw=Q_FMUo-FaXZKng@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: command to execute a set of task again in bitbake
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
X-List-Received-Date: Wed, 03 Jun 2015 21:48:36 -0000
Content-Type: multipart/alternative; boundary=001a1135339061e1bd0517a405ec

--001a1135339061e1bd0517a405ec
Content-Type: text/plain; charset=UTF-8

bitbake --help is useful here, there's a --force option for this.

Ross

On 3 June 2015 at 16:07, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> Hi,
>
> Is it possible to force execution of certain tasks in bitbake. I want to
> force execution of tasks from configure to package_write_rpm for one
> package .
>
> Thanks,
> Yogesh
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--001a1135339061e1bd0517a405ec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">bitbake --help is useful here, there&#39;s a --force optio=
n for this.<div><br></div><div>Ross</div></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On 3 June 2015 at 16:07, Yogesh Tyagi <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:yogesh.bit2006@gmail.com" target=3D"_blank=
">yogesh.bit2006@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>Is it possible to force exe=
cution of certain tasks in bitbake. I want to force execution of tasks from=
 configure to package_write_rpm for one package .</div><div><br></div><div>=
Thanks,</div><div>Yogesh=C2=A0</div></div>
<br>--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
<br></blockquote></div><br></div>

--001a1135339061e1bd0517a405ec--
