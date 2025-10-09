Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B9CCD185
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 11:48:37 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.10292.1760010510225338562
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 04:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ggivIixC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so949163f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760010508; x=1760615308; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njmm2Acvl7N7hY4aRVCgy0wq2hXwvR1z07xGdnTDsSA=;
        b=ggivIixC7uPj2/oE4Tx5LxAz7hyAHXcRAtYMPmnTJ0zXiNU7MTP0e84V76dN/3K5uL
         lH57MMCwUdU2R+KYviMf4JrT9rUvQlCOzB0Q9Rmg+UNBO6vNpGDbO/aURUcJ4oXeLxg4
         Wj3o6YPPb+X1YFbmgTr9TBI7RoMSELiWws6Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760010508; x=1760615308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njmm2Acvl7N7hY4aRVCgy0wq2hXwvR1z07xGdnTDsSA=;
        b=Xre1q9ReAvVJ+qhzQI1P14OswlvAObd6baKvd5vAbYjM75iZ71eDj/+whn5udfbr6h
         wt4tF1c+BffbYBWm2cLH34kqMfBUznljnm/GycKQ3DHMeVegZz4Diu+Fymakl6TV7lbJ
         S3ZlygHkgyBVoSwJFe5G2ZIst10uKntFMjOxDVrFAIsQ4abUR3iRqmAhGp586Io7RzUx
         s2ltHAz2x40X/7W5fpCCZRExE/nPl7cjn6Y2dLRJDrNzB25hdkEVgmnK2l/7YpdheRSo
         efEUVq3Lowj3a4XKgfApmKZZVQYn7ZY5bkZ02YdOLF/b68aiV1YYsxmYN+7lRS7a5zIX
         PO7g==
X-Forwarded-Encrypted: i=1; AJvYcCWGbFYDLF8KNVltDEIJwQLgJBTiFNEfolr6c0loiaiZ1LBDPvYmxEIlUrpOETMD1bHkHqIj51fvbHepJmQT@lists.openembedded.org
X-Gm-Message-State: AOJu0YxTxbJGDZXkVReva3hm492nhV9lv3maaq2BVvBkW/txan+vJBxd
	p8N+A/c1dFOEABXV/hhGyPT/i5Qx2iDS4S1ddO/N2vfmft54PFMg+22QSPGXOjdhVsM=
X-Gm-Gg: ASbGncuWUUgi+Rh0uacORKlohfa0DJ27xCUmEr/rw4lQFMEer78xPhOAD+XfaYIz41W
	ZbbvKqerK0iYyEnYlvrfSWVl4RvCppcgt1lu6z8EBVaHwzqF42MyQ0bQd0EqJ9Fpx9mMc0q10L6
	X7jzVuf2DA+zAlM+msjkX8emmeA2zSRy78galJY9/hzGmfwsVaCV/4K0FLwGSKzGI7VGhZn+Rr+
	EUFfCXP1P6GllcW28lRIqk/ogKYlk+Y/gGRw5JoFP0HBvXMoWeXjGgBghzlcfELqjF/A7PbV9P1
	Suyd6GjrIwowiY1Jg1sTx9RAiYJE962uz9zxP4y9k87dqW6q+jtRsNEjwo54LvMxIuX/PowubWx
	QyZ0VDxBAfsUE2sW9MW3axFAvK1VCINatv6NaWzh/NU3GGcYoRLlvps8Q+887V5oA2q6ZCYHbQc
	zekFSTlHGb5XwAIfras977tESu8xNtx5EXB9E=
X-Google-Smtp-Source: AGHT+IEHt3IoMYplBYMGbhJggy6pjZ9t3Lqh7vhAQltLvBQ8ghnIa+1N4ks/RXOXX8URuMzLWn4xWQ==
X-Received: by 2002:a05:6000:430e:b0:3e7:d199:7889 with SMTP id ffacd0b85a97d-4266e7c4ed5mr5636676f8f.27.1760010508570;
        Thu, 09 Oct 2025 04:48:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8c4a:b3bc:b910:6576? ([2001:8b0:aba:5f3c:8c4a:b3bc:b910:6576])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm34642827f8f.2.2025.10.09.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:48:27 -0700 (PDT)
Message-ID: <b31807779ef3667b1e8008cb47f71f6db64c5211.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Make the "Initialising tasks"
 progress bar finish properly
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: peter.kjellerstedt@axis.com, bitbake-devel@lists.openembedded.org
Date: Thu, 09 Oct 2025 12:48:26 +0100
In-Reply-To: <20250927055339.2472285-1-pkj@axis.com>
References: <20250927055339.2472285-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 11:48:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18150

On Sat, 2025-09-27 at 07:53 +0200, Peter Kjellerstedt via lists.openembedde=
d.org wrote:
> The "Initialising tasks" progress bar needs to be finished before
> update_scenequeue_data() creates another progress bar.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
> =C2=A0bitbake/lib/bb/runqueue.py | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 63d4edd892..96d70080d3 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1610,7 +1610,6 @@ class RunQueue:
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.state =3D=3D Run=
QueueState.SCENE_INIT:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.start_worker(self.rqexe)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.=
rqdata.init_progress_reporter.finish()
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# If we don't have any setscene functions, skip execution
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if not self.rqdata.runq_setscene_tids:
> @@ -1948,6 +1947,10 @@ class RunQueueExecute:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.sqdata =3D SQData()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_scenequeue_data(se=
lf.sqdata, self.rqdata, self)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Finish the "Initialising ta=
sks" progress bar before
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # update_scenequeue_data() cr=
eates another one.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.rqdata.init_progress_rep=
orter.finish()
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_scenequeue_data(s=
elf.sqdata.sq_revdeps, self.sqdata, self.rqdata, self.rq, self.cooker, self=
.stampcache, self, summary=3DTrue)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Compute a list of 'sta=
le' sstate tasks where the current hash does not match the one

Having this call buried inside RunQueueExecute is not going to improve
code readability or maintainability.

Also, whilst I agree update_scenequeue_data() *may* trigger a progress
bar update but it is far from clear how it does that. I suspect it does
so via code that is sstate_checkhashes() in sstate.bbclass in OE-Core
but that is metadata dependent, may not always happen and subject to
change totally out of sync with the code in bitbake.

I think the progress bar handling code needs to understand how to run
multiple bars in parallel, or close any existing bars if present when a
new one is triggered.

So I don't think this patch makes sense in this form, sorry.

Cheers,

Richard


