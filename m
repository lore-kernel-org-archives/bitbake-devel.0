Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D65C63709
	for <webhook@archiver.kernel.org>; Mon, 11 Apr 2022 17:18:01 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.30760.1649692588985583450
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 08:56:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H7182N8o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id e21so7202189wrc.8
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=TrhNENKV6uq0qejPGmZAjSM60plR+Taav4+v98/gwlk=;
        b=H7182N8o3UgYk/jsrSXx3r/lhkDZaqn1KFXCzHrpEWXZG+/5AMxaJbMGd18cC1Z4wx
         dPiFp1pLWn7i23mozC8jx178ycUA2POOD0fiIxvgjYlXQAoCX5XiduGZp96xdumS0THv
         4gRCl8Qo8gU2MFNfkj8DfN9Pm2wlReB/O+Wxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TrhNENKV6uq0qejPGmZAjSM60plR+Taav4+v98/gwlk=;
        b=wgfsSB4pBMQAy9sDIC45EZvE7CYvgtnxkE5O0Oivp2hqkbTJm4b2Q2VdglA+lotswR
         wtCDDuuEwnWgbH3br87QdLlR/BmLexx83M2dahGXS7cjZo2LwdCvrV8S9sLiZAMwzNkZ
         3DlTAmkJ84+zV2en+YkB6akw3ot5LzZ0XEUGBo0lkpC71C7OQby6/Zt5UgFEyEWOSboi
         TzCH8A/9dVStkRwPlyaeMVtjXdnCSK2m34unJAzmWOjQSAlJ09wFGNVNBeYtEeYR7KMD
         yp/Wd5V5tEoEevdXyK4Fjw9CfKvQT3CLh6BzAZV1ZZ1t4vdDWio9L4ZWj+3LArFw8el3
         51Zg==
X-Gm-Message-State: AOAM532cYPj25FGyWBW65VBeXIC3NxCDsufXlfyKt3dwaliramNhkNzs
	8gOl2314fAj7QvngEhKgJ/ftQQ==
X-Google-Smtp-Source: 
 ABdhPJzl4rg+nHisWsB2zUC+B8sczmSypjF6KqOnlgWpyDZaq2/47w+nWVu+4lLLdpUAsVq7iV8xCQ==
X-Received: by 2002:a5d:4311:0:b0:205:f26b:fb98 with SMTP id
 h17-20020a5d4311000000b00205f26bfb98mr26046181wrq.202.1649692587389;
        Mon, 11 Apr 2022 08:56:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f8d9:779e:103c:69c3?
 ([2001:8b0:aba:5f3c:f8d9:779e:103c:69c3])
        by smtp.gmail.com with ESMTPSA id
 t4-20020adfe104000000b00205b50f04f0sm26444567wrz.86.2022.04.11.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:56:26 -0700 (PDT)
Message-ID: 
 <54bf9bc2753e4b91adfe1efd2c5aeec382792dfa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 11 Apr 2022 16:56:23 +0100
In-Reply-To: <957f9816-d2d8-b43e-b77e-51a64b9d984a@gmail.com>
References: <20220206134507.123558-1-ptsneves@gmail.com>
	 <16D17908BC3DCB81.25014@lists.openembedded.org>
	 <2c7698c9a48dcca849b964b5cd5076c12f5168be.camel@linuxfoundation.org>
	 <957f9816-d2d8-b43e-b77e-51a64b9d984a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Apr 2022 17:18:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13602

On Mon, 2022-04-11 at 17:23 +0200, Paulo Neves wrote:
> Hey Richard,
> 
> Thanks for the ping. I will try to have a look at it this week. Sorry I 
> got a bit lost with private stuff and forgot about it :(

I've just sent a different patch which I think should fix the issue. I'll run it
through testing and may be able to merge my bitbake change with your test for
OE-Core. Changes are in master-next.

Cheers,

Richard


