Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F055F9B600
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 09:39:24 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78579.1776850754205370899
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Apr 2026 02:39:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PwnWi5LI;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8eb5ad01402so331772585a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 02:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776850753; cv=none;
        d=google.com; s=arc-20240605;
        b=QsZqXR0SMnE2Lp6HtIEh74el9AoLa4ydjsadkU1OHdoJvv3f/b/6S+MqEMk7FhMqfy
         y5wi7pydf+JtNgpBy4WsCOhyNJaR0XupEZzxom8X6gijnb+3qq0Xv10rKn3jTe7R4G0k
         vrDWueke3PRgocpoptIqqxAAd+NlX35WuL9Vw2KJzHNX+XaCq/PnxMZH7rd69VN3+p+/
         G548sJmi084I813bmQ9wLqHwPkoV6q+ntH4bIlTqIeP7cOnR9svwGrHZ/mZNJ7nVlP4r
         WlYkyPVFU53Uved6Vrw6Tlpvyblyy/YYZStp/DCtj9cFlCNnvtMFGtXMVjy7aROTU+CO
         ghWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rj3OcTDPBXoFykaKY0bF94hl3jd3x6owUrdKpD3T2C8=;
        fh=nTTaCMLSXiKcsNq27TrJZaTuW3XGD70wCTeR+9P8VtA=;
        b=NVzvmnwfV7thZx7KK2JrZiPgTqh3aVV+DbgCeIZYiJRm902PBtndcTo8YotVTm4NXc
         qnKqq1g9yzd4B485jwlbb61q6ctYo1HxNRNBwUY8IwfotYa+BzrUZe4uVnEvoKunJ0hA
         GVWjeWc1n6/OFOfSrESIe1lP7T1pBEbTvcZb7WpdmnD38fnJ1n661GbyLhbcUrAp75AV
         hlFQKyDhSdeJtdFt2OVnKA+AHTTgxU+cP1Aq8JJjRGnfJUz4UAgQXla7jEYUNvs7WmaO
         MYoiNZ7kSOxj4BBalGCF2nuYTz2EamPPzLa+DWmDJkCbxCtiBM+9HeU6TxzXuWB1Eb06
         fN1A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776850753; x=1777455553; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rj3OcTDPBXoFykaKY0bF94hl3jd3x6owUrdKpD3T2C8=;
        b=PwnWi5LIB/f/EFLmGKVDGvXFJH2idDrot0vACa84c1rWxZ0tBIqLRlucAQZ8OPX9fp
         J+DypbwtXj/+PljddKvxZ92pO63eWJxgPpoayQfxKiW+UjcGgrrU37oJLERgx5l4dEID
         BkT62++EgMxJtAH8Ok6tj0TQyZ7VH2as7oUEdUafrsuwWuzgz5BJDWp95qAId0KIQV3c
         SIbFy9k8F8k0Ocgvs6b9sLrRKjXQsys4Zg0H541TbWdUmC72hPSKIPf/BNiTTWndKsN/
         p/5HxahgoZP3OvIo66QmcHxaEb+C4kvfFdnGPf5Kl9IDugWE+L6eynTWIWcPjr0iivKu
         PE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850753; x=1777455553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj3OcTDPBXoFykaKY0bF94hl3jd3x6owUrdKpD3T2C8=;
        b=fKjd6oO8KR/3wE7EI/XLS99FosTkUvpLEA55owe+FnQiL8LROYZlfx1RiTdewCLwtR
         kfw5h6K6BXYlXNdOr5VruX4R449MZokxwme+w77Ejj05hjGr7amj92VcqRQ6U/asx38D
         SlFBrp4QBdPD2Gc3ppE36BMzhct9xX4gwWzrEhURiQs0BxooObQmKHzCjAPqsTju8k00
         tgPVsEMvLPgxzJnGssbr1jhHsaQa0sNRXaZEc/pY7jhpyHm8nX1aHaTUP7Ppo8AHEDd8
         x5BTYevjfLL74lerkE6/ECCbMYP0NI1BXKRZzIYF/RzhQktfXRygKjbsN6nBvsKEaphc
         excA==
X-Gm-Message-State: AOJu0Yw1jY9/q8hpZCQsThD6IQkFtLPkSGs+sOxfY8/pICV0rojbrBhk
	7Pa+1dHEZvDj2RnEGc5Q8BtIpVzAlvWaIc4VZNn0c2/oL9N/KTlUww6eyAGxK6rUqvAbrsAsCNh
	B8PE6GDL8NWsH95rZr8dcD9lzp9M7no+Tbw==
X-Gm-Gg: AeBDiet46AHBiDa2WlEUCnDkzGEo7+NFKBz3PPRiYiwnBFT8mXPbneIUDHpjpJQtPYr
	HUc1URpRLlYV6wgfgiGn/+53qbEu3GQdBe5Y/O5N1Ka/aayGfSXKqtXGgUZABoT+FqCadx945Jd
	FEjFHjOYhL4ZZPB4e4skI07SWQRV9GtIuCKUfinZpG255oxKJ+KJOpLg6N4Glq29bSRr7lewMIk
	uLdF2oYTM5RkMvaD1hbfvNcesJlcKHgSU+VWEm0YE9NdRuwDDjjPCWKGg0jlJ19EjGvRsIboMKJ
	fOS4t9FZflCrh7jEymM8elNJsUpIfiB8XLTs+PFs9gZ0wwqa8tcF
X-Received: by 2002:a05:6214:cc1:b0:8ac:b4b3:3ce2 with SMTP id
 6a1803df08f44-8b02813ae21mr328958716d6.41.1776850753117; Wed, 22 Apr 2026
 02:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260422091826.135946-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260422091826.135946-1-richard.purdie@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 22 Apr 2026 11:39:02 +0200
X-Gm-Features: AQROBzDYCGGyfEsCOojGfUTg9obzCAjnuZcO0Fjklx9_thJTqCNKOVGzeuAaYeo
Message-ID: <CANNYZj8jK1aNNsDufo3y3_Dd95VrAFCdu32OfykMzRuPdxmouw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] default-registry: Update whinlatter -> wrynose
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 09:39:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19373

On Wed, 22 Apr 2026 at 11:18, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>
> Add the new release, replacing whinlatter which it supersedes.
>
>  ...onf.json => oe-nodistro-wrynose.conf.json} | 16 +++++++-------
>  ...atter.conf.json => poky-wrynose.conf.json} | 22 +++++++++----------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>  rename default-registry/configurations/{oe-nodistro-whinlatter.conf.json => oe-nodistro-wrynose.conf.json} (82%)
>  rename default-registry/configurations/{poky-whinlatter.conf.json => poky-wrynose.conf.json} (84%)

If someone has set up a build from whinlatter, this will break updates
for them. I think it's better to make a copy, rather than rename.

It's also good to diff the new wrynose configs against master configs,
to ensure they're in sync with them, similar to how wrynose itself is
branched off master.

>      "expires": "2026-05-31",

This needs to be updated to 2030 :) This field is how bitbake-setup
decides whether to include a given config in listings or interactive
selections, so whinlatter will simply not be included in those after
that date passes.

Alex

