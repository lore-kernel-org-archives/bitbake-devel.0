Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C100C83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 10:02:36 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.77743.1753696946953751237
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jul 2025 03:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bZwuLLIc;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e1d89fcc31so410444285a.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696946; x=1754301746; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8/pbuW0UQwylw2LD7npAEusYc9Og/EGU+Nr3ewk9MO4=;
        b=bZwuLLIchNGF4yXKM2fU4BzpdsP2OY1YQyoAr+VYFj/JwgT/DXhfCPo+FyP10CHyw7
         7e1558tAXQuPTbmJR8kz7JvsNtGxBh5gWHxf9fHiW1HkSiZ08tRrfhtY2xSKOkN4BIfk
         l+7Kr7+GpJf74l9EUHavQfD2ihN7KplL+375Vjs11Yh/kpT0+gP7bkRrlwxmt80dUNIM
         9jFOx0JZyD949vDUhn/cNVrHTauKTLaLo4nWJiop/fbRKTOJO6krNzsRiEZUEEFRE3pY
         G5Kdz/U9GR6VE9S2MiUUguwTKPkTEFWh9oPoJDD/TSUu7nIodZIvu5dNFuEc4gpVcAmw
         bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696946; x=1754301746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/pbuW0UQwylw2LD7npAEusYc9Og/EGU+Nr3ewk9MO4=;
        b=BpJXI5vjFZBP4tLmv74giBIAO8R73vodRDxNXMx0mcEWE5r0c48721TMTmcUQU8t/1
         ay0bUHl8ORycmsaY7g0cfpkG+uSMdEuY1L3Yx2nhhe9OMluZtg6+ZgD+B1n+eyXLl3fk
         RZX6fOkQj0qTv4bPjPoALqPzBACSM323EbOPO1jlq4CvtbHi5zm7cyNBoXmH0+AQgh7g
         I/hqstJRLopm1axqiRZQD5QNXSrbFg9bhGQJzrdKz/JYxnyxf+7YhN9vUNFVd3inGWr4
         F1FiSQpAm4bFKRP5Vhql3rWk1r/GrXJahsbxwTPopckV1w05CWzdzx6h0ds3xyrG4CLh
         5JKA==
X-Gm-Message-State: AOJu0YywZU4EWrV+/8nmlrtsG9xx/Bn6sUTxosIL37g1wiRXw79LlCY3
	l4EYa3YdoiR5Klm9+nP5xrw1ZnoGBaoBuVwWxSs6yaNZI8Y1zIe1r0DxUzRywxo85KurPPN+y0m
	PJdc7Q30eaOR+4Zdaxk5obs5T4TK6wobSo2pNrUE=
X-Gm-Gg: ASbGncviSDAYm4A4Xms9KZYhNpIdl+y6qxNwU4tbbb1KPuNu5Q2tc6ctnitL+vKamji
	ltg5NvPUHK/yBubOQcn3AKCGGnmy9olohllGNQ/nvcsikq8+Njr92v+AQB12Hm2S9yr+LbAAEw6
	+Jzz8uvs7qm29CWQYXOcD+fiQsV1T8b1fXqru7lKMhf57XF7q6vxwz+5X7Iw85mjq+zSHuFMSHM
	rBxiSxWpkyqFtMRKPSk8Ksowh6Sj7xgSUjnRaNg59ArhBQRFaOs
X-Google-Smtp-Source: AGHT+IFcqd6oO8nKpWplclBm3WfCmXQinixGbgs/cPGxNcTPSUg6DIxAKPs1bAbgnaUd7S6ZBihxVIErubI/5MVLq6U=
X-Received: by 2002:ad4:4eae:0:b0:707:4998:711d with SMTP id
 6a1803df08f44-70749987306mr40159806d6.34.1753696945461; Mon, 28 Jul 2025
 03:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250630101828.3109911-1-alex.kanavin@gmail.com> <CAMSfU+7CQaNKDbJyu8NY6VKC=K-M2vVmgO1UxB2HvRSe5zWuhg@mail.gmail.com>
In-Reply-To: <CAMSfU+7CQaNKDbJyu8NY6VKC=K-M2vVmgO1UxB2HvRSe5zWuhg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 28 Jul 2025 12:02:13 +0200
X-Gm-Features: Ac12FXzTKSEIkag6QTnANVuOwSawfue1h0xqiDrBuzpwv4urcbRHCx-8zb2x1qg
Message-ID: <CANNYZj8+2hmPFCin-ZSG6F6msCvWfKPnSF9DnMUUMcTrt=ya4Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: add the initial implementation
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 10:02:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17813

On Thu, 24 Jul 2025 at 10:59, Yoann Congal <yoann.congal@smile.fr> wrote:
> Here is my attempt at reviewing bitbake-setup. I'll explain how I've tried to use it, what I found along the way.
> I have not (yet) reviewed the code, only the user perspective.

