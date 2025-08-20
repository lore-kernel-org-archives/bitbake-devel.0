Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDACA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:42:14 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.1942.1755708130736197617
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 09:42:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CSDPSmTN;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e87068760bso781473985a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755708130; x=1756312930; darn=lists.openembedded.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AT0b4MnrWDmQLY0Rr7WPW3EgLsScgNDOl/mukupq/oU=;
        b=CSDPSmTNoCHgwkQVSl1d7jPKqyiCYVe2MDZ1EHc+oSsPzXr8XV/K9is8j3RD0E4EFz
         Shl/WX3OC8u6/Kpl90iGpG0kfSIjq+Uz4Ammyy915TwIWEXUeqraZcwsRkC8R0TBRRbr
         vBmAMV/KiOdxIlQaCn4JBN2zYIvWddl7p9Ytg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708130; x=1756312930;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT0b4MnrWDmQLY0Rr7WPW3EgLsScgNDOl/mukupq/oU=;
        b=dLZi46updcCHuOgIO0a6BPedgHqFwc/rOteAbfwl6dFS/caQ74v8co78P6sU4Yi3pY
         GRUqVvogLPlnzGGgPRtugiigPJ6YjcaZh5BPOX8pzTBidiJN+Av2Vh+FFSRfHJtJ8YcJ
         RcSLjVCktpbQocw1KEJepSgJrkJjTNESoUJ6+F7CZZCC7yBCKtb4EnozmO3/mkrk2EqC
         fXXRw9sATvh8XtvyZMFnJw42sfcUKBFE/DdWFh0KGw92/tnD4cLpXI1KJTFIzG8PesY6
         6b7KETu5J8eZu5xjKIbc64Bp+BfUMHIyhKgTldAi3klwtfRmVmowOG9wFdCYO6jhCrug
         6XHA==
X-Forwarded-Encrypted: i=1; AJvYcCUuhSbUdFXe7nz+n7u3u0lXr2QCg63bOdaDWgSAE/jdZwAKVXJxZOIztvAkEXlSIUhhwMNCpn0ERZ80ijy0@lists.openembedded.org
X-Gm-Message-State: AOJu0YwzSewg60kSzGlRt6FBeEvLG/eCVtn9VA0yZrYAvoZJwny5ILPa
	G4GTSemAnzdT7mubvkYPXLPtXGkr7NQ6owTMEMWWq82pka5iMs52LeBL2XX5f6BYDuY=
X-Gm-Gg: ASbGncv6csg0nJGsjmRYPO3zl8gcc8dm6Um+SKuv6Hzl06/h2yWu8RF8NV7ohbbnDwy
	AOafjQD5eJZCGXpXEnIvFgLzVOHHEs5650GgQHfS68tU+St81uGzJ1o1xowq/XriwJKLitBYEuN
	nglmVgcPLmJ+nL1Q1yuo8j4CM+7Z4WKZgZKAKlT2tg/9Wbyf8e8Kk6JhG5Y9/fXb+3IfjH5lfBI
	rMyFAzpaqD2H/9+aET4Nh3zWjG8zWBoIT6hZLjIlDNJ9NiUyba4mOZjQoGrYj9bId5anD4ddMT5
	LNlt617xdyTPeJGoa2Jfvr5FukZB5RlXDBNwHBqEUbBnbsXDFxtTjFhzlryeQ54B0VGdnuXu3WJ
	l09H08vmIMAgdPSFRv/QbVTBHUdYt+HQ/fpF9IRmPp4zhvtvB7CkMf/Vy
X-Google-Smtp-Source: AGHT+IGOUKn6v69HJelT5Fy/3v3hgObyVWWAFTyKfSKx6xGP/ggCE8SO9Zp5tsMcz72ju/Lnh5RBXQ==
X-Received: by 2002:a05:620a:701b:b0:7e8:7094:52dc with SMTP id af79cd13be357-7e9fca78f79mr357909385a.7.1755708129534;
        Wed, 20 Aug 2025 09:42:09 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba909e68csm90397946d6.29.2025.08.20.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:42:09 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:42:08 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: richard.purdie@linuxfoundation.org
cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
    bitbake-devel@lists.openembedded.org, Tim Orling <tim.orling@konsulko.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
In-Reply-To: <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
Message-ID: <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com> <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org> <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
 <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 16:42:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17894

On Wed, 20 Aug 2025, Richard Purdie via lists.openembedded.org wrote:

> On Wed, 2025-08-20 at 11:29 +0200, Alexander Kanavin wrote:
> > Thank. I didn't polish the UI as I wanted to get the 'new
> > functionality' out as soon as possible. I also already want to tweak a
> > few things in the output.
> >
> > By the way here are the slides I'm going to show in less than a week
> > in OSS Amsterdam:
> > https://osseu2025.sched.com/event/25VtR
> >
> > There's a nice hand-drawn chart of how bitbake-setup puts all the
> > pieces together in creating a build/conf and layers checkout for
> > bitbake to be able to run. If you can take a moment and take a look,
> > I'd appreciate.
>
> I will take a look, I can't right now but remind me if I don't
> remember.
>
> > > I think we should probably be "properly" integrating into the user's
> > > HOME, i.e. create ~/.config/bitbake/bitbake-setup.conf and
> > > ~/.cache/bitbake/downloads by default out the box too, we may as well
> > > make bitbake appear a "proper" citizen if used this way.
> >
> > I'm not sure about using ~/.config and ~/.cache.
> >
> > I introduced the concept of 'top directory' (where everything else is)
> > on purpose, such that there can be multiple top directories, each with
> > its own bitbake-setup settings file and site.conf. If you look at the
> > settings file:
> >
> > [default]
> > registry = git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main
> > dl-dir = /home/alex/bitbake-builds/.bitbake-setup-downloads
> >
> > there can be conceivable use cases where users would want to have
> > multiple such files, each with its own registry location and dl-dir
> > (and site.conf items in a separate file). E.g one for builds internal
> > to their organization and another for upstream yocto work.
>
> I agree we should allow this to be configured, I'm just thinking the
> .config/.cache directories might be the right place to put the
> defaults. This does move bitbake (or bitbake-setup really) to become
> more of a distro/system tool. I'm still not 100% sure if we should do
> that but using the standard locations by default would fit with that.

I can see where you're coming from, as this shadows how git config works,
but the top directory behavior is something I've been on the fence about
with bitbake-setup, and this seems like it'd maybe make that worse.  With
things as they are now, I fear I'll be having to document passing the
--top-dir option in any bitbake-setup usage to avoid contamination of
configurations between projects, and avoid users asking why they're having
stuff show up in $HOME.  I'd honestly prefer if it only operated in the
current working directory by default like whisk and kas.

Scott


