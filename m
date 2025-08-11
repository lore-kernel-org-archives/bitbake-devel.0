Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFDBCA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:27:05 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.43645.1754900820266661851
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 01:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bOE//yay;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70736b2ea12so21083756d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754900819; x=1755505619; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w1pGz40crc+l6IZw/cs4NR3zwoRRWINMyZ8H9zruNJk=;
        b=bOE//yaysYem3hcHEKXbdjmplqTEyOhH1L9ZPKPGz++Xfs7KD702J4Z30Hkz733CUA
         yWXhnfKs5jhhLArUCKcdprecs/wlSljrYzJ0caq1VraTxyGUdvaiRYlXv/866QynJnw4
         4fMQ3BCOclzbOqNQMWMJ9/+DBI0Vf1rfOQ3T5sSf9QD2BF1B9ox3WUuv1DykG1e3glX5
         iX99aDKNk2zm8a6lOgjDYIOp804Unlz/6HhXMYCW3CfvQwdZUJZ7efwh4q1sx34PqayL
         cgQOP0vdEE7GjVnoP9rDC9OkFPz4aZWWEH2LJSF8xjbTtCiCu0X2BZ8s2kpQHvdxS9hL
         BVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754900819; x=1755505619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1pGz40crc+l6IZw/cs4NR3zwoRRWINMyZ8H9zruNJk=;
        b=FF6fnyPA3BFx5cznnQN2DiIshzRG2mhVyZN5lghY9d4Vy7kchZ2JA1ncn8o6kn41ol
         /ENEvYLkisfVDVPL/QWO87ArAgK44yqoQlf8cdvQzYFw58pbex74dp9PDGyam6ibLm+H
         WnrOny7pweP0dJT52arAOjlZRt3z5DIQWjxm5achMovu+VVQayUCHPL+GrR+tvK4BmxQ
         62qOmi510TDTj0g98JefG1CfoCSKgT4jWvMqyJOjXv3P4XJ97Gu6SdW3XQkSPFD59Nui
         +gyztxwmx6Jxcs70iV60vB7kw0uNqJPYMUvhcZU6SpfSRlHKUDUzMuLJZ7W8PMxsSY7D
         mH2g==
X-Gm-Message-State: AOJu0Yz5dLX+draRWnus4yJFULChYl6VGfT2Ru6UCtL2B8ZrR7v6ELdh
	wCJ9EDfUTqmEZAeiQvkzObPVWIkk+QIf7UW0UjtSMW0CFmcDjApjZRKPzVyZb0AgBP8axF1rbVs
	5CzMCZH4GD8AzT1C4MJ2tq3iWRIDlxdqQaQ==
X-Gm-Gg: ASbGncuPaqd6blhkQnpFIYlA7sYXmgCiWbwO6XpaMespwvcCFDc25f/vGulR0OEQ/xz
	cB6lY4tfosUutEenf+R+BY+oiECsDCttvhqY2Gqf4DjrkxrdlS0yCM/oCwZi0tIXeM8TKwgn/eT
	tmV4tsHGF1+M3vnTeLmuHx1OaAL72S0QbFygULn/MLF1hwmpottxtlymr1l+01bsy31keEBjcmD
	UsPYd8=
X-Google-Smtp-Source: AGHT+IFyl5+xDsXLiILMxp0bBKlqu89uWrQumGruptTor5ZO6o+ErPqmlgs06Xtmf6aLdEwjgdIcdpobEtsZ6DOw9Fs=
X-Received: by 2002:a05:6214:27e1:b0:707:5dac:be09 with SMTP id
 6a1803df08f44-7099a27f4afmr154076006d6.9.1754900819098; Mon, 11 Aug 2025
 01:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754898959.git.liezhi.yang@windriver.com>
 <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
 <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com> <cbc5cc61-9aac-424a-83a4-f0bc1c21d1d8@windriver.com>
In-Reply-To: <cbc5cc61-9aac-424a-83a4-f0bc1c21d1d8@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 11 Aug 2025 10:26:48 +0200
X-Gm-Features: Ac12FXwC6CFXR8YvYNljzb-_rUyzOL-lhv1EpozyxBG-j2Vp2hVqJeTUhC3hpcM
Message-ID: <CANNYZj8cUAhA+j5t9Lc0UPELpbG8nx3UmbLyUy_Axrv9-AY+Rw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: try_mirrors(): Skip invalid
 local url
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:27:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17857

On Mon, 11 Aug 2025 at 10:19, Robert Yang <liezhi.yang@windriver.com> wrote:
> > Can you please explain the use case? I'd think failing is the correct
> > action, so that the invalid url can be removed from configuration.
>
> There can be multiple PREMIRRORs each PREMIRROR conatains specifics sources
> for each layer, each recipe will try the PREMIRRORs one
> by one until succeed, but the trying would be failed if the PREMIRROR
> doesn't contain the required sources, so return it immediately to make
> log.do_fetch clean.

But why is it specific to file protocol then? If the item doesn't
exist on some remote server, there would be the same issue?

Alex

