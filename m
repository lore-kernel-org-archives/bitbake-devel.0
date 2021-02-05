Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8983.1612536160027495475
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 06:42:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MDnNRQQP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id i9so6095711wmq.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XehfMOYae5YkksKpyxCusHQ9+z/gaotLye5rAIWmzcg=;
        b=MDnNRQQPWBU6DN591wn2IF1sjoA+dn4kQmGwbOMJZaC/BIbuhmRcpzF7T7IxTxnGAI
         pfJ4mF3m9lOcFFaX5LRO68gr3ExKPFEzW5abofqhFfRKEOj7wn7LCg5/FCotWLlknyF5
         3he79XjGYOLCg471xXJchPOeoQfifEm/SVTrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XehfMOYae5YkksKpyxCusHQ9+z/gaotLye5rAIWmzcg=;
        b=TbUDlEKVc2QHfbBtBjxVQquZN703AT/IcfH/Pce6SK4YYjNhSRJu8wgnmrMcPSt+fY
         SZbzPeYrh27X8fjePJV2goVUt/3ba2FzxiAU6n0bW5iO5jm7umnEiB6CritR/c3dtg8b
         XCC+PUY0w3uPbk4hyUaWYzOgDVVf/l/8GjbAOULfBQm9Pk4UMRy1THx/1pTJDjOz6wNT
         829SL4hv/Ya0/VNIivMWirg8Rzm8aareylVGfCrYi5Xqar4TcRyjUB2l1+KnYx9NBb8g
         v8BCObBFxIocohrTtxRSDdX29oukh2h5/pH90biLyEMl+WAqotG27eHdlPBmtEYDkbrD
         0SWw==
X-Gm-Message-State: AOAM531mQijruMuK+wT+D9m1CsLC8hv0OT1JckNVCVOry4EFyH/rBWsw
	n8QYUgk9jgUCQYA5MvZzAx8FlA==
X-Google-Smtp-Source: ABdhPJyZ1AbDVoTedT+rrPMUoaxMor5L2dd+Ukbx7yrv0Pt8GC2p6WV5SFioQpH3Z0paNi5JRyC9IQ==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr3935896wmq.21.1612536158681;
        Fri, 05 Feb 2021 06:42:38 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:d1b2:8778:591e:ef47? ([2001:8b0:aba:5f3c:d1b2:8778:591e:ef47])
        by smtp.gmail.com with ESMTPSA id a17sm13142093wrx.63.2021.02.05.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:42:38 -0800 (PST)
Message-ID: <f07ad5d24c64acc060ae71e91973b869da27824d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 05 Feb 2021 14:42:37 +0000
In-Reply-To: <CAJkqNs2S2_JVZRpDgj_62zGmyqrLUyybDNy3z5wutn7RH_pWvA@mail.gmail.com>
References: <20210204221422.16042-1-tomasz.dziendzielski@gmail.com>
	 <1e3bfe4059efd60bf6ee4b31c1b81355f6657586.camel@linuxfoundation.org>
	 <CAJkqNs2S2_JVZRpDgj_62zGmyqrLUyybDNy3z5wutn7RH_pWvA@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-02-05 at 15:26 +0100, Tomasz Dziendzielski wrote:
> I can already see the bitbake test failed, after adding "if d" it
> passed. Sorry that I forgot to run tests before submitting a patch.
> Another thing, I ran locally oe-selftest -r multiconfig and build
> fails with "When reparsing %s, the basehash value changed from %s to
> %s. The metadata is not deterministic and this needs to be fixed".
> During the build it appeared only if I made changes to the code
> during the build. Here it's most probably caused because of events'
> handlers renaming.

That is going to be a problem, we need to make sure the hashes are
deterministic.

> Do you think there is some way to handle this issue or I should just
> add:
>          ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH") or
> '') == '1')
> +        if d.getVar("__BBMULTICONFIG", False):
> +            ignore_mismatch = True
> to bitbake/lib/bb/siggen.py?

No, that is definitely going to just mask the problem.

These tests are designed to detect problems which will cause us "pain"
later. The hashes are designed to be stable to whether something is
built as a multiconfig or not shouldn't change its hashes. The tests
are warning us that is happening so we need to fix that.

Cheers,

Richard

