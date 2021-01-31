Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.17196.1612092590598524661
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Jan 2021 03:29:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hnJ2n/Eu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f51.google.com with SMTP id a10so19737691ejg.10
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 Jan 2021 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=H6udSY8U+G2oFgW56Tw0EI6OKFiT0VYL4NRdk6xKXWM=;
        b=hnJ2n/Eu0bQV+AoNx70mBUVX0BOqikTsk4WypvlnszBq6FrljvtaCm316PuLxcWPcY
         DaEcRhjp9rY6Ey138p8BNJRbArcKYeUTdT+NYPZJx1S7UV+DvO1ACxaCOGTprRp/f6Nb
         0DhWjNM/MIBRcirkyWRsV8hadhyddyJec6G8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=H6udSY8U+G2oFgW56Tw0EI6OKFiT0VYL4NRdk6xKXWM=;
        b=BXjHMF0MlOCud46fgwkYqCAfVL/l/4z6p8mP7DisDojAZUq1X+R7UxxV+iDdYLAjVr
         ozfLAMy2Hp1YXuPxoU7gz25SwqMOQYrYqpGHzh3WdVxBIEN7ojUFPttgQK4fM70/ZMg5
         ImAUPAqXk48icOrBnezjNDnTJTywGrHHSzhSZc5OXgFEDNMUJwgzgzX0BhWAc0sYUAUS
         V9dihUN08KqEcfOo+o5aGD9SGhS7Imc0etFbmbvyi2PGLAs5avZOoc8fqvCwXJtPMgxN
         wDilHAJSd71hmM1FugwIdAFrpHB+7rUfsQ3fwmEiZjNNsub4oPpGdRAygqGzuwXI8bga
         vb5Q==
X-Gm-Message-State: AOAM533aYgy/TSqL2dMt1W3IHC3f1zV5R2U85DiV9SY3wZIycGcmlQhR
	IHrT6pR0UR8K6jX9/LUZTWw3DQ==
X-Google-Smtp-Source: ABdhPJzXqHScnxwYqk07i0iJBDS4PVMzaueV3kbWuQukaeaUwL8OwMMsr6a+byyyPIM9EqCsFkmINQ==
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr12568561ejj.43.1612092589035;
        Sun, 31 Jan 2021 03:29:49 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:29f7:5a4e:c660:258e? ([2001:8b0:aba:5f3c:29f7:5a4e:c660:258e])
        by smtp.gmail.com with ESMTPSA id o13sm6556742ejb.10.2021.01.31.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 03:29:48 -0800 (PST)
Message-ID: <45a46d525340ff82ce3fc6165fc68913eea4ef1e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Backport fix for os.errno references in fetch2 (Thud)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Daniel Dragomir <Daniel.Dragomir@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 31 Jan 2021 11:29:47 +0000
In-Reply-To: <H2US.1611877713506764273.o6hn@lists.openembedded.org>
References: <H2US.1611877713506764273.o6hn@lists.openembedded.org>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-01-28 at 15:48 -0800, Daniel Dragomir wrote:
> Hello maintainers!
> 
> Can you please backport commit
> e74f80433e9a7e7ae7ec1472eb7387301d2dc816 ("bitbake: fetch2: Fix
> os.errno references") on Thud branch?
> 
> Don't know if Thud is still supported, but I see intermittent fetch
> failures on Thud which were fixed with this patch (present starting
> with Warrior branch):

bitbake 1.40 (used by thud) is well outside its maintenance window but
I have backported that one.

Cheers,

Richard

