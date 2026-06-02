Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E7CD6E4A
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 08:04:09 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20025.1780387442700138566
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jun 2026 01:04:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NuHGmxm8;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso52329326d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2026 01:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780387442; cv=none;
        d=google.com; s=arc-20240605;
        b=PyBmsFhhHDWq9/PyZ8nbUuP4V1dfMexhrKexHWmhQBq1tuOKBYiREjGP50Tl5HDsv4
         s5W8O2QrnbMBCbTVNmO1oF51CzfLnYPzgVgYbNNUv4pBX2pS2qRlAqBxmobN31AV4Dve
         9HOkfg2YDmzT8ZJKEW6PnUllll4N0JxCMQdiE97B87V1y2zMsPj7e6xuGTXvcC3mWGCW
         KwwvbhYS/3Q+90NYi965y4BEgGy94YDW3zK9+BKKB8aLcp8Wt70QegnMcoG5PJssrl+j
         sOjZVVbi0QqHirIU7WqWcVZeB33/4QJdvyWMtTwyshnDFManUbSXH7xnUr9qiqJo98oB
         QG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FnN+9HlopnVx9KQsiQwnXqMZIvJ1vA+8qQImHraWUz0=;
        fh=S70EIw5I6KnwG2JXmyE4WkvLU4aK+s9Srxw9jTjAdcY=;
        b=dQse43YMYTszISZ5530EsZunvcq/Jpsg16pFQwRo83xDBmxexkrlALrmOMwBbPdP8u
         GxNFsaFFjH153IXsvmEdTP/qujcK4e5+ntQRt2SUfwi72DO5AUljQPeoEwl3tlykx3Mo
         H0ofndcsWAr46HypGyvgzwQTK8b3mq2tesEMLNlUmEbsVsM3Yf6kC7UF267e7WXCm65d
         79OD3MkyQtHjUfHr7FyM0ftgfyqdBun3a0mmcbyudClQVX5SKH+7RYR4DCi0KcsBApx7
         aYq4g+q5W8RTEJymbyL20UdpuQEuT+LvKnRefGLjr6tETEVxZrUtYvQU0NM9YIbgwLvK
         kmlA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780387442; x=1780992242; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FnN+9HlopnVx9KQsiQwnXqMZIvJ1vA+8qQImHraWUz0=;
        b=NuHGmxm8fWKFca3/vunZLVWRGV3ChHdiBvlAzTWrmXWViPzu3c61akl1U6f8Jm5h93
         Birh/HEyaz0gWVkHrl4V+CiVGSD3JvtcKrK8V8R/0WbORDJR9EIWG8NKp1/mZVoKZLxL
         aC/cS+6a4E/ji1zmSwLkZGvsj262HpvMAJWyXuLsNDwjV6MceI7wgc2PVWPd8vHyhQZV
         q4RQUm1c/LJsnjzlJhd7Hug2o/q4KC3fnVPtH0ZhqZjp5rP+BhynJaRtf0+gi345wNnN
         mzSoN62kW14E/F6NuqpuWGWmyAaLEaiO1dTxGD7jOTuZPSo6eBR68gXCPR/fXU26SeXL
         4X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387442; x=1780992242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnN+9HlopnVx9KQsiQwnXqMZIvJ1vA+8qQImHraWUz0=;
        b=PQU4IeKk+Z7ECRu742Bb6BoVqzw8hRXH+kgmSOuyHVlbL5vJmGyAcExSu58gE24LUX
         HKaekqAOZRzO/GFm3L0u8LfUIy2OQmVlPFcxeXAjuhKsfhxudBpDuhR3Z3B77xG8XC0w
         BMORICKpmxZWBVKMIspbezvzkgNvhW5LwG7qiifPONql57wTyZUCpem7DMaxQkN6xf/e
         fOg+VHqJo+9QTCf1XljAftc+t8DArGVONfQGHWyvtjbPgS80LW9d/dYtYEdPsdd6fW3O
         +86tAym1O6CItYOuPgXm+dzFBm3IW6kSqulRb1asArkBqY+KA4NMul+R2rfi2anaj39z
         ucWQ==
X-Gm-Message-State: AOJu0YzVR6UAdBgO8Or3QsXBTM01w24sd4gC5/QvpJ4e2JpiPYrgkF/Z
	fve6VO84ocxdVq8jsBBY05tcfDTv8flpZevEHzvvpp1tyD6nJH7tJNRnP0UUArA2ubO1ubd2AD4
	9pg6tn1Ai1Ou62nYvNV8PiSn+IJEyKR4=
