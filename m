Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FFDC4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 20:21:26 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.6808.1702412484756753324
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 12:21:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SEFA4YlP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso30322345e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 12:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702412483; x=1703017283; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krzDQT0RBBU4EjJHms8MZMw24HNQOrw0D6//f6g1kAA=;
        b=SEFA4YlPcHHilolr+ftI6vMcratbep/J/iKEMRUw5HZZ6lkdfIXELN4bTdQJXPPxoI
         /asfjP8dh8qaPkq8WF1M+oqI32qLle4a7RwlGxlP7eeQkERuzHA34R0hPZy6vPXCF5z1
         ZWmCd8xsSBbjH4v0sar2bMYAuX071fh1QkqI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412483; x=1703017283;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krzDQT0RBBU4EjJHms8MZMw24HNQOrw0D6//f6g1kAA=;
        b=V0ZwJYJLzMI8j1SXs2aoj2PklunJCzT4JKGL4+BAOWiJEMPjANY02+lujMvUUEyT/o
         15FHfg5N/A1KNkyy3+m6kySXwd5F0Q5m1Io2uL8OrbkT5U8/CwFVpgM4iWjjSgcOT0mx
         bAc26GfSU/EVT04K+sxwxjpDBjs8IgBEYFQiIt4xM167jTUmCh7htALazuaTBdxP80ww
         2QLTi/rqkpoLiwIN+N+VyO/gYSWNStqFx4s4OHPlVnPgej5AhwBDjNqSWfD7uZXbUTx/
         mkAfgVwhKdsNvUgIO3nl2kwVGhHOrE/nB2rghhmdXb3YuhCkGmQalvJFXtvK2Yow9u3Q
         zcwg==
X-Gm-Message-State: AOJu0YzG7WH0ghUZUGdAPqX9KsjpDv71P6eULeJj4/FjB13+9KvXm41i
	zCvPxU0yQqWCTsAv85ZTzAxxKA==
X-Google-Smtp-Source: AGHT+IGd4np9oa6DliItjZmoX2DcXcx3armFCQVxebPwBVcf8IGQUFSCV5Eju6szt5sjgvN55wGkSg==
X-Received: by 2002:a05:600c:6985:b0:40c:25c1:bc03 with SMTP id fp5-20020a05600c698500b0040c25c1bc03mr3425898wmb.61.1702412483049;
        Tue, 12 Dec 2023 12:21:23 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aa7f:d5a2:dd4f:a965? ([2001:8b0:aba:5f3c:aa7f:d5a2:dd4f:a965])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm17814602wmb.30.2023.12.12.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:21:22 -0800 (PST)
Message-ID: <43e8207d9565b0de4a38002579d054e3d56fa149.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/4] toaster/test: bug-fix element click
 intercepted in browser/test_layerdetails_page.py
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 12 Dec 2023 20:21:19 +0000
In-Reply-To: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
References: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 20:21:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15657

I tried this series on the autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/61/steps=
/11/logs/stdio

(and builds 59, 60 and 62 also showed the same issue).

I did also have trouble applying on of the patches on latest master,
please ensure patches are sent against the branch HEAD.

Cheers,

Richard

