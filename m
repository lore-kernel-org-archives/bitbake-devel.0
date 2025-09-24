Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F852CAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 11:11:17 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.10079.1758712276035000299
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 04:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SYbrybt/;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-856328df6e1so84267485a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758712275; x=1759317075; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xgyyItGWW/SC6Lyh2UAROmIZNkrLp3W1m3fTh9sscO4=;
        b=SYbrybt/5UqaTXYUX2uvDKeehOfgHTFQKqByyjfWm4lhz5VDtSUwtYya7rzbUVO1Uw
         svurM4zkHrSVyIaPA/9NZtCzizvrUz0a5Egg4TZdgArqHsL9YCZKLxE8OpGos8v/Onsa
         Krb9+I7ODhOQE84vt+jElc3YUB9aP9qUf8p7NLS09yLTigr1a27cIlRkyIia1aXY9/wz
         +xRxd733VIz1h/FAZJYk+ekqAF4tF/pvpvDu8+Pa6iqXO/+c1sYsE+jYEXugKnA9ZAyW
         ezGZRCartYyVcFQ5gvykco4DPoV/O6lBAk6PItQKOtMmB6Iau729rhqWtSWp6tUewOPI
         5BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712275; x=1759317075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgyyItGWW/SC6Lyh2UAROmIZNkrLp3W1m3fTh9sscO4=;
        b=m8CFWjFxq61PvqULQgstwRDpcct2TRlmmAfyTEUmRpOgRq58NbH1+gFWoUgs6SjKrX
         SlWyWcn0OK6CvfE1LuxMUh1rJvMhZSez6MDlNhgNzn42CDtVhFWD8BYgqrSS1Dppf2sa
         1Yc9fPzvGP7LsCNSFMgVKSN0uXSH0D2IA08mCmM4HZZTbVzE8XYWJ9SFYT3qJ6eRwzm+
         /ksNsuWWHo4UQcoEUOmFIbDu9ujDVnfMr9RZ4E+qwN2UMRcTZvbVvvc1mxw0VmSaxG3s
         OO+bOyrX4F7c3p0l/V49KXT00qPBs8yDqQ28Bx4DYWZCc3+VNUbBDnrZB0+yRK9u44gS
         nw7A==
X-Gm-Message-State: AOJu0Yy6XdFtm9p9ZJwphlbQMrygJ7sj4ZJftVQ8KmkLR7eovD9nzPu2
	9gHgW7k5ZL2uZKt2x40VTnitBpXeGj/PENzrEY7dgP5htJ2gj85sNcSPMK8C8jYbeNJWLXT/Mb7
	zZ31Gr+XbqGWMOW+Gj9tsHD294J3wnwQ=
X-Gm-Gg: ASbGncsXSalaOmldh74XQEcs8kMPW01bhfFAV86civUbfeND6ur3vRdAlnTtBfzI7Fp
	ukmZoSGdlqvDyba7i3fR2XCk+KDmmlRlxsFjDzjvbvjU34HJXDgUywBv7wbhJ8LwM2F8lPa7xs1
	w5jqg4UlKK/803JzBdx6IRUDuWA/YbWJ+70AgN6rEwBqTjRCdoghoR5mhue/m1NUMxZObjcQB9i
	MNjxghs/WSIEysaELHaeWc262vbQPro3MFCtKaNabdwfD9EhxyAWhIRmI637OlR8x7GIwx6Kl4d
	OWbVlSyyMhK6+kTogM1gSEp6LbDS39nUv7UCefyfFi2mQszp8Z8=
X-Google-Smtp-Source: AGHT+IHOTsMuvuJlgOfREhGFWkxaobRtJPsGiaLgvQtfAndmRz0IghnwuUUPAfB3cHqUWNoziQbUj6tgydK5NTr+hHk=
X-Received: by 2002:a05:6214:5199:b0:794:463c:6d26 with SMTP id
 6a1803df08f44-7e718ddb7c7mr60823586d6.60.1758712274860; Wed, 24 Sep 2025
 04:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <18683160554EF259.24570@lists.openembedded.org>
 <CANPvuRk2n7t9YHThXATOT+zD9DYrzV36rU4r+Ku50Wy9y9Q=7g@mail.gmail.com>
 <CANNYZj9om4Ki1X9+91uDaf8WoR1z7USnbG++9qUmp-wUELai1Q@mail.gmail.com> <CANPvuRkpq1M_AEs7J5+pvo6F1SR8srEiPV=SZVGM4knqLD5OJQ@mail.gmail.com>
In-Reply-To: <CANPvuRkpq1M_AEs7J5+pvo6F1SR8srEiPV=SZVGM4knqLD5OJQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 24 Sep 2025 13:11:03 +0200
X-Gm-Features: AS18NWAdYC3Rw5bqiAdXfyRtCk1NTlHVEZm0ZrdC2jUCxB5ntphco743TYy2rDM
Message-ID: <CANNYZj85dxnKQKQsSjqtF5dsmLzUCW5uAmK6AZgcn2v=mzhy8A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] cooker: add support for more than one
 server in BB_HASHSERVE_UPSTREAM
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 11:11:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18087

On Wed, 24 Sept 2025 at 13:06, Jose Quaresma <quaresma.jose@gmail.com> wrote:
>> > BB_HASHSERVE_UPSTREAM = "wss://hashserv.yoctoproject.org/ws hashserv.yoctoproject.org:8686"
>>
>> I'd like Joshua and Michael to comment on this ^^^
>> Specifically, are there performance implications in using one or the
>> other? Are both officially supported and maintained?
>
>
> AFAIK the two are still supported because kirkstone only supports the raw sockets.
> We will still prefer the first one and fallback only on hosts that don't have the python-websockets
> I think with time they will become available widely and we can also add it as a mandatory dependency of bitbake.

The problem is that once you have the fallback, no one will bother to
install websockets, and they will not become available widely. I'd
rather adjust bitbake/yocto dependency lists in yocto manuals,
together with all other bitbake-setup tweaks.

Alex

