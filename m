Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D2C02194
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 11:25:11 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.67299.1738927503729383537
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 03:25:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PhUZ0kKi;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e1b11859a7so12270756d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738927503; x=1739532303; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfCuBMY4aDavdhkhEDKRAbjS6dkEeZ15txc9F+K5sOU=;
        b=PhUZ0kKiURtGR2fLDpPttb1vOIHxfKGplSG3pEXgWEMKRGl1rWNj6MlEF1ebiSFi+6
         0cUm98JGN1hDJ6v+boujFFPvyTFT66xchhj7ifmEYcXCq0HbKpdKAIPgLgfxZ9Va3wOi
         b19cLTXfN0QM5GfDtBJz0gRcfqD3958kcK7PV1FumYvjyOKmd+8E0s9yhjZ6wn/jqrJ/
         B8Y0ERdamZ7DV4/LED6BZMWLYTfEUnNfcwySJU9nFWnrnaLYSHrAWhyzF24Cd14QFpPY
         pNdS4HdecBUzRpjFPf/JqgUrNvLA5nq6Fl9oni2j7/lP2JQBZj8Y1JTOPKbpgWSFH54y
         AZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927503; x=1739532303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfCuBMY4aDavdhkhEDKRAbjS6dkEeZ15txc9F+K5sOU=;
        b=pkXSY+Be2MsZf7NkLRVbuADOfNnXnk6IGdcXFfZ3XGdROTklIEH5LmwtuSQmtKaMqD
         ipdu639sdsrKM8GsDfEXr2iXnBCBJy5X9WDsEnbUV8yPhBIN3aH99lhqXghQP05USSed
         8yq9xrHUcf5iiXq4bodzEPN6lmsRr1vq7cB3IQOegWZmftYp3NQtcZjIR5TlIVBwpguk
         k+sVxVp+O/u6tu9tEIJ80nlW76JK34VZm5BvmwD0H9YXcK4YwpiknuaK8Zpful+jcHDj
         ylnGhNoJxLRNtzDY5KZyBGekclkuUtijuRzAelVuWIgHK1uavwPAQGMUzEpl4J54d18D
         IPyw==
X-Forwarded-Encrypted: i=1; AJvYcCXtnoq3mTcnagIRpenpiPG+FzOKkzOypMuqkhjjo53vHKXpbUhIaoW7vdD5NqMmwuoi9fKfhuFE4oQ/Qbv3@lists.openembedded.org
X-Gm-Message-State: AOJu0YzM0fXvxxL6AIv3D/+vQI0h7NTcB8ufHmzYPeQRvEbOwHgFRFTS
	V9686VM0m8m1DAvLfKfWimN4hM0zplTFJfLEzXZTnhNYeWpbmRmKTBKlyjkt9Xjmv9LDvPFhIcz
	UDiGu/OPKET+2R22AFtksjKm/wfk=
X-Gm-Gg: ASbGncurNyZsvV0H69/vJKitwx823UnML2fVyInLlyOnKhxMrWWbVWwYYPsb1FPeBdl
	08qMIGyBOxCB0SC4fUnDzp0LcZ8qu21WH/NVgCCsCS/Q1EbP/P5NKJHDEwHHEVd+nl8jb3AU=
X-Google-Smtp-Source: AGHT+IG9StrqwBKMJg70N8CxnM7TYwt0z0i8E5j+c/ICEF4pP15X03+WDdrbRplVfReIG9jspzP3W+m3FeI2msaGLrU=
X-Received: by 2002:a05:6214:2608:b0:6e4:40e0:18c7 with SMTP id
 6a1803df08f44-6e44566d9eemr43888756d6.25.1738927502671; Fri, 07 Feb 2025
 03:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
 <20250129112406.1660522-3-stefan-koch@siemens.com> <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
 <1821E627D6FBF186.752@lists.openembedded.org> <1821E75CA5CDE51A.18160@lists.openembedded.org>
In-Reply-To: <1821E75CA5CDE51A.18160@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Feb 2025 12:24:51 +0100
X-Gm-Features: AWEUYZmgxsv6W16N4oREcz6dykOnDAVn6WeV_KWOmibcgsyhntF-QilVyzYBSHA
Message-ID: <CANNYZj_gvfFwd=_X-0rc37j9hAxvipkDEVmRkiaverjVB=_5SQ@mail.gmail.com>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 11:25:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17167

On Fri, 7 Feb 2025 at 11:48, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:

> > Something doesn't compute properly here: the cached revision should've
> > been successfully looked up via BB_URI_HEADREVS, and a call to
> > _latest_revision (triggering network access) avoided altogether.
>
> This has been recently refactored to use a different mechanism, and
> the code above is from an earlier yocto, but it should still be using
> a cache, and the look up should succeed.

Okay, I think this may have caused a regression:
https://git.openembedded.org/bitbake/commit/?id=fdc55bb649cb77456d0ac48a9600ef289a52af18

With the refactor, the file needs to be explicitly written out via
function calls, and it doesn't seem to be happening as I can't find
local_srcrevisions.dat in ${TOPDIR}/cache/
:-/

We don't have any tests for it, unfortunately.

Alex

