Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.1598.1599241110412053833
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 10:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ekwW+6Ox;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id e11so7973349wme.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=tG0GOXb9ekszBhmbgDJyRIz1Q9ABVfylcJvjf8yCDtE=;
        b=ekwW+6OxBnx2XZfRmdNLnfuecTR0oTTdxy3wGZXsI3TmYRnP6JE21rweBgK78Yzik2
         chxdJNilj1Oms63TrU2wfdfqgWTt80sE4EJdhq5TkujgvUh2YI2XORMS1whYBm+RwZTR
         INUSZ3LisHsOjQNC9MSvumiJaR5vnqqj5ecdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tG0GOXb9ekszBhmbgDJyRIz1Q9ABVfylcJvjf8yCDtE=;
        b=GYA8sA+TXpQR2xm6RMHHOLPwX0RUqOLx8M0ergqELgiMz7MSmjl/9TPETvCI3Y2Asn
         W2SYRDIA4XyX2opKexetEjz6IrDw8Lr/kfCL7bFmvXyOy7/aOI4k06Its4z3pAuMHYpJ
         prjxZLFvgHdEgkpfooUZ0/rspx1aSR1lasBn/PzHfXCgxaKehXNQ+XK3HhiW0VJygR7K
         px/WwpbZuAtBQbqfJ5Ve6UNjP/nkc+WSeiB0qfB8KDwSUSntRDBsFP3GxxdN4FDTnJow
         n4lAQwZ+kE6RsiNiwK4NXuM/tzjqU5SuQUBDDTvWmvnZk1tBFF7h8D9YS3qRxfAqniJi
         2QEQ==
X-Gm-Message-State: AOAM53033aVy0j2NPwSn0YLjo/hLWz5DlOFMzB/+2NSlQ99lxLhUHZD0
	8JbNd0Sl2TDAW20ECo6HAJPokQ==
X-Google-Smtp-Source: ABdhPJydslsB4ZDNLEZjhMPbf2uMYzVx7bAFX0/IT+wdo7yfueqgTskW6M4aYBa2Njy2V1FfRmj6nA==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr8473859wmf.40.1599241108815;
        Fri, 04 Sep 2020 10:38:28 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id a20sm11657413wmm.40.2020.09.04.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:38:28 -0700 (PDT)
Message-ID: <d3e55f910417f0f0eea02e226bd8411dd4ca431c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] "Resolving any missing task queue dependencies" - info or debug?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 04 Sep 2020 18:38:25 +0100
In-Reply-To: <f6dcb541-6540-6aa6-4fd4-3a651f950452@siemens.com>
References: <f6dcb541-6540-6aa6-4fd4-3a651f950452@siemens.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 2020-09-04 at 17:52 +0200, Jan Kiszka wrote:
> it seems al ready every multiconfig entry triggers one line of
> 
> NOTE: Resolving any missing task queue dependencies
> 
> when starting bitbake. But there must be more source. I have setup
> here
> that emits 42 of these lines.
> 
> Is that really so informative that it deserves logger.info? Or should
> it
> rather be logger.debug? Which level then?

We get loads of bug reports if bitbake sits and appears to do nothing
for londer periods, so it does try and print something each time it
enters one of the critical paths.

Now we have muliticonfig, that can make things rather more chatty than
people want but I'm not sure we can win. Its definitely something we
need to think about...

Cheers,

Richard

