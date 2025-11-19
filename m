Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A574ACF34C7
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:03:27 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9087.1763564605281847041
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 07:03:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WYVXUbzi;
 spf=pass (domain: gmail.com, ip: 74.125.224.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63bc1aeb427so6199556d50.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 07:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763564604; x=1764169404; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r81v99c8FWvSRa01VhO/wL1W++LcqdtHIK62spxlnrQ=;
        b=WYVXUbziVI1csZE0EI9aK7fJev207l639QF2/ez6Fi0//ofhQPz1BXoaQmxaFSULoo
         9B/cgCIF5LJncvhgKUeat3mX7SFEFSbXGYzEp9ZQb8Fov4j2PxTW8FAOTlV1cOiNuJWx
         Iq3pif+UxTQtYZ7D0OcIqCg/XqW7JvDfLmFsb+YjPOY/wr2/g5bzAOmEU3hYyt2iEagu
         ZEg4cOKENNXleI4rJ4VssyfdFTOsCzgG8NgKayBbuZpVU1ugj/AShDWfLSqlrBO4eIF+
         +BXF1PDm95ynGypJ1IynHiVEvebOORgMrbzeoV4e+1AG3yx5qW4S6BgFJsdh7XbKF0pd
         SVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763564604; x=1764169404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r81v99c8FWvSRa01VhO/wL1W++LcqdtHIK62spxlnrQ=;
        b=aqHeVzwZlQSg/0xeVE2oYJMfOAmI/Q7bXu9NcooC7f5Bip5lpJlPf7m0FEwmAVdjKv
         nx62Kz9WOM6H0eYh4/5u6cIoxZkElojJWZIYGbTPmibUZzedg+CIS8xI1JLMMDjL6lKO
         sM3pw+AV0O3hOz9i/2dOLVvTuCQB4Xx/oxQi5m1klsuJXwekZ340MgdIDF/MreJEPIWr
         pHBEc/Iuli0UPVdFiFYl6P5014grtaWEqpKlGRva7jNVWRHeRzYj24mVMtQKHpNMZOq3
         UAELsMx/Kvc5kMHg47MelU6cFv+nbkQj676/w38TEVIbmWCuEgUlL31LHgCCUTvAEKCL
         gO/w==
X-Gm-Message-State: AOJu0YxWR4pFu3rf/ID7QWuW6bGa0v05hVeu5O8QU6353alEiftXuxo6
	/IHgLqKOCmZAIHCQhiILOQNEkhz6ykeGOHo3CQS00dMBQS02KVXFiSq5CPu3JWA2rV+dqjl2yBc
	ZGgtLuPwT2UHAAZzOdR7lV9mZhs3SycZHw8PI
X-Gm-Gg: ASbGncs2cFPX7mwZIAOEzDluhDezT9mcQYilHAMAi0ury2xt9zYT2mhSmhO6mE7/qFX
	NsQvGWkb9/NXWuyy3uSO3wQgdZK9HNiOrD7zc6+9XAa41Iks2ARukcPplJNBXgIwAtVTHst2zsk
	WnwyPekhTr3NLckNN1dgIia6LCTuFSZWye2z86nrwWvwVXLqQN/WSCuql+haT7GC/zTsK2YYner
	iZhDzylFHq1stZ54ZC8nx9bNWHgOn0zKXECzKNQvXam3i94b1EbQy5b9Jy/IF5He4/Z4L5AnFKJ
	AV5jMTK3Vlbta3+CZTt6
X-Google-Smtp-Source: AGHT+IECpQ6o5b7xsFrc9AElij7yri37qDi10aXIIwUsOnyBsbbBDkVxaZMTMrHM1cy8N9FUUjNf68OS5YchkkuQMeg=
X-Received: by 2002:a05:690e:1513:b0:641:f5bc:6942 with SMTP id
 956f58d0204a3-641f5bc711bmr12838528d50.70.1763564603715; Wed, 19 Nov 2025
 07:03:23 -0800 (PST)
MIME-Version: 1.0
References: <42bcc23e-27ae-8bf4-486d-3e552d58c701@crashcourse.ca>
In-Reply-To: <42bcc23e-27ae-8bf4-486d-3e552d58c701@crashcourse.ca>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 19 Nov 2025 08:03:12 -0700
X-Gm-Features: AWmQ_blEwDIVPq6rsfFqBYBLQSzONZx5cSkcMRGDR5jc6j0-q3971tJO_Ni0BOs
Message-ID: <CAJdd5GZZNGyPePiJEQnn-0mZK0cX9dzTh7KM3uqkFJtnJ6dVQg@mail.gmail.com>
Subject: Re: [bitbake-devel] why is "bitbake-setup list" trying to *create*
 bitbake-builds directory?
To: rpjday@crashcourse.ca
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 15:03:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18459

On Wed, Nov 19, 2025 at 7:58=E2=80=AFAM Robert P. J. Day via
lists.openembedded.org <rpjday=3Dcrashcourse.ca@lists.openembedded.org>
wrote:
>
>
>   i'm confused about why "bitbake-setup list" is not just attempting
> to "list" stuff, but is actively creating a "bitbake-builds" directory
> in my current location.
>
>   if i have no bitbake-builds in my home directory and i'm *in* that
> directory, then:
>
> $ bitbake-setup list
> Bitbake-setup is using /home/rpjday/bitbake-builds as top directory
> ("bitbake-setup settings --help" shows how to change it).

Does this still happen on the latest master? I think it might have
been fixed by: 0ae46d39c ("bitbake-setup: create top-dir later in
init")

>
>
> Available configurations:
> poky-master     Poky - The Yocto Project testing distribution
> configurations and hardware test platforms
> oe-nodistro     OpenEmbedded - 'nodistro' basic configuration
>
> Run 'init' with one of the above configuration identifiers to set up a
> build.
> $
>
>   and suddenly i have a bitbake-builds directory -- that is not at all
> intuitive since all i asked for was a "list", i did not ask for
> anything to be initialized or created.
>
>   this causes unexpected behaviour if you happen to be in a
> non-writable directory, say /etc, and run the same command, which then
> blows up since it can't create that directory:
>
> $ bitbake-setup list
> Bitbake-setup is using /etc/bitbake-builds as top directory
> ("bitbake-setup settings --help" shows how to change it).
>
> Traceback (most recent call last):
>   File "/home/rpjday/oe/layers/bitbake/bin/bitbake-setup", line 963,
> in <module>
>     main()
>     ~~~~^^
>   File "/home/rpjday/oe/layers/bitbake/bin/bitbake-setup", line 955,
> in main
>     d =3D init_bb_cache(top_dir, all_settings, args)
>   File "/home/rpjday/oe/layers/bitbake/bin/bitbake-setup", line 52, in
> init_bb_cache
>     bb.fetch.fetcher_init(d)
>     ~~~~~~~~~~~~~~~~~~~~~^^^
>   File "/home/rpjday/oe/layers/bitbake/lib/bb/fetch2/__init__.py",
> line 516, in fetcher_init
>     _checksum_cache.init_cache(d.getVar("BB_CACHEDIR"))
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/rpjday/oe/layers/bitbake/lib/bb/cache.py", line 824, in
> init_cache
>     bb.utils.mkdirhier(cachedir)
>     ~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>   File "/home/rpjday/oe/layers/bitbake/lib/bb/utils.py", line 943, in
> mkdirhier
>     raise e
>   File "/home/rpjday/oe/layers/bitbake/lib/bb/utils.py", line 940, in
> mkdirhier
>     os.makedirs(directory)
>     ~~~~~~~~~~~^^^^^^^^^^^
>   File "<frozen os>", line 218, in makedirs
>   File "<frozen os>", line 218, in makedirs
>   File "<frozen os>", line 228, in makedirs
> PermissionError: [Errno 13] Permission denied: '/etc/bitbake-builds'
>
>
>
>   that is not intuitive behaviour.
>
> rday
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18458): https://lists.openembedded.org/g/bitbake-deve=
l/message/18458
> Mute This Topic: https://lists.openembedded.org/mt/116374639/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

