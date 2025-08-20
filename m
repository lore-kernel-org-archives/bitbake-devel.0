Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC65CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 20:15:25 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.7185.1755720919532846916
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 13:15:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CzV2cjFU;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e87050b077so35259985a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755720918; x=1756325718; darn=lists.openembedded.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zOVueOqbNLl/oONh8I8bJxhmVJ5X/r9ruJUG+m0k3I=;
        b=CzV2cjFUGb/fJsOQUGcNTxft7hgpCz0QDteeBvq5zFsq0XjXiZA9vaSWfrC4Hq26/L
         vVM5ZaVXOZ6IU4vmDjP0Op0FjvxHBMokAG94DgtU/6/SUBsBh35kST9l3o+dHFYsm61V
         aryUhD46XM5qyub6xsRCB/VCjdRYXSRGQsPWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755720918; x=1756325718;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zOVueOqbNLl/oONh8I8bJxhmVJ5X/r9ruJUG+m0k3I=;
        b=FVZT0SQqWOHtpqj5j8+8UNHYlIpvvAriQ8wJnexPfA3LbNDg65iH+yVjy/lVVj08KW
         q1kYxyBRjKfZDG8Bz2aBwiDODB4e0Zlh+omHg1q0Vy0Cq+q1QU966koW10Okbkv5NH8S
         vLEUHz096XA2VmoXPdyxyIsCaWB3yGOC8OPx9amIv/suJF5b2JhcTPNWAdrl5qoNJQnK
         o4MA8bvZX7HYDtARFoPwCUoi3vPu/VUb3b+5i4QEUYFUxKmYUfbF9edlcgqyZdZYbNCJ
         UiftWDWsM6bEbXK/MfW1QD+woYmNOmcsqUwXTE95MMj+ZWRoUdhht2feU1rVVKPkd+bg
         GU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUza/6Xx4vw8hqZfAUWbOR0xPTPcXdg/VtSpdk3NzMTYhHyx/QTTYSRYGKCZmVFRz9jX7ew5vvt2Xr13/gg@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy3/dgZ+FjJRLTseSB2R5bd27RRlWOLvWfTNak05duBnWuuCFfj
	NyGQEvaNxnmqQ8q63hfTmYkPoBaCgs569O/qeQeWvxXbg3yIOpEjRL7mFjuR8iwRPpI=
X-Gm-Gg: ASbGncu60MS6MJTaTo6T6VYMIhKUPlmu22rQj1O+IvC2/qPokHXsscCYbrtMDR3P+3H
	yM6iuyBQLsrdZt0eWUPEgr5+fNxUoIfH82LivVNhRhDkL4tDlBE2dME+r/tfPk13PB4TeGy6IIG
	jpJep/+W3/bGVRq/FcZZVcbMx7q/1ThPqT23XlrmsVUyHRzHDmACcfUyN3TpqcqcV5P9mYl0pA7
	uyzA61VLxxQ+QrU7p3G3DIOs7MHbzQ13eagTSdMXXCMGSRGZPLCbtaFMTkz+dQglsIk0dSar+ub
	0HEGN/PnNDz+j4P1VPLMXx3jOaDXZHG4DnuzZyaPJ5sl7NRDdqyvFzhl0NwRKvBl0OG2mgXc+Wp
	M5AjIdqnYGCbrsPlOFSoHvARo6f11oaSN/3V3eFuZDp3F8n9wKpWLEjQ3
X-Google-Smtp-Source: AGHT+IFut/XPvwvaKWAW+EAgjXgVaAnq7rCDEbbSOMRdPna1I7XhZJdfJetH9ukG+PxXXVyjBREN7g==
X-Received: by 2002:a05:620a:19a5:b0:7e8:3c3:8321 with SMTP id af79cd13be357-7e9fcabee67mr490610285a.27.1755720917972;
        Wed, 20 Aug 2025 13:15:17 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0228f1sm1017745485a.8.2025.08.20.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:15:17 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:15:16 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
    Tim Orling <tim.orling@konsulko.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
In-Reply-To: <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com>
Message-ID: <647b238c-cf12-eb7b-d243-038854180192@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com> <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org> <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com> <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com> <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 20:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17897

On Wed, 20 Aug 2025, Alexander Kanavin wrote:

> On Wed, 20 Aug 2025 at 18:42, Scott Murray <scott.murray@konsulko.com> wrote:
>
> > I can see where you're coming from, as this shadows how git config works,
> > but the top directory behavior is something I've been on the fence about
> > with bitbake-setup, and this seems like it'd maybe make that worse.  With
> > things as they are now, I fear I'll be having to document passing the
> > --top-dir option in any bitbake-setup usage to avoid contamination of
> > configurations between projects, and avoid users asking why they're having
> > stuff show up in $HOME.  I'd honestly prefer if it only operated in the
> > current working directory by default like whisk and kas.
>
> You only need --top-dir if you're not in a bitbake environment yet. If
> you are, bitbake-setup will deduce top-dir from BBPATH.

Sure, but my point is that's what I'll be doing every time I set up
any project (and maybe reconfiguring it?), so effectively for me the
default behavior is not useful.  I doubt I am alone in doing all my
development work on a different disk than where /home is on my dev
and build machines.

Scott




