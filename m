Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id F235A77114
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jan 2016 21:43:53 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id 1so69350870ion.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jan 2016 13:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=QC41/1wdRKuRapE5IlvvLet1XNwDD+Oox5Ge+UvnVo0=;
	b=r+e81dR8H6DBFoKkzIBktQfZYdueGUI2DzsDwVnu6it5uLZKLIIH+4/ODOg7J7mmKG
	xFXf2BfKqKJbWSgZ3nqjI88lItndTexM9Q7MWJ3kW2J6XganISS+gKnfbPnINs/wPoLJ
	mWCuaWVicr7Ez3vuQsa+h6CPSTtsPGURzZosJNvux77+uzVkNDt2T+TX6Ptt8FPblSvq
	wn26U2WQ/HPxabUvFyRVlomqTeSi0Gb/m73FvQzkpd4DyHoE7ceuFer6OKnIbhhsLwC3
	aRS0bLxXX0faRegOdQj0dakR3nQ0ghxP8k1hCLngqkypsI7Dy60wkj7eL546DJt9mzUX
	Iugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=QC41/1wdRKuRapE5IlvvLet1XNwDD+Oox5Ge+UvnVo0=;
	b=E99zPYiIV8E8V0/s0RwcBx6GnEnDDeMAWEn3upNOZK2sCEQHXk0F8M4EksS1QOSonH
	s/o8HvdRqJ1EVhnYhp2USMYmGCBr5B12t7K2EQwyrQ6tEprCuUp7jLQMb6Yi0/EGeqVz
	4eaw9hzEBPXrl947lqGXYg/hRVcTdxfGwFd8h56CHas0ulQOZQR4suuBhyjZAQDEV5kn
	KCtgIDiF9Kf1vZDciBrQ5YDhVsGcv2LwkaC0ohMhuUJHQfx/OnAL3dNeheQWFoQj1Hz/
	Jq5XCal2pISe+ypJG/4vilCvvEK+9oblyCZol2AIXNA6zk44rLQ3cNpISafBfDSdBpvB
	bWAw==
X-Gm-Message-State: AG10YOTHbivLolPB6l1cC5mgFl1QHWUtRh7r5ztIi1JzRLuOjl5DS8F4M/KtbmLdaFvOQC7csZt+7EHHWe7JtimU
X-Received: by 10.107.135.104 with SMTP id j101mr7174361iod.133.1454017434312; 
	Thu, 28 Jan 2016 13:43:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.162.70 with HTTP; Thu, 28 Jan 2016 13:43:34 -0800 (PST)
In-Reply-To: <CAD2C2VRqrrOKLixFBBXq-Vxu-nb5DzSXqV8Xrr2yuwb6auds5w@mail.gmail.com>
References: <CAD2C2VRqrrOKLixFBBXq-Vxu-nb5DzSXqV8Xrr2yuwb6auds5w@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 28 Jan 2016 21:43:34 +0000
Message-ID: <CAJTo0LbUkpF3Oq5FDXgizhUW6ANbwcyiTrrzZATBsZ_7ABsHEg@mail.gmail.com>
To: Bryan <just4tech83@gmail.com>
Cc: "Development list for the linux-yocto*.git Linux kernel repositories"
	<linux-yocto@yoctoproject.org>,
	OE-core <openembedded-core@lists.openembedded.org>,
	Chander.kashyap@gmail.com,
	OpenEmbedded Devel List <openembedded-devel@lists.openembedded.org>,
	Poky Project <poky@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [linux-yocto] Plymouth support in yocto
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
X-List-Received-Date: Thu, 28 Jan 2016 21:43:58 -0000
Content-Type: multipart/alternative; boundary=001a113ebe92ab7b55052a6bd023

--001a113ebe92ab7b55052a6bd023
Content-Type: text/plain; charset=UTF-8

On 28 January 2016 at 18:01, Bryan <just4tech83@gmail.com> wrote:

>    Can  we integrate plymouth package in yocto  so that we can properly
> display splash screen on different resolution monitors.
>
>
http://layers.openembedded.org/layerindex/recipe/39966/

Ross

--001a113ebe92ab7b55052a6bd023
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 28 January 2016 at 18:01, Bryan <span dir=3D"ltr">&lt;<a href=3D"mailto:=
just4tech83@gmail.com" target=3D"_blank">just4tech83@gmail.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><p dir=3D"ltr">=C2=A0=C2=A0 Can=C2=A0 we inte=
grate plymouth package in yocto=C2=A0 so that we can properly display splas=
h screen on different resolution monitors. </p>
<p dir=3D"ltr"></p></blockquote></div><br><a href=3D"http://layers.openembe=
dded.org/layerindex/recipe/39966/">http://layers.openembedded.org/layerinde=
x/recipe/39966/</a><br></div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">Ross</div></div>

--001a113ebe92ab7b55052a6bd023--
