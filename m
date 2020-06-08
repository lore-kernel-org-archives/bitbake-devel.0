Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.1661.1591648340889793999
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jun 2020 13:32:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QxZ7TAjC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id j10so18898240wrw.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jun 2020 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=/XRAfNTIwdUdKa+gGIyD3No/sDlh29agDIOd11hiMUM=;
        b=QxZ7TAjC8/ajfMKwiiDH81C0ABTgbMl2Tpb/T7fY72NUaxtEL3XXujx2GKoZdd4oUa
         jZcC9qSv9xCOncrG0CgC1PMUCol4LJRBceOjsLU0sZFBRYBu3KQbIqZVZGuUHOrgT2dX
         T+L7kVEMiMQStIpumwXk1Lw3KGwS/B+uG0QxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/XRAfNTIwdUdKa+gGIyD3No/sDlh29agDIOd11hiMUM=;
        b=etgF0IsD1Lfr/6RIMD0tocREzT6AZxUFs0YRS4gDtuUNhHm+Nzhayo+k/+z8zbD0tJ
         7w7Kx8bN5i2tGWqB5wg7rqPUW8PYJzrCriJuWOX4jlhiXIKl0YFrmmTTUf+Dw6I0KJ8k
         WR/zAexor35TRkLVaDxpE2xlCA8pdt+lxPVYay6ZpvllBsqPq3XM5Db/mT7KDsppNzCU
         egOnBXES4U+4jbPdywUg+x/YWkg9dQQ5BfJZF8vp/4PDhVP/tHZET1lWtIckDLlzcECO
         1tbDnfaG0HGRvWMI9Kekb+hOUDUgv+pUheT8ljw0m9vQ7TxGqTihTyKJQWq4fFA/SxZc
         037A==
X-Gm-Message-State: AOAM5330pEOtekJfXHZuH7l4fPPPOfE0RJblE/O4I73ZvQcUH2GDUG4A
	ZJ42Lf/PUqC4SvgBN0brdjXhpA==
X-Google-Smtp-Source: ABdhPJwuMuoJdAmBIKoBTkchzFBl1Pvf/oA05ycUaUQGkBXZHk6C5SlRGKeoqa0+3f9DABGS8/PL/A==
X-Received: by 2002:a5d:5483:: with SMTP id h3mr615181wrv.10.1591648339402;
        Mon, 08 Jun 2020 13:32:19 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id v27sm917889wrv.81.2020.06.08.13.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:32:18 -0700 (PDT)
Message-ID: <1aedd9f81afd4d3855c56412cdc5ce1ac0ca82c8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v5 0/8] Add support for per-multiconfig BBMASK
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 08 Jun 2020 21:32:17 +0100
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
	 <20200606031536.15956-1-JPEWhacker@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-06-05 at 22:15 -0500, Joshua Watt wrote:
> Splits apart the bitbake configuration data and caches so that each
> defined multiconfig can specify as separate BBMASK independently of
> the
> other multiconfigs. This can take multiple forms, such as a `BBMASK`
> in
> a multiconfig .conf file, or BBMASK assignment based on an override
> (see
> linked bugzilla for an example).
> 
> The most noticeable change is that bitbake now keeps a parsing cache
> file for each multiconfig instead of a single parsing cache file that
> caches all multiconfigs.
> 
> [YOCTO #13721]
> 
> V2: Fixes some syntax errors in tinfoil
> 
> V3: Optimizes caches so that each one only caches the files for it's
> own
> multiconfig
> 
> V4: Fixes compatability with Python < 3.6
>     Renames split_pn -> split_mc
> 
> V5: Fixes oe-selftest errors

I think there is an oe-selftest issue still left on centos7:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1024

(and I've messed up the bitbake selftest patch merging I think :/)

Cheers,

Richard

