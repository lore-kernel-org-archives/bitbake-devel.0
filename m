Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51309C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:19:22 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web10.18532.1716563955741224746
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nKVWEkIl;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: raj.khem@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8d0a1e500so804484a34.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716563955; x=1717168755; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwy+eG8l0V4DBtdNzNlqRP6mj+mwNmCtSUHffT6LIfw=;
        b=nKVWEkIlf/f48+W57HKjTKUUnQLTCriJLQBfHC+fP9TIZqNALfWWBFTC6T2LllYWuo
         ZNPDqSND8u5xji0Mev/wfNmD52pLXnziM9FeO06woXBwvjsW7LQo/BxJiT8NlFGwxj3+
         BPR4AMxereTaPudpal4gq95zRBOyySS/6y0uT5HL1zdJf6yoLg42KxEHtUcf2is3nGmy
         q4HOC3/zF2zws9iy5hOnSjuX2XO3Cd7O2sUc9II03VS7AXGUdmBIdyUb0viTbyn2DTOo
         PYF5PqMiy1A48y5/BlxzdNjqJLK9EG6S5jEpz/ZXoSoqCiXqoJCVctcrIiVEpmkQFNsE
         wWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563955; x=1717168755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zwy+eG8l0V4DBtdNzNlqRP6mj+mwNmCtSUHffT6LIfw=;
        b=MOgXEGs1r2Gd8ysZvR12fSvfI5mPDzkcQeu450Lw7C7HlgjyKJygq0l7lstGxbqKjI
         RCvYj6HELpZH02/UIwq8r25l9dRV43kp7ruq8j7LF7gpn2dyab5okfQG/T8+MbRijPl7
         VUQ3SmiQXCPV/VJvHfF1SYNz2mQ3of1jj6fa9U2UlBio1TX5POSak5tqS4h3UGybwcFG
         /sc/jTMpks5w/B8qfskVvpnz4uLcGu1aZgZRIqk23H+JgvGE1pPinN+We9XBF+yqNHu3
         aTNcaMiEh+3Fx37eDZI+Nq5GYKRpCOgvxRdfx+lqkFbJJlFnuA3DtxjspsFfLM17ZicN
         pV2w==
X-Gm-Message-State: AOJu0YyjziNTrMCxA89iiwRsgJhd7kIgCHZZV+0Zy9EDWdzO61q4RMpB
	p+iYnS4rwyrNlwKWwL+5EggyhQbHCPPrM4VU3kVvAQNyvCCQStWfLq+qi+SnI6YAg2m3I+ayR+B
	8UgibyXijUretN8i7Yvk7JDX5Bm8=
X-Google-Smtp-Source: AGHT+IEg6Zk3fTLevNBdQBh/U+YuqVHqdz4lcjvSQHM04PpFwBbT/e1pNk28h6wdB8GFw6HA9ze+e8Xpfn7s5nf+NOM=
X-Received: by 2002:a05:6870:93c3:b0:24c:6184:1152 with SMTP id
 586e51a60fabf-24ca1550f3cmr2522653fac.56.1716563954735; Fri, 24 May 2024
 08:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
In-Reply-To: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 24 May 2024 08:18:48 -0700
Message-ID: <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: foss@0leil.net
Cc: bitbake-devel@lists.openembedded.org, 
	Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:19:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16261

On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> b4[1] is a very nice tool for mail-based contribution. A config[2] file
> exists to set up a few defaults. We can use it to set the Cc recipients
> to always add, in our case the mailing list.
>
> This shouldn't be necessary if we had a script that b4 prep --auto-to-cc
> could call to find the mail address(es) to send to. While we could do
> that, this opens the door to people trying to add a way to notify some
> people (e.g. a MAINTAINERS file) which is not somewhere the project
> wants to go right now, and this also makes sure the address is always
> added even if one forgets to run b4 prep --auto-to-cc (which is part of
> the typical workflow for U-Boot and Linux kernel, but is not necessary
> thanks to this patch).
>
> [1] https://pypi.org/project/b4/
> [2] https://b4.docs.kernel.org/en/latest/config.html
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This adds a basic config file for b4 to avoid to have to add the mailing
> list by hand. For documentation patches, one will still need to run
> b4 send --cc docs@lists.yoctoproject.org
> manually for sending it to the docs ML as well.
>
> Note that b4 supports patchwork, c.f.
> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-se=
ttings
> though I have no clue what it does with it as I am no maintainer, but
> maybe something worth having a look at if some maintainer of this repo
> wants to use b4 to merge stuff?

I use b4 regularly for meta-openembedded maintenance and it also updates
patchwork when patch is accepted, I have this config.

   [b4]
    pw-url =3D "https://patchwork.yoctoproject.org/"
    pw-key =3D "<mykey>"
    pw-project =3D "oe"
    pw-review-state =3D "under-review"
    pw-accept-state =3D  "accepted"
    pw-discard-state =3D "rejected"
    send-series-to =3D "openembedded-devel@lists.openembedded.org"


> ---
>  .b4-config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 000000000..632e39db4
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,2 @@
> +[b4]
> +  send-series-cc =3D bitbake-devel@lists.openembedded.org
>
> ---
> base-commit: ce166ae25793c11b0a190c531bef0c296fd74497
> change-id: 20240524-b4-support-e9855fc54d40
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16251): https://lists.openembedded.org/g/bitbake-deve=
l/message/16251
> Mute This Topic: https://lists.openembedded.org/mt/106281674/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.kh=
em@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

