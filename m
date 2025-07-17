Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A71C83F34
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 15:30:19 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.1803.1752766209591272748
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jul 2025 08:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GUvMGoCm;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32f1df5b089so10786051fa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752766207; x=1753371007; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo0BwhN1iDDmRgBM7++F4Zg9YvdHlgb1RIVmrI+HDcc=;
        b=GUvMGoCmyBBIeH178BW3J3w2lkp6Nk64N10iKIQV2j+QG2ZaWTz5z3wnkyaUgLJ579
         XgwiaKZhSzqKaQraOjgU8RU3+yxCDvM9fkWFBFJksovrjCA2/xzuAKSb5ykdjvWotTV3
         FixNiypr7yb3ofb9KL407srXeRzwPPcnZsWVlmSWETpjzNDFdThtPErW8kgkLatojxZh
         CER6/Hd3NFGepFt7xdgsk+c2imHzWNFwFVqAXk7QLdFAtabMUOSmHNY/W7NUN3v+NjMo
         0KJONkLYYx5zEF9Xuy0DlRL2E3OBB4D3fqoyHQVF4E4uhuk38/344yLqjZpsXxcn7OVj
         g6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766207; x=1753371007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo0BwhN1iDDmRgBM7++F4Zg9YvdHlgb1RIVmrI+HDcc=;
        b=P95InTFNDAB5z8fBi/ARHDsoIawyhtYxxuu3cfpOZfyWBYRXEdI/1lpl2udwsS62mf
         ODQM6agGkclAOByy3jI4cL/dK6lPmyim1Secx3/VNPB/+GU0eaCTwuvkgx2uBtjFt238
         MFAB83VYY+s22m4B5SN4VXp62pZ/fmeaCAmqGd8sLBfDTQxGhB+vPfmwCwKoARyCvNjB
         TZnBA1WY8ni1E1Y0ikozDSChSTgsiHLUeXzSBqS9BsxVqTt1pnzHrbGjfHDc0rkKKrzD
         hBww8f8zukmG7ijH2ZcoxmGz6NBCG0cKFDqUxPpQovloDthyJqiQcE9jw/XS1vT683BL
         Hqkg==
X-Gm-Message-State: AOJu0YxoKm+w0nBqOTD+BJOKurCaj4EeFirQGRMFyn7hf5iVHSmPXhk/
	B1UxzRj7TKm2GzSd4JmjBLIh+xDnqzeZgmsPGCpleC1CLTd18E40xIFccIsZBo84QeoEY+7Z4FV
	6XKiq8kkus4qg0jjsFHnAhhrY7YlwbHoJgw==
X-Gm-Gg: ASbGnctPDJC+6LVO+P0QRY1+FB+us/lH03pYGFpoafEycndFKxtwDZYB6Gdjs5avLJA
	TpXYoxI9l7EHxVOBbHN8deuKDNRM58izCCaTzU0XcryDvpjEjRqgXM6JZRwERHX5a2dCUMHxxXp
	nDarqfOWoFunhElpjy/77axypwSJIIFSTl2IcJXZkzSQNOcAb+oi+uyTr7HxochmUUxycSWq+rk
	5rCzKInvzgQ6q7oJo2PsA==
X-Google-Smtp-Source: AGHT+IGT+3RvRfwQuAxmwN4ani/Rg/+vV0JOeYHrQOtKT/r9tRqrrdDtPBqqcjT0uYK8+FrrOdaehEC2U6OzznSW0bs=
X-Received: by 2002:a2e:a01a:0:b0:32b:47be:e1af with SMTP id
 38308e7fff4ca-3308e58fc6emr17255631fa.37.1752766207259; Thu, 17 Jul 2025
 08:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250716152249.96126-1-richard.purdie@linuxfoundation.org> <20250716152249.96126-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250716152249.96126-3-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 17 Jul 2025 09:29:55 -0600
X-Gm-Features: Ac12FXxaalhW7x1a1YLWiLSoV0xT4ocdfMIxvTdMv_0tIPU6gELc56cV8ZzxEhw
Message-ID: <CAJdd5Gbdw72dDUkbmAdKraP9dsVriGA_JficMNC=_RA_yKDeew@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] event: Fix an event duplication race
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 15:30:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17786

On Wed, Jul 16, 2025 at 9:22=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> It is possible for multple bitbake threads to empty ui_queue in parallel
> leading to duplicate console messages and much confusion when debuging.
>
> Use the lock to extract the queue data which means only one thread will
> processing, removing the duplicate out of order messages.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/event.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index b29f0a55687..2256fed7648 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -236,9 +236,12 @@ def fire(event, d):
>          # If messages have been queued up, clear the queue
>          global _uiready, ui_queue
>          if _uiready and ui_queue:
> -            for queue_event in ui_queue:
> +            with bb.utils.lock_timeout_nocheck(_thread_lock):
> +                queue =3D ui_queue
> +                ui_queue =3D []
> +            for queue_event in queue:

Do we even need this code anymore? fire_ui_handlers() has a loop to
process all the events anyway (although, it looks like it probably
should have some locking also, maybe:

while True:
  try:
    i =3D ui_queue.pop()
  except IndexError:
    break
  fire_ui_handler(i)


would work in a lock-less way (or rather, use the GIL as the lock instead).

>                  fire_ui_handlers(queue_event, d)
> -            ui_queue =3D []
> +
>          fire_ui_handlers(event, d)
>
>  def fire_from_worker(event, d):
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17781): https://lists.openembedded.org/g/bitbake-deve=
l/message/17781
> Mute This Topic: https://lists.openembedded.org/mt/114186788/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

