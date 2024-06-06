Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ED8C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 13:50:33 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.14968.1717681822523910716
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Jun 2024 06:50:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Va+2FocQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b936c958dso1181956e87.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717681820; x=1718286620; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAIkln1rzS9tRvTl5eJueACTwJ27klA1779RLrVCWyc=;
        b=Va+2FocQovnGMjS41LxlncjH/Mo3tbpsSX9HSd9bj8h4xvcdPAwdHlKr0fv02yUm04
         amc35rv68g42OEdd+NNwwLG5CV9CIfbnCsNKtUJomlCyzUiiLyQQ2RERC0orzaG83+9Y
         n2/sNf3+ZcLt2qrZmJzJbl9so7xRrkwuM9Gl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681820; x=1718286620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAIkln1rzS9tRvTl5eJueACTwJ27klA1779RLrVCWyc=;
        b=XLf77U8TfsalMPOV8nrlzCSm8x7S7/mKuXq5yliCGcgqSp25BlEcJjeyAcWpR+agre
         8OlD3G9GD1veLhxX7bdPgD6c5Y0eKBL7mq11phgnJ3BaY02SMlM5orHbxZp5wLEZFhdk
         wuTrGdPpflO5Y98MczhkVZBwcB5WMN9wvYoMwoKf/ryJd852rUBXf9fa4MgitXfinyn+
         1Kbnt4YhBSxT5wgP4USwkJwIkNSlugm1O3eto7RUZo2NV0zCdpV9gPMjnezfaq8HW1y9
         AePrk1PvCcrx6Yk3ypJ1MDMlHXVSQ66nr8WeJtd4H0l/ubHS7bOJVJ/g98vr1zunNXuN
         +plA==
X-Forwarded-Encrypted: i=1; AJvYcCU2iUzIlJwyNTOWTAQ40RxU+BSQ0b0Km9wwI6ckEwiZUOW276MzjEHjnwmmi9aEgKB+Y53wuVNy4HSiXDfQEPUXBcg6vSNfAOYDR9y8BZrJAdldG7I=
X-Gm-Message-State: AOJu0YxPIHQzFQuo4KiS1PcGeZN4Jv4Vkm64HbWeFEEh+DUmT+rjo9FB
	nC5n29hJqG2YtsgfgICRw5q5kXkbexdfSEgoMqn9PLEKpgx7pWotyzoY9ot1OHo=
X-Google-Smtp-Source: AGHT+IGNFTGjiCTjmjwCm8W1vW9G0d2nXmk17Nebxkw1w2igTyVwZ6k1KSV3AMAm2p5zpY9ozpcyNA==
X-Received: by 2002:a19:f80f:0:b0:520:77e7:79ce with SMTP id 2adb3069b0e04-52bab4c9afbmr3344629e87.21.1717681820267;
        Thu, 06 Jun 2024 06:50:20 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2418:892f:d822:11fe? ([2001:8b0:aba:5f3c:2418:892f:d822:11fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e7bfsm56496225e9.40.2024.06.06.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:50:19 -0700 (PDT)
Message-ID: <e22ec7329d8c18c254b8fa116ffebb32d4d8b86d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] wget2
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rudolf.streif@ibeeto.com, bitbake-devel@lists.openembedded.org
Date: Thu, 06 Jun 2024 14:50:19 +0100
In-Reply-To: <234ddf00-756c-4863-a508-6a0ec75558ea@ibeeto.com>
References: <234ddf00-756c-4863-a508-6a0ec75558ea@ibeeto.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 13:50:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16322

On Wed, 2024-06-05 at 18:54 -0700, Rudolf J Streif via lists.openembedded.o=
rg wrote:
> =C2=A0I have been using YP/OE for the longest time with Fedora. I most
> recently upgraded my build system to FC40. FC40 replaces wget with
> wget2. FTP support was removed from wget2 for good reasons.
> =C2=A0
> even if the protocol used was not ftp. Since wget2 does not support
> ftp it also does not support (or ignore, for that matter) this
> option. It fails. From Scarthgap on the --passive-ftp is only added
> if the protocol is indeed ftp or ftps.
> =C2=A0
> So far so good. However, there is another subtle issue with wget2: it
> does not like relative path components in paths provided with the -P
> option. It normalizes paths if there's one and only one relative path
> component at the beginning of the path:
> =C2=A0
> =C2=A0* -P ./downloads =C2=A0=C2=A0 works
> =C2=A0* -P ../downloads =C2=A0 works
> =C2=A0* -P ../../downloads does not work (Internal error: Unexpected
> relative path: '../..')
> =C2=A0* -P ./../downloads does not work (Internal error: Unexpected
> relative path: './..')
> =C2=A0* -P /home/user/downloads/../downloads does not work (Internal
> error: Unexpected relative path: '/home/user/downloads/..')
> =C2=A0
> I am commonly using DL_DIR =3D "${TOPDIR}/../../downloads" to set a
> shared download directory for different projects. Of course I could
> replace the relative path with an absolute one.
> =C2=A0
> The culprit is the function mkdir_path in utils.c which attempts to
> create the path components to download the files to. This would make
> sense when wget2 needs to download a directory structure from a
> server but technically it should only create the path components
> relative to -P.
> =C2=A0
> Of course, this is not the right mailing list to complain about
> wget2. I have submitted a ticket:
> https://gitlab.com/gnuwget/wget2/-/issues/667. However, it might be
> of interest to the YP community since other distros might have
> already or might be in the future moving to wget2.
> =C2=A0
> A Bitbake solution would be to normalize the path in the fetcher.

Thanks for sharing, this should stop anyone else trying to track down
this problem! It does sound a pain to get to the bottom of.

I'd accept a patch to bitbake to resolve the path names to work around
this problem as I suspect more people are going to start running into
this. Did you happen to have such a patch?

Cheers,

Richard




