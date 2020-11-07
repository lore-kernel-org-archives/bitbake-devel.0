Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.5699.1604709204970942198
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 16:33:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NJXzJkC0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id w1so3042088wrm.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2020 16:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=C4HPqEp1fiNE/NjssV4bgEbZhPK+sZxBSFCzZVek7cs=;
        b=NJXzJkC0TSXu858J9eCr1deTLijteEsHXcDUgs41y4TJmrlMMPyc5kJW5ltPQNVCpS
         D3BL3yAY2iP+cttNv7CAdLYHiFXlzvn1k5NWHjY/vU0zABZ+rL+8WHryZ8JaNN/xfmlW
         IkamMcaERLA9LwkgfrUASne//yzlG2tPbKLFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=C4HPqEp1fiNE/NjssV4bgEbZhPK+sZxBSFCzZVek7cs=;
        b=fNT+zJhvs0SgrgZrzB3whLc6UdYWtgjb7ek1O5Dadt1t5uVSaZ5BWBnUlYhKg91a2K
         1bG35qRK9KvJnYCfRwaEsm/joCw2MoVgUREQgQveUkqHAarEMQitZuSFyqsEdnqgxXCF
         oYAWmHNj9s5KqgqFKOY/El8tft3w8weMJ1VMDwPqHT1Vm5iZU3Ae5HnXe80gyor+478/
         mRXFssZgwT2dyV1WOvRBdYCZ0F0EKdGG/8lfyQuFBjpsq7UIXMIUBAJ/0pgnD8S6CKJX
         O7qQ7+aVwL7+Wx5y/LonnGFdt/fgwaq9ET34oSD7xsT3Tl2Yb9VoMbooHLzYLCSTv+fZ
         Xv2w==
X-Gm-Message-State: AOAM530IvPvZB9Lpq82Hnxr6cHWQdzYmMN88s9hqG/zwNfFGfzDkJtm9
	85CFZNyOQEwqVodNjA0i0ZBwLQ==
X-Google-Smtp-Source: ABdhPJzcoouCTJhiw7PcFkCbDbIftIunrdNDItzOqDGPiwXYqV1MviB9KfRlz8/u25S/cCNaBdF5fw==
X-Received: by 2002:adf:f101:: with SMTP id r1mr5682230wro.392.1604709203347;
        Fri, 06 Nov 2020 16:33:23 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (7.e.4.c.9.7.4.3.c.6.2.9.7.2.8.5.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:5827:926c:3479:c4e7])
        by smtp.gmail.com with ESMTPSA id c8sm4289485wrv.26.2020.11.06.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:33:22 -0800 (PST)
Message-ID: <af501cd1ff6fd7422f44367bd9bdc53c81558fbd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] main: migrate from optparse to argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Sat, 07 Nov 2020 00:33:20 +0000
In-Reply-To: <20201106143457.81958-3-chris.laplante@agilent.com>
References: <20201106143457.81958-1-chris.laplante@agilent.com>
	 <20201106143457.81958-3-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-06 at 09:34 -0500, Chris Laplante via
lists.openembedded.org wrote:
> Modernizes the argument parsing code and opens the door to grouping
> the options (e.g. YOCTO #12018).
> 
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/main.py | 264 ++++++++++++++++++++++++-----------------------
> --
>  1 file changed, 127 insertions(+), 137 deletions(-)

In testing it seems "bitbake world" no longer works?

(e.g. 
https://autobuilder.yoctoproject.org/typhoon/#/builders/39/builds/2683)

Cheers,

Richard

