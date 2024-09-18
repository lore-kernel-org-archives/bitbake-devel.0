Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283ACCD18E
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 08:08:46 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.10257.1726646925259951180
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 01:08:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cRedUkoB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so4160922f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726646923; x=1727251723; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V0O8wPhFym+BQ/c6de91sEkdlWIzz/DH93Uzhs0Nstw=;
        b=cRedUkoB8OM/YhXoV+B/DVB+0W7iNbSYeqCbUtyHRqsvZWjJzENaPrtmZGXuIfuLch
         EC9Uus6s8m41s6Ln6B/TIIwZQk+kgKBq3TomL+KUi4hlPCAoJ1xUYWw/uzLj6RM3pY1I
         wgfWS/blML4yHqmRFbOAS+LBsDmSv8HT2bfqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726646923; x=1727251723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0O8wPhFym+BQ/c6de91sEkdlWIzz/DH93Uzhs0Nstw=;
        b=X0dWjcCXnLJ+SiUYeX+ovaW6NcJ3pWL/aivI9/LzhThVpBXcC4W+GpbHhnxoF0RSmt
         AMeQnKNIT6N4MHSrRceXoTU92Yrt7nB5cjkFCct1duqKcYTG5YuvxGZf+ymUN8Ldl+Z3
         HiU0yFloavcpGt3Jx73e8Ohue8ku6FcPoXGtxm+lPfSXpxD9PpJsPv2t17E/0PFz2P5g
         WLLXZJ+/xMKEmnltFm7fprNYqItbvP77SsDSG1Ih6B9QycHy2Q/Y9DdjW4MTq+WiT0J4
         uf59d/yfm7GG4zXXTg744BG9xpiEKlWNzvNM6A+BwrzCa7U8VyZzmxqM3HD24aDA+jxg
         UlXw==
X-Gm-Message-State: AOJu0Yy2khmIVb+gaDgniqw5Ci14XU62JFca+lYqCVPSPRiFF7gpqwy7
	gusSmkGZI9Tb0+N2/E+wiZt20XlbU2fKnqdEZ6kpUfdWZNVxFu1xEilRoFfEUfA=
X-Google-Smtp-Source: AGHT+IFAKu2g+FOQejkRS25fPm3WUBXG/xVz1Sl8FcUm1vTr1n+eF5lH6lrvxrbf9PuMXBOfG9dSsA==
X-Received: by 2002:a05:6000:1241:b0:36d:2941:d534 with SMTP id ffacd0b85a97d-378c2d4d759mr11346994f8f.36.1726646923375;
        Wed, 18 Sep 2024 01:08:43 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:84e0:f160:18f9:5089? ([2001:8b0:aba:5f3c:84e0:f160:18f9:5089])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805337sm11591985f8f.104.2024.09.18.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:08:42 -0700 (PDT)
Message-ID: <2a431a522b46432ac01a45dec140dd96815497d7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake: main: add choices to
 restrict -S parameter
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jstephan@baylibre.com
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Sep 2024 09:08:42 +0100
In-Reply-To: <CAEHHSvYBQQEdTCMdqTNUnswV+vbcb-i5gNwq_6y7Nufqx2hE4g@mail.gmail.com>
References: <20240917151157.780068-1-jstephan@baylibre.com>
	 <17F610BFBC886D2E.8168@lists.openembedded.org>
	 <CAEHHSvYBQQEdTCMdqTNUnswV+vbcb-i5gNwq_6y7Nufqx2hE4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 08:08:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16573

On Wed, 2024-09-18 at 09:54 +0200, Julien Stephan via lists.openembedded.or=
g wrote:
> Le mar. 17 sept. 2024 =C3=A0 17:12, Julien Stephan via
> lists.openembedded.org <jstephan=3Dbaylibre.com@lists.openembedded.org>
> a =C3=A9crit :
> >=20
> > Currently, available -S parameters are "none", "printdiff" and "lockeds=
igs",
> > but there is no check on parameter, so user can literally give anything
> > to -S and it will act as if "none" was specified.
> >=20
> > Fix this by adding the allowed values in choices for -S parameter
> >=20
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> > =C2=A0bitbake/lib/bb/main.py | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> > index 1f4313fa0dd..24758646eaa 100755
> > --- a/bitbake/lib/bb/main.py
> > +++ b/bitbake/lib/bb/main.py
> > @@ -213,6 +213,7 @@ def create_bitbake_parser():
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 exec_group.add_argument("-S", "--dump-signatur=
es", action=3D"append",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 default=3D[], metavar=3D"SIGNATURE_HANDLER",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choic=
es=3D["none", "printdiff", "lockedsigs"],
>=20
> Richard,
>=20
> Should I send a v2, dropping lockedsigs? Or should this patch be dropped =
also?

The comment applied to the series, I can't merge it as the handlers are
metadata specific. I think we might need to ultimately move this
functionality elsewhere and drop -S entirely.

Cheers,

Richard

