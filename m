Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.3368.1627335930852232072
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 14:45:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LAGH/KoS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so403648wmh.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3d8CLOsZ0tehztGUaQkDudHK+xuUWpkGU1y2Qx53xB0=;
        b=LAGH/KoSOTMh/AMwHHCrd4kNaZMLg+pD6b4Zb9/Ct5l1elRGKWWq1Hx1UzveoQeDv6
         Wu+6liVkizFI8yzA/Ec34PtKAmRUUQCNHWtp+LX2sMocWf/4GM1W/cX1ITmZ3bSpHqwQ
         /UHV8fPZvuArB3tdotl2aJF5bkz1HpUwKN8HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3d8CLOsZ0tehztGUaQkDudHK+xuUWpkGU1y2Qx53xB0=;
        b=WTfKKOEIvlN6C2clN5Y4Y5iA5b6X5Kh+HQrJQ9qqEAucdu9jIPGLU8aXXDG8b7gxCf
         7bbEgXYsxnoVGbJJMz/sHvS/cl6Iy8wTxROEhwtYx50pTJfpdpKle2Pf7FN5ZjV/BXdL
         00gCuzL+NR1JIHE9qgYfGD16M5rrIdl8+/8199w7FwZ6MXEx0UNx+tKKrKWfA23d2tdM
         hXmht+GYHLZW2NXM67khltiRTySjZnJU87iKdVxnwwrmCXfXuq0Qr8VJ+xEYy1hLQxBo
         IpEe1fMahaNRr+dsb8h9n11HaxB1jGG9BcngH126eZZMzbRXF+5VIWTkIsQv8Bgd2eGS
         yOBQ==
X-Gm-Message-State: AOAM531PnHhyR8OzDykK1vS5h+FY4Y/qxvuAHw8BTqH1Ifg8chuwi/3s
	nEyluk8c/XehrvIPhbns6JyzXw==
X-Google-Smtp-Source: ABdhPJxFyIs1IuajKqdVGPbo/+mS+vRGOeIwMVZVFvAH8YciGJ+bVrg0P8XuDdZSz1JeRQnZVn5BQw==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr2871184wmm.63.1627335929177;
        Mon, 26 Jul 2021 14:45:29 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4? ([2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4])
        by smtp.gmail.com with ESMTPSA id u2sm707361wmm.37.2021.07.26.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:45:28 -0700 (PDT)
Message-ID: <e6511dbdc13c163b0a9e445eeacde057181a92ac.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: bitbake-user-manual: fix syntax in example and improve description
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Mon, 26 Jul 2021 22:45:27 +0100
In-Reply-To: <ee3b6c49-802c-8840-f8f0-5e47bfb51581@bootlin.com>
References: <20210722171021.69225-1-michael.opdenacker@bootlin.com>
	 <a7519c3f91a397c4e4259be88c0ccd76c3b2f037.camel@linuxfoundation.org>
	 <16945E9217B4CF53.14473@lists.openembedded.org>
	 <ee3b6c49-802c-8840-f8f0-5e47bfb51581@bootlin.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-07-26 at 17:44 +0200, Michael Opdenacker wrote:
> Hi Richard,
> 
> On 7/23/21 10:35 AM, Michael Opdenacker wrote:
> > 
> > Of course! I was wondering when we are supposed to start updating the
> > documentation. Probably right now, indeed, right?
> > 
> > > An example of my scripted conversion run against the manuals is included
> > > in this commit:
> > > 
> > > http://git.yoctoproject.org/cgit.cgi/poky-contrib/diff/documentation/ref-manual/variables.rst?h=rpurdie/overrides-convert&id=9ac22a64a4c0ac4640552e90674e6459f0fece9a
> > Where can I find the script (or commands) that you used to modify the
> > documentation?
> 
> I found your script from patch messages
> (http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/overrides-convert&id=f7c5c3bbb9bc5d4c4c8f798d64a020a4504542df),
> and it seems to do the job fine. I just had to exclude the migration
> guides, but that's easy to do it manually.

Sounds good and yes, we can just exclude those paths (we could even do that
in the script).

> How shall I proceed? Shall I send a big patch to
> docs@lists.yoctoproject.org for people to review and check that the
> output from your script is right?

We need to get final approval on exactly what we're converting, then yes.
I wanted to ensure you knew this was coming! :)

I'd note there are some _arc overrides in the docs as there as in the metadata
which need manually tweaking. I also spotted some _sh4. Those are rather obscure
and we may want to use a more common example anyway?

Cheers,

Richard



