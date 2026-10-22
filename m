Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2629.1792710657176409989
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Oct 2026 16:10:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RamI2t2Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e09aa5264so145565f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792710655; x=1793315455; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f2AjBzkIzuFwiCc7HKMzNMi2yPkxEUyB/OKvxkGWPRs=;
        b=RamI2t2YfHBKsKPHxiz+J60ASBaakWsBz9K//i22FR8DJ8qkHh0w8y7RSv4nx5cVYP
         fVcBE+C62Da88/8mzQsWnSUNeebJmEDpJKL2hRnhzWP1PBXCy6+OhqO6XWDaER+JnSMA
         yAK5QCnCxFvuaO2zLdpZfzlOBwoiY8s34OxS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792710655; x=1793315455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2AjBzkIzuFwiCc7HKMzNMi2yPkxEUyB/OKvxkGWPRs=;
        b=0xBnVABhSWSV0heWyW6j0AxxHvRn6rpJlqnlEUftPnlJdYuZJ7kLWhXH4Qoq3m6i8E
         Z3+Qrgcb7LpAa2/vwAhtDgYmwsGSMb50IYVXYQzFFBIFrL8+zPEYGQJstfJR2XEdhy9L
         +dHtRELx/oyiOTzDWlmLPXU90aEEwfQi62yMjzvNBRmEnswKSdtJMABZj4OzmJR2RDV2
         Gy/7cGioOOniEo2W08wzhAIn2z3T5pTjowJ4W0YWOjtUS0bVOm+sG4wdywQ8JidAS29D
         QdCG/gn63sgLyASQCCxfMlmEwgBNjBw+jICIsL0aQLeEBCS0rerI0CkVNGj6/q/lJObv
         9Mdg==
X-Forwarded-Encrypted: i=1; AKwUvBymHUVnKaeW32PbmNQMVT7rjcbj585mn6VW3VtIV3CoZ+ajPjBlZyS3/jEW9nBS8ljPYO3QlBloTdOfGEBf@lists.openembedded.org
X-Gm-Message-State: AFq9FYIq9iEO67ey5OJDP3XNuTE7JwZLCgA4t62chiMFVcCltHVUOEVw
	q7h3tMLtfLoqSWyMqLdcbSchptz2qdD1tzZ76juXjf51/wPkCbqIxpgJJQvBD3mzom0=
X-Gm-Gg: AYBFou2tHVCJ5zY9VBES2205K/+C2mD4N/3xGvrKVjvOfxQYHf9NAi0A5YbOIrrMpqh
	ewSKU4JBwG02UxXFexyVs123E3P/gUZnqLvuE5eygpHAlPVOsWs4Ta03JViXF62aUSADAk18K/m
	EvfncwCprxLuFh/A1IqkHR/o0mxirXZQS+uvbGpY36qLjuhOthhJXGSB78oTVXpyBlwVSLDE/Tm
	mQUVjzTBDcWExlhUSoEkPQt9056vwVAxG0FGXXThNDCsLrby0z59Q6RNrhySpQRFblwLoydzIjE
	1UlwiuXYb8t3s0ioBAWsT/ZtExJJttHgOsTSJxQrRSK/VPLiy3TfM79ur6Ps29hP+Ecz0naMhwg
	hsHyA2pLTTuQeP3wxb49SJV4x9qsL91h2dQDiddzFipjN/KP82GJ6f0luvwsVdSOf2U82/dtFeL
	ymJZyl9wHzEPOguo1+IrB6mu29yau0Dtt8GraVOqVTdq6K9rvG/yWP/lXiGhKKWguRDygm+BafQ
	RMsbwmMJCF239Z8UO6bUpT3rWnVdgepfVFX+67DfjxNSkvMqUbMcyEm8ZWj2ghwzXK9Y3dL/A/o
	Lqf6sSPhakU+h4qfos4V1Rx2mzFhP21adv9UEIHEboqN
X-Received: by 2002:a05:6000:186c:b0:48e:b8f:f7d9 with SMTP id ffacd0b85a97d-48e38549e00mr539090f8f.6.1792710655333;
        Thu, 22 Oct 2026 16:10:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:82cb:4462:e32e:8be9? ([2001:8b0:aba:5f3c:82cb:4462:e32e:8be9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37e5dfb6sm964172f8f.0.2026.10.22.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:10:54 -0700 (PDT)
Message-ID: <ac0c3b89244bc513a59405f476b76bd7bcaca74b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Avoid building task set
 unions in next_buildable_task
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ricardo.salveti@oss.qualcomm.com, bitbake-devel@lists.openembedded.org
Date: Fri, 23 Oct 2026 00:10:51 +0100
In-Reply-To: <20261022225148.2195453-1-ricardo.salveti@oss.qualcomm.com>
References: <20261022225148.2195453-1-ricardo.salveti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 23:11:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20369

On Thu, 2026-10-22 at 19:51 -0300, Ricardo Salveti via lists.openembedded.o=
rg wrote:
> next_buildable_task() runs at least once for every task in the build,
> and again on every worker wakeup while a slot is free. Each call copies
> the buildable set, removes holdoff_tasks from it and intersects it with
> tasks_covered | tasks_notcovered, and when a task is buildable it also
> computes runq_running - runq_complete. Those sets grow to the size of
> the whole runqueue, so every call costs time proportional to the build,
> although only a small fraction of the tasks are buildable at any time.
>=20
> Filter the buildable tasks by membership instead, and keep
> runq_running - runq_complete as a set which is updated when tasks start
> and complete. Tasks are never removed from runq_running or
> runq_complete, so the new set always equals the difference and, as
> before, includes failed tasks. Also use it for the thread count in the
> pressure and load average messages. Every task has its own priority, so
> the chosen task does not depend on set iteration order.
>=20
> A no-op 'bitbake core-image-minimal' with OE-core goes from 7.66s to
> 6.64s, and a no-op build of an image with 18 layers from 46.54s to
> 41.59s (median of 5 runs each). Task signatures and the runqueue task
> order of dry runs and of a single-threaded build from sstate are
> unchanged.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> ---
> =C2=A0lib/bb/runqueue.py | 27 ++++++++++++++++++---------
> =C2=A01 file changed, 18 insertions(+), 9 deletions(-)

I'm torn. That speed up is relatively small compared to times of
overall builds and it comes at the cost of having two data structures
in parallel which need to be in sync with each other. We're tried to
avoid having duplicate data where possible due to the risks that
entails...

Is that gain really worth it?

Cheers,

Richard
