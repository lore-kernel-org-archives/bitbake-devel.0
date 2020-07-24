Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.616.1595570513611495519
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jul 2020 23:01:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Gep/eNju;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 3so228704wmi.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jul 2020 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=7TdQqLbGZ4sZLd2t9yqXoqvTx+XPFCiDJg4vuDNi5n0=;
        b=Gep/eNjucdgOSW3P+dHDehDvZM5HH2MmsaY9pYMaCHBecKqTd6pHiSHuPwkv8lDs4h
         Ge9DYsDxGLDCnP6MttMXP8KqAA1Py50u6Nq6jEyY5jCTatPdFjvlMlkD0PQkN9KmEVMg
         +jFEoIINt/oni0w14Q1lQTvbQG/67s59tTRzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7TdQqLbGZ4sZLd2t9yqXoqvTx+XPFCiDJg4vuDNi5n0=;
        b=Td0eDDNxp1HaU1G8XNAQzDm2IIPWRKKuelI/oK7m6FumOjjGnbobQjED0BRZcLHxrb
         1aZDvMJVFQKos8fdQ48sQmrSO6xXtmP50S0Dx66MRfbnjuyV6va4mYKiSB6zOrxJgmWG
         EUOHrmVbnemdtOjd+JFQkEhj8j6YdPHhAPE565jSAqYvzCOSfMy+FOTdnZ20CRRJIOmP
         1pUm6/uAfigskSi6eNRHlZfVDZNgxD40O/+Vk34Kad4goHxLI5oger8CIjIg0sCqEU9t
         aHz7ksf5aaPGGknI3vLMA7lNrdf5p0gt/4M6VhE+JfW9Gn99vdgboYRwupREFP1WNv2n
         quhA==
X-Gm-Message-State: AOAM533k3qjhWVjDUrEo3mAMLGdb3Itgz9OISPyRbmrow0QTKmyYciMw
	vZS8j0ASnYw1ql7x0Xg4tymSIQ==
X-Google-Smtp-Source: ABdhPJwMvAC71vfo1nIWqvljhCH3E8X4GQ74zX/Axftse7FYfchRtB1WWd1Bbfm2THiCDPE3CtR76w==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr7512479wma.4.1595570511886;
        Thu, 23 Jul 2020 23:01:51 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from f.a.5.c.a.d.d.d.3.0.d.d.c.1.8.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (f.a.5.c.a.d.d.d.3.0.d.d.c.1.8.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:981c:dd03:ddda:c5af])
        by smtp.gmail.com with ESMTPSA id j5sm5605892wmb.15.2020.07.23.23.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 23:01:50 -0700 (PDT)
Message-ID: <48c641c1f8be55e4e6bb862f543df9178b8ff69f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH][master|dunfell|zeus] knotty: ignore pipe errors
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@bmw.de>, bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jul 2020 07:01:46 +0100
In-Reply-To: <20200723145812.14029-1-mikko.rapeli@bmw.de>
References: <20200723145812.14029-1-mikko.rapeli@bmw.de>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-07-23 at 17:58 +0300, Mikko Rapeli wrote:
> Piping bitbake output to another process like less currently
> results in an ugly error if the other end of pipe exits
> before bitbake has written all output to it.
> 
> For example with "bitbake -e linux-yocto | less" and
> pressing q to quit less results in:
> 
> Error in atexit._run_exitfuncs:
> Traceback (most recent call last):
>   File "/home/mcfrisk/src/yocto/poky/bitbake/lib/bb/event.py", line
> 133, in print_ui_queue
>     sys.stdout.flush()
> BrokenPipeError: [Errno 32] Broken pipe
> Exception ignored in: <_io.TextIOWrapper name='<stdout>' mode='w'
> encoding='UTF-8'>
> BrokenPipeError: [Errno 32] Broken pipe
> 
> Fix is to use default signal handler for pipe signal. It's
> perfectly normal that on Unix systems the other end of pipe
> gets killed before all data is written.
> 
> In some cases there seems to also be a loop which results in
> a large number of "[Errno 32] Broken pipe" messages printed to
> console until knotty process is killed. I think this also
> fixes those cases.
> 
> This patch applies to master, dunfell and zeus branches.
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
> ---
>  bitbake/lib/bb/ui/knotty.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/bitbake/lib/bb/ui/knotty.py
> b/bitbake/lib/bb/ui/knotty.py
> index 87e873d644..56ac41d0f9 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -29,6 +29,9 @@ featureSet =
> [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
>  logger = logging.getLogger("BitBake")
>  interactive = sys.stdout.isatty()
>  
> +# ignore pipe errors since they are normal
> +signal.signal(signal.SIGPIPE, signal.SIG_DFL)
> +
>  class BBProgress(progressbar.ProgressBar):
>      def __init__(self, msg, maxval, widgets=None, extrapos=-1,
> resize_handler=None):
>          self.msg = msg

I think but have not 100% confirmed this caused the failures in:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1200

(new build running to check)

Cheers,

Richard

