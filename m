Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.43012.1622460343922756361
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 May 2021 04:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EnScp+vd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id r10so10507614wrj.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 May 2021 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lhAlTlfDtGNi+/jBsRGoFlUr7jeW7nhN1Ayt37/yX+Q=;
        b=EnScp+vdDlCqtx4CfjC5zkp4L52LxvmXv+ZaYlE4/jgxm5fnleBPoUJe13EVh0zGbQ
         V3NsYtLl5Ki9XWr8OHuUfq1/QX92gz+tddcnxGJINNhA2g3piUA13AlwLkL9XRtvg+T7
         csyMForWFKqKehwiWOrCdH6ecR1mpZVeYBceY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lhAlTlfDtGNi+/jBsRGoFlUr7jeW7nhN1Ayt37/yX+Q=;
        b=QXLTVvdSlzVdCVrrcqEJ3yAoUomaC9ZJ4zCsjz0/cq0KApF4oAZDVGh5jSkCnrW07K
         /O+AFHo1D9IC4xkOYv3A1x2RH41KL/UsSAHQ7imckbbzvMBYTt9ucSb3CE1IiLcWj7N4
         UVTvb2a/8Q6umTCZN9xIMkAkvuLL+txOIJgOQInGMrSVA/WgCQgmhakPSU52CJ1jzISx
         hwM/UcOexYh1vnIkMEw2cFQmzgGtwwzerWLG4ivr5tGqkyr6c1TF50LEFMOXBs4TRvvX
         xKZ+thfGaLCizXOqSk6YiS1pULhUfz1IRCAfQ/dGiK9oIjRdOTJvxMd9YlWwdoM27NE3
         D9Uw==
X-Gm-Message-State: AOAM533hASqoudXHqRETkHgeuTuH8oWVpzujZnfvQ0p7h6Uxp3kfVliY
	XiVpibFovSVsVAJuFgtZp320HA==
X-Google-Smtp-Source: ABdhPJymIr80cS0tKzI/glfBb1mDlNsrJZ4efC1tL2BrFzJc/AMT7aKxi+obMa6At660j5kdaImKtA==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr15351469wrt.169.1622460342128;
        Mon, 31 May 2021 04:25:42 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:fcab:51bf:ac39:992c? ([2001:8b0:aba:5f3c:fcab:51bf:ac39:992c])
        by smtp.gmail.com with ESMTPSA id s28sm4141113wra.54.2021.05.31.04.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 04:25:41 -0700 (PDT)
Message-ID: <b258e09be64468dcdf685cb9f7f26a011cb7f2af.camel@linuxfoundation.org>
Subject: Re: [PATCH 0/4] Re-implement prserv on top of asyncrpc
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@konsulko.com>,
 bitbake-devel@lists.openembedded.org,  Joshua Watt <JPEWhacker@gmail.com>
Cc: swat <swat@lists.yoctoproject.org>
Date: Mon, 31 May 2021 12:25:39 +0100
In-Reply-To: <20210528084209.8408-1-pbarker@konsulko.com>
References: <20210528084209.8408-1-pbarker@konsulko.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Paul,

On Fri, 2021-05-28 at 09:42 +0100, Paul Barker wrote:
> These changes replace the old XML-based RPC system in prserv with the
> new asyncrpc implementation originally used by hashserv. A couple of
> improvments are required in asyncrpc to support this.
> 
> I finally stumbled across the issue which led to the hanging builds
> seen on the autobuilder when testing the initial RFC series.
> It was a fairly dumb mistake on my behalf and I'm not sure how it
> didn't trigger in my initial testing! The
> `PRServerClient.handle_export()` function was missing a call to
> `self.write_message()` so the client just ended up stuck waiting for a
> response that was never to come. This issue is fixed here.
> 
> I've ran these changes through both `bitbake-selftest` and
> `oe-selftest -a` and all looks good on my end. A couple of failures
> were seen in oe-selftest but these are related to my host system
> configuration (socat not installed, firewall blocking ports, etc) so
> I'm fairly confident they aren't caused by this patch series.

Thanks for these. Unfortunately I think there is still a gremlin somewhere
as this was included in an autobuilder test build that is showing as this:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2203

i.e. all four selftests have not finished and I'd have expected them to 
by now.

I'm trying not to work today so I haven't debugged them or confirmed where 
they are hanging but it seems likely related.

Cheers,

Richard

