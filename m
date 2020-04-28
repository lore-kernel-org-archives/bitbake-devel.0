Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.4412.1588068211744984788
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 03:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aVZAK6lt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id t14so23889527wrw.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2020 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=+E+RY4y1/qZa7tWRYSiD3z+uJI891ILaj6DUekEmW70=;
        b=aVZAK6ltNJzfBSO3ezmJxi/deBmF5SrlJ+AcPF7DyRchEDrFOYHHQwuZUEXOACo35D
         rMVuc3CyNQo45JmYvsCxFR78ZmTT36e7bUerrzJlUWIlyfRXhPrzTs4VAygPoZpxQl4p
         eCYvAbYKa+vGxlVeMy7018CI7lVKMDZqcbobw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+E+RY4y1/qZa7tWRYSiD3z+uJI891ILaj6DUekEmW70=;
        b=GpOYGGwOcNHfZT2OE6Sym06Cvh2Jp6JE+jlAVmoXW7+DlsaO0wDx1A4CGSxOWdT/TN
         tzclG9mUlPx7N6IB6OcwCTF/KUuHQx9C5qAfI22YT1tvmomkrxeHln1jJpGhMh6Q+5pj
         iWCa5fWoyU6/WPj30JFbRdVgCeUVErvTK80fk6KwvA0izlhN4jKMG3IzQ2CTItG4OCAd
         4UHJgWkJ5Hu8g97nbPapl66FsjtjgiUEIHNbD9qxqiqw2sWWxzDKgPGGFpDPG3Ev2JMv
         8bzZOhWe4in0VkCYdiBaOWZjOinKUCCR1BQAGW/Tv/yfCWuhvSQRoLbG/Cr06viRfVMU
         aERA==
X-Gm-Message-State: AGi0Pubn8Xf7gs/pOgjjO3FfSZfsYDyxgkQfoeTojf7/BhXf9phS0V8t
	eUvGQ4vI3rT0DcBxAgUNuIE0eQ==
X-Google-Smtp-Source: APiQypLG48qLDpYW6eulYEuJQ4dOPnugRxxtRieKPLyruZbpWux3i8D3iUQ4JIR8C/YjQ4C8UCMitw==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr34967115wrp.39.1588068210172;
        Tue, 28 Apr 2020 03:03:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id y7sm2765303wmb.43.2020.04.28.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:03:29 -0700 (PDT)
Message-ID: <8847750bf3a00ee08c38dc6c2c192d3ddff73928.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [1.44 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: akuster <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 28 Apr 2020 11:03:28 +0100
In-Reply-To: <282920d985d63db6f2284718dc3db2196c6fbf6f.1587931627.git.akuster808@gmail.com>
References: <cover.1587931627.git.akuster808@gmail.com>
	 <282920d985d63db6f2284718dc3db2196c6fbf6f.1587931627.git.akuster808@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-04-27 at 19:17 -0700, akuster wrote:
> From: Peter Kjellerstedt <pkj@axis.com>
> 
> Mark any keys used to cache the srcrevs for a recipe as "dontcache" if
> BB_DONT_CACHE is set for the recipe. Remove any such keys upon the
> next bitbake run even if BB_SRCREV_POLICY is set to "cache". This will
> make sure the srcrev is updated as expected if ${AUTOREV} is used.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit ba093a38539960e645e994a66ed7872a604c00a9)
> Signed-off-by: Armin Kuster <akuster808@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

This was later reverted, so no:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake?id=12fc1c5637bca79a7a5735d9a8e819aefd0dd19b

Cheers,

Richard

