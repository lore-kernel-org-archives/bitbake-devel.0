Return-Path: <troth@openavr.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B215EC6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 19:51:06 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.6986.1679687464655772215
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Mar 2023 12:51:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@openavr-org.20210112.gappssmtp.com header.s=20210112 header.b=Ytg6vSlQ;
 spf=none, err=permanent DNS error (domain: openavr.org, ip: 209.85.221.44, mailfrom: troth@openavr.org)
Received: by mail-wr1-f44.google.com with SMTP id r29so2867617wra.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openavr-org.20210112.gappssmtp.com; s=20210112; t=1679687463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGdJRkO/ps1+Ixooe8PJKtWCl+vINnqHn6Ob6epyUHY=;
        b=Ytg6vSlQnY2+8BlMy7NJu5dUIcoT5NXGLE1R2bTfA/jfD0xwsvj4rOC0zW09rkYOH1
         QjasvDtkTn9SAoMY/AwwBmGYTJUohRh27kgd2FATxAJ9N25xzTzHSM08y5q5RsQrUKTv
         GTd0qrYuqknquAorLhzfSLYzgtvzIw1mLWXEvQaNMQ5mDasU/Mg+SA8UXTkIj7LHbAj5
         qD954+iBhEoi9t0uDSuhVhmrbmrHo69lCFbbDnUe+nZyD0iBSx4xj7iSfiY//lZ3evi7
         cpt9VoeJrAkBucM7PEGJpzbXhj9QmQMWdsKPH/PMX8GTAlN+ZOq8DQV+BKD/7JCs8o1N
         4KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGdJRkO/ps1+Ixooe8PJKtWCl+vINnqHn6Ob6epyUHY=;
        b=t14xMr/RiOINFqyD1b2BeEGwz5N66it2sSCHxolXolp9lBWAi7Q+vhNai8WWsvOtwu
         cQOJggKTxAirZ8W+MbRFuOCr/kocBNLT5PZz+XYChWnG9/M2HPL2lrFZHrTB3omPTu8H
         42oE1te86XZ3gX1ZDeal8sp2YeuAEs/MfMqCS9eJuSPdxKWcarKZiFGd9AL0RsqBYc+j
         5ulWtupVAJ1IfYLlhLXdlIobote1M/YT/B9arXkJs83dkGiZe2fiwi5swNBtDJErDtRg
         dnIejTGoEXMWMVcKKJ1g8M2FNrzQ63GficlWsTuvYXQ3XZtpKZ72O2+PbLW9wlEs3jeY
         xbRA==
X-Gm-Message-State: AAQBX9cAGAoQ2IzbVQCmEW8HcIyocnpgM6LE3H9ojowaDMOPGJUrXU5M
	wtKRQDWgElZfcO2GeV9J4UgTBVqZuXVkAJ9H9vFjpQ==
X-Google-Smtp-Source: AKy350Z3006Aqwx0N7D3WVFuuIEmCOuTZV2CnHRX79RbU8vo8EHiHMK0mNoHLesgXqC+BSCyzQnCfXdSJ/0MWci7WRQ=
X-Received: by 2002:a05:6000:1a8d:b0:2cf:e75a:eaf0 with SMTP id
 f13-20020a0560001a8d00b002cfe75aeaf0mr2912646wry.0.1679687462944; Fri, 24 Mar
 2023 12:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679641659.git.liezhi.yang@windriver.com> <e763d75fb33b69bbfbf3350b2592b4eea7d3878d.1679641659.git.liezhi.yang@windriver.com>
In-Reply-To: <e763d75fb33b69bbfbf3350b2592b4eea7d3878d.1679641659.git.liezhi.yang@windriver.com>
From: "Theodore A. Roth" <troth@openavr.org>
Date: Fri, 24 Mar 2023 13:50:51 -0600
Message-ID: <CAFMvBt3DoQmj371=wjzTefmvKdXUFwZGjSXggGnFYgqcK=Ftaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fetch/git: Fix local clone url to make it work with repo
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, sam@liddicott.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 19:51:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14618

On Fri, Mar 24, 2023 at 1:09=E2=80=AFAM Robert Yang <liezhi.yang@windriver.=
com> wrote:
>
> The "git clone /path/to/git/objects_symlink" couldn't work after the foll=
owing
> change:
>
> https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d5=
6
>
> But repo command manages the git repo as symlinks, so check whether the o=
bjects
> is an symlink to fix the problem:
>
> * Nothing is changed if git/objects is not a symlink
> * Use "git clone file://" when git/objects is a symlink
>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

Tested-by: Theodore A. Roth <troth@openavr.org>

