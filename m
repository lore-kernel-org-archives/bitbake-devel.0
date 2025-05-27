Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3CBC54F30
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 08:11:17 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.46265.1748333467345479098
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 01:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MKTpFclM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a36e0d22c1so2020347f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748333465; x=1748938265; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjqVSf60HuKCKLGeFACPmdyBz5vPmDPI124qkES29EE=;
        b=MKTpFclM1ArhmeS27c1o7ILgh+G37LH754nzKORWF9oRb5UGyRQ6d0T3387AlHNQQq
         XvIzPkTLpvvjucm32TN94BEw+Y6KqLeo3gVJW3WQbFTvTD+Nb/MjvDLRySVfjU/FuvFt
         cyx/cUKVVSphmTVBdZoq1Lw9nRTOPuBukCdBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748333465; x=1748938265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjqVSf60HuKCKLGeFACPmdyBz5vPmDPI124qkES29EE=;
        b=KPoO4RZljxUSc59hAb2LZAsgYcb54NKTcE8cZrMWH1uy5e0KwS5kWlTzozj0ZUkwJs
         knpV4nrEFTYoPWSXZwlWRTVSP9msqiIbxTkaeyQXkI9UtaI7nYGr1KiD/IqJYitmpbwv
         b/75j+tUhVWSKd5YzgIrm0GGj14kDbFlVfUKbHTgi6XxTBQRlMH4QyHmMCPiJt4kuktt
         5isxf2nUXU94wb/i9ChJFowhi/GVR2wso+4IQjdu1kDMU0IWlgWdIxMEAgFrV2SGbRCl
         w26OqXPM7CvR/Hwhc7Wg5ZPWp5fzZ4k22jOGxBYc5/7nXFHbBhCKnMgG7cvw0jfQ4wfj
         Rf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUVVvQfo51nChS8ZeDxfw3kDBcAoj5PLhlS7hPyh4/oS981g9/vF3H5igQsn/LewtXxjhG4ZLNg4Lnfzs9k@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxjs6pxQow6CrYs9GobfdJ4gVjSOY6QVE1dLuMt3ZcrRj6qzMMU
	cj7AFH8AYI+z5J6qtvKKRUnoaEvOEwbi4i4t35WorOL/zxkTQHzhUrtX93ODDr7fckg=
X-Gm-Gg: ASbGncsDXJ+bfX5YJcrUqa70m58Q+AaNbzVD5t0FwP6yJeUxTFpWbvmVf590xbQujIA
	z0+sBuUKZIImCCeNS7owMehH81PF2vnI+Do29ncqll9vQiCRqxq0i64zZwCCJIcGKjDf5AV0183
	n5YIFcF0QuRONWockxYCyGTmxFGnjQl/mylwucJJnjjUPkRZLU+tb1L/tUEesAhFIz8Uj35KANZ
	+puIADfUeVlTM2bH2x3A49N+MzMshGfa/UENzp4RtIrsryEKZ/DmH5xkQZGgosPrmizzDU3YTwZ
	+4+f2uiCFfzNATtaAEbuFuMohTx5qLqwxGmXQS/qSmyoNKH5H3LYgNp33IMlC70KD3fBTdCcsQT
	NNJz0srTOHVsE3ueflrI5qxBbI8Gu7PPFYmSL3oSo
X-Google-Smtp-Source: AGHT+IEmu7wa+xbJWD8CtBCT3sCA7fOMMmcNO9NuXafd4AKJJPIk3g7etln0dawIwlKiaghCty9zNA==
X-Received: by 2002:a05:6000:40df:b0:3a4:d18b:736f with SMTP id ffacd0b85a97d-3a4d18b753fmr7428679f8f.56.1748333465353;
        Tue, 27 May 2025 01:11:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6923:f643:8186:933b? ([2001:8b0:aba:5f3c:6923:f643:8186:933b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4ceecddcesm9346320f8f.99.2025.05.27.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:11:04 -0700 (PDT)
Message-ID: <d317516d9184fc3d304f1c21577d0503e06e93cb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Allow pressure state change
 notifications to be disabled
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mac@mcrowe.com, bitbake-devel@lists.openembedded.org
Cc: Jack Mitchell <jack@embed.me.uk>
Date: Tue, 27 May 2025 09:11:03 +0100
In-Reply-To: <20250523145205.3542264-1-mac@mcrowe.com>
References: <20250523145205.3542264-1-mac@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 08:11:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17643

On Fri, 2025-05-23 at 15:52 +0100, Mike Crowe via lists.openembedded.org wr=
ote:
> Allow setting BB_PRESSURE_NOTE_CHANGE =3D "0" to disable NOTE messages
> being emitted every time the pressure state changes. The previous
> default behaviour is not changed.
>=20
> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> Reviewed-by: Jack Mitchell <jack@embed.me.uk>
> ---
> =C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 7 +++++++
> =C2=A0lib/bb/runqueue.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A02 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 477443e22..cd81a586e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -574,6 +574,13 @@ overview of their function and contents.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 might be useful as a last resort to =
prevent OOM errors if they are
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 occurring during builds.
> =C2=A0
> +=C2=A0=C2=A0 :term:`BB_PRESSURE_NOTE_CHANGE`
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default Bitbake emits a note message e=
ach time the scheduler
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decides to stop or start scheduling new t=
asks due to pressure
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 changes. Setting :term:`BB_PRESSURE_NOTE_=
CHANGE` to "0" stops these
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 messages.
> +
> =C2=A0=C2=A0=C2=A0 :term:`BB_RUNFMT`
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Specifies the name of the executable=
 script files (i.e. run files)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saved into ``${``\ :term:`T`\ ``}``.=
 By default, the
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 8fadc8338..306814fd6 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -218,7 +218,7 @@ class RunQueueScheduler(object):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
pressure_state =3D (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memo=
ry_pressure)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
pressure_values =3D (round(cpu_pressure,1), self.rq.max_cpu_pressure, round=
(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq=
.max_memory_pressure)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ha=
sattr(self, "pressure_state") and pressure_state !=3D self.pressure_state:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if se=
lf.rq.note_pressure_state_change and hasattr(self, "pressure_state") and pr=
essure_state !=3D self.pressure_state:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bb.note("Pressure status changed to CPU: %s, IO: %=
s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake thread=
s" % (pressure_state + pressure_values + (len(self.rq.runq_running.differen=
ce(self.rq.runq_complete)), self.rq.number_tasks)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.pressure_state =3D pressure_state
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_press=
ure)
> @@ -1864,6 +1864,7 @@ class RunQueueExecute:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.max_io_pressure =3D=
 self.cfgData.getVar("BB_PRESSURE_MAX_IO")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.max_memory_pressure=
 =3D self.cfgData.getVar("BB_PRESSURE_MAX_MEMORY")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.max_loadfactor =3D =
self.cfgData.getVar("BB_LOADFACTOR_MAX")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.note_pressure_state_chan=
ge =3D (self.cfgData.getVar("BB_PRESSURE_NOTE_CHANGE") or "1") !=3D "0"
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.sq_buildable =3D se=
t()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.sq_running =3D set(=
)

I've resisted taking a change like this in the past since firstly, we'd
otherwise get complaints about "why is bitbake not executing anything?"
since it becomes unclear why bitbake isn't doing anything. The second
issue is that if you're seeing large numbers of pressure messages, your
configuration probably isn't right.

I'm also never that keen on single use variables like this.

I'm therefore torn on the patch. I can see why you're asking for it,
that doesn't mean it is the right thing to do though...

Cheers,

Richard

