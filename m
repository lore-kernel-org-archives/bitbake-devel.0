Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC6FC83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 08:52:44 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.17769.1751532762585397261
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jul 2025 01:52:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F7Ytq0e8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4537deebb01so28310405e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751532761; x=1752137561; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9CBEr3XwZllZ5X9rDCEJyAjdBoV0EHL4mcrPpdcczSU=;
        b=F7Ytq0e8r8rAMQhVlBWVDtw4A1cz9W+HGaKMujnWsdu46miTv0bf1e2cZ12jhpnZ3b
         nbHsFJyQdR1EdBMjsQZ2TrK7BbVaP8UC+tGyt54sgqaZyBwHyTPND46w6Lu+7vwV9Vok
         ZpMj3yyg1F9Gnu0OD/VKWIT8gVUr8AIWSa/FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751532761; x=1752137561;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CBEr3XwZllZ5X9rDCEJyAjdBoV0EHL4mcrPpdcczSU=;
        b=iLzxtewreeYpA0FAEzyXNeSEVmu7d+gdYie9EIKXUjLoCOdi2aKrHV5J1zfBduc7KD
         2FEIgzHMqldXqPhWtpubkzPxfrLsc1dAVLAzAIgac3xXxEo+mQEJNmZSMc0pFyOGSyKw
         m9GjYIjYWDF6fE1+6ahuFhCH2qsFe2yGd8XqHtmpBPwypayDAV56jceqksz5qYNyQeue
         sb6ZPNWFRedXmWmLH9ai5TuTTiV0+PdaCWDyBuIBudiQ26W3WkYYhQNiUaGWBjsD0uFL
         RvrpaQZ5n+mqDOwStdxQfLUr5GMEdcsT8G9az4hVQYwWhya1nTI0hE3Ss3duW7ipzVjM
         FYjw==
X-Gm-Message-State: AOJu0YwrLYoeubGPbkfqmpSdlJ3up+wDMGo7OKJ+VS3syuTaQOqNf9JP
	VjBbZIBfOMieU1YpW6QDb1xu/Ob7v7vErzAC35GIOl9Y8ZJDgq3LV7lZwutnVQLeJ8c=
X-Gm-Gg: ASbGncuaPUwN6v3i65nd7bcmgqrnpRvEg09i1yIzdg+cjrT5COBBf6GcvwNZyIPw8Jp
	1JmvBr0EjZq+izieII7oypCAgbM3mIieac+bLJkpnUDTZle9j0Jtvptxb6fi4tErxmWdSCr+isb
	x2arNrCEn/PoezXrQ6mY4U8WwknaGguwR4s7KchFnTDUqzcQ2pY6nTVwzmhqT/9Pi/lwdfa/wiZ
	MZ6whihBJvcVonJ8j32QcBYeLoXfqOCMMoQ/rIvK+dIRV+SjJPOPXU5JDLoIrte8pE5QLmOEyLe
	E2jhyPbrhGLpYBZFDD8fbsth1Nkx1fZj76cTljFky9RVdxi/kT2LLylFDKeoCZ9uFz0lCm44PTC
	VZoVoYoVMUyutvfcd6EcHecmBYURD1SdG3WYYvKsCFy/1lS768sI=
X-Google-Smtp-Source: AGHT+IED+BoRcWMgbxx8wHVaZuVJ7x1+XvC8VJEmgvh7Sk9IRX+Lqnqp/jUIgu9qUhYiHHG4yuNR9A==
X-Received: by 2002:a05:600c:c172:b0:442:e03b:589d with SMTP id 5b1f17b1804b1-454a37262cbmr63355555e9.24.1751532760963;
        Thu, 03 Jul 2025 01:52:40 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e9f6:56ec:1d33:85c3? ([2001:8b0:aba:5f3c:e9f6:56ec:1d33:85c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a999c632sm20530395e9.23.2025.07.03.01.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:52:40 -0700 (PDT)
Message-ID: <979ed4823e11b76bb362dfeb83470959f53581a3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] uihelper: Fix KeyError race condition
 in pidmap access
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Etienne Cordonnier <ecordonnier@snap.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 03 Jul 2025 09:52:39 +0100
In-Reply-To: <CAHUKmYb=-rkSodEzWrcBNPG9k=7-x2EDr9ovuU8iUkLVAa6d-g@mail.gmail.com>
References: <20250702204758.2773339-1-ecordonnier@snap.com>
	 <1350a18ac7b6985471ac15e89321c559dbabab62.camel@linuxfoundation.org>
	 <CAHUKmYb=-rkSodEzWrcBNPG9k=7-x2EDr9ovuU8iUkLVAa6d-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 08:52:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17741

On Thu, 2025-07-03 at 10:03 +0200, Etienne Cordonnier wrote:
> Hi Richard,
>=20
> I have not yet found a way to reproduce the issue. I'm seeing the
> issue in 2 from 50 builds after updating from 5.0.9 to 5.0.10, on a
> build server with 60 cores, so that's about 4% failure rate. I've
> never seen the error before the update. There are no other patches
> applied to bitbake, however there are many other layers used so it
> may not be reproducible on stand-alone poky. I'll monitor and try to
> find a way to reproduce.

Is there any pattern such as only interrupted builds (Ctrl+C?) or build
with failing tasks? Any particular kinds of failures? Just trying to
narrow down the possible causes and give ideas...

Cheers,

Richard


