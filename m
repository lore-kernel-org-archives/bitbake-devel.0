Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922FEC1E9C
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 11:12:50 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18270.1770289966338724805
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 03:12:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CMTB0D5i;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a288811a4so9187646d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 03:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289965; cv=none;
        d=google.com; s=arc-20240605;
        b=SoUOH5Smz4HTIxyEhsw9Tw6HXmlBdckM208fNDvnF9Q3qIOSL3iYHcFh0q3qdr76/V
         tJSV6fMQjdoCPIcWE9kk/FOxBU7DtqnyibrVCzXGNetyHh9xDzZySO2TP+FJgXUdLW91
         P2qo2nkGCkxeYPG1VuOq6mb28IYsPeRGH6ntzpSmK0xdW/qPsbnMsY58hPjDGNtNVDrd
         hfm0J6rm4MKMCR4eb26azazhi7mABLPYVQbDYedzSrDucWNBGnnZLYJBE3tACRF/Ky5H
         puYOzl9jwgIMSiYQ7e0fwBc1RrsEP7tzTCg61z/jEHrFbR/uqQR4Co0tin4MOhZ3Fkrt
         B3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c1S9+KPOOdC7AmULd6FTA0QjXrvgZu2DD4VQLLyNVRI=;
        fh=Hum/kZAjzN6Flc1ry+eXJst/j9pwak+n57H5EduIZPM=;
        b=ZIOFE82IIQohVIKKawJEAMaV2/D/5XOQR+VrJgY4CEUPHxzLcdx1i8TaINnUUlyPc9
         wiYkHo5a+gfyHrYellh8zqb4LFdE5F5jJWEGetXr3n5K9BE119eY/YO2leMsylWQibcs
         TtDvDZPygggOON+Oh/7xcmvDAMcN4WZPLLLXnJ2AA59eKvIrLuy+chvZ6/CcL4GVpgUk
         /ENOOJK+oufiS4X9HFW4EenpVbX+b8OGGBeeQb8o7OU07dbjXvbsr9F/YhD3xFPC/lK4
         Hw2xWdnIxMuOg8QHd+m4JhWEOj+vd0YB0jA6Nfi+NrFPAaS4/DEgoK7Mx5HWjzqgWsBt
         tdgw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289965; x=1770894765; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c1S9+KPOOdC7AmULd6FTA0QjXrvgZu2DD4VQLLyNVRI=;
        b=CMTB0D5i67GvqPu44AI+Ua4+CAlSFpATO9bycZLAHMS2WYL7aCVz38uwuijJOfQnJc
         ZuQqUtvt8TYCN1GJEbx69fDbeuOJhV99GmuOohW+1AyHxGT+JDUfv9PdWqdFpKFymVd+
         AvvDVZGp7DJl7Haqcl2rrdugcIIFcxq5ROcgTAfOlc3YT7UOnWMOu/Sg1rX/08RMOMzS
         OnGUo/V4vBg6WGuP2UNgUaoq9qmVRniTOwwxA5gpbYoJ86ogGShGA8Jb5bFnQZGLlJo+
         QmhoQiazQH4zwIAuT/OLotjoeA18cDIFn3w7BhV541euLFasHpGLc+hGOOfqugdlITCI
         DFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289965; x=1770894765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1S9+KPOOdC7AmULd6FTA0QjXrvgZu2DD4VQLLyNVRI=;
        b=az9+mbWQ6LidA0ls0AGpYvDAdmDkOdCqBWdnNY08U3268huHg97EslnRINMoA5TD4F
         KJw3i7fKJ+PdJnVYS2QZNqhldCKrhQvN4SjnCnOVfcCiSflLwqVGGlifgjaLvbMfpAin
         C8DoS+SrLsMn31LNgrJv1nyXIlZMPpt6iikEsvTt7iOnEZxk9IPJP0MWV+WYQwYluEqU
         r55CfrT6GGAXwi4ydvRS7tx7Kzitnc8iIX2+JH6tp3Rmr7ygfF0bt6RdavyX5SatZPYj
         IXSyV0icvP+c5Q3CW/dOaf1VhG2tZniTIg46SbIpUHnIHPZdaZDykESXYh6eAtsy6xer
         c3SQ==
X-Gm-Message-State: AOJu0Yw3Nv0ZrDAot7oKKBZDR7BGEXvdnvPeBSBVtaVZdhywkMo/TUzr
	cfh09Jg5GEARUK5kNDfra92NbroZcMcvN7y1UEdAPWnI7jzpHJKnmzlF1Eyi1jw0KDWwUffyTYb
	sC5yAdO+kM/QXhRH6Zy9O1lEPuPlAp+w=
X-Gm-Gg: AZuq6aJhVHd5SKn/0HCEFeZazeJP+WMOfp989f3bzPlQ39Y8yvP9IhDjvAWI+Dx8U/j
	eJdZFqpOAaWOht0L92EXy+WeF0wIwjgUnVqxnif3Lxf7S1svMlqIVBLYxVJVtTSTE9LrO1spdj8
	c0aZ3XIkj2YrGUj68ugu7cdvRyrQZCdEOwCzbGcLGPLSIIFYyus19zWs89HGtRbm7wsJSYgYauz
	zZxXJ7cgKS01yYnYuyoaEUMNm0kq3FH7oL7UaJ0+xZJPkVURLB8s/g+VLR7+zl/Q4tT8HcRkaqf
	s2e6qg9ODiZFT4IR3bSrym7PgfeRu7ZEt6Ydie4n
X-Received: by 2002:ad4:5f09:0:b0:88a:529a:a530 with SMTP id
 6a1803df08f44-89522119a02mr92006956d6.23.1770289965323; Thu, 05 Feb 2026
 03:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20260129120421.4413-1-alex.kanavin@gmail.com> <20260129120421.4413-2-alex.kanavin@gmail.com>
 <DG6ZBGNEUSSR.E95H6B6IK8MM@bootlin.com>
In-Reply-To: <DG6ZBGNEUSSR.E95H6B6IK8MM@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 5 Feb 2026 12:12:34 +0100
X-Gm-Features: AZwV_Qi8tlxG1FkuLvXZSaC92jFKa_nKrv_ICo711lDdnxQVWgavDDMbMxwElHQ
Message-ID: <CANNYZj8=NLgUPttWTy2suUnxj45MJ3F_gScL0tvyykFdwqJS_Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 2/2] bitbake-setup: share sstate by
 default between builds
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 11:12:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18963

On Thu, 5 Feb 2026 at 12:08, Antonin Godard <antonin.godard@bootlin.com> wrote:
> > +                SSTATE_DIR ?= "{sstate_dir}"
>
> Nitpicky I know , but we should add a line return here, as DL_DIR above is
> already separated from SSTATE_DIR by a line return.

You could also argue that the two sstate settings are in a group, and
should be visually 'together'.

Alex

