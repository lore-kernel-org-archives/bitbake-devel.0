Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E370C02199
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:15:52 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.68008.1738930547585506004
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:15:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=khg1+IsC;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fa734a0b8so18825991cf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930546; x=1739535346; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GluLOG+nFA8kDG2fc2g93pUqoy37hV7O/aAJfF+vZl8=;
        b=khg1+IsCGh07W57vfeGa1mQOsqGPDNctLYI4FuyzQ53K28XWVxtf6icEUJvWB8hNap
         ovj9njkJZWJunVQji+xQ9GyE0OSiaGpiay8sSH+udcsbP6T30sGLhK1HeDw4uJ5D+7tT
         0zmsIw0dxw6hnhzZKXyP3TkLPPATV0+ecHQ9Xq6z/c1T7/LGILCcSYAU8Be/gnmlV4Jr
         l1xp2/B3q4evM2blu1rI9DIQSOEFfcrbarUG5CQfITSDJakr37GedjSAMfpgIrmpZaI7
         A7Ezj6wNU5JLhwCkD1FTptZiu0krbqKcTIWQ/dLB9gujwuRppoGAKq/m7Ob4+KwtFtTV
         NWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930546; x=1739535346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GluLOG+nFA8kDG2fc2g93pUqoy37hV7O/aAJfF+vZl8=;
        b=Kg/OQq5xhrwPPGJrwF8GifWoCEbzL6UZJZFpX2JUmhJwZX+gkacpU/cj0lNrw/X9tY
         18IUr7HrJG0jy2Zq/yphT+yFjBl+Y/o5pIKAHkqqWh9ZPtfwNtDHQKKUHnCseUEThHQI
         tFBgnRaSmtqhNiOmzof/dZ0GULyEv5yScw/FHdv9ZWSsLYM9Vy16br4jaNvBPhzqW4Lj
         nDJ7A9qxNLePnhKIh8aq07MKfeaJvMtRNn1uc3YWQjAEOvyHFQhVnn+KcLtUOAdANq4L
         xNMIMpOl4CEpA1PS1s7Jg5Q2x+fU/BDxB+GMe+bmKeF9+iUKZm/czBLRzqfHurmTayxn
         jL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpBEvcJjAFJW2vfbja+2wzBLUdbrhCn7ERcYfLIVzQl/kjW2eGr2LVLY/HW6ua1URat7xNIcsDN1TJ/Rom@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywsgfr/gb/W4stjLv5eTuFbYl7M85xPs2YzKn17KIO0EfOFOdT8
	pDpIvMWLzL7rZDRfPCLYdAfQaRrKnba8eyOKDVw8xNbVrWErv30eajGpDPpGSyUNrQVHZ8Y6qbI
	3vdCgPR0gkbBFgrEqam1w1vicZSw=
X-Gm-Gg: ASbGncv1oJW0bk5CaokylHZcLS1XD8p/oy+80KyqN1SYeqsnxYZynvWYpU0EbAaBZrt
	cFlFnngjx15RiaAZdUfLrIfAwEtiva/xPcKiZj2TocUbK9q4mQKu/6DEa2eNJGzl04sPVdL0=
X-Google-Smtp-Source: AGHT+IFNtZ9aUyuRW580DJVJzdsYMEwPSM20g6eBKgtAYb6DpctTsK2cIy5aq34NP6zfYzzMINLgiuXc94J9cngzWm8=
X-Received: by 2002:a05:6214:5098:b0:6e4:2d89:3a92 with SMTP id
 6a1803df08f44-6e4456f8d8cmr45744346d6.34.1738930545506; Fri, 07 Feb 2025
 04:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
 <20250129112406.1660522-3-stefan-koch@siemens.com> <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
 <1821E627D6FBF186.752@lists.openembedded.org> <1821E75CA5CDE51A.18160@lists.openembedded.org>
 <1821E95A02BB5E12.752@lists.openembedded.org>
In-Reply-To: <1821E95A02BB5E12.752@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Feb 2025 13:15:34 +0100
X-Gm-Features: AWEUYZl35kbxBQuhElojhWAtUOclRSSLr-55G0EJQ1nX81mNkA_pZpgHSyCbUsk
Message-ID: <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: alex.kanavin@gmail.com
Cc: "Koch, Stefan" <stefan-koch@siemens.com>, "Sudler, Simon" <simon.sudler@siemens.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Kiszka, Jan" <jan.kiszka@siemens.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:15:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17168

On Fri, 7 Feb 2025 at 12:25, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:

> Okay, I think this may have caused a regression:
> https://git.openembedded.org/bitbake/commit/?id=fdc55bb649cb77456d0ac48a9600ef289a52af18
>
> With the refactor, the file needs to be explicitly written out via
> function calls, and it doesn't seem to be happening as I can't find
> local_srcrevisions.dat in ${TOPDIR}/cache/
> :-/
>
> We don't have any tests for it, unfortunately.

Ticket:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15739

Alex

