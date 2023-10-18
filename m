Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EAC46CA1
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 20:57:15 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.12409.1697662630876453259
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Oct 2023 13:57:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DICFrGLK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3226cc3e324so6459844f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697662629; x=1698267429; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cUBgvkWX6Fn8mwNcN0Xmo7i0eeXGl7dm2ybW0vRWxWA=;
        b=DICFrGLKM0GS2U4Qil7p0UM4xyUIi3ShYeETc7s9q19wKvT7qlr0uH2T4bhOCcrEcF
         sofrXhGA7EXnDvIKb+E+tDgUsxJLtTkkOEnXl0Sb1ukrsYcsxiDyZ+hEoeQYwFpUsWom
         G3jwALl8MyngDvrCXAnLTZhAH6fn9Md16c3UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662629; x=1698267429;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUBgvkWX6Fn8mwNcN0Xmo7i0eeXGl7dm2ybW0vRWxWA=;
        b=hM34VMhMLSDXTtTT9lIZuOb1WqLOKM5V7bZmpi8Mdc73QjSR0Iix9J+T6q3hDO1iDp
         UZysQOAqugkl29yxcPESr7H5AhjzE2tENHljrCN+IoJOavKMPzVUUUvUEEuET9Im92xE
         g4lI8u/Atac6JLRhaZBzg9hVzXEg1alfVZddTq4jA6OOI0eezCZ+O6wMvQNmm0wy5Lty
         Txj6C5GzSyAiGg81VRDXtMBP6OO4LbeZseyEf8CpsoB8c4WwLb912yGnbqsrM0+ZuAzE
         hTcehW/HCH+GDuxQsY4q40SjO5n27o06pgPTVFH9DW7qLgvTGOjfuLPSVUpSccy92Zvi
         McWQ==
X-Gm-Message-State: AOJu0YwRCDVW5pxvtqSb6/FBnYuyfhyIf25kdqjnZKk66MouJfTtxV+4
	8Gkde9HLL6laaum/2AZ+tj9tqw==
X-Google-Smtp-Source: AGHT+IHQbAkioK5MPrpqeB4VZuRNykZ2sFPTO3m4T5bx8Pv4zE29W6NjnVPJh8SCK9FiU0tCQIxX6A==
X-Received: by 2002:a5d:69c6:0:b0:32d:8db5:59ff with SMTP id s6-20020a5d69c6000000b0032d8db559ffmr144479wrw.5.1697662629220;
        Wed, 18 Oct 2023 13:57:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9ec8:2948:ce65:9cfb? ([2001:8b0:aba:5f3c:9ec8:2948:ce65:9cfb])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b0032da87e32e2sm2964878wrm.4.2023.10.18.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:57:08 -0700 (PDT)
Message-ID: <4bf9819abf3e4ee4879f337fc3d9a90a52a627a5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [Toaster] [PATCH] toaster: add tox.ini file to
 execute flake8 and test suite
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tim Orling <ticotimo@gmail.com>, Marlon Rodriguez Garcia
	 <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: toaster@lists.yoctoproject.org, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Oct 2023 21:57:08 +0100
In-Reply-To: <CANx9H-Df7sm427L8pB50CfraS_Grx6Sj_TG-jUXTX9Qw=N3S5A@mail.gmail.com>
References: 
	<20231018194605.2710214-1-marlon.rodriguez-garcia@savoirfairelinux.com>
	 <CANx9H-Df7sm427L8pB50CfraS_Grx6Sj_TG-jUXTX9Qw=N3S5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 20:57:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15261

On Wed, 2023-10-18 at 12:51 -0700, Tim Orling wrote:
> Can you check if you are sending to both toaster and bitbake-devel
> lists at the same time? otherwise I have a feeling we are going to
> miss some communication.
>=20
> On Wed, Oct 18, 2023 at 12:46=E2=80=AFPM Marlon Rodriguez Garcia
> <marlon.rodriguez-garcia@savoirfairelinux.com> wrote:
> > Added configuration file for tox https://tox.wiki/en/4.11.3/ that
> > includes flake8 and the test suite.
> >=20
>=20
>=20
> We do not have tox in openembedded-core and I am reluctant to add a
> specific tool,=C2=A0as it has a lot of dependencies. I am not aware of an=
y
> other python based tools that we author which have tox enabled.

I have been thinking about this a little, I first heard of it on
Tuesday. It seems we need something to execute various pieces of the
testing and in the autobuilder context, there are other dependencies
we'll have to install for testing so the fact we don't have recipes for
it might not be a big issue? On the autobuilder I'm assuming we can
create a pip environment we can use with the right pieces in?

This tool in theory helps with the answer to the question "how do I
execute the tests?" as I understand it.

Cheers,

Richard

