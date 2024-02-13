Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7578C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 12:41:44 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.10433.1707828101106435116
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 04:41:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cMZPHACV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411c93e1cd8so2165315e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707828099; x=1708432899; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogLVTBF0Jnf6eosYjz4lSY5s1jxSOHoUDRdQif5FhfA=;
        b=cMZPHACVGu62wj+7eS66zJUS8AAGP0hHdvbvlz+rPPZ3kRQqmb3EupqraZwplAEKD0
         JDjCcBrpYPwYaA/djdZ8U+BOtuLpSbvIjqmMp3OpV5MzlYQoBgGGnYfT5rGAGIfGY4nt
         diuMbqgdtr+Ev84Q2Eurk3AoV8MFbRs+UlDZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828099; x=1708432899;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogLVTBF0Jnf6eosYjz4lSY5s1jxSOHoUDRdQif5FhfA=;
        b=OnOetYJav6AzIhUXgnqwwPV7Y0sNkd/c6Rs80nKM7CFOds2/bqU8oEjIZ3a5duAKPl
         B6RExUsBnE2MAYPGrXHWpBkDDEWJOWGNN18p5ZWUJ2O1P66A+8w4/XwEIHP0lDAUjk2p
         5YfhIOIKak1d6Bxew2+zqFJ9GvcgFw8Rq7Ou782ZhjQ0lhq9IF78OTgqkkXoCek7XAxW
         FmCgj5+n737T17OQIXAW4ruwsUO+u5RxVt8DXD2dI/O2diOUCly9sKkN7dTB0TFKMmLZ
         O7mdQkdnVgODUib8pye5J1NrcMYF1jVlitPZ++N3T/GByIxTugybh2LSmoM5+vMMAT2Q
         vxYA==
X-Forwarded-Encrypted: i=1; AJvYcCVSQZcDAf9pexDNCa5LAMsMmTINIsqyPE5oUO3d5XDeQJNhcT5sWFtPco8mEsjKzRzxYIcz/AOLQ0SltpNZGQqfa9rtfXV98CnmYyeHhXhVSOcue5Y=
X-Gm-Message-State: AOJu0YxulzVIEAsE5znOqRpIQ8gpfMKwgjBSdzCCW9k7oshPYa++PX0h
	I63aYnHoSH0DiwGBdg4h/AhPQigJySgd7Q1NRbK1svkxQJj8HEQ7aFlFQoNDlLc=
X-Google-Smtp-Source: AGHT+IGd7hGYoEAr0KBjrynBaNf5GTt6cysVjnbjZZppkauMgkQ86idw9g24at26SHXwZBJR48k3Jw==
X-Received: by 2002:a05:600c:4fc3:b0:410:d877:2478 with SMTP id o3-20020a05600c4fc300b00410d8772478mr2137692wmq.11.1707828099596;
        Tue, 13 Feb 2024 04:41:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBMQbKiKWYcIF/1hACpDiL7FBKUfxd1bzC0fLDaIgT7jLX7wvPLGJYPAZz6ElSrcVUfa5SGaNRlrVr6gW7pP+3XxKFnZ/XjZgvaZVM/ZgBBX1/NanpxUAxdWvPS01fsWDTX5vjnr6r966C7Wh/mwV50Zmx0LoM6osYMH49u6hAXVyX/RZHVjEoDA==
Received: from ?IPv6:2001:8b0:aba:5f3c:61a5:11c7:4181:c4a3? ([2001:8b0:aba:5f3c:61a5:11c7:4181:c4a3])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b00411a0477755sm3496208wmk.9.2024.02.13.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:41:39 -0800 (PST)
Message-ID: <6f3ad1da428dc3023c30daa521ae97b89c21abd9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] regression of 'world' performance?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>, Randy MacLeod
 <rwmacleod@gmail.com>,  Mark Hatle <mark.hatle@kernel.crashing.org>
