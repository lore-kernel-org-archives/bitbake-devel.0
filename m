Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.24057.1591304429513250199
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 14:00:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DUxEHSQW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id r9so6531815wmh.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LrwTU6iIT42SWXZmmT5O8WmSPL5e069RQFv4dGulzvU=;
        b=DUxEHSQWchlVXxoqQotM03WsjB3DVR9WknHbKKFqQ3lp/58h3rIdRKabMFHPyRQGuZ
         aeYH7rOUmm871189QLHwMwRX6LCL9hzbfxVnrUFXBRKZxonxqU8PdpH7CpGMrzIATfdy
         CIr+PClswlO58nMcBPVwVrqZnGtapdPS88nwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LrwTU6iIT42SWXZmmT5O8WmSPL5e069RQFv4dGulzvU=;
        b=tppTEviDA58682uahPrAhWGBE+czVYITRFBtFkV5cl1Fr+m/7/ARfeqlsbOi/SkQUb
         D/Z3fm0+Z3j2ngRoEDmRSlvLgSsQdqiq2Gu66i1CQ17HumUIjuobzai2sSqMJcQJT100
         qH57NdhICnvCzPWHRbYyf5mEhXxSEBO39+3JVeTKfkx5IuTHVn9POddiwzD/GBDBzCI7
         zGJb5xUxhKJqOZpfPuX/7AryTOQBjeYe1A9PlTLy57eTSmK27MciTvRXJkx7f2GRMgd2
         zdywT/fj6vs2aHHIzlLo0E9/QpuYjX7ZQzbQPtv02td/8liVl3D+ZO8uWNKwmm02oSFN
         KWiQ==
X-Gm-Message-State: AOAM530wUMh7UELT82gm4dx/+9ThgatgpbSE5b51O9FwSQVzE8NiOdv3
	xKa9R6Uc7BhN9R5bACJyrAMHyQ==
X-Google-Smtp-Source: ABdhPJyiCnOo92HtJa73hO6tyJSX/UZ3uXYoBUJKZb0zlTpZVKqG23TRLNxwCnhdpyT1Se/jsnuxCQ==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr6020716wmk.90.1591304427765;
        Thu, 04 Jun 2020 14:00:27 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id h15sm9018735wrt.73.2020.06.04.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:00:26 -0700 (PDT)
Message-ID: <7b90285ec759589cc2edc3994ef39ef508b8927d.camel@linuxfoundation.org>
Subject: Re: [OE-core][PATCH v3 4/8] bitbake: lib: Add PrefixLoggerAdapter helper
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joshua Watt <JPEWhacker@gmail.com>, 
	openembedded-core@lists.openembedded.org
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 04 Jun 2020 22:00:24 +0100
In-Reply-To: <20200603025405.26885-5-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
	 <20200603025405.26885-1-JPEWhacker@gmail.com>
	 <20200603025405.26885-5-JPEWhacker@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-02 at 21:54 -0500, Joshua Watt wrote:
> Adds a helper logger adapter to add a prefix to all log messages.
> This
> is useful to distinguish log messages between multiple instances of a
> object.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/__init__.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
> index 2e2966c3b9..1de32041ed 100644
> --- a/bitbake/lib/bb/__init__.py
> +++ b/bitbake/lib/bb/__init__.py
> @@ -84,6 +84,14 @@ logger.setLevel(logging.DEBUG - 2)
>  
>  mainlogger = logging.getLogger("BitBake.Main")
>  
> +class PrefixLoggerAdapter(logging.LoggerAdapter):
> +    def __init__(self, prefix, logger):
> +        super().__init__(logger, {})
> +        self.__msg_prefix = prefix
> +
> +    def process(self, msg, kwargs):
> +        return "%s%s" %(self.__msg_prefix, msg), kwargs
> +

Ignoring the mailing list issue, I think there is something odd going
on with different python versions somewhere in here.

https://autobuilder.yoctoproject.org/typhoon/#/builders/81/builds/1004
https://autobuilder.yoctoproject.org/typhoon/#/builders/107/builds/585
https://autobuilder.yoctoproject.org/typhoon/#/builders/15/builds/2255
(all debian9)

and then selftest issues:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1020

Cheers,

Richard

