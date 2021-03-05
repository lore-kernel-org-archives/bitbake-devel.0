Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web08.946.1614987448295196633
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 15:37:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IBPmwc9Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id f12so3871001wrx.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 15:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gHlCpXdy/rYKL8o2OwtmqNSeHu4yE7pFdkpTNhUfcuc=;
        b=IBPmwc9YaR2MBGb11A+YStYBMtAydOsprPwY/Vm35B3QNqtNBABL9rqcYvhydGBv0g
         6K8F9hK8aYUBXXzDp7cBFukf68QSeqmrqz+X6bFh4PJePlzOeYgXXGtXAoh1Na4sfrNa
         NJMWfAuggyG6+Wxn9nMRwcMQ/jLzDzMOE52w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gHlCpXdy/rYKL8o2OwtmqNSeHu4yE7pFdkpTNhUfcuc=;
        b=epu8T0XBNm4tdyiUjXHhEd8lhXuwRDxcjuur9DMXW0zN93ap+OiKcW/QehGc0PTa9G
         Xde+RUoTX1uLdH7JWf4LKacGJsaN9bK7n3+y5orQ2Mb/Us+gS4zLnIeu/PTm4xblGP8M
         mpNtsnjvoL/J27UFkb4rsKqSoFWPdnfoyWwJFzdz3sn30PYlKSRmHWyk10ySOUnRHi/Z
         mh9ksD7U3dnpJx6rN2b5owg4pzrwN4PwK/HcogKxkTn7Q31LH2M1i1w73oNNqvubOAeh
         Wz1tMocFxyECYXG8Ir+Ooz5UNUDQIPYRAQ9d1435aMR9FgfE1kC6nDzIDegp+WAp5zHV
         PrWA==
X-Gm-Message-State: AOAM5316mpIINzOKiMaW9HhfRetqB+xNHxXykugCtDXKMPAFM+qVj7Y7
	F9Up5VVZ9fDoXTIxP21ZvbWuBg==
X-Google-Smtp-Source: ABdhPJzv9qQAQSN+vZFndbrF0F57rvEHircuqxg3OcHlt139W/MQmXKlG8VAx+u/jfgsERBHVILYpg==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr11263376wrp.303.1614987446671;
        Fri, 05 Mar 2021 15:37:26 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8791:d573:be1c:dfe9? ([2001:8b0:aba:5f3c:8791:d573:be1c:dfe9])
        by smtp.gmail.com with ESMTPSA id s124sm5965639wms.40.2021.03.05.15.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:37:26 -0800 (PST)
Message-ID: <ede980db00b9924e73ce83cfcdfa0a734f426dd4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v5] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Date: Fri, 05 Mar 2021 23:37:25 +0000
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

Somehow I suspect this patch is causing a parsing speed regression:

https://autobuilder.yocto.io/pub/non-release/20210305-7/testresults/buildperf-ubuntu1604/perf-ubuntu1604_master_20210305150036_c8075ed8f1.html

See the "test3: Bitbake parsing (bitbake -p)" where you see bitbake -p
goes from 19s to 22-23s. With more layers the issue becomes more 
pronounced.

I haven't 100% confirmed this yet or looked into it but we need to find
out what cause the parsing speed regression from around this time...

Cheers,

Richard



