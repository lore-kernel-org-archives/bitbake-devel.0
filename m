Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CFD2FECA
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 17:45:51 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17731.1769535944601894058
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 09:45:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TkZO6EWr;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c0f13e4424so656072485a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 09:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769535943; cv=none;
        d=google.com; s=arc-20240605;
        b=OKaXuDYqDwEYv3s3fFnQWTp6lTNrSNRFbCLgyRTFRWjlOSjNXY50kzDPr2DAEAHNct
         3fSn49mixmWao4orq8rkMGe2Jn6+1F+02gZVx0LBk/UxAA19zEPUoVYWTirB79FZhPWU
         oFnnIvjaNrUXiRC1bFNbGzEny10eFetHs/sx85YnBrAl+xdmt9WB2iCvLGNwlfpeIcVx
         t8VL6l9jEpKWD9Y6hm0i835StnXF8SzmZK1tH3Ve7qH5BF+CwzzMuFvLwUui6gghWrkf
         dGJQAs6oJl0pro1T2uSYbjL5vC0wmVmMYkKAep+yuLLPDxbUkWatK43ZYKixARsjGxZd
         +Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=91EVQTgcyqcWbfl+778KP0bQEXvVzkOUpPK1OsTRR18=;
        fh=HTnq3TW9VO1HUJe4b4aXNW7h6vMaeEp2RxK0zK89K2k=;
        b=dmjJ6QjVSqIn/Rfbp/0+46ajohaO72LwEYqEKFPhn5Xdjn92ZUtB454SvqYm4qIx7c
         O1SyCOob72zj44fZiYT8ub8xDH7W4ORMF7xVlyaWNUijPpeiqH8QtWIBNuYLRVNRTwKQ
         Hq5G1kwG0/UmREgg+U1TOP3qQ51BHFzZTByrScL5CuMYIU/bfRNK20zUCIWVuFiCS3Vk
         B4mE4dkoKHGkfhmUZe1NfQvBtizenEVPSKTxNruagTfqbxhoGbTAa43cgdlGrG7G7ZKZ
         J1gIsp9KQcj4rSeue/16V5kmouOAakIc2aNMpmXYKWey/lEjqZSnnGJoNobYEsvHUMTY
         FvUA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769535943; x=1770140743; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=91EVQTgcyqcWbfl+778KP0bQEXvVzkOUpPK1OsTRR18=;
        b=TkZO6EWrzSThcdKbxvaey6fuMq5bBlLG6b/WaxoyIYeHt0Xtmw6mhOHlHHKHU3v+L8
         s2lBPHDqvx6iwqYJ/BhuRzEj3DHULszpie+Fd/Asz+NSfyM3Ve/i87tvd+QrMhhk5D2S
         uUON1zrj5TIyZ/geAP35T+pFRjn1kGGQTiwHjYlEVWkkwNhqlKBIK182VvJTmiSBaM1R
         rYaMkg7+EgZPQnZ7hXeMNqMov9o0E1MIZ0LxBUN/m7TilZdPd/1c2sFmx6JGZGzPKJIU
         4A2TKs/1HeCNHJ+52vQbSF23QjiXGgIr0tf0RaNtUYNX3lB5ipPnLQOUwQilkaAko6dF
         MzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769535943; x=1770140743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91EVQTgcyqcWbfl+778KP0bQEXvVzkOUpPK1OsTRR18=;
        b=lZKLCt1kE0i87wEzVZ4SaLgk4PuJoa4ZpJqjftx6Evhr3nVbr5uxWOX4J+fCKTGD2i
         PSKaxsZgHxzClXumXwKou9yJRBoGW9JHqw42RCQcaKmBxcgFtwFlKZZB3q0KDWllWN73
         lPvvBHbIA9NAVQ9+YEhDvcSfCZ3sYV0d3LX9YKHuOH4JBZ82VlEJ2+szuYbSj77a+vun
         w6wc/+HZt0jTYANcCf/tqcMfYxbXdgM+hZp0nIWKHDlQvQAuF8G0k1p5ejS3Gr4EzRyZ
         9/znLM7qU8VKEbi7mxxl7Pws1LiA5r1UOu4aI2tPVDc1Csb/J3fcaddU01E9/bt748WU
         fpCg==
