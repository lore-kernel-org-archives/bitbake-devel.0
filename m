Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81D6C531C9
	for <webhook@archiver.kernel.org>; Sun, 26 Jul 2026 13:50:48 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10772.1785073841837577024
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jul 2026 06:50:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ckTXfeN5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1582368f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785073840; x=1785678640; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YdT17b/5tcdpM7y4bYPzHk7w5LC9RLjScCZFc+hkhhg=;
        b=ckTXfeN5Yvo8L9T+JwfFE/FsqywrbgSqYwxqOqvxpGjGX/rYU+XauSIZiITxNqDhA/
         PuWCkUXeGmqe+d0+vIxrfo2WR3tk/sSlGQm2TUX/nouVkOHkBDIL7uxYf0phGHIc3SQD
         YHsxyNGqPQ5SciPJY7eRA7/sP7JZa+rX24JD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785073840; x=1785678640;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdT17b/5tcdpM7y4bYPzHk7w5LC9RLjScCZFc+hkhhg=;
        b=REUcg1OcXkAUr/YlZevNJIM9SaTtlVUsDS0LLS49gyoyp0p+3M0+seUWbrh5iqmh3A
         nRPHySlqJFkif4lfBON7G/ee7qf4cZw8GUq69kwC9izK4vpSRTAAFF/HCE/6FBk3pKl3
         2KVd6h8wHAwMGg6dOSqDycGrRFljQcMH+DwaFZUK8jFO6zhQQ3M/DUPcwH5SHFp2X4bV
         ZUGV2JlGhblRgFRmzrFWeVqn0+xOpMHXKFbqwgPkYJo/OvTQDrZonpc91UpIM8s25e9j
         mm4h4Cikfic3kPUpMQDk2IO3bC1kGTvnZRU8gCCwYE5JnBcbIjVjRdQqf6l+NBGxVthT
         OrfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1Nb3ARE0eHpRCymFu6ovHbKYi94hbeH35ICQC/LAbkoHg3cpS7j3DMN1LaVtHXtlbiKavZhquLzrtAPTM@lists.openembedded.org
X-Gm-Message-State: AOJu0YwVe3hqDW4BMsYf5BZI+lPoVcALVNVV4iy7CVmu9ySQ69UDlIzt
	A/GZq7iFEUUL5mziMHPDu+gSD6MRvIUYQPdPgyYCifxd5dyLxt3VZBkMlhYXaLiMxhQ=
X-Gm-Gg: AR+sD11O6WdqNUuQICh1Q7wtI3BD/AR0qiRYWFmzW2UMRGaWL3i1079KnkNJ6BO+8/R
	KbEkKm0Lxvhh3RmasFC1GLmwnhaMfQwuvIWAdhk3/Bb0Bk0GJZuUWu4aT2ah3GtRrf3pqo8EFOi
	jJv9NMpb+ozU58mKCF9u/tv/zDbBe9D8sxZCnJGRI1JVJ1SkqEyUshNhEcSrCzVxJkssmXQg14J
	TFGtnpwPwEPj5aP5/1XXXAzE5VZbQ5TprqAXytvfdfx/EnUYatGJN3GBqc0ERwDa+jUECK6UXUp
	B5Lg3WNKrSWcyBCvd6vJL16z3J0vDlDy1mTpN5m/tmGToOkDmvQm67XLjmZ1o4kWu+KLlX+ns/2
	5pgs0bHhuFfymRijwXyfnfKKICBB2QJ7C30NwmPRxj+ugpUntJ1Cx13fO7aPy35JKGp1SCX3yHC
	FTGzKRMcNDSjyC1XK3zqwm586iI6Q0T6lLyVJUlbmGImAVaBAXMdj0FhvFK2uqyki66EM=
X-Received: by 2002:a05:600c:3e1a:b0:495:77e3:88ba with SMTP id 5b1f17b1804b1-496b56fa4a5mr66065115e9.27.1785073839937;
        Sun, 26 Jul 2026 06:50:39 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a3ed:a478:dbfa:c28f? ([2001:8b0:aba:5f3c:a3ed:a478:dbfa:c28f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4866ddbsm170426025e9.7.2026.07.26.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:50:39 -0700 (PDT)
Message-ID: <9329f406cff5fd50d20ae0b65263e45f5151a491.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH 0/6] hashserv: Pipeline Upstream Queries
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>
Date: Sun, 26 Jul 2026 14:50:38 +0100
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 13:50:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19862

Hi Joshua,

On Fri, 2026-07-24 at 15:25 -0600, Joshua Watt via lists.openembedded.org w=
rote:
> Adds a true asynchronous streaming API to the hash equivalence clients,
> then uses that streaming API to pipeline requests to an upstream server.
> This means that when a server wants to defer a request to an upstream,
> it no longer has to wait for a complete round-trip API call. Instead, it
> can use the faster streaming API to send the requests, and continue
> processing other requests while a response inbound.
>=20
> Joshua Watt (6):
> =C2=A0 hashserv: client: Add asynchronous streaming API
> =C2=A0 hashserv: server: Fix formatting
> =C2=A0 hashserv: server: Add queued streaming API
> =C2=A0 hashserv: server: Use streaming and queue API for upstream unihash
> =C2=A0=C2=A0=C2=A0 queries
> =C2=A0 hashserv: server: Use streaming and queue API for upstream exist
> =C2=A0=C2=A0=C2=A0 queries
> =C2=A0 hashserv: tests: Add test for upstream pipelining

Thanks, this looks promising but builds didn't like it:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/22/builds/4225

(and more in that a-full).

Cheers,

Richard

