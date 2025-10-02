Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29BDCAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 16:22:58 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web11.13454.1759422170805377951
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 09:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KYc9yxFo;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso8432241cf.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422170; x=1760026970; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etcw1EslBf42/ZAjxWWrhu56iIgh/Zo3HQoxjnoOFAY=;
        b=KYc9yxFoMYnc4pd7a/4xT4DE0QRL0DvaRO9kk8k5YcM9wru4xjb2yG8oYoT2ArEfyW
         nhgOoGxfgrYGw+NN5tB6NF76v2UhR4AP08n3L2KgxCpr3aAVTIfJPlsahkrsVytns+w8
         BLyoO6b//PD9hxeCaM2Oiu7X2mFKmwgdpA1XHAqoFUx17rGbqqMJjI4feAiDcz7oNjMp
         GtmSBSubcHP4KiqDX1pWo+hJyFk7x8L5IhKxuMj2W4utLUrh59dspJ89DBMBbZA7dyrj
         9wRQxiWUvGtNe0jeDIGVKeTKJDJnQqPfvyv3lMFFMFQSemCagGYvy3ZlOCAYAEBYc2Kf
         48pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422170; x=1760026970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etcw1EslBf42/ZAjxWWrhu56iIgh/Zo3HQoxjnoOFAY=;
        b=SfnRH4c5sBma/UXYRq8tN7seIHlt2p61xGj54CKNRied5LB+fHopNN7v4y0IeEqQLB
         Vj2C9Yxju7BhBB1MaZF6jw6tvsjElHWiFDWv3Xz3+eUNLTRLEi0KF4mPJ7aMGWgpDH2X
         UPi6t6bsKR5/A+yzWyHARhZhCljjKh+bL9SyV/k4/9Nq8pef4Fw4Qw20lBGtlWNCx8ZA
         /JbTFdhRvKPViec2TrLTvEzGO/MYGXABrTNaFTDbkHW9jAxmjxg5QWjlc/pEouFA+9HX
         GY1Xh0Vvz2fQB9ml0/RR7BBXRi8fssfFtE/quxZ3uHI/iFZeFa6ylh/opI0Ha9200ERu
         BO8g==
X-Gm-Message-State: AOJu0YyRSGYRRVFZCkaXZUt5rjEweP9FoXOEaIw3jFZEpIbLHyfi2UUL
	CvP0hwOlZ66jA8gwbPl3kTRM7miRWQSVXkfLZbnpu4x9D1yAni9SNuwu5YKK9DruFWy1XPe9g1L
	gdgfscSMYs/CX3JUYbiOQwEmgue9LgUc=
X-Gm-Gg: ASbGnctPV/1BzzIHblH1nkO3M2JamoO8KjjTY7mf5XgwgeOEiQBLaTd3BG6Csy2C2fk
	e+WO0roFaMIaz3+PUSVtcADzSyUYMHSkaZDWwdkkUTjxhier1Jj2uA7O+9S1bgYpwklROIOX2UG
	Wb52N/JVf7N6Vawg/3IFGCdQkS06MH+kTIjUQHckV/Xq7sRnEo+Ln/ioTvZFYZNnDos4WzxRov7
	XttirzLHtXH26xuWfYwAzKke93KB/GyGQYhwy8ETbrYFLitekAyX95skxeJZJ1ozgQjiIsO9nYy
	PNeJJNPt4AZ1K1qv2li22amE5nk6b3jEkVlGd3rzGfKJq2J8R+puDD5JGp/p3au3
X-Google-Smtp-Source: AGHT+IEj7mx39Wpm19hoLKBnoJP9s9wXKqFCaga82tv7OFmo09ErcZH7hoVTw/UbL+bG0PfFjvAzVJYTAiSXikma+AE=
X-Received: by 2002:ac8:6f13:0:b0:4d8:2245:e246 with SMTP id
 d75a77b69052e-4e41e444e5dmr122706131cf.57.1759422169794; Thu, 02 Oct 2025
 09:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr>
In-Reply-To: <20251002155210.782342-1-yoann.congal@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 2 Oct 2025 18:22:38 +0200
X-Gm-Features: AS18NWBqW5ibeniV24gB2c5nFYbRu6vKVifxmoDQT7WAbzNbA-9HcnSNVmJ4iJY
Message-ID: <CANNYZj8RicOLzYbtQ6anggqiMkQMDJ=REBztppNa3CP6dLOkcw@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 16:22:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18125

On Thu, 2 Oct 2025 at 17:52, Yoann Congal via lists.openembedded.org
<yoann.congal=smile.fr@lists.openembedded.org> wrote:

> +                        ],
> +                    },
> +                },
> +            },
> +        ],
> +    },

I don't know Yoann, these still need to be perfectly balanced and
they're still visual clutter (admittedly not as bad as xml was), which
is what yaml frees one from.

What's the particular need for comments? You said someone else wanted
them, what did they say?

Alex

