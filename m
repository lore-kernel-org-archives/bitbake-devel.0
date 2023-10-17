Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65606CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 12:04:58 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.211163.1697544289146121304
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 05:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h8QMPZ0j;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.172, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso50388171fa.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697544287; x=1698149087; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcSR0hsYP9DTMdRWnfZmrWKTeIzzkD8Tu7o50Aigtik=;
        b=h8QMPZ0jazhHjJ5r6dmqwc1wtmRSgmM/hQBsPYtP5Gni1kxdNa7ammN/S+CKdwDNmd
         OLzncUmvUqr7T26Bq3aJQw8+oswSNx3jO6+xiBMNbQXyjF7XgZGDQiLm50Hg/mlUnpZ6
         UaSjSs81TWRGspIzYj+JhNUbfvvn45bEXnOdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544287; x=1698149087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcSR0hsYP9DTMdRWnfZmrWKTeIzzkD8Tu7o50Aigtik=;
        b=wYY9ACC0UUVLeD5d2kGBa6JeFLjSlZvABG0ABNY6IBbA6Vr4MCvK1uCKi5H3iMKI+m
         lETNqxvoGuylBgVMwoWnG8jMu8f8OAxh6vvLJkWY3EmyKv1kDlx4LYW1lGiT4I9daGiy
         PHM53KQLkr51yGFf8rYPdFTXug+ILZLG5ypuE6SmjIjQZ/wHQUyPVqflUjyTHNqTcCV7
         Ku2OqCp/hB4oumHQsY2aC9PRxHEbaTfuiZX/rDQQzUFXrmkt6/Q+6RPDGxRvS28XdQ3j
         za1KM4WzVeYX8dOMMPdTtfSTPdZp68xf4YVxAlGlVyJqflp/iK9oB7Kbm8SEsGthDc46
         ZGYA==
X-Gm-Message-State: AOJu0YwqrY3R8pnuyRVfpDO7zuN81BhOyhTo06PVOzT4GnRSCi5/DYrp
	2RCCiJHWFte5tb8NCXgxVVBtYg==
X-Google-Smtp-Source: AGHT+IHDHGuSSEcJopE8xlzA8TyQkp62BiTjAkxujJ3qktjpbmaBwmViaQHOgaYV+iXn66xNOwUkiQ==
X-Received: by 2002:a2e:9f4a:0:b0:2c2:9414:7dc8 with SMTP id v10-20020a2e9f4a000000b002c294147dc8mr1553253ljk.36.1697544287242;
        Tue, 17 Oct 2023 05:04:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:81eb:8695:fc05:9038? ([2001:8b0:aba:5f3c:81eb:8695:fc05:9038])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c3b1800b004065d67c3c9sm1783022wms.8.2023.10.17.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:46 -0700 (PDT)
Message-ID: <8dde72b7b3978468000fe4f36a76fd916c52dc27.camel@linuxfoundation.org>
Subject: Re: [PATCH v5] fetch2: Add API for upstream source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>, bitbake-devel@lists.openembedded.org
Cc: jpewhacker@gmail.com, carlo@piana.eu, luca.ceresoli@bootlin.com, 
	peter.kjellerstedt@axis.com
Date: Tue, 17 Oct 2023 13:04:46 +0100
In-Reply-To: <6618da6c6215f91b1e898ffa6d96a970@pianon.eu>
References: <20231001075225.1054512-1-alberto@pianon.eu>
	 <6618da6c6215f91b1e898ffa6d96a970@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 12:04:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15250

On Wed, 2023-10-11 at 10:02 +0200, Alberto Pianon wrote:
> I just noticed that the patch has been merged!
> Thanks for your availability and patience :)
>=20

No problem, I'm glad we finally got there!

Cheers,

Richard

