Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DAC4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 12:54:35 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.120425.1699534467485588906
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 04:54:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KDp0Sbes;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4094301d505so5477825e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 04:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699534466; x=1700139266; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T4I2bFP+z2qZY/ctdiK08D6XzvAqsXW1aw0Xxov5B4=;
        b=KDp0SbesEH5uoDWPvyOy8zLd4aKWP9EPBp2kXnQz5K43W0yAtZwpduHCrSlgkAhdXL
         fzgMXCOC1ZjXEsNYs5QtPkeCq7qc4oQw8gYinJBQOu6cOiL3hc1NIAGhQs+mGBHCHDTU
         clT+vWgcjnnQL67283i9FWRHvgS3+QKHb6YlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699534466; x=1700139266;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3T4I2bFP+z2qZY/ctdiK08D6XzvAqsXW1aw0Xxov5B4=;
        b=QBLfX0/h/H27rtG8VOy58rdvfpTs9hqKGFJGbLjKVKbP1wbjcAOsiusk9XQjdkix7T
         nqud4tkeJcjlxl7jjSV1p26fVlZ8QJ0Wi4Zq6w+Yoi4oX8BUELYGhA5LcMxHN/cJdA4N
         b9lKFE3sbNWzfcdNMw3cizv4fqy7ilAzT9C1CExnTXMCK6W/x09TPDRDTVEDypSKwjuv
         jjG3PpeLo+yOucX1MFAFXqwLvggF1rAoRY6KzLnss59aGpjH2y9i3sTIsquFUhWBfrDa
         WtBfshl3Wnojcp+UiqN6as2tJ9BWfFjcyzg1jW2BPL+99zsMdyYROcyXf1ZemaBPN56x
         TPTg==
X-Gm-Message-State: AOJu0YwjEC52gGnfNsGjWgL2VWMFsT8aDUEWn7nCYjF164Frotf0kAIH
	lT2GrADq9OHbwMoV4xFiaiHPrQ==
X-Google-Smtp-Source: AGHT+IHmLfpxj+XDpC31a2fgfS46pHkM5T+xSq0a0DX5jnzz3jxJFuMuMq42qTcgEkr/i/cMYsXhLg==
X-Received: by 2002:a05:600c:4f93:b0:401:a0b1:aef6 with SMTP id n19-20020a05600c4f9300b00401a0b1aef6mr4790016wmq.2.1699534465739;
        Thu, 09 Nov 2023 04:54:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7d6a:4777:87ed:703e? ([2001:8b0:aba:5f3c:7d6a:4777:87ed:703e])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c44c600b00401d8181f8bsm1981154wmo.25.2023.11.09.04.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:54:25 -0800 (PST)
Message-ID: <caaec5d4adcae6b352c36256ac629ceca8a9cd51.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 4/4] Toaster: Toaster: Remove unused
 sleep import from time
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 09 Nov 2023 12:54:24 +0000
In-Reply-To: <20231102150227.363289-4-alassane.yattara@savoirfairelinux.com>
References: <20231102150227.363289-1-alassane.yattara@savoirfairelinux.com>
	 <20231102150227.363289-4-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 12:54:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15457

On Thu, 2023-11-02 at 16:02 +0100, Alassane Yattara wrote:
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/browser/test_landing_page.py | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
> index 756497bd..7b425344 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -7,7 +7,6 @@
>  # Copyright (C) 2013-2016 Intel Corporation
>  #
> =20
> -from time import sleep
>  from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase

This line was added in 1/4 of the series. This should get squashed into
1/4 and the series resent as 3 patches since it hasn't merged yet.

Cheers,

Richard

