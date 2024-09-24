Return-Path: <simon.eu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770ACF9C71
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 09:06:12 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.9275.1727168770565992812
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Sep 2024 02:06:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FUFM3Uzq;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: simon.eu@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2db928dbd53so4139500a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168770; x=1727773570; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0sG+3eHKwjiQZBaL10tzSMwuP4mL6bW/PbbTdL6lU8=;
        b=FUFM3UzqIFu21K/VgtUXNird8aYXdYsIFFOQ9/RvqhngHdLVARXCwT8IxGD9i3zGpg
         BcW3eSKbouSXwcJLUBl2X+ZQZDnAIm0TKvmEJ8vvhoKTsm9klP1N8NE7v1p+4LwJmOgG
         Ztj13wSoYc+ytY5DxEDyChRi3WQFrEzVKARg56xYnqDKCnukBEL+Tysv6sIMUWYiuSln
         5jYgJ+MJ1T06IIDvkn+pfdAkV4IynizrjGoFFna/l4HtjnCAssEpVIyvvBvjYlZSzD2u
         Jv3zkvShAuzYu0n6olCdqyIYPPkbINNnPSNxL+AXKI1PdK2qlBIijCch11C4mtNm/fdt
         VHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168770; x=1727773570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0sG+3eHKwjiQZBaL10tzSMwuP4mL6bW/PbbTdL6lU8=;
        b=fX8pO92nUzWZPScuVuDiQ038hGUT2G1DpcCl/e6gq3VM2tEKW6oDAkFUlAmcZTpxVl
         a1cC6l401KnpnGghaLKSjxh1dKxqAYrD7K65eAKvMT1DOS1i88+LFYIwMWv0g+9t0icM
         AS5Q22BZe2TMJ6PPr+o0Uhunfmu46CCYikao1BXOfjoHbgVg0DMSLfXJwvDpBKeTN5w/
         +FaKA7feIXiP1c0cAHFUS1mQiunck2n6r2OGhhyICjKCKQDfK2Teq15YLcx5zM4vYGNm
         9OS8FI50Uh9yBKdLzBZcTczAc8YyagJVnMdz69VP0v7hGOEqTiOgtvQ9PyX3Pv9rB/6o
         TgDw==
X-Gm-Message-State: AOJu0YxsrGuFmPLNxUmbdbDN+u7QCe9LOLdZFIhnDRZcnYZUnmeo1jg1
	nnsPVa14OynvtC/lFyaA2iWsbMdGwGlc3CSaLNPRPT/biwwsy1qxBlHW5iAb48VARyu93TvxvEl
	joNwH9oJt6Kal5COcocWPAcfnlVw=
X-Google-Smtp-Source: AGHT+IHu56Ncza2tQ3hP+2c6kDacpNjNiDN6+w3GcCsT7y+EX+3PjOvpbXO/ZNIum+c722dkwa7Qk4RBhaTX+5pO+EI=
X-Received: by 2002:a17:90b:1643:b0:2da:9dc7:add2 with SMTP id
 98e67ed59e1d1-2dd7f71aca7mr17609362a91.26.1727168769821; Tue, 24 Sep 2024
 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240920124020.2894006-1-simon.eu@gmail.com> <20240920124020.2894006-2-simon.eu@gmail.com>
 <5eb7e737-37e9-4d6b-811e-4fc121dd6567@cherry.de>
In-Reply-To: <5eb7e737-37e9-4d6b-811e-4fc121dd6567@cherry.de>
From: Simon Eugster <simon.eu@gmail.com>
Date: Tue, 24 Sep 2024 11:05:58 +0200
Message-ID: <CAO8d5Bbk=VNHKG_xKcbD1=nKYeuEODQfUrmLANHqKgcyDiDOMg@mail.gmail.com>
Subject: Re: [docs] [PATCH 1/1] bitbake: doc: suffix for BBFILE_PRIORITY
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000fe185c0622d9d0f8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 09:06:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16596

--000000000000fe185c0622d9d0f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

thanks for the feedback. Will do that for the next patch!

Simon

On Mon, Sep 23, 2024 at 11:32=E2=80=AFAM Quentin Schulz <quentin.schulz@che=
rry.de>
wrote:

> Hi Simon,
>
> On 9/20/24 2:40 PM, Simon A. Eugster via lists.yoctoproject.org wrote:
> > [You don't often get email from simon.eu=3D
> gmail.com@lists.yoctoproject.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
> >
>
> Please try to always have some commit log to explain what's going on in
> the commit. It is useful if one does `git log` without `-p`/`--patch` or
> if additional "metadata"/context to the code is important. E.g. here,
> you could have said that you were confused by the use of the underscore
> instead of the colon so you are now making this explicit.
>
> I don't think it's warranted to send a v2 just for that, just think
> about it for your next contribution!
>
> > Signed-off-by: Simon A. Eugster <simon.eu@gmail.com>
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin
>

--000000000000fe185c0622d9d0f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Quentin,</div><div><br></div><div>thanks for the f=
eedback. Will do that for the next patch!</div><div><br></div><div>Simon<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Sep 23, 2024 at 11:32=E2=80=AFAM Quentin Schulz &lt;<a href=
=3D"mailto:quentin.schulz@cherry.de">quentin.schulz@cherry.de</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Simon,<br>
<br>
On 9/20/24 2:40 PM, Simon A. Eugster via <a href=3D"http://lists.yoctoproje=
ct.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a> wro=
te:<br>
&gt; [You don&#39;t often get email from <a href=3D"http://simon.eu" rel=3D=
"noreferrer" target=3D"_blank">simon.eu</a>=3D<a href=3D"mailto:gmail.com@l=
ists.yoctoproject.org" target=3D"_blank">gmail.com@lists.yoctoproject.org</=
a>. Learn why this is important at <a href=3D"https://aka.ms/LearnAboutSend=
erIdentification" rel=3D"noreferrer" target=3D"_blank">https://aka.ms/Learn=
AboutSenderIdentification</a> ]<br>
&gt; <br>
<br>
Please try to always have some commit log to explain what&#39;s going on in=
 <br>
the commit. It is useful if one does `git log` without `-p`/`--patch` or <b=
r>
if additional &quot;metadata&quot;/context to the code is important. E.g. h=
ere, <br>
you could have said that you were confused by the use of the underscore <br=
>
instead of the colon so you are now making this explicit.<br>
<br>
I don&#39;t think it&#39;s warranted to send a v2 just for that, just think=
 <br>
about it for your next contribution!<br>
<br>
&gt; Signed-off-by: Simon A. Eugster &lt;<a href=3D"mailto:simon.eu@gmail.c=
om" target=3D"_blank">simon.eu@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.de"=
 target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
<br>
Thanks!<br>
Quentin<br>
</blockquote></div>

--000000000000fe185c0622d9d0f8--

