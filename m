Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.5474.1596105456797950227
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 03:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hH/mS08N;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id 9so5245438wmj.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2020 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=EZck0rrL0q96VW8Z7dIsk2+DfIGTmBu4NPhW/OpILZ0=;
        b=hH/mS08NpmLgAlnpwTB+N04bhJydPaPQMxVhMhuWBOTf1X1Jepcx0YvBLyLewh7hFq
         vvv/EiKLKrONWqToDEy5AlbUmWycKSpXwf1OQNHQUV3PmVSM77Lvd9+6bOxIC0Kei/nV
         TD4iEhHaSqFYcOhhhuZrD5/X/k/5m4wOQKcNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EZck0rrL0q96VW8Z7dIsk2+DfIGTmBu4NPhW/OpILZ0=;
        b=WT7CCS3s4JxNUErBMP0ttYt4Lfsqhm9ZhKDG9QyEkwqU3tGLtaa7n5cDtUtYVMOqO4
         nxxl+pSSJAO8mLi12ItXh9lWEK5b80kItvU1LPCHgaEdOD7N7f9NUkxKIC8Rml1ssZW5
         bDbZmlf930Cz3UpWbzsBN+BZBig0j1OXMqvXY2AvrdM1v0ol59qGq8yCQUbNVmqd79ry
         ZKIJ7t3wEhFLOG4UXDRdjwtpBiz07pds5aX+KVmviDDpWRwmuDSGd4tamJ6AVN4iArTx
         ICTaX13fBf0Q1zIgtukm5v+jPsWLwJjD3/YMn+5NqTu2BCypo9X+SAsKdMKbkIqKSNYv
         rRTg==
X-Gm-Message-State: AOAM533+omIAGHnMs9Eco2nX3kBDvn3Zgl7gqcww+WcxA4oNudHom7ii
	xb9oDAsxxQu5V61XMjUQzmBcBTIJAu/+vw==
X-Google-Smtp-Source: ABdhPJzA8BYbXFK+lPy89up7MG7jXPNGCeGR3sp/stD3QQ/i4PsvxfrBxfeUlFgX1oPhORBLw9GLpA==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr13359245wmq.182.1596105453959;
        Thu, 30 Jul 2020 03:37:33 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 6.8.9.6.7.0.f.f.a.f.4.5.6.3.d.d.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (6.8.9.6.7.0.f.f.a.f.4.5.6.3.d.d.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:dd36:54fa:ff07:6986])
        by smtp.gmail.com with ESMTPSA id z63sm9712301wmb.2.2020.07.30.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 03:37:30 -0700 (PDT)
Message-ID: <dee49e85c1eab606b528add87d52af439ad898b0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] cooker.py: Save prioritized BBFILES
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2020 11:37:29 +0100
In-Reply-To: <20200730092342.7420-1-liezhi.yang@windriver.com>
References: <20200730092342.7420-1-liezhi.yang@windriver.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-07-30 at 02:23 -0700, Robert Yang wrote:
> The original code saved BBFILES back to BBFILES without changes, I think that
> it was for avoiding undefined BBFILES. Now save prioritized BBFILES back which
> is more usable for the one which requires it such as bb.utils.get_file_layer().
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  lib/bb/cooker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 3a58a3a33..5571e5312 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1738,10 +1738,10 @@ class CookerCollectFiles(object):
>          collectlog.debug(1, "collecting .bb files")
>  
>          files = (config.getVar( "BBFILES") or "").split()
> -        config.setVar("BBFILES", " ".join(files))

I traced that back to 2007 but didn't go further. I don't think we
should be writing this value back at all. Its going to confuse anyone
trying to understand the history of the data in the variable.

>          # Sort files by priority
>          files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
> +        config.setVar("BBFILES", " ".join(files))

If we want to make this information available to the wider system, we
should perhaps have bitbake API for querying these kinds of things?

Cheers,

Richard

