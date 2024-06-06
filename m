Return-Path: <rudolf.streif@ibeeto.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC23C27C52
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 20:18:25 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.25206.1717705098829549752
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jun 2024 13:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ibeeto-com.20230601.gappssmtp.com header.s=20230601 header.b=kKDMJDOm;
 spf=pass (domain: ibeeto.com, ip: 209.85.214.169, mailfrom: rudolf.streif@ibeeto.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f630e35a01so12986595ad.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ibeeto-com.20230601.gappssmtp.com; s=20230601; t=1717705098; x=1718309898; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lqBT8N4XbgG6tbUk3yx7s86TGWNFOgFvOHrgxnFmWOg=;
        b=kKDMJDOmTs2syHVJB3EjQT8txqP2fIXwlqZ6O6hjPYZXpC2q8lROSHI/Ke5argi4V5
         6WcT3I8/hPmKm9YtJgICbMzs8ruieEuCHXTPU3URpyTcpZOnWwQ1QFN76o0ipMP4Y+Uk
         i3tRkYrA35iHXJepN1Q2mon7Ic14dq8z2ZPxpXtcRwxoqXZawkaexDRfxXHWE2Vk+1V6
         0CRo5p7siI7tE2VgvZexWbHIk1usFhhaDHRWBwcttHXAV+P0Nb5X9xPcrcBI74icl59/
         M/dgAnm2d3ebIohHSBuKt3Sz98Kds0SK3KzWMnFVB3mfKuBdNcztfve0JE6UrzweJwMM
         NO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705098; x=1718309898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqBT8N4XbgG6tbUk3yx7s86TGWNFOgFvOHrgxnFmWOg=;
        b=Ss+LnNqmv6iQuttz0xjK0xQ4W3kl5GJ9J+O07aAbF0fLA7rxbYZ7tVbfrLeXXOvVDU
         dpUF4T/J69ncytzbJPtsO35LbsfMRSQ0lZrXpFpZ6wEfmi55TOwhcunQYhKjeJwMQWbj
         zDgSSDJmYwb79KuoQKpWml6lIGFAXaSqK/y43Y6gIuBIZMC8FX0wdmKpv8fLKIb0WHPO
         ZY2tkikue0wx3b7l5wNOeppnpU99Njhh+kNPEjrEYsY2/sWybhlBQ/9TlewdHxDnM/ze
         XhovZ5kweKOOJfinuP+hJxaWJD8v3ajM21yYTwGyyqbU5Wg4+bkolBOyJxmd0ua62n2O
         +2Og==
X-Forwarded-Encrypted: i=1; AJvYcCXY/X5QuqV/3sc5M53KHvHdKoK3HRfJ+6AKD8PwgKyol4LpDNAlTAcRcDY0wi0MbhJT1GGIqIGakZn1QGWf7ggkSJtUcX3FyVSVu8n9up9EgalheME=
X-Gm-Message-State: AOJu0YzvYSdpdqffAQKXBDDm8p9thJcvqNVbnjAuMRmvcE4yDbUdno/t
	VwGNhl44aTFvfNMXTqxvBofyUD2B/LyS8ylqyb7rLCbR9r31DPG9UuKX20tEGs2JqzD4y5yeI9d
	o
X-Google-Smtp-Source: AGHT+IFjWfxi8tibAsp29F2NYODcHKwwCEnhz+b7Qw3c3sa2Su4In9x/Ey8uIRCl8HMCDVFBhoUyEQ==
X-Received: by 2002:a17:903:98e:b0:1f6:6bf5:5aef with SMTP id d9443c01a7336-1f6d02feed2mr7907135ad.29.1717705098229;
        Thu, 06 Jun 2024 13:18:18 -0700 (PDT)
Received: from ?IPV6:2600:8801:8d00:d804:cd39:5769:28bb:21e2? ([2600:8801:8d00:d804:cd39:5769:28bb:21e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75efa9sm19436925ad.30.2024.06.06.13.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:18:17 -0700 (PDT)
Message-ID: <89068048-ee96-425d-a640-684cd6fded58@ibeeto.com>
Date: Thu, 6 Jun 2024 13:18:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] wget2
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <234ddf00-756c-4863-a508-6a0ec75558ea@ibeeto.com>
 <e22ec7329d8c18c254b8fa116ffebb32d4d8b86d.camel@linuxfoundation.org>
Content-Language: en-US
From: Rudolf J Streif <rudolf.streif@ibeeto.com>
Autocrypt: addr=rudolf.streif@ibeeto.com; keydata=
 xsBNBFhQFAQBCACa5/X8dcYC25ELsL2exFTaf9QV24fFIn64+rXFqDNKuk7xed5kafscejvD
 Qpe+Co1EPSU4ybklzYlvbMvzxKfwLDADKh+HsqmUYrd/l43hbqrPLxfDUhg87WVEhjm0qyYQ
 /Qymy+7Cbh+pVNNlHULUQttkXPl3D+UOMz9se0Ook/HngDIOCyQF4rTyPnGNvd8NJmAng969
 cQD/S9LNndnK5GGrmDDOuMYwoG4qDqWvWEChncgqHfmWK/Z1AvYKdYWe9uh1N4Qb/P5AZxTM
 3sPiHrF+Y2HTdK7j7lWgtu8YzluBHdvzhC+4jUnAKjh8P/N/H6JlE3UC3dwHPOaRsnXBABEB
 AAHNKlJ1ZG9sZiBKIFN0cmVpZiA8cnVkb2xmLnN0cmVpZkBpYmVldG8uY29tPsLAdwQTAQgA
 IQUCWFAUBAIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRCNjKgpJzObdabzB/4lFMf0
 3GsVMG6C5QOLaPx6rOgj5qexCH3rfYeI3xkbGuR0a+YByzvSiCc6Ukh7YNn4UwRs6cY0fYBk
 txioE384/51QTIfCmW8ZG5X0cMC5d38LFvd/dj3KBA74HW4GoLt0cIyzy38CCOFmClTNE8xl
 lpeOfKQD3wn99w5dzXYhvajXCWwAjjpWrR84ww6xromQCDj0AubLA6xyk3t8bzFNsRCCFx+w
 Xl7keSggn6ld3f3ySIQyEK2GgZDdw+zQmgVMq4x5LZhUhGYoqbYwNy9imoBkUAZkbbViNOtX
 zaTHX/RzRHErvq56HOVqceJZIpkDnfvB1aXvfvmBhjVLmLHvzsBNBFhQFAQBCADXoLKCuF48
 5eCWhnty44o9IZJuOSiX+uVJTgVGNWkZOF61Hs2pieIOmTqk3fb9+Ao6C6IliC9ZRXyAVLD/
 RSGoLiTnWLc1uaK4P/XCM3HZfsi9ueBuNufR8yMy8/8ZqbFwRIFpPBpxHRrZnDdEd5IKsy+z
 w6QChvhpmssZy+UaKfWHILroAoS/7bKGzHo5F/dEJhxVDjgxDUDspJSHWMBh0OMKDeBik5wl
 svtV2yw7ezwWJLRsbaa8TUXd79ZJYYc3FIi0K5aXkMySh+QaQ/bE2Y5A/mCBCZ+IKhBQR36v
 tUAsTCuUAOREwSdPDVwfuoI5gfVxGyz/zrERfnXF4viHABEBAAHCwF8EGAEIAAkFAlhQFAQC
 GwwACgkQjYyoKSczm3W3fgf+NSdojthWWEqfWwym3VHK8955SeOy12xQA4ird2Ca2LYUpLNj
 s4qVFEqXSXZk4rmpGCFlMWwOjcCJOXJLR0ATfmWlvZxp1QL4res/R+SPFEyheu7TTpJ9MbyE
 fxaMSn2xRMA1V2KVJSfDoMacImVRchFclaNU31cEu6tEnNRwVcsWdTlGdA5a1ASGl4CiP8Tz
 Yf9m2KOWGjOmVgGFcIJ2QfIlMglU875YHE3W4u3YOWwUbPEr2Seyb176MvO74CUL/Nlouvce
 P41tsC5daxZnrLBQ3nw4xe4RJSzdPPkY7iF0N5R9NvBJ7WX3dwjMO4EMvdlFuNCQ2ALli/AN
 ROZj4g==
In-Reply-To: <e22ec7329d8c18c254b8fa116ffebb32d4d8b86d.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 20:18:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16324


On 6/6/24 6:50 AM, Richard Purdie wrote:
> On Wed, 2024-06-05 at 18:54 -0700, Rudolf J Streif via lists.openembedded.org wrote:
>>   I have been using YP/OE for the longest time with Fedora. I most
>> recently upgraded my build system to FC40. FC40 replaces wget with
>> wget2. FTP support was removed from wget2 for good reasons.
>>   
>> even if the protocol used was not ftp. Since wget2 does not support
>> ftp it also does not support (or ignore, for that matter) this
>> option. It fails. From Scarthgap on the --passive-ftp is only added
>> if the protocol is indeed ftp or ftps.
>>   
>> So far so good. However, there is another subtle issue with wget2: it
>> does not like relative path components in paths provided with the -P
>> option. It normalizes paths if there's one and only one relative path
>> component at the beginning of the path:
>>   
>>   * -P ./downloads    works
>>   * -P ../downloads   works
>>   * -P ../../downloads does not work (Internal error: Unexpected
>> relative path: '../..')
>>   * -P ./../downloads does not work (Internal error: Unexpected
>> relative path: './..')
>>   * -P /home/user/downloads/../downloads does not work (Internal
>> error: Unexpected relative path: '/home/user/downloads/..')
>>   
>> I am commonly using DL_DIR = "${TOPDIR}/../../downloads" to set a
>> shared download directory for different projects. Of course I could
>> replace the relative path with an absolute one.
>>   
>> The culprit is the function mkdir_path in utils.c which attempts to
>> create the path components to download the files to. This would make
>> sense when wget2 needs to download a directory structure from a
>> server but technically it should only create the path components
>> relative to -P.
>>   
>> Of course, this is not the right mailing list to complain about
>> wget2. I have submitted a ticket:
>> https://gitlab.com/gnuwget/wget2/-/issues/667. However, it might be
>> of interest to the YP community since other distros might have
>> already or might be in the future moving to wget2.
>>   
>> A Bitbake solution would be to normalize the path in the fetcher.
> Thanks for sharing, this should stop anyone else trying to track down
> this problem! It does sound a pain to get to the bottom of.
>
> I'd accept a patch to bitbake to resolve the path names to work around
> this problem as I suspect more people are going to start running into
> this. Did you happen to have such a patch?
>
> Cheers,
>
> Richard
>
Thank you, Richard. I submitted a patch. Please let me know if acceptable.

Cheers,
Rudi

>