X-Gm-Gg: Acq92OG97Fy+aHWVOkwLqS6qibaXFl7m7yYR/qjsl6Pp95/GLYgtv3yOlLuOqjz2P01
	OADolO78zQ2bvrbA3LnNubT/NZQ9awi6t1e9aMZxian00tyGSf5EDDZixmGihEeEIGWXa8eyfBf
	XYRBQeSvA4c+3EPmzZtH296JaQJQ+8O+/IWPDwIE0juFFSlFn9U0oubBSrJqIPW7iZkzFZWpKYq
	nT3rmc3xFOjp2v6Lk5cjPO9e8QUHmbemBqgfLQRtYfP2vIOpAqZcEBbPkcRH3tUYDXHr5dJCjIz
	gYTJ6nDDUIaEj4rkC7TE0nAsS+DbWrPbdd7RU79uP3ku+NF9I+g5
X-Received: by 2002:a05:6214:4499:b0:8cc:dd12:a545 with SMTP id
 6a1803df08f44-8ccefb28fe7mr237400996d6.8.1780387441669; Tue, 02 Jun 2026
 01:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
 <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com>
 <o2tur4mf7vfsmx2qkizqhhxjnz34vifjtxeschtjvueskuzrcy@5hmfaoevpek6>
 <CANNYZj-ajQ_2LJnTHMvC82JjtNxLRMPKEJO1ez_Paj6vb9NBdA@mail.gmail.com> <epsie6ihulfecgum6rju6azeyhzv34544bvw3tmyqeznycq3pk@fmmew2m6ahcw>
In-Reply-To: <epsie6ihulfecgum6rju6azeyhzv34544bvw3tmyqeznycq3pk@fmmew2m6ahcw>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Jun 2026 10:03:50 +0200
X-Gm-Features: AVHnY4KQS62pSg4NczjLNveM2lJlkMsNeDDxCpCqs3PAnc_qKOSG1uYaXs6Xsko
Message-ID: <CANNYZj9rKRS0CD-LGq=phvB_T1XS+SmR5Uti0p8tu49PtTm-QA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: support multiple
 source override files
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2026 08:04:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19590

On Mon, 1 Jun 2026 at 21:21, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
> Agreed, I'm playing with this idea now. How would you feel about a
> top-level definition of:
>
>     "source-override-sets": {
>         "release": { "sources": { ... } },
>         "dev": { "sources": { ... } }
>     }
>
> That can then be selected by a config with
>
>     "source-override-set": "release"
>
> I don't really see the use case of having this be user selectable such
> as the "oe-template-one-of" property. Seems to me that it'd just create
> another axis of choice for the setup but at least for me, the sources
> would always be tied to a certain config. For example, my dev config
> also applies some other templates that differentiate it from the release
> config, so release+"dev sources" is not enough, and I'm not interested
> in creating a dev setup with release sources or vice versa.
>
> I'm struggling a bit with the semantics of this new approach tho. It
> makes me think that we really just want multiple sources nodes, not
> overrides.

I wouldn't call them 'override sets' as they're actually the starting
point, I'd go with something like 'source-choices'.

The use case for making them user selectable can be seen right here:
https://git.openembedded.org/bitbake/tree/default-registry/configurations

There's a lot of copy-paste in these configs, because each can hold
only one set of sources, and folding different yocto releases (plus
master) into a single config file would be great, so that actual build
configurations need to be written only once. I can imagine downstream
users could use it in a similar way: share configs between different
releases.

Adding restrictions on what config can be used with what set of
sources can be done as a followup, and doesn't need to be decided and
agreed up front. Until then you'd have to maintain that restriction
externally, by ensuring bitbake-setup is called with matching items:

$ bitbake-setup init my-mega-config-file dev-sources dev-config

I'm considering whether the source sets should hold optional allow
lists and deny lists of what configs they can be used with:

    "source-choices": {
         "release": { "sources": { ... }, "configs-allow":
["release"], "description": "...", "expires": "yyyymmdd" },
         "dev": { "sources": { ... }, "configs-allow": ["dev"],
"description": "..." }
     }

This feels more elegant and flexible. But again, it doesn't have to be
implemented up front. The best way to add new features is incremental
and iterative.

Alex

