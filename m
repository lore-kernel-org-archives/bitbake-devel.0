Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F1BCAC598
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 09:47:06 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.28635.1757929621800033941
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 02:47:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kH3lIhY5;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-76ce24d1dcaso22216286d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757929621; x=1758534421; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OY95O9FC53MffYlb3HbXcDrC1j5ALe3s1XdhaTelsIY=;
        b=kH3lIhY5/dWqVm+qKujTPoZFRYq7ND6q5T3g54x62Qzvho5ysTn1lPEY94+BWYeEiA
         M2dZNeJsxbcagmj2y+xJicrG6oHGUrQppl2dhQ6s9l1Fsu3aJiv4C1is7XUwcwO7V5tT
         ZdcEfywBbz58kUB6Ckie/EQ9ifLDOM4ccRpcD9XLQET4gJYjmnhkzGgmnc0ells6AIcY
         N5arqBKnZcKidQXWTkqC+uuJAxb5zuI6M6a1X2nOUz0UkXp8ug1GiHxN2dWhrinQ+t7n
         miwwv2gQbN+2g7BBaYZt0OzcYYRACkGAO7zfxQDXwiW/FrFz/JxKazJeALc2dkUcMYUa
         PhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929621; x=1758534421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY95O9FC53MffYlb3HbXcDrC1j5ALe3s1XdhaTelsIY=;
        b=a84vdCbHEJT3Brbr3RLmia4gm+wsEtw86EJtfgZU8H0kmjB6nzofcuQ9AaLNCR6FNu
         5lDsKpBJUycYXGE/SrRiblEWjAB2sX5sIExKEtl7At/SUfXjHaLbZJh1XEB6u88+3+oK
         nmCYsvzTuPwBtsSQYi26xsDKztti+SGly06zZv8sLrMSiw7R037eSjalOjpth2aAHD6h
         WhxQgGr8V1VR0b7JDARXoZd4SutX+dvtjOEz+BqUPL9BJ0nRXK+fqa5eOJL/R1dxWX0t
         QCq5mukF7FjL756vV1qSeYcFg+KXPtAkA2auNeksbVomvMTMGqspaFRn6xg1BnqUXm45
         +WSA==
X-Gm-Message-State: AOJu0YwQQ9AVq+4XwVYoQcJzbUIdSeDRKAhlcZ5o+9lXSqPv3naSYdI9
	juIqczO+pVl1Bjy1GES3t+zumYlVSfPsS+g+ti3lJcI0tRgVG+yOOOsVNPI+uFCAWP24M/N8M/c
	38bH8AnBezuERyoE6JCKqmFqOo3vF7WuRRRXh
X-Gm-Gg: ASbGnctvuQfDTZvjNwTQZqLNmyI9lAE+sYyb9H0ryZ9HVp1RMxLxWUvveQ4k8qUAGKv
	vuP5u09oiotPQ2YzFxM/8RsrZvLPuA0y8VdU3BL871HZR/V6vGjDqYehQcmGbROFxyEJWGr17tn
	6QsGett3V+gxdrOEpVBK0+3vxiJ1WZQJoGNTFRxEthjCEuTDaUPL5m7GjXbA8bNhmqQYnlEfnxe
	6OBCwtuzDfCoHP3btgguEpxQu9mGO3pbVJGAcIRfYQbeBtarKKwFfMC0YCgIb02PxJTuXjbx+eg
	uKMu
X-Google-Smtp-Source: AGHT+IG60DQveZHYgy72/r5Tc9DjVKTqsrgdSaLRK3AA6wRqWIwYbgQTDzP6EalLI2gH30SRqjWPt+X/bBAZNnZVN18=
X-Received: by 2002:a05:6214:5296:b0:77a:57d0:b26c with SMTP id
 6a1803df08f44-77a580dc008mr60924026d6.66.1757929620767; Mon, 15 Sep 2025
 02:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250912204559.10360-1-reatmon@ti.com>
In-Reply-To: <20250912204559.10360-1-reatmon@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Sep 2025 11:46:49 +0200
X-Gm-Features: AS18NWAkhcKx5XADX0l-osY4YGddKJ5BJbswFfDTlXAQe5xb7R7JrnRuvRMqL0c
Message-ID: <CANNYZj_HYDbnYnNhW=W0Xqd_bDp0dvK541P2=0qPV_gED0wOgQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 1/3] bitbake-setup: Tweak user inputs
To: reatmon@ti.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 09:47:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18019

On Fri, 12 Sept 2025 at 22:46, Ryan Eatmon via lists.openembedded.org
<reatmon=ti.com@lists.openembedded.org> wrote:
> +def get_user_input(prompt):
> +    choice_s = ''
> +    while choice_s.isdigit() == False:
> +        print("\n{}:".format(prompt))
> +        choice_s = input()
> +    choice_n = int(choice_s)
> +    return choice_n

Thanks, I already have an implementation that also checks that the
input is in valid range, and tries to guide the user to input
something sensible (not yet pushed):

def int_input(allowed_values):
    n = None
    while not n:
        try:
            n = int(input())
        except ValueError:
            print('Not a valid number, please try again:')
            continue
        if n not in allowed_values:
            print('Number {} not one of {}, please try
again:'.format(n, allowed_values))
            n = None
    return n

> +
> +        if len(options_enumerated) == 1:
> +            only_config = options_enumerated[0]
> +            print("\nSelecting the only available option {}".format(only_config))
> +            choices[k] = options_enumerated[only_config[0]][1]
> +            continue

This should be fixed in the configuration: move the only option to
'oe-fragments'.

Alex

