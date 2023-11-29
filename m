Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18C0C46CA3
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 11:38:22 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.30778.1701257896240880279
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 03:38:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U53l/KDa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.176, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so82083351fa.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 03:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701257894; x=1701862694; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I80e9gtIpfIqH4jg/39geY0UN73Lh8EekK9suhnU1G0=;
        b=U53l/KDa7pYQeGkWxHbhWl0RX8UVCAk3tX1uprfPzyrFCV23Y73o/7knybuYJikKNS
         pXFQ7SRNe0OMNVRr8iaLIoaANN6RjAk8P7hppFTlrUpI63XIngA7HRzQngoEAMqA8XJq
         IhE2fPM+j5xKaZheu6jNvrJdECAjmpVVEBxbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257894; x=1701862694;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I80e9gtIpfIqH4jg/39geY0UN73Lh8EekK9suhnU1G0=;
        b=oW2xtZ2x6ssdUoo3N0XZm7jaGpB2Y733rk9fFxBuBwxSdK0zYzZ/GpXs21tiBRTrJC
         OUormC4fmATrw5uvL9qGE2jEGUOFxunSHBoj/az7QYMkmrNp/FrKhffznO/yl+fpRRGY
         sUlReNfSC5TKsLP0wDx5KDTkOoaMZSflkb1lkG135xdbhtphdXZ+UuTsUop8aDG1CUAN
         n/ZZEzazeNFfSjYX9tJk8ADCWpegepDyqULjV3U5VmKejh6uUjLAHsRwGhNy54tyN5SQ
         dxsJZ4Wd57ub42msGnpckL/XstpSDKLK3TBlMqawSgl4aLxECIFZN7uHrD3hA4ABaJRI
         D6tw==
X-Gm-Message-State: AOJu0YwsYjBP2zfARjajS4PI1lqYeZXqknckKKi3w/+fx9mJCdaDsBG9
	Zwu7Hk/lArLyWCqWXDq5Lpp9vA==
X-Google-Smtp-Source: AGHT+IE4RLyM3NJKSzk0iPH5NwLl09lbHrfyarmp4HuPLcPfLRmvraB/TEeiJqHw0H/L5tRToFO7xg==
X-Received: by 2002:a2e:b1c7:0:b0:2c9:c125:c8fe with SMTP id e7-20020a2eb1c7000000b002c9c125c8femr759042lja.7.1701257894192;
        Wed, 29 Nov 2023 03:38:14 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8ea1:d952:d81c:3bac? ([2001:8b0:aba:5f3c:8ea1:d952:d81c:3bac])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b0040b4e44cf8dsm1951615wms.47.2023.11.29.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:38:13 -0800 (PST)
Message-ID: <b09c64c3bce3210b8265550c864f1df98bc13b35.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Added feat to import eventlogs
 files as builds in toaster
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Date: Wed, 29 Nov 2023 11:38:13 +0000
In-Reply-To: <20231127204913.94683-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: 
	<20231127204913.94683-1-marlon.rodriguez-garcia@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 11:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15578

Hi Marlon,

On Mon, 2023-11-27 at 15:49 -0500, Marlon Rodriguez Garcia wrote:
> New feature added to recreate command line builds that are made when toas=
ter is off.
> The feature contains a new button on the base template to access a new te=
mplate.
> A new model was added to register the information on the builds and gener=
ate access links
> A new form was added to include the option to load specific files
> This feature uses the value from the variable BB_DEFAULT_EVENTLOG to read=
 the files created by bitbake
>=20
> Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
> ---
>  lib/bb/ui/toasterui.py                        |   2 +-
>  .../orm/migrations/0021_eventlogsimports.py   |  22 ++
>  lib/toaster/orm/models.py                     |   9 +
>  lib/toaster/toastergui/forms.py               |  13 ++
>  lib/toaster/toastergui/templates/base.html    |   3 +-
>  .../templates/command_line_builds.html        | 171 ++++++++++++++++
>  lib/toaster/toastergui/urls.py                |   1 +
>  lib/toaster/toastergui/views.py               | 188 +++++++++++++++++-
>  8 files changed, 405 insertions(+), 4 deletions(-)
>  create mode 100644 lib/toaster/orm/migrations/0021_eventlogsimports.py
>  create mode 100644 lib/toaster/toastergui/forms.py
>  create mode 100644 lib/toaster/toastergui/templates/command_line_builds.=
html

Thanks, this is looking promising. I tested it and the main thing which
didn't feel so good from a UI perspective is that I'd click something
to import and I didn't get any feedback that it was happening. After a
while it would move me to the build page but there was no progress bar
or any other indication anything was happening. If I click a couple,
only the first is acted upon too.

Where the UI says "Import eventlog files from directory", I'd probably
change that to "Eventlogs from existing build directory:" but that is a
minor thing.

Also, on the landing page, would it make sense to put the "Import
commandline builds" as an extra button alongside the "Create your first
toaster project to run managed builds" and "Toaster is ready to capture
your commandline builds" on the landing page?

Cheers,

Richard

