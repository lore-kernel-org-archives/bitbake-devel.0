Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A425CCD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 13:50:20 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28994.1780321817821854022
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 06:50:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JzRC5+eM;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5174a1f2d45so7349001cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 06:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780321817; cv=none;
        d=google.com; s=arc-20240605;
        b=MofQgymBw0M+FEPbMOtf9Vt3HCQt7PEVoybF2sluy9TrExZbgFylnhnBTPgnVeBSW7
         Uh3cRpCByffnOLeNa10iGD/iApLxJweI2t3i3tjnhhgKL+tFf2YwoptfuqtYCMXPGjiP
         +Cs6XCUqebiKxQ/Z4Fa7D+IzfJHKxpgMFEZZ2ajoUIgS6B4Dq00wyZ7/KeReLIH2GGxf
         ROkMoycLW2UUj1QfjPIapyaG/wUHTltKvXpz0LXu2dgX3sJ26JR/duN0KxbYQdzXO2VI
         /7fqGZn29OzpJyOlOgTK8M8vv/l1Ra3SZvvBOtIn0QLuQEpLZ9zqCiLmrzmR322xdUmn
         pBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EaqdfggLgajFTdZN0uRkOuUPLhtA3ZUFAHAhEQ57p9s=;
        fh=84xj9XDuYLF0wLQ0yAEsw/oXHkMBlnfXtSMQO8blqMw=;
        b=GgLiKQUysS5hMa3jYYZFD9Gcovz+tr36YKBkiZFTNE07vSMqgTCC3z/P2VMnak5u4V
         bhHaAGBckQHQq1gJ46Rb9z88lYpN4i5+MJqK0BFaUe6st1qUAHG6wrWx/9iyVISgshtz
         Y5vahmbVkMsCHtTZaSvLdHrqy1owmlE3nR8cV1HJBVqotdFQtVmTDEP8xDuKQ+UxTDH8
         S16YlnnyBWn2E6YyyLEO0b+9niX8vF2q+QmgukJP2Es9EgVXyIIS9S3aaWEs4/o+EnrZ
         0tXrhW4Qsp22WtecHkT9nqyFryDVpG8K+fLWIGukUl2l/bsD3DEaJPO9rTUR/vCWgAXz
         pWXg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321817; x=1780926617; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EaqdfggLgajFTdZN0uRkOuUPLhtA3ZUFAHAhEQ57p9s=;
        b=JzRC5+eMW8bacEbZCJOtyjD737ruUB0+BshxLkUK4ZwGHGzgJPGVtAM0Y4WaMqkppd
         AudgUOJ8l4PJYtpPpD9GpPIIgQ286mT8MRoKj6MEYjPljJ1c5kUj0XBm1/ooX5svgULK
         Q3/jVb7OeQObwYKXmBDJEWLtONOz8HKRtbAFtEVSDxRoVoVxU6UMfZZ8IKtTPjRJoXCO
         xs8jgvmoVRFAjSunUFpF5r+7PVw9keXqXn5hnRMoN8m+T1nOll6WA4R5btVWfTra06ty
         OcpPs8QJBafUl71VngmY26t8w0CkJO3xPaaUKFXFWU7tBcI5FJQO9iJcIjsJctAc6gb/
         bQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321817; x=1780926617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaqdfggLgajFTdZN0uRkOuUPLhtA3ZUFAHAhEQ57p9s=;
        b=gOiyCTAo0d18iOpoU4X/br8tQDWr3vP7t9fRaniHKwRmw3yB742/vM3VMiPTVFf+fI
         GlhDjbLMysgkD6GG2WrLxKwJhm1LzJhJDz23n7cDIKCYakGKPZsnC34bB1sD/cfJunEl
         DilUUOJ3Kuirav2T/bXxUaOLY3tmm5n9rZG2zSNbd5v7fTz9/yeXK6zy4uHCo7br1C6W
         LB9o5YI0fqSthIBvqqztRmfdz/zxgybnshCcxvryZ87gW2l9Qru6wZfOliJZJaRYK/4+
         Iq/xrLqgTNBQ8I4qp+BBi/HU0f38UOX4ErisK4vRJq1T6G7NluaaiddLKQ1uG2b+dun+
         Jp9g==
