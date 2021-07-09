Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.8430.1625820627468943543
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jul 2021 01:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N8HtlAJo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id f9so5434373wrq.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jul 2021 01:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ZWoLDnLTtrg6pWhETeNkcu/zFDj9J4Hie8243zUmLcs=;
        b=N8HtlAJoCF+m13xGbi0+qBLmGbFYXAah86euDZkgnwiTd55hyVWAFA/jbDPTMahZXl
         g7Uc5Aemy4YLhbWbjh/VXyatpq6Tlj/U/6kvBGRQCq58x1aR/dVtRrTEpaojgLW50WpQ
         bZGdcW5HprHuVjyvI9wjeBvz7ON9LsHJuLBDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZWoLDnLTtrg6pWhETeNkcu/zFDj9J4Hie8243zUmLcs=;
        b=ufivUALPKpazCbX0dvBpyEUQMrsDYnUas+DtOmRcJSKN/bS/vu6EUry3sC6BLOHu0k
         keXTSOIaaRqtZHdPBa6grg81P/mTRfuIHXOmr2rB+kDCvojFW7TRLuot20QSkykNk8e6
         8bItHwKS/ocBF4g4uhO+a2HQQBIkVmNl+E4m8NWb2jM4ORLNGIJ3vi59Eu3msx39w09g
         1orle+jSS5aD4wge8hRjLJeLXQbFL9ES97gjT7EJmQLIxbWCRL1S6t0Pq+kie9C8Knti
         lFGayiIyFO4Tsx5P70w22lWRjswbrcomxK9ERlrIxuTocJ7p1/RB1gh8y/NkPVbp/GSC
         e0Tw==
X-Gm-Message-State: AOAM533GVf3WPozzuMUmdMY+IxlWQtSWRhP7LoKhJvRv5HMP+798oiaa
	rKkwwjPjkvftzbi6WlXw+az/nA==
X-Google-Smtp-Source: ABdhPJwveYBXTGvecs7Ou5C7ijq44znqViCeomXWhWLl03CQZmIOXcxxLUpRpFAE7XIzVUSt2YwYNA==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr52010wru.24.1625820625972;
        Fri, 09 Jul 2021 01:50:25 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8784:9f68:1c6d:5aac? ([2001:8b0:aba:5f3c:8784:9f68:1c6d:5aac])
        by smtp.gmail.com with ESMTPSA id r18sm5008585wmh.23.2021.07.09.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 01:50:25 -0700 (PDT)
Message-ID: <d72c3eafc5e4327d97ab16382b66dc6b97b51a2c.camel@linuxfoundation.org>
Subject: Re: [PATCH] Add a new variable:'FETCH_ENV_WHITELIST'
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "jiladahe1997@gmail.com" <jiladahe1997@gmail.com>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 09 Jul 2021 09:50:25 +0100
In-Reply-To: <202107090944160361815@gmail.com>
References: <202107090944160361815@gmail.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-07-09 at 09:44 +0800, jiladahe1997@gmail.com wrote:
> From d228100b7551b2327d66072b03f2a809744e8f52 Mon Sep 17 00:00:00 2001
> From: Mingrui Ren <jiladahe1997@gmail.com>
> Date: Thu, 8 Jul 2021 23:44:53 +0800
> Subject: [PATCH] Add a new variable:'FETCH_ENV_WHITELIST'
> 
> The enviroment variables used by Fetcher are hard-coded, and are obtained
> from HOST env instead of bitbake datastore.
> This patch adds a new variable 'FETCH_ENV_WHITELIST' similar to 
> 'BB_ENV_EXTRAWHITE', trying to fix the problems above.
> 
> Signed-off-by: Mingrui Ren <jiladahe1997@gmail.com>
> ---
> The situation I encountered was that I tried to use a custom git-proxy by
> setting GIT_PROXY_COMMAND and SOCK_PROXY enviroment variables. However, 
> I found that even if I set BB_ENV_EXTRAWHITE, the SOCK_PROXY variable does
> not work.
> 
>  bitbake/lib/bb/fetch2/__init__.py | 16 +---------------
>  bitbake/lib/bb/utils.py           |  5 +++++
>  scripts/oe-buildenv-internal      |  7 +++++++
>  3 files changed, 13 insertions(+), 15 deletions(-)

The patch looks like it was generated against poky since that script is in
openembedded-core, not bitbake.

For the patch itself, I'd much rather add something to extend the list
rather than replace it entirely which would make backwards compatibility
easier.

There is also an issue with the variable naming. We have adopted a policy
around inclusive langauage so new variables need to be mindful of that.
We're in the process of trying to work out what to do with some of our
older variables names.

https://wiki.yoctoproject.org/wiki/Inclusive_language

Whatever we do to address this issue really needs to match how we fix the
existing BB_ENV_EXTRAWHITE.

Also, since fetching happens much later, we should be able to set this
variable from config such as bitbake.conf or local.conf and there shouldn't
be any need to export it to the environment.

Cheers,

Richard

