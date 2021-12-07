Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C7C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Dec 2021 11:38:53 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web10.65989.1638877132253420943
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 03:38:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=m/dEuOeX;
 spf=pass (domain: gmail.com, ip: 209.85.222.44,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f44.google.com with SMTP id l24so25955885uak.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGeaFiI6Ud6ohPFa6JufEM1PZk4vxE8uLbJdlhmnbM8=;
        b=m/dEuOeXp9O2EDsOm6R1hnhKBHZU42I6jxscJfeIlRI3C6T/hyv8s7W5iCEAkuQcYc
         logQEYdQHpJ09fRgNJtrvQN3dBNTQvA064pTU3+hGCrEv2XbUV5HFfXtbcyz9jw1zhlJ
         bZCPRpEoBMRcGysambxlHCQi/GWW3gtSTfETO4gZSUMPiUnPKYJQel6+vJnKh9STIUuF
         3Y03BQezQXDUFIM8sno5ftoyLlNQpn6wJ/tWP/FsaiwKQkBxWITJBeFFkfZbBZKndjuv
         VKeeG7FjgZO96/HBg5zrzZ487wkEKOB33TKTRfAdpfijgro1vfZY0YmpoV/5maCjOcck
         mT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGeaFiI6Ud6ohPFa6JufEM1PZk4vxE8uLbJdlhmnbM8=;
        b=lJRWFpPyKvC8k0GLwtIkK7Es5EAhOVVU2IJdY4BjIyBaCGDY1zXq1u4uXeVe5jtEW5
         RCOkVv16gqh22zVu4M3tjELwjqex3Npq2yaj2bU8wS3+FwnVu6tMwvIi8KupoibQK0GE
         eceFGvKus7nY4NN8L0mVm+lU88CGvGhWE7Y2Ez2kFp0MYJU7RgY2r9EiKZWYOM+ajQVi
         B/ckwOZEgZkvf77mcyjHYcohIwjjlmV30m2vL1bMP1ElTP1jHEQCYsZGjEgg1p797W/V
         yB4oGQKTx/61m9Znei0wX4jsUIXHczPhhGB8jiJi5j26AwurY7vgzV0r20gcJpvzl62e
         ey2g==
X-Gm-Message-State: AOAM5305FLRqog5liMyWcWgTxXk1zw6gSNh5qvFX5DLGhBbZRRy4pcG6
	Hhxc+udbiGLdda9C1grlV23AEh4mJYRtbUS4Ji0=
X-Google-Smtp-Source: 
 ABdhPJw2FtCBevpR4+F0kR/jHeItBfYBOtxaEw9JsEibvm4pMhvfmB3DVwZ9Qm4hMSNDLaJ8lPI7pcjSrfPOzu8QsQY=
X-Received: by 2002:a05:6102:3232:: with SMTP id
 x18mr43503796vsf.38.1638877131375;
 Tue, 07 Dec 2021 03:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20211206164119.4076119-1-alex@linutronix.de>
 <4ff493233f785384ac845b2b712388155a328bab.camel@linuxfoundation.org>
 <CANNYZj-=TU6QNRDE4u13cc28F_PxnzCeMSd7txRh6N2pMTmspw@mail.gmail.com>
 <3600232f440e8a1a1caed9a57f0105a02f38e6df.camel@linuxfoundation.org>
 <16BE7582F291F13E.1024@lists.openembedded.org>
In-Reply-To: <16BE7582F291F13E.1024@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Dec 2021 12:38:40 +0100
Message-ID: 
 <CANNYZj_iDvKzLH-+v7yFksEz7t3+gLC6asDoqGVOaAMeQEg-0Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: do not hardcode tarball
 compressors in version check
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000003f076205d28cd1fd"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Dec 2021 11:38:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13141

--0000000000003f076205d28cd1fd
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Dec 2021 at 12:28, Alexander Kanavin via lists.openembedded.org
<alex.kanavin=gmail.com@lists.openembedded.org> wrote:

> I appreciate we can't cover everything, my worry is that if we change this
> code
>
>> again, we may lose this corner case...
>>
>
> The issue was that orig.tar.gz was covered by the regex (as it was
> explicitly listed), but orig.tar.bz2 was not. The test already checks
> various .tar.XXX suffixes, so I don't think there's much value in also
> adding .orig.tar.XXX and stable.tar.XXX and src.tar.XXX checks. They've all
> been changed to use \w (i.e. alphanumeric suffix).
>

Let me look again actually,  maybe I misunderstood what the test does.

Alex

--0000000000003f076205d28cd1fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 7 Dec 2021 at 12:28, Alexander Kanavin via <a href=3D"http:/=
/lists.openembedded.org">lists.openembedded.org</a> &lt;alex.kanavin=3D<a h=
ref=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedde=
d.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_quote">I appreciate we can&#39;t =
cover everything, my worry is that if we change this code<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
again, we may lose this corner case...<br></blockquote></div><div class=3D"=
gmail_quote"><br></div><div class=3D"gmail_quote">The issue was that orig.t=
ar.gz was covered by the regex (as it was explicitly listed), but orig.tar.=
bz2 was not. The test already checks various .tar.XXX suffixes, so I don&#3=
9;t think there&#39;s much value in also adding .orig.tar.XXX and stable.ta=
r.XXX and src.tar.XXX checks. They&#39;ve all been changed to use \w (i.e. =
alphanumeric suffix).<br></div></div></blockquote></div><div class=3D"gmail=
_quote"><br></div><div class=3D"gmail_quote">Let me look again actually,=C2=
=A0 maybe I misunderstood what the test does.</div><div class=3D"gmail_quot=
e"><br></div><div class=3D"gmail_quote">Alex<br></div></div>

--0000000000003f076205d28cd1fd--

