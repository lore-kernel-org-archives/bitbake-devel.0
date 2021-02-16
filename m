Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.7106.1613479157843573778
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Feb 2021 04:39:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LIjWFKuX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id b3so12764013wrj.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Feb 2021 04:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=tNuftDFlNMs72M9oNarkf/7pM8Vuo2EsNJ54uwPQ+RQ=;
        b=LIjWFKuXCjTi2Bedefa+3kkjFmWOjxk96QmlPyOgDa185TyrHpb82BFzfJkConRM20
         QrCCimBAPliOAJBlIsdqtsICCZ0NrVnHRHhegY28CADvF+QnekOZktpaDZGK5PBXRDUa
         zEJhlNkFB7hcUWIdyVsYur6LclVRrXXaMJeD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tNuftDFlNMs72M9oNarkf/7pM8Vuo2EsNJ54uwPQ+RQ=;
        b=SAUqlHjSMX+kd3N0a+TgwEmJdNh8YKM7mh3m2obUoS10rOQxBXEhkbYhItDnISTSLE
         /uXrQ2Ua4zRGqxRBXvd0sBECOWvW7z68C9iAN/3k3PA/WJjA2ma2SpLTS8MwD3elxfw8
         NMNlFo57/DEspvpCmw35ekvHE80XlR/9TFXJ73SQgRIpm0XJ9bHbkGpGLNNnA/edecCK
         EYdJgcbqtbQqjTFf+KwntyeLbnjwYbLsAVjMXVR7PjGIfq8m+Gfq1UCYP4A64eGxCzd+
         3am28ASsn5G/ybHfLcMNpIrSC18200YOrDtOfAWOjeWFhGBcwFXztItJxufMIHZu855j
         3HmA==
X-Gm-Message-State: AOAM531bhoDvoZDckF4/ElI/7yGcFgnfTaGBqDcsp4pvyjnVFJu/En5p
	OKrFxnmrhhHueqWOTkLeTHDMMA==
X-Google-Smtp-Source: ABdhPJwvbNIjRW4hENaMnFxq/Vsn2STRMf6AJFu7pm0DrdW6P0ALfWbfsBoJ/mxWikw8YciFBjpt6g==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr22921245wrm.289.1613479156071;
        Tue, 16 Feb 2021 04:39:16 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:3cdf:51ac:3008:b3cc? ([2001:8b0:aba:5f3c:3cdf:51ac:3008:b3cc])
        by smtp.gmail.com with ESMTPSA id f7sm28617212wrm.92.2021.02.16.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 04:39:15 -0800 (PST)
Message-ID: <7e12f6331ca23f8fac9038bd65609cd4e8aae383.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v5] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 16 Feb 2021 12:39:15 +0000
In-Reply-To: <20210210111515.1189896-1-tomasz.dziendzielski@gmail.com>
References: <20210210111515.1189896-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-02-10 at 12:15 +0100, Tomasz Dziendzielski wrote:
> When multiconfig is used bitbake might try to run events that don't
> exist for specific mc target. In cooker.py we pass
> `self.databuilder.mcdata[mc]` data that contains names of events'
> handlers per mc target, but fire_class_handlers uses global _handlers
> variable that is created during parsing of all the targets.
> 
> This leads to a problem where bitbake runs event handler that don't
> exist for a target or even overrides them - if multiple targets use
> event handler with the same name but different code then only one
> version will be executed for all targets.
> 
> See [YOCTO #13071] for detailed bug information.
> 
> Add mc target name as a prefix to event handler name so there won't be
> two different handlers with the same name. Add internal __BBHANDLERS_MC
> variable to have the handlers lists per machine.
> 
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> 
> --- v5 move the whole logic to event.bb, fix tests
> ---
>  lib/bb/cookerdata.py |  2 +-
>  lib/bb/event.py      | 26 ++++++++++++++++++++++++--
>  lib/bb/parse/ast.py  |  2 +-
>  lib/bb/runqueue.py   |  4 ++--
>  4 files changed, 28 insertions(+), 6 deletions(-)

Thanks for persevering with this one, its a great fix to get in! It
passed testing and has now merged.

Cheers,

Richard