Date: Tue, 13 Feb 2024 12:41:38 +0000
In-Reply-To: <CANNYZj8qZ4-nyGu53HsV8sJLCfBxmBuDeCD1cq7raSsby-_1=w@mail.gmail.com>
References: 
	<CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
	 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
	 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
	 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
	 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
	 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
	 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
	 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
	 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
	 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
	 <17B24084174823DE.15017@lists.openembedded.org>
	 <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
	 <17B255DB2CE33879.588@lists.openembedded.org>
	 <17B257441406400D.588@lists.openembedded.org>
	 <17B2894C95E031D0.14481@lists.openembedded.org>
	 <17B29B2072FF51A8.14481@lists.openembedded.org>
	 <7bb8798da40488ad8f79f472775e2ee2c2a9c8e2.camel@linuxfoundation.org>
	 <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
	 <b30b09d3a164e2425c8d0d43df495ea8bcb08679.camel@linuxfoundation.org>
	 <CANNYZj8qZ4-nyGu53HsV8sJLCfBxmBuDeCD1cq7raSsby-_1=w@mail.gmail.com>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 12:41:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15887

On Tue, 2024-02-13 at 10:42 +0100, Alexander Kanavin wrote:
> On Tue, 13 Feb 2024 at 09:57, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > The patches fix low hanging issues but I suspect there is more we
> > could/should do in this code.
>=20
> Thanks, I confirm that after replacing the previous 'return True ->
> continue' patch with the latest one, the profile is similar to that
> patch:
>=20
> Tue Feb 13 10:29:59 2024    profile-mainloop.log
>=20
>          171090640 function calls (170677396 primitive calls) in
> 1000.777 seconds
>=20
>    Ordered by: internal time
>=20
>    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
>     35784  301.390    0.008  509.820    0.014
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:225(next_buildable_task)
>     34092  164.164    0.005  171.500    0.005
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2438(build_taskdepdata)
>     35787  120.062    0.003  120.062    0.003 {method 'difference' of
> 'set' objects}
>     71572   55.117    0.001   55.117    0.001 {method
> 'difference_update' of 'set' objects}
> 17639/15964   49.593    0.003   49.869    0.003
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2686(scenequeue_updatecoun=
ters)
>     34096   44.287    0.001   44.287    0.001 {method 'write' of
> '_io.BufferedWriter' objects}
>    298936   43.070    0.000   43.070    0.000 {built-in method _pickle.du=
mps}
>     52656   39.374    0.001  936.397    0.018
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2150(execute)
>     35787   21.456    0.001   21.456    0.001 {method
> 'intersection_update' of 'set' objects}
>     35783   10.646    0.000   10.646    0.000 {method 'index' of 'list' o=
bjects}
>    314739    7.954    0.000    8.176    0.000 {built-in method io.open}
>  90090452    7.660    0.000    7.660    0.000 {method 'append' of
> 'list' objects}
>=20
>=20
> There's only appending to list which is still done tens of millions of
> times, not sure if that's a concern. The bulk of it is in
> build_taskdepdata().

We can work out how it compares to what we'd expect. If you generate
task-depends.dot and count the number of dependencies between tasks,
I'd expect the number of appends in build_taskdepdata to be be
approximately:

No. Tasks * No. Dependencies * 0.5

The half is assuming that the number of dependencies a task as scales
linearly which it doesn't but should give a rough number. It certainly
shouldn't be more than tasks * dependencies as an upper bound.

> I first noticed the issue when working on python 3.12 upgrade by the
> way: this version has a higher amount of breaking changes that has
> been typical (this was noticeable already in plain oe-core builds), so
> as a courtesy to those taking care of meta-oe I've decided to fix
> everything there as well. Which meant adding all meta-oe layers, and
> running bitbake -k world with that.

Thanks for doing that, it is appreciated. I think it is also good to
flag the poor performance as there is something we can do about this
case.

Cheers,

Richard