X-Gm-Message-State: AOJu0YxOOc5ItDi1/hQhwLy+lrP6Q4slL0pyZfQ5Xrj789O8gilmerGj
	K+m6ZF56v6sUp4mN/dAW2TuBalJWsTaMgv//zic5Jq9EWM3Ko3KQoT86HtyIiyKrP51TF1W4c9e
	r5nlcuTnl1ZgzzJU33Kbj9KrRFG9xkcI=
X-Gm-Gg: Acq92OFhYSeRxHJLnEr4HkBRQ9Zx4QmHcKjEHGPL1btK14eTOCoCYSVc5G3iwlA1MQB
	I9p08zZI7lBl2dYKVIcIeGY5gb255MyopEOtjcAqa4yVWhCPR0QpKcpasvyK/5/8xf4scJzW7WX
	YwA9B+T7dIFH+n1ZCHJDa3VeOXK4+t4VWMjptGDvq9gMpq+vGPeiZ5HHoQyysX32JZ46qeeJGk6
	C5sStaw3aEW6dvMcfsvOy96UTpkjEzH8LkdEKMoPOKhV1kOAlqCvb+1VohLLF5wJUY2gfYzjFB8
	JeJEcVX81csGw4jxhlNw0VAf7tm5AkMvd4ZqthV+7nztA0s4p6muPCRVTCS/TuI=
X-Received: by 2002:a05:622a:1f16:b0:516:d64a:e67b with SMTP id
 d75a77b69052e-5173a82fe33mr153850621cf.40.1780321816743; Mon, 01 Jun 2026
 06:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
 <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com> <o2tur4mf7vfsmx2qkizqhhxjnz34vifjtxeschtjvueskuzrcy@5hmfaoevpek6>
In-Reply-To: <o2tur4mf7vfsmx2qkizqhhxjnz34vifjtxeschtjvueskuzrcy@5hmfaoevpek6>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 1 Jun 2026 15:50:05 +0200
X-Gm-Features: AVHnY4Li8PheL8nDJ10wOQE209Kfvb0B-Zb6eAwSRXgVUlCataD32rc_nvYXKUI
Message-ID: <CANNYZj-ajQ_2LJnTHMvC82JjtNxLRMPKEJO1ez_Paj6vb9NBdA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: support multiple
 source override files
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 13:50:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19586

On Mon, 1 Jun 2026 at 14:43, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
> I arrived at this from a real use case. Admittedly, that might now be
> semi-artifical if we don't want the other default-source-overrides
> patch.
>
> My setup idea was to have all sources move, then use a fixed revisions
> override to create a "release" setup at known pins, and then apply
> another override on top of that one to create an "integration" setup for
> CI where most sources are at known pins, but some repos are at latest.
>
> By overriding again, it prevents needing to maintain a "release" and
> "integration" sources override files, that are mostly duplication of
> each other.

But why can't 'release' be a full json config? If that leads to
multiple duplicated configs for each release, then we should pursue
the 'souces-one-of' idea to have multiple source sets in configs.

> You're right that this can easily be managed with other tools, the small
> risk I see is that lots of custom solutions start growing around
> bitbake-setup, but with your feedback on the other patch I also see less
> value in this one.
>
> In short, the expectation here is that people use their own tooling to
> manage the .conf.json and source overrides .json files? If so I'll send
> a patch later to remove the multiple --source-overrides option from the
> docs.

Overiddes are meant as something local and throw-away, and not
something that is ever checked into a public git repo or otherwise
shared. They're not self-describing for example, if you look at the
content, there's no way to tell what is it for. Allowing multiple
overrides that are overlaid on top of each other also makes it more
difficult to tell what would be the final result, it's hard enough to
figure how bitbake variables get their final values, and we don't need
to repeat that :)

So if a certain set of sources is reused between many builds, it
should really be in a config. Bitbake-setup could help with that, e.g.
'take this override and add it to this config' command.

Alex

