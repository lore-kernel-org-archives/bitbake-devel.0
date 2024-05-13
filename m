Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C4C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 16:06:41 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.64837.1715616398685741576
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 09:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MF9izqeD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.43, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-522297f91bcso3803189e87.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 May 2024 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715616397; x=1716221197; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X9fJiKjQVdsKxXo1+fj2f3qOT9g2I8N3jnexJXLi+5g=;
        b=MF9izqeDFiXmL/N92U+CLpPYtJY3w5cJrau5mKw1YRsOJ8KAwzMovR3XvnLeQruziz
         QkL1GRdEnqCQeCkDxZXOG2ojB5m6UtNMleOTcez95HM8nkk2TCxKMlhEGRwpOMomTuwI
         V3zitss6zLNBa/I9CanqaSbU1R6+6FRzNiu8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616397; x=1716221197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9fJiKjQVdsKxXo1+fj2f3qOT9g2I8N3jnexJXLi+5g=;
        b=Yh2QgHNx2L65eG+As6X9aJWGcwM8U1IN6tQcTycZovxOeb2A2UYcbYwRllY2FPDTeF
         tTlM61az2/7d6IqKpJ4Hx/QkMfOIr8B4ftvBNkl8TAHPO8aBSsDmKBlqBwhkFxdGRakK
         2IkntRbmooeT6pVBjZNrqzZgIa00xtpGZTk41hLR/rg2V4D5ntpf3xsVjrcUOus8Lins
         7n0oAyQSB+TkxcIGOBf9QFquOSFguwKoInZnnvbXDqJdxV9w5FF6SpbX2mrxNLQMeuUD
         yn1wE/N8glVMU4Bv6xG60wmP1CwdutdN2rHGASWGUkO9lx6FBBEC8Ifb036TUMJx7aCb
         mSgw==
X-Gm-Message-State: AOJu0YzbAnZZf4r1vwZZIqvqpy+inuNw6EYl/iMImIYgbIqfNVRZeLSQ
	B8tm0M5h8i+qj9uu5BIY/eV5cYA6FokjM/ex0dF66Q5MnHbxRaQKLtfsnYHViEgbyQPAnKoE+z/
	2Vluld9vJDCqqa3hqmj9uhHDQWaKsvewGf2BSgCOcpzFvrq2lD+8=
X-Google-Smtp-Source: AGHT+IGtGWRg/1uS7rkhPXIszyOYt9PCsbASOhSxBXpU+kg8DJU7d0CjuD0ND8tpBcn7SSO7mY/SAK/L/zkPqhVm0xA=
X-Received: by 2002:a05:6512:2086:b0:51c:d6c9:e9a3 with SMTP id
 2adb3069b0e04-5220fc7d776mr5447528e87.17.1715616396865; Mon, 13 May 2024
 09:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DM8PR12MB543006B728DBC2C6E7077D7A8BE22@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543006B728DBC2C6E7077D7A8BE22@DM8PR12MB5430.namprd12.prod.outlook.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Mon, 13 May 2024 09:06:25 -0700
Message-ID: <CADfgfoZjbarji4my4mx74Fap-nx0c+xqO1GNTAyrOMqk4j1BfA@mail.gmail.com>
Subject: Re: BB Datastore Playground preview is now live
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"behanw@converseincode.com" <behanw@converseincode.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000e80f07061858110f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 May 2024 16:06:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16209

--000000000000e80f07061858110f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:55=E2=80=AFAM chris.laplante@agilent.com <
chris.laplante@agilent.com> wrote:

> Hi all,
>
> > This bug ("A web based playground for experimenting with bitbake variab=
le
> > expansion") has been preying on my mind ever since I read it on Bugzill=
a:
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805.
> >
> > I'm happy to say that I have a simple proof-of-concept implementation
> built
> > using Pyodide. The code needs some cleanup before I feel comfortable
> sharing
> > it, but here are some details:
>
> It took all Saturday, but a very perfunctory version of this tool is now
> live :). Check it out here:
> https://yoctoproject.github.io/bb-datastore-playground. Many thanks to
> Michael for setting up the GitHub repo for me!
>
> It is basically a Python REPL with added 'bb' goodness.
>
> It is very rough - no styling on the page, and it doesn't work on mobile.
> But it is already useful so please give it a try. It requires a modern-is=
h
> browser (though I haven't categorized what this actually means).
>

The interpreter works for me in Chrome and Firefox on Fedora 40. ;) It
seems to handle weird whitespace fairly well. Both copy-paste and arrow
keys are working as expected too.

> Next steps are to add a Godbolt-like editor and 'Run' button.
>
> Thanks,
> Chris
>


--=20
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

--000000000000e80f07061858110f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, May 13, 2024 at 7:55=E2=80=AFAM <=
a href=3D"mailto:chris.laplante@agilent.com">chris.laplante@agilent.com</a>=
 &lt;<a href=3D"mailto:chris.laplante@agilent.com">chris.laplante@agilent.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi all,<br>
<br>
&gt; This bug (&quot;A web based playground for experimenting with bitbake =
variable<br>
&gt; expansion&quot;) has been preying on my mind ever since I read it on B=
ugzilla:<br>
&gt; <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/show=
_bug.cgi?id=3D14805</a>.<br>
&gt; <br>
&gt; I&#39;m happy to say that I have a simple proof-of-concept implementat=
ion built<br>
&gt; using Pyodide. The code needs some cleanup before I feel comfortable s=
haring<br>
&gt; it, but here are some details:<br>
<br>
It took all Saturday, but a very perfunctory version of this tool is now li=
ve :). Check it out here: <a href=3D"https://yoctoproject.github.io/bb-data=
store-playground" rel=3D"noreferrer" target=3D"_blank">https://yoctoproject=
.github.io/bb-datastore-playground</a>. Many thanks to Michael for setting =
up the GitHub repo for me!<br>
<br>
It is basically a Python REPL with added &#39;bb&#39; goodness. <br>
<br>
It is very rough - no styling on the page, and it doesn&#39;t work on mobil=
e. But it is already useful so please give it a try. It requires a modern-i=
sh browser (though I haven&#39;t categorized what this actually means).<br>=
</blockquote><div><br></div><div><div id=3D"gmail-:15w" class=3D"gmail-Am g=
mail-aiL gmail-aO9 gmail-Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" =
aria-label=3D"Message Body" role=3D"textbox" aria-multiline=3D"true" tabind=
ex=3D"1" style=3D"direction:ltr;min-height:85px" aria-controls=3D":20j" ari=
a-expanded=3D"false">The interpreter=C2=A0works for me in Chrome and Firefo=
x on Fedora 40. ;) It seems to handle weird whitespace fairly well. Both co=
py-paste and arrow keys are working as expected too.</div></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
Next steps are to add a Godbolt-like editor and &#39;Run&#39; button.<br>
<br>
Thanks,<br>
Chris<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Michael Halstead<div>Linux Foundation / Yocto Project</div><=
div>Systems Operations Engineer</div></div></div></div>

--000000000000e80f07061858110f--

