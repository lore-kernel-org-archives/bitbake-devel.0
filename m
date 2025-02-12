Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5EBC021A1
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 10:42:35 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.12731.1739356946129140708
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 02:42:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RgOK0BCN;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be3f230436so621714885a.3;
        Wed, 12 Feb 2025 02:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739356945; x=1739961745; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hX0SxvfHMSlRlrbwRPutX/1iIulEJsC8xMvuS+lv2eY=;
        b=RgOK0BCNZIICIGIO7Eg78tMXxl4luOz9qvRXQVRfjyokO3Te9q0CtaVd2TBassLRHP
         wBUoKhyCbMPl5+kphlyqASs1QT7hGQ7Q1DlzMQDzbAO2dLxZpgYfzA1L4X15vLRKh/Md
         IEK/FxyNIwzlSpSqcxC37LWvr4JE2tHkNttS9IdY4oCQ1xByBVmMHkQZk65jqnP9x/1M
         RqWNDim9NMWZ8Z20/YB29xgd6GGEccvuXcycFmPgiZon1pGoK35lp67rDFPHt6auKoGh
         kbRvSqn7srCan8qYOkq5dfaJjH7mbITZOt08vWLuwwqUTMGFPd94gSVS1Qe7D/IYqfLK
         yW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739356945; x=1739961745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hX0SxvfHMSlRlrbwRPutX/1iIulEJsC8xMvuS+lv2eY=;
        b=AQ5iIO5RXvlejx1EdvVaGXNZIAMcpDSDeWgoiVL1KryKAC3IoPsPQe6qO01r1o9R/Z
         n4VHUUWag6H0dOa5tS72P5URFps8FaoPHgBAHtJY7JCcBkYbDDwBhQQBouLYBw9Cs+Zx
         06MvCOZXQeaFU9z2zRMhJoUO3/DbFKTTQ4ZY/Bhy+YX2hcaDBvk8QvJN4gQeHDHIgU0h
         adOjA18PN8vCFHv3Lfiss9+wscxEO38yBghiAsJwJcbmt3zQeDCyUlc0a54OJlgk5B9q
         sPKpZlMV9cMGKIuAfEqfhMgyv2I/R2sVJJmLMTZ7aSW2fzBlL73PGDnCM6qoqnIPQgQJ
         FA1w==
X-Forwarded-Encrypted: i=1; AJvYcCV4aPAf6ZsrquOC5hReHnPuEoV6dCdFGOzCqeuhEwtyav4ocnnKUwozSb4UmsCF89Q2DLBdXUvNOqNHSsUu@lists.openembedded.org, AJvYcCVpStk+h4qtj9XH1TKjoz6by6MB5vnf5uSgSWKU8IiCovOz2WHKUuz2jnQCmyBFeAyJYwHx16kDw31PQVXsIfL2y0I=@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywj6L3DxI7B9fQJphm5KZKwMgoyhBBnbE1Nj0goJZ07fOkeXAZb
	kQkCD8PqM4kUpzfHn7FEp7Ieg6cR3In3xSpnbrXPh9/d87KW3wNv1WCYnEc0syPvISj/nok0/ge
	f3nLvtHoL3716nk+EZRLuSOAr/nY=
X-Gm-Gg: ASbGncuiKjzOZBRcYQPc6RaaMVVu+VpgD2QItJ3DXWFcFlzegKkjYPd8iuUBB41H3Pp
	3YgQhZ8Egxe7Kl6bCPcvZJEOOKiPJvRhTMfBzih3fPFkt1NUHrt1KqdS6OcTjJaE9mgy8Qsv060
	B+TmKVpLeSNloa4+NUD6jbRHTHebjkmdM=
X-Google-Smtp-Source: AGHT+IHFkaoCZweR1SyPRTr45e1aJjhPap8pGM63uwqDpB96HAcXUJ18adAlfpe2CG4bUbiw40tcTXdK7L8tG4S9CYU=
X-Received: by 2002:a05:6214:410:b0:6d8:9b20:64e8 with SMTP id
 6a1803df08f44-6e46ed82f7fmr48989376d6.10.1739356945055; Wed, 12 Feb 2025
 02:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <81801173-8a60-4278-a8b1-70715fa5accc@weidmueller.com> <18236D0FFBD06B89.28278@lists.openembedded.org>
In-Reply-To: <18236D0FFBD06B89.28278@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Feb 2025 11:42:13 +0100
X-Gm-Features: AWEUYZn4vGF6Ju3pOlZrofkEUQYZMKjrzPyfDFgjtcE92bp9X-EvgtV78m60A_o
Message-ID: <CANNYZj_A8i2Rvk_-NwoZS-0EPVC87pm8OA8m6Jbd=hkayTT=4w@mail.gmail.com>
Subject: Re: [OE-core] [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
To: alex.kanavin@gmail.com
Cc: stefan.herbrechtsmeier-oss@weidmueller.com, 
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"openembedded-core@lists.openembedded.org" <openembedded-core@lists.openembedded.org>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 10:42:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17201

On Wed, 12 Feb 2025 at 10:50, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> This doesn't explain why we need this separate new variable to begin
> with. In what scenarios it would be useful? How does the
> implementation rely on it?

Ok, I'm reading the patchset further and it becomes somewhat more clear.

Stefan, please do write long, descriptive commit messages, so that the
purpose of each change doesn't need to be deduced from reading the
whole patchset. There's only so much my head and other people's heads
can fit in.

Alex

