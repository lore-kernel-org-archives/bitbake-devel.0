Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036BC54E94
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 23:25:09 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.61601.1674689102613020895
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jan 2023 15:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ndYUj/zT;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id ss4so710538ejb.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wSCs37eSodjiOqdm3NOtKuM3bFXlhtPRfHitdQukcv8=;
        b=ndYUj/zTs82iFLycAEBO+ta3J7Fc7qvQjGw5BgPxAiU4eIx2qthzMqKySmLj21KhH+
         I2q6hsrT9S5TBfkQbY/QgUM7Ti1qP72hZPCvFW7XXEXZEnazhA0nnfhWPmk5aAK0Y+iz
         bEfuSuOB68HaicMafKA6tQ4PAs1cSJ05hmNob5teqk/e6sBb5khAQgrmVlMONM7UEEhC
         NPmUpBSslpdi3C2ws+AKeEmqlHvEEQstSI0jliqRAmztnjVQ6AQnZRVd1Gmkk1zvC3wn
         kHoxwyhj7WGc64OU8jQgxe8A18SDqbi27UlQkVjfwKnfBF0G60odE/zpjyJM3Ex/vmPM
         qlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSCs37eSodjiOqdm3NOtKuM3bFXlhtPRfHitdQukcv8=;
        b=69NWbWJXIa+jpRTW/FNYyels7RRthKvaKpZZzqD6ibtdSvpq2zvW20rLT7MU/YFhI+
         UduWOOYgDaISeU6C0vJQ1ozEy8k//ZnDl3MT3Mwm/2PUXneItIhrUWB0U5nCJmD52EDG
         Lfm9TVPReeDKC0ICZ1CUQ9H+eVdK/WLve+kRZbSKHR4truc0sEqG1cEK7B/0d6RQzQt9
         Uf68TdqFdefDalZ3nOp9w/Bd3qKEQM6tvbtlRvpCL+YLqzPFshAV+ya41jSUmxqe8xOB
         WIlOcgjEVlrvmLtMgCNuLBuyiq+XPqFLyIboPj3pPeOewRXPgTv2Uoe4EN7NvNvk0khA
         8nQQ==
X-Gm-Message-State: AFqh2krEb+rzFqLxQnk8g/1EXSXkFUTDpl1uAVLluJ7no5HZVziOTkSl
	A3v6g/KsmUeEblKV7MxilIXYaQGgqf5bFz9PdWU=
X-Google-Smtp-Source: AMrXdXtLxJFrovpOA7RqieySoSBzci69TTS/11/n/BJ1Msek1elx4kkFjdBYah/UWifaPcHq8lCxKeWpssTIcyFmfdg=
X-Received: by 2002:a17:906:5a54:b0:84c:4d1:5e9a with SMTP id
 my20-20020a1709065a5400b0084c04d15e9amr3288135ejc.297.1674689100895; Wed, 25
 Jan 2023 15:25:00 -0800 (PST)
MIME-Version: 1.0
References: <8f03e675ecb19ea938428c52431cd1fc384b5cb3.camel@linuxfoundation.org>
In-Reply-To: <8f03e675ecb19ea938428c52431cd1fc384b5cb3.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 25 Jan 2023 17:24:49 -0600
Message-ID: <CAJdd5GZKqXyETj4trusWAz2YyXheWeUj3p8ZLCwMz0NhJrnqZA@mail.gmail.com>
Subject: Re: Bitbake overrides optimisation in the datastore
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 23:25:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14343

On Wed, Jan 25, 2023 at 11:55 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> I mentioned recently that the override "cache" data in the bitbake data
> store has some potential to be optimised. The data I'm referring to is
> "self.overridedata" in data_smart.py. To explain what it does, some
> same data helps:
>
> RDEPENDS = "A"
> RDEPENDS:${PN} = "B"
> RDEPENDS:${PN}:class-target = "C"
> RDEPENDS:${PN}:qemumips:class-native = "D"
>
> Some code might call:
>
> getVar("RDEPENDS")
>   -or-
> getVar("RDEPENDS:${PN}")
>
> and this data cache exists so that bitbake doesn't have to iterate the
> datastore for all keys, checking for variables starting with the
> expression.
>
> For the above, currently bitbake will store data against each of the
> combinations, the code is in _setvar_update_overrides(). Taking,
> "RDEPENDS:${PN}:qemumips:class-native", it would place a cache entry
> against:
>
> RDEPENDS:${PN}:qemumips:class-native
> RDEPENDS:${PN}:qemumips
> RDEPENDS:${PN}
> RDEPENDS
>
> since any of those being requested by getVar needs to return a value.
> It would cache the needed overrides against these, they're stored as
> strings. Effectively this means d.getVar("RDEPENDS") can be redirected
> to d.getVar("RDEPENDS:${PN}:qemumips:class-native").
>
> To work out what d.getVar("RDEPENDS") should return it goes through a
> few steps:
>
> a) see what possibilities are "active"
>
> This means for RDEPENDS:${PN}:qemumips:class-native it would check for
> set('${PN}', 'qemumips', 'class-native') is a subset of set(current
> OVERRIDES). The actual code:
>
>
>         if flag == "_content" and not parsing and overridedata is not None:
>             match = False
>             active = {}
>             self.need_overrides()
>             for (r, o) in overridedata:
>                 # FIXME What about double overrides both with "_" in the name?
>                 if o in self.overridesset:
>                     active[o] = r
>                 elif ":" in o:
>                     if set(o.split(":")).issubset(self.overridesset):
>                         active[o] = r
>
> b) for the active possibilities, work through in OVERRIDES order,
> chopping off the right hand part each step. The actual code:
>
>
>             mod = True
>             while mod:
>                 mod = False
>                 for o in self.overrides:
>                     for a in active.copy():
>                         if a.endswith(":" + o):
>                             t = active[a]
>                             del active[a]
>                             active[a.replace(":" + o, "")] = t
>                             mod = True
>                         elif a == o:
>                             match = active[a]
>                             del active[a]
>
>
> The code in question was designed for "_" as the override character,
> which may or may not have indicated an override. We now can know what
> is and isn't an override so I think we can improve things.
>
> So far, my feeling is that we can optimise things by:
>
> a) Only caching the entries that would apply to the initial part of the
> variable, i.e. have one cache entry for RDEPENDS rather than all the
> combinations.
>
> b) Have a pre split version of the strings so we can avoid the
> split/join operations.
>
> Challenges:
>
> * sets don't hold order and part of our code is order sensitive
> * we do want sets for comparison with the currently active overrides
> * sets/lists can't be used in the current dictionary overridesdata
> structure as they're mutable (could use a tuple)
>
> So at some points we need strings, sometimes lists, sometimes sets and
> we need to "chop off" sections from the left/right sides of the
> expression.
>
> I'm open to ideas on how we could/should be handling things.

Ok.... I think I understand this now (maybe...). My gut instinct is to
use a tree based approach here; basically use the requested variable
name (e.g. "RDEPENDS:${PN}") to find the starting node in the tree,
then recurse down the branches, efficiently culling out ones that
don't apply and accounting for priority as we go.

I've written a little demonstration script in
https://git.yoctoproject.org/poky-contrib/log/?h=jpew/override-cache
to sort of give the idea; maybe look it over (especially the test
cases at the bottom!) to see if it makes sense.

>
> Cheers,
>
> Richard

