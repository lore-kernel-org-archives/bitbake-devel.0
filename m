Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220CACD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 13:14:12 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11573.1778159649236509941
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 06:14:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HyEK/ciI;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8f15e900586so41619785a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778159648; cv=none;
        d=google.com; s=arc-20240605;
        b=SGLDaIpSuDYBmNRNzwzTqBGs7tYGfcFhUVVYiKuyz+ENF5PM8uDqpnE5b5kySmtaC4
         RMMYcU2p57COCBoVgnfUD9u+1/lKNPOtNdikr5KDg6Dn5hovPGJeRD5z69JNAEDu9a4O
         vTYozNewWws3hRwTizRs6WZJN2zjvCmhiO/7tUOPpPuqZG6ovENqIdPFLDM4a+6kC/2G
         PDIc3T4dWFwNGX/R3hQOx+oaDVCVXkFe/HtaGU7b46dHjdh/pw+fpNx4D4JHXqL7RVGh
         IBNenwE+gDh2RiPgRKtAjO5gUAr5a78NRQDJMXJdUzc+abfjN/YAh9l0PDdVII1NF0/e
         yFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YDqhr40LUhfzqrs9mZat2TNlu3YDvQg6xtW2odd5yKs=;
        fh=/Ku15ZYEqeXvTtSWJ/28JmWlOjgrr8zJWAVx6nIBNQM=;
        b=hsI81WvXCoQdABRv0AamyLULAMEaizm/hjsFFIc4dRtBx61KVy1clbgpPi//ak5waE
         GLC3zfUGoLIQIQ8ul5gJfnEU9ICuR/zmx+Hx3xPBmb+e4Bz0w7sog1gHAxk/xYA27Bqe
         cpY8RyQnuLCCXM4mxPNlu/mP5mmtARXQg0Z4rsl7hnHnAlRUmKK+shgyJNZy2Q0xXEAm
         ST8tHK0bjliHOSi0F1F6ePO4OHkvQD8fcZKu+X59eEHGnhD75sI0jRHvaG6acPBvftLa
         yI6bsnpVxmZ1hSBtjc4B8MFLv8roSMuRHU/6VHq1T+7pR+GziO21CFPUaOoMIFmPrcFd
         KcqA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778159648; x=1778764448; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDqhr40LUhfzqrs9mZat2TNlu3YDvQg6xtW2odd5yKs=;
        b=HyEK/ciIEuOTMfI/gsjuk+8/0YpxPp9NLXMVcAhUuKcmeGd8EIqlLna6I47PcXXCw7
         bhqNcJtssWw/KWNhQK6S5W3A9qe4YCtS/7MRyjo/l7ehg0FtKie1Sr4bouykdNJHWbe0
         lO1lg7yrJMbeWz+faDeSOhhk2/EQ1NUGBfsPcy/aa7csosk51h7xMgbdHDd+VXuetsep
         C9HpObhb3Pj7Fr5+QgQCCRUXfSNYHm+nOERCwXfYvQexV/4KYUFxdxkH7gtNGt3777DS
         aK+rnBL+LyBhNeoIC3lB6KljIuavbM+7hOWOqpqux6VDZRu2V2yyjaeer8cq93S2+ceX
         2E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778159648; x=1778764448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDqhr40LUhfzqrs9mZat2TNlu3YDvQg6xtW2odd5yKs=;
        b=BC30pbqz7LKs1hyUN+S+274OkHcp/ahl6uzMr1fFyrnDC+ZsrtElGC5SzwHXbYlsq+
         m9pM2ZJIn/Xb4pvSau0Oiw/vaG8KCJk2RW4VGPqQpbvSwkQjDVhktJ8L+DA7QMnD1YBq
         OqXI2d6XDWQtKugoCERbozIDTNDgEmTDIyIy7eGk9b4IxOjWX0B+5O+zr4x7OMmMQVyE
         Wcb7EHMdgDy8KUz1G8BrvYlNuslmtdMx/yI9T1zzX7rLQg+80psCurm7qmmkM8QCG719
         pWYXzK/km5E1fAt+X5wA1IL+iVcuCa7aiKslUQ+xav3gY3km4taYo/DuDU25NMVIxBa9
         A09Q==
