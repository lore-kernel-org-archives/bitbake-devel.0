Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD919C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 11:53:47 +0000 (UTC)
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
 by mx.groups.io with SMTP id smtpd.web10.10231.1738756426174533826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 03:53:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XPcDQz0R;
 spf=pass (domain: gmail.com, ip: 209.85.217.66, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-4affab62589so2070840137.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738756425; x=1739361225; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK6ABiEbvHCynkf5j9QRYI3cwAozQ2P6EpSTyF8Clbs=;
        b=XPcDQz0R7+QpepIpPQSl9enRx5giWxCg+KX7V24E9y7/kmhjo9CBNOI84vR8AiAg1c
         RFyyRMZ+d7L0hR1fJhSs+a7DjX5sdO+7DysAva+4Ka0ruKxRRAKFLZBUpSuJISc4jkkR
         PS5xoTmT5GBGzjru/xI0sFVkLbbr0ftWOWUY4MnrRChXc3gDU7rhXdiUCEKXBrvQ7QXZ
         Rdo88Uz6pbrHIXtqyVoLZRXSBbIVGi6fRNcLyl2RXsbIl5IUpTqUpQLFTe0mPxNgwPa2
         NQjhQAp1ZLWPTRGC/3hVsTZ45O5MITvftBBRTvvwO3sP0DmkNf6z9HZVXWJNWyF3cYRW
         rAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738756425; x=1739361225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK6ABiEbvHCynkf5j9QRYI3cwAozQ2P6EpSTyF8Clbs=;
        b=WRyQBCAVqfJU4bvkOZCgobjdHt4Y3VsizqtSFB/GAbHN90R9MzEguGzl17U44oPB+k
         6b9u0d4OtBDyVQvCbJAW+eWWPMFLyF8l6QPgiQEZfm4iXPNkhb5FdRGZ7fqX78EIW9xr
         azceMAYv52T8m0O0JUzcFJx9hA2CNuJy8uL44cPD2YuGMUmmwrpf8nyJT68iAnSlabmh
         XEgt1zvXm28OTkOoY9LFC/Y7Q5OqFia7PjNz+nlMGiBHueQQaZQsm+TgFjIT+MSHzFZ8
         u+VdpU5RWGs1ZYQGMXHVQyCl4uuLFMEcghCCiP7P3BpMwB8zT/tvnnzH+Pw9ykP0uYQE
         +8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8/VCrdMW15u7UBHjivQWiCTYhqW3b1Ot8Cooym8R+YdL40drrxVpaQ4lZRBbngpANbE3NScWWLt++QZUl@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz1frfc/Bea40xza86emIOZqv2iJJLgU9x0qRfEjQwmxqJp9I1K
	Rj4StjD8h1agC9b4s1BoUMhl7pPWspHaLpiND77vPIqG9RCRNMnF+aqkIusm3Ymwe1W8zvK9Ro5
	jA7rqrrEZYuouhba04s08vCx+DSE=
X-Gm-Gg: ASbGncsZ4w0UPyh/KTA+9BtCPKr/OFPf+mUt8ZT/zVgxYdcchu9GKiOqH/L9rmFYRhJ
	EfXuaKUr2Yhj6d/V3sCUdw/MdKygjBkFUdho6c7h8gbngSl9Q927oZAPZ5gsNr2qIaMQk2ZfQ
X-Google-Smtp-Source: AGHT+IE9saCpYeIp9heU8lxPxu7Bq3f2AwTm4/i0sLJvoH4L42n9uBgma0fmQ4t9hHei6I0GjVMZjFD6Bz3SHEf2tPU=
X-Received: by 2002:a05:6102:2b85:b0:4b6:1efd:4f with SMTP id
 ada2fe7eead31-4ba44e8292amr1927562137.0.1738756425190; Wed, 05 Feb 2025
 03:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20250127142918.163-1-eric.meyers@arthrex.com> <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
 <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
 <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com>
 <CAB=6tBR1y2Xzpy0MK1uW2TLV7O1opcW_UP_LGd-t=yYg+SAL2Q@mail.gmail.com>
 <CA+cKJ+HRxtWLSehYjUc6rLS18xxp2C_kvq8Tx_vJ_FvuxdTPXw@mail.gmail.com> <e02d51c4-12e6-4cec-8405-e1b9b1f714d9@weidmueller.com>
In-Reply-To: <e02d51c4-12e6-4cec-8405-e1b9b1f714d9@weidmueller.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Wed, 5 Feb 2025 05:53:37 -0600
X-Gm-Features: AWEUYZlYvRVX9KCqA-7l_mFjhuG3WzOKBYN1ittNBtPFr1KQDhqzRk99WYUEqsQ
Message-ID: <CA+cKJ+F1whopQKFe0LxcDMMxArFJNuf=3qD8s-rNwukk_FQJjQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>, alex.kanavin@gmail.com, 
	bitbake-devel@lists.openembedded.org, 
	"eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 11:53:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17150

On Tue, Feb 4, 2025 at 7:19=E2=80=AFAM Stefan Herbrechtsmeier
<stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>
> Hi Eric,
>
> have you seen my RFC [1] to remove the npm dependency from the npm
> fetcher and use plain wget? I have a Work in Progress to parse the
> package-lock.json inside a task. This task generate plain https SRC_URIs
> and fetch everything with the wget fetcher. Furthermore I have eliminate
> the npm cache to speed up the build. I plan to post a first RFC with
> cargo, go mod and npm support in the next days.
>
> Regards
>    Stefan
>
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/110212697
>

Hi Stefan,

No I was not aware of that change - thanks for bringing it to my
attention. It looks interesting and I think would make my (eventual)
patch resubmission obsolete if I=E2=80=99m understanding it correctly.

A few questions:

    - Sounds like this change will remove the need for an npmrc file
when using private npm registries - correct? (since npm altogether is
being removed)

    - Do these changes impact devtool/recipetool within the upstream
poky repo at all? I assume so if the parameters to npm SRC_URI have
changed. Did you have any plans to make those changes by any chance?
If not, then I will try and pick up this change in my environment to
test alongside.

        - Our workflow here eventually is to run =E2=80=9Cdevtool add
=E2=80=9Cnpm://<private_npm_registry>;params=E2=80=9D=E2=80=9D and have the=
 recipe and
shrinkwrap generated automatically.

    - Do you plan on backporting these changes over to scarthgap?

    - What commit are you based off of within bitbake master for your patch=
set?

Thanks,
-Eric

