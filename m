Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D44C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 11:02:49 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web10.10389.1720522967791574942
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 04:02:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YevlgrP3;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so33431461fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720522966; x=1721127766; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Un35DYm3/ZxQDzOlGzmbVYrMbLHXFLo9d4i+o0i/GZE=;
        b=YevlgrP3//hKEuAPBiunHPLITFl5XogYZssLdBU2gzH8sTqYzEgpFaLdBfCv30I5D/
         ukrKP+7bwQdSqAX11DlSnF7JibxPl0PnIUJNz7SAhldP0o+kea3xn5GWbFDDiRlLpddA
         NqaKzCdPHtA46XpBl1HgceMDnrbEGQdoe1US9aIv47S2pGvP4j6gpLws2cxKp7vaKE1z
         GbQmIxvejcsThdTAoPduOcBERm0dtcqi0baznRGYCcSlzd6wYBdzICKGgUsNRAL7F3hv
         bOwtRuQh9KC34sU1M2oUY6tmuTK4pFFAjgkucMAbnsr3rZ0WLRCbL/QtExbGKgGlsJVN
         qoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522966; x=1721127766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Un35DYm3/ZxQDzOlGzmbVYrMbLHXFLo9d4i+o0i/GZE=;
        b=Cjv01bVBARR3lTtRA12UMmE0J9S2zZABYvkdGs0uRJY97LFhdegMW1yCcjGPBGcR9d
         Hq/DucScKlamER8fK1o/lBRF8iu3SenUKOkQTVJYXpVzzvig8kcJ3RNMslYh4uMMhbSY
         pq97TPA/ypIQDLIfxaZZoX3tXF/V3HkL03m9eMyTqJY0ClxmPOz1KBjIdux2nAxk6Mye
         BThX+kUbA08TmPdXfJe4kSsj4WJhN9kTOCaQC3J6tjIo5+jxbm2450QSr7QuVBULhhXY
         /b+SsxvtmaGbk1SZkEd+do+gkYzQaDOC9qq5ftVEKJi9Wzpe9oRsfLp619Er1oIcs2Nu
         8U3w==
X-Forwarded-Encrypted: i=1; AJvYcCXBzSC6JkzWI5sRxKAMFSFyXYgCtstq1CrnbB7ONON/jYREmoo6UzEQHWqZf6HQgNojWoAPgckS4qLF2TiVRyxkcfLlnFeY8VJmKBQ1S6lWeuU6x3Y=
X-Gm-Message-State: AOJu0YyKnpFmyVlItAtSSPr9HgC71BWuvDDUtrd/QUZGtdgIXmm3Thzn
	9yXStSZcxORPa19UcyXZoJPBBy/YWog5fjLKc4vDzo2j3yibNHWNI9h9H3cERv/CGV6i3lrWAwL
	2qeoVLWw5LjUeJDxffcI5zXFpkdl5ug==
X-Google-Smtp-Source: AGHT+IExU2KhaaX1/w4hreADyGE6dSGjxywa14r/qpztf+UatnblezNJNUTsnJO3EK1kkawNvEmW2tFrA7ZYuyIdPXw=
X-Received: by 2002:a2e:7215:0:b0:2ee:4d28:981 with SMTP id
 38308e7fff4ca-2eeb30fefb7mr18032201fa.25.1720522965470; Tue, 09 Jul 2024
 04:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240708081034.1474312-1-changqing.li@windriver.com>
 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
 <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com> <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
 <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
In-Reply-To: <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Jul 2024 13:02:33 +0200
Message-ID: <CANNYZj9L_8hu8wsV0Jq6MG9_o144iTdV9KoQ1uAvMWaF7R-GbA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
To: Changqing Li <changqing.li@windriver.com>
Cc: ChenQi <Qi.Chen@windriver.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 11:02:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16408

On Tue, 9 Jul 2024 at 04:42, Changqing Li <changqing.li@windriver.com> wrote:

> I think applications like Chrome, thunderbird etc are commonly used applications by user, so they are might in
> ubuntu's package repo,  so they will support it and add profile for it by default.  But for bitbake,  it is mostly
> for developer and and not support by ubuntu.  And considering  there might be many other softwares meet this issue,
> so I am not optimistic that ubuntu will add default profile for all these softwares.  so maybe we are still on our own.
> One option is using this patch,  so users don't have to struggle on this problem, don't need sudo, don't need an apparmor profile etc,

Yes. Things will 'just work' on the surface. But you would also be
doing those users a disservice by quietly disabling an important check
behind their back, and not even letting them know that. Some users
will not be happy to learn that after the fact.

> but have the side effect that skip disable network,  we need to balance which to choose.
>
> One option is document or  notice message in oe-init-build-env,  suggest user to disable unprivileged_userns or write a profile for bitbake.

I wonder if we can wrap the actual /proc/self/... writing calls in
disable_network() (I think this is where things fail without system
tweaks?) with an exception handler pointing people to instructions
about installing an apparmor profile. It wouldn't be optimal (this
happens in a task execution, not in a build setup), but it would help.

Alex

