Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841AD11708
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:13:25 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.946.1764691997453212689
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:13:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FA8d7qLH;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8823cde292eso53158436d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764691996; x=1765296796; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XNdzGZ8I/toQD7LsphLHRn6OBfaD/3IQejPOytk9sfQ=;
        b=FA8d7qLHrMcbO+ACOso8WaRdUZtYNlKznnTGGIXNlBw/f1Axg8Nef3bIXtrjptR+4R
         aPx+rj7Oxlpp2xMQapdCHJGUaV2wncu5CZxXsmB7UXLtc4NxcBq4y9niFMOzzIv32Xt2
         PlxtF5OYh1oAaVHv5PjSewQk88F3pR30wB2Z2QLyKSS2hi52DBnBDZRUFM3Lm9PTejcS
         noZYZPdBTm7p1VA8qHp+zYIlLuThgY4EMua9j/O6fHgtoG+JLd/ILEQdTAtuGMu4Am6/
         Ly7aANRJcRySNpWSDg2Cz3wgSL9cDb+5eoPSSXQR5qtPHvI1ZRXwgWswoD1w9QAeedrZ
         WLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691996; x=1765296796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNdzGZ8I/toQD7LsphLHRn6OBfaD/3IQejPOytk9sfQ=;
        b=UlnkcBSEOxHr0+uTvsk+KlfnrsUM5Mb8+yLYPr0NSf+SvMtp3TofeoiDovrYw4lmr2
         XmEmXWJew7NnWOJWxwkSlsspBVAPzYn+qjo8zR6QknhXJU4ZemxhZdSsPkDWfsHHNxuR
         mAdoe+z22yN1pp+tJWxQcl9Oli4rWBbGR65C2XNg4ImlGJBta9ndkq9Xd1Di15UTVxxL
         2VAAoM5gJVpl+aHWAxCyU9HFSZYioCnVDGFlqNxTyI9dLkBxyrsVMzIkxADtzAa4Nnj/
         jxxCt5l2/kca1PwSOSHdU/p7PBnYIUhQZf2/TmkHHUwdRMBxoLOqW6YHfgB1bCBZ3azR
         YNfg==
X-Gm-Message-State: AOJu0Yxrx9yY0BbJKZ+SuynguciI3XbR0SmhbTsI8PVuk02e4tJpL/GT
	k2+1/QA87A/za4Xh4z1Jd3OSSdN0uUTvVkD6fv4vd1sSCM6Ps7oT7IYAN7zNEewHAu+uAe41BJ+
	Gi5kQB+ovSBb9tPM2w5XS6BcT7j814Sg=
X-Gm-Gg: ASbGncvZYIku2aJgCkh+qQTahIwWompy59BVyfZbJ5uIL04Vy5A+GrYqpMObdHLDj05
	FicyCu0o+srOzXBiJ9SMQX0AOQJ6rO2BvaCdV5Ieemt5uDazRvhm5VQKa4ep1iBnIdjSfEGECI5
	9Wf9XLBQR1WGpC+aGTbopsccpO3v8VvfONkKlj+66/nuo155QViYrMSHEnfKm45tkDgaxFWn0uU
	92PMOVlZf8Q2nqexgvKcvge77N6PhNr7YxZjliAXma2K9B9Vc0i4Eeky3r/JHzjTVrWETtfzb49
	AAnNXhheF78IcBw5oY9FfGUzbbCbZr1dtNXcPXYZ
X-Google-Smtp-Source: AGHT+IFWyMLHV3jsHMtzxZ4PjzGW5KAquAY6GrZaR6pT4WJCSC4XnepXxyI9sX30ITkK/5klsKqWlqLy3EsSvJTm/Q8=
X-Received: by 2002:ad4:5f48:0:b0:882:4a63:63a7 with SMTP id
 6a1803df08f44-8847c545834mr722326006d6.60.1764691996348; Tue, 02 Dec 2025
 08:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr> <20251202160402.819060-2-corentin.guillevic@smile.fr>
In-Reply-To: <20251202160402.819060-2-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Dec 2025 17:13:05 +0100
X-Gm-Features: AWmQ_bm4gUfA1kALo-nxdlS06P_Ns_GrNrhHtBgpSDzxr0T7vUX5L7HNM7nc2js
Message-ID: <CANNYZj-dNDhzchZU02w6-Q-CLkU2MiFaZ-z-=n7JxsmGdDsgxQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] layers.schema.json: support 'uri',
 make this and 'remotes' mutually exclusive
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:13:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18510

On Tue, 2 Dec 2025 at 17:04, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:
 -                                }
> +                                },
> +                                "oneOf": [
> +                                    {
> +                                        "required": [
> +                                            "uri"
> +                                        ]
> +                                    },
> +                                    {
> +                                        "required": [
> +                                            "remotes"
> +                                        ]
> +                                    }
> +                                ]

I don't think it needs to be mutually exclusive. If both uri and
remotes are present that's not an invalid combination.

Alex.

