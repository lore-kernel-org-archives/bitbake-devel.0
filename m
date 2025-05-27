Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB4C54F30
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 16:07:53 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.56023.1748362068678310676
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 09:07:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WCkExFdX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso29267315e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748362067; x=1748966867; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtuxI+1QVEPk277zrjlrqWd+Kyt/eFehUPJut+t/PBA=;
        b=WCkExFdXuvx69+xF3ZRKr1v1FVKwoA6DMrPndi2ZpMcSrAJ+MKrdThnGU60kIIOXyy
         f8zOtG5R6S5HI00TEYKREuK9Jg0WUDN5OyJ0Ve2gtdSNoJsFHnFOkcUIvi38uzKi9Kra
         DhOVM/7XU6Q0VtUM1YfDOeaLkvjEdG2AONJvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362067; x=1748966867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtuxI+1QVEPk277zrjlrqWd+Kyt/eFehUPJut+t/PBA=;
        b=oLPPEjjQG33W/K09wVTqBpoYmFEhrWuWfzTOdT9OGxqzTIyjc0t/QbrxQ6amXzn0hI
         3Syh8PVcNO8dg6tYkB896SPTFbFvSrAaGA6blSFBiqXf4DfOSMO2LIdymrugrZuJXAN+
         PHekY4dQF2cBiHsJwYJTLIuEFtAIzQrk/TG1ekY/eVrp5xTJEAHbyBVS6KcPGZ9fDjQk
         zfq9ZcKu5nN0Y+e4fTVTPmXGMfqTeLo6qjwAn3LAFp6xJK0GQ9QwaHERRqa6lImHAYVq
         Q6chycV2lzO6UT1/DYxO0EC7APkLy6f/2UvlPDbc0u5Noc225tqQdlC72JUDnHt5Mku6
         ITeQ==
X-Gm-Message-State: AOJu0Yze3v82ZqGaQzWDQQrlJdbbnQNMGtBfhX4vTfcoyMdSx81xErXO
	7pZ2l8EJlJaaENRqUjhdQehI/PZgEpVkIo9an2DrseFc2Ec03AKoJIvosjn1dIrAHnKhMgv1dyE
	nLiL8thE=
X-Gm-Gg: ASbGncvBcZ7ejN4Lp+Za7rjAYP23vjfETWle0spb1W+L51CfQcMlEFkh0PB2b1a4AOf
	vldtMsBdcw/VXjB/5esEcVaHW5KJzN6pGZm9tw7zS7LClNcg6pZeds+BL3Tl/dVAix0P5sF1fni
	p4q1Lp8ppXf/3Ve8Qv5+dRyCUEWsi5BNF2DJd4rsIGQEhW/N5dqZPHLeknO7eq1/EAq5Kv9+sNt
	YRuLlUW+sds6TYunrK/tFwzrK21cwP76GrWXUwdN+7mtcXvTDcze38AV5ILDBLCG7dupe4wZLDd
	ikbeyHUmIY6BM2GclLD+WKZbEqapvQN54UMN10yGykgjfTrExANrtkYuHUu5jsClrf1n5BR9NiC
	dK5DIMF/kV7rvEbxDC/OY2AVo/UTtuOijl6nwr1Sj
X-Google-Smtp-Source: AGHT+IFNeWK5uPayNegLCc27B4oxlWiRLUC3rBwXAwNwviRmvfoQxLXlQfQr9wvlVeSoZGoiVTvdOg==
X-Received: by 2002:a05:6000:430c:b0:3a4:dd63:4adc with SMTP id ffacd0b85a97d-3a4dd634c23mr5985643f8f.38.1748362066900;
        Tue, 27 May 2025 09:07:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6923:f643:8186:933b? ([2001:8b0:aba:5f3c:6923:f643:8186:933b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44f706b9065sm49998145e9.13.2025.05.27.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:07:46 -0700 (PDT)
Message-ID: <adfa0b4e7e456937f9fe5cea524ddb0f773c4c6c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Allow pressure state change
 notifications to be disabled
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mike Crowe <mac@mcrowe.com>
Cc: bitbake-devel@lists.openembedded.org, Jack Mitchell <jack@embed.me.uk>
Date: Tue, 27 May 2025 17:07:45 +0100
In-Reply-To: <aDXY_Vp48EnDDP9-@mcrowe.com>
References: <20250523145205.3542264-1-mac@mcrowe.com>
	 <d317516d9184fc3d304f1c21577d0503e06e93cb.camel@linuxfoundation.org>
	 <aDXY_Vp48EnDDP9-@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 16:07:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17649

On Tue, 2025-05-27 at 16:23 +0100, Mike Crowe wrote:
> On Tuesday 27 May 2025 at 09:11:03 +0100, Richard Purdie wrote:
> > On Fri, 2025-05-23 at 15:52 +0100, Mike Crowe via lists.openembedded.or=
g wrote:
> > > Allow setting BB_PRESSURE_NOTE_CHANGE =3D "0" to disable NOTE message=
s
> > > being emitted every time the pressure state changes. The previous
> > > default behaviour is not changed.
> > >=20
> > > Signed-off-by: Mike Crowe <mac@mcrowe.com>
> > > Reviewed-by: Jack Mitchell <jack@embed.me.uk>
> > > ---
> > > =C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 7 +++++++
> > > =C2=A0lib/bb/runqueue.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> > > =C2=A02 files changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variable=
s.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > > index 477443e22..cd81a586e 100644
> > > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > > @@ -574,6 +574,13 @@ overview of their function and contents.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 might be useful as a last resort=
 to prevent OOM errors if they are
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 occurring during builds.
> > > =C2=A0
> > > +=C2=A0=C2=A0 :term:`BB_PRESSURE_NOTE_CHANGE`
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default Bitbake emits a note messa=
ge each time the scheduler
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decides to stop or start scheduling n=
ew tasks due to pressure
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 changes. Setting :term:`BB_PRESSURE_N=
OTE_CHANGE` to "0" stops these
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 messages.
> > > +
> > > =C2=A0=C2=A0=C2=A0 :term:`BB_RUNFMT`
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Specifies the name of the execut=
able script files (i.e. run files)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saved into ``${``\ :term:`T`\ ``=
}``. By default, the
>=20
> [snip]
>=20
> Thanks for considering the patch.
>=20
> > I've resisted taking a change like this in the past since firstly, we'd
> > otherwise get complaints about "why is bitbake not executing anything?"
>=20
> The comment in next_buildable_task implies that at least one task is alwa=
ys
> running (or shortly will be). Perhaps you didn't mean the complaint to be
> taken completely literally though? :)

Being specific, "why is bitbake only executing one task" :)

