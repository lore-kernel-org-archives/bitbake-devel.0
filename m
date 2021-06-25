Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.5445.1624615546186653216
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Jun 2021 03:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MmVOV5Gq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id g7so5328685wri.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Jun 2021 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6y1YXUixSBuaQ8I/pS8xe4nLbbBJ0PDq39L+KoabxPI=;
        b=MmVOV5GqlyvEERIiTAzIu8dLIqObo9kQCZJxK1LJG52Ioy5ev7TMAQwwcVVMsrAq//
         LbpxL0tfH7fXCbgoivpNZRwskfmCy58RL00jeGwqHLsZv8tbhX8CiVrnxHJS2cDul1vP
         jWh9+HgEPcvyJqmYCGQh34HKZWTir19WmIKvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6y1YXUixSBuaQ8I/pS8xe4nLbbBJ0PDq39L+KoabxPI=;
        b=sU5Px5WUH4AxbSNmLs054k+r3Dn54K4Z2TCLmt6pmJ2ITxdS4rSusf6poyATB9SyDn
         vu/W66W7jDmoF8z6lspukLC+k6p7GQ+Ilvk8rf6zroo3E+zQxn6gsfLKz1EOrqVXxAcB
         KerCiygcSxDBNsJb5h44pySYQ7WuSFX2Mp6lHASrdxyYOeUdkFXUJ1Q5rj8CWYvDzasx
         YvU8UN6VdU+vD6j4Rn7bG6yIAISjj+bQ3lzywnvfOBOjPzdvkPzdW16HvEwUbuzKMAFB
         s79sXXPgo3OqiGUD5nhA1cnrbnHE0g0nigaWJ6Y9y3N4tWResa75uxelOpSLCFAmBzve
         Ay8A==
X-Gm-Message-State: AOAM532ySeSC5c0XY2NBu3P6qi4fWTwQdSjrxSZ4oyIrytW7I/9cQJsl
	CU4gKdxNwmkcTyFx1eqWq8n6Sw==
X-Google-Smtp-Source: ABdhPJyP15gPICukz1aKnjZV/0nMTYGVGeIy6FZRXtk6X5dvDeQczL/Y0DdSA86hdPJMQtpYxsHGXA==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr10079587wro.194.1624615544454;
        Fri, 25 Jun 2021 03:05:44 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:628a:47d1:4c03:7e6d? ([2001:8b0:aba:5f3c:628a:47d1:4c03:7e6d])
        by smtp.gmail.com with ESMTPSA id m5sm12191454wmg.32.2021.06.25.03.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:05:44 -0700 (PDT)
Message-ID: <5fb285259b90e3f8d7f9c01c778e79686563e350.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Improve multiconfig deferred task issues
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Kyle Russell <bkylerussell@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jun 2021 11:05:43 +0100
In-Reply-To: <CAFrQVPMHson5cyOgmcDZHFTbzYHVPrdebiSZ5Ad8AtjkfmhGvw@mail.gmail.com>
References: <20210508091457.2084843-1-richard.purdie@linuxfoundation.org>
	 <CAFrQVPMHson5cyOgmcDZHFTbzYHVPrdebiSZ5Ad8AtjkfmhGvw@mail.gmail.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-06-24 at 21:48 -0400, Kyle Russell wrote:
> What's the status on this patch?

It fixes some issues, it seems to cause others.

I'm afraid I simply don't have the bandwidth to work on everything and
whilst I do want to look into and fix those issues, I'm struggling
to find the time (amongst a long list of other things).

The challenge with this is finding test cases which don't take hours 
to run and the "starting" configuration is easily set up.

I think the code in master-next is probably correct so I'm tempted
to merge it and then improve from there as the code in -next definitely
feels more correct even if there are some other issues. It does reduce
the output noise a lot.

That said, I've held off since I know if this does cause further problems,
I don't have the bandwidth to look into it. I've also not 100% happy
the code is right and I don' want to see the inevitable backport to dunfell
request when I know there are more issues remaining.

> I have an issue on dunfell where two valid setscene tasks are getting
> scheduled for native packages even though the hashes are equivalent.  
> When both configs' do_populate_sysroot_setscene tasks get scheduled near 
> the same time, one config often fails with an unpack error.  One config 
> sees that the other config's task has already started downloading sstate, 
> so it immediately starts unpacking the tgz it finds.  However, if wget 
> hasn't actually finished, tar errors on EOF during run.sstate_unpack_package.
> I can readily reproduce this on my setup.
I'm not completely confident it I'm not completely confident it 
That sounds like an sstate or fetcher bug, it should be moving the files 
into place. Obviously it shouldn't be racing either but two builds could
race. We should probably have a bug filed for that...

> I think bitbake rev a75c5fd6d4ec5 attempted to address this with 
> pending_hash_index() in runqueue.py, but it seems that over time, that block 
> has been pushed further to the bottom of update_scenequeue_data.  I think in 
> my case, both tasks are being marked as valid, so the following case appears 
> to prevent one of the tasks from being deferred until later.
> 
>             if tid in sqdata.valid:
>                 continue
I'm not completely confident it 
You are correct, the code is definitely marking multiple things as valid when it 
shouldn't currently.


> I have seen some instances where native sstate tasks are actually deferred 
> because the bb.note is printed in the log, but not always, so I'm not sure 
> under what circumstances update_scenequeue_data is supposed to execute the 
> pending_hash_index check.

The problem is caused through interaction with the hash equivalence and unihash 
task "rehashing".


> It looks like this patch might take a step towards fixing that, but I haven't 
> followed all the recent multiconfig discussions completely.  I'm not confident 
> on the current state of things and wondered if you could provide any insight.

Basically I think it is the right direction but I'm not completely confident it 
fixes everything and I know it needs a few days to spend on it (mostly to be 
able to run large test builds).

Cheers,

Richard

