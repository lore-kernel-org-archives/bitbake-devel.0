Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web08.12170.1612885830373099047
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:50:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g7JggKVQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id 7so22600266wrz.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=gW4PbKvpzpiSTPj8sDk6VxkK5RDQG7iiZY13WixB258=;
        b=g7JggKVQgvZq6tKhsN4sm7bHNsbf7/HFBam9JDC9jcjcgou9EAVgXcNEoO50Dh9zhm
         02HBcvnn9/lLJn8d0KdHHk2VFB4OvbN9R07jnJeA1tidyq5pjQgjbtAUwY5YRRmflg8U
         QMVo9LtTkRQyovu6k871w/W+IBiu9JAbBmH8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gW4PbKvpzpiSTPj8sDk6VxkK5RDQG7iiZY13WixB258=;
        b=M3KzCqM3WdrFq2QGyEIGRUJ1fHOIln3kxVry5rKpYLDlv7sm05lGgM1njBoFtnErlt
         IntDms3ZevLd8Sq3RMfGWR8Q816Fc2rxwTioig7A07Z2cfdegqhYYtrEF8JLDSMss5kr
         mIAcbqZCUmKjBmUjmyvyjfJu0vHw2Uy0ZW6XjCarTv43XKqhhKfs3TcA9bYrctTtfmkE
         0fB0GwQIBCpt++VZF5siHOcC/FG9QvdBLbP6P0/FVWYxPPwzNt+Dk6xp7xdYOYvyDTFA
         rbjhruLZ48sc3/2bcrna792K3qJyWKY9PhOHzjX7OVY5ZZA+OiskxZfYEbPpi7qwq544
         Or1w==
X-Gm-Message-State: AOAM530Q60oot21n4v5De5KlaANMRecGX4WW9cFTNj5Rfd+dlTdLPoEh
	O5gwzIcweV7SH+91VCyfpT2mpQ==
X-Google-Smtp-Source: ABdhPJxOpP+xlOLlBQBgmobyBobU1z60KKbv3hFCiRm8b/QPof69MW+SkWVJpVj/Swp0AQ2EDhBQfg==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr187775wrt.312.1612885828806;
        Tue, 09 Feb 2021 07:50:28 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:6e64:a4a9:6e48:217c? ([2001:8b0:aba:5f3c:6e64:a4a9:6e48:217c])
        by smtp.gmail.com with ESMTPSA id e16sm12437654wrt.36.2021.02.09.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:50:28 -0800 (PST)
Message-ID: <9a9ad16dbe9d6540fb375d8419fbb569334c1757.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v4] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 09 Feb 2021 15:50:27 +0000
In-Reply-To: <20210207114659.148514-1-tomasz.dziendzielski@gmail.com>
References: <20210207114659.148514-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2021-02-07 at 12:46 +0100, Tomasz Dziendzielski wrote:
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
> Add mc target name as a prefix to event handler name so there
> won't be two different handlers with the same name.
> 
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> 
> --- v4 add mc prefix to _bb_diskmonitor event handler to fix build, both build and test_stoptask_behavior should be working now
> ---
>  lib/bb/cookerdata.py |  5 ++++-
>  lib/bb/event.py      |  2 ++
>  lib/bb/parse/ast.py  |  7 ++++++-
>  lib/bb/runqueue.py   | 15 +++++++++++++--
>  4 files changed, 25 insertions(+), 4 deletions(-)

This still isn't right I'm afraid:

https://autobuilder.yoctoproject.org/typhoon/#/builders/39/builds/3057

I did also wonder if we should be changing each of the event register
callers, or doing something inside the event register function instead?

Cheers,

Richard

