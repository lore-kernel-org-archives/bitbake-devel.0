Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE7C4332F
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 09:00:38 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.8821.1670576427877029880
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Dec 2022 01:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=U1UTB4E0;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id l8so4234309ljh.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d1BA7HA9vKbhaeFLWZDcleslnbENbirenI2EMzj48Tw=;
        b=U1UTB4E02s3v5GxH/9jpPybKe4QN52EQW9jhu0mwpR96/dTDFaznnKQnTo4TcsngTY
         zPlKLpm6hppDjEu4t4kRuS5mVSgYckwKVgu/IMtn6XQCn4fBfO9WNVzXTlVogB0E/HCe
         tYBuChDpQ4Egr2BmIZ1pQmKB9GtNfy8L+Wh99djRxdrH1L/Gp6CYhXuam2sk5v2Yn5KS
         atpoBsOIlPRVlBao9B+ljD0KifC1kFngIsQE7ZbS40gnvgSAN+apSIMhNymdtB3Fqp9f
         vuDwWMv8ENvzvFpfHXvi3nko9tfctOdlIhNdjUsE4uhjluyfdzZbv6N1VAgfTTT3nhyS
         x/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1BA7HA9vKbhaeFLWZDcleslnbENbirenI2EMzj48Tw=;
        b=uq6HNkhrVOs22K62KRGjr8BbwBXWNsE6jRTLRm0BAP6+Swv1kyTu53pAK6pJw88JL2
         B2utn0Ab2Q4IGw8t6kymaTkQBz6qbrDF8yRrsg2T0IKE0nSLYRAqv72i7zfBeEzphrbG
         Fc7Ct8n73TOrig4P7DjKAIvWA/Q2SFX+wm9jiIVnR/tRPN3VGCNBZN1woDrokaCYeTDs
         luONAn8LaT96cXEcLrT1+xseo0x6m0FPCt3LzeBoHwTLwfGwnEWUrsElYCw8KT2703bg
         bv/E9BKHUtr8EdPOOyyeetboP1BnxpwSa+8iaAw77rla+H6dzuaa4dNpLbrrgA9+uBA4
         dFwA==
X-Gm-Message-State: ANoB5pm4JVVMBzreznZncf8S2kZ2acASO9+/JdSZUM0blf57ir1z2lN+
	XbEshTblevAkEZIpV+busLCJvGY/fC7FxU9R+to=
X-Google-Smtp-Source: AA0mqf4bI7q/XttPI+8NoVFiPVVrKaymFneC/VU+iGtfSIHHd+ce77u4pSyotWOud+pVesEYCB7xfGrud67MptgE56w=
X-Received: by 2002:a2e:7818:0:b0:279:bf32:34dd with SMTP id
 t24-20020a2e7818000000b00279bf3234ddmr12646953ljc.31.1670576425410; Fri, 09
 Dec 2022 01:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20221208160320.3306734-1-alex@linutronix.de> <Y5JpB9iZ2d65PJIg@mail.local>
In-Reply-To: <Y5JpB9iZ2d65PJIg@mail.local>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Dec 2022 10:00:14 +0100
Message-ID: <CANNYZj9Sv012uE2=i6oRoVFsFSF1YhbPGYpx__TE+WZzYKW9wA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget.py: correctly match
 versioned directories
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 09:00:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14159

On Thu, 8 Dec 2022 at 23:45, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> I got this failure:
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/4517/steps/12/logs/stdio
>
> however, git didn't complain about whitespaces while applying the patch.
> maybe I can pull it from one of your branches?

I just sent a v3, v2 had dos newlines which probably broke things
somewhere on the way.
The patch is in akanavin/package-version-updates on poky-contrib.

Alex

