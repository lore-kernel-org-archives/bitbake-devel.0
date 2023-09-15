Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE0CCD37AA
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 21:08:20 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.32574.1694812093904893416
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Sep 2023 14:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g0RqF09f;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso6169635e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694812092; x=1695416892; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YiwZ9Nom09BfAdXROKljHswf89U2FsTSLFoF2Q0IT8o=;
        b=g0RqF09fk8JLq0auhjc49oWLtEsGj1LZDErJ3672mjthRA/vhxV0nH165nkTB80aL+
         LknL8JVw5cxlhuXWIQIGq8mWIPL5RBwaSfEgrMU5QwKr4tIqtbuhbrMdh6rPiLQ0wf0L
         jL5byNd049W2lSjhv9WD3AihrQrIpiRX4GF68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812092; x=1695416892;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiwZ9Nom09BfAdXROKljHswf89U2FsTSLFoF2Q0IT8o=;
        b=XgBv1c8RYpQTTlkFatJcIcGmJ9Mlj98DksQVEgUJ2Bhm6Y+hTWCPKac6oxPdQ8t7S3
         pzWayGc8H7yZZpMWZXDCgc3bhlst1X+w6qHZ/v+REmzdaPTZnswiBMPLBGC3zFTz3Jap
         MaIeVpz4rJionMWCtBwZva5hcy9AI7fspiPpDudAyj0jeSDVIFKwZN20ne8xl1IFLr1d
         ipTHyGHeytAXkbRpkbRJE2mTbxkvCa1QPfBu1xxinlaa1NuAX93payyZDnfrQaFxqATe
         nLCsZxS/a4h0iv7R4xmpVQhsYfia7lWjPqyVFxvWWemM5w6XSOLsSnAtONzHeRlaCsNo
         /W3Q==
X-Gm-Message-State: AOJu0YxI2iwIb5XwJgr9JL4VWXHTcGo4o7wIkbiR6tHirUL733k17oDP
	lW87ox4Ad3OXKEg1h9/mSjz+FkBdtJY4D31+OZo=
X-Google-Smtp-Source: AGHT+IEv56WH/5R0kmWIzo4shLaKAuOMJLGvf16dC7JF4Mo0V4Nk+dPXUCY131TdaJNFTSEjg/kT0g==
X-Received: by 2002:a1c:f717:0:b0:401:bd2e:49fc with SMTP id v23-20020a1cf717000000b00401bd2e49fcmr2258575wmh.24.1694812092337;
        Fri, 15 Sep 2023 14:08:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e272:9aba:e7f8:b67b? ([2001:8b0:aba:5f3c:e272:9aba:e7f8:b67b])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003fee6e170f9sm5547989wmj.45.2023.09.15.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:08:11 -0700 (PDT)
Message-ID: <31aeb55cfbb089e282265e211725f74b89111d21.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: Disable the flush()
 call in server logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: Philip Balister <philip@opensdr.com>
Date: Fri, 15 Sep 2023 22:08:10 +0100
In-Reply-To: <178518DC5E1190FF.14273@lists.openembedded.org>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
	 <49c3f81299d8153f31b09cfd226cb183097e6c8f.camel@linuxfoundation.org>
	 <DB5PR02MB10213747F1C3061D3EC8C116FEFF6A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <178518DC5E1190FF.14273@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 21:08:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15071

On Fri, 2023-09-15 at 15:29 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Fri, 2023-09-15 at 13:59 +0000, Peter Kjellerstedt wrote:
> >=20
> > While the problem the patch tried to fix is real, it seems a lot less
> > problematic than the result of applying the patch. So from a release=
=20
> > perspective, I would keep the current code and possibly add it as a=20
> > known bug to the release notes. Then, after the release is out, start
> > the work of solving the fallout from applying the patch, with the=20
> > intention to have it solved for the first point release of Nanbield.
> >=20
> > While not ideal, it sounds a lot less stressful than applying the=20
> > patch at this stage.
>=20
> My concern is the cache coherency issues this exposes.
>=20
> The 'easy' fix for release is explicit os.sync() calls in most command
> paths (everything except ping).
>=20
> I'm not sure I should really allow such a patch through review though
> as it would raise a lot of serious questions and the underlying issues
> need to be addressed.

Just to follow up with where I got to with this.

The problem is that inotify isn't delivering change notifications in a
timely fashion.

With the patch applied and BB_SERVER_TIMEOUT =3D "60", you can show an
issue with something like:

rm bitbake-cookerdaemon.log
bitbake-layers add-layer ../meta-virtualization/
bitbake-layers add-layer ../meta-openembedded/meta-oe/
bitbake -m

where the second add-layer fails with the same error as the first with
a message missing meta-virt dependencies. It doesn't notice
bblayers.conf has changed and hence doesn't re-parse the base
configuration. I've locally proven this is due to the inotify events
not arriving until after the parsing commands.

os.sync() isn't enough to flush the inotify backlog. os.system("sync")
does but that may be the fork overhead. sys.stdout.flush() does too,
probably as side effects in the kernel IO workings.

This basically brings me to the conclusion that it is hard to know when
the inotify events are in sync with the incoming command stream and the
current approach is flawed.

I'm starting to think that we should drop inotify and go back to stat
calls and maybe require that UIs send "re-scan cache" events so we can
avoid the scanning when we don't need to. The client code does have a
pretty good idea of when it changes metadata, it just doesn't share
that at the moment. We can rescan at reconnection so it would just
affect tinfoil usecases.

Cheers,

Richard


