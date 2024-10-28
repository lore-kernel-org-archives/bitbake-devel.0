Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF3D33996
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 15:16:41 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
 by mx.groups.io with SMTP id smtpd.web11.54226.1730128591681009698
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Oct 2024 08:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=sTuVlftj;
 spf=softfail (domain: sakoman.com, ip: 209.85.219.181, mailfrom: steve@sakoman.com)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so4494743276.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730128590; x=1730733390; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpttrnDELEXikNlANx2Q02EtfcugjwPi4+Ac2cTUDe4=;
        b=sTuVlftjnnoriscc42NYhFWO5veRXQn/Yk2BO5hHhmr9tfrnmOMwZayJrKpKfKewBC
         ez4Q7zmqYINxv7nwfAgnG+cVa9tj+l0IkV3L29pNaHeXS6t0tMstkRxNA79UGnCxxqQQ
         KrsFqP7rGgWjzM58JIQ2js1aj3JrhoDiFI2OE+l+YMI0Ksaflk9j29beBtyfPhfFd666
         iJRXmRDSqJ2ZTVIE2QIZ87b0EXOoSTyhuyxUJMsw11M3fZ3xkTqY4zxAWNkfgMygtaYC
         EzW7h+IGWZNfToicIib3zU/27dHTYIhRxSWE4RWWSATv1LzLSZLKVLKMKjzGMkDDfYXC
         uN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128590; x=1730733390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpttrnDELEXikNlANx2Q02EtfcugjwPi4+Ac2cTUDe4=;
        b=MNgJuZ8PninussNNxK++RDQLf4SyDQ1QjnUag/w+KAsT4yGsYOqFZJa3ZfXtb/6LRT
         P60UFjhJ9j83RS1JlzqsvPjI7TX+KHH7/52VRs2YL99e37Si9kmT3C3yKTO6KiuL5SOv
         FGbUZT2OLXs1TENNXHLi2l5ze2w/dgEasFvqQ3iGBGRuS2GBhlL9ncVxpW/+EktesNTq
         eMdyqFMw0nDNBe7N+x4dTDkqjcDVfl+o/Qv2SEY84Sc3v6+fdeVfibwSOuSXs/GWs1nl
         EXviP9FCTF232BEmRePKjv6S/B54006hxKBD2OJUn6bEPkHJECcoro3VF20wR3AZTZAo
         VFzg==
X-Forwarded-Encrypted: i=1; AJvYcCWbU4xPzCzGnNbqwDL/JLI+XMA79IfOYWcxRFN16jFNb/Cq1dxRmKpkDOJLPmXv0Muz77eVaJ66HoALAH4b@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxa7uSWoRHHgjFJ4nTmon2+9AlqSazNyhOvZQrbGirjcmTa1at9
	s2KuViAK+e3MJYkoAIBfK2BqnLnCWUeBshK5Nrjtlk8fuMxykW85VAB+rFXsrc2RuUcN3Q1eIo3
	ltF+f8IlmpYaEo79jMdaM3rWugITQtVqrTy1aBU/UxmsrLOpTfK8=
X-Google-Smtp-Source: AGHT+IFsJqTdGJPcDJOmMd7Zf82BQrFSmfX8B/aeI87T4d71NEp1ssdwd6pYD0U3lCn7acmH9XbhG9/8pFf80Cd8ojo=
X-Received: by 2002:a05:6902:2b0b:b0:e2e:35db:9b94 with SMTP id
 3f1490d57ef6-e3087bfd514mr7694763276.39.1730128590590; Mon, 28 Oct 2024
 08:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729933869.git.liezhi.yang@windriver.com>
 <c4e94db7e266f90dde06cd7d0e73dd3b035e121f.1729933869.git.liezhi.yang@windriver.com>
 <d122bfdf0fc1684d7aea91f3020e2037cb95356a.camel@linuxfoundation.org>
In-Reply-To: <d122bfdf0fc1684d7aea91f3020e2037cb95356a.camel@linuxfoundation.org>
From: Steve Sakoman <steve@sakoman.com>
Date: Mon, 28 Oct 2024 08:16:19 -0700
Message-ID: <CAOSpxdYyvjS7T8pTPgwYd+iH4GhXkB_MiqFPaaeG3ybF1ujz1A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/5] gitsm: Remove downloads/tmpdir when failed
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 15:16:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16738

On Mon, Oct 28, 2024 at 7:06=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Sat, 2024-10-26 at 02:39 -0700, Robert Yang via
> lists.openembedded.org wrote:
> > From: Robert Yang <liezhi.yang@windriver.com>
> >
> > The tmpdir such as downloads/tmplp3cnemv won't be removed without
> > this fix.
> >
> > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>
> Thanks, I've been meaning to track down the cause of those!
>
> Steve: We might want to consider this to help the autobuilder.

This won't apply unless I also take gitsm: Add
call_process_submodules() to remove duplicated code

I've added both to all three stable branches and will test when the
autobuilder is usable again.

Steve

