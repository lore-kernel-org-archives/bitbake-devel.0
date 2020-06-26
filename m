Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
 by mx.groups.io with SMTP id smtpd.web10.192.1593206786794104294
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2020 14:26:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=heskRbe1;
 spf=pass (domain: gmail.com, ip: 209.85.166.65, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f65.google.com with SMTP id a12so11317468ion.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2020 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=49hQjE0/xCU0nzT6mlhmCIXJO2EZiXn629GwrfZS1sk=;
        b=heskRbe17ls/+dQomRw6aGhlBQOrlhkwEpTl+AqRlmm44g2onLiIcKqI7C+AeGpC6y
         tozfiKy0Va+kh1jG2CST6MbPY6iUFzoB8r6LYqR9R/9/Yepwxg4FRDyUotX5AM+m3nJT
         u7ZZ2jr4Rf/6zdlIPrBeuEF0qVB4++Nsr5gh2AjWVOfUPqLuf4v1Kq5gIsFPYLlchjit
         OCzJ3SlM83pU4fQk/RsQHNG2gBP0Ohd46lir9XRuqPNAXSPPYaoe8VdwQy0L5Nc21hcL
         Cm6hy5aFMVqZyEe1bYZSyA3i1xQqb5ePYSpNvlrq3rZzpU98D62s/uirjFVT/7wMMjTX
         qIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=49hQjE0/xCU0nzT6mlhmCIXJO2EZiXn629GwrfZS1sk=;
        b=CrAJf6rvKueYIrRFqS5+xbtcIeYGVsq4vvrnGPcCdmUvEUwdxojbGTxva6I9F+RUgu
         uYN3iOOT3AICynzspa8HryLStORdwkgn4yJWOJpabmrCl15N62ASygzl4ZPV/+QjOavg
         cjz/FK6vrZyAt4Gy3ym07iyHcJ0Kws6bgbR6BCziQk1nqIgeFWoMfNSfmdsRMJKaPfTG
         TTUqvsRdtzpXB6bfnsDNDzhh4vGRetkypQ6c7yseQCTHB3Zzi66KRxz/UKOIKVti6HbM
         ln62VEFLCxF5pzMBDlrMhrYNczy0AMkPlJh0UKXFMoe0DPUbM0Y5LSCUYXWztp/ZoHKm
         lBqg==
X-Gm-Message-State: AOAM5302+OGrYIZ5+776g1Bz8HrDArkhZOnp7UW/9KEyYeFakTdugftE
	QqKI5tv1xB9MqNe0eOP88p8jAvTY
X-Google-Smtp-Source: ABdhPJxOY/lUgr8Q5tqfI7gUt8u57Ucj46rq5J6PD4STPVoajnQB+V8OwcwDNTsZ3VojslvukwGQJA==
X-Received: by 2002:a05:6602:2d41:: with SMTP id d1mr3909878iow.54.1593206786033;
        Fri, 26 Jun 2020 14:26:26 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:b57b:f342:9dbb:77c7? ([2605:a601:ac3d:c100:b57b:f342:9dbb:77c7])
        by smtp.gmail.com with ESMTPSA id c20sm15850250iot.33.2020.06.26.14.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:26:25 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] hashserv: Chunkify large messages
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20200625141338.9078-1-JPEWhacker@gmail.com>
 <20200625142107.11098-1-JPEWhacker@gmail.com>
 <aa414ee5c19b78e4fd148e9e3e97b8147269ee49.camel@linuxfoundation.org>
Message-ID: <b4ba6e41-2d61-9412-ba10-32fb7479e12c@gmail.com>
Date: Fri, 26 Jun 2020 16:26:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <aa414ee5c19b78e4fd148e9e3e97b8147269ee49.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 6/26/20 4:20 PM, Richard Purdie wrote:
> On Thu, 2020-06-25 at 09:21 -0500, Joshua Watt wrote:
>> The hash equivalence client and server can occasionally send messages
>> that are too large for the server to fit in the receive buffer (64
>> KB).
>> To prevent this, support is added to the protocol to "chunkify" the
>> stream and break it up into manageable pieces that the server can
>> each
>> side can back together.
>>
>> Ideally, this would be negotiated by the client and server, but it's
>> currently hard coded to 32 KB to prevent the round-trip delay.
>>
>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>> ---
>>
>> V2:
>>      Removed some debugging information I left in accidently
>>
>>
>>   bitbake/lib/hashserv/__init__.py |  22 +++++++
>>   bitbake/lib/hashserv/client.py   |  43 ++++++++++---
>>   bitbake/lib/hashserv/server.py   | 105 +++++++++++++++++++++------
>> ----
>>   bitbake/lib/hashserv/tests.py    |  23 +++++++
>>   4 files changed, 152 insertions(+), 41 deletions(-)
> I naively ran this on the autobuilder, forgetting the server is central
> and would need updating manually.
>
> How backwards/forward compatible is this change?
>
> With new client and old server we see tons of warnings, e.g.:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/61/builds/2068/steps/8/logs/warnings
>
> I know I can upgrade the server but then will it work with old clients
> (e.g. our LTS)? Do we need to warn users instead of warnings like
> this?

The onus for compatibility is always on the server, so the client says 
what version it is, and the server decides if it can support that 
version or not. If not it closes the connection, as you're seeing here. 
The change is backward compatible from the servers perspective (that is, 
a new server can support old clients), but not the other way around 
(e.g. an old server has to reject new clients because it doesn't 
understand the chunking protocol).

>
> Cheers,
>
> Richard
>
