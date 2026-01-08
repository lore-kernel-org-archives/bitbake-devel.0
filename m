Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A6DD185E9
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 12:14:31 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5146.1767874463881322067
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 04:14:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hU49eE50;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2d7c38352so192412285a.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767874463; x=1768479263; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLg5uRYigNAU/Q7emjxtbrtH9v3myOFz8YvDs3z5nNQ=;
        b=hU49eE50qQts+ALdoosDx8AG4AHj6u9KHm5rcQDW8KoW7mWN8cEwC4Y/jquO/OfUgm
         BI9G9J5D3HZ7El+0sCQ6ODsD/rXbbDRpQBBEosJr1m6bKZ8bDNDKEGLAlEW+/5DInPfL
         xiOz1U0JTO3GOHYF4hm632RTW0Y0VvN+x4r56bva3dgGeX98VzlJlA1W93dxy5+4Cto7
         5pzvY/aPHKNQK52BGNX+e/j9MJPEZhKicRAZBhewEuPfxN3AswkBIfDdaoVLaCQI1McY
         c9VwEgAn8qerh6wmPl57Il+yRo9H9H6VjzldXW5TWzuy2Pk82G87DRbL7E/m76GJy8hh
         Z/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874463; x=1768479263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLg5uRYigNAU/Q7emjxtbrtH9v3myOFz8YvDs3z5nNQ=;
        b=gvLlYaU0GrM3VJ9z5fR5RNHPdOWm8S8iR+3JYSG0W63GTELgs8UUQ7r/qz8OV+qAR0
         yTXQpLMC//sCIYdboVB1dH2jrRzTtbuoLIFffFRccvjlBMyH0g2+sbvZfwClrOJWiYUQ
         xdbzEjH1KC7M9tCTSW+mnzmGEXuWIOxi0vbvhgwJH4Dnh7U7thgiY6bQSk3uVoeMvh2E
         2sDxmWpenVtFgbnYA6Ya/MQ9ci/mMm3o2bUqN/WHv9Z8wOLiWFqjNWF+L3AiME0fTJeL
         npQghg2J2rY1dkQzXOisVRd541X3M5cdBZW5qtXy/Mpa/s4HDFN+PVI7XbtMVWJfpvm7
         FLpQ==
X-Gm-Message-State: AOJu0Yx7cLkcnSdAzs1wAQU/FzK3e+r0UyETQmALDfZWd/xCSKosvP2b
	eMzleVVFJTKYb9T5pL43rX6eq/Jp1bEd4gEokA0BejwN6iI2xM1iIQn8QmOu5pH7Qbr8pYfuqex
	r9T47sJDQ4L0edFyfAAYChkp1cx1NIcE=
X-Gm-Gg: AY/fxX7LpOE7n1Mjwv8DI04p5N+YCZMr3lUxJu0UtkAAEBHO8l8qPbATVfPSzZYw2My
	a8LpSq7Vf+gzs9QSdmJClgOxvI178UxpBOCg0tFkDO65oQXqjKFULY/PyGKtEOOYPH+sdo4vdU2
	DvlLdAyGPUXEpRFcfSM/H3AMLh3ir1MzW6ZtxfWWefA4DZQ0l0H2wwS+KgH5vgVmLnVAJmdfMKS
	YIHSmF1Y7/q5asWVQzAAV1q7ur6VpcTldxNxPgWVkzeRc+/+NqrxGrXpW+nRIPz1QtqIGULz238
	P3lbug2YhSQmY4hyGNshZnaqUX+BoyqZwgGpIUwp
X-Google-Smtp-Source: AGHT+IEAUBLKUvJw15KhpNQD4wuLMTIIIv+EsAnC4xn+otJ9OUeisa63v24Vxvq+KBqq49Ph8imn24PAdqhwTCAIWPA=
X-Received: by 2002:a05:6214:3988:b0:890:597b:ac04 with SMTP id
 6a1803df08f44-89083cbb484mr86930746d6.18.1767874462766; Thu, 08 Jan 2026
 04:14:22 -0800 (PST)
MIME-Version: 1.0
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com> <1883858B93EFC423.1614991@lists.openembedded.org>
 <188385EDFF4B6429.1342979@lists.openembedded.org> <18870377D56AF168.1986633@lists.openembedded.org>
In-Reply-To: <18870377D56AF168.1986633@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 8 Jan 2026 13:14:11 +0100
X-Gm-Features: AQt7F2oLUOUNcD9mrePagXjEU0xxiDFedvD9hSj-EovqQbKewTVeqrguw9fsKUk
Message-ID: <CANNYZj8+msix6SFiCH=4UcLogt-+zA6=keGtXtBPbTE8vKTqoA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, uvv.mail@gmail.com, 
	Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 12:14:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18707

On Fri, 2 Jan 2026 at 21:19, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:

> I posted a patch which adds the local modifications check.
> Unfortunately I couldn't figure out how to check for additional local
> branches: it checks only if there are uncommitted changes, or changes
> on the current branch. If you have ideas I'd appreciate (simply
> running 'git branch' and counting the lines does not work, as git
> fetcher's unpack first unpacks master, then checks out the final
> branch if necessary, so both one and two branches can mean no local
> modifications).

The more I think about it, the more I'm convinced git repositories
managed by bitbake-setup should have a commit hook that prevents
making commits altogether and tells users to use 'bitbake-setup init
-L repo local-path'.

The local modifications check should remain, to guard for cases where
there are uncommitted changes.

I'll make a v3.

Alex