X-Forwarded-Encrypted: i=1; AFNElJ8r7NXQWGIVm4zxbx7xPPA0jpQtLw7bcEddWKQWSOAW5ppHLidX/HX/wlUmJr6YC5bd4GUmp4/HtAT7GDSl@lists.openembedded.org
X-Gm-Message-State: AOJu0YzCntq0vTQLc7DcycZC4vX2COrRdT+UnGOOcmJ0vwokvylhnFGj
	PRnCZXHjtgRClVr887LPSEPwpQ+c1xREg4XNIHx/gJTdq6k1uu0G8oM/u2954rpkQiGV3oyUM1/
	erhJdOWNOuore5dyiZyHKllLSuZOFMdQ=
X-Gm-Gg: AeBDiev4w9pJGWaDyWJHh9vhu/PIyFeUzXUsBITT9ZceTU5UlAOMoBo+nruiXulA1z7
	VLEKAmmhy/pASG71+8Va82Naf0KH3FyZy/DZDJzwVdDr/6+ZkQbqQGXLQAjakO8yxj+tVRfutpK
	+kGpAjqA503OHpyfMy2/nLR3iTHKLgzc6g+6+vtV/FD14UCLAEXbv4uwEbb/xPhVSBeM4syTm20
	ZYIXRv6RjOe5tFJPUBoW4Xeet96jpVuJL/j6nt3phWVl+5UZ5Up1iZMdVW3KeiH375EGd2/rRbJ
	ub/I7tQqqOXFTJdBDpxafEhMDQeqlIMwFCzGICrB0TOciMa7QzA9
X-Received: by 2002:a05:6214:19ea:b0:8ac:a553:528c with SMTP id
 6a1803df08f44-8bc45f1aee3mr118052856d6.42.1778159647970; Thu, 07 May 2026
 06:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <6100A74F-B06F-49D5-9895-DB7D5B563773@arm.com>
In-Reply-To: <6100A74F-B06F-49D5-9895-DB7D5B563773@arm.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 7 May 2026 15:13:56 +0200
X-Gm-Features: AVHnY4Lrl09NphEZSJi_FOj1vYi9Xnddvehsx3EfxGg6sg2eNzNuaF0F25mnMPA
Message-ID: <CANNYZj9YxLpwDe4pTiT5-WMYUG=6AdV1u=dQHCZt45Pk9QF=xQ@mail.gmail.com>
Subject: Re: [bitbake-devel] proposal: build pipelines in bitbake-setup
To: Ross Burton <Ross.Burton@arm.com>
Cc: openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>, Zhangfei Gao <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 13:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19460

On Thu, 7 May 2026 at 14:37, Ross Burton <Ross.Burton@arm.com> wrote:

> To be honest I think I disagree with you here.  There=E2=80=99s already a=
 load of =E2=80=9Cbuild pipeline=E2=80=9D tools from sh scripts to Makefile=
s to the multitude of  task runners written in every language under the run=
 (invoke, rake, etc).
>
> Does the world need another one?

The idea is that bitbake-setup should help users do something useful
with a build they set up, by providing a standard UI. You'd type
$ bitbake-setup run
and it will give you a selection of what's possible, and then proceed
to do it. It's the equivalent of 'kas build', just more flexible :)

If someone has written their pipeline with make or a shell script,
then bitbake-setup can simply run that (e.g. a pipeline containing a
single step), but I think there's also value in having 'native'
support for multi-step pipelines. They're simple (e.g. executable
commands are static strings that can't be parametrized), and if that's
not flexible enough, there's indeed plenty of industrial-grade tools.

Alex

