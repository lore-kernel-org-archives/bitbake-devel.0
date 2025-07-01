Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05CDC83038
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 21:23:28 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.8674.1751405007370286981
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jul 2025 14:23:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QitB0Q2t;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45363645a8eso42821075e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751405006; x=1752009806; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NXpaS0Bq1tOL355J5X+D32e46yon6O/qiRGPfnOHbxA=;
        b=QitB0Q2tGlM3v9h3/AVjq0pqkARqrpNNv8Y1RKw8NVBvC7DsmrzltLjwuHdhhYqLWu
         NeO/1JEkVa/tyAJ9AaLDYMk4k5/JkhjUnphXisjBiZlWW+TcBNLOgOTowUHJLs97LzdN
         Z4GBCJFOBBMT0l0WPAfZzk/UvfGXYPeU221qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405006; x=1752009806;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXpaS0Bq1tOL355J5X+D32e46yon6O/qiRGPfnOHbxA=;
        b=MJhCSHo43aJlKQSb56AFk34OJct1k2kQAPzYocllQJCXPx3O/Oso9n8MIvp8VuU9pU
         cAiTwk6ur0ZzLkafao3zPFq/S6X8WBYqUikiyICqJ7k5hdFuCWJ0gZHWhoVf96XoJ5hN
         ToR8Cj5Cgct4CqlJ5a6xnSZq54MonK2s96/o8cr16e+0lWUhi2pBborf/cnStBO9JkF8
         YUsyWiKcrLGaL92J/zhzo+VBbuC3mdhIa4lV47B8SJCCeDSoPE12Zl8+PUJaBM9Fh5nU
         2M+MMlwYBSnXkSDpB3Tz8h4V6q1eYkDiDq3xF2x0d4gIByQzMZ+P6+uFfAmdA+SoA/un
         /L4g==
X-Forwarded-Encrypted: i=1; AJvYcCXYtnGXoHENdhv3i/Do67SBUlgAMSQv7LS9Xtg6r3PzO8eeISLpKlIGnYuUJoq5EeTBE6Mw6Omx5uDsHDvd@lists.openembedded.org
X-Gm-Message-State: AOJu0YzF/BGkHtzDQWdy/rYh+Igw7rvXLylrtKbEzsumpJwj9T0m5Tk+
	9fd9y/H+LsvED08Vcalw2MwcaJKuJf5XoPgqGP4n2mxwk/MeX4ozf/D25VczyQPa+NI=
X-Gm-Gg: ASbGncukoue7Y7DJLYsPhDZH97CzPYZBrm+UiFsqgUzriL+GfCc1m0M89HaC/IprDOM
	tSqn8GCnipNRqBmb5z53SbZbx/LI8+p1GuFh9Bxc23H0+UqnVJ4I17Cio7oq1qSOr43IgyogoHb
	lCUXS4hnfkWROg/2Xzqagbml3+5retH2SFm/e7Pepb4YhOOQur2fFbi3v1YMz4AN1MlJeapIsF3
	SxaPqEmoigK89Inx3l30eUG1EQoo4tV/vJyDiAmUR1sI7mOgofjOPQebrYcM6l/+xtMq70Oocnk
	yeq6DGIef2aPlpYOKEBkWhU94wmyA0ehoCG88D91zbyhgcfqxDfKVQ9g13DggBtUfpOcsYqPmGF
	f30fVHfdJ9WHOL33nRzpaq84CR0n7AUdgDkFaHsCIhLfoKqRRGp8=
X-Google-Smtp-Source: AGHT+IFiV9OdoVeVTCCxGubuOmaSpwQqq5Aqyi2fG6zg0fwBX4WS2mDxChnmcQ3S2VTtj7o37q0sGA==
X-Received: by 2002:a05:600c:8219:b0:44a:b793:9e4f with SMTP id 5b1f17b1804b1-454a370befdmr5286915e9.19.1751405005688;
        Tue, 01 Jul 2025 14:23:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:62fa:d15d:397d:870e? ([2001:8b0:aba:5f3c:62fa:d15d:397d:870e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b30dsm206898385e9.12.2025.07.01.14.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:23:24 -0700 (PDT)
Message-ID: <e0ec39370f30659958447e6a5def8d88d3dc4649.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: show the current pressure as
 debug messages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 01 Jul 2025 22:23:23 +0100
In-Reply-To: <20250701-pressure-messages-v1-1-bebffe123676@bootlin.com>
References: <20250701-pressure-messages-v1-1-bebffe123676@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 21:23:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17734

On Tue, 2025-07-01 at 11:53 +0200, Antonin Godard via lists.openembedded.or=
g wrote:
> The current pressure logic only prints pressure information when the
> limits set by BB_PRESSURE_* variables are exceeded. But in order to
> determine the best pressure limits for a given host, it can be useful to
> monitor pressure information after setting BB_PRESSURE_* to the maximum
> (1000000) and get a sense of how high the pressure can be.
>=20
> Add three bb.debug() calls showing that information.
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> =C2=A0lib/bb/runqueue.py | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 80f3d3282f..cae4bfa3e5 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -206,6 +206,9 @@ class RunQueueScheduler(object):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cpu_pressure =3D (float(curr_cpu_pressure) - float=
(self.prev_cpu_pressure)) / tdiff
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 io_pressure =3D (float(curr_io_pressure) - float(s=
elf.prev_io_pressure)) / tdiff
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 memory_pressure =3D (float(curr_memory_pressure) -=
 float(self.prev_memory_pressure)) / tdiff
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current CPU pressure: {cpu_pressure}")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current IO pressure: {io_pressure}")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current Memory pressure: {memory_pressure}=
")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_cpu_pressure =3D=C2=A0 self.rq.max_cpu_pre=
ssure and cpu_pressure > self.rq.max_cpu_pressure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_io_pressure =3D=C2=A0 self.rq.max_io_press=
ure and io_pressure > self.rq.max_io_pressure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_memory_pressure =3D=C2=A0 self.rq.max_memo=
ry_pressure and memory_pressure > self.rq.max_memory_pressure
>=20

I'm torn on this, debug messages aren't without their overhead even if
not printed. How often do these end up outputted? If nothing else there
should be one bb.debug call and not 3...

Cheers,

Richard

