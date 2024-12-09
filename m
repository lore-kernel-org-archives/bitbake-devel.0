Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C5E7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 14:59:32 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.103478.1733756367332796547
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 06:59:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QZVyrBQp;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d8fa32d3d6so24206106d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733756366; x=1734361166; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+tCm8i2csGX4naXKHcAg3uZ+dz5dwrL0yNmut4jV4Sg=;
        b=QZVyrBQpq8sad7T8wpvnurtmEIvjfwZE2S460/5jhM2MSj+sQXyopYd3zLB0LcevS3
         qf6X2js6MWG5AEFvb4dlm2fyhu7f49Uw/9GAl2RE2N/RSb6SyTuB7f+Zp9am8VvO1wEo
         I+39RErOfAwuMq1GTeTEzJ6HOQ5hUD+w1fSLTtirCwZno1MWq95ee3Spd1pVvmpsrYEa
         mDY9NkJUIZUmJFT7BAE8UnO+5Gnvq9QHN09Zb69XvGL6Rzp3pBVYUz0Y9/qQ/GGeQZvf
         RXQWVNuLea35jv1O1rMxmIZXO7oy6ulGp0aK7zDje4rjE/4Kqz3eASGrh3SPMdjAXrUE
         qdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756366; x=1734361166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tCm8i2csGX4naXKHcAg3uZ+dz5dwrL0yNmut4jV4Sg=;
        b=kpF6bS13SSe+UL8qxXlWBBWKriRH9i6mGImkYnQxMYu4uMzkF8NHGHfNAGDi0iXf6x
         LcRgWImMrjEkpPpIVlC/rCNzLvNotacVzgQoKfjP1gHp5XKCeUJGueLfbmrwkSx0KwEO
         k7SD0exSs9aNg6DId3i1Sf5lGRxS3ULlCpkew6EXdxirfRq80/APvQiHiqRz/hS4bWAV
         N5V3afCyL6D1h49dPhusMCrCCDLFAkcUMdQxZ4F6FcdwmdPRgqqme2nBt9I+IjSDIoZr
         7EENvEO31ubltFarnwgNkBwdeVNtcspLW/uhTobbZEzSTK+h1GfMTe4WVjrGc5X0CMQA
         qgFA==
X-Gm-Message-State: AOJu0YybblmZVmdwIgTqQO8zedczFvemLL8uXxDxEKyi/iu7B9xUH5Ft
	h7hrD+OvnQkDiOJ6SMWIO4f2ZLm5i8P9QjVHYWs3zWYlUhvAsfz7gb5app6dFU/6j884mLfWOMy
	3S+qOwhhgNajM1+pil7EWaPUYWAU=
X-Gm-Gg: ASbGncu77J5tmpwb2jqz3YKBJaLRf6+7dLpZgWbbOEjWYQyan+zssCZXwf2UeKfiEIu
	SVqhux6Sy2WwejcdGb2weIM6DSaqPpIvmzmTgXDKRtfAhisJWA/ltGcGzNfklixZzpg==
X-Google-Smtp-Source: AGHT+IFSEDP6NXD6iR4Ynmx/jWIIh5ZZHHygkD4uNgTw1XLqFkKVPXcsJrONRAcV0Jklb160XLzm7ALgWmC9F+UM5dE=
X-Received: by 2002:ad4:5f8f:0:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6d91e314546mr12655696d6.17.1733756366439; Mon, 09 Dec 2024
 06:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20241209133053.2494088-1-alex.kanavin@gmail.com> <e0d3f4c1-f252-44f4-9e45-dbfa13b41996@cherry.de>
In-Reply-To: <e0d3f4c1-f252-44f4-9e45-dbfa13b41996@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 9 Dec 2024 15:59:15 +0100
Message-ID: <CANNYZj-LziSwSdKMCTkRQgwzHBM_TFoZhkKbx9Tvcf943zBS8Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual-metadata: add a
 section about 'addfragments`
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 14:59:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16899

On Mon, 9 Dec 2024 at 15:35, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > +
> > +   addfragments conf/fragments OE_FRAGMENTS
> > +
> > +``addfragments`` takes two parameters:
> > +
> > +-  path prefix for fragment files inside the layer file tree
> > +
>
> I assume you can addfragments a fragment from another layer? So that
> would mean this is a path relative to any layer's LAYER_DIR dir?

addfragments in itself does not add fragments to a currently active
build. It declares two things:

- what is the variable name whose value contains enabled fragments in
an active build
- where to find the fragment files in layers when bitbake is going
over items in that variable and transforming them into require
directives

There's an example below that shows how the transformation from
fragment names to require directives happens.

addfragments is not something users of fragments need to worry about.
It's set just once in bitbake.conf, and the overwhelming majority of
yocto users would be using bitbake.conf from oe-core. But it needs to
be documented as a bitbake syntax item.

> > +   require /path/to/core-layer/conf/fragments/domain/somefragment.conf
> > +   require /path/to/core-layer/conf/fragments/someotherfragment.conf
> > +   require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
> > +
>
> Can you tell us about a typical case this would be useful? I assume
> there's a reason this was implemented :)

This has been discussed on various mailing lists many times, you can
search for fragments to find those dicsussions. In bitbake docs I'm
only saying 'This directive allows fine-tuning local configurations
with configuration snippets contained in layers in a structured,
controlled way. ' and not more. The actual user-facing documentation
for fragments will go into yocto manuals, once the remaining pieces
(tools and tests for them) merge into oe-core.

Alex

