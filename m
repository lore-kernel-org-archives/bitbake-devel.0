Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web09.312.1615502955989402802
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 14:49:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bAHLQa/a;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id g20so2685474wmk.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Mar 2021 14:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=nuoDlku1CD7OlvXW0PT5FgeEEPcFnh3Uuajf2U8r1RA=;
        b=bAHLQa/agBLJAUcZ8evGWSyizt0bL9RytaFB2JXUcDgvBx9uDh+7Ql4wcNT1fI1nnv
         lfvlyNl5w1gp1Fcihq5JOHgQNimdIU4c88kfbG6f6cwmyBHpZWpvTV070TSBuUEamBKj
         v+Q3l16z7H+q8Cj3FQkcCvbbjm5GaFMOnQjlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nuoDlku1CD7OlvXW0PT5FgeEEPcFnh3Uuajf2U8r1RA=;
        b=SK0fOAAjw1A/2q9iFgtYF6gsUTM9fJJ2FFWz553soSNJYdhQJWqJYqs1dSG4/Wgxv2
         ftoEQk+AuqDkJpxBvb8ocXm0YCaxlwsKpGIB5p5+8mSUSpAY3wEU6fH0sayoJzGoHUNE
         eHAMHOZKFLsXrFSJ4bARj0mEpeesq+IwEj6peNwu+5Pic/jGg+yUFNlfaWSKCZ+tywfP
         rJK/2OF7NpkWbwbtkdh2Mcr3dEqsU3zHh9XF4wi3gXQ+XMo0FHZZ6vUW/CX6/qoAiDmD
         a51QvpawZZ/4iDR8Cbm7OXc5DGjbEdNUlFYQqlJ+OpZdugSuhPmWm/WfZzPrekffUUJQ
         rHEw==
X-Gm-Message-State: AOAM530qRVsLbjDBkh75olG8C+ncxTvCk1JhAvJpVtFjzpVSZdnMJ2P2
	6+j5QjL6fiRYcSXp6bqi7jHfnw==
X-Google-Smtp-Source: ABdhPJxnh0POCBSbKNGptAdKe3uTt6zD2QU32GdLCon9hQ6qpuCFBV7G7zkSGH0bcC75WHmcFSEPeg==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr10259765wmd.78.1615502954466;
        Thu, 11 Mar 2021 14:49:14 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:7cc6:73c3:839f:86be? ([2001:8b0:aba:5f3c:7cc6:73c3:839f:86be])
        by smtp.gmail.com with ESMTPSA id m17sm5906596wrx.92.2021.03.11.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 14:49:14 -0800 (PST)
Message-ID: <06120a8293bdb7a251fb7fb71f253f42e50aa3ff.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] event: Fix multiconfig event handler change performance regressions
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 11 Mar 2021 22:49:13 +0000
In-Reply-To: <ea3cf67c8b174f3eab75d68d14e72440@XBOX03.axis.com>
References: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
	 <ea3cf67c8b174f3eab75d68d14e72440@XBOX03.axis.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-03-11 at 22:14 +0000, Peter Kjellerstedt wrote:
> 
> While this greatly improves the situation, it is still not good. Here are some 
> numbers for me when parsing poky + openembedded + our layers:
> 
> poky + openembedded + axis dunfell
> Parsing recipes: 100% |###############################| Time: 0:00:39
> Parsing of 3935 .bb files complete (0 cached, 3935 parsed). 
> 5767 targets, 711 skipped, 0 masked, 0 errors.
> 
> poky + openembedded + axis gatesgarth
> Parsing recipes: 100% |###############################| Time: 0:00:39
> Parsing of 4051 .bb files complete (0 cached, 4051 parsed). 
> 5490 targets, 726 skipped, 0 masked, 0 errors.
> 
> poky + openembedded + axis master
> Parsing recipes: 100% |###############################| Time: 0:01:07
> Parsing of 4111 .bb files complete (0 cached, 4111 parsed). 
> 5607 targets, 732 skipped, 12 masked, 0 errors.
> 
> And here are similar measurements with only the poky and openembedded layers 
> (meta, meta-poky, meta-gplv2, meta-oe, meta-filesystems, meta-networking, 
> meta-python and meta-webserver):
> 
> poky + openembedded gatesgarth
> Parsing recipes: 100% |###############################| Time: 0:00:17
> Parsing of 2289 .bb files complete (0 cached, 2289 parsed). 
> 3537 targets, 91 skipped, 0 masked, 0 errors.
> 
> poky + openembedded master
> Parsing recipes: 100% |###############################| Time: 0:00:27
> Parsing of 2354 .bb files complete (0 cached, 2354 parsed). 
> 3659 targets, 64 skipped, 0 masked, 0 errors.
> 
> I have attached profiling logs (first 40 lines) for a gatesgarth run and a 
> master run. If I read the data correctly, it seems that during the master 
> parsing, there are a lot of calls to fnmatch.translate, posix.read and 
> _posixsubprocess.fork_exec that are not there during the gatesgarth parsing.

Was this with or without c3f6fee42bfa23f23f167cb29f0cfa05ac2fa197 from bitbake
master?

If with, please send those full profiles to me offlist. You're right about the
increased re.Pattern objects, there should be information further down about
where those calls came from too.

Cheers,

Richard

