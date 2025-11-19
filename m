Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C31CF34D1
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:10:48 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9290.1763565039607399590
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 07:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l3+EWg6c;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-882360ca0e2so50196586d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763565038; x=1764169838; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilGZIHCihGNRrHbJI98S/xTblgli9c9LzMP0UD338Tw=;
        b=l3+EWg6cGTQkBKN+I1G3eGbqe6kQ2gFD15+orBvRxKcAHrora6WQx1FjnFhN4epJTX
         2ueaAQ7o/H4tv2pBSedB3C7jp+xR4Xqzh/0Bb0w08o4F08NjREaU9RlWndsGY7TY4e6k
         nplWVr95jOT912eCvOiG+2eigS1wUSB1Cjiz6HbMgmBZ1eKs6QB3j6wsCZKmg8Vm6OBX
         OSFHmPSshCm06Lggi4X+deoUslJxTDM8ujPKGKiEu8TRHGLM1CICyOqqm3F4jMSdkxxs
         IO+9Hf1ZmXyQNy07NXpCSI9tLZSxObmTSTRHzOwSW4ZXqA4wEY8PnovOlnZwNuJ0ZXQC
         Eigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763565038; x=1764169838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilGZIHCihGNRrHbJI98S/xTblgli9c9LzMP0UD338Tw=;
        b=se8ijFhx9zxbYbIeWa9UiIcOnO1cyhio2MyY9mAaenlBI/AIfv8xE720oE76OwSsgn
         NjboIinm5Z40Q0FhXSXFr1eMAjo5cVFFdukNaZ4QqWTIM1TfBTmsP6TYz6Ianf+XJN8n
         rkVk7MmjurSQJ7Da4/R+Udk6viFNeZ0Xh/ju7Xcu/sTCa3RKnXuqzhQU1YbBz0fxgv9y
         IhbrR47L7h4/y291AT06LfQMkgo/uYVANwidFyDhK84HEwCnzPjve0fTx+uN5ScIj81L
         Ay5FLHxBUgYXEAnIwVlw3DcZLj7Y4VyO3acv0NyfuwVA6Yw64THFAVaNO7LE6ex0eWT3
         N4+A==
X-Forwarded-Encrypted: i=1; AJvYcCV8TXUCzdooDnlnz9iAiLa4C3EIL5zj5cSl8w1HXreKf8U2Lbl2THqgSAfyjwJhh2xZ5qupVjmCUZb38yK1@lists.openembedded.org
X-Gm-Message-State: AOJu0YxHXc+ysdWz863pSKz0mQE1xjw1Plu2PNn8xMA0NK0LNj7Z6pn9
	1rM2i+3+3aHVY6kdbyzKWTK3uhugCVp+kQppA1WsNMX8G72DDGBeZLUyKlS2MmMAET/sR0xRPAF
	cMbOKfWZAz55T+z2boxOXY+6EN2C5SF4=
X-Gm-Gg: ASbGncvf4nOoO54UtcOMq844+VVtIW9ug83SIASTxHDosnR1lHIRVdvVn51FqwzZQaR
	U797uzzUe5KblF0WINC+/kZOkla6SJfUqtwCSefVeZk+UTGTQrzsYVQ2hxWjlY5ml7Zy4EgYlzz
	mbk2S1ixIccSGULCgNfEDy2mVEkEGezg/DG9D/HhZTgqyEg5/7/SFpAG81YYEAHHlr7vT/NTgDW
	cVagiAcfkLvd3K6UhoxKRF0ie6hygnnTuATcfvGiWzBoTMjmj8EL8HIZoQ4qS0YxGamdAyMzPHT
	oYJBGjQU4Uf1gBhN3s7ns0jwfkjYFA==
X-Google-Smtp-Source: AGHT+IEJJWkERXa/CLiRHmkyjZvxF74opVpsXwwwYHoVj+nYaY16APJDHHx3atpp+QyrG1vJbZQDhR3JtDb0cyUqCpw=
X-Received: by 2002:ad4:5f49:0:b0:880:4695:466b with SMTP id
 6a1803df08f44-882926034c9mr333637646d6.30.1763565038463; Wed, 19 Nov 2025
 07:10:38 -0800 (PST)
MIME-Version: 1.0
References: <42bcc23e-27ae-8bf4-486d-3e552d58c701@crashcourse.ca> <CAJdd5GZZNGyPePiJEQnn-0mZK0cX9dzTh7KM3uqkFJtnJ6dVQg@mail.gmail.com>
In-Reply-To: <CAJdd5GZZNGyPePiJEQnn-0mZK0cX9dzTh7KM3uqkFJtnJ6dVQg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Nov 2025 16:10:26 +0100
X-Gm-Features: AWmQ_bl7MRbI4jcgaWR4XHn-xXu75Isu_W3MPdQGgCsMqxFy2KaeluoLbY97UMw
Message-ID: <CANNYZj8J3FGkjpjoAqaPqAqvobScA=HEOpz2BSj=SXpgcVP-cQ@mail.gmail.com>
Subject: Re: [bitbake-devel] why is "bitbake-setup list" trying to *create*
 bitbake-builds directory?
To: JPEWhacker@gmail.com
Cc: rpjday@crashcourse.ca, 
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 15:10:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18461

On Wed, 19 Nov 2025 at 16:03, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> >   i'm confused about why "bitbake-setup list" is not just attempting
> > to "list" stuff, but is actively creating a "bitbake-builds" directory
> > in my current location.
> >
> >   if i have no bitbake-builds in my home directory and i'm *in* that
> > directory, then:
> >
> > $ bitbake-setup list
> > Bitbake-setup is using /home/rpjday/bitbake-builds as top directory
> > ("bitbake-setup settings --help" shows how to change it).
>
> Does this still happen on the latest master? I think it might have
> been fixed by: 0ae46d39c ("bitbake-setup: create top-dir later in
> init")

It does yes. The issue is that bitbake-setup needs to set up a bitbake
datastore (at least), and potentially fetch and unpack the registry
repository, so it can walk its file tree looking for configs. The code
to do this is shared with things like init/status/update, and so uses
the same top dir as those other commands do. And of course there was
pressure to change the default top dir to . (instead of ~) which is
how attempting to list from places like /etc no longer works.

I guess it can be changed to use a throwaway tempdir as topdir rather,
or go through the same "print top dir info/confirm top dir" sequence
as init does.

Alex

