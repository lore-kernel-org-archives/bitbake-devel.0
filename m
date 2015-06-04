Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
	[209.85.220.182])
	by mail.openembedded.org (Postfix) with ESMTP id DF393757A7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 14:42:46 +0000 (UTC)
Received: by qkoo18 with SMTP id o18so24906806qko.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Jun 2015 07:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=kaTfgG87DiTI03ub1VsHl8A3gmCUQArdMuGbWzKInk0=;
	b=SqAbI5w2b+IkYRWniM7ADjhgMZG9uZcXgBGtiQ5LYjBpWPS7XjtEEhaT7a3FN64H4b
	PVdgSdL29irKNpDYZF+56Gba6XWR6Q5wVYXkBMpqTBOfPt0pdoGjv/lpb+eiO6KscwxQ
	M2Cxb99YZpFn8yBe5WtQivIT3oK9BQASedrqmT4p8p+rpPhQGBOz7P8Kzwo/mRMC26CM
	rii2Y9j0Mv6ojUa45tImyu9wQH0iqgqfPv3YESsMS8PvsmByid07bh8auMLRT4w7dPbu
	vw7IXxE8oLnXmQsGJfBmGR8oy2XQ9GGZqCH8hDe+83/hPDQbwehlbNHSy/auLwubZLXO
	fPPA==
X-Gm-Message-State: ALoCoQmgFAYpnGSz4UeCux7EPSObY+Bbd+uh3n4+x1IgiwcFxOsnt+tPmGO+MnlV0dsoJb01nwuA
X-Received: by 10.140.133.199 with SMTP id 190mr45380274qhf.17.1433428967863; 
	Thu, 04 Jun 2015 07:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Thu, 4 Jun 2015 07:42:27 -0700 (PDT)
In-Reply-To: <CADL-HDh=p-=YvT-xw-EuCVKOux9+k3RtpN93LznaQ=5mT3=opA@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
	<CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
	<CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
	<B8A83673-75A0-4880-97BE-1712A4093058@gmail.com>
	<CAJTo0LbTnQQmj-KsmncAsnE-kcuZxKTH-mwHMC_=HwPCV6JCgQ@mail.gmail.com>
	<CADL-HDh=p-=YvT-xw-EuCVKOux9+k3RtpN93LznaQ=5mT3=opA@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 4 Jun 2015 15:42:27 +0100
Message-ID: <CAJTo0La_T6oP7n6TuDUS4v5u=L59-=WSiAg4wuw+j37z9uLFTA@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Thu, 04 Jun 2015 14:42:49 -0000
Content-Type: multipart/alternative; boundary=001a1135339070d3810517b2306e

--001a1135339070d3810517b2306e
Content-Type: text/plain; charset=UTF-8

On 4 June 2015 at 15:15, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> I have not overridden any variable but when I printed "libdir" in
> Makefile, it's value is "/lib" . This should be the reason why my libs were
> not getting installed to /usr/lib/gstreamer-0.10. But why this is
> happening? As per bitbake documentation  "libdir" should be /usr/lib and I
> also confirmed this by
>
> bitbake -e|grep libdir
>

If bitbake thinks its /usr/lib then your configure or makefile is
overriding it.

Ross

--001a1135339070d3810517b2306e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 4 June 2015 at 15:15, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>I have not overri=
dden any variable but when I printed &quot;libdir&quot; in Makefile, it&#39=
;s value is &quot;/lib&quot; . This should be the reason why my libs were n=
ot getting installed to /usr/lib/gstreamer-0.10. But why this is happening?=
 As per bitbake documentation =C2=A0&quot;libdir&quot; should be /usr/lib a=
nd I also confirmed this by</div><div><br></div><div>bitbake -e|grep libdir=
</div></blockquote></div><br>If bitbake thinks its /usr/lib then your confi=
gure or makefile is overriding it.</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">Ross</div></div>

--001a1135339070d3810517b2306e--
