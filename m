Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 9AD5771B24
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Nov 2016 15:46:52 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id 62so1617713oif.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Nov 2016 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=/Eklkammacg0RoMXS+n1gWerKCwYSHIEvdDhNST2aoM=;
	b=nBnAQGKVjM61PNElzxuSF2FFndrtUqftP+A1OyA0r/0vCsg8P5WSEaXq5e2RANqoC1
	WXoaodIkVEwOBRtGmmcXWgNh/YmjPKpKIH1fFRC4u5n28tfrF2kpPy2a1Q6CVwQqfRW6
	tA1jiLysIQ/39ENO+fM7UY8j8sBYPJgexu5beWzUlD5pP+Z3ccRiroUBA4waAUXarYPl
	6aWNVCHPtKjMCg2fUD0oB94WUo5tpccgFl2AeZw7E6pstcqpK1fD/nB3oRf+pf+dM7L1
	fxHG2HuXU3T95e4NcHVuRYh6X4o7/PR6P9jeD9gmT6q/BKLUrfRAjfwAQDilSXTzdN1k
	05+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=/Eklkammacg0RoMXS+n1gWerKCwYSHIEvdDhNST2aoM=;
	b=lmobpB6GFE1Rwfy1kQwuplSE+5SfrnltNattaa5QeM+rURdlf7mwcD3JFc7N9vEgw7
	TaScPqPVm+kW5EiqUMTnUXJ/KswFi210VPsErnBNet4GDvB1kIjIHIDt2RffydRi4QCy
	kg2G7U78X8WoYZGzKFKlSxcKXGhEP+a4ChZd8DHxpOZ71TfjTgessSF0Vcs7kh2M9c6V
	RVw2DZ8czqfToP5jDlQBZzlN6a8ED+27Y7kFCdxytmNEg+zGjGjO5L2ErwWWhAvnwAge
	bcMNmuuRvydP6SCGZj+1aLmD95tD2HoqWT3oaJJZ8gafcuNf6vNMHN40/YMbPwzWOKtW
	ADfg==
X-Gm-Message-State: ABUngvfRACKuQjVBkka5Q8ojK0EPwsozuIHUc7f5LuIKwDYMLic0EqXqkvmj2fmk8iO4Y7ZDIUmIbCfJZ1O9Mg==
X-Received: by 10.202.89.66 with SMTP id n63mr3647443oib.65.1478101611726;
	Wed, 02 Nov 2016 08:46:51 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Wed, 2 Nov 2016 08:46:31 -0700 (PDT)
In-Reply-To: <1478099253.23123.63.camel@linuxfoundation.org>
References: <1478099253.23123.63.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 2 Nov 2016 08:46:31 -0700
X-Google-Sender-Auth: 4HBdFZETGAdEVJDRkhywD85MWKM
Message-ID: <CABcZANkNPT+wqHMkUE3z0N_0R=QWYrfPDzU1R+qw31N_WjHdnw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Ensure taskhash mismatches don't override existing data
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
X-List-Received-Date: Wed, 02 Nov 2016 15:46:52 -0000
Content-Type: multipart/alternative; boundary=001a113d597c8250090540535958

--001a113d597c8250090540535958
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 2, 2016 at 8:07 AM, Richard Purdie <richard.purdie@
linuxfoundation.org> wrote:

> We recalculate the taskhash to ensure the version we have matches
> what we think it should be. When we write out a sigdata file, use
> the calculated value so that we don't overwrite any existing file.
> This leaves any original taskhash sigdata file intact to allow a
> debugging comparison.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Thanks, I ran into this trying to diagnose a mismatch with our automated
builds a while back. These patches should make those a lot easier to debug.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113d597c8250090540535958
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 2, 2016 at 8:07 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@<wbr>linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D"m_-2237343649939990454:32g" class=3D"m_-2237343649=
939990454a3s m_-2237343649939990454aXjCH m_-2237343649939990454m158259d5c3b=
a2326">We recalculate the taskhash to ensure the version we have matches<br=
>
what we think it should be. When we write out a sigdata file, use<br>
the calculated value so that we don&#39;t overwrite any existing file.<br>
This leaves any original taskhash sigdata file intact to allow a<br>
debugging comparison.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundatio<wbr>n.org</a>&=
gt;</div></blockquote></div><br>Thanks, I ran into this trying to diagnose =
a mismatch with our automated builds a while back. These patches should mak=
e those a lot easier to debug.<br>-- <br><div class=3D"m_-22373436499399904=
54gmail_signature" data-smartmail=3D"gmail_signature">Christopher Larson<br=
>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<=
br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113d597c8250090540535958--
