Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351ED12D4B
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 12:02:46 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13418.1764763361390866778
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 04:02:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UU+WSGw7;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882399d60baso53139426d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764763360; x=1765368160; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRXFc3xp2P+jkk0NQS+7jnsz2BCLRZC+8PXGm8IU+tQ=;
        b=UU+WSGw7KsZRPLFlXE2FgUT1khmt34mW1YYw0l4IKGc7blxtW4bKk5Xc1QBL6os361
         kgT0gtaHkuYtWjdtRhLRCqK+e+B1/KbRei9iVKAuSZeaNXvn0iILe9b0uKT7B2Rf7Pzc
         BcUXRP9eW/uGop6pvkpNJ83B6zGzN/1MrfHeQlnrZwS01cyw0BJ5YMtEtSKhDDFRljBP
         BOSsMJSaGXS2JsutpOoNzRJARNsBTIuvwFIOWc2XImVGWjojottBT3VVThD62uIt/iuu
         5S8/p1FLMZVbEscmwJbi5P63oop89tygIW7eO5L6E/rJyen8PMsBE1nFTZ5GvJxWgfoO
         rdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764763360; x=1765368160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRXFc3xp2P+jkk0NQS+7jnsz2BCLRZC+8PXGm8IU+tQ=;
        b=SqPUFIu1wK+65CS309p7cTFm/zQyvhhMUsp+W5uTNQ7S1cahAm8mfFXMB2hZLHNWaz
         ftnQ/OE0NQIoM43gERFI/lliMQG1TONeDJF5B8D0IWWFhB3pDH8u2TYg9AHcQPz0rM50
         5dcIEh7Boj5JVrSVcKyMESSDJUmXY3FPm8YyUZ6Naop3Lnq55pMR2qgFDpuowUA8cClh
         OL4WM5gkl0yfBz4AZLYoP/3dpqkdXOdntlIvTZQgzEXICEd6SiOigORd0KEsDplhypWR
         brKMrflHmptRoA5Eb7Bef6uE+XZWjPGRDXZ3IGxqBjmtyZuuX6a5bcLM1yxWYAbt7afK
         GPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhwvgXmtDNXUAF9cbldZzkiDlQAeCLZqKGt1RAzH35e1Ab2B6bDMW6/Rd1+OuOOksVAR9lMZmaGq6pacHE@lists.openembedded.org
X-Gm-Message-State: AOJu0YxZEa6DhJaGGbCN/geDEHYbbCLDkGvOMNs6B37ri3CjqhWS5K7G
	04dIl9D2fg64iUtZdQuxMv6ICoa0j00vf+xaf/prHgzMxtdenu62JFdSZn1NZNeQoRUShrf6lNB
	mEydvOqVFDFGE17INfH9psea8fr9tI/k=
X-Gm-Gg: ASbGncuY59brWbr0cj7pdWzoed3bYcv/EfrakxvWO7667wMLtsBe0vhd+H3DJK5hT5C
	HKU9fgLDSOEqdLYdcHMM2FH0JyaHBwfc2KydclOBnWWyoxBzQVYtiqPw5LETid+jSLgLwjgFbTH
	JXy3GvXz6AfrhKfiY9R1IaaEvJk0ya8vDdxY8xMEO97e8nJWh3P57ouexs7H7gAFEGfKkwm5XGd
	EOuBUpl1sjUs+bw5FdYJ2cPAlUzbBkXLdldly9fcGL04SfFhuGCsSVXPDIyxa8S9SqwcDzdASJI
	kJIfA9S/AVi/NuUTmJfRMVKOI1A4hA==
X-Google-Smtp-Source: AGHT+IEgSmBTPG33OJohpbQTw+RxBm8sTRDEhB6Cnvn+ge+3Vu1rcbN9n+bN7skZ7WElBvyiepdq9+BmppcNROfdw5M=
X-Received: by 2002:ad4:5de7:0:b0:880:5001:17d3 with SMTP id
 6a1803df08f44-88819555bf6mr30162856d6.40.1764763360304; Wed, 03 Dec 2025
 04:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
 <20251202160402.819060-2-corentin.guillevic@smile.fr> <CANNYZj-dNDhzchZU02w6-Q-CLkU2MiFaZ-z-=n7JxsmGdDsgxQ@mail.gmail.com>
 <CAMSfU+6JeaWFAah4AH_N7Ewpzw8g-WCq=we4-kTVfaNF63MdaQ@mail.gmail.com>
 <CANNYZj91Q5GxUVmMoOrZg17tdY=TCsAmF8SEM+Mtriu1VQNTOQ@mail.gmail.com> <CAMSfU+4RTXYaTqLuOFrYDWY_RZYfxM+FNDSjD92WA6-E58z7yQ@mail.gmail.com>
In-Reply-To: <CAMSfU+4RTXYaTqLuOFrYDWY_RZYfxM+FNDSjD92WA6-E58z7yQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 3 Dec 2025 13:02:28 +0100
X-Gm-Features: AWmQ_blAyZeylNHA8Ej7SGrhGNrbDgfPPIIXtBbiC5RXJBIROrrQzJe0kTRzZMk
Message-ID: <CANNYZj9Ekbo81rAWmyPbhka2xhp-pBZT6EkH8AnGpJPtvyj05g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] layers.schema.json: support 'uri',
 make this and 'remotes' mutually exclusive
To: Yoann Congal <yoann.congal@smile.fr>
Cc: corentin.guillevic@smile.fr, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 12:02:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18522

On Wed, 3 Dec 2025 at 12:47, Yoann Congal <yoann.congal@smile.fr> wrote:
> At first that was to avoid this kind of setup:
> "uri": "http://example.org/git/",
> "remotes" : {
>   "origin": {
>     "uri": "http://anotherexample.org/git/"
>   }
> }
> In this config, what the "origin" remote should be? To avoid this
> confusion I proposed to make the two modes mutually exclusive.
>
> But, thinking about it, when using the short version, a user most
> likely won't care about the remote name so we can choose anything that
> isn't a "remotes":{} key : a random string, an incrementing
> "origin_%d", ...
>
> What do you think?

The name of the remote (e.g. 'origin') isn't actually important or
used for anything, other than iterating over them in a loop. The
fetcher does not need it. So I guess you can assign something unique
to the 'simple' entry, or just make a unified list, and discard the
names in it, just keep the uris.

Alex

