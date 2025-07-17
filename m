Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D454C83F1A
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 15:34:09 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.1897.1752766440589422153
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jul 2025 08:34:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G+9kNWza;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d6ade159so7879755e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752766439; x=1753371239; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EfJjpnlO6oi0lnOkJKRmHZFluoTzb6tIGGvwmgUeCZg=;
        b=G+9kNWzaCrTIDjoLImBR25K3GNSpwPpTtzvGFZ22FXD9rQbtwCQMs6gV2bkRsdFLbh
         HygFtquHM8W9yXltcJhNzKOowfefZzzyp5Q+dg079nA0iA+jzXeFc5UoOaV9TbvvCcBN
         IUzcK98YQWkFY5larDDE7S2reeJgMD+h8EVxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766439; x=1753371239;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfJjpnlO6oi0lnOkJKRmHZFluoTzb6tIGGvwmgUeCZg=;
        b=gXU7CW9fF8C91rkQRw6U9k8eq4t/2yOPQjaqg6zWgyCOcCGolk9sW/rvbKQ7Lt9MT0
         aNypeFCzWKs2SQ4Cno31S2JJYNmHIxttoRRufVyrK0GkVUGzUIcRyM+wewPpOYuid7M7
         yYkFxCaZ2dRG+uT/niYVrZWxQ9JG9gW4zrD05QkeHShv1jMnkxXzGy5fNlNBY70DPFug
         WkOyhBvywQaOZHd/eQryyCcb/EIYAvbqWTX+gGXkCfyYbtRbYRBqvt7+LfUI7hH4Fu4+
         bSSgwzdRxLkXwkypaIsZuHWrCTKQ5w1ZNAwTITFwgok5YHRwKrJO0/ZBgghW1AkARdAw
         X9dg==
X-Gm-Message-State: AOJu0YxcEuRnM5E5JdS58DbyI14WQwIUEUUA10MaFrbfx7Mf0IpdCoWq
	ywr7le3WtxkyuAu9vHB+vUbf1OQ0kJrk6+n/uIppNYAt3X4FQ3+rQ7ocq9OvuFvwQ3s=
X-Gm-Gg: ASbGncu3EFriAc7aPSVRs6VHdKUA/utRbISHCchMYJhcN7EKKsNcuveamX2CZ60rqXv
	Rvt7ijBtlqoHnCcNG6W92FibhYTat7ceA55nu3glE/Hh5ficLFMbe8vX72BFrNZ2i6E46i0newX
	JowOTkOblVwWInPNh0um0BQHVVgkjU5K8LEmwVWVs6x0yDcKYOScsrMKNlVdT3KeM+1nKdaKRbQ
	O2YKpJcrppaPz0fB3hCw5FiIdnPYAbE4q7OmZUTxROzpksDA/oeycXsvcNhO0c+wQ/lcIvDpWLU
	wWfLqHxLIn/Tuc8WiiOE1bYwUHsqRxLsRfH6pPCOKwXkKb7/jd/ve59P17ErBvY/wcU0Sx1IWAt
	8GKWbtq36nwvv7FS7wsTxbW0uI2DTFLzt87rnAbptnjaivXLXjPvVjHkP/5iDc79/IK4ZdH8Qqy
	cEq4RhJeQZwdM=
X-Google-Smtp-Source: AGHT+IEYXC/C/UEkh2OqwYxpdOyRKyFw2ECZjx9oSL3ZhPgkWPo9osAB7dgGwyYrmTiQN0THQGzuFA==
X-Received: by 2002:a05:600c:3b88:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-4562e355c9bmr74334995e9.14.1752766438737;
        Thu, 17 Jul 2025 08:33:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c05c:a45d:32ee:c317? ([2001:8b0:aba:5f3c:c05c:a45d:32ee:c317])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600a39281sm13356454f8f.73.2025.07.17.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:33:57 -0700 (PDT)
Message-ID: <17628c32b3e1edada0fb9c078a9a7b311f512b6c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/4] event: Fix an event duplication race
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Jul 2025 16:33:56 +0100
In-Reply-To: <CAJdd5Gbdw72dDUkbmAdKraP9dsVriGA_JficMNC=_RA_yKDeew@mail.gmail.com>
References: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
	 <20250716152249.96126-3-richard.purdie@linuxfoundation.org>
	 <CAJdd5Gbdw72dDUkbmAdKraP9dsVriGA_JficMNC=_RA_yKDeew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 15:34:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17787

On Thu, 2025-07-17 at 09:29 -0600, Joshua Watt wrote:
> On Wed, Jul 16, 2025 at 9:22=E2=80=AFAM Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >=20
> > It is possible for multple bitbake threads to empty ui_queue in paralle=
l
> > leading to duplicate console messages and much confusion when debuging.
> >=20
> > Use the lock to extract the queue data which means only one thread will
> > processing, removing the duplicate out of order messages.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0lib/bb/event.py | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/bb/event.py b/lib/bb/event.py
> > index b29f0a55687..2256fed7648 100644
> > --- a/lib/bb/event.py
> > +++ b/lib/bb/event.py
> > @@ -236,9 +236,12 @@ def fire(event, d):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If messages have bee=
n queued up, clear the queue
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global _uiready, ui_qu=
eue
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if _uiready and ui_que=
ue:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 queue_event in ui_queue:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wit=
h bb.utils.lock_timeout_nocheck(_thread_lock):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 queue =3D ui_queue
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ui_queue =3D []
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 queue_event in queue:
>=20
> Do we even need this code anymore? fire_ui_handlers() has a loop to
> process all the events anyway (although, it looks like it probably
> should have some locking also, maybe:
>=20
> while True:
> =C2=A0 try:
> =C2=A0=C2=A0=C2=A0 i =3D ui_queue.pop()
> =C2=A0 except IndexError:
> =C2=A0=C2=A0=C2=A0 break
> =C2=A0 fire_ui_handler(i)
>=20
>=20
> would work in a lock-less way (or rather, use the GIL as the lock instead=
).

We do need this to queue things before the UI handlers are present.=C2=A0

There is actually locking present elsewhere in the fire code, it just
works on a per event basis rather than for a group, hence the code
difference.

Cheers,

Richard