X-Forwarded-Encrypted: i=1; AJvYcCXcJx+zmtsEwTlcSspm5mclo+vkVypbjOJG5LrR6LmkLZ2Q93bpUTI4cA4akcp52kXW8IgjDrGEMM9IyWTn@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy+CU45aQRhLwH9BbzN5jPkxm1MryLyJ+ZMwEBn0YJVA/dI4x1r
	TTmz9XtXwLfMHIaO2bxzu6QYairsSS1c+yRZiOvmyZm8c3CIkUjaQwfmvp9JR64W5uJza4uy6uQ
	HdPBRFPbkm1IPwxiUaQx+dZdiOb4UFCg=
X-Gm-Gg: AZuq6aL+HkV8831wVsyuEOHC1AtKLX/JWXlqI8INnrLnFAGklnvJfcFT4zG5zzmzibF
	RxG7Ez5BAmPJw/wEbrDdI87VOFNCCPMxncakHfmGUD/d3GGDXsv/Ti793Y0j2lN02sn6mXktDhV
	G9w2NXOvIBWTc8ThofcApo5+XzSKd8jspVeHTHqXVxeXrkUIW3tGnE4/3o8Q2d7sRZMQb/j3Uq6
	PD+wBMW/v4LNGAb7N209lW3pN6rjHgT+ixG8rNJRD9h0ITCPaa+Y3o0H9lY0ZtxbQchIV+OlD5R
	T8bBiY8X4PICxtO1aI+Jb1FT0HEKCg==
X-Received: by 2002:a05:620a:2844:b0:8c5:2e1b:7913 with SMTP id
 af79cd13be357-8c70b841f60mr338213885a.25.1769535943572; Tue, 27 Jan 2026
 09:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-2-daiane.angolini@foundries.io> <DFZAUTK11Y5A.1PPDDZRLH02PU@bootlin.com>
 <CANNYZj_DhwvpzBcG0Vi7E9aYqx7b30uDUxJFkmdE686f1+Zkog@mail.gmail.com> <CA+HEL79Bs-OaWjNa2OSrVULiBqpeXU_0m1u=vUwgh3cXWXY5uA@mail.gmail.com>
In-Reply-To: <CA+HEL79Bs-OaWjNa2OSrVULiBqpeXU_0m1u=vUwgh3cXWXY5uA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 18:45:31 +0100
X-Gm-Features: AZwV_QjjcqIJO3IGRTKZsKCYCx9rJ40fvewO1JWAPIQn5lMF8sDggv8IQDbEirU
Message-ID: <CANNYZj_o9A8hpmnwrJ3Ng+ZvPLHy+AbGnRcS3QJm2nUDT=SW0Q@mail.gmail.com>
Subject: Re: [docs][PATCH 2/5] bitbake-setup: Change the output to match the
 terminology in the docs
To: Daiane Angolini <daiane.angolini@foundries.io>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 17:45:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18901

On Tue, 27 Jan 2026 at 14:21, Daiane Angolini
<daiane.angolini@foundries.io> wrote:
> If everything is configuration, all stuff is the same for the
> newcomer. Bitbake configuration is the most generic way to refer to
> anything. If I have a site.conf with DL_DIR set there, it's a bitbake
> configuration, if I have a KERNEL_DEVICE inside a machine.conf it's a
> bitbake configuration.
>
> How do you like Fragment Set?

It's not just the fragment set. It's also what layers are enabled in
bblayers.conf, and what is in site.conf. All these things together are
collected in build/conf/, they define what bitbake starts with (the
metadata in layers is pulled in based on what layers are included in
bblayers.conf) , and they are commonly understood as adding parameters
to bitbake configuration for a particular build directory, on top of
layer metadata - if you change those things, then it affects only that
build directory.

So maybe 'bitbake configuration' isn't unambigious, but tweaking
build/conf to adjust the bitbake configuration without changing layers
is a well understood concept. Can you suggest a better name for that?

Alex

