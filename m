Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0BD59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 11:01:24 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45840.1765796483242294970
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 03:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EoE5EI+P;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so3731046d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 03:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765796482; x=1766401282; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plTVK8HeQ2nu2bAuNbvUTh1zrqv0d1wUUt0/bR/sVxg=;
        b=EoE5EI+PeFbuggmEasBSp2ntjflSB1j7KCGpYS0EBHT2bWE0itD8vT0AgeZ+h7g3Y3
         09scan0chYWLcy26R2PowsxFgKOguMONE7LMJ6W8LnRP0KYvB4RV1nxMpy+rIjbK9FS4
         pRfBG+J0YJo5roZSwvTzhLorm0lSZedAMbx1ecWpO1naFQXWIVyV35dOJTgrFzODQp1E
         Qs2gT+QyAoeQL44M98UemuvLgcD0WuTPxknbiEyLw1NzqN9s02UUKPMCIdcMiJBQXYv9
         /47MsSlRoxf1RvlltQrCXSyv32RX1DI1XZ6EKKK+LY0bEOv3CJ+LFjFIEXFAk4dSbMtH
         JqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796482; x=1766401282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plTVK8HeQ2nu2bAuNbvUTh1zrqv0d1wUUt0/bR/sVxg=;
        b=rsevW61k/tUmuKwiENvQBK96u7bv+IZbXOjqm53sHe4dO1tYE+0FYADRfjU3TQw22f
         9r8plvPnqSYJIL/qDUaDH3dOzEH0h6lsWrgeIrh41OZwa7HB+OX6Sq1kOaEG0MMcnZAD
         6WptSxc33lTKrhwbzszPtcd7dLznU5SqRzM4B8ZdbmNoPSfk8Gg5VIhaKisQ4MyTAKWP
         0LlUGGV84oCEL4a6Jah3tQyZ11IKfgNJEJecWuy56rmPNhdJKi0kvmcaYYxfUQHkvVwc
         Q0arsfVrPc7DUh4BREYFQhc5jEznhOK39uNbNW6tPZtCZv8YbmnObcACRe6L2AK4ZCj6
         +VDQ==
X-Gm-Message-State: AOJu0Yz/Oz6We/yQ5hVjZiH1CFDcF4CuBp6oCaw1s5W4WDvO3ni7wDDn
	jwmT5hXI+3N7LBHdg2r7XNsNT6Vm0aCMCrHYNf6Loaam7zHbcN5zkEXLvwF0C48CH9e+s74iW6I
	xgGXq6VNAhpROaEXmHXmkKonlBdaekFY=
X-Gm-Gg: AY/fxX53Vu5DPT8UXWtcrP/370CWLH6r9qiPdOUMlpEh7/0T+LYqrZ5Bv4f+Kn42N8r
	1Kex0txyS4WGorMJg6YGuWfkNOew9XzNNDZw0I5NvHW/BXCxARDYwphCJCZzXI6ciOjEubhps2T
	WSMszkZf8LFPqL4q5/nQ1xB5HcU+2CqUPaxhgLSm0uw9NccNl+l6w8vvOCQ6U8hMb/hXGmpBIDy
	K2O/0AQcSN7emKEEIfGFe8toXhzWiSaXXOQ9/IQOYFa5lmA8H5lVOsEPo4B4kOqd8L3MHqg2nSO
	GTwds5iWJKDGp/eARKahQInCnFFg+kWreakQOodv
X-Google-Smtp-Source: AGHT+IGBe0voektQ9fK16q311C82gm5lgc//OCV0G/Oi0qT1oDhTt4FjrySQsJ5dAddyE2PInfVLeUxiPpa3OF0EwDo=
X-Received: by 2002:ad4:4102:0:b0:888:8511:dbf7 with SMTP id
 6a1803df08f44-8888511dc47mr97833376d6.49.1765796482127; Mon, 15 Dec 2025
 03:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20251215103256.902711-1-corentin.guillevic@smile.fr>
In-Reply-To: <20251215103256.902711-1-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Dec 2025 12:01:11 +0100
X-Gm-Features: AQt7F2rC9GuHNPIdM5k-U6fSTnR11PzCCvIBwK_D-0d114VwCbY5WX4qJLbkLcQ
Message-ID: <CANNYZj_4XFj2Sgv1Q4_=BwDBCAtCpj5X=XfQ2=CuiJjoqOrA4w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/3] bitbake-setup: add inline URI
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 11:01:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18587

On Mon, 15 Dec 2025 at 11:33, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:
> +        if 'remotes' in r_remote:
> +            if not 'bitbake-setup-uri' in r_remote['remotes']:
> +                r_name = 'bitbake-setup-uri'
> +            else:
> +                idx = 1
> +                while 'bitbake-setup-uri_{}'.format(idx) in r_remote['remotes']:
> +                    idx += 1
> +                r_name = 'bitbake-setup-uri_{}'.format(idx)
> +        else:
> +            r_name = 'bitbake-setup-uri'
> +
> +        remotes.update({r_name: {'uri': r_remote['uri']}})

Thanks for continuing to work on this.

I think we can avoid adding the above code, see below.

> -        remotes = r_remote['remotes']
> +
> +        remotes = _get_remotes(r_remote)
>
>          for remote in remotes:
>              prot,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])

The names of the remotes are not actually used anywhere for anything.
So the _get_remotes() can return a flat list of URIs instead, and then
it doesn't have to do complicated name calculations like implemented
above. Then this loop can iterate directly on URIs in the list.

Alex

