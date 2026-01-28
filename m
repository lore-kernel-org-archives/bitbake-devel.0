Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE2D46BF3
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 18:43:04 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2087.1769625776982743607
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 10:42:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gTRdHJF8;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8946e32e534so1723866d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 10:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769625776; cv=none;
        d=google.com; s=arc-20240605;
        b=Sm1YsC+7A8d0YwsQEMioQHX2AfCKQL/HHDCwFLk8fTbdhBeU9H507Mj52zJpFic150
         XdGTOYniH9h9FTgnFNEa+aAN2JH0j7Fv/DsUpBtg+FZw0X8q2HOi+W5JIbWo8FhVcx4l
         DB3mKxbDeHtXVnCW0NjqvI5eAjZ8VElUiPatA3x2CKY8mbBPhvXrD2vtworu0v5OjEu4
         kHgYW7tZcZVDyGUUrxBvwVzDlVLk/49ntOP2dUOs80+AWpfG1bpagV3wGwyh8V+6jLJt
         K86hw4aeiHzwaSI+I0VcKHesLkanppEr/hvjhKoDShBwlE6F1fcpK3J2c4ebTsgJ4Cm2
         5mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QBf3IPoHqYQVaWhkGzhq4/ay1HIHnyf0wbKkoijUa/g=;
        fh=jlfXIGFqiJJmji0XOVSr5x4A2G0iBGLYFcLfj1AUCow=;
        b=AKdmbTEEhZK7oeI+gydsUAokIUeef3hP4XCsXdSKDwmVr/HZT4W7GeBUtLsZy8kvvZ
         6/1EvknPI+C7+gs8u+VUg/een1OVJeOOnL65Fl+4LboqMLvboWGLMMQrWP/a82ypwYQ+
         4clBjQXE6ivw1k+xWT89OHOua0Mmt1QUxHQcrS4gyvA4X7q0//npFRCa35SamG+WfAAB
         LdGeyCwCgfUCxBP1fm5MiUiTaDqsD3JfXPAM8gm/Ngbp76qmroOcDQ2+ezNTy33lkB6a
         HE/FdJOhdHKw53hkSRt4VMRjiwrjeuIw+TAD70Ta20FhDtn6I8rKYpIJPYAc8wn19TVU
         tZpA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769625776; x=1770230576; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBf3IPoHqYQVaWhkGzhq4/ay1HIHnyf0wbKkoijUa/g=;
        b=gTRdHJF8nHi1q7X1VcHYj0ddtphzNrkCENIfa+P6zHJ/98JPwwcaJL8xvDGV94wCdA
         kmIbj2iUlHK6UcXm3FB8TFRan+KtTiWE1AOfqn/0TzM3b4XNj9moGE7kQQyB/D5pEKNQ
         8qsP9roITzBe9+h8Q/EZFOU28sHuT1xcFVmTMVTMlFymQE1Nz8BmgROBGFhEXzVaDKk0
         v6kYBFzm+oRUF0lbNM6ZSdz/hxl6ankHms+PZEC+X5Tk/Ar6CkNpHD493CsHIbEMebnA
         lfEZTrUJZrKg2whlQfLhDLbm90nEb2GcLXetCTaoAwZmTJNTwijvdy7zBR4lVP+od9SJ
         FeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625776; x=1770230576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBf3IPoHqYQVaWhkGzhq4/ay1HIHnyf0wbKkoijUa/g=;
        b=WZ/2atr7OYQNhkvSRA2uegoF91oWlJJVG8p+VdpsGjIo3+Q28dnlNBglYZPzpJaDLp
         LjiGdX+pujgdyHPW80v7rpJF5b19uo2pN1yjkEjXJmA2d0W1haTanLoH7D/MrkmZUjiw
         pJoiKxjnjqAW6Q/uBtK7bdfzF7R4qjSG5Bw5EJyYH1hpm5paneR3U0wb/mWSpEfl6hLZ
         6ZrWL9PaQzvm3dPu69xI0hYk9FcCLK5dWTbxGl7LjIXwVwfNlNYSrDFeZb0YjU7OEcc+
         FuDBjkZaiSxevlYJ0aaUmvzN1XgT5gaieflnF6YOwVFN1jBUDduKwaf3oVKp0N7fYz3l
         d14g==
X-Gm-Message-State: AOJu0YzIrLxwVOWa2jHATsH4cg69cmQuNSrPOCarMmjh09av4XfTq40y
	Lx+f6wRwv1DjFUUg38bpPGR7UTTDfJW7ZNgLsKHgdJYydO8ieXXZ/CN+Vl6XdChpR008elGLW+C
	ex66+JUixbW00B97GfrCqRuCvfCglfcg=
X-Gm-Gg: AZuq6aJOfRGaWQd1JSuj3qOM3KYIrgIn1k6PwnViErFpcp2AtZA3WdQDyURSdgcNJdz
	G2NIRhifbDetocsx4Dp59ywwG6sFHs1fESM+v+j8BXCAVn0h5oud6TUzfxAJjA4PuEN9XooVcby
	hvnwULU7afWpypezjMZ8DrLPDuGVo5dxKN89apnXj+Qn5JUeIYWY7AMka7li5VPxTE/Q34Hd76n
	734R2PONdgdF/FCEgDr510OO2LkJvph/ZKoqI581gy9fTnvwKHLKpYOTHEPcXf3m951pHNABEXj
	SSkdEi6c2d704L0h7AD1kIzClzib7w==
X-Received: by 2002:a05:6214:62e:b0:894:8311:d3ef with SMTP id
 6a1803df08f44-894cc983185mr89843866d6.69.1769625775940; Wed, 28 Jan 2026
 10:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20260128143336.1963432-1-anibal@limonsoftware.com>
 <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com>
 <188EF863C74CB2B9.4042470@lists.openembedded.org> <CAOU5ZMvLpHs6ETo847GR2=N7iL8qPxwjuo15aLWpehpmpsucrQ@mail.gmail.com>
In-Reply-To: <CAOU5ZMvLpHs6ETo847GR2=N7iL8qPxwjuo15aLWpehpmpsucrQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 19:42:44 +0100
X-Gm-Features: AZwV_QgolJ9VcupHgQVWfDd7KxiNo1jLeXk9-NvFMzitjq8kfOXVpCDnUNGB9rw
Message-ID: <CANNYZj976uHS__6bsfjeYYpL-d4NqtkRitEyx3g8FvWHVT2GgQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: _has_local_modifications
 fix layer add on existing project
To: Anibal Limon <anibal@limonsoftware.com>
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de, 
	jonas@limonsoftware.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 18:43:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18924

On Wed, 28 Jan 2026 at 19:30, Anibal Limon <anibal@limonsoftware.com> wrote:
> - setup project with bitbake-setup
> - add meta-freescale layer to the config
> - setup project with bitbake-setup (fine)
> - checkout previous revision  without meta-freescale
> - setup project with bitbake-setup (break)

I'm sorry but now I don't understand. Are you setting up the project
twice from two different configurations? Why does the second one break
if it doesn't even have meta-freescale?

Alex

