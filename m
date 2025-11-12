Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D70CD13DF
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 16:04:00 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.846.1762963430890896300
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 08:03:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ogx8rlhY;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c82bf86bso641337f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762963429; x=1763568229; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1htTvmHhSS7PxGLOxYsNqzuoZBJcNttW6OTDvCLzFk0=;
        b=ogx8rlhYGC+Sx8dZYdDz/lGTlin/ulwW5dBE7A8vdlk2GQxVaBP9G9r8dPX3erWew3
         h1MUtWlm6GqMnrRWAngj2JFLaf/MnYPCQXw102C4j3ziJ6yEDRAT2ewptBuDtMszXgxL
         yZFivTk1XrWpk1MlV+WG4iVppCJlzhl/sRoLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963429; x=1763568229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1htTvmHhSS7PxGLOxYsNqzuoZBJcNttW6OTDvCLzFk0=;
        b=EH8dYoN4vph1KmYLES/oF8by/tJZYDeo5qmXGsNfUTAEEf7avDQRCjQS1GqAjOidt7
         UEwKBM3sIarmbKaiRta7zEYe+b1a7KcNSccSJQA3dEzZqEdw7G0UL7h8rE1AOq8wfXsY
         VedYmQFsFQFQuC+2ogR25Pu5Uul5CEe5/qatxKRAV2VqnM0liIUWdM+1C1734uuyOB5L
         GGPPujFcvMs7/8lI9QM5a3q7x3kz2AF6RBkerDmJ/9RLTuXJZnY+XKkY8CTFf+D4BH/K
         cPgdlfledIHnuN0fg2nSd3pyynXtxZteimkAHekhMHlrYLIib+A+q5VL6JF4+kJwi3SZ
         hZJg==
X-Forwarded-Encrypted: i=1; AJvYcCUOhp25r6DW0XJA0Pi9brxkOIuE061/UM0Pq/iMuY90/x3sUsbiffFnsA2CvTG66gUouGUTuoRKCqSkmkcc@lists.openembedded.org
X-Gm-Message-State: AOJu0YybbgrYF5zCkaLNHrM9JLkDW8h0K+V7OTCwMjpFK4BNsiMrr3cU
	ybHNvm+0V4rqqub/wLqwpwzTGXlnE5emJI30LhpnxjwzX++MwlBD3P4Mn3czYkx/d3v1G+dEYSq
	28BhxGoW45eU1m/7caotjZnSFgvpMFZuV9DuTz4hAqQ==
X-Gm-Gg: ASbGncuCHJBz9gggZ06oCjixTCtSltLgjMhsI5W1ZJdbGzOMAwn6qriPwITnarzBH0i
	wYah4A1yPPXYaMWpMaFY82Ngp1NMk69QZqOrd0+Zo9L9+7tGVwswEnCbWrt53Zhm/GTffEHXNmz
	ANlWVSQ4mrs3iRrIg+kfZRZyYd7NVM1UfQ7rZONyA92oR2rLu34yWeq9p/SML3s/tawlWa7PQZo
	R3nMAikdRGUPiaEOZ5wX4D3Aj0G3P3SSEPNyhqfyFSlfNX9dpQXxAOR2S3CSk8=
X-Google-Smtp-Source: AGHT+IHd5PmpqE8zkXy/KUW3buwt2upMCHzCHzNgxG/zU3FiWrBJYJLFqh4USV5yeX2jOpt735hXhboqOGuroizHJis=
X-Received: by 2002:a5d:5f53:0:b0:429:d565:d7df with SMTP id
 ffacd0b85a97d-42b4bdb81bemr3572632f8f.42.1762963429057; Wed, 12 Nov 2025
 08:03:49 -0800 (PST)
MIME-Version: 1.0
References: <f0f7ae6b-33f2-402a-86f2-4714f07af30e@emlix.com> <6c4906cefa9846025d944edc02351bcfc9f3f42c.camel@linuxfoundation.org>
In-Reply-To: <6c4906cefa9846025d944edc02351bcfc9f3f42c.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Wed, 12 Nov 2025 17:03:21 +0100
X-Gm-Features: AWmQ_bkEumEUXJ0FSbVGJlOa-NHB1Trri9lYkVRW2uqcwtCqPyHjXiRodfWEJf4
Message-ID: <CAMSfU+7hRY=bM66NTyEvzbCsYT3R4z8XHT+eiifhEBTmHXTjjg@mail.gmail.com>
Subject: Re: [bitbake-devel] Combining PREMIRRORS and downloadfilename with wget
To: richard.purdie@linuxfoundation.org
Cc: isaac.true@emlix.com, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000f0fb0f064367e8b5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 16:04:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18359

--000000000000f0fb0f064367e8b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 12 nov. 2025 =C3=A0 16:57, Richard Purdie via lists.openembedded.or=
g
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> a =C3=A9crit =
:

> On Tue, 2025-11-11 at 16:55 +0100, Isaac True via lists.openembedded.org
> wrote:
> > I'm experience some confusing behaviour when trying to add PREMIRRORS t=
o
> > use an internal proxy for source files fetched over HTTPS, and I'm
> > wondering if this is the intended behaviour or if this is a bug.
>
> It is a known bug. It was mentioned in the weekly status reports for a
> while.
>
> Basically nobody has been able to find the time to dive in and unravel
> things to make everything work as it should.
>
> There may be an open bug for it (I hope!) but if not we should have one
> open.
>

Sounds like
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15126


> We may need to introduce a new parameter with different semantics and
> remove the current one to properly solve it, going from memory.
>
> Cheers,
>
> Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18357):
> https://lists.openembedded.org/g/bitbake-devel/message/18357
> Mute This Topic: https://lists.openembedded.org/mt/116240177/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--000000000000f0fb0f064367e8b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mer. 12=
 nov. 2025 =C3=A0=C2=A016:57, Richard Purdie via <a href=3D"http://lists.op=
enembedded.org">lists.openembedded.org</a> &lt;richard.purdie=3D<a href=3D"=
mailto:linuxfoundation.org@lists.openembedded.org">linuxfoundation.org@list=
s.openembedded.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, 2025-11-11 at 16:55 +0100, Isaac T=
rue via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=
=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; I&#39;m experience some confusing behaviour when trying to add PREMIRR=
ORS to <br>
&gt; use an internal proxy for source files fetched over HTTPS, and I&#39;m=
 <br>
&gt; wondering if this is the intended behaviour or if this is a bug.<br>
<br>
It is a known bug. It was mentioned in the weekly status reports for a whil=
e.<br>
<br>
Basically nobody has been able to find the time to dive in and unravel<br>
things to make everything work as it should.<br>
<br>
There may be an open bug for it (I hope!) but if not we should have one<br>
open.<br></blockquote><div><br></div><div>Sounds like</div><div><a href=3D"=
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15126">https://bugzilla=
.yoctoproject.org/show_bug.cgi?id=3D15126</a></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
We may need to introduce a new parameter with different semantics and<br>
remove the current one to properly solve it, going from memory.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18357): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18357" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18357</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116240177/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116240177/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000f0fb0f064367e8b5--

