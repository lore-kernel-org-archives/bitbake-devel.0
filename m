Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF7C369D7
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 10:54:33 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.12257.1745492070552966132
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Apr 2025 03:54:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AxXrpShW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so915083f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745492068; x=1746096868; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4F+28CY2wV6HPMRAvy8rDP2doIGIQ8BcSW5ctdoyi6M=;
        b=AxXrpShWPkOe29C6zO+vGHcsicHs0fdIPOWUHGJHwHtKctsV4q7rH/FOarJNlirOgl
         6lJflHmJDwWJ1U7VpmEH+eaUHeADP9o3iguQawtmcDsLWC/vvKzGZNepVtyDNBbC+r+T
         OTOj9iCJ1Ot1dTOxJuHl1/WbnuO27Oonk2vAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492068; x=1746096868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4F+28CY2wV6HPMRAvy8rDP2doIGIQ8BcSW5ctdoyi6M=;
        b=Jze98mRxkiR44VsnBLbCApgqnIfzqHaB9dNk66Zgx6PUAopRfaB/4h+w8n/SpmGEkd
         6tJNDEJUqYQpnDcR+JBfTSKD7W01rH1yyh3PddIyvKtzPhHW5hGnGp798/hAry87Yoo9
         ykhr122HIuCXdt30OHKJWUl5g9T1uxEj5VjM0+VfGprEdOEtMTwm0idHVjwBOJ2DpnDY
         Pw3B/1dZwqOJnPF1YjjKylpJt4KFoz5bHxJKFgejy5w+XYQZklmosnLrlmUjycFwVOQV
         kLevwQ5tebG2o1tsZilHnWFZZIwyBPoG+UYjNCWmPh5OHgH+fneQ19eV/yy0WUtWKfhx
         YYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXv3XoY/BndSsFx9Ed+MOD4q9DerkK/9qjOtMJDXh2F+KVNplzincJARmy9w+aO0XLajn2N5+6iguMZ/MZG@lists.openembedded.org
X-Gm-Message-State: AOJu0Yweq5bgpQRuaTi+L9UvkM9ZMTKaLt/WoXrC9KhJsKVK+6SOOU+V
	k34VumuGawIy4IM65+LJY0b9PAmXF6VvJ0EOKASEM7Tty8vj3U49hsGf6jV4JMY=
X-Gm-Gg: ASbGncuCeWLHZAA+vWidPshKGmkd/63J6EK5yKK3RHZF6oTBk0lwkLfPnilfwLuh7YK
	D5nqAtGwRxgEbft5JtaJbMj4Z+MqxzqhrL9i4B6ltawn/wlHbQTNIWlj87TBppqzVNOHAzdgo2b
	oLKfloLncxn75/uBHtkGv17HEKuz346U1E8dG77sUXke7EjpLsQ1tsZyCXdtQwwaTmudwXGVYvI
	Z0F+jQ3GmCMe0E0Tz2/sFTiGoyMnRMD83mxa3uvO5qR+r95Ttbu/qmpr9PRIDHbirziw9c19JR7
	29nl/eKhvmThTMECwzDCLBlkUtCbeFwWSeRD0WrCw9aC4/eqzcSw0qIKEe/mOeAW1vPId8ewayY
	WXlmfwwYgF6MlwQJ9eJ2c88VvVWnZsw==
X-Google-Smtp-Source: AGHT+IHgVC0ar1AflyJGUogAsErnEqjX5SYKuIv/NZyoiH28Hx187Y2KpGVKOtbZL2tU/kF6ZYyyzw==
X-Received: by 2002:a05:6000:1787:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-3a06cf4b720mr1738962f8f.2.1745492068545;
        Thu, 24 Apr 2025 03:54:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:94cb:8780:19ce:62be? ([2001:8b0:aba:5f3c:94cb:8780:19ce:62be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d532976sm1703118f8f.73.2025.04.24.03.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:54:27 -0700 (PDT)
Message-ID: <3a847ee8e460bca5d98b56771669a2ef0f915af1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/4] Document library functions
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org
Date: Thu, 24 Apr 2025 11:54:27 +0100
In-Reply-To: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 10:54:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17553

On Fri, 2025-04-18 at 17:15 +0200, Antonin Godard via lists.openembedded.or=
g wrote:
> Use the Sphinx autodoc extensions to document the functions from lib/.
> For now logging utilities and bb.utils functions are automatically
> documented. Some syntax a formatting needed to be done for the doc to
> render properly.

This is neat, thanks! We've wondered about something like this for a long t=
ime.

Cheers,

Richard

