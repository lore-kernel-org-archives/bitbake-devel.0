Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7CAC4706F
	for <webhook@archiver.kernel.org>; Sun, 31 Dec 2023 09:40:42 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.217308.1704015633525132229
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Dec 2023 01:40:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XfngVgyj;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: alex.kiernan@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7af5f618so5276154e87.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704015631; x=1704620431; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c/aCP0lUvIj29RmugCycw+wHw7+PLJIdGTwK8dkJuk=;
        b=XfngVgyjMYTUo+DlPuDig1WH3ou599Zhe1r2SpJCx0wR6gmOQ5KFVjyC12W00Ewoe5
         Wh5EdYu/Lw0TOXkm7uYcZyqubVAKvcgBbk2fNUj0aVmPHLo01EGQhh9199BSveVOlimX
         dA2pgyr3gIKjvmZCKa/+ImZP81YXoGS8iredVoFEcMCyfJYX+/2olIOk7UjEp6bA8y5F
         5c/tCP/FLiVLIMWtMUCY3xVnXf7GYCJv603FEOQgnFGqmisOWYdaqs3byWmE0WFQlYpb
         5rDPLzuI4kcDwFdqL6tjSchv1z68nBRp9A2cxStjCgsYfrJ3ZT3ACMW4INY1tPMurijP
         XCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015631; x=1704620431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c/aCP0lUvIj29RmugCycw+wHw7+PLJIdGTwK8dkJuk=;
        b=BaeoioYqwFNGReepskgaPuxgrBsN0n2mn+01cFLGpjsXwwVJKpCsFExay8tX5MZiGs
         2wIusCXsiwpVGqEYY8mcZhPj8y0eejGfpNrWSulw/yYJ1iCLqg5vF/WcWnrOnjS1O2Zy
         2npygQsXqW4K9+SJ+8n7xyK3V299bV2Hyy0ISP8rLBpcKTW15m5uEsFyX0zmbfQELzLm
         Bt0xHs5k2MhS397n5I2zax/WMGiSddT3dJaMV9gK1ihBy5MrhY/UNu8LyrTEJUf6GLgq
         uxtcGfwxc6WSY9ZHMp+ZTj8O6iuoQgwo67pQc9h3QRPV6bIg7kyrAgrYw3TZ8q8XAMt9
         PXGQ==
X-Gm-Message-State: AOJu0YxqV1C5zLwTOUBublNJ8CgoE9666Kq4su/aZuzDfIm8eqPRkbIz
	yOJGE6VBKnaxuW1eW4ydN8g7y/4j+AKv8QYDT5M=
X-Google-Smtp-Source: AGHT+IGhNkIJhqnxM/1h6QlNViOzjAeEHV4BRbP8jn7bTE7ozh33Y0NNZk3YhXEimjJtsTqlsDVzSvCFv3R9vKzorpA=
X-Received: by 2002:a05:6512:ba7:b0:50e:7be3:d325 with SMTP id
 b39-20020a0565120ba700b0050e7be3d325mr5291189lfv.86.1704015631279; Sun, 31
 Dec 2023 01:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20231230154843.8086-1-alex.kiernan@gmail.com> <74ea71abd4a3fa563dad559af79bccb360706d96.camel@linuxfoundation.org>
In-Reply-To: <74ea71abd4a3fa563dad559af79bccb360706d96.camel@linuxfoundation.org>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Sun, 31 Dec 2023 09:40:19 +0000
Message-ID: <CAO5Uq5QB+cfPxX+9Ddk07uHDFTJ3be9EAHRdXb397x68sLmRXg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2/crate: Unpack into CARGO_VENDORING_DIRECTORY
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 09:40:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15732

On Sat, Dec 30, 2023 at 11:50=E2=80=AFPM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Sat, 2023-12-30 at 15:48 +0000, Alex Kiernan wrote:
> > The vendor directory is set in cargo_common, to work with rust 1.75.0 w=
e
> > need to change the location, so use CARGO_VENDORING_DIRECTORY here.
> > Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
> > ---
> > Is this change allowed, or am I coupling repos in a bad way and should
> > hardcode `registry/src` (which is what I need it to be) here instead?
>
> We really need to find a better way. Bitbake isn't supposed to have
> "knowledge" of OE-Core outside the key variables it expects from
> bitbake.conf. CARGO* from class files aren't included in that.
>
> What we probably should do is set this in bitbake in the fetcher and
> then read the value in OE-Core.
>

Thanks, that makes sense. In fact if we can move the generation of the
cargo vendor fragment into the fetcher then I think we isolate the
details of our implementation in one place; I'll see if that works.

--=20
Alex Kiernan

