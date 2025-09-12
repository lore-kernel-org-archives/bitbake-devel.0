Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E26CAC582
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 10:48:05 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.13440.1757674074700547273
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 03:47:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KSd2gWoW;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-80e2c527010so111399985a.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674074; x=1758278874; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R7cPz1SuwB+koB7lNnsAEi3y5zr4mRHNNseGDZDIkAA=;
        b=KSd2gWoW30SbpHb+zdN6Vmt889IyP9UtZyEPByTLwhtH1OAGZQuFeC9o3BBid497Ob
         iQF5nswqpV1GBJNaLEVL+ChFhnkfLJBAPOabXHUdFRpnAOPEmFM+pWU9HvOpfg6N1eed
         ivDyAWoxgUNpDMwtLjPXaiCvuYS2vMddsUhDw/1cf6HshkgoPqbFGggYlhsZxliq6vge
         YuMukX7Q7GHcTbDf7zTbp4tYh0udZ9ceQBcVJMatBsWGaprXBZ+e0fbCK59zN+MTj2Hb
         5PmcPXJXQBBSDuQ7fWnmCauc7mS5oKxjVmuUUj/DZ/6ZUpNSc9GFYxNWCF0lPUktxEpe
         S9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674074; x=1758278874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7cPz1SuwB+koB7lNnsAEi3y5zr4mRHNNseGDZDIkAA=;
        b=dbTuEvTb8TMP7jia4Zlpb8VU2yVbUQHNaLvrEg/ggesGCHn9m0iZTjg6C8HhruJveP
         hbARVoP5AhStrQHhtgbA2YX1ZNZg8YMWiBe+mivcxNfXsfbsz0TXn4ymXWGrxbIZIDDI
         uprvTwGhayqVBG/EXq3crwwKEYvCDLFg1Y2LCvaP/sNXnICUOKLTMiXwvNuBUMxFfD0p
         JgjHUpwP+rWAm2kQbBHUKZrEtncBXBl4qYYp9jpRcN62DJJyMj3rSfH2LjsuEbL0DodJ
         riesooqHBdB5HJWqROn9BSYxJxoSYYUNeJq+vKwprPXZVVEhtyO0b6x7SpaidrHefLTZ
         zruQ==
X-Gm-Message-State: AOJu0YyrRCxsad4spvDtIiwvaRTx2+WBHTx1kyKH27jvtAkyEwx0KYx0
	8KZ27x/QwwsHRIQFugvOCpIKZ5+bNprhdTpk1gH14CkWVRudZOYxdPypSk6t2Z0YFTQdKfIqF5w
	VjJA67Gj20huXWoF9iqbxkM40pbbvYGE=
X-Gm-Gg: ASbGncsnmHVggSTcAFq5ZWkBPK2WCVMUOdQ9N0LEJ+Wtr6Pn/AwPi84722s0moR78Qf
	Q/BGa0YRUBQPNqfSkEigB8S62i+UJrnA80/nu3gehbFIlBLtLXO7RQ5D+CTlENX+ooA2miHwTfj
	k82LyMwx6GDl0DCSQuJLzWz9MyI+LuP3IpWqyIKKDJ4Gq9RmoElqi+e/L6rZeusp/3HRZE+M2b8
	2qqIHI1HgUxgTGT7abv0vsONkYm4kQlU3qFEMuw3aGUXkNKopeYaroiwQJlHXh1j0tS37FfqxZC
	TOOmE88gNEcffDLOHDCUEpX4U8pB3/L/+Yiwpd1o61Jh+BvVhU4=
X-Google-Smtp-Source: AGHT+IEqFT1PJ4r8UbYbFy3iCBHYltOuWN22UOrBv1/6/VietqjU0W2h+lmPUsIKPBS1LGqCbX1KS3FiSdwRSrf7hIA=
X-Received: by 2002:ad4:5ecf:0:b0:728:8b2:1e34 with SMTP id
 6a1803df08f44-767bda44212mr31819016d6.27.1757674073618; Fri, 12 Sep 2025
 03:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250908123437.1728264-1-alex.kanavin@gmail.com> <4eb83cb1-f5d5-49dc-bef5-9476e4018d40@ti.com>
