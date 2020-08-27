Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.27028.1598556518167287178
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2020 12:28:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g6ibKhpM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id b18so6423904wrs.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2020 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=FT6bFOCWoYrO+SnWst6LnCN2Nc9X7tZehYHYsFeBKdo=;
        b=g6ibKhpM6b3Iqz2DJ2jt/UKqP2MX4byc0cZDXAvinlKdjkDujLAJlE3VkIw0mMtNO6
         CCVOK7mQsg0sU454opALN70pI8+DWjIEtQgtRLwPHH3ggtYLdCLxm6Fmli4aJIJtvagJ
         CblnMAEOsxLGltEmv2aV4rcfRmORWhobF2OIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FT6bFOCWoYrO+SnWst6LnCN2Nc9X7tZehYHYsFeBKdo=;
        b=OGAecEvkZ+bG6YtlG7bep49Kj/XqcuSBBbbMjmhjSLVZJcekS6nR2EgTKvoBW7tHZp
         6w4HfmQotew7f/xNYgrpB1OSMt3fJs+C+eug/ghOr43l1DDbRSuFk5Prd/ksmGh01c7V
         oWlDesHqyi6l7Gu7c0UIJ5qTqTjRg7ut4JXa4MSAG4s+RSlTnpmeOE/GSXPYlxYTJeMw
         7RdzIqpRaQxfdRKAxeyTn9ouNQGwdd5DL3NIUkdoAeAQRWX9HDxfk4R4Y78zUJp4qc9I
         jVTGsjh0LlkU06qocv23nADUyb4gDcRukIuxuBKPoeghdDK+bI9A56WVqfHt+H6yjRSR
         gNvA==
X-Gm-Message-State: AOAM531K2hPXkfJHUigH2Oubo3wbkOwx6DdkBMQAGjN2jciEp3yYfyxy
	/lFiJEwR7rU81nlqbxsdVVUkcg==
X-Google-Smtp-Source: ABdhPJysxZPCVe3IKK0hbc9hIrZNuNwoqgOMKQ1kbMM/dagQG4m/0qNOBwGTU/KVBo7zB7LuuSKgmw==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr18557146wru.358.1598556516458;
        Thu, 27 Aug 2020 12:28:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c407:538:d07:8b9d])
        by smtp.gmail.com with ESMTPSA id t25sm6754011wmj.18.2020.08.27.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:28:35 -0700 (PDT)
Message-ID: <59cafb789dc3c57bceee16372f306dfff1cfb218.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bitbake: fetch2/npm: allow to build npm package with no dependency
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 27 Aug 2020 20:28:32 +0100
In-Reply-To: <20200827192537.3091416-1-sandra.tobajas@savoirfairelinux.com>
References: <20200827192537.3091416-1-sandra.tobajas@savoirfairelinux.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-08-27 at 15:25 -0400, Sandra Tobajas wrote:
> In the case of an empty npm-shrinkwrap.json file (with no
> dependency),
> the npmsw fetcher was causing a RecursionError reported in [1].
> 
> It also happened if the package has only "dev" dependencies and was
> built
> without --npm-dev option.
> 
> Add sanity checks to ensure that the dependency list is not empty and
> set
> the urldata proxy attribute to None if no dependency is found.
> 
> [1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=13901.
> 
> Signed-off-by: Sandra Tobajas <sandra.tobajas@savoirfairelinux.com>
> ---
>  bitbake/lib/bb/fetch2/npmsw.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Thanks, do we need to add any test case for this?

Cheers,

Richard

