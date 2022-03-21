Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54890C433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 21:38:56 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.1783.1647898734596644788
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 14:38:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20210112.gappssmtp.com header.s=20210112
 header.b=HyOlXpj8;
 spf=pass (domain: burtonini.com, ip: 209.85.221.49,
 mailfrom: ross@burtonini.com)
Received: by mail-wr1-f49.google.com with SMTP id j18so12844458wrd.6
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ihXoqYfkaDlH5Wk7EcmL9nUMRUngUFbD5ouXCBixFU=;
        b=HyOlXpj8pdH5UYWWP4RpxG5DS4oEeUe1oUIYWHLeKsxiBvwahXJqGz1txnb3w94vNP
         TXcDmEO3J0UQ4EtRBJnymKo7ENe4AMa8Yw9t1QaEygNd2EUseALLiTsNqd+cY4GmQ2xr
         zK3nWF3DXJKFPYa7ITIm7wxnG+lWW1s0MIK44bt1plYiwyIzGVCbq83fdcEifvcp+JR+
         nM1vQRoMSQgGVh/4aaDo0Pfvo0JnwHNhcI8pg7uyJPEAh9D6rBgHb3N8eQkiuCAEkSar
         zCpXalb4kWSvM8+Bfyo4x3WOYxHq+Vuja83fhZwDp5xKNnqHU7bc+ZGuwm+zl78tD5AC
         IxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ihXoqYfkaDlH5Wk7EcmL9nUMRUngUFbD5ouXCBixFU=;
        b=At2gDzwKiv+/h3XLJrINySVCnjBDuySFysCkT1BD3fyhrf/MBC1ApmeXNFACLSY4H4
         aYSeVshK7YTDcP8uuL984mrpaVlWTm1UkJ6/Vxk24+sOgO47MJeDql0sEdvrU9P4oJM3
         KLaipBSWmLLHsvJpC/oIKx5gs+lMdbhHMi1QQG1P+xChp9qxVHAGAHbEd6AIEYkCZ917
         sKcUYr5kaRnXLQbOllArMs1Mnz5JZmH/PPjewLH6awNvTI3Hr0Nu1v/1MHdPrmHLH+bm
         El/MzchKtEszR81+7erm6PocG24gI9dhTDi1Xeq5jVka33o8AtHwbKGsVMDR4gnHOXO7
         Armg==
X-Gm-Message-State: AOAM532XE/RufAognhtRiSIsl9GTfDMSDQT9v/ILCWLqjpq6dru1zr6G
	7XhXSxdmaJ74qcqwIUqLZi9CeAXh+rObg96nHiSISA==
X-Google-Smtp-Source: 
 ABdhPJwLPQA5dktIYslkpXMrou4nl8LR5k60rCnXo0K1IqkzjWVx58jjrg4vM+/OME1KyktlXPIwZbymKrtblF7RpQ0=
X-Received: by 2002:adf:f24d:0:b0:203:ee8a:2160 with SMTP id
 b13-20020adff24d000000b00203ee8a2160mr16848611wrp.497.1647898732955; Mon, 21
 Mar 2022 14:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220321170104.3371476-1-ross.burton@arm.com>
 <CANPvuRkLfOOtqe2a8roVRisq7Qxb6yyJLxiGFkHQ=sSzOFQ8Mw@mail.gmail.com>
In-Reply-To: 
 <CANPvuRkLfOOtqe2a8roVRisq7Qxb6yyJLxiGFkHQ=sSzOFQ8Mw@mail.gmail.com>
From: Ross Burton <ross@burtonini.com>
Date: Mon, 21 Mar 2022 21:38:42 +0000
Message-ID: 
 <CAAnfSTv5P_q=DozdJPBP=mKQKJ4aOTwYND-MzB67gNqfLqeegw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] knotty: display active tasks when
 printing keepAlive() message
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 21:38:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13493

On Mon, 21 Mar 2022 at 17:05, Jose Quaresma <quaresma.jose@gmail.com> wrote:
> I think that building a new string with all tasks and call print at the end is more efficient.

This only happens if bitbake has been idle for quite some time (5000
seconds) so efficiency isn't key, and I'm not convinced that
constructing a long string and then calling print() once will be
measurable faster than not doing lots of string manipulation.

Ross