In-Reply-To: <4eb83cb1-f5d5-49dc-bef5-9476e4018d40@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 12 Sep 2025 12:47:42 +0200
X-Gm-Features: AS18NWCfpIB_DX0POt9pPNUnm9jyCVCx-bhDVQjoadOwpYQX3IYPOzDO4FsNj2I
Message-ID: <CANNYZj-tFRkfpwVW7Rtu-6C0pTQ14M9-xXSEafYxqz9nGA9SQg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: Ryan Eatmon <reatmon@ti.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 10:48:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18009

On Thu, 11 Sept 2025 at 22:01, Ryan Eatmon <reatmon@ti.com> wrote:
> Thank you, Alexander, for this update.  It is definitly an improvement
> over the initial version from last fall.

Thanks for looking again :) Fragments (added over the winter) was
really the key missing piece to make this scale, and with them in
place it became possible to set up builds without using templates at
all.

> I really appreciate the addition of the layers and the fragments to
> allow for configs to control more things.
>
> I have updated TI's oe-layersetup repository's bitbake-setup directory
> to conform to this new version and provide more examples for folks
> wanting to see it.
>
> https://git.ti.com/cgit/arago-project/oe-layersetup/
>
> The bitbake-setup/ directory contains all of the json files, and the
> conf/ directory acts like a yocto layer to provide the config fragments
> for the different configs.

There's a lot of fragments and bitbake-setup conf files, so I can't
look at all of them, but it looks basically ok. Note that you can
split the bitbake-setup configs into their own repository if you so
wish, but in any case any place where they are hosted should be usable
as a 'config registry' repo.

> The only feedback I have a sort of nitpick things.  And I will probably
> submit a patch series to address these in the next day or so as I work
> out fixes for them.
>
> 1) The interactive interface has a couple of usability issues.
>    a) When prompted to pick a number, if you just hit enter, you get a
> stack trace since the empty string is not a number.

Yes, absolutely. We should not 'punish' the users for making an
incorrect choice. Just politely ask again. Ideally I'd want to mimic
kernel's menuconfig UI, but python input() is built-in and very simple
and doesn't require external libraries or complicated UI programming.

>    b) If there is only a single choice to pick from, it would be nice to
> auto pick option instead of making someone type 0.

I think there is already auto picking a single choice, but maybe
there's a spot I forgot, or it doesn't work as intended. E.g. current
code has:

    if len(config_list) == 1:
        only_config = config_list[0][1]
        print("\nSelecting the only available configuration
{}\n".format(only_config))
        return only_config

This is not done for 'oe-fragments-one-of' because if you have only a
single entry there, you can just add that entry to 'oe-fragments'.

> 2) The directory name that is chosen is a little unweildy.  It looks
> like it takes the json file name, plus the configuration name, plus (if
> set it up like your example) the distro name and the machine name.  For
> my builds this resulted in:
>    arago-master-wip-config-arago-distro_arago-machine_am62xx-evm
> Which is just mouthful, with arago repated over and over three times.

I think distro_arago is in here because you have it in
fragments-one-of? If that's the only choice, just use oe-fragments.

>    a) Maybe allow the json file to specify a style for this directory
> name?  long, short, custom?  With custom having another entry to specify
> how to build up that string.
>    b) When finding the json file portion of the above, the code is just
> finding the first . and chopping off the end rather looking for the
> ending .json and removing it.  Some of our config files have versions in
> the file name with . and it made for a goofy directory name.

Yes, this should definitely be refined, I'm just not yet sure how.

I went overboard with this to ensure build directory names are unique
for each possible build configuration, and would not clash with each
other. They should also be self-descriptive. These properties should
be preserved. It should also not be over-engineered or baroque :)

One possibility is to give up the flat structure, and form the
directory like this:
arago-master-wip-config/arago/distro_arago/machine_am62xx. Which also
has drawbacks and needs to be done now, not later. Perhaps omitting
the single choice entries would also make it shorter. But will cause
problems if later on additional entries are added to configs and
single choice items cease to be single choice.

If you want to specify a custom format string then it should be placed
somewhere common to all json config files in a registry. E.g. a
'registry settings' file?

Alex

