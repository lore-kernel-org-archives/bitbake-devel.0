Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2A2CD98E0
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:46:43 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2939.1763066795520995985
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 12:46:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OoUeV32C;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88246676008so15113486d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 12:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763066794; x=1763671594; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t8CAgDrLcZEO66lXQj/504k5mB7ZDOPRA2Z2BBgtIXE=;
        b=OoUeV32CIrlSrH4IBXk2xxDyL2UwHiycl9zqPsKtq7q80vEOmJObDv1eluSqF6pHcu
         EENKLUoTr8MEGXS18ToQMVQFqCW6+s+HFyeTehTHlM6gKyztBqrbg/Y7Y33xse1En5Oz
         +puRI/0F+BhVBcwGOwnqep5Vib6TYXgCzt/fSIiVvPonYR0JuIabhoxU5NFEI46FgKjL
         LWiBQC/sChI1lA3O35GQ/UVHNHyvjSckPJxXZFsRxJT8h3BSBbvXZp/NNV42j0cdZiMV
         7ZBMrR9y9oxbePgjqZ5NroYmnllckWLiq20OgZh88deLjdGjC9ImzksDnR9AVSaGLTuX
         7pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066794; x=1763671594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8CAgDrLcZEO66lXQj/504k5mB7ZDOPRA2Z2BBgtIXE=;
        b=Sji3+oXW2Zk2f+YVDZ6PTLmnT5odG6beScHD727L8jh1MRfwN8hRG8TaKQUzaN6EZ3
         zQ2pO2f5xzmdtAFr/Dhc29tcezO9TtaJ0CB2SzvBUziFSwO2Uu9II0qA18IcOA16GLgK
         FeyagLcYH2JKqCpzGxPrge0ggExa2IBXcDlEApnjVT3r0nDVP9S8WuILoPmPIIOh3tMy
         Ctwh5nrmZHggOFjmcqmKeJ5YevALHODohZ0xcub3TvLG2IUSmjxHA9BkQXktUu77fRv3
         VTpONbbH7/e+/tb4Df9Juk5H3+LaGm5h9EsMWgw+cj9p8mIdkfMniwp26jZ9cwVEDybb
         AiKw==
X-Forwarded-Encrypted: i=1; AJvYcCXvB4VOF/+zdPpqzQ8DCx+wXZisJjdZCrC5ZQbKbcuqCkuKyBfth6p3BT+BgEXUIxamAB4NqmozTs96oOj7@lists.openembedded.org
X-Gm-Message-State: AOJu0YyXNOZQT2LuT9yGgy+9hwTpDxpspd9uZgJ4WTvy+e4MOIqzOFMF
	C74FnixIo67ouR515NaC1p9hb2Pk2lYSzrdp9Z5YEnls7XG4Z01NVoUrcqHweS/+cj7QHFH7/ow
	pgKvoagidlsxbL/NqauYUwWkmjvkAKtk=
X-Gm-Gg: ASbGncuMEyOJxc4TR3iJN/2OZRGIIdP3baG284prJ4CgWg9urijoyGxX5hRb7L4bXTz
	TmNwjP9tZj4leDvfZuwp7nZAcOVlOEppDh253o5lHna4OVXnZyzr2SQeeQogDQv4jxJe3QPl7q1
	rj1kfeCi3KcY6+H7C6mgX8xfAGmuZX7DnXUEtB1GlTqC4iVe544a4kjfhgnhAO9QhMmfbBFQ1Jk
	qdJdoS8egXeRHxBPuV2ZTe5ryl944S6tnPriSjDlD/HwLU66wYpCqSpUDvKO6zAOuX6ejbS6xqV
	xH1GuZNN59gZeGcrHoBcUj8dvqMGSjmXeEfQebVa
X-Google-Smtp-Source: AGHT+IEvizcRSHmFo1kDbPWRir4p2MayTx2PXcfSae8PWC9N4LAr0fP3aLH8E9qxEyUukXD15WpSQsYNkSV700xDaXk=
X-Received: by 2002:a05:6214:1d22:b0:880:48e4:198a with SMTP id
 6a1803df08f44-8829267c858mr7911446d6.32.1763066794390; Thu, 13 Nov 2025
 12:46:34 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
 <18779541E6AD04B6.981615@lists.openembedded.org> <CANNYZj_p_FX1sb6UduS-5H=jsmBrZA5crpJFPi3juRXjRtarXQ@mail.gmail.com>
 <d6865d19f95b3e7a3addfc14f08ce042a82aa43c.camel@pbarker.dev>
In-Reply-To: <d6865d19f95b3e7a3addfc14f08ce042a82aa43c.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Nov 2025 21:46:23 +0100
X-Gm-Features: AWmQ_bn0rGxlGyhBkjmRjSSC1ff3qpLNxIuL-A_-pO_7HbUro-S625c_vAxBpmQ
Message-ID: <CANNYZj89WnP1LkK7rvToAfp=NLCXiEYKgoo47Zdr1SPr8_Mssg@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup steps for release
To: Paul Barker <paul@pbarker.dev>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Ross Burton <ross.burton@arm.com>, 
	reatmon <reatmon@ti.com>, Robert Yang <liezhi.yang@windriver.com>, 
	"antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 20:46:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18380

On Thu, 13 Nov 2025 at 16:30, Paul Barker <paul@pbarker.dev> wrote:
> I think this may be enough of a solution. I also like the idea of
> bitbake-setup symlinking things into the layers directory so that we
> don't need to handle these paths as special cases.
>
> So, are we thinking of an override file like this?
>
>     {
>         "description": "Local overrides for development",
>         "sources": {
>             "bitbake": {
>                 "local": {
>                     "path": "~/src/bitbake"
>                 }
>             },
>             "openembedded-core": {
>                 "local": {
>                     "path": "~/src/openembedded-core"
>                 }
>             }
>         }
>     }
>
> I think it's important to support '~' in the path, we can easily call
> os.path.expanduser() to handle this. We should also support relative
> paths, which are interpreted as relative to directory containing the
> override json file.

Yes, this looks good to me (there's an existing, optional path
property one level up, but it's intended for where code from remote
repositories goes in a designated checkout location (e.g.
setup_dir/layers/...), and so I don't think it's appropriate to reuse
that).

If you embark on writing the code to support this, don't forget:

- update the schema in oe-core (I think it should be moved to bitbake
repo as well, we just had other more pressing matters). Make 'local'
and 'git-remote' mutually exclusive.
- update the bitbake-selftest to test both the override function and
the 'local'-type source.
- I think this feature isn't actually a blocker for release, and can
be added afterwards to bitbake master, and used from there.
Bitbake-setup is not coupled to the yocto release it's setting up.

Alex

