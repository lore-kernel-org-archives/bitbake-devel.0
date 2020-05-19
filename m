Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.9367.1589885929496331747
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2020 03:58:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QJZTub27;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id f13so2570045wmc.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2020 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=R/PzkP7A1285gCdqvmNIQ1jtZ1rE+8p1FalRejAi+kg=;
        b=QJZTub27g5lOxxFCFTqnGNw1UOIJzHSOo5UMAtJounVMlCdunmSbqunP+ZnliXCRgF
         h5e4lNhMEbW4/Pot82kB23TQ/qsI8VxGhSYREbSUcbCWpWJR9Ez0swiMoZwS/g/2cCYQ
         +63La+LfPpcDf0NwHPsOytrgMB8x4QK2DbwLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R/PzkP7A1285gCdqvmNIQ1jtZ1rE+8p1FalRejAi+kg=;
        b=HP7CBI1+jtg4sTOgKwjR40fL74XjYikiIKX/emr9Jz3rz9tyFiyvDf3pfhXCwHbYxb
         8Rwu8Lb2Lh1nHxl2ryTaTogpD/241FKEurECJfWI//rKDsAjScjpF0ogkoNeaZyt9CXc
         o2MeWcy+2yNJveI5NY9OQNQYNSR8bp5+5X7u+Ey3+ymjjC6KTkLI414Utmjt8rfob4pq
         YcOL7D0sWHOB9hTkwxXksYgyJ0x7Ee2XHLVqXpNNgiTD1Al3pfuXlKXfeguXxQXIviQS
         PTE/zTmOPPncIeY8mERSt7/ka4MERUAKvxP0AE4JpylpDWOlW/ZEF1cVvAPH4fdc5F5w
         n3VQ==
X-Gm-Message-State: AOAM5306J3QKqStLqVPDiBJu1FAAGeYMgoj1UkZU4ZgrEXQ01Y2095KT
	9eade+y6x2nCjMtc7yGO6YOe7TUhmEA=
X-Google-Smtp-Source: ABdhPJznJ1wLK0+6WrCJU4ST72LfetZfeaqSKnVVSIKF6DfuMJce6FrXOMc7n0s85bHWe1nvBcZN6Q==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr4611859wmk.112.1589885927618;
        Tue, 19 May 2020 03:58:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id y207sm3807632wmd.7.2020.05.19.03.58.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:58:45 -0700 (PDT)
Message-ID: <2bad5b8490f2b1e2aad09127fb1ed2d8efeb7438.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] more nitpickery: difference between d.getVar() and d.expand()?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 May 2020 11:58:44 +0100
In-Reply-To: <alpine.LFD.2.21.2005050921570.14090@localhost.localdomain>
References: <alpine.LFD.2.21.2005050921570.14090@localhost.localdomain>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-05-05 at 09:27 -0400, Robert P. J. Day wrote:
>   no, wait, hear me out :-). still crawling through BB user manual,
> section 3.5.2, talks about using d.getVar("X") "or for more
> complicated expressions, use d.expand()".
> 
>   fair enough, but it seems like a lot of the code bounces back and
> forth when getting the value of a simple variable, as in:
> 
>   libdir = d.getVar("libdir")
>   libdir = d.expand("${libdir}")
> 
> given that d.getVar() by default expands the value, is there some
> difference between the two statements above when specifically
> accessing a single variable in the data dictionary?

No, there is no difference. I'd usually suggest getVar for a single
variable and expand for an expression.

Cheers,

Richard

