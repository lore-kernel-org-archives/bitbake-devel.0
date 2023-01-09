Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E7C54EBD
	for <webhook@archiver.kernel.org>; Mon,  9 Jan 2023 14:22:58 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.72891.1673274174463624169
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Jan 2023 06:22:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D1OWDrlp;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso2655490wms.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Jan 2023 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgZP5nOPjKfQ756WDJ7ZJxKIFTcqmrThLtTavoNNfKM=;
        b=D1OWDrlpIXCFtWCkaOJ72vUMx9YpCJ/1Vn7Axfz4iPLBO9dKcG2D/VnxtlquN7lYBp
         yXX6yX47jRqvHaz+58pvq/u9dQLFYGq5BwwQQiaE1xiCXD90DWKDt8SNwHLLVNGo6/J4
         EjeBYaU1vJHvdhTRMfTy57E4w4dOt9OiqjYuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgZP5nOPjKfQ756WDJ7ZJxKIFTcqmrThLtTavoNNfKM=;
        b=S+VwtGNvW8RLgQ6G5xdYBbY5NK/p/B6Zj77jrH+TUqgyYNn8J1JxpE27QFs1cEB5d0
         7EAmQLMqkKu3u5LO+4yB5LtRonPTUSQPzk1eSJcN55pZb0V9WoTuDf6J/BfCK7gqQobw
         FTXCDFhsMSiUqeDE3nXPf+LREvLIwOFjjrlSTs6CIUGhrkcfmeu6VeDKkMDy8A9vVYQ+
         wQz4FIdv0eebkyAEbbXfUOsu1PW4HH4d2NSO2KKg890zPt4JDjo+Ongf6fjOcXQaDUjm
         e0mHOZ8Z3EVQiOfwHELCB53pQAq3xB/2PHYdH8PT7+1uDI9w/jHhiWu8/QojAg42G+ud
         4i+A==
X-Gm-Message-State: AFqh2kr6fJDLvgCUNLpPjCZ6EkJNLT2tlwdnOfwNiTPM9XHrz6+wDiXA
	JnKVuXsJH+RkwhEe+qD95UglwA==
X-Google-Smtp-Source: AMrXdXv/9S9QH27DFVuR1fgsWI2uUXOiq05jMYbnVI/R6vfxDdTPz2+caQhIBXjkG4Z3cbbWfunerQ==
X-Received: by 2002:a05:600c:4f96:b0:3d9:ed3b:5b3e with SMTP id n22-20020a05600c4f9600b003d9ed3b5b3emr3710996wmq.19.1673274172719;
        Mon, 09 Jan 2023 06:22:52 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bf05:daf1:cc08:7166? ([2001:8b0:aba:5f3c:bf05:daf1:cc08:7166])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003cfa3a12660sm29007861wmb.1.2023.01.09.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:22:52 -0800 (PST)
Message-ID: <58bb68ffb87e64c7ad6f63bd08e33873c329aaf4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Group and reorder options in bitbake
 help
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 09 Jan 2023 14:22:51 +0000
In-Reply-To: <bf7521d9-5a6d-c33d-53bc-01dbcfae91c3@smile.fr>
References: <1737BD92075F06D0.26636@lists.openembedded.org>
	 <bf7521d9-5a6d-c33d-53bc-01dbcfae91c3@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Jan 2023 14:22:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14293

On Fri, 2023-01-06 at 15:20 +0100, Yoann Congal wrote:
> On 1/6/23 15:09, Yoann Congal via lists.openembedded.org wrote:
> > Fixes [YOCTO #12018].
> >=20
> > Also, I have included some small fixes:
> > * added a '.' at the end of sentence where it was missing
> > * split some long lines
> >=20
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> >   lib/bb/main.py | 222 +++++++++++++++++++++++++++---------------------=
-
> >   1 file changed, 122 insertions(+), 100 deletions(-)
> To help review/discussion, here the new generated output with the patch=
=20
> applied. Please note there was a discussion in=20
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12018

This passed testing and has merged, thanks. I think the output does
look a lot better.

Cheers,

Richard

