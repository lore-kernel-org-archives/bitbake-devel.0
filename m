Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35484EE498F
	for <webhook@archiver.kernel.org>; Wed, 11 Sep 2024 10:25:23 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.18717.1726050317162517107
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Sep 2024 03:25:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EOeIkFH/;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365cf5de24so5328349e87.1;
        Wed, 11 Sep 2024 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726050315; x=1726655115; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GrPgQReS97mgjD1zGR5f/LmZMk6tKyIFsh3xVrofKmA=;
        b=EOeIkFH/RFIPNETVfSYTeLz7hmNEIkxcFiVdNGbf3Vm+o+VtbSinhEXSMvQS5ACx6R
         5SO6h4NO5Q+teqaJ3iySRO67PMSwRxDysBzoVqI8dMko6kBM3PDKAKWUPqfBvUy1V/kF
         pFlqQGH0BwMM6C4QYMHW889LDwyqWjYl6zjKWITO0720Z+/2HFGSoS92gzoCjM3PJjS8
         c5jUpp5OyiOsgcOBmlKogWvacnd/EFB4hGzidMSL2lRd9bUcwoudp+NOS57ZVduhUG+1
         D7kNTiCwt0nVCryzhLG7a96GpOz1y6ARcFVc3+kNKZlMbeA7yPJGi+4LVZ03iPjo/3ZI
         LUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050315; x=1726655115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrPgQReS97mgjD1zGR5f/LmZMk6tKyIFsh3xVrofKmA=;
        b=GFuaIFFW9RocLv5JfJQUOME3zprEqJPg1M4lQJ3EKZWv4B2sFsrp+Orf+1d3C9iGWr
         4fRPdNhXYAjgPo+NnCHqijQlEBzeAAVD9GDrzUOEQOOEeg4Xx7Kiu3itvbUYbG0Jnybk
         TITCE4vByLG5ong1f6HgK3BDM1oYOWizYs+bYnzuNd1BuP8IGJjoaJFoJOjn986zi/aS
         Kei6IIeWqNPPoAC5RbX31LLA6XPhOaYLoRjZmPyuRqjiCTec87i0WmG7ZNmPahKWfo/4
         3PPvFZ0Y6AJfOi3ic7iN8v58kpaMEMKIL6NPPvrzd+RKZdmHnxM5+hRmtLsKj1kifuL+
         In6A==
X-Forwarded-Encrypted: i=1; AJvYcCWm9bf4qAh+UACZetyCiZbQpbwclChUB2X2PABjng74sQuC8dgYq8GM+RrqSWXfuPXyqMNBx76oFmnu6OwPwPVEKTsuSB7qdC+kDg==@lists.openembedded.org, AJvYcCXByL5FCqk98zQoR/2DLxABMrcfJ92ixeHvTMTvwCdDOhGBBD/tRoZ208uMBBgO1ANQSJAUpJsuWbsFxXqZ@lists.openembedded.org
X-Gm-Message-State: AOJu0YwGFf0peV2YMrzj1Nr4KXetaDPFAKthFyjncTo3MQVrpIAjvtjU
	Rg+QJXOVh+LyfOLOT94In/rrLN5PCpHdom0haGyec67ZuShPXOuFaW5wXa7bwnEtzzaFfAg/Brc
	X0iZllKLF2qzV8y+nn1MoDWvatsI=
X-Google-Smtp-Source: AGHT+IHUY2/aERLk4yJ6l0NzeExV4ktsJgMLHRn0ZQL0dMqHoxFCMVoGPpviE5DJYTAhqyv+kjgcqd+l393Ed1QGee8=
X-Received: by 2002:a05:6512:1386:b0:52e:fd84:cec0 with SMTP id
 2adb3069b0e04-5365881028bmr10537787e87.52.1726050315085; Wed, 11 Sep 2024
 03:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
 <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com> <CANNYZj8THxZ6y8sv3Y7A9br3zfh4GMpec4g4Y-+gMzGMJf5CAA@mail.gmail.com>
 <fa52a7f7-d025-418a-b022-9d3e813ad2de@ti.com> <17F3EC948BF602BE.32151@lists.openembedded.org>
In-Reply-To: <17F3EC948BF602BE.32151@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Sep 2024 12:25:03 +0200
Message-ID: <CANNYZj-mpDJmJSsM9-JSFzJCYMqyUqvLz9dK8vdnaDTjLEf93A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: alex.kanavin@gmail.com
Cc: Ryan Eatmon <reatmon@ti.com>, bitbake-devel@lists.openembedded.org, 
	yocto@lists.yoctoproject.org, 
	openembedded-architecture@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Sep 2024 10:25:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16554

On Tue, 10 Sept 2024 at 17:46, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> Please keep in mind that the format for the set of layers in the
> 'sources' section follows precisely the json format used by layer
> setup tooling, which was discussed to death, and agreed with great
> difficulty quite some time ago, and then implemented in
> 'bitbake-layers create-layer-setup' that writes it out and
> oe-setup-layers that consumes it and pulls the layers from the
> network.
>
> Then there's an additional ['configuration']['bitbake-setup'] section,
> which is new, and specifies what to do after checking out the layers.

I forgot to add, there will be tooling to generate these json files,
possibly a simple extension to the existing tool that generates layer
config. Everything in the json can be obtained programmatically from
an active yocto build (except bitbake build targets maybe, but even
that could be added to config templates), so beginners don't have to
wrestle with json syntax or particularities of specific entries in it.

Alex

