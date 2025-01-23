Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D262C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 17:12:32 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.16518.1737652344722806426
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 09:12:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HpwohYMp;
 spf=pass (domain: gmail.com, ip: 209.85.219.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e460717039fso1641624276.0;
        Thu, 23 Jan 2025 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737652344; x=1738257144; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKeiBZoMt3cDdIG6w+E1kKSf003j23UHtQeGLUByoXI=;
        b=HpwohYMpjoJZKi3n1c393De3V3SSfioo0XGp51oUhCtPwN0Zh3YG77qX4pRJItI1Pj
         sJAlUFlBy9O6r/TIk+BV7WljjUoxJAtbe8jxCazR2KQhAgLbMPnNvwDA7x73EyXaB7ch
         GmNKi9TLqT7hTWBvBu3dF52hZ8MNv7/B6jY3/201sy4rIomfx/LuDDiiOYZoKe+Ea6ju
         0wuQWA0Vw7/LSJKlOav72BA1N7VBiJJPKt2h0daXG6hGZnHOOSKe4oNfZa4p+smJHdvL
         MHo+ea10QivTzRfsM/Af1xySol4NuKxsyyuxsGkiqqdwD0X8hg146+hkzazugSTsZ3Cp
         x1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652344; x=1738257144;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKeiBZoMt3cDdIG6w+E1kKSf003j23UHtQeGLUByoXI=;
        b=gVbGk556s/FzQdsU96YlEoYbyCxG3Ngw3KxuKHHFrNrmpiM6h7M7z8zHqB1gDdZFJi
         SJxUd7cARgLXsv36wlOvr9RrMWR+StopRvVrQy26VsT7e1zJs7fxvnZItLNVJV0gVBjb
         trCSamnvgLPhA6mUKdm+xSU8Lsobv9gQPGpRYB1sjc2rBEhn++bfgtS3ZxjP9P4KJrt7
         vL/0TB3yCb8AbpCx4Lu98iDEkB8WqMB9tURIev5KDr+O3lyjfm39XSz226R6I+NSqBXq
         q2qazsAtQireibR+e41jdGmGHkCrtiRMfINzwanBJ6tttwgAgKAHMpUzzE8W78xiFsNf
         OTyw==
X-Forwarded-Encrypted: i=1; AJvYcCUCiwpLlqRXH1swq7qtpDkrZaspgXNXgsA/0jTLtQ27HLQ6a2TuVb0hR0nGiNK31GsXwASMeSZFRU6unhiJVvQR+yyHX9BCRSn2@lists.openembedded.org
X-Gm-Message-State: AOJu0YxWTNzAgWOmlXpJVDV0I9M7amEO1YH09B4SQbbhVjpJwfAGPlZl
	+F+UIfeXR53aN5rgVw4wnPsU1mZYq8QeCp5T1e61v49W5pZ4UrwbAj0djUp5ooWT5/vVKl55msA
	8swXpxevaJpi3eYrV9SdgYZ7wiHhxUA==
X-Gm-Gg: ASbGncs9pu2VDQZqCpk1q22igzDjTSnugiAjLNRzX7teofCpU84MkI+JtByBVYmLnYE
	upGDTksyQac482qj5jJTsk80xl5lL44m1oMAL2k7t1je+hes6K6YOGI+DpQZH
X-Google-Smtp-Source: AGHT+IEaX6z1uzj18tj+1+nRYLOTjt/j+3TLL+9HdTWEpbTJcIGC0ridlzrYtr/HY9BdSZBYtXAVLTVpqRZoY4rWkPM=
X-Received: by 2002:a05:6902:1144:b0:e38:8a2e:e3bc with SMTP id
 3f1490d57ef6-e57b1035f23mr21468562276.5.1737652343623; Thu, 23 Jan 2025
 09:12:23 -0800 (PST)
MIME-Version: 1.0
References: <181B8041053EB73B.1562@lists.openembedded.org>
In-Reply-To: <181B8041053EB73B.1562@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 23 Jan 2025 18:12:12 +0100
X-Gm-Features: AbW1kvYGtYUBhq3ZF3VSbfhyVAgaiIQMZbNxSp9hkDCRk8CfdzzAKJeJ_2anX1k
Message-ID: <CANNYZj9StZ26LENRbN=Z6mdFhOXsgN_Uf3hMqwL7NXn67Fibpw@mail.gmail.com>
Subject: Terminology for bitbake-setup
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 17:12:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17069

On Fri, 17 Jan 2025 at 15:11, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> - tighten the terminology: 'build' and 'configuration' are each used to refer to
> several distinct things, and should be replaced by specific, unambiguous terms

So here's the hopefully sensible :) proposal. Note that each section
below cross-references definitions in other sections, so the full
picture will not form until the end :)

- 'top directory' means the place under which bitbake-setup reads and
writes everything. It makes a promise to not touch anything outside of
that, unless otherwise directed to by entries in settings (currently
there is one such setting for fetcher downloads for layers and config
registries). Top directory can be selected by a command line option,
or otherwise assumed to be ~/bitbake-builds/

- 'settings' means bitbake-setup operational parameters that are
global to all builds under a top directory. E.g. the location of
configuration registry, or where the bitbake fetcher should place the
downloads (DL_DIR setting). Settings are stored in a .conf file in ini
format just under the top directory.

- ' build' means a tree structure set up by 'bitbake-setup init',
consisting of, at least, a layers checkout, and a set of bitbake
builds. It maps 1:1 to the json data it was constructed from, which is
called 'configuration'. Configuration files are either standalone
files, or are obtained from git repositories called 'config
registries', in which case they can be listed with 'bitbake-setup
list'. There can be multiple 'builds' under a top directory. Here's an
example configuration that showcases this:
https://github.com/kanavin/bitbake-setup-configurations/blob/main/poky-alex.conf.json

- 'bitbake-setup status' will tell if a configuration is in sync with
the build. 'bitbake-setup update' will bring them in sync if needed.

- 'bitbake build' means a particular sub-tree inside a build that
bitbake itself operates on, e.g. what is specified in BBPATH/BUILDDIR
by oe-init-build-env. conf/* in that tree is 'bitbake configuration'.
Bitbake configurations are constructed from templates and fragments,
with existing mechanisms provided by oe-core. I structured the
configuration file format such that other mechanisms to set up a
bitbake build can be added; there was a mention of ability to specify
local.conf content and a set of layers directly in a configuration. I
think that scales poorly compared to templates and fragments, but I
made sure alternative ways to configure a bitbake build are possible
to specify in a configuration :)

Finally, this is how bitbake-setup already works; I just need to go
over the code, and make adjustments to variable/function names and
printouts to ensure there's no ambiguity or confusion.

Cheers,
Alex

