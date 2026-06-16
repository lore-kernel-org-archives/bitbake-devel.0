Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C2CD98E7
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 09:51:56 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.150769.1781603511317452030
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 02:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dVwBdhP0;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51764768c36so61408901cf.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 02:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781603510; cv=none;
        d=google.com; s=arc-20240605;
        b=dsHrrpvFDDBEUVcho+BGKpTbj92IdlZBtp8tAumH2sTNrxDAoCtRbak3goGaaiGEC9
         edvw70wYAKk4Emu04wuGF4SY3QSzvRbTRBxt2Pdi0SNN4d8xlsvlVI/IbR+95Rf6Q6Bh
         uGRzwcZjjhwvA5EbbihKvg8yDo/3OqhVOQ8+yWR8aJ+oT4TVVUY4iuhhLB0DZwT1rvw7
         eZqf8B8u04vUIGFQp0iICMvANoO3cFecXtnxv88y+DhwHmINfF0HhqPKL1jW6xSfbcOP
         V0BBw6QvQpXtL4nKR6SXLXe2xWyCnAp6n7Q4iNjWhhoLWY5ZQrePdutGOLuPyE+sLJH6
         zW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1C9AySTXkfWjxknozRVApm9pNYSPzw3sBu7XINLqTJc=;
        fh=mUlp8pz9+bLOeXyxqBtCGC2Mb3iwsCq10NPbAD51KHg=;
        b=JKzCryGy6tYNz7frcOwMVtHB6YQ2Owx3+6AKTpeCrBuQwlBEyYLeMg6CPltncRPjMP
         X7QlvHrfVoWEYikPWCZST0cwHv7Mfjvr88k7C3D0u/2Jgit9rypoVnxRQWumvBu3mvuQ
         ZJLxF8o1+DerIkOPWr6k43q5FNHM8Gp4MQM/u5sx/Ym3Y+rVovMhvcqxMkt2+8aOELDl
         eCcLJlWHTQpjwXiit+nzoSfkMly+42m6q4y8kuU/FTs5m2uWLob4dLe5aP4ERlzCZtnE
         K2AOuUD/y3uzmJ8oZd6yN3a8vhbwSEaSJokBwmY9ctsDMSWeP3ZJ0wazlvBpBZBUC80f
         HRvA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781603510; x=1782208310; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C9AySTXkfWjxknozRVApm9pNYSPzw3sBu7XINLqTJc=;
        b=dVwBdhP0pd+ZOYOXVnfsK/Fr4uWoxw5cAkNd9orSP7Rjm3MT0XlxrXrnc+yisF01mU
         lajc6OXBsFh+LOhoWR157F8WJQHsmOoqe6EsPCvBnEDPuWflrSXa8MBF3C6JTUO55wVC
         KjotzkpNr3C0INw7GFTuxL0p6a4gStAlQpOtVyFxP5isd8Xvhvpv4lQuwwEv8KylS7iv
         uISbe3mZS3iXTm/ar9fMK84ftXdWTxdq/sFqhdarRsr3tA2D/NASrK+2NwkDIQ9O2Yn2
         zFW1YCz6ionZeBdt1vap81Cl8O48p/i1Wb0owhT6KF0lrMDj7S/r891i3RuKLLrBA4Ts
         ui+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603510; x=1782208310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1C9AySTXkfWjxknozRVApm9pNYSPzw3sBu7XINLqTJc=;
        b=FSPVm0BN7kLcMWuoMW0eIpvlWft4VsveszNe+PXbLVQYi32oySvEXFssVe/+m/heIG
         bYUUZFVPzTOC54o/vcYylM7Ry0sSkOn2YFrmglG5oBqdPkCRpq7rfND5pXcQGZSLn1vV
         s3jMclv63hd9IlmDDLz6cVMmkKnDnNHAoLRws0SmI2ERCENURsQ/jmMAkz2H04Nsha9E
         CZH6hj8L4iz/qJx9aGoX9THHTFNADCly6LpzAvxp36zp+JIc8oMUNmkphjR+HOGrbniy
         0Nltln/KLDr3YFWpYLVN7GursxV1bNnqy2154R+utX0rSRP1y3v6FYJmELhQM01uecvt
         KPHQ==
X-Forwarded-Encrypted: i=1; AFNElJ964qOVUjXeK24iTM/uF9Js7dpxi/bW0tCQDkpD1YMyQMIo8blSqeHvjb89dQhyU2bwNeuU59zRhhvfLvC5@lists.openembedded.org
X-Gm-Message-State: AOJu0YzC1ziF2+HLQTIvU1LFcZX/kc5D8TElnp5hXczvvT9jEZ6RyJ8T
	OEz/N9/OpKZ/3vyIzwNkQnTL1TrF7WYF54MPlvyc0akYB6yVEfImfBPS4FlDFAPztasVi3WQQPG
	sEVM00EsK7wL7A4q6I7PsaADJ+n32Q5E=
X-Gm-Gg: Acq92OFlzJocZzcmZUW6yR/9IVo+mOFUj2BiyQsVmPvcnrzLtEEX1vNnCwZJKIvS8dp
	JdKpNZu3eEH3V/fJ7uvaY4MdMX0ewueuKBfaEDz1yYS3AAJPZOA1FDCYvQPLdRi+GW0FdrIB7p6
	QuSvf92cu+SPQcspjLtpAxbcrVz05z4VYlt8EnGMjapY/MHXGz0y0JCRLb3atBEGnq4o0v/jxPo
	UzND9O3l8VNCfLso+RF4Yg9UIuOv0uS7fulueJkpTJRev7OtbkMsTORQ///EtmsDQJNZvjMWCw1
	KCanelz9xO8zjERKM4h65NxS07HN+olUAZPGBECJ4g==
X-Received: by 2002:a05:622a:28b:b0:517:a9ef:ce30 with SMTP id
 d75a77b69052e-519535151d4mr214365931cf.17.1781603510319; Tue, 16 Jun 2026
 02:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
 <411bfc4142ad6d577df4b9350d6a18ca977b7127.camel@linuxfoundation.org> <b792862b45f9fdb57cba31418d8a18c68dd2e70e.camel@bootlin.com>
In-Reply-To: <b792862b45f9fdb57cba31418d8a18c68dd2e70e.camel@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 16 Jun 2026 11:51:39 +0200
X-Gm-Features: AVVi8CeIj3vwA9viofvT0EVYRzsMEdKSuO8nQIpWXKmROZJKhwEUGZpgIaHFQjQ
Message-ID: <CANNYZj-w2oCUwSEOAhr4=T1cFKzuchUPpcr=sUZnYN_c5_zk9Q@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 0/2] fetch/npm: fix security issue and
 re-enable fetcher
To: thomas.perrot@bootlin.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 09:51:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19701

On Thu, 11 Jun 2026 at 09:16, Thomas Perrot via lists.openembedded.org
<thomas.perrot=3Dbootlin.com@lists.openembedded.org> wrote:
> > I suspect there is a patch missing or something here as it doesn't
> > touch npm.py and half the changes above appear missing...
>
> Sorry, that=E2=80=99s strange, it seems I made a mistake with b4. I=E2=80=
=99ll resend
> them.

What happened to that? :)

There are users of the fetcher that resort to horrible hacks, and
there's just been another request for it, so if you have patches, that
would be most welcome.

Alex

