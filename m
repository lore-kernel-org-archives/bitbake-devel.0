Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA86ACCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:28:35 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10217.1762417713319810610
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 00:28:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IYs3VAUb;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed79ad2846so3388891cf.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 00:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417712; x=1763022512; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93vX0/Sc1fw8nqMvo9r+Hf72mt3nrlAanhadY9VEmFA=;
        b=IYs3VAUb5M+E80GfmeEtDC3IlffShDibKMegMQS2YhfVxLKC7wdYh/bJHbOLm6iFtP
         Sd/UKLTPKs2B5GS0guXBE1IgYuaDRWocRmkQztzI/eisMOc3XaekjtgFXGWEuDGrDFRA
         Gzy6fPyTVYtISbIYHlc46Lq+5SbL5ur4/w1gWrc48hrEMqLKngtkhdu7khVPa0sc4AkG
         gfzMOyTGvT3IGmS7sJ19U+koMlA/MYtvTrgqeFXS4OTTtuAt/SGWNxx/Ij6+zFfwqWeq
         xXmda07fRZOONw1giUmgYoAt1FgrOWGddWM2FYusvYvI1XVqX386ZqwPQU7BaaLnk3kV
         J7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417712; x=1763022512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93vX0/Sc1fw8nqMvo9r+Hf72mt3nrlAanhadY9VEmFA=;
        b=EGOy++jzXgGnV8t3XXxK4xoT076fAb1HjvG1vqDru5sgkwYlQcSKVNDQukH1ACj7m7
         9fgvRTbYicR9v7fQXSQcFsa5isK4tqdGcpL4l5RxlVWu+2eTLYXTDgxS67I9P6y0NUv1
         IAjgdh5P3fT1HRZPI5yAIVkJLS3qecsmL3DFntTCrm2mRXKjCtIUxgvLslnqp87FgPLG
         SjDdHI5q1jqOyZShy6/LW+07VVHkgXqmi5GELs7OgCpbYhYhUaFVN/fD2RTX/lspnnIM
         KDUsjdEEz3d3fhMvMI1kwetRWfyq2h6DSQSkcj7XzP595uG6Qh1ezttj3wzNycGcWCzB
         9BnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj2dYk3Uc39wtXxIDZ2CUiyNGM2PoJV9JAmTHSpgt8pROJUVugv0I2QOXlVtmdyWdzuFToU+3x8tmIKXZC@lists.openembedded.org
X-Gm-Message-State: AOJu0YwjXyJpGW8nUV9fSlfJ0q1wbSBRpWmWQw8fKKh9JmUvbBu2fAXm
	HFnXWQgB3IsqsyeTy2/ZkbxY73z+uG6lsC/z/p9qExL0CuCZc32bYAax7Bd0DmkjbpTAAD5sFVG
	HVHOhh3RzRXtxYkXczIZgIyNJj/YzIXo=
X-Gm-Gg: ASbGncvuze9IAOBax5rMQ/okYyrPuD6C4d0345+y6nB6TzQ7Utu4CEqyMiFBt1aJwJR
	KCvpfKN8VWBIb80jtLzAcOYlHn4plcPYx0VB1muvq7RsDTv6T88iZpAjkqaQs8iIlsVo0uUaZFN
	nWBMFDA8psbyohMw7fuzvJj6sZJNKfAS6BbMkNIiifKyAhwGsx6j6dyG085alBi/eQ9vxbhBeD4
	akxgKai9oMDiOaRkwKSp6DX8cRbJ+zyXde2vJ+kQfpnNF1MbQfO242TiKeje72QWQk7rgxO8ncL
	AQ2OmYr57oMERlWmICs=
X-Google-Smtp-Source: AGHT+IG4rHlqxtgrxfcSyjPjg8APP/spVouznjWVtNvSQw8vzqHRxflMY52rqkNb8eDLHB38CziOzuOSuPuid9kVpZw=
X-Received: by 2002:a05:622a:53ca:b0:4eb:779d:e8a6 with SMTP id
 d75a77b69052e-4ed72629a1bmr87323921cf.77.1762417712225; Thu, 06 Nov 2025
 00:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20251105232718.2801446-1-yoann.congal@smile.fr> <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com>
In-Reply-To: <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 6 Nov 2025 09:28:21 +0100
X-Gm-Features: AWmQ_bkeHyAnDTkXJ3Vhl6WhfVbWkyW1UMSkBH8lQXsIERfNkEDeVIVDLJcjRWI
Message-ID: <CANNYZj_KS5BKsGMiQkLSyCKtma_BYcqJ+W3_jw80SzR6D-80Pw@mail.gmail.com>
Subject: Re: [docs] [master-next][PATCH] bitbake-user-manual-environment-setup:
 Document "{THISDIR}" in bb-layers
To: antonin.godard@bootlin.com
Cc: Yoann Congal <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org, 
	Yocto Docs ML <docs@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 08:28:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18279

On Thu, 6 Nov 2025 at 08:59, Antonin Godard via lists.yoctoproject.org
<antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
>       This useful for a project that holds a single :term:`generic
>       configuration` file next to a local layer::
>
>          =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
>          =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json

I thought the use case should be described along these lines:

This is useful when (one or more) configuration files and (one or
more) layers are hosted in the same git repository, which is cloned
and managed independently from bitbake-setup workflows.

Alex

