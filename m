Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0898CA0EE4
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 10:33:59 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.8767.1755254030369332565
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Aug 2025 03:33:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UzjncItU;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70ba7aa1300so2488706d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Aug 2025 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755254029; x=1755858829; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kG4gBL4cDGGaYlTV2sFy26jVDeuFoCBF21szSaqU/Po=;
        b=UzjncItUujDYUZVLhZMI++W5VipdsIwhMNxqRgZfPR5njIBsy5VrCrBxuQJtuuO2EZ
         ASkgGf0jruTGlvrtbPFG/wf3zVmwN3Pq5Now7Th5lLdFSWJH0F7Qjl9RFUL1ibVO8/yB
         B29OF6z2ol1WnylGdhZMwXysAyJWScSdFfMQPeKuA/RjNlk2HuCVhVCnOlibXVVYkuUp
         Pij3TQhTcyTERcDc7kfxJZoKpdkWn2W48/cCjGkjikCKziy4BwIpFyR0LeqUpECeNmAE
         BI6q7uen5Sqzn3mV0mRV1IbQ5+GSRYGLWXqFvYNvcnNJCEytAV8drYhS8zt4T5yi3Roa
         2DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254029; x=1755858829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kG4gBL4cDGGaYlTV2sFy26jVDeuFoCBF21szSaqU/Po=;
        b=pN4XpdCz1lizWMUqMbpMBC311ncDyQ6Td3zwM9V8dK7sLvi/sbKevZUlrVAxYE2pRe
         qKSxJ7r8vW3yFhUWMfg2dRzmSVOqtq18HZ4UIDZtpolbOIE1WAGefkcyOfrRCubVeLlx
         Wfwg7A6WQegVYrMihRlFiWNjo4UDZBggWa86OYqZpKUgAXHhsTE/dK7JgdVieV1vehqA
         YBmicrqgivVny1RU7f2VcyI51ueoqvJuOLKW03dqgVbL+EC9PSc2Vom2a8vd8ktJWlVN
         5G0UBPFPbbeB+Zza2JSwWg3EatFwZvNVi6iFhLfkj3KJQZkOvJXcmJuMdgv7LRhXtJWq
         odOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxAeklCnPVQeuEPSiPjkjXT7rIGEjX/upRW0K0bG77YQzgrQ5bcF5SyXoXZ/y3xVjfaamlyWIHDRcz8bOO@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw4LO4iKVfCEz8I3Ps9MIz+YFzP+TiG8JV0wvgGzP8Sb8gUSHOK
	LIUvrQEmsUb99EFZabNd40DVEufbENRIswXWUd17fqhJDLmy2Es3p7TdO8q4uHclnmIj2tt8RVS
	jXO7rmwlGcIEICM9/TB4xpP4skq003yM=
X-Gm-Gg: ASbGncvcZz7wDzi0vX8Wxm6j4M7BcKmmAvjXUeKuz+ylX3opNyowfCeYU8mtuVX2wEj
	st65GuXG6QzeZv8gsyRaX9F+hQhsgECuYWSX1Ti7lEdDjFMdAx/Y/izsvtpkJgbdkmQS0U/dzbr
	SLkL4joiMXlmbAoxvvxYGae+5ibmEpttBtsFMtcXROgOUykqg9YDf97RH/KvCpxVmtcPRguo4GZ
	xZHA++R21rEalStZYcHJdNx3KjyJ4VSfQwXQw==
X-Google-Smtp-Source: AGHT+IEC8i/L5eVR4ZH9or/GvLRcCqX/eVZCIyQ12pp1cV5h3gk4afNQUTjHRwWo9a6Q8GbuvMeOI8auPb32zkLywfE=
X-Received: by 2002:a05:6214:d63:b0:709:8665:f839 with SMTP id
 6a1803df08f44-70ba7c4cce8mr13506686d6.43.1755254029182; Fri, 15 Aug 2025
 03:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
 <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net> <CANNYZj_7MebKw3iKvgRdKkpQvBW4a+4kdP8QZX_yWoY3DxN6TA@mail.gmail.com>
 <CAJdd5GZXsmby-n5XRX+U1-Hg66xricNt_oyAz0CG9mY89U+3Xg@mail.gmail.com>
In-Reply-To: <CAJdd5GZXsmby-n5XRX+U1-Hg66xricNt_oyAz0CG9mY89U+3Xg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 15 Aug 2025 12:33:38 +0200
X-Gm-Features: Ac12FXxn314G_-XsDhaDbTAJiWGjjpCdQZc85Do8eFwKvS4CTNzflS2-6jhnzUs
Message-ID: <CANNYZj8a49ecyJeSkstZXU7khM4ppt5i7FoaoRqBQTO9Mgx08A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Chuck Wolber <chuck@wolber.net>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Aug 2025 10:33:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17875

On Mon, 11 Aug 2025 at 17:49, Joshua Watt <jpewhacker@gmail.com> wrote:

> Hopefully that accurately outlines our struggle here and why we would like this feature.

Thanks for the detailed write-up Joshua. Given what RP said in this
thread after this email appeared, I'd like to abstain from further
commenting.

Alex

