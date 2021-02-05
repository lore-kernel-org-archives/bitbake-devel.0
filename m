Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web09.6972.1612527480247326319
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 04:18:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O5eWvDpY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id w4so5844890wmi.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=LrUM0hSPHFl1MV+mp4d4SQFprCIgX0VDEEL2Qca/Yno=;
        b=O5eWvDpYfJMV/pKkjSLmxo6rq2DOXy/Y6J/9nw8w2G/RF5rSyvQfzM5cKmV3dGNw9M
         TpWCR4+8GnsMsjIDZkYPnlvbRKmeJcHuuJK4W1Ncmmy0Hn5gdUG4ZP4w2iuF3gEgqI6A
         B08OgMlCzbtSM7F1DOhJVVCLS5/talEF0gQKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LrUM0hSPHFl1MV+mp4d4SQFprCIgX0VDEEL2Qca/Yno=;
        b=AHH152U1UnxZfhstNgSdxXPA5LyjW/ADqS0/OowXaPVkww9NaqqBUui1qKujSxnR1d
         PYI+xDh+dDUHv6TUNayvTetclbwwFPU8SGZTnfFi4eyLYjTK9cs9+mtDbsY+9yu1tqZf
         5D16UBQbTkGFyeRaakW4yghJ+vc6B4ruYLlkdNBqVIqrdrQYGUFGlOGjIi3iljIQqPBV
         qMZoHU7tWsvQ2zt5kEDslI6khnB4kQ/CRiY6qbrEQeDO9qoUmM0vgqQTIrTiIXAzAqpn
         HaclGivIpFyF42jsvskOtaKalKL4OTINE4080gsypdjc15+4pabjdsk/AD9l7J7aroF+
         9vdA==
X-Gm-Message-State: AOAM5330Y4ekLkwF62M4FuY9P5txT9uOlaW6vElsoyZLdE0GCGWYSiOM
	48DH27TJPi3pz2Ta65/bRP/Ubw==
X-Google-Smtp-Source: ABdhPJzejPzuzuEd92lUHQcc6vIyZ03Z4LIQu6X4rG6AlalvQSJ5Y5YEVagyYrG/RpTtP332DAJqbg==
X-Received: by 2002:a1c:31c2:: with SMTP id x185mr1479740wmx.44.1612527478660;
        Fri, 05 Feb 2021 04:17:58 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:d1b2:8778:591e:ef47? ([2001:8b0:aba:5f3c:d1b2:8778:591e:ef47])
        by smtp.gmail.com with ESMTPSA id x22sm2987902wmc.25.2021.02.05.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:17:58 -0800 (PST)
Message-ID: <1e3bfe4059efd60bf6ee4b31c1b81355f6657586.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 05 Feb 2021 12:17:57 +0000
In-Reply-To: <20210204221422.16042-1-tomasz.dziendzielski@gmail.com>
References: <20210204221422.16042-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-02-04 at 23:14 +0100, Tomasz Dziendzielski wrote:
> When multiconfig is used bitbake might try to run events that don't
> exist for specific mc target. In cooker.py we pass
> `self.databuilder.mcdata[mc]` data that contains names of events'
> handlers per mc target, but fire_class_handlers uses global _handlers
> variable that is created during parsing of all the targets.
> 
> This leads to a problem where bitbake runs event handler that don't
> exist for a target or even overrides them - if multiple targets use
> event handler with the same name but different code then only one
> version will be executed for all targets.
> 
> See [YOCTO #13071] for detailed bug information.
> 
> I added a mc target name as a prefix to event handler name so there
> won't be two different handlers with the same name.

This looks like it solves a few issues, thanks!

I'll include it in the next test runs and see where we go from there
but it looks right.

Cheers,

Richard


