Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EE3C10F1A
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 15:03:03 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.20941.1713884580383449903
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 08:03:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M10nWUX4;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5196c755e82so8135945e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884578; x=1714489378; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fbqyLN3FC4B47BlRt4LTu4MAmUt1glWIPUAqipDmIw=;
        b=M10nWUX4PMy/9Oi/NB/uSI1Z/VtArRDCGK248BqWUHSQqmWXlY8tG3AvTe8yodiK3Q
         oI8qNcwyFl3dlrGN3Rw9rWOIWogNuonEIDxAxkwvqZHTLxGx9nsTo2bnLOn8YJ98TklP
         d/P60ibg+PPzlD52lMq90T3974P4vcWSAg6xsWu9z3efpLvaNNuqPsYE1VyYDb4nLCQq
         8JZpzIiysh6xSva7iMOuWxootFK+l8ROU5zUzXOEHEeGnJdlbTN/MMCFEg60pkxos00j
         5Acuc0YJr1Ih9NpyTGCJGX1RGJp6qF4OMlFRGenhCQ6uH0d7zFs5QLQrSotS6EeX+87m
         oFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884578; x=1714489378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fbqyLN3FC4B47BlRt4LTu4MAmUt1glWIPUAqipDmIw=;
        b=JHmEkVp79Y8cbRzOM9Mf6nLEjhwmtTNZbe9q5pcvm1nd37I6XLNDhGHhtuIXaoPzGh
         azI1cg1DwCZ/+/25a0M8FnDnicVfzgukQZmB9vHz7ypGPWXiZrvdl+OSvBEzNartKF/R
         dWSObWxQhzxHClmNh/9oy5bGaO8YS235PHF1qck10UoV77a6DBgzgg9VQjeNnh1AQK/n
         HbO64YsofPmiV4I//1xCc1EvTKicLpHjK4z4PZQy1FebAzlBzGlPzeIwlKhhkvdj9ff8
         pgsApgpytw6kAgF2BVHnhTpgSuL6LcmRGyYW+7Um9s3ErrNDxGZcFLGkvUZQcvdJPw+X
         KGNw==
X-Gm-Message-State: AOJu0YwtzWt+2908cM5tw8VDjuSA7w7l/teV686EFY8kHt8IxDw/0xLe
	bXidHvSo2GGfjiMgGRLoa/NF+Dqrv7NEIsiFI4jkNEDimMB/LUd1YZI9dvDIXBLYANQ4kgXnZYv
	MKUVjWEFXy6CeHIV7rnwcDwj7Dqs=
X-Google-Smtp-Source: AGHT+IE8Mt1HTNgKkzFR2rqu8ki6F1aYXZYa1xeRwneHGbi9lroKY5RAHP1cDTkUo42/MlF7Al0t7yTezHR1d6tUqE8=
X-Received: by 2002:a05:6512:4d0:b0:516:c7c2:23b6 with SMTP id
 w16-20020a05651204d000b00516c7c223b6mr7722432lfq.9.1713884578220; Tue, 23 Apr
 2024 08:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
 <20240416171945.3799445-3-michael.opdenacker@bootlin.com> <CAJdd5GaYY4+jp34H+_BJ2gACA0eg5nog34JdDfy9nnhKVJRkGg@mail.gmail.com>
 <9bf63d8d-2750-4ee2-ad3d-67fbb029d61c@bootlin.com>
In-Reply-To: <9bf63d8d-2750-4ee2-ad3d-67fbb029d61c@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 23 Apr 2024 09:02:44 -0600
Message-ID: <CAJdd5GYAu=Vsx=o0kncNZLnuQu4cxhe8uN4BTmk_iiToQGKBDQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] prserv: add "history" argument to "get-pr" request
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tim Orling <ticotimo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 15:03:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16134

On Tue, Apr 23, 2024 at 6:26=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Joshua
>
> On 4/20/24 at 22:45, Joshua Watt wrote:
> > On Tue, Apr 16, 2024 at 12:20=E2=80=AFPM <michael.opdenacker@bootlin.co=
m> wrote:
> >> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> >>
> >> This makes it possible to test the "history" mode in the
> >> future bitbake selftests, to make sure that both "history"
> >> and "no history" modes work as expected.
> > Is this useful in normal day-to-day usage? I don't generally like to
> > add functionality just for testing if it can be helped, as the closer
> > you can get to actual end user API calls, the better it covers the end
> > user experience.
> >
> > It looks like PRData has an (unused) argument to enable history mode?
> > If this is unused do we even actually care about it at all? Maybe it
> > would be better to remove an unused feature than try to test it?
>
> One version of my series actually removed that feature, but then Richard
> asked me to keep the code, because of the usefulness of the "history"
> mode for binary reproducibility. This way, we always generate the same
> package and revision if we have the same output hash as in a prior
> build. That's different from the default behavior that increases the
> revision every time we have a new output hash.

Ah, that's a different story. API used by end users (but not by
bitbake during normal execution) is fine, and a different story than
API added just for testing :)

>
> This being said, supporting both modes added substantial complexity to
> the code, and I wish I had more time to consolidate all this and reduce
> as much redundancy as possible between modes.
>
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

