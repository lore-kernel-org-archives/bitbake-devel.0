Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7ABCCFA13
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:47 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13419.1762429837602463594
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 03:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NJOFcwit;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78f30dac856so10528706d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 03:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762429836; x=1763034636; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca7IZDmhwqxAtwJcEVJlN1QnHAEILc8ENm66owReKpo=;
        b=NJOFcwitHasgdqDhu5MvT5etEns8CYleqfwNxRL8bgcyOC4fnRted0HRsotXCE+Geq
         PrUUrL8kH+Iwp49fR9fpYzl7Wmf9Du6JXZg82kck1nGtD+RJ00RjGfFvusumo5Ij02AO
         z2EcMGYk+wCC0M43IGUnPJ+majhHHcXwDCpkfDZ8MziKQQRWzUsme+TWauS0o4fkk0db
         DcxOEWQqRkpWt9eBwXzL+K5ceJxfT1LRphLJBvsOmBgBP7YvN9LBjVj+BewwtrS1t3J0
         w6tNXiMUJS2Xo0auoQkVQcbuWaTlrim0Da27E5DYHIjCWBVbQeoGuEb4MFgk4EKHDwkv
         YA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429836; x=1763034636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca7IZDmhwqxAtwJcEVJlN1QnHAEILc8ENm66owReKpo=;
        b=t2loHuzT8mVUfQymVRChi2f0PreJoGTJYSDz8u7U0VvRlQ0xU35kgab35sGQD/Iq7+
         SMbKGzUbdqWIOaBg1dh73/nOMCsgB80xTQb6XdgwrxPGgK6QnJQ5JNmHIAbcMT2CfeLO
         Mu+rCZarvXKTVgymljAlCAi9JChVEO4GtrjrRQC5p7QGZ4gY8h+fq5kN9UEQFCa0H+1U
         b4E5WBZ060sBeawbPtQ6+xdb+hV2PqNvPYValIBXMIBxNOgthwzljehGjt7VkdlZ+nIv
         7M92+yFXt528QnyW2dxXk2AH+is45ZhieMtA+dqQLs6C0jxao9hipu3hd3QMyqxa3z0J
         m5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs9QbIbfVYyqzBhb87WsKebPE+8+fipTcf5xQtOQqG/mbDpyr1jgPFsHpsIEmnw2BHKCFLfSH0ZoXVokvJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YxnsQ50yZFD1/RTa7eWexNIqpsNh35JitpkUaRcByojviEfbGgh
	X07nTDpmUkoef46N0qVpYiChorfWTg8T8N7Uu0rIILGiBnrUSfNxKjxLPzR7JoR5DGDgBzJA05Y
	8Q+u/Jw1jgYRCtlp3vOd9BkHkL6LMLeRpTBEw
X-Gm-Gg: ASbGncsvEmrSeePSvioOfop8jBfAth7fh/Ybr1SpU85SreVZjjoWbgvCBIIC5Q7aVYp
	0nT90YFjbUJqzPVsji2YHs2JVshvSsADx2gWHQT4yj/XDUEdWTvmEBFQLLjERN78tUqvt3/mjr9
	vjrY9WUdpKDMAUvhv3nPjKhlcr1H8jwmZry5b2NZ+8zIUQbFeTvx1mEL7RZ52XELAvGA4n4H+Hh
	lY8VhZ1Nv9saFyn7TjNkTuWdhb2C7Axl+/fN+UJxMjcluTaUGIoj/jJig==
X-Google-Smtp-Source: AGHT+IFmzJj07Q4NppuaZLfNZN99/JTELUYCK/2FuV3VThiID1Xu20OvgdVJIMDiy+j/tD0kgMUUx6IzsqOdRTSk/i4=
X-Received: by 2002:ad4:5ae1:0:b0:880:460a:96ce with SMTP id
 6a1803df08f44-880712226b9mr97558176d6.63.1762429836508; Thu, 06 Nov 2025
 03:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20251105232718.2801446-1-yoann.congal@smile.fr>
 <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com> <CANNYZj_KS5BKsGMiQkLSyCKtma_BYcqJ+W3_jw80SzR6D-80Pw@mail.gmail.com>
 <DE1HVJAH8J7U.29XUESHFLVEGD@bootlin.com>
In-Reply-To: <DE1HVJAH8J7U.29XUESHFLVEGD@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 6 Nov 2025 12:50:25 +0100
X-Gm-Features: AWmQ_bnysqalFcp1AX699N-CQHVG1E3C4JepWC1YCa7S7cvm50O65TylzXj0qdY
Message-ID: <CANNYZj8+BELKtPY+0bojL+zv4tbCsqgxmYUXnWLpr28urbCCSQ@mail.gmail.com>
Subject: Re: [docs] [master-next][PATCH] bitbake-user-manual-environment-setup:
 Document "{THISDIR}" in bb-layers
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Yoann Congal <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org, 
	Yocto Docs ML <docs@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 11:50:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18286

On Thu, 6 Nov 2025 at 10:12, Antonin Godard <antonin.godard@bootlin.com> wr=
ote:
> >>       This useful for a project that holds a single :term:`generic
> >>       configuration` file next to a local layer::
> >>
> >>          =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
> >>          =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json
> >
> > I thought the use case should be described along these lines:
> >
> > This is useful when (one or more) configuration files and (one or
> > more) layers are hosted in the same git repository, which is cloned
> > and managed independently from bitbake-setup workflows.
>
> Rephrased, thanks. I'm about to send the v2.

Note I just sent
https://lists.openembedded.org/g/bitbake-devel/message/18285

I do apologize for shifting the configuration format like this at the
last moment, but I do believe avoiding tokens and not doing
post-prosessing on values is beneficial for clarity and validation.

Alex

