Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.6302.1615470520884191421
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 05:48:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ihprLvZX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso13232022wma.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Mar 2021 05:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lMUE3BivfwCKp80gq627lihSr3y6PR24aseSPqm41Rc=;
        b=ihprLvZXCX3gF7snv08fwj8pKBClKc3azAxs+x4uA/HlYQ8bXapSKCsz6Hncwt1mgd
         6Gwn0pTPMFYbmpnVhFrmQlrPB12zWcmjlA3sHThv4xSjUgfHJtHUh92AnFsTg4o42icl
         0A6Hin68yll/oOW/eyJ63A7LFvg/lsCUNEOJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lMUE3BivfwCKp80gq627lihSr3y6PR24aseSPqm41Rc=;
        b=owclZBvvabqjW2UyBFHtY2aMrTdk93Wa+phKIs2gHthf4heOamtqjFQJQCoLHKtvVx
         UTujAdbPTpbmA/PjL2DP2r43/1k+WbCegj3hX0bgMSovK9Ra0+dENxin3YSR8Y5ola5f
         rfmf/T/clZGl0WR+Pg/p0PprqOFX+TZ7A9yXqLYB3K12BReBC9cJGd41GJvjXJL3Iapt
         dhixcFnjcCssThRx/4NhhvtqRwGweahpWt0VJ1Adzrel4yNvNtAE6O7L6Uzeqf7m5UPq
         3Uvm1j0a/Om041/Blhr3eHw2LqZ783xMfsyeWYbuTr3J+Qmc9NGD3pVTh7xANu5UYJdB
         tT0A==
X-Gm-Message-State: AOAM530lHmWi7KfDKAul9N2hJIsHm5GQi6uSu3uu8jIQgzQYqMv/7m3k
	iS34UHgg0iXSB8w/bqse6n5ZEQ==
X-Google-Smtp-Source: ABdhPJxeE7g8qeLzdYzL8ZAVp3Zz/nwvDtegijJZ58VV/7FSL3aHMUXf37/+lcBdR9hMx49bK0ubww==
X-Received: by 2002:a1c:22c2:: with SMTP id i185mr8324586wmi.99.1615470519436;
        Thu, 11 Mar 2021 05:48:39 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:79d1:e29:deac:3ff5? ([2001:8b0:aba:5f3c:79d1:e29:deac:3ff5])
        by smtp.gmail.com with ESMTPSA id c26sm4161424wrb.87.2021.03.11.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:48:39 -0800 (PST)
Message-ID: <9560f525dfaaf50ec1a50dd43f71807556e68e5f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v5] event: Prevent bitbake from executing event handler for wrong multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>
Date: Thu, 11 Mar 2021 13:48:36 +0000
In-Reply-To: <CAJkqNs1_oXuRtGNXH5meVY+Lw-O5bjEq1TivksnkXE4SmR5-1A@mail.gmail.com>
References: <20210210111515.1189896-1-tomasz.dziendzielski@gmail.com>
	 <ede980db00b9924e73ce83cfcdfa0a734f426dd4.camel@linuxfoundation.org>
	 <CAJkqNs1_oXuRtGNXH5meVY+Lw-O5bjEq1TivksnkXE4SmR5-1A@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2021-03-06 at 13:50 +0100, Tomasz Dziendzielski wrote:
> > Somehow I suspect this patch is causing a parsing speed regression:
> > 
> > https://autobuilder.yocto.io/pub/non-release/20210305-7/testresults/buildperf-ubuntu1604/perf-ubuntu1604_master_20210305150036_c8075ed8f1.html
> > 
> > See the "test3: Bitbake parsing (bitbake -p)" where you see bitbake -p
> > goes from 19s to 22-23s. With more layers the issue becomes more
> > pronounced.
> > 
> > I haven't 100% confirmed this yet or looked into it but we need to find
> > out what cause the parsing speed regression from around this time...
> 
> It's possible this patch is causing the regression, since in fire_class_handlers we iterate over the
> _BBHANDLERS_MC list multiple times to check if it contains an event name.
> 
>  def fire_class_handlers(event, d):
> ...
> + if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
> + continue
> 
> I've sent a patch changing this structure into a set that is faster than list in checking if an item is
> present in the structure. Anyway, I can't confirm if it is the case, since the difference in parsing time is
> not significant in my environment. If not, then it's still good to merge it.
> https://lists.openembedded.org/g/bitbake-devel/message/12072
> 
> Please note that this patch might conflict with:
> https://lists.openembedded.org/g/bitbake-devel/message/12053
> so one of them will require adaptation depending on the order of merging.

I firstly confirmed this was the patch causing the regression which it 
was. I then ran it under bitbake -p -P with an empty cache and you can
see a lot of time is spent in register(). Through the call traces, it was
spending the time in __len__ of the datastore. From there you can realise
that calling "if data is not None" is much more efficient than "if data".

I've sent out a patch for this and the set() fix.

Cheers,

Richard


