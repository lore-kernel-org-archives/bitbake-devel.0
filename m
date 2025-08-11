Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF1CA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:38:15 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.43421.1754901487722870581
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 01:38:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SmxFnFse;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70748a0e13dso30923266d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754901487; x=1755506287; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pNaX25jEYKq1J+hsX0KzUqqtbFVDN4u2uBqXnVnQHE=;
        b=SmxFnFseqOkgZAz0YGnH0MNGSx7S1I36f0ymE5mCQjV1VejX6eYIkf7Ip/QkwxAq3m
         I1Ct0OQ4Mn4tqKqBy3fbEvDIxpsXuk6XmA3wJjHPI5bLqHzNcK2CXDNMYd6S412515Fg
         6NHbhzBN1wGpsOhwpnrIIyOgojiE8dszsMjyeR9j/DIXcHujRalxcbFIe9aKp4khUitg
         CWTvAMHMyv1/eqw7uN3K1FLbdR/i1D+GDPSntCT6LWUoSWFFmkG7bnAjSb2Ao7KTAxT7
         KI3wtqsBN738NYdJFfUaBsL93uqGntX59MiF23zSAOhCn/BZfFtPqLVYms9+MaYWzqes
         FYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754901487; x=1755506287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pNaX25jEYKq1J+hsX0KzUqqtbFVDN4u2uBqXnVnQHE=;
        b=l4s2C+YyNKT0U47LQmB3P7MNqj+ajbFXVbq4Q5pN8XsxzLRIrgnNxFCtjURMgcfk7r
         +xL56vrklkxrk695Uh9zDw2v92zTh4JPaydvJujpAJPFihScozHRetEjDmN2lzRjIiJt
         GlGWk1LJIm1wlF6EmT0FSORD//7/MkjkZgOFhIZJoYkEyWSawcWi/N5FPIeeJcx/YzO2
         j0sHztrCMF4uJtvzmzws5/Ve0pTfp0g+3l5hus3kMPRkIct4iPH6QwdOll3w+bZQ7at5
         WsPFaV6l3eTg34wx56TaxJx1dg/cup3KzVj4UNFTB7N9Q8saoRUauv4Ku5SaKWQDrQcV
         zVWQ==
X-Gm-Message-State: AOJu0YxA7hqfbEjy4vD8vfcu0sO5BL77Nu9CZOKFThnMkc+zEs+5FDUq
	9ojbwCpVLxOpct/zxhpyUFBIoaKXB9IMQHi6ASOyvzYHJXnxBFte4aw8IwqiSx1n1IkPI7eeuZp
	AblZ5QLFQOzmRWim01xXC3C3wfRsfNmnJmg==
X-Gm-Gg: ASbGncs/jkxd1btMjlw/bqCVmYQwsVSQKDFjMUvg2BGFlkolldzIK9Qesa69vlEliXx
	3+Riis6Sgu6etcGIIJbqjjhEK30dnUik2ItvISi54IBbhBBZP9wtQocASGbnaHqb4Q2hCjeV7Pd
	ojVBCzIManL/U25m4dx3HJznZmU8t/tjAdk5i/kkkP51X4IAa5z51oC6eZc5Gwyh3vbywIR7EpT
	S61dvP4/wktuy7l5w==
X-Google-Smtp-Source: AGHT+IEWv0HYEBXHhnL8zYCooAqJ9VdmLwG0b1qi/KIAh0/OQ20wlGCUF3Qb9aLxRDdC5xKeNNRvQ9Cu59vuQOxrcVE=
X-Received: by 2002:ad4:5fce:0:b0:707:6302:90aa with SMTP id
 6a1803df08f44-7099a302186mr153896026d6.27.1754901486644; Mon, 11 Aug 2025
 01:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754898959.git.liezhi.yang@windriver.com>
 <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
 <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com>
 <cbc5cc61-9aac-424a-83a4-f0bc1c21d1d8@windriver.com> <CANNYZj8cUAhA+j5t9Lc0UPELpbG8nx3UmbLyUy_Axrv9-AY+Rw@mail.gmail.com>
 <9afc76ad-bb5a-4114-8f20-5571a8bcb85d@windriver.com>
In-Reply-To: <9afc76ad-bb5a-4114-8f20-5571a8bcb85d@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 11 Aug 2025 10:37:54 +0200
X-Gm-Features: Ac12FXzwjysEe5kBGIqVp3Niv60IXiAN17eIoe_mk9Ev2e9b128PtsmGI8b0_38
Message-ID: <CANNYZj8LPVJxW+nk1iRfa9uY-Mq4eTbat-5EfDsFL+coMwP1BA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: try_mirrors(): Skip invalid
 local url
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:38:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17859

On Mon, 11 Aug 2025 at 10:33, Robert Yang <liezhi.yang@windriver.com> wrote:
> > But why is it specific to file protocol then? If the item doesn't
> > exist on some remote server, there would be the same issue?
>
> Yes, they same issues to other protocols, but there isn't an easy way to check
> that for other protocols, so we have to let the code go on for other protocols.

So the goal of the patch is remove clutter from log.do_fetch, and
nothing else? This should be spelled out in the commit message, with
examples of logs before the change and after.

I also wonder if this should be inside try_mirror_url (or further
down), and not at the top level function. Otherwise other users of the
function will have the same issue.

Alex

