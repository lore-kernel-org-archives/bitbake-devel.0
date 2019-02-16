Return-Path: <mr.k.zawadzki@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id E56976BCDC
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Feb 2019 00:36:14 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id i2so27769834ite.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Feb 2019 16:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Qm/bVRSEaa3wmyMYc8gkIET3UFW+yh/4i2q7VgvoYpY=;
	b=g0IaJvb5kbwySW+uU7QtYT+xukmuDgpood0ynogiIFD7E7q6FDdJvtrGSnmHxQPtmP
	IJgGZXXuCvVMZpo4iRzqStbtWbZQHaUOa/JVfu8ygCVPugZSWxDHwHpmoD8BuUdAbZv5
	7ePzO/02Qn1mG4I4Ai8zT2k029pG6AA5FNYLn/+XsMWwRYI1Wi4aev4NMYO/1KbbagZU
	iMmR/YuaBMzvaKXrZkrMXw6rypxgt31nMCRjAOfZ+8bxbFqm8YXFVXcF/5/1jX0M7/Ki
	+UeHKnpvWSCKolITbt1/Y/ZuMkeMWvjrgaAfOHC4DA8U4T5C5f+IODPOOcJNaXxiECy/
	E0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Qm/bVRSEaa3wmyMYc8gkIET3UFW+yh/4i2q7VgvoYpY=;
	b=fO80CKQWz2hFI4Po7OyXD2AaBL42MqcYvr4d0V0SVzCJOTYvWsGVLUoTEhw08ZTInJ
	/QDBNiHCPA5LZ5hpEHy7JyTMKG6B37UIWAYRLmDC4elsbC6wvrBScc3Q7voAfjVJDcSm
	7Biy9DoIV2ADXjHh+GIaJhL/fO0hGEdxGxFHgvAhLpiQ130Trc9CzM4r5loU1aes9ALi
	xUOOBxbJncVwQRZxFOeKd0kr6zwxD3umjq5smjxhgA3rY3qNbZbOcHQCu5eqIr4tPo65
	9tdHAU7jC9CIAUNk9gKyRkYpxwCmvo2/n8NNcrapjL/SkiLhFG8YC81/l7ANfy4igu6F
	AygA==
X-Gm-Message-State: AHQUAub5JLA36Nf+6lJaxy5Z9dsOsb00BNhCoVeZu4a3PPOFoNGX4gx0
	mv5hIf1yHny0AR9KadBQA1OXR+xKHL4XxfiMgMI=
X-Google-Smtp-Source: AHgI3IYu7rlmK7PqbE+5qwZAz7fWoGvCr+ohWdLbUwa2bWlA61/ZAVPyi5RpOrvtseho7bucMf8sJR4cq34za+3BQLI=
X-Received: by 2002:a24:4692:: with SMTP id j140mr3946135itb.170.1550277375908;
	Fri, 15 Feb 2019 16:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20190215032539.5297-1-mr.k.zawadzki@gmail.com>
	<7dd4a96220566dc8d9a1db6a6430aba8bed8b596.camel@linuxfoundation.org>
In-Reply-To: <7dd4a96220566dc8d9a1db6a6430aba8bed8b596.camel@linuxfoundation.org>
From: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>
Date: Sat, 16 Feb 2019 01:36:04 +0100
Message-ID: <CAKdBavFaHM8xBNz0-HNydrqRtYPcCET6uhbQhFUKm78UjMcQAw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/svn: adds svn --ignore-externals option
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
X-List-Received-Date: Sat, 16 Feb 2019 00:36:15 -0000
Content-Type: multipart/alternative; boundary="0000000000004b61c70581f814b8"

--0000000000004b61c70581f814b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I think so also. Subversion client is poor in exit statues when there are
issues during svn:externals fetching. I have seen such issues previously.
And it took a while to find there root cause (e.g switching revisions of
svn:externals to non existing paths or revisions and some conflicts showed
up).

@Richard Purdie
It's better to create new patch which will add this option by default, with
additional Docs update? Or update this one?

Best Regards,
Krzysztof Z.

sob., 16 lut 2019 o 00:00 Richard Purdie <richard.purdie@linuxfoundation.or=
g>
napisa=C5=82(a):

> On Fri, 2019-02-15 at 04:25 +0100, Krzysztof Zawadzki wrote:
> > With this option we can force users to provide all used sources in
> > recipe.
> > Without this there is possibility that repositories which are using
> > svn:externals
> >  can point to source code from HEAD or to nonexisting repository.
> > This can cause attempt to reproduce build after some time impossible.
> >
> > Signed-off-by: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>
> > ---
> >  lib/bb/fetch2/svn.py | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
>
> I'm wondering if this should be the default and is something people
> have to explicitly opt out of?
>
> Cheers,
>
> Richard
>
>

--0000000000004b61c70581f814b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I think so also. Subvers=
ion client is poor in exit statues when there are issues during svn:externa=
ls fetching. I have seen such issues previously. And it took a while to fin=
d there root cause (e.g switching revisions of svn:externals to non existin=
g paths or revisions and some conflicts showed up). <br></div><div><br></di=
v><div>@Richard Purdie</div><div>It&#39;s better to create new patch which =
will add this option by default, with additional Docs update? Or update thi=
s one?<br></div><div><br></div><div>Best Regards,</div><div>Krzysztof Z.<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">sob., 16 lut 2019 o 00:00=C2=A0Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; napisa=C5=82(a):<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Fri, 2019-02-15 at 04:25 +0100, Krzysztof Zawadzki wrote:<br>
&gt; With this option we can force users to provide all used sources in<br>
&gt; recipe.<br>
&gt; Without this there is possibility that repositories which are using<br=
>
&gt; svn:externals<br>
&gt;=C2=A0 can point to source code from HEAD or to nonexisting repository.=
<br>
&gt; This can cause attempt to reproduce build after some time impossible.<=
br>
&gt; <br>
&gt; Signed-off-by: Krzysztof Zawadzki &lt;<a href=3D"mailto:mr.k.zawadzki@=
gmail.com" target=3D"_blank">mr.k.zawadzki@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/svn.py | 9 ++++++++-<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
I&#39;m wondering if this should be the default and is something people<br>
have to explicitly opt out of?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000004b61c70581f814b8--
