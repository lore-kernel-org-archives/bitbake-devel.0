Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.5327.1626944347662590743
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 01:59:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gysmhLwT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso2499413wmj.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jul 2021 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KGtzgUdEliBIHT7OEmxfPCS1SXQ6oeXe8lV9yq1EmEo=;
        b=gysmhLwTs3QRNrqCwidAbRPlOQgLKsS/i5faO+miQjke2JthI6k3D9qQeg79O7wn54
         u5DiQs6RWXmZvTuHTl+yUflhZm85+Xz/1Dw7To18lzLQxGDNkVsQqhz1DtKkKskC0B/Y
         ajEv6G+DAlXf1hdARhYKZJTlD6IM//+VT3Yn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KGtzgUdEliBIHT7OEmxfPCS1SXQ6oeXe8lV9yq1EmEo=;
        b=JvH4AxY393GzvRXsu0OBpW7VnCNqzWBJXAG/jegi2f41TsTsbzAvpI5GpgKS6dlO7c
         N4RjcUTNG3DDWcAEZ35mKJDxQYaEnw+fseJI1QqH/+MXWpEYtC7N60ZIQrGRhfrbAkyo
         HUc51F4El+QsrpATkAUvImZRvNAL8uaRrHdGIyoAI6TcnnxDtYhBwnjz8dCdb0i9qZ75
         kfsIJ6/iauzvG2nplF1OexFAf2ckQ16SYCIBVaSWyFhZxTX0vEnjc39V95DpwZWgiPXp
         5tzi1ZlKsy1NTg0VvW09iS9xZZyI6aB5G10KlHNPVF4nyYF0R5XG1eE1IgctwBdvAABl
         UKsQ==
X-Gm-Message-State: AOAM533Gv6TG+QxFtG6GbPt80IpLdj1080cvdzyeCEKWNnI+jHk+OxIa
	MkDQktyS3k9KpH3FsJgW4gInnQ==
X-Google-Smtp-Source: ABdhPJxzQlcLqnnpX/zKWxU8NiHF7fRpItr6UH+11ofPjMuyeDCsOHlaTmJxZHdEUe0/QCV2yigTWQ==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr7926385wmf.176.1626944346160;
        Thu, 22 Jul 2021 01:59:06 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:40b3:3f27:e412:a801? ([2001:8b0:aba:5f3c:40b3:3f27:e412:a801])
        by smtp.gmail.com with ESMTPSA id c2sm29309233wrn.28.2021.07.22.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 01:59:05 -0700 (PDT)
Message-ID: <f6e86401ad6f2077133a7d989fc32c34547d24eb.camel@linuxfoundation.org>
Subject: Re: [docs] DEFAULT_PREFERENCE no longer used?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, BitBake developer
	list <bitbake-devel@lists.openembedded.org>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Date: Thu, 22 Jul 2021 09:59:02 +0100
In-Reply-To: <53a7dab9-2c9c-ce0b-b363-543c33959e62@bootlin.com>
References: <53a7dab9-2c9c-ce0b-b363-543c33959e62@bootlin.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-07-22 at 10:55 +0200, Michael Opdenacker wrote:
> Greetings,
> 
> Looking at the code, it seems that the DEFAULT_PREFERENCE variable is no
> longer in use. Unless I missed something, the variable is still read,
> but not taken into account any more, and there are just two recipes that
> set it.
> 
> The BitBake documentation still refers to it though.
> 
> May I propose documentation and code patches to remove it for good?

I think it is still used:

lib/bb/cache.py:        self.defaultpref = self.intvar('DEFAULT_PREFERENCE', metadata)
lib/bb/cache.py:        cachedata.pkg_dp[fn] = self.defaultpref
lib/bb/providers.py:        preference = dataCache.pkg_dp[f]
[in sortPriorities()]

Cheers,

Richard

