Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA9D3F077
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:49:53 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15038.1769611787050457767
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 06:49:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nd6bVtoY;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c07bc2ad13so483486485a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 06:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769611786; cv=none;
        d=google.com; s=arc-20240605;
        b=DBd0huAeAxW3I7/QGzfLbrV7y0/BsVJEeb4u1Qbpzz7MRF6ED1ECzMixa1+dYWCS5e
         McEGO2apA8QUjwSZ3yQ28GunmuZocYO7HkE74moq5i6rb//AGyyrEL2dYCLzJqdcH6qM
         D8IabW1EDYL5yTJurN9uD58uWdKIRUQylF+kmsOCABqgwzxgql0wrWSUkfVArQr0TJFG
         /9REvEutrnJwR9+rKK//ZbGvi66bwLojftzN07vkN6dpeHRdsmPIshARTK6zCRJPJphz
         xoBuVSpS27jDSc/+kUlT5TsKN3FdFpZdzw7fVrUPJRQJ8N8V2cFTbHWaTP5Z4//kb9no
         Y5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yLBd2B0bWvpe78aeudFvuqg3AZf3mM/hyw6vBafMnT4=;
        fh=V8wtxET+8j6WYeXAAiNwzCXmItNoSm1UUSrmSFvX+YA=;
        b=INpcN4fSBNlUB8e7sidECJTIiTph46qcuzuj9K2WXEWAzYP4BtKMcURvZbO+zXqQ7K
         wjECxIBl50zCSmorrZ0mR+xkFpVrlnLBvTHpG9o98+ri98N5uSGj89wXxIQiRdX6yW6t
         PTk39OexVLvRUHr/TRB3HIpCFiNdiZQz6tk0BlgmO8m4TSBzeUWiaXLVn1ZT0vnkfBKd
         DdRUZSQl/wmi4Zzha4nYhxYu7gDaQqVHB/lR+h8/gm5e2eAQ5WL9oyajN7i9HdDtjMYp
         OXHDr6EayJAWdx577PbWly01yWvDebx1QHixDvPvTLLEmvrJZZeeNhxaAB5/5p75KKFW
         p8xg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769611786; x=1770216586; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLBd2B0bWvpe78aeudFvuqg3AZf3mM/hyw6vBafMnT4=;
        b=nd6bVtoYu9yQuKvr4rO8fjcf2ePQ4W/qfepkDAlPbM8lWdq9b288U06VEfmmZpxqKr
         oPd6eQauuKGJ0ko5ihwg3pd0IPhQtvT5pbdHDd5aQ//YUOPvYnkloO3wkqw40H5wy3dB
         EFDuFN3UUCksHVM7Rt8VK7S3uKrJiOoaVaHT7yoHVhCZ2kZr2X5ulNNrFj+pg6V5vrEB
         H/Ga3L1Lzv1dxwmbHytyQfi3ttdbG3AqI9N8derdRW8FyCKQQIoidXtqk90ncIwSBrJI
         NJnol/AUI0hxANstLEn+kWv+Usg95YiGhDxHGfFOXkpIu/ktQ8imiLGU4srhEmFbUuIW
         LxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769611786; x=1770216586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLBd2B0bWvpe78aeudFvuqg3AZf3mM/hyw6vBafMnT4=;
        b=p1XMsCMibN8w9qJZZChgiRVGvxdFKow6oF5gDI//SXr1nofV4/S6/ygptk37I5B/SX
         rXvz8I1flciTsZtETvRRxuAlcD8YENpT9i54/GWYDvHhUOsqEIKgttQ8CW1Pt5SvHSoZ
         SBbcxIeQKa+x1Gg5gXg9mkMThdcoSAj9EMcVUYea4tgm7KmRFxmsCEChTTQb6NBx+jX4
         H1+1F0IpXicEscT0vOUL51cPvLezfnzw9ZnuMU0JrNdKdfCGX8q/g45MbvyOEJepGGNi
         qVdPhAO8spRH4kgZ/HxpA9uNZxnVfeb1UzqrhmiLPXPbWyrJaPdEKRm7OUiAJwPBfRKI
         WxaQ==
X-Gm-Message-State: AOJu0YwExXePQP7ymoluso1WimfEVrw2dpZau/lDaDWF+ql/JRURk9c/
	PQNEgPsZ+SgqzvS1ksf8+FFaRht8tPQeaw9iSMqA6PxryJ+zQVw05WUieVC+wCxXfr3UJgq6QhP
	/WZ8c6O8Xs/u9+KGlV3RSR+w/w+EMn6Q=
X-Gm-Gg: AZuq6aJ6wPfn0DG3YTRfS5s3L2xidTTN9AhIyqKbXpw+eALqE87M3kTfVjBI4yEp6SD
	6QBJDnR59wJggHd8SnlWNMJ4YSU2QHyDoym5dHIwthfz9Ww04JLHJyZgJx34n5wMbEUtuoAyaZX
	WMFiJuf0Rd26UgwIqMY0+N43d4aFmV+WvTEW9sEUNgumbzbo5/frmUc453yEYxOdArnC+wIUKfd
	Cx6SWqRizp3pkM5gVwGvlGP0r2sJHRxYCiLH3SCt59ysiTiwhf0Cqc6xi6Q81kzEYB7pYDJyGhv
	d6n00GGIf4QdKZQl3YkRqvy9CWi4tQ==
X-Received: by 2002:a05:620a:2807:b0:8c5:3202:8bb1 with SMTP id
 af79cd13be357-8c70b859447mr651700385a.13.1769611785923; Wed, 28 Jan 2026
 06:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20260128143336.1963432-1-anibal@limonsoftware.com>
In-Reply-To: <20260128143336.1963432-1-anibal@limonsoftware.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 15:49:35 +0100
X-Gm-Features: AZwV_QgBliL0pkt2o6SB0aXM51RWSdHtYhDF0bYKlPZjo2fsJE_v_6o7gHXVvX4
Message-ID: <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: _has_local_modifications
 fix layer add on existing project
To: anibal@limonsoftware.com
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de, 
	jonas@limonsoftware.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 14:49:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18918

On Wed, 28 Jan 2026 at 15:33, Anibal Limon via lists.openembedded.org
<anibal=limonsoftware.com@lists.openembedded.org> wrote:
> +
> +        if not r_name in fixed_revisions['sources']:
> +            return False

I'm not sure False is a correct value to return? My understanding is
that the scenario you have hit is as follows:

- manually clone meta-freescale into layers/
- add meta-freescale to a configuration
- run bitbake-setup update

At this point bitbake-setup sees that meta-freescale already exists,
and it needs to decide whether to preserve it or not. As there is no
record in fixed revisions of what the original revision was, should it
default to preserving, so that any possible user modifications are
saved?

Alex

