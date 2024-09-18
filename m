Return-Path: <jstephan@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0E2FC619B
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 07:06:06 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.9852.1726643165069504147
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 00:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=rpupDYZA;
 spf=pass (domain: baylibre.com, ip: 209.85.218.46, mailfrom: jstephan@baylibre.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d4093722bso32092166b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726643163; x=1727247963; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq1F7JH5DTJyDAeGUPBgM1ZiLtpxM5zFd9HkYL4YopE=;
        b=rpupDYZA47vz9yHp6/4E1U51JbTwtnetage2wzQq1L71iRVDpuAt73NhVIu1ay5GP6
         WG+YjI+r1GZ5qMgiCB/Ylj/d3acXtBXoJBmHXdUCUcgK8U7vt5xByjsBgdiigI1lwq/z
         hkyU4Jh7T+06VV2uoc7BhTPU9iONucWsU0AP/5zSLyY9uXc/lxWAaIfdXRu9b3ELlH04
         mmyEmsb9ja+7UPxAh8XeEyCoVa47HnniPX0KA4fkSktzCEIqlojRxpocFs+j2fg/5yXi
         fMhXIAIqdOKwob0n+piY6mxsstSzDk2AAP3lVXkuCzLvM+FoAQEpNfC0rjmbJID+sGZb
         524w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726643163; x=1727247963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq1F7JH5DTJyDAeGUPBgM1ZiLtpxM5zFd9HkYL4YopE=;
        b=urEHCAvKooYVjuCGbNbxxJpW4M433dZmER8xjc6QkmCFKTMdOB2MEBW/aCy+ttvqdO
         6qY2DzE/APlrWFDZ4ZLyEGe0n8DVs/VvB9Z/B2bISmyHoI0lGUs875gVwHqycEr/BBYS
         Jt11l+1iB7AbH4i1sw5l+EaqirMGWyrjj1YIYAjEixRE8/o8rR4tnEV40WggqNydcy+6
         muY0u3U5vLsoj5INoZK9HRM3n4VRf9T4+mZlpn4a3YhO5dq/2ujfhZBanOMavrrWaigT
         oDKyNfEF3h2nbw5I8J6Ayx9NbKjxqOtGzCzBEsx91ajCFipsxZ+ozlBBp+Wfufl2QczL
         SF7w==
X-Gm-Message-State: AOJu0YxQqp46iSDMzm2IBLDj02LQ2N2RMi07/S9lOBIckAW+tDlE261L
	GaQMNrnnPqVGF0ja5zzBMDqPR3KVEKoWGbrUGlS9oRJ0wK3iI7KB/Zo4rq3vlb9y7kGdhi/Nt27
	KDRz7I3YLGy9i8A0xDVRaN+d3coaOqyL0kQS8sA==
X-Google-Smtp-Source: AGHT+IFLwv9OPlN+hU1oVwH3ip3ZDPdRwHL24sNJ9f2Pgeu4DdKyYlKcjLuJEP7Vq9BS5AYy+Hd4bntak0x2M1WQs70=
X-Received: by 2002:a17:907:e268:b0:a8a:91d1:5262 with SMTP id
 a640c23a62f3a-a9029490283mr1957225266b.28.1726643162975; Wed, 18 Sep 2024
 00:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240917151157.780068-1-jstephan@baylibre.com> <b911e5bef3e661b976d6a5822e9fa2941d2e90d7.camel@linuxfoundation.org>
In-Reply-To: <b911e5bef3e661b976d6a5822e9fa2941d2e90d7.camel@linuxfoundation.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Sep 2024 09:05:51 +0200
Message-ID: <CAEHHSvZigPQTmPwHP-vom2ybOXoXQm3NhCsUyFLW0n9H2t3VxA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: add documentation for
 "bitbake -S lockedsigs"
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 07:06:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16568

Le mar. 17 sept. 2024 =C3=A0 22:55, Richard Purdie
<richard.purdie@linuxfoundation.org> a =C3=A9crit :
>
> On Tue, 2024-09-17 at 17:11 +0200, Julien Stephan via lists.openembedded.=
org wrote:
> > The following commit added "lockedsigs" as new signature handler for th=
e
> > -S option of bitbake:
> >     2cf13f25139 - lib/oe/sstatesig.py: dump locked.sigs.inc only when e=
xplicitly asked via -S lockedsigs
> >
> > But it was not documented anywhere, so add some basic documentation for
> > it in both the .rst documentation files and the help message of bitbake
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  .../bitbake-user-manual-execution.rst               |  6 ++++++
> >  .../bitbake-user-manual-intro.rst                   | 13 +++++++++----
> >  bitbake/lib/bb/main.py                              | 12 +++++++-----
> >  3 files changed, 22 insertions(+), 9 deletions(-)
>
> Unfortunately I don't think this is quite so simple. The lockedsigs
> support is implemented in OE-Core and BitBake doesn't contain that
> code. This makes it very hard to accurately document since it is
> metadata dependent.
>
> I do agree we need to improve this somehow, I just don't know how.

Hi Richard,

Maybe we should remove this from bitbake and implement it using bblock? :)
Let me know if I can help on this!

Cheers

Julien
>
> Cheers,
>
> Richard
>
>

