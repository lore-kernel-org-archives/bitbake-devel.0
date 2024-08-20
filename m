Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C80C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 14:07:41 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.20180.1724162853780459889
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Aug 2024 07:07:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DJRXtbeM;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53212e0aa92so6185652e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724162852; x=1724767652; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEtb6yNI7JAwc60BTrxltRbWgCZuMbSCJvaJ0k5qhnY=;
        b=DJRXtbeMAy4dHs2/G+bdI5FJNwJxIru51vFPWuf+wJF5tpbUOP8tOzBmnGixZl6Ppe
         xtmGEauGE0qr/4hurC7ZUux/5cTPbOSgweui5Cy2P2aL7woRtSxE1PCd0zGqBRKbXKRH
         xYQHSbamcRUKhXVmup/WTOeqBhgCr3swU8H6Ywm64VMgm7Ff+COQRA7QZl+F0deafKEn
         Hj9n+lWyDCQ0FxqIcm0NwF09AhnAFWZ37RbBSq/jlcCt660LVzjIwzcZzQeJVZ15rvId
         YN0uit+Pli5lNAov6v9BSFlbmd9KcHz11e9V0QVvFgcTmJHu8q6KNbmsNSxlphLSm99k
         LVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724162852; x=1724767652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEtb6yNI7JAwc60BTrxltRbWgCZuMbSCJvaJ0k5qhnY=;
        b=Yo3oCLZrTsU/pRjjIUncr8cybGn6RVq/Q+a2mbG0ObkFbVtDE1I6kVg5XZtqxRJfKo
         hHUFci12gwGcY74hRELs8NU12gJDiNCYM6L2xlHacWY2wUBxNaiBvjrAffAh6fkZIman
         7AF8vtgnrGWs14NhOdCMvN3LLSWbK8dq4YaPglWPWQyA5pDEQoy6LsuIEn5pn6f/g32T
         F8ULE1mMoAAlEcR1wroOzycGPzMyGfNqCWDflzTChCATKHFO6OOkNEbhgYDtQXliZSBs
         j5Lcli7pCGIVOWRqKcu8CVuIJq313XOnLnJSIMcz86OOCTTJKdRN7Ze1jfLmyZVN+Jba
         MEGw==
X-Gm-Message-State: AOJu0YwGgCI2001mGs1JxVEGYdnRV4P/BzPXZuS9oiiOMUdqu8n8s7fQ
	B/Zcorc4USe6Fk+8N47q2rtwZkg4UGb0ltv0A3zkOHzYCIfM5FsLzP5YegmFtq5qWc1En7fPCfL
	IM3dWoLU3O46mah+zyLHgsG8JjfA=
X-Google-Smtp-Source: AGHT+IFZhHoN0HwFMZOnkvpIyywgdq2fkL6Kms5WfV+JqXk/Qa9M2hE6sBx3DoyKFzaIj0rmmKx7QSFuTYckr6I7rrM=
X-Received: by 2002:a05:6512:31c4:b0:530:da96:a986 with SMTP id
 2adb3069b0e04-5331c6dc816mr9809423e87.47.1724162851475; Tue, 20 Aug 2024
 07:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <DM8PR12MB5430C4D4EA06B2AD975C00928B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5430C4D4EA06B2AD975C00928B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 20 Aug 2024 08:07:18 -0600
Message-ID: <CAJdd5GYK6tP5CRqq_g7FeEe6RpX_sa_1aX8_Kf9BB4tH04yVtw@mail.gmail.com>
Subject: Re: [bitbake-devel] Pickle vs. sqlite3 for cache?
To: chris.laplante@agilent.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 14:07:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16500

On Tue, Aug 20, 2024 at 7:57=E2=80=AFAM Chris Laplante via
lists.openembedded.org
<chris.laplante=3Dagilent.com@lists.openembedded.org> wrote:
>
> Hi all,
>
>
>
> Apologies if this discussion has already happened (I searched the archive=
s but couldn=E2=80=99t find anything), but I had a thought the other day. I=
 wonder if the decision to use =E2=80=98pickle=E2=80=99 for bb_cache.dat st=
ill makes sense? BitBake performance has certainly been getting better over=
 the years I=E2=80=99ve used it, however it still seems to spend an inordin=
ate amount of time loading gigantic pickled data into memory. I wonder if i=
t is time to dump pickle and consider sqlite3 instead?

It's an interesting idea. Is the concept that instead of having to
load the entire cache into memory at once you would basically amortize
the lookup over time by querying for what you need when it's actually
required? I'm wondering how much of the bb_cache.dat is used for any
given invocation of bitbake. If the entire cache is going to be
queried anyway, it seems unlikely this would be better performing,
since a sqlite query is likely going to be a much more expensive
operation (per lookup) than loading in a pickle as data that Python
can natively access. If the percentage of data needed from the
bb_cache.dat is low, I could see that as a win though.

As with many things, careful profiling would be needed to tell if it's
actually a win.

>
>
>
> Just wanted to get the discussion started, since there=E2=80=99s a chance=
 there is some detail(s) I missed that will stop this idea cold :(.

I'm not aware of that being discussed before.

>
>
>
> Thanks,
>
> Chris
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16499): https://lists.openembedded.org/g/bitbake-deve=
l/message/16499
> Mute This Topic: https://lists.openembedded.org/mt/108000847/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

