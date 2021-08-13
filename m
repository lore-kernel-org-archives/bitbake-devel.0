Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.43280.1628892025277210670
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Aug 2021 15:00:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RX/pu7YT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id x10so8798173wrt.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Aug 2021 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nS0ozX7uKLURp7SpmYbLL82GjIu1AmogerSM0EYBAAY=;
        b=RX/pu7YTTxW4/fM6utMlpcCE9TtPSZ/fhG0zio/M3qp1PScDNqjL5JDRWliQhzEJ7J
         tAvSWoDaLGJRf3qs5uvtC69ouYvamgIJj0tNCzhSCI9drRGeVEnObqzftmB2J1lQbxKK
         huPVuxARk5erM2bDsddTlxibeb/la+NlQ4mpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nS0ozX7uKLURp7SpmYbLL82GjIu1AmogerSM0EYBAAY=;
        b=YhMswbLmChaZTviYBNEbw79EA47xg5CXZhWtY/KHRm4puBjVPnxY2l9e2QxcLGSINH
         DC55s3y+ZgrJe+/Kr43AtsASXSb3nyABnxTTgrP8d3ksnXclrMoDIjtIZEEymPXQF3ni
         lWJmZ+7+e6rxoeZbSt6GPdnATrRznuopLshbWnlSCm6mBYb6fwgvwKsRy9x15SZ5N0cD
         Dh0YsI7HOJNr0ORZPGCE2C+6xZKKxLogjGO9+X/PnQgCRxcreVnqFhuJ3LwE/Fkh0j14
         /waMzaSPi1Y/GwouZidzzU0Sv46Jin4w/IV66mYId/oZjbGjrot1hGkc5iCACm4LzcHj
         SmCA==
X-Gm-Message-State: AOAM530ZoDho/KyE5+fXlO57n17Qj6kjghsi98gMMQTCWWhG+Eh9+rnz
	OuBlRR/l+CBsRrxIWztWNJfifX9mOFCsIw==
X-Google-Smtp-Source: ABdhPJwOdKPkfG1c7VwhR4L328L7ZWGkwo+vcAT+SHFHXW5xWdjzVEGN0GfSY03XEhU93Vodt0lo8w==
X-Received: by 2002:adf:db83:: with SMTP id u3mr5485369wri.363.1628892023917;
        Fri, 13 Aug 2021 15:00:23 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:ef44:3f5a:be32:a2fd? ([2001:8b0:aba:5f3c:ef44:3f5a:be32:a2fd])
        by smtp.gmail.com with ESMTPSA id h126sm2594423wmh.1.2021.08.13.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 15:00:23 -0700 (PDT)
Message-ID: <dd60618caf5cc533bc9665a0583b6a7afbcdc4da.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 4/4] fetch2/wget: fetch securely by default
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Ross Burton <ross@burtonini.com>, Michael Opdenacker
	 <michael.opdenacker@bootlin.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 13 Aug 2021 23:00:22 +0100
In-Reply-To: <CAAnfSTvxcxK6budbRk9UP+YxECHzCkxRygO6SG1V5tL-v836Aw@mail.gmail.com>
References: <20210810165509.19121-1-ross.burton@arm.com>
	 <20210810165509.19121-4-ross.burton@arm.com>
	 <86a39b80-209b-8fc5-7239-ef6cf3541f55@bootlin.com>
	 <CAAnfSTvxcxK6budbRk9UP+YxECHzCkxRygO6SG1V5tL-v836Aw@mail.gmail.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-08-13 at 17:41 +0100, Ross Burton wrote:
> On Wed, 11 Aug 2021 at 14:46, Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
> > 
> > Hi Ross,
> > 
> > Thanks for the patches!
> > 
> > On 8/10/21 6:55 PM, Ross Burton wrote:
> > > From: Ross Burton <ross@burtonini.com>
> > > 
> > > The days of broken certificates are behind us now, so instead of always
> > > passing --no-check-certificate to wget, don't pass it by default and
> > > instead only pass it BB_CHECK_SSL_CERTS = "0".
> > > 
> > > [ YOCTO #14108 ]
> > > 
> > > Signed-off-by: Ross Burton <ross.burton@arm.com>
> > > ---
> > >  .../bitbake-user-manual-fetching.rst          |  4 ++++
> > >  .../bitbake-user-manual-ref-variables.rst     |  4 ++++
> > >  bitbake/lib/bb/fetch2/wget.py                 | 19 ++++++++++++++++---
> > >  3 files changed, 24 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > 
> > This patch looks good, but your patches seem to apply to the Poky repo,
> > not BitBake. Wouldn't be easier for Richard if you submitted patches for
> > the BitBake repo instead? That's where the patches need to go, if I
> > understood correctly. Unless there's a workflow I'm not familiar with...
>
> In my experience git has been clever enough to notice that the base is
> different and will apply the patches anyway.

Sadly not, I just fix this stuff up locally and deal with it. If I were to
do anything more, I'll get told the 101 other ways we should be doing it 
and/or put people off sending patches and we really don't have the bandwidth 
to change right now.

Cheers,

Richard




