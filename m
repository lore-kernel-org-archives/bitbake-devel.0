Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9EC43334
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 21:42:13 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.77457.1656970922949737873
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Jul 2022 14:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hLOrQsKo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id
 l40-20020a05600c1d2800b003a18adff308so6396970wms.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Jul 2022 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=0aJJEc68MzX8ZJoG0IYd4dPtbOeFQHtaFi48gf7qJMk=;
        b=hLOrQsKoEbvkCzDgAdJKcgxCDi9rMjA6hGyR1oK6GwIvFykVPyypFmMHZ5+ia6kFRR
         QZXhqnq9wVuQSo8L5S/F6tCJl2W0KGaoVEP5Z/vw4KGjkt0xEPX9FALoDTVOXfOocUTo
         +aXY1lzoVbJuxZdDgl9E/nGjSYzQp9F1J1aTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=0aJJEc68MzX8ZJoG0IYd4dPtbOeFQHtaFi48gf7qJMk=;
        b=oW0UlxvfcUZ0gjgcqUUsvY+sqOIy+tgdPk1FN3sX74Xy2IWZGbASPSEjkv1r5QLdzu
         vz9ZRKRflhMdgMEXazE7xs9iNjoHCYuhUezyyeiMMrpL3Z1SBWtiGzW5oBuvvOgfPgMO
         s6Dn/K86aruB2iq5tpFKAtCkwyt7OBwkxQq3kUA+NM1hMKfeAiiQIefqachf2p20aF+W
         pj0zT+G8vHEmEIZnSzFkMEfpqbFUiOR4jr5XUmAlE7aPKafh1XC8dAjTd5QHYZDNDHWi
         bU2x8RJF2XviNG9nfy2lzva2kDVjBf9RJTvzR09uVXGO3DcO1burbdYzxWwTr52mk0Qp
         8Z4A==
X-Gm-Message-State: AJIora+KBAsrI7sc6tJBaqH6tPUACgmWkMFi1ThIDv2rzWK3qarlwbmg
	csGh8mXHcOetMtihXZ1axYWzpg==
X-Google-Smtp-Source: 
 AGRyM1vzHCZMUfGtp2mNG7Kkqn99DbpTlf7d75Gaw+7XyIwxjm4A156LphTZtZn2Q/klyPRZDlCa1A==
X-Received: by 2002:a05:600c:4f11:b0:3a1:8631:b6b4 with SMTP id
 l17-20020a05600c4f1100b003a18631b6b4mr23749563wmq.94.1656970921214;
        Mon, 04 Jul 2022 14:42:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7dad:6fff:75bd:1ad8?
 ([2001:8b0:aba:5f3c:7dad:6fff:75bd:1ad8])
        by smtp.gmail.com with ESMTPSA id
 q5-20020adff945000000b0021b9585276dsm30552858wrr.101.2022.07.04.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:42:00 -0700 (PDT)
Message-ID: 
 <60a09886e04e773c6867a81edb9597b5b92a8626.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] runqueue: add cpu/io pressure
 regulation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Aryaman Gupta <aryaman.gupta@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 04 Jul 2022 22:41:59 +0100
In-Reply-To: <20220704204409.3692354-1-aryaman.gupta@windriver.com>
References: <20220704204409.3692354-1-aryaman.gupta@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Jul 2022 21:42:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13798

On Mon, 2022-07-04 at 16:44 -0400, Aryaman Gupta wrote:
> Stop the scheduler from starting new tasks if the current cpu or io
> pressure is above a certain threshold, specified through the
> "BB_PRESSURE_MAX_SOME_{CPU|IO}" variables in conf/local.conf.
>=20
> If the thresholds aren't specified, the default values are 100 for both
> CPU and IO, which will have no impact on build times.
> Arbitary lower limit of 1.0 results in a fatal error to avoid extremely
> long builds. If the percentage limits are higher than 100, then the
> default values are used and warnings are issued to inform users that the
> specified limit is out of bounds.
>=20
> Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
> Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
> ---
>=20
> * Changes in V2:
> - Replace subprocess() calls with open()
> - Rename BB variables to BB_PRESSURE_MAX_SOME_{CPU|IO}
> - Skip the checking of pressure when no value is provided.

This looks much better thanks!

Some small details below.

>=20
>  bitbake/lib/bb/runqueue.py | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 1e47fe70ef..0500211c8d 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -159,6 +159,26 @@ class RunQueueScheduler(object):
>                  self.buildable.append(tid)
> =20
>          self.rev_prio_map =3D None
> +        # Some hosts like openSUSE have readable /proc/pressure files
> +        # but throw errors when these files are opened.
> +        try:
> +            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/=
proc/pressure/io") as io_pressure_fds:
> +                cpu_pressure_fds.read()
> +                io_pressure_fds.read()
> +            self.readable_pressure_files =3D True
> +        except:
> +            if self.rq.max_cpu_pressure!=3D100 or self.rq.max_io_pressur=
e!=3D100:

See below but this can just become "if self.rq.max_cpu_pressure or self.rq.=
max_io_pressure:".

Also, the correct whitespace here is "pressure !=3D 100" which is
standard python code style. We're not perfect in bitbake but we do try
and keep to that guideline.

> +                bb.warn("The /proc/pressure files can't be read. Continu=
ing build without monitoring pressure")
> +            self.readable_pressure_files =3D False
> +
> +    def exceeds_max_pressure(self):
> +        if self.readable_pressure_files and self.rq.max_cpu_pressure<100=
 and self.rq.max_io_pressure<100:

again, see below, we can drop the <100 (and there is again a whitespace
issue).

What happens if I only set one of the values though?

> +            # extract avg10 from /proc/pressure/{cpu|io}
> +            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/=
proc/pressure/io") as io_pressure_fds:
> +                curr_cpu_pressure =3D cpu_pressure_fds.readline().split(=
)[1].split("=3D")[1]
> +                curr_io_pressure =3D io_pressure_fds.readline().split()[=
1].split("=3D")[1]
> +            return float(curr_cpu_pressure) > self.rq.max_cpu_pressure o=
r float(curr_io_pressure) > self.rq.max_io_pressure
> +        return False
> =20
>      def next_buildable_task(self):
>          """
> @@ -171,6 +191,8 @@ class RunQueueScheduler(object):
>          buildable.intersection_update(self.rq.tasks_covered | self.rq.ta=
sks_notcovered)
>          if not buildable:
>              return None
> +        if self.exceeds_max_pressure():
> +            return None
> =20
>          # Filter out tasks that have a max number of threads that have b=
een exceeded
>          skip_buildable =3D {}
> @@ -1699,6 +1721,8 @@ class RunQueueExecute:
> =20
>          self.number_tasks =3D int(self.cfgData.getVar("BB_NUMBER_THREADS=
") or 1)
>          self.scheduler =3D self.cfgData.getVar("BB_SCHEDULER") or "speed=
"
> +        self.max_cpu_pressure =3D float(self.cfgData.getVar("BB_PRESSURE=
_MAX_SOME_CPU") or 100.0)
> +        self.max_io_pressure =3D float(self.cfgData.getVar("BB_PRESSURE_=
MAX_SOME_IO") or 100.0)

instead of "or 100.0", just do "or None" as that is the pythonic way
and then other code can be simpler with no magic values.

Cheers,

Richard

