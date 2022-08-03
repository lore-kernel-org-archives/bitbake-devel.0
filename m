Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42DC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 14:05:13 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.8908.1659535512267324456
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 07:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=V7eLlzlp;
 spf=pass (domain: gmail.com, ip: 209.85.221.41,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id z17so17017775wrq.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lI+NyS7DyN09q1MckvHUaj8ka9rNKvJJQGb4mv8RnZA=;
        b=V7eLlzlpxhhegJPoO1kZOOAO6fJY84VHb/cf5TCffBU0d7GcCS1nXfBa1wnVeFi/np
         wwFAyNbCCzAARbYrAidbzOerKewawEK1O3GQ3d2Dx01UvZOIiiylmYkpqbXdFSIzLZ7o
         74PZ2AnM41kHS0KG1jqC638shPoFliNdj8T6f+3z3IMx7BdH5E8/2gEKj0iLJf8luXsm
         VgvjO/pYXj4gb7j4V0tk3YmEDcSNrHh7sXzsDU1ylinxynP0e9ZbWvjTQEQxAc1FTgpB
         rFrxbp5tbhWYheYPxF6DKcI7ujRZqLujaWYHA22XR+Ze0WbsOWVrhk90Xi4wJinpVTVs
         ll2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=lI+NyS7DyN09q1MckvHUaj8ka9rNKvJJQGb4mv8RnZA=;
        b=RgoB/u6WeQonvfnMkQzYz+3/IchK63XM4uAPuaicwUpddtOTzS0yOlSB70fKW8UNkR
         6qpCp7ShnHufiGpAUsT5FhWCuGss4FxWcgbACeUk+T8iBvOUI+OIXWXQcN0nfXivb87U
         oOXT4rNndFSFISEWzMDJSHMB4wgMlg+1PONOxHScLdLxNb14+33LSmDK3gPCc4Ud/GSF
         k2M9Ex1kCiz91sGGL+8EJNtHdneEeCvzjCcD35pr+hOgS533THlJwTQOaFo2gHKl2EOE
         0TUrhWecIGdAhuVToedALWoXtnu20UTfmLJkDcxnepLWrPpQmm0n1dniBeud9Abw2ReU
         Zh1g==
X-Gm-Message-State: ACgBeo3Hn2577nXHml6Y5DrV/YSLAKU3QsmOjwIH9nGOa0uPo2RZeEy2
	9fxrqTsi1e7X5iq9dIxLKEGwZxYoJW8hoJq0iPY=
X-Google-Smtp-Source: 
 AA6agR7ML+Wxp4vTl9f9netZIigrJWsw6Sk93ir/846o0EL8d+n3yFz1BtjAcKG9sg2rIDYd10lKtxZCtkBEt0dWUxU=
X-Received: by 2002:adf:f851:0:b0:220:732b:2df2 with SMTP id
 d17-20020adff851000000b00220732b2df2mr4910163wrq.716.1659535510592; Wed, 03
 Aug 2022 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220801203418.57677-1-JPEWhacker@gmail.com>
 <20220802131405.318201-1-JPEWhacker@gmail.com>
 <29b6f80a-74e8-896c-d02a-cd584d50cfb3@prevas.dk>
 <a1e4c7e7-e048-e57a-976f-86584b2970fb@gmail.com>
In-Reply-To: <a1e4c7e7-e048-e57a-976f-86584b2970fb@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 3 Aug 2022 09:04:58 -0500
Message-ID: 
 <CAJdd5GazU_hfTojjeOd7uLxMDtBk77vWE=c52eO0xm36Zs-Rpg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] siggen: Fix sigtask data not being
 renamed atomically
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Aug 2022 14:05:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13868

On Wed, Aug 3, 2022 at 8:21 AM Joshua Watt <jpewhacker@gmail.com> wrote:
>
>
> On 8/3/22 06:40, Rasmus Villemoes wrote:
>
> On 02/08/2022 15.14, Joshua Watt via lists.openembedded.org wrote:
>
> Signature generation uses mkstemp() to get a file descriptor to a unique
> file and then write the signature into it, however it closed the file
> before doing the chmod() and rename() operations. Closing the file means
> that other mkstemp() could potentially open the same file and race with
> the chmod() and rename(), causing a error. While it may not sound like
> this would be very likely, glibc (at least) generates the filename for
> mkstemp() using the system clock, meaning that it is much more likely
> for highly parallel builds sharing sstate over NFS to encounter the race
> condition.
>
> To fix the problem, perform the chmod() and rename() while the file is
> still open, since this prevents other mkstemp() calls from being able to
> open the file (due to the O_EXCL flag).
>
> Eh, O_CREAT|O_EXCL should prevent opening an already existing file,
> whether somebody has it open or not, so I don't see how another
> mkstemp() could end up opening "our" file. Unless O_EXCL semantics are
> broken on NFS and only work by accident when the local client does have
> the file open - but what would then prevent other clients with,
> presumably, the exact same system time from clobbering our file, whether
> or not the chmod+rename is done with the fd still held?
>
> Yes, for some reason I had it my head that O_EXCL only affects open files=
; so I'm not sure. Maybe NFS is the culprit :/
>
> The patch is probably fine (as in, shouldn't make anything worse), but I
> think it would be nice to understand just what the problem actually is,
> and if this fixes it, how.
>
> Ya, we are definetely getting errors like:
>
>
> FileNotFoundError: [Errno 2] No such file or directory: '/mnt/releases/ss=
tate/99/sigtask.wq6gkrm7' -> '/mnt/releases/sstate/99/sstate:hdparm::9.48:r=
0::3:990d8b39c15752a2dd68369cb3609283_unpack.tgz.siginfo'
>
> With a backtrace to the os.rename() under heavy load. I don't understand =
how the chmod() can succeed and the rename fail unless there is a race. It'=
s very hard to diagnose what went wrong post-mortem.
>
> My other option was to manually add more entropy to the file names by pre=
pending some random characters after "sigtask", since the "randomeness" of =
mkstemp() isn't great all tasks use the same sigtask file prefix (which inc=
reases the likely hood of a collision).

Ok, after further investigation, I realized that our NFS server (which
I don't have any control over) is not Linux, so I have the sneaking
suspicion that it doesn't implement O_EXCL correctly, or perhaps not
correctly across multiple clients. In light of that, this patch isn't
going to do what I want anyway, and I've sent a new patch that
increases the entropy to mkstemp() so it's not time based which should
solve the problem in all cases

>
> Rasmus

