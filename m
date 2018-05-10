Return-Path: <armccurdy@gmail.com>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
	[209.85.213.43])
	by mail.openembedded.org (Postfix) with ESMTP id 0E7DD7501B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 00:29:39 +0000 (UTC)
Received: by mail-vk0-f43.google.com with SMTP id 203-v6so201870vka.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 May 2018 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=IB6+rUdH7jaG7MCmHGipIeVOCepwgjOtTh2NsadPhRU=;
	b=fiVx1A1iiIosD8TqF9JFpUtNvfowgxnUibrrR2QMNHR6NFI9rAToB1qYsvws530Z8L
	XFQu1VL99GaDt8+Ezv081AjNSLSJMarvnhBT3/PbaTRbz4c2yUXSA7bX8jD1j9AscG4J
	/iQ+e43Jn5Dyr1RUs5w1dcpeJKZkM6aiVSdaLn9Qmm2B2OroaxaUmMznOTnbbObiOytu
	UUclPZCU3s6u8Iv11XXOgkLpeGLhL5k8gTJ9t8uoQLDB4QUjvPK+6ZW3pL02f0l/oqWX
	u7GjoxYcE6d9enlbdKvyMR4aDGV/sVK15sWSiVU96oXx32GqXb+bYAXIUx/yAEx3sxdN
	oN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=IB6+rUdH7jaG7MCmHGipIeVOCepwgjOtTh2NsadPhRU=;
	b=mFJVL4Rp0dLaP83IY9SaCPP9NBSSGEWXDIGG5Z1+AH1alaLbV02kzX9EJjEXc3rfTp
	xDkEgxoGnDKojarjoAfltWWIi3XxhhQl1oP5DsskBNLvi5p5Dxp701zSpq8yIhpGz94e
	rWO3ICXMAmeWEpoGAw2J3Vjj2IGcuNxdcqxXQdUfTFtwNr/QRopwEk48YoUtTiVM4lzO
	EDR8EWX66haV1sdfYlERud7/eHgRy3rdsWLxqH7RZ5XkBn7SILghf9OPsr2BxNdM6kRF
	26C+E13M8osXFmL+yn94KQdNiIjCs6kQJz47wGD0TOy8chjGdWEuzdx7ZRJ83beJCCzU
	ckBw==
X-Gm-Message-State: ALQs6tCmpsjT9r1gnHkj/pS4BrEe75YNLJSORDOQld7746p92+Bve9G7
	cjcDRoQco4guoD8VBmyCiJc6lm3q1mXYfgIRwX0=
X-Google-Smtp-Source: AB8JxZp9A4cM/JcBIMpsvuG0BB+fZpUY5IPUnNTiHA3SdOvFJeFksrsOByTa1c5cHaiqn7Np8E0Hn0ItxDpGzkdhDSs=
X-Received: by 2002:a1f:4445:: with SMTP id
	r66-v6mr37882794vka.154.1525912180611; 
	Wed, 09 May 2018 17:29:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.48.148 with HTTP; Wed, 9 May 2018 17:29:40 -0700 (PDT)
In-Reply-To: <838865895.1728045.1525881582620@mail.yahoo.com>
References: <1184471455.1381374.1525832300014.ref@mail.yahoo.com>
	<1184471455.1381374.1525832300014@mail.yahoo.com>
	<CAJTo0LZGEBwiZr7csd3vxYaThN7-fTjexeRfkT+1ksX-AerbvA@mail.gmail.com>
	<838865895.1728045.1525881582620@mail.yahoo.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Wed, 9 May 2018 17:29:40 -0700
Message-ID: <CAJ86T=VW2yODWtD_Fx+3436GKQYwuFL2jnHoy3xpsQ1SA4Mk3A@mail.gmail.com>
To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: .bb script file for auto tools
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
X-List-Received-Date: Thu, 10 May 2018 00:29:40 -0000
Content-Type: multipart/alternative; boundary="0000000000007be1d7056bcf1dd9"

--0000000000007be1d7056bcf1dd9
Content-Type: text/plain; charset="UTF-8"

On Wed, May 9, 2018 at 8:59 AM, Ugesh Reddy via bitbake-devel <
bitbake-devel@lists.openembedded.org> wrote:

> Hello,
>  The devtool hides out the information and trying to learn bitbake and
> wanted understand each entry in the .BB files.So I would to write it
> instead of tool.
>
> Could you guide me?
>

How to write a recipe is well documented:


https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-recipe-writing-a-new-recipe

https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-recipe-autotooled-package

You can also learn a lot by reviewing and understanding the recipes in
oe-core.

--0000000000007be1d7056bcf1dd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, May 9, 2018 at 8:59 AM, Ugesh Reddy via bitbake-de=
vel <span dir=3D"ltr">&lt;<a href=3D"mailto:bitbake-devel@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>&gt;</span=
> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hello,<div id=3D"gmail-m_-27980050=
02225837817yMail_cursorElementTracker_1525881354960">=C2=A0The devtool hide=
s out the information and trying to learn bitbake and wanted understand eac=
h entry in the .BB files.So I would to write it instead of tool.</div><div =
id=3D"gmail-m_-2798005002225837817yMail_cursorElementTracker_1525881480048"=
><br></div><div id=3D"gmail-m_-2798005002225837817yMail_cursorElementTracke=
r_1525881480127">Could you guide me?</div></blockquote><div><br></div><div>=
How to write a recipe is well documented:<br></div><div><br>=C2=A0 <a href=
=3D"https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#=
new-recipe-writing-a-new-recipe">https://www.yoctoproject.org/docs/current/=
mega-manual/mega-manual.html#new-recipe-writing-a-new-recipe</a><br>=C2=A0 =
<a href=3D"https://www.yoctoproject.org/docs/current/mega-manual/mega-manua=
l.html#new-recipe-autotooled-package">https://www.yoctoproject.org/docs/cur=
rent/mega-manual/mega-manual.html#new-recipe-autotooled-package</a><br><br>=
</div><div>You can also learn a lot by reviewing and understanding the reci=
pes in oe-core.<br></div><div><br></div></div></div></div>

--0000000000007be1d7056bcf1dd9--
