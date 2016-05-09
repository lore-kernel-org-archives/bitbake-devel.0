Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f195.google.com (mail-ig0-f195.google.com
	[209.85.213.195])
	by mail.openembedded.org (Postfix) with ESMTP id E08296FF97
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 16:37:08 +0000 (UTC)
Received: by mail-ig0-f195.google.com with SMTP id c3so11860509igl.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=3tgRVEp8CY7UQXxbWFgtRfLjvmyip2gdPaKvM+GhdYw=;
	b=KnOPpCmItx21Zo+1AME1cmn/LLZRs4vTY/yo9p77XU3NyzuSUbBx4uU6agWr9mZceW
	txhqsprew3iSZJ00CiunoSlhGbtsEdJP4fqfRqmKH7F8L54fPkHMdoDbrh4RfF8aC5h6
	TquYXeC/DdOVYsfPaAanzhXAnIaThRwBgff/K/zZurlNc7eLz1u4DpP6Y+2C6kULhjUR
	lbdcZM3nuCeswVbGYATewB0Gzh3pmL6OdqhmDskWLjNIj+rqtvAMEcQ8OAi5t4bG5kGf
	YvjKjGRlmVy0765hHgEHTVNlOG/kKNpkPPyQ5mVeLq3TUIFlYS/sERwiNM1VmJ9qo3IN
	Fb3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=3tgRVEp8CY7UQXxbWFgtRfLjvmyip2gdPaKvM+GhdYw=;
	b=V6V9WYug4GEY6gYY6qcwo1gGRl5Yb19olQfcQ/+brHdo646DyqoxmrbbXDDMmIf5XK
	4CdFipFk3WXALpAZODBdAHmD+cyVnzLr9jvXByPonZmCRZUetkuhQxeA5MT4EkF99ZWE
	+SWQOE/5Go3AymgHzkJ1t1zjBcsHBaY9UYMT4yiMSzb2pkdK/XphiPZL9EIrtWcxncZD
	d4iKwfkZ8ACViEauDanO080ov/HsFxzb1VwtwWCpYmNi7DVKrupZNTSsXFMi1yhhTnbE
	aAZms71xNLaDCOjdMLu1Puvq23NtD8/zPw7uKhL0JLqS7oGoxOm7MR9JRPxBD6HPCFl/
	r2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=3tgRVEp8CY7UQXxbWFgtRfLjvmyip2gdPaKvM+GhdYw=;
	b=iQeSYx1cjMxI5oW0KS7FgmdunBkWsD+gxmj/zYatC0292OsNltaLf4OEKhZvqY6cJi
	gv+XRxQDAxHNo8IE5oOh+nOaHkyi7LQNL2sDC6Y+yOcnEXSgKYjJ70MhLzcywKK8DTM8
	oMc5udwh3WkyEh7JOOJ6EyQ/af6mu1HKhTTfoUiloDBaUrAL6n1aqeoTV9RgngeM6p4q
	Zs9FtdzerMP2C2RehFx9Aw1+wiIl5I1hYk8hbQg/nkpvcyvJXxNpzgVwIt15jxgEPZJN
	9DxJwvLABxNXR17Yv0CjeTq60den43XxtwiLzotD0qmog14+ZnSytLa5H5GgKTirBnaq
	G12A==
X-Gm-Message-State: AOPr4FWslz0qMvXJXfVAZY8pLlFLN3NTOsr6RXp1N2aOrJsC1yE+/CTY9Wwef8UvW/zr4BhHQD3I85B920kYdQ==
X-Received: by 10.50.29.76 with SMTP id i12mr12402663igh.87.1462811829053;
	Mon, 09 May 2016 09:37:09 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Mon, 9 May 2016 09:36:49 -0700 (PDT)
In-Reply-To: <1462799726.21831.144.camel@linuxfoundation.org>
References: <1462799726.21831.144.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 9 May 2016 09:36:49 -0700
X-Google-Sender-Auth: pa9T1djj-bg7KHeV---IrDqNUqg
Message-ID: <CABcZANkZdn512rbYaPF=D+hO+3kygdjL_cmoz10ymVpjyDtSYA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Fix missing fakeworker under dry run
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
X-List-Received-Date: Mon, 09 May 2016 16:37:09 -0000
Content-Type: multipart/alternative; boundary=047d7bd7598471b33305326b6b6d

--047d7bd7598471b33305326b6b6d
Content-Type: text/plain; charset=UTF-8

On Mon, May 9, 2016 at 6:15 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> We shouldn't try and use fakeworker when performing a dry_run. This
> makes the core match the other fakeworker execution points.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bd7598471b33305326b6b6d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, May 9, 2016 at 6:15 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div id=3D":ox" class=3D"a3s aXjCH">We shouldn&#39;t try and use fak=
eworker when performing a dry_run. This<br>
makes the core match the other fakeworker execution points.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Looks good.<br>-- <br><div class=3D"gmail_signature">Christopher L=
arson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, Ope=
nZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics<=
/div>
</div></div>

--047d7bd7598471b33305326b6b6d--
