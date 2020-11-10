Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.34689.1605044336912379270
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 13:38:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dyUJwJJw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id p1so14315561wrf.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=8ORwxU/gIGR+IhjQ4VjX2DPsUFPmYUKT/1F+B4pymzA=;
        b=dyUJwJJwVLFS2DF9q+TfBR9WpI7EzuSAmS/oknImVb0AyEVBWO6tgpgtYT7kEdDFOq
         8eaSa+OGudBnrTazqSs30z1kWrEW/0152yPeeENV5zpPmffBTJit6lkBlGBUglMYxIbB
         RHnZ+VBpe2cHuLJN/UTlFYyfpALDe93B8Cvvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8ORwxU/gIGR+IhjQ4VjX2DPsUFPmYUKT/1F+B4pymzA=;
        b=luQjrjQam+jtkcasYH4ya2olanBWpWdBnkmQ3T6Udk6TpCGIoKMOLoU04/6mlCLEuZ
         HWgIuP94RHIkxC4Cd9/vCiGi33u/5BYameNyusKKyIMvVIVzjcgeIRJBB1ejJ52x1vMg
         4DdStvjf+fouXX+ttvNNknk220//gfQdCPTJyGX8dBRwWbEbpZQ2tnNyPGkCFCW0TWNV
         m3nACiwyRsRALHkatunyDsXeEcPj9g4stRyCcvK4Rz8nVYVnxVFqdtYndOp694Op/U4F
         2Oy1YNdoJsrNvjXhrzpQMvfBdu+Rc7dD4+mRacapU5xnf8j/gNlSdw/TI4X4rqrYnna/
         FnMw==
X-Gm-Message-State: AOAM530uA31AE0OHMWmmBDNR/E3eBpWZupfGBp/XsYSJy1mN+2b7MjHa
	IulkeKWIv0CpGvdzx6I6DYtCPg==
X-Google-Smtp-Source: ABdhPJxMRmSfrgHBqMkh/Q9t7hC2jJlEWMa5GjvxQbTMC6qi1yI+NqegxZLc4saR54f/dk4FSmkfDA==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr24628032wrq.151.1605044335450;
        Tue, 10 Nov 2020 13:38:55 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 2.f.3.d.1.3.3.a.9.f.d.f.a.e.5.a.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (2.f.3.d.1.3.3.a.9.f.d.f.a.e.5.a.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:a5ea:fdf9:a331:d3f2])
        by smtp.gmail.com with ESMTPSA id z191sm119195wme.30.2020.11.10.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:38:54 -0800 (PST)
Message-ID: <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Tue, 10 Nov 2020 21:38:54 +0000
In-Reply-To: <20201108221059.16854-1-chris.laplante@agilent.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-11-08 at 17:10 -0500, Chris Laplante via lists.openembedded.org wrote:
> v1: initial
> v2: fix intermixed argument parsing
> v3: fix TinfoilConfigParameters defaulting of 'ui' with string,
> reorder
>     patches

One other thing which would really help me is if you could either fix
your SMTP server setup so the list isn't as unhappy and therefore
doesn't present you as "Chris Laplante via lists.openembedded.org <
chris.laplante=agilent.com@lists.openembedded.org>", or add From: lines
to the start of the patches so the author is set correctly, or CC: me
directly on the patches so I get a copy which hasn't hit the mailing
list and been mangled.

I've been fixing these up manually but its getting a bit wearing given
the number you've sent. I guess the alternative is I improve my
scripting which may be the other options, its kind of inevitable.

Cheers,

Richard