> > since it becomes unclear why bitbake isn't doing anything. The second
> > issue is that if you're seeing large numbers of pressure messages, your
> > configuration probably isn't right.
>=20
> I get hundreds of lines of pressure monitor changes when building even a
> single large recipe that can take about an hour. It's always the CPU
> pressure that has changed.
>=20
> The last time I looked I couldn't find much guidance for setting
> BB_NUMBER_THREADS, BB_NUMBER_PARSE_THREADS, PARALLEL_MAKE and
> BB_PRESSURE_*.
>=20
> We currently set PARALLEL_MAKE, BB_NUMBER_THREADS and
> BB_NUMBER_PARSE_THREADS to the number of CPUs on the host. (Our build
> machines tend to have about 32 logical CPUs though we originally set thes=
e
> values when they only had eight.)

That is usually about the right amount until you get to larger numbers
of cores. On the autobuilder which has 96 cores, we use:

BB_NUMBER_THREADS =3D '16'
BB_NUMBER_PARSE_THREADS =3D '16'
PARALLEL_MAKE =3D '-j 16 -l 75'
BB_PRESSURE_MAX_CPU =3D '20000'
BB_PRESSURE_MAX_IO =3D '20000'
BB_LOADFACTOR_MAX =3D '1.5'

(see meta/conf/fragments/yocto-autobuilder/autobuilder-resource-
constraints.conf)

>  We set BB_PRESSURE_MAX_* to 2000 (though
> it seems that I had it overridden to 20000 in my personal configuration -=
 I
> may have got this from
> https://wiki.yoctoproject.org/wiki/images/0/04/Yocto_Project_Autobuilder.=
pdf
> or similar). All machines have NVMe storage.
>=20
> In addition to stock oe-core stuff, we also build various
> embarrassingly-parallel large C++ recipes. These are often blocking
> dependencies so they run on their own. We end up doing quite a lot of
> incremental builds too, where some stuff comes from sstate and when
> compilation does happen ccache is often well populated.
>=20
> This all means that we'd like an individual task to use as many CPUs as
> possible but ideally we wouldn't run multiple such massively-parallel tas=
ks
> in parallel. Of course, Bitbake, Make & Ninja don't know about each other
> so there's no good solution.

That is something we might be able to change with a shared job pool.
Ninja is now able to share make's job pool as of the last week or two
and once that happens, sharing with bitbake could be possible too.

> With the above settings I tend to see Bitbake kicking off many tasks all =
at
> once, which pushes the pressure too high and it backs off whilst those
> tasks finish and then the same happens again. It makes the knotty output
> on console look rather like a spring bouncing up and down. This is clearl=
y
> not ideal. Luckily there aren't too many really huge tasks that get to ru=
n
> in parallel, so the smaller ones finish and free up resources.

It is tough, bitbake could perhaps have a startup/backoff algorithm to
try and avoid it. T

That said, the idea has been that it should be able to run
BB_NUMBER_THREADS in parallel without issue and then the pressure
regulation kicks in if one of those jobs is heavy and using system
resources and avoids bitbake starting any new jobs until it is done.

I still suspect your pressure numbers may be low. How to work them out
is trial and error though, I wish there was a better way.

Cheers,

Richard