Hello, and thanks for looking.

> First, I find that this is definitely the right track.
> I like how it is based on bitbake tools and not directly writing in .conf files, that will definitely help maintenance long-term.

Yes. The problem with tools like kas is that they take the easy way
out of managing everything themselves, instead of first taking the
trouble to add the needed pieces to the core project, having them
available in a yocto release, and then using them. For bitbake-setup,
the goal from the start was to build the integrated functionality from
smaller concepts and tools available directly in bitbake/core. That's
why bitbake-setup itself is comparatively short (again, compare with
lines of code in kas).

> Then, here is what I've did: I've try to migrate 2 projects from Cooker (https://github.com/cpb-/yocto-cooker) to bitbake-setup:
> * our contribution project (basically yocto-master but pointed at our gitlab mirrors)
> * a simple existing project of one of our customer (Scarthgap poky.git + BSP layers + some lib layers, 1 distro, 2 images)
>
> The contribution project migrated quite easily but I was stuck on the scarthgap project.
> The bitbake inside does not have bitbake-config-build which is needed to configure a build from fragments.
> Maybe I could have used the oe-template mechanism instead of the fragments from config?
> I finally (virtually) upgraded the project to master and then, no trouble to migrate the configuration.

Yes, scarthgap is too old for fragments, so the only option is
templates. Bitbake-setup will have reduced functionality when used
with older yocto releases. Something even older (like kirkstone) has
no support for templates (via oe-setup-build) either, so bitbake-setup
will only check out the layers, create bblayers.conf with a subset of
those, and then stop.

> I agree with the need to make some elements common between configurations:
> * most config of a project will share the same layer set,
> * the "dev" config should inherit the "prod" config, ...
> (You mentioned this in your intro)

Yes, I'm going to implement this.

> I think I found 2 bugs:
> * Calling "bitbake-setup init non-existing-file.json" will default to cloning the default registry (where I expected to fail with a error message)

The problem is ambiguity of whether that argument is a file or a
reference into the config registry.

If the file is non-existing on local disk, then bitbake-setup will try
to find it in the registry. Otherwise how would it know that it's not
in the registry either? I can tweak the logic, but you need to propose
a better sequence (or UI).

> * When sh is dash, the init process fail because dash does not support the source argument:
> see https://git.yoctoproject.org/poky/tree/oe-init-build-env#n11
> and where the bug is (I guess): https://github.com/kanavin/bitbake/blob/akanavin/bitbake-setup/bin/bitbake-setup#L136

Can you provide a way to reproduce this? sh is dash on my build
machine and laptop (both debian), and I have not seen issues so far.

> Coming from Cooker, I miss some features (I'll totally accept to be told to adapt ^^):
> * setting bitbake conf variable directly from the config json (but I agree the fragments are neater)

As you may expect, the answer is a firm no. I'd like to move away from
doing standard configurations with a pile of random undocumented
tweaks in local.conf, and allowing this would be basically the same.
If you need to tweak something in the standard config, there's always
a better place for maintaining it than local.conf (or the top level
project config file): distros, fragments or bbappends.

> * Using already checked-out layers : For simple projects, we have the JSON configuration and the project layers inside the same git repo. IIUC, bb-setup always does a clone for layers.
> Maybe this can be fixed by not handling layers as a "source" and having a way to add layer to bb configuration by their relative path to the JSON config (similar to how OEROOT template work?)

This would break status/update commands? I'd say it's fine to put json
file into a layer, and list that same layer in the json layer checkout
section. Then it will be first cloned as registry for getting to the
config, and then again under layers/ for using the layers in it in a
build.

> * I don't like mixing projects, so that mean I'll use different top-dir for each. Having to repeat --top-dir everytime is a bit cumbersome, maybe add an envvar that can change the topdir defaut?

Bitbake-setup makes a separate directory under the top-dir for each
project, so they should not step on each other. But there can be
different reasons to tweak the top dir, so I'll add this. Perhaps a
~/.bitbake-setup-topdir file that sets the default as well. I don't
particularly like magic environment variables, as their presence at
runtime is harder to debug than presence of config files on disk.

> Finally, a question, how do you recommend to handle my local SSTATE_DIR/DL_DIR? Setup with bbsetup, copy a site.conf with these config inside the build, then the proper build? ... or is there a better way?

This is an unresolved question. I'm open to proposals. Or code.

I guess it will be something like 'bitbake-setup change-setting
default site-conf /path/to/site.conf', and then bitbake-setup will add
that to every build that is initialized. Site.conf need not list site
settings directly, it too can add a fragment maintained in a layer.
That way CI settings can be specified and maintained in a layer, but
they don't need to be added to a json config, as that would impose
them on everyone using that config to reproduce builds locally.

> Sorry for the messy mail, I hope it will be somewhat useful.

It certainly is!

Alex

