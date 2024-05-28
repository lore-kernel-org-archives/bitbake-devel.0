Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA14C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 21:29:55 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.3082.1716931790085129670
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 14:29:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Movpm6Km;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so221971e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716931788; x=1717536588; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QugJW9DVxqS3MqZKxX8Ahd+F1z2Pqml4jGy+eVjwmjU=;
        b=Movpm6KmEpy3Pm8TxelY1TwOeu/FsMGv3j73m0r+bTZMA2xqtX2S6IQwk1NXRS6lD+
         8T84zDAJ1f2bveaUSfMPngWaXGenYjBgfSk5KX3ZwWdX+tLFgfyLDNUjMpQMKMgsL0s3
         YiSr1yvR11KBqOd7gztKdw41t6M13Pok5CT8WBI6GdMPjFzuwHMrxsgb6s7eU8rLeZ3i
         mnz27sOCVSc0UA92mC/T4Syew6nVkeqnGdqxkRHJgzZi77i4WA3rwcoOLEpB8Nogqqse
         qNIm0K6kITSGvKCuyKFETHP+W0NraSkeLueWptFe1S8eZDwX0ZprShQkgw8hrufv5Jr/
         kh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931788; x=1717536588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QugJW9DVxqS3MqZKxX8Ahd+F1z2Pqml4jGy+eVjwmjU=;
        b=A2mxVG696vrw5nn7i61+SlpJn1r/tuVaP1rnqE2L6OMeI/FQ9yBpQH2B4gTs3xBPel
         wqrtNOyjn+EcYQWLGUPD1/OUV5cLvb2RG4AIp/r5JVN/8quUssfLGfvgtbWiIo5YcqLH
         XR1qx+8xrXgZH+ED3ZwuYENgYHXO03pPE73TrzzYhcUOb0F/txy6IqwGbQWFuT9hZVrX
         gquyoInmiRyS110UQySxgSFgmo+DLChJsvNKpfvL01n7nLnyfYZ6GYOWtD6dvFCpRSeC
         jnVLbqY6RzKg6nEEVAqZOgVYD7E0X+I2gGizs1bCbIq7KwzI+6Lw5iKU2iFX2+bmpMP4
         oEdw==
X-Gm-Message-State: AOJu0Ywk6t6/Vb0+UzrDKkEOTwS+r7Hb5V+aV0V1Hl8ZvWFznyC2ikW+
	kPv6e0WPPa39XCchBxJnza5wx2PLuRDNODcQxOAcAhg59bsWQYIXt4d87AecyVLtaFSIET9wSlv
	kL2r06Jpc+yJUQkcqSyvclITMBnE=
X-Google-Smtp-Source: AGHT+IFmkb1GDSu2diFy6cUbfsYvCiKvTE9irfZE+L2z42U/zS5SAxqySg21oBpTgCr0d2srqAVbr22d+XwSzMpOcAQ=
X-Received: by 2002:ac2:5102:0:b0:51d:8ff3:f835 with SMTP id
 2adb3069b0e04-52a78e20b23mr63376e87.26.1716931787859; Tue, 28 May 2024
 14:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org> <20240528204420.2845521-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240528204420.2845521-3-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 28 May 2024 15:29:34 -0600
Message-ID: <CAJdd5GZa-YQOA9rRjyG1oiZjC9ZSUUa-xt_QVFnYER6o4kKeqw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] runqueue: Process unihashes in
 parallel at init
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 21:29:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16277

On Tue, May 28, 2024 at 2:44=E2=80=AFPM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> Improve the runqueue init code to call unihash queries in parallel since
> this is faster and more efficient, particularly on slower links with long=
er
> round trip times.
>
> The call to the function from cooker is unneeded since that function call=
s
> prepare() and hence this functionality will already have run, so drop
> that obsolete call.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py   |  1 -
>  lib/bb/runqueue.py | 18 ++++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 076ddaa58d..255b9f199a 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1459,7 +1459,6 @@ class BBCooker:
>
>                      if t in task or getAllTaskSignatures:
>                          try:
> -                            rq.rqdata.prepare_task_hash(tid)
>                              sig.append([pn, t, rq.rqdata.get_task_unihas=
h(tid)])
>                          except KeyError:
>                              sig.append(self.getTaskSignatures(target, [t=
])[0])
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 84a6f4172c..999868dd72 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1280,11 +1280,18 @@ class RunQueueData:
>          dealtwith =3D set()
>          todeal =3D set(self.runtaskentries)
>          while todeal:
> +            ready =3D set()
>              for tid in todeal.copy():
>                  if not (self.runtaskentries[tid].depends - dealtwith):
> -                    dealtwith.add(tid)
> -                    todeal.remove(tid)
> -                    self.prepare_task_hash(tid)
> +                    self.runtaskentries[tid].taskhash_deps =3D bb.parse.=
siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches=
)
> +                    # get_taskhash for a given tid *must* be called befo=
re get_unihash* below
> +                    self.runtaskentries[tid].hash =3D bb.parse.siggen.ge=
t_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
> +                    ready.add(tid)
> +            unihashes =3D bb.parse.siggen.get_unihashes(ready)
> +            for tid in ready:
> +                dealtwith.add(tid)
> +                todeal.remove(tid)
> +                self.runtaskentries[tid].unihash =3D unihashes[tid]
>
>              bb.event.check_for_interrupts(self.cooker.data)
>
> @@ -1301,11 +1308,6 @@ class RunQueueData:
>          #self.dump_data()
>          return len(self.runtaskentries)
>
> -    def prepare_task_hash(self, tid):
> -        self.runtaskentries[tid].taskhash_deps =3D bb.parse.siggen.prep_=
taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
> -        self.runtaskentries[tid].hash =3D bb.parse.siggen.get_taskhash(t=
id, self.runtaskentries[tid].depends, self.dataCaches)
> -        self.runtaskentries[tid].unihash =3D bb.parse.siggen.get_unihash=
(tid)
> -
>      def dump_data(self):
>          """
>          Dump some debug information on the internal data structures

Reviewed-By: Joshua Watt <JPEWhacker@gmail.com>

>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16274): https://lists.openembedded.org/g/bitbake-deve=
l/message/16274
> Mute This Topic: https://lists.openembedded.org/mt/106357289/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

