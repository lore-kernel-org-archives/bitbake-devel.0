Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C726C77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 06:57:01 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web10.14478.1682578615141695862
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Apr 2023 23:56:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=fnsv4t5K;
 spf=pass (domain: gmail.com, ip: 209.85.161.53, mailfrom: raj.khem@gmail.com)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-545d82e1a1bso2551842eaf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Apr 2023 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682578614; x=1685170614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mHVXcg2ajXphDZtpN70pJG0URE9UvoGnlzKD9EnmOI=;
        b=fnsv4t5KvG4yKezHe7HWW1rDWEVC3Qcum4tlL7LJOLKCWYq2XxloYrBaROPV75UmeY
         T4v/HO1btU0rifMjhpYlSd4Wywku14k5SAzxx+ARRopOg0t843dDhvvqAitArwSvZeGB
         /fZSZ1fa1PqNYNRUAWKCpcN/TA98ZCdyQqpasdAMObaR6/sGSg36cSIioyRoF7nPA7VX
         fW5fKCMRD6j8zVRkq4h1G+vKvTCLoXA3BmlZff1o4cV7mq5vHVA5Cb3w15msI19Ll022
         mQxPmp/0++mESguKqCje2oY12tpNAeK1FePsRcvFw92BP18SIkK0oLAWapbCGSUz+F+G
         KS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682578614; x=1685170614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mHVXcg2ajXphDZtpN70pJG0URE9UvoGnlzKD9EnmOI=;
        b=VuUwE+nOLn1iYiGzDlhhQP/uZCY5FzuUd/9LOvnQhsbfPKJRZuUK4T0I8T5KwlqL46
         f0mioJ/WsafEg63eIup74lJum2a4PK16jD2spAg2aKTd3iefC1tv5wHvbiZQVj6CwwIV
         DIgijSbIgliXNkLcd7EOTuQ/5NzQ8V921Nm61CisiXJtHEx+7SKMcl7+qQSXgaeJ57Q7
         4r19nKJyWkFj5saGSJk0SK/qhm/ToYK9W4Sk3g0AURrHNyAruih9f2cythIsfp4UOpw3
         ge94ky/AuBblaH0gpEV/8ngT3LvBHg5fzWgdv2a4K7F3ExrfxNll/vsnIo+ntgAQn5Lz
         EYNA==
X-Gm-Message-State: AC+VfDwisqRubLrRGy8ZCr8TqcpIX9ZjvCM2g7k+s7AGiFyfCuvcaDuw
	GwR9y6086NvKNbLRyT6WHuFn8ME22cdQtdsLzC4=
X-Google-Smtp-Source: ACHHUZ5i6GCz65551DUKZ34l74rMiOweTVAW7OEnx5P9Pzpb9HbLjUEmyoXchwiJjPm4za8/4tqs0RvEDrWdPyDTibM=
X-Received: by 2002:aca:1303:0:b0:38e:3904:2db9 with SMTP id
 e3-20020aca1303000000b0038e39042db9mr179814oii.46.1682578613978; Wed, 26 Apr
 2023 23:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230420062113.134546-1-alberto@pianon.eu> <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu> <afcd01000f265238360efcdaecd16a4e@pianon.eu>
In-Reply-To: <afcd01000f265238360efcdaecd16a4e@pianon.eu>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 26 Apr 2023 23:56:27 -0700
Message-ID: <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
To: Alberto Pianon <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org, 
	jpewhacker@gmail.com, carlo@piana.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 06:57:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14750

On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon <alberto@pianon.eu>=
 wrote:
>
> Il 2023-04-27 07:14 Alberto Pianon ha scritto:
> > Could you please check if this is really the case in your case?
> > You'd need to go to meta/recipes-sato/matchbox-panel-2/files
> > (check where the layer is located in your filesystem) and do
>
> Of course it is located at
> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
> atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.patc=
h
>
> :)
>
> Please check also the other two files for which you get the warnings

My distro uses git submodules at top level and poky is a submodule see
https://github.com/yoedistro/yoe-distro

git rev-parse --is-inside-work-tree
true

% git status
HEAD detached at 5a944d32a1
nothing to commit, working tree clean


>
> thanks!
>
> Alberto

