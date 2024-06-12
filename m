Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3DDC27C75
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 08:46:59 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.6508.1718182018870368115
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Jun 2024 01:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Orw3pDnX;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c8973ff29so2179643e87.0;
        Wed, 12 Jun 2024 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182017; x=1718786817; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e+CjCsOpOHgbe5785ZjuYM1+NJSxx81aN+f5C5V8gPU=;
        b=Orw3pDnXeRxoCSEjmag3LEU7eYUtPxBIlODHDfZRRWNQHAAXCJS7zh5fI9cQAebO5i
         aX9LeklwL2xDAJ4AEeEMW0w97yS15LwpHzrxKr3xuSO2U6lPP/90h7R0abcuqglQyNVO
         B0lwLdezOWqhcULb94oMXn/AfbB0FwWIQRJC+To4B4d3HGagrzODufNcHVXvEnCEyg6q
         bhiNFLwas/c5V+BHNiaUD1lit3vlcJAYCxVHZqjwJ+rI72Lh6WZjvmDQUUwTtMKuogE+
         CzFleTwYqm8MXtjeD3E7fZm/1215LM0PcDS3DOUnhrXXSMARBxJq5vyHQ+BNSumylvYc
         1DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182017; x=1718786817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+CjCsOpOHgbe5785ZjuYM1+NJSxx81aN+f5C5V8gPU=;
        b=NProJLj9O/8BTlKhHQP91IIdL0S8rXkuuR7E7D5La+GVMgVk27BPB2B/lBPHI8Oi+D
         TSCrQOxSlzwjXF/1lplM2f5SrdsK3sWnMfMhL7jGUUFs3+U7jKT5evxvGCETzL76t3T8
         zjEVLlOIGe4bP5feCFBIlzMF/hcImJJIj/tPa3KwzXldeY4M8Uq+OpexvhhZjAhzS/f6
         yix9V0hcLycjmJv1IJhZVdEuT5bG+w+dIggdzibOOsoPWBMLHeL1769zDn0p8M/jOljo
         6ssiuCYXw1IPgo01IrPTuZ+2yF5+tPgxk2j5qTAlQAzmbBJokIsCH6y7U/3fNSvPNRiG
         pq3w==
X-Forwarded-Encrypted: i=1; AJvYcCU6vL+MSCSzjgRWP0igyYp63s2YaojQXiqb9yNXdEDiNTK7D3W4t51YmDKUWTUVtRJWPNGhQyLfjc1/tGtS/A4qacNCnry4LwC7huO5R7uOJ55JJ+Pm8S9zRG50TQms0+c=
X-Gm-Message-State: AOJu0YxzmYi4lmZGJJVSa7W2d01E1LzetUXyamDxsbz7ApEz9AVNCQwA
	UYYofRjCoTNaNcIWKCdHeLgT/zIQ8EeJclbC0bA1lKKN8g7yqiZpufXPTDMn82nYAoC4XNE5p/t
	65hgP4olK+1BV/T6i1M6WoTv6a9c=
X-Google-Smtp-Source: AGHT+IFjlyqREq1YYldBKxj+FqzQrEoX3NDNp0RUICfSxic4yinjfIzQMu5qTiZwPGaZjJEuk1G5EeBDQqlH6h8yFqk=
X-Received: by 2002:ac2:4254:0:b0:52b:79d6:5c28 with SMTP id
 2adb3069b0e04-52c9a3fd532mr602472e87.52.1718182016581; Wed, 12 Jun 2024
 01:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240502105745.3073153-1-alex.kanavin@gmail.com> <17fdbe98636e4e93ba2f7dfd52e294d2fb479ff3.camel@linuxfoundation.org>
In-Reply-To: <17fdbe98636e4e93ba2f7dfd52e294d2fb479ff3.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Jun 2024 10:46:56 +0200
Message-ID: <CANNYZj_iodZF96JEnnUi6_fa5_CqO1UGhZSHYur=iKWjbMA=yQ@mail.gmail.com>
Subject: Re: [Openembedded-architecture] [RFC PATCH] bitbake-setup: add the
 proof of concept implementation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, yocto@lists.yoctoproject.org, 
	openembedded-architecture@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Jun 2024 08:46:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16354

On Mon, 10 Jun 2024 at 13:22, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> From the init command, it isn't clear what build.sh is for. I think it
> should also mention the traditional build env file too, make it clear
> where that is.

The printed note is: "Run path/to/build.sh to build using this configuration."

Can you suggest a better wording (I have ideas, but want to hear how
you would put it)?

> I struggled to find the --build-dir option to init, I tried to specify
> a direction as the next parameter but that has to be named.

I wanted to keep build-dir as an optional argument, so that users
don't have to specify it and the tool will decide for them.

This can be re-done as an optional positional argument (with
nargs='?'), but then everything else would have to be done via named
options (e.g. picking one configuration out of several - note the json
nests the config in ['bitbake-setup']['default'] to allow for multiple
entries and alternative tools in the future).

> For the cloning of repos, I wondered if we should have some config file
> in HOME with a pointer to a central downloads/clone cache? The
> autobuilder will certainly need something like that. Whether we could
> use a common cache with DL_DIR remains to be seen too.

Having a tool config on disk crossed my mind several times, but I left
it out from the prototype due to uncertainty about how writing to it
should be handled by the tool. There is a spectrum of possibilities:
from a rich 'git config'-like UI to handling it as a strict read-only
item that needs to be manually created and edited. The config could
contain other entries which are currently hardcoded in the tool  and
can be overridden from command line, e.g. the location of the default
configuration repo.

> I'm not sure I like the build config being moved out the way when
> updating. The tmpdir "ABI" and conf file versioning should protect us
> from the worst problems?

Yes. The tool could back up the previous build/conf when that has to
change, but preserve everything else in build/.

> Also, once you're "in" a build environment, can we can bitbake-setup
> without parameters, i.e "bitbake-setup status" and "bitbake-setup
> update"? Effectively that means teaching init-build-env about the
> environment it is in so that bitbake-setup can then read the right
> config from the env.

Yes, I'll look into it.

> For demo purposes it might help if we could add a "poky-ng" config,
> which would be poky, but built using the config from the individual
> bitbake/core/meta-yocto/docs components. That shouldn't be too hard to
> add?

I think so :)

> I'll be experimenting a bit more but I wanted to give some feedback now
> I've taken a look.

Thanks :) I can do a v2 once we settle the above points.

Irrelevant but hopefully amusing implementation note: I've written
this with 'nano' like pretty much everything else over the past 25
years. I'm that first person in https://xkcd.com/378/ .

Don't be shocked, I have reasons:
- too lazy to learn a 'real' editor or install an IDE. Emacs in 1998
made a *really* bad first impression, sorry.
- lack of 'modern' features like syntax highlighting, code folding,
cross-referencing etc. forces me to be concise and get to the point,
and don't write more code than I can fit into a single brain (or that
can be read from a github webpage and fully understood that way).

I can fumble my way through vi when I'm forced to, but otherwise nano
all the way.

Cheers,
Alex

