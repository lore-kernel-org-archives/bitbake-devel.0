Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.16695.1592224153425130214
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2020 05:29:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RwB3AwD7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id l10so16903081wrr.10
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2020 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=jbkujafygaHD26jsl2IeZM++Qz2MlL+jua5pNZIwUw0=;
        b=RwB3AwD7qfStSdnwmQdXzWdt93NeWUSs3ZowmU69htnQ43LGMOzdtDNgrtjR/jlpFQ
         4ECwq3cN5aIifJ6WjUabluO730KoEoJZJyh0+S/lDBgv1DjMrIXZMrczejjYoG9DAkTo
         XC6H/R+MHOQ7/0vxoKMOjuvJUUAXHiJF1jEWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jbkujafygaHD26jsl2IeZM++Qz2MlL+jua5pNZIwUw0=;
        b=hF+0QM7HO7Bo9wpvogoV4JMmubO6qTB8dFYJ2KIRvSclK4KuAJs0dFPrYg159dWV8e
         QnArRNRUoghY4cjKCtNO/tpapt2HfMxpndpsJ4HuY+WMOwK5ohNQgSdgyzod+BtZnP5V
         IqW5FnaN6AL472kG/azTZ8CNnUZGygjEw7Y2V3ukZPruKOKipb04R9HfRyIlcwrhqqEi
         E9Ff5/bb8Dk3TAZC7xN3gx6T/beOb7EQaSq1rFI9SBBF5pmCNr3g6rBLGCK4NU+2IxVf
         5k6o9slZIPLGNQk2atZwxRrfgxZhLPUI62hiTQPexekyvmOyjRyhpfPcP3d8oBKsAFh8
         UWmw==
X-Gm-Message-State: AOAM5339IjoISOWBIttKmdiUn7s+XVenQ9Lx9E/pUL1kOk2wH3Tghkoo
	ADp2RN2m32x/t98EY8jsBo6sig==
X-Google-Smtp-Source: ABdhPJy25v3QbYLgGP5ZHzbm8e7QQ8xp0FutT2ry8dc973M+wPvNvPBzV3C8W9YsasU12Vn+CZHC3w==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr30642309wrv.77.1592224151881;
        Mon, 15 Jun 2020 05:29:11 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id v7sm24323671wro.76.2020.06.15.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:29:11 -0700 (PDT)
Message-ID: <2677ce4ecd89cb99e7bd491a68be93908023c87b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/utils.py: Do not preserve TERM in the environment
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 15 Jun 2020 13:29:10 +0100
In-Reply-To: <20200615122231.1325750-1-jacob.kroon@gmail.com>
References: <20200615122231.1325750-1-jacob.kroon@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-06-15 at 14:22 +0200, Jacob Kroon wrote:
> The value of TERM is leaking into OE-Core postinst-useradd-${PN}
> scripts,
> which in turn can optionally be monitored by buildhistory. Prune the
> value in
> order to make the OE-Core buildhistory output more deterministic.
> 
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>  lib/bb/utils.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 5f5767c1..50032e50 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -580,7 +580,6 @@ def preserved_envvars_exported():
>          'PATH',
>          'PWD',
>          'SHELL',
> -        'TERM',
>          'USER',
>          'LC_ALL',
>          'BBSERVER',

When you send a patch like this, please be clear that its for testing.
I know from a discussion on IRC that this patch needs close vetting to
see if its "safe" and its likely going to break things around the
menuconfig tasks for example. The patch needs to state that so people's
expectations are right.

Cheers,

Richard

