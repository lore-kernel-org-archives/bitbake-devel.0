Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45996C282EC
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 11:11:52 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.10467.1741259504023485826
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Mar 2025 03:11:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fvOroFTE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390eebcc371so358715f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741259502; x=1741864302; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UjsvzOZUNjx1E4QknaLeHz++p50xmtteXdMqw9FgxNo=;
        b=fvOroFTESE2yB5DrCXmRbpOii21B3yD+7l8TfKb+TzYEjsU3YOtzWlHZ86u5ky/fHM
         bspFgy52B1zwNAV9lYqweMigDVC+IbJl0yo23ZgJj7eeCmmleg+CTMq7hApQMhOTPFoZ
         y0zpivI/UxShhg3JJHtH2qVzQIQIiil7dnmKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259502; x=1741864302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjsvzOZUNjx1E4QknaLeHz++p50xmtteXdMqw9FgxNo=;
        b=rCe/D9tvMA+MYYAEhol67OUFRWscmCns6fM72kWQiJCzMtFRsLE9SfmOcOE/kB3yHJ
         3BuIqhmOnZNCg7EEWX0tflgq5FZXhhoals0NcSNxlRwFy1S/s716e1SLZ/Co/rzWwpUi
         sfZ5D54Cwb2Al2RrWHREHF0aAUchUA+egfH5U0l5u7trN7eyJUD6U0RvgPrSt3c6Zeny
         USYWDKl2jzFMhLJxgcYpf8L0SFuef6xsEaPGuXBipyKFOFZI9af/+ExXago9ms+L1ail
         AyVCvAeu5FOMXxNHq7gkEwzHdo4m5Werh1ouVnyYKExvdMG0h1YqE1iwOJbx2Xd/ChTo
         Mb0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8+Y/pT19QTkr6k969oWuHnbIm9iNi7T/R6oz0OyE/uM2uYEC3Qm+pc+eb5jSEt0G9RfpM0Rn5oRABC/y/@lists.openembedded.org
X-Gm-Message-State: AOJu0YxsrQUHHrgT1LKm7F3w8hOtwf8OpnLn4WRuFtizYjPa3Devbg/5
	FI2/Pft5DWLGvuCKt+V9D3w94NP6zBaCLmGvqDiANW8IP8j0Ea1blJAZqFY4THc=
X-Gm-Gg: ASbGncvRxg5+cD0GruMo4YdFCkTzMs6q5yTTktak6cYTFFhLatXauKVsRxlpi1QZgJw
	svRPkL+gKCN6gppawZyR32kIbPECFuSx5qIYC/Z6bblcUTTnu1F5rVyOPfBlXymRwURM0Xl2TGl
	8ka7oRPRufSgdd/fc2PIpHVloIF+uyfzygZTmvTgmm1NoIu4W5Ml0bTjWHLlsgsTb6N+NbQ45l+
	u9ezRLia90FsWjiqanYwkSu1iW5i4IxyLAwu4rHpy5R3dMFS2bsTxW1P/DHjo7O11e4FHue6hvc
	2xt4REkB9nFv3B2qILVbisNWjsANOvX3n2KmVsxJz3nHioFUpgDJnIeWVWH8w9hpC6rxSRHEmJG
	bpJJzI8Bu3Q/pXdinSRpzAHWKwNgcz8gWkA==
X-Google-Smtp-Source: AGHT+IFLEj8BUBJdOYs204gt3pC6D2qlnCWbQJywM6pngNUlcsMTEwzkk227/gQ07JLe/ysNUlg6sA==
X-Received: by 2002:a05:6000:2108:b0:391:2ab1:d4c2 with SMTP id ffacd0b85a97d-3912ab1d7cemr1354686f8f.37.1741259502439;
        Thu, 06 Mar 2025 03:11:42 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e869:4c46:3bba:1ea9? ([2001:8b0:aba:5f3c:e869:4c46:3bba:1ea9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1037bfsm1718499f8f.96.2025.03.06.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:11:41 -0800 (PST)
Message-ID: <a147420295a67f1db7be369e6ad45b2fb2bb086c.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH v2 0/5] fetch2/github_release_artifact: fetcher
 for (private) release artifacts
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: lgo@pengutronix.de, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, yocto@pengutronix.de
Date: Thu, 06 Mar 2025 11:11:40 +0000
In-Reply-To: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 11:11:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17392

On Thu, 2025-02-27 at 10:08 +0100, Leonard G=C3=B6hrs via lists.yoctoprojec=
t.org wrote:
> This fetcher enables downloading artifacts attached to GitHub releases
> in private repositories.
>=20
> Authentication is provided using tokens via the `GH_TOKEN` variable
> or a `token=3D` URI parameter.
>=20
> Changes from v1:
>=20
> =C2=A0 - Provide examples on how to provide the `GH_TOKEN` more securely =
than
> =C2=A0=C2=A0=C2=A0 just hardcoding it in the recipe in the commit message=
.
> =C2=A0=C2=A0=C2=A0 E.g. via the `local.conf` or environment variables.
> =C2=A0 - Indent the code example in the documentation `.rst` using three
> =C2=A0=C2=A0=C2=A0 spaces instead of two.
> =C2=A0 - Document the `token=3D` URI parameter along with the `GH_TOKEN`
> =C2=A0=C2=A0=C2=A0 variable.
>=20
> Thanks to Alexander Kanavin and Antonin Godard for their review feedback
> so far.

I'm torn on this. I am leaning towards merging it however I realised
there are a few issues. Firstly, it is failing during testing on=20
Ubuntu 20.04 workers:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1129

Secondly, it adds support for putting the tokens in SRC_URI urls. I'm
not in favour of this since it encourages people to write them in
recipes where it is all too easy to unintentionally share them. I do
not think we should enable this.

Finally, the naming of the variable, GH_TOKEN is not in keeping with
the rest of the codebase. It needs to be prefixed so something like
BB_FETCH_GHRA_TOKEN which makes it clear it is bitbake, the fetcher and
the GHRA fetcher.

Cheers,

Richard



