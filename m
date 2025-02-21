Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4590C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 12:18:43 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.21654.1740140320542376649
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 04:18:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sc56I3WG;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e65e0a3f7eso9452276d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 04:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740140319; x=1740745119; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5o2EzqcVSNtPGa+dq1iW+dVMILxanDmc6D1UD+2apw=;
        b=Sc56I3WGb8Rgn38v2Mlc/DKzyEUClYUq8M69nSEjBmP4H2VOHh0EUTHvIcDlJsuYEW
         PgEeJ9FFzb4IfSaNDrjQAuxdzmy99NccgA9rr51tTroAynWV5CkDFTaNpQG3xx7wePBg
         SzvVdteC4KKyzkqaLYOyNwwNRrX0Rj6gNzi0IHwhR2hw8rSaW6678yNoEqt3hnuOxcEB
         NtS0jOEDOTn+oy3nV34L8ffycMnW4MOwgjmFO4wL6cIrzin1YgZYZkhjSWeOONS0dLfn
         EQ302C0yOu28h2M1YgE8HOkuZWGOpaLTNf5FWE8f3ac2datYHvHLcXg7MfLmcVS1uVIl
         Pr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740140319; x=1740745119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5o2EzqcVSNtPGa+dq1iW+dVMILxanDmc6D1UD+2apw=;
        b=XLTVftc4sv0Z0Y3hwIKzBIN8DVodcTcdpu87XH67iMru+SF0BlmHTFAAnhzvhKSsL8
         i6F4ZDJ3yyqhyXLR93gGChTCvwUZAOV5iDMBymxCePxEmzQC/CZvjbAFr19NqIHPCxWV
         64Lb7BsBOiDqoymSZGQwOZbmVb5t8SNlJwRYD1j2iINUxt8Ccfg4EA5yVK81WDWzZt9X
         jd07SYm+FA0gKECwbL1u3JnnWDsgPn6YOQal3v01DwIWl5ddTsKD1hpLb88jmA8debkO
         fohaoWArCBmovYJhIoYbpLVsQ0VgdIzmmJhCPwh1JS3VGMb80TRgjiWcIlhDZ/16mQ21
         rFsw==
X-Gm-Message-State: AOJu0YzMvlI1mGHe1E88TR/PbxhX5z+clJmjDdtJmv4AgF/m8UmloIiF
	V1dD33VWPDU3+fkhM1jCL9uv0Raai+XOClnPQo1LMP5CiiCe1DKsR27SmkjE1imsVC2Fw7fCIEq
	/6RoLlrlCd2AqlROVDUexeCm6gQc=
X-Gm-Gg: ASbGnctU5STHI+5WMxbE1Abrr6Fv4ooGa2jvFTxKrP+YspRkjRWPhui/QUX2Kz408e8
	le2/23zpfZ+gz/Lqvywcwx2NUE+d0WQLJZSalZk6ZfR7Pm/qfSh7e4pCeufxeI5u4KXUBuxXJ03
	5Yaj8Z/W9ESxhenen3lBpcUKfN2T0QEEinGh6/VNlT9g==
X-Google-Smtp-Source: AGHT+IEQzyKvXpqsqAyHlEg4v1JSduhUWWCaM35RO9QVTvZQnNcVNIgIpV3Ax+kEROFTyfFrzcj1W2NN/sT4Zx47NnA=
X-Received: by 2002:a05:6214:2681:b0:6e6:6b6e:e9a5 with SMTP id
 6a1803df08f44-6e6ae9c70dbmr35055546d6.38.1740140319614; Fri, 21 Feb 2025
 04:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
 <1825F6393BB749ED.25123@lists.openembedded.org> <CANNYZj8LynhGChryLLHYFSz3=G70nO1938FwbfHN58rucuQ2sw@mail.gmail.com>
 <b78c624ef4f48bf9f4c8d571555dd693ea8da4de.camel@linuxfoundation.org>
In-Reply-To: <b78c624ef4f48bf9f4c8d571555dd693ea8da4de.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 21 Feb 2025 13:18:28 +0100
X-Gm-Features: AWEUYZnG_LNwoJWksFz4DEHRKclYl2t7yBFtIb2qMQo4XK3A63X-jg6G7bbqZQI
Message-ID: <CANNYZj9XMsyedwZROJ=ftWdBT_c=HhkWreiA01C7-SiE-a0wvw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, JPEWhacker@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 12:18:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17276

On Fri, 21 Feb 2025 at 10:14, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> > Ok, I've slept on it, and concluded that bitbake-setup should simply
> > always install buildtools by default. It's a front line tool for new
> > users, and it can't afford to fail in mysterious ways. There will be a
> > setting to turn it off, for those who know what they're doing and know
> > they don't need buildtools.
>
> I think that should be an option but I'm reluctant to say to use it by
> default as we're just not going to find out about host issues until it
> is too late. Our sanity tests are supposed to detect and give human
> readable errors for the common issues you'd encounter.

One option is that bitbake-setup always installs buildtools (e.g. runs
scripts/install-buildtools which in itself is harmless and doesn't
affect builds), but makes their use opt-in. E.g. bitbake-setup already
creates

build/init-build-env
build/build-targets

that do not use buildtools. One initializes bitbake environment in the
current shell, the other runs pre-defined targets.

Additionally bitbake-setup could also create

build/init-build-env-with-buildtools
build/build-targets-with-buildtools

that also source the buildtools environment script. No need for
options or settings or guessing in the tools, we just need to
highlight the difference, and guide to use one or the other.

Alex

