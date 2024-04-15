Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A7C4345F
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 17:17:14 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.1074.1713201430714465203
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Apr 2024 10:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NSADD8jP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.46, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d264d0e4so4521146e87.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Apr 2024 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713201429; x=1713806229; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mCw5hMLZhHfY/Ga7RYyWsYrl8LgCCSpVntAzxEUU2U=;
        b=NSADD8jPTDKbx0r7FCEeWjMmiqQy53lRFQ3NUI7Rp6AVjlz1EPeEySkAso2htuiIFx
         9WhjUr1kE+oNueuPIAzbx9d0FsWWNZVcet+LGcIxUJDiCQYhnzGTtlgTetymSLNdJViH
         1XDNxlp8jD8lJ28Rfc0+0U8KaW2szaLQVDuDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201429; x=1713806229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mCw5hMLZhHfY/Ga7RYyWsYrl8LgCCSpVntAzxEUU2U=;
        b=E2LLuBu6YS6AsB3hawuZn0YGd+yhChphkMpvN/260pmlAjjxZF2f1YYXREYmZl51uU
         MGyGWhwYAPhZqYMBk4c4iqfPvhZO09tVJSbO4U9tTcVexU9bDZcVdJeRp/bOsJzqnBS2
         5kx4n2wwqoy5aEkngQYY7JQWbRBoBV8mnsWt91f7YCwq0DjcB4aiHsD0biWxQCtG92sq
         uquc+npaUloO04FLCzGca/woIi2GmIcSUG3hZaI9y9QjF/BkZxNdg5pdByrpuVur7Fbl
         09ddfWPPPmTA6T0a4FV89pV6mPHsinQ2Ym9cNXpPjuKGMZbKvFmVg8zbAa9SA9vKBrDR
         kEcw==
X-Forwarded-Encrypted: i=1; AJvYcCVKDo7MlwvHf7ja8kc/xHbLbP8uvUMsCRVOdtLIpOPJyv2mHo6gmKZVT34XRKCjEOyTAsnCIIS2SEjrltsSJKu5SI9VCWFVeS1uHOzRSpFLkSA1e8E=
X-Gm-Message-State: AOJu0YzitIft0V36AORi+47S+qKcXq6hHuihwHWffRuikwYnRdLPrfuH
	9Zyp3DviAJK9avQJKGGPlFKb6cAnRHUARqJZgTScKV6Y30gEpnbPQDQRrfkfjD44CbbghRXmhoB
	SNJ/lvrRE25ocvyE8AmKHBIgbmat9vQiQv5L9GA==
X-Google-Smtp-Source: AGHT+IF2NNlefDqqVTg3/DRE90q1cscrUTeioGpN8JtaM38h5HerXl0xD3J8b98TQrxEeVnkJxvxwMY0QY2fLP/XZe0=
X-Received: by 2002:ac2:47f7:0:b0:518:a315:26c8 with SMTP id
 b23-20020ac247f7000000b00518a31526c8mr82931lfp.11.1713201428637; Mon, 15 Apr
 2024 10:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <17C611708D6AA374.8361@lists.openembedded.org> <0a26e1afe4f043570c7b94b0a818e4ce77a43d26.camel@linuxfoundation.org>
In-Reply-To: <0a26e1afe4f043570c7b94b0a818e4ce77a43d26.camel@linuxfoundation.org>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Mon, 15 Apr 2024 10:16:56 -0700
Message-ID: <CADfgfoYX=z5UG3iPpfuEv+SD+wDCEt3fxUQ=v8zpMGRGbNnNQA@mail.gmail.com>
Subject: Re: [bitbake-devel] One remaining hashserv issue - bitbake-selftest
 failure on some hosts
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000954bda061625ca21"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Apr 2024 17:17:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16096

--000000000000954bda061625ca21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've upgraded websockets to version 12.0 on all hosts except for
alma8-ty-1.yocto.io, stream8-ty-1.yocto.io, and ubuntu1804-arm-1.yocto.io
which have older versions of python and only support websockets 9.1.



On Sun, Apr 14, 2024 at 2:08=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Sun, 2024-04-14 at 07:24 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > We've managed to get most issues resolved, thanks!
> >
> > I think the one remaining puzzling issue left are these:
> >
> > debian11-ty-3:
> >
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6583/st=
eps/11/logs/stdio
> > debian11-ty-1:
> >
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6586/st=
eps/11/logs/stdio
> > ubunbtu2004-arm-1:
> >
> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/3182/s=
teps/11/logs/stdio
> >
> > I think these have only appeared since we changed the websockets
> > presence on the workers and it appears host specific.
> >
> > We've seen this issue with master (which Joshua's changes unmerged) and
> > on master-next with Joshua's patches.
> >
> > Ideas welcome...
> >
>
> Its worth noting we started seeing these on specific workers when
> master hadn't changed and we hadn't enabled the new hash server. This
> means it is likely the installation of websockets on the workers
> triggered the issues.
>
> Cheers,
>
> Richard
>


--=20
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

--000000000000954bda061625ca21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve upgraded websockets to version 12.0 on all hosts =
except for=C2=A0<a href=3D"http://alma8-ty-1.yocto.io">alma8-ty-1.yocto.io<=
/a>,=C2=A0<a href=3D"http://stream8-ty-1.yocto.io">stream8-ty-1.yocto.io</a=
>, and=C2=A0<a href=3D"http://ubuntu1804-arm-1.yocto.io">ubuntu1804-arm-1.y=
octo.io</a> which have older versions of python and only support websockets=
 9.1.<div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 14, 2024 at 2:08=E2=80=AFPM =
Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">ri=
chard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Sun, 2024-04-14 at 07:24 +0100, Richard=
 Purdie via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> wrote:<br>
&gt; We&#39;ve managed to get most issues resolved, thanks!<br>
&gt; <br>
&gt; I think the one remaining puzzling issue left are these:<br>
&gt; <br>
&gt; debian11-ty-3:<br>
&gt; <a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/80/=
builds/6583/steps/11/logs/stdio" rel=3D"noreferrer" target=3D"_blank">https=
://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6583/steps/11/=
logs/stdio</a><br>
&gt; debian11-ty-1:<br>
&gt; <a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/80/=
builds/6586/steps/11/logs/stdio" rel=3D"noreferrer" target=3D"_blank">https=
://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6586/steps/11/=
logs/stdio</a><br>
&gt; ubunbtu2004-arm-1:<br>
&gt; <a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/127=
/builds/3182/steps/11/logs/stdio" rel=3D"noreferrer" target=3D"_blank">http=
s://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/3182/steps/1=
1/logs/stdio</a><br>
&gt; <br>
&gt; I think these have only appeared since we changed the websockets<br>
&gt; presence on the workers and it appears host specific.<br>
&gt; <br>
&gt; We&#39;ve seen this issue with master (which Joshua&#39;s changes unme=
rged) and<br>
&gt; on master-next with Joshua&#39;s patches.<br>
&gt; <br>
&gt; Ideas welcome...<br>
&gt; <br>
<br>
Its worth noting we started seeing these on specific workers when<br>
master hadn&#39;t changed and we hadn&#39;t enabled the new hash server. Th=
is<br>
means it is likely the installation of websockets on the workers<br>
triggered the issues.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Michael Halstead<div>Linux Foundation / Yocto Project</div><=
div>Systems Operations Engineer</div></div></div>

--000000000000954bda061625ca21--

