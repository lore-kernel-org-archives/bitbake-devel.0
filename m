Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760DC4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:37:58 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.33222.1701873472915556554
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 06:37:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AIdn3xL5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3333131e08dso955556f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701873471; x=1702478271; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QnPeTeHSPqHv4drSYf4kC2sHssBFKmi4Rzp4YNK4CCA=;
        b=AIdn3xL5k3zdNzw+fzGiGXCLjySlk5CshGzZofjimxfMQOUJPlxFIRhwzjWo+QtZQc
         7ltcPvjXn5fFNoDYzWweT9cbfxNJNRthpJSflLLoN3J6UTz0n8lUAmfn/ydi8/TLr1lf
         I/JXkdwyMDgs3WkwfzGUCdc4olGcf9cYtuo7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873471; x=1702478271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnPeTeHSPqHv4drSYf4kC2sHssBFKmi4Rzp4YNK4CCA=;
        b=l+iMgod7Hg+nU5NZOiR0jI+Vhcgxi/HVQLc4I/uKxTdMSLy/F+yEY5JAfvrUtx1Dm3
         V5RPfsbNtg2x/WbZ7UuRzBN7iHc2hFtfkecO1VoJiPy9s67qmsfeDfD4mcxX+oqxhN0L
         4Nau0gIvIkQWNim7Vwj6UXypDFPX+ywJ1Bs/i9OGdnVbs1MZ5CniCM4t5oFtg0ifqcPc
         CbdOQ1GBJ7e3qXMzeFiUJcpS5NUNewmObEbHUYbOp5nN3qlChulRv5EwPOxU0xKPvzin
         IPSUq5i3U7/lTD+8ONErGBDViv3ToeS9nv2Foa94xJzV0iHYvC0BqFF4wEtoKLyjx93r
         RI6A==
X-Gm-Message-State: AOJu0Yy+LR9DzI4MDFD3V1gUdkXgBbth3/MOR99x01R3RENE86d5VloE
	4K6r5NRENnMgOFu3hNSzLOY3Cw==
X-Google-Smtp-Source: AGHT+IFWTGNMDG1SssDcuyK5PZE5/JemL3EW/pdwhZFZ3bIdhZlN72OUJRzzisD8IxKq5loSyMp1ng==
X-Received: by 2002:adf:ffc8:0:b0:333:2fd2:2ee0 with SMTP id x8-20020adfffc8000000b003332fd22ee0mr553499wrs.89.1701873471195;
        Wed, 06 Dec 2023 06:37:51 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3cca:8f76:d5f9:e02c? ([2001:8b0:aba:5f3c:3cca:8f76:d5f9:e02c])
        by smtp.gmail.com with ESMTPSA id l13-20020adffe8d000000b0033342978c93sm9524626wrr.30.2023.12.06.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:37:50 -0800 (PST)
Message-ID: <4949d314efde5261ef8ce9b8d919ffd99bd66106.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] toaster/test: bug-fix on
 tests/browser/test_all_builds_page
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Mohammed Raza <mohammed.raza@savoirfairelinux.com>
Date: Wed, 06 Dec 2023 14:37:49 +0000
In-Reply-To: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
References: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 14:37:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15617

On Tue, 2023-12-05 at 17:40 +0100, Alassane Yattara wrote:
> - Bug-fix on table filtering on (CompletedOn, filter failed task)
> - Better handle testcase used time.sleep and remove it
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../tests/browser/test_all_builds_page.py     | 56 +++++++++++--------
>  1 file changed, 32 insertions(+), 24 deletions(-)

Even with the v3 we're still seeing test failures:

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/22/steps=
/11/logs/stdio

Cheers,

Richard

