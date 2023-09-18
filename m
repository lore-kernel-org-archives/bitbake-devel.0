Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722DCD37B0
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 10:54:34 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.48281.1695034473253655278
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 03:54:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BP+NwjJJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-401ec23be82so46490105e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695034472; x=1695639272; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=03v2M4eYBVC4yvrvfowI6Qayi+R9OSiLnKC8TVRyyjA=;
        b=BP+NwjJJ93qrHZbfYIfGEScXCu2TF2ls/42MHiujyLvPieU5MnT8RXE67IAzf4HWoS
         wt94fby5nrS4QZ9ajq6dXhMli5SgvQ3mC41i38jZUabHbyuMCX2zsS8JAZ8kbXJeo3ZV
         SZxUooCwrg4+HnRqQKWq+Z2DoEc3u2QyhyXGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034472; x=1695639272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03v2M4eYBVC4yvrvfowI6Qayi+R9OSiLnKC8TVRyyjA=;
        b=FUX1xtgR6bphgnpuTQiGhdg+Gmp0cEEQ6q2dYsQRhatNLrRWM4IbET50sH8hrHYDo3
         vXKZw33M6RcSf1EatZ8+K7PTzmESt7WfL9K79ldwPhipaf0M03ROuz8LS9ozDHvqnXd0
         JNQyMjUxuz/yYoKVhbLgpJV15HOA31UbZRbx0mXtfV0/o6xEK+Fwre0XiKoyF7WtJXbw
         zOTg0n9H24YPsvOdamw/3E1RhgK1FjYrJ1RUUpMBqBKzhsdx8hwD1MMlqljl1aYrbhDT
         de8C+egLkd1OZTrz1IRW3+lTxXt+cHDkE0Uy7ielOqWxe9cp/uFxAl4teDMGq33GpGbC
         ITTw==
X-Gm-Message-State: AOJu0YxNLyiGV6jsc/bDf1cTl9G+NfW5sBceYhFtq0XrFidPSCwGp8dV
	4KiZDSh0km1U4PMC8eM9Niu0jg==
X-Google-Smtp-Source: AGHT+IEzoqa0H2mvB1yvg7p6EqcMcAu4NHXE9qJDxpm8ySwYxYVMPiNz6WkU2HwCvd4Mjsn3VhjlNw==
X-Received: by 2002:a7b:cb99:0:b0:3fd:30f7:2be1 with SMTP id m25-20020a7bcb99000000b003fd30f72be1mr6624064wmi.39.1695034471630;
        Mon, 18 Sep 2023 03:54:31 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c207:9dee:97a6:8348? ([2001:8b0:aba:5f3c:c207:9dee:97a6:8348])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003fe23b10fdfsm14958089wmj.36.2023.09.18.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:54:31 -0700 (PDT)
Message-ID: <e0b05980a3bf12dbad6195917e74787b1f3000fa.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] [bitbake-devel] [PATCH]
 server/process: Disable the flush() call in server logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: Philip Balister <philip@opensdr.com>
Date: Mon, 18 Sep 2023 11:54:30 +0100
In-Reply-To: <1785A70B83E3810A.9824@lists.openembedded.org>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
	 <49c3f81299d8153f31b09cfd226cb183097e6c8f.camel@linuxfoundation.org>
	 <DB5PR02MB10213747F1C3061D3EC8C116FEFF6A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <178518DC5E1190FF.14273@lists.openembedded.org>
	 <17852E9ECB514263.22721@lists.openembedded.org>
	 <1785A70B83E3810A.9824@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 10:54:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15080

On Sun, 2023-09-17 at 10:54 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Fri, 2023-09-15 at 22:08 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > Just to follow up with where I got to with this.
> >=20
> > The problem is that inotify isn't delivering change notifications in a
> > timely fashion.
> >=20
> > With the patch applied and BB_SERVER_TIMEOUT =3D "60", you can show an
> > issue with something like:
> >=20
> > rm bitbake-cookerdaemon.log
> > bitbake-layers add-layer ../meta-virtualization/
> > bitbake-layers add-layer ../meta-openembedded/meta-oe/
> > bitbake -m
> >=20
> > where the second add-layer fails with the same error as the first with
> > a message missing meta-virt dependencies. It doesn't notice
> > bblayers.conf has changed and hence doesn't re-parse the base
> > configuration. I've locally proven this is due to the inotify events
> > not arriving until after the parsing commands.
> >=20
> > os.sync() isn't enough to flush the inotify backlog. os.system("sync")
> > does but that may be the fork overhead. sys.stdout.flush() does too,
> > probably as side effects in the kernel IO workings.
> >=20
> > This basically brings me to the conclusion that it is hard to know when
> > the inotify events are in sync with the incoming command stream and the
> > current approach is flawed.
> >=20
> > I'm starting to think that we should drop inotify and go back to stat
> > calls and maybe require that UIs send "re-scan cache" events so we can
> > avoid the scanning when we don't need to. The client code does have a
> > pretty good idea of when it changes metadata, it just doesn't share
> > that at the moment. We can rescan at reconnection so it would just
> > affect tinfoil usecases.
>=20
> There are patches in master-next which replace inotify usage with
> stat() calls and mtime comparisons.
>=20
> For "bitbake" commands, I've made it revalidate the cache upon new
> commands so that part is relatively easy/safe.
>=20
> The tricky part is that we'd now require tinfoil usage to explicitly
> say when the client has modified metadata (or run all the stat calls
> between every tinfoil command which would have crazy overhead).
>=20
> This means we need to audit the tinfoil command usage to markup the
> places where it changes files and expects bitbake to notice.
>=20
> In master-next, I did audit bitbake-layers and recipetool but not
> devtool. I've run an autobuilder build just to get an idea of how close
> this gets us to a solution. Unsurprisingly devtool is exploding there
> but other areas look more promising.
>=20
> Ultimately we need to make a few more invasive changes to the way we
> control the server from the UI and be a bit more explicit about the
> command flow but that should wait until after release.

Final follow up to this. After some testing and sanity checking
my=C2=A0change with others I've merged a patch removing inotify usage in
bitbake. This then allowed the flush removal to merge too.

There are further things we should really fix but those are less urgent
and this removes the problems identified. It should hopefully help some
of the AB-INT bugs.

Anyone with custom tinfoil usage where they modify files will need to
add a function call but I doubt there are too many people doing that
(bitbake-layers, devtool and recipetool did).

Cheers,

Richard


