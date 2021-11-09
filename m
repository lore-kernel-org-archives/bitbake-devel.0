Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD81C433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:03:56 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web08.11124.1636459435961255389
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:03:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PMswIwAJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id s13so32596403wrb.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RhLL1FriU2X+CtadaJ1BttTKkKyT7w3KTZdbtwMpvO0=;
        b=PMswIwAJ1VEXq7T8mZpM1YjZd8d3SJOHZz8HF0xySZ3/gAOuSzwl0Xi7+Z/FV4tDzy
         d31qydZ+izKwHHiNoKWvphcfSC3XraT2LtXDtyB/drEMubz5huqj20dcqy0ttWBpQdaL
         wu4obYp/cXrviK+3yQNs1EyyCkPsKvADSdPxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RhLL1FriU2X+CtadaJ1BttTKkKyT7w3KTZdbtwMpvO0=;
        b=3bKVfH/Ts8XCa4IQjPPqhbzuxXSVYzCrs1WNJV1Wi6jMWI7Kgr5YW4eOfErSmR2A4n
         lqw70HsSoTPBMxnqyeM7joayla/Fs5msd5zdB8IdlJ7HNnJkxJ5DNEhm5xz2PsgGy60h
         YdN5qwD5UvE55VUJJbrhjRBsxZTEobAFDw3SWV1/E4QH81v+6SBG3fYdhAlvI75HmEFr
         YVtWQRQzXOxgdlBjmZT1va55tuTeBHX8C0tdNmVRSkUFUt0SKoxHffyifODBWbUWJqr+
         pf/TjglNaacw4q97fFCDPFrIm8x2uG9vvBCciuDzTwSnEAxxJ7iRmzjIOsbmrm4h9x7+
         80RA==
X-Gm-Message-State: AOAM533i5MNoropwnlis4SxRGqPQzExpB8El8tf6/8rcXp1UhHl+3Kq/
	OpMDtjNICHFzJtHnsg0BGeuHRQ==
X-Google-Smtp-Source: 
 ABdhPJykjzJmBQ8xRtk06/svAWyUtnksYqYBlo2pp39LBxSfznZys1yhx8cThOTXjDr0jlqOw5xKCg==
X-Received: by 2002:a05:6000:1688:: with SMTP id
 y8mr8662098wrd.420.1636459434220;
        Tue, 09 Nov 2021 04:03:54 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:10b7:e9c6:d1a:6f7c?
 ([2001:8b0:aba:5f3c:10b7:e9c6:d1a:6f7c])
        by smtp.gmail.com with ESMTPSA id
 o4sm2853607wmq.31.2021.11.09.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 04:03:53 -0800 (PST)
Message-ID: 
 <f04a8a8b56be668ea8ea29e2707bbd50bedf43c4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] bitbake style/workflow
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Mikko.Rapeli@bmw.de, Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 09 Nov 2021 12:03:51 +0000
In-Reply-To: 
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
References: 
	<CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
	 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
	 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
	 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
	 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
	 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
	 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
	 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
	 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
	 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
	 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
	 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:03:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12964

On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski wrote:
> Okay, one thing I have to add after killing some time with this: I quickly
> scrutinized the git history of `bitbake` and `meta-openembedded`.
> 
> Attached are two figures that show the first time contributor count of both
> projects over the last ~ten years. While `bitbake` shows a linear growth of
> first-time contributors, `meta-openembedded` is exponential. I didn't analyze
> the first derivative but to me it looks like there is a kink following that
> timestamp indicated by the vertical bar. That line represents a subtle, yet
> important change in intonation in the merge requests. Before that there was
> always a comment "Please read README and send patches to
> openembedded-devel@lists.openembedded.org for review." or alike. After that
> the intonation changed to messages "Patches should be sent to openembedded-
> devel as described in README." and if I interprete the following MRs correctly
> the maintainers (mostly @kraj) were kind enough to apply the MRs as patches.
> I'm sure there is a readon not to hit the merge button but instead doing that
> manually which I don't understand. But most important point to mention:
> 
> The development of the community around meta-openembedded is what a community
> driven project should look like - the evolution of `bitbake` not so much...
> 
> Have a look, reproduce, ask and draw your own conclusions.
> > > > > > > > > > 

Thanks for sharing that, data is interesting and useful. Looking at the data, I
agree one is linear, the other is more like a growth curve however what I don't
see is that it changes from linear to the curve at the point other commits are
taken via MRs. It looks more like the change didn't make much difference as the
curve was already there before that.

The nature of the repositories and code is very different too so I'm cautious
about reading too much into this one way or another but it is interesting.

Cheers,

Richard




