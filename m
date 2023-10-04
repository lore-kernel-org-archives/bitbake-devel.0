Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7AE7B5EE
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:03:59 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web10.15613.1696417433426759781
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Oct 2023 04:03:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=QIRjSm+Z;
 spf=pass (domain: snapchat.com, ip: 209.85.208.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so3319842a12.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1696417432; x=1697022232; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7D8UkGkTJKT/2e1eMEl1vu8XtUBrRVj603ptk0W+lnw=;
        b=QIRjSm+Z4rd+UTCgU8CLqr2qhIdgOI+MOdoSLSmRBLr8eByJeCZxV4ZVt99ljQHuGt
         feSA+DxQYFjVWAOYOLkCZ+vaouCn3MU5Xs4fUAToeQ3h9bTwhC4Cbs7KhrH8kmInzgZe
         NaVcPQU/TcYM8E65JJMP0KM/QaFLAU0XVK5ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696417432; x=1697022232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D8UkGkTJKT/2e1eMEl1vu8XtUBrRVj603ptk0W+lnw=;
        b=jdozhBlxBnRysKRqWIk2V9sKL7T/NDK7CqaLsPWUNdo08gk/S46WT6ZHzTKcAJF9/q
         UEEYaNCZ6FS8Lqk4wzb6WFrDLPUexIuIKc9CTnCpxP0NPcPlyaiJO/xeoiit6UlULFBW
         U1aHpPjJIJJXYDk8tGSYyG1Q9iYNm1pA12uh3yBEL87Q/nb1x/z+7O62hoKEIAjSd5id
         MyKumhAhMBEtZExRrtRS4+mhToavps/KDKD/X1w0kSkQAD1D48Q3Ws57M6A+HvQCG2F4
         lOCq8+clzhQDl8ZVyGhKkB7Z03uWMWzfcPfK+woGQY/gwy8y8+JiDhku9iysWcTNEiAr
         HMXQ==
X-Gm-Message-State: AOJu0YyEI8UJ9K/Ax7WzSY5LQW6HI7rdUhOIka1Gg9kw11uqF/wMgwTi
	Gm+LxshGpy+2j0LY8V8/2e3B+WjjOHNxuwGnvEuhCQ==
X-Google-Smtp-Source: AGHT+IHoRTfm2jqezreqIfDMQsAKY91QlO+K4Cr5If7XZLAEmbR0wARMfBNE7NKUEskjLjyUu34Zzoodrm/7PPmiEgQ=
X-Received: by 2002:a17:906:105e:b0:9ae:654d:5105 with SMTP id
 j30-20020a170906105e00b009ae654d5105mr2003317ejj.47.1696417431710; Wed, 04
 Oct 2023 04:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921075658.509846-1-ecordonnier@snap.com> <0d94ff1c8efe8d37471f3c0bfe09403a7d8c5af8.camel@linuxfoundation.org>
 <1786E57180396CF1.29236@lists.openembedded.org> <CAHUKmYasZWwwZ_QZmd0WvFx=mE8na+0OCn3ddS1zNCp_O4rRBw@mail.gmail.com>
 <1eb0d3b2f485a10a776ad1c136b1d5fc62228efd.camel@linuxfoundation.org>
In-Reply-To: <1eb0d3b2f485a10a776ad1c136b1d5fc62228efd.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 4 Oct 2023 13:03:40 +0200
Message-ID: <CAHUKmYYnZejxEBVqWufniLc+piHmek3z1EbdYqRCJYy-GVq2-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH] bitbake-worker: add header with
 length of message
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006911630606e1f6bf"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 11:03:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15183

--0000000000006911630606e1f6bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
OK, no problem, I just wanted to understand the status of the patch.

--
Etienne

On Wed, Oct 4, 2023 at 10:17=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2023-10-04 at 09:43 +0200, Etienne Cordonnier wrote:
> > Is the patch OK? I think it should be merged independently of whether
> > the amount of data sent through the IPC gets reduced or not.
>
> With this one, I'm not sure. We're in our feature freeze and there are
> a ton of problematic issues which we're struggling to get to grips
> with. Given I'm not 100% convinced that we should change this, I don't
> feel it is a good time to change this.
>
> I really don't know whether it will/should go in after feature freeze
> or not either. I appreciate you'd like answers on that but I'm
> struggling with the bandwidth to give everything the time they need :(
>
> Cheers,
>
> Richard
>
>
>

--0000000000006911630606e1f6bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br>OK, no problem, I just wanted to understand=
 the status of the patch.<br><br>--<br>Etienne</div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 4, 2023 at 10:17=
=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfounda=
tion.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, 2023-10-04 at 09:43 +02=
00, Etienne Cordonnier wrote:<br>
&gt; Is the patch OK? I think it should be merged independently of whether<=
br>
&gt; the amount of data sent through the IPC gets reduced or not.<br>
<br>
With this one, I&#39;m not sure. We&#39;re in our feature freeze and there =
are<br>
a ton of problematic issues which we&#39;re struggling to get to grips<br>
with. Given I&#39;m not 100% convinced that we should change this, I don&#3=
9;t<br>
feel it is a good time to change this.<br>
<br>
I really don&#39;t know whether it will/should go in after feature freeze<b=
r>
or not either. I appreciate you&#39;d like answers on that but I&#39;m<br>
struggling with the bandwidth to give everything the time they need :(<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div>

--0000000000006911630606e1f6bf--

