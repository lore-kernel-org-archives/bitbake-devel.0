Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA18C4332F
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 16:47:14 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.55170.1671554828143380924
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 08:47:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VFzP2EsZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id v7so9238096wmn.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0cVl74DvUD60M4dzhyjJW6nxZdYqPjS2xyzulEO29w=;
        b=VFzP2EsZjr7ruQFg6Gew1CR2QOy0lAt1jfs9T6fN6IyaHyE3b0zx5fuO/s4ubNXMs7
         H6pHRt0KtcnhO0YBw18Qut73qxFMsgUHAYGC51UMKeKM4POryUcFc3kUwvYL9zNY2WCB
         WZ8LF1DzwJFkCXh6JXrUxscDbEWK+QLOPncdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0cVl74DvUD60M4dzhyjJW6nxZdYqPjS2xyzulEO29w=;
        b=KOX4gurDDOJVZ6kjivcemJpu57HBPtTZX3zxkjt6VqdTBtFddDCDlY70UaZ6+NJ75f
         SSo9iqMOuJbWv8DuvvkoJM59FFMJmXl2AiWfmkSEvIEAS8xCsz2NQGlBSzmldYw9r1FN
         GyXDy/YOtrYGPopM7nnY1NL/UaRkAHEUE1dZ1BDbbi+kMUaDML6ocyRiX12nCxCLiKzi
         R3IjfSbmYUYvXEDrCZVLultSpaEZDZbVo2s6nfFUsxCesbcf9Z0S2DTykmAgUQQHHc/D
         IbRSxtUrJVpvgjn9z60BHX7TyJ1837Qyzi0JR2GtchYWk4PByLOg2FLZoaurOaV6AE2N
         GJCQ==
X-Gm-Message-State: ANoB5pmsp3HIUeIm07lfsTkDL+ua1Pcns2kkjTkntY75lzoJjiH3vcO0
	h6KjIw0pPUau+AZNFdFE8iazxA==
X-Google-Smtp-Source: AA0mqf6ufqT2axnKMe3F0FEkSilqWQKvYVyYOTdzTRaC1XZmcMWnyv+I2bGWb0XIm4V332hfgcuEQA==
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr35144962wmb.33.1671554826505;
        Tue, 20 Dec 2022 08:47:06 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1273:dbb7:632c:a9de? ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003d070e45574sm16621764wmb.11.2022.12.20.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:47:06 -0800 (PST)
Message-ID: <1956eb01face066828ac1bb85663f83e797c31ed.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 4/6] event: builtins fix for 'd' deletion
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Dec 2022 16:47:05 +0000
In-Reply-To: <CAJdd5GbfF8ppFL7QZZ3F-XQconAtx0=uDhHd6MbqncbRo_yFeA@mail.gmail.com>
References: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
	 <20221220151604.415637-4-richard.purdie@linuxfoundation.org>
	 <CAJdd5GbfF8ppFL7QZZ3F-XQconAtx0=uDhHd6MbqncbRo_yFeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 16:47:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14217

On Tue, 2022-12-20 at 10:41 -0600, Joshua Watt wrote:
> On Tue, Dec 20, 2022 at 9:16 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > I've been seeing event handlers where 'd' seems to disappear half way t=
hrough
> > event handler execution. This is problematic when multiple threads are =
active
> > since this code assumes single threading. Add in a recursive lock to av=
oid
> > d being deleted from a context it shouldn't be.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/event.py | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/lib/bb/event.py b/lib/bb/event.py
> > index 21e9a1b025..5df5b3a3ee 100644
> > --- a/lib/bb/event.py
> > +++ b/lib/bb/event.py
> > @@ -68,6 +68,7 @@ _catchall_handlers =3D {}
> >  _eventfilter =3D None
> >  _uiready =3D False
> >  _thread_lock =3D threading.Lock()
> > +_builtins_lock =3D threading.RLock()
>=20
> Does this need to be a recursive lock?

Yes, in testing these can be re-enterant (think an event handler that
does a bb.warn()) so yes, it does need to be.

Cheers,

Richard

