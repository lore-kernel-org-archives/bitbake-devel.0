Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9778D6910E
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 13:37:27 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web11.94973.1732801042479524434
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Nov 2024 05:37:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Qwxag41q;
 spf=softfail (domain: sakoman.com, ip: 209.85.128.179, mailfrom: steve@sakoman.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eed41d2b12so6772007b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 05:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1732801041; x=1733405841; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yeGtNzFT08WZOq3uxdm3jqnrkAWg1MGJEnOMbOXFCc=;
        b=Qwxag41qRjUwnZA/zoHFfpb1xbHckeEJL4wfpOQn2XD6b5yyyLpXpgghzY3knHoUmw
         9+w6G+WKBPUAe4CMnunyS9p6LWH+ZutjOTUO1jT3h44YcuD7iwNDYYSnVksfwSV9wn3v
         c8ptI2xif5UT/2aBH9FWojJ+Xt4JAlkGENOkNFCR23esHrKIjh4nCQ6/qpYGf84K4fa5
         cF+QHIuvuCeHb77y8/g8bN7K8cGHPZXZIUtDRV3C8NoCRDuIw/0DFQGhhDaM1Z3xQNqe
         jBiW79y+6/7tCce3+m66T+7fUu2F0BToYjPH+t0sSyzQ9ffMYjfj9g9LPT+tYgFzvAZ0
         Y8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801041; x=1733405841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yeGtNzFT08WZOq3uxdm3jqnrkAWg1MGJEnOMbOXFCc=;
        b=BEJ7u6psYOWZ02lazQRtAYQMwHHzXMxGf5BRAwP5fy2kdg5i0PisJCQ8ZJVFLVDJFG
         W3rcpLFaQiKXaZLbCSttuYAJDRB8tMgG8VzXR3QWqHXqL2A5DjDSYZHKoW+UkogFEavN
         vM0U6ImwEyxjXtsceW1CaNiBN+eC68kzDTJmyIri11DCVz5Bzj/sXl+JyRye+XT7s4ts
         FmaOJTi6al4yrjQ3gmvsZns9HfSXMZwE4NAyFE1E+lSUQMEZFoNC0yZjZ7jnhRs/EOG6
         5FCUuPtGObMUpRN4seah7E9E1Z/IYGsJ9jOz7+KwdRXhalRgR8h6oYaS62JSbF1l1OWE
         32PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhpbNu4NrIghpE2W6YViwMELdJ7ibXPqHpTBDZT4wmYKQEM2wQ4aNJsWByzXJu3Ix/6eaz4wjl8N8k4+nZ@lists.openembedded.org
X-Gm-Message-State: AOJu0YxnASmpP55V21BrE4xQlj/yIm6JWHfqLKghU94t/krW1RaY8j62
	tW55zXmLFW6Af6v+A9zWGPnYd6cOO5/PtGjidRuXPoA3FExmoTOb3OgsF3G72Gjy/edcrYFjLBU
	+906ltdFhLXMhaqNiZrp7BOEOudc0DEdzF71iAA==
X-Gm-Gg: ASbGnct/PtbcQYSAVPB0L4wTd9U7CTRFcdpG7357U+3/H8ULxVuu87EA2Ba+Ao1yY5s
	g0w3O4m62N7EWp282pJEc7XzIebXx94U=
X-Google-Smtp-Source: AGHT+IFinl5fPj+L3QeDwy03e75il+8hAcqqrA0VHUH0UmSp5umxkWvIK6UG57EGTdi6RqDwKzJS1BcL37ds0D0W0i8=
X-Received: by 2002:a05:690c:9b0a:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6ef4a14f5eemr25317927b3.15.1732801041617; Thu, 28 Nov 2024
 05:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20241128081341.2190513-1-martin.jansa@gmail.com> <3ea5c511a8f0dcb930de62ae60cfd7ed0c6e00d2.camel@linuxfoundation.org>
In-Reply-To: <3ea5c511a8f0dcb930de62ae60cfd7ed0c6e00d2.camel@linuxfoundation.org>
From: Steve Sakoman <steve@sakoman.com>
Date: Thu, 28 Nov 2024 05:37:10 -0800
Message-ID: <CAOSpxdbB+KSOAjwrnNSZu0RwCpzN77U4ff0J3T7dVMM-VLs5kg@mail.gmail.com>
Subject: Re: [2.8][PATCH] fetch2/git: Use quote from shlex, not pipes
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Martin Jansa <martin.jansa@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 13:37:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16847

On Thu, Nov 28, 2024 at 3:34=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2024-11-28 at 09:13 +0100, Martin Jansa wrote:
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >
> > The pipes module is removed in python 3.13. It was already using the
> > quote function from shlex so use that directly instead.
> >
> > The module already imports shlex too so it is an easy substitution.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/fetch2/git.py | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> I've put that on the branch and will let Steve pick it up from there
> for poky.

Done!

Steve

