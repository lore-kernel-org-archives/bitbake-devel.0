Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F6CFB441
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 10:25:02 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.49978.1728296692877458287
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Oct 2024 03:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e/gnMoP1;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53997328633so5301328e87.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Oct 2024 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296691; x=1728901491; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiW3dU2XSKZJkvOdHwkY1eTMV0cXkgLcjbR3huYwelw=;
        b=e/gnMoP1zTGD3XEEstdAMp7/flkw2urVm4KV23f6g3gYjqUia0C7HqKfBnkbafkA2V
         dIWiOOhMh/iEHxfZ4oD8enCdHqezlHAcv+AE4VxX2i9uks8l+F3qIYEDietADKIsdTLE
         91Kb0qopzSD6Ojtbz+155YRpu8QDDmbD7ZYSnL4WE6yzmFaH7FosFLtViuhUoLVAxqyC
         vccsLvHf9uEJK0fR+Xz0Wf1iQ2UwJMxx72bm+tpTf7RJuGxSaKl2+bl0cZgceCNMaUg4
         edAGQ9M8x+XZheZxVAmVfw8694EeO5Nra0FHH6/mlnwIDIkv0q+hA1F2xW4xR0WRy791
         NcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296691; x=1728901491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiW3dU2XSKZJkvOdHwkY1eTMV0cXkgLcjbR3huYwelw=;
        b=hJ6t+oF1VqPbErw0JbVPwt+D4a2duvx6ucQNDBBq+VtRygNmLkypmpR/m3jov2zEpG
         /55wPqscmqV2H4cKHWe+fcs7y5Ki6zxRejBjodw8w4TEtx2e94ysTJ86GNIEunx1srW7
         tyK3EyrTMi3MA555wM3X0Ifp6CkNcYZk7QmevYktA09nSKRd9OTpHJsDkxR85zWLe6Mn
         vyskCEKvnpU5KyYkL9n/xvIc+CDXTPv/Y+/e5zDDWYFR+45l+vlcDa6YzK0XxVB0fJVZ
         vJ+dvlTyA46SJIVV5PbRAAzINMjesNIpHJGGsEIIFJS1UEtqtwy2HbPXnxRk1MMI/Z+0
         ZmZA==
X-Gm-Message-State: AOJu0Yx8Qj86LjeuD0X1GDrt7mhlOohMkSzUPT64mXKdTznICTeaJ+7a
	H9Tm1SZdgNqlWYRdH+LXzP5T2qUYYYlHLyWS565eBOiB43whXJrukssDURjQPLd6o0UOldWfCKd
	IAfRjxQPqzhOB1EtWGA6/O9R4uthXaw==
X-Google-Smtp-Source: AGHT+IHgCw8JCumJMrS87vEsgEX0ZW+yxQYY9RYZXn1MXGiAPSAuKE5kgWMIbvHNgUPUkDiYsRTZHJspbLNwgnubv9c=
X-Received: by 2002:a05:6512:ba2:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-539ab853fc7mr6915187e87.3.1728296690895; Mon, 07 Oct 2024
 03:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241006222630.278007-1-git@oliver-kaestner.de>
In-Reply-To: <20241006222630.278007-1-git@oliver-kaestner.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 7 Oct 2024 12:24:39 +0200
Message-ID: <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add GitHub Codespaces support
To: git@oliver-kaestner.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Oct 2024 10:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16649

On Mon, 7 Oct 2024 at 00:27, Oliver K=C3=A4stner via lists.openembedded.org
<git=3Doliver-kaestner.de@lists.openembedded.org> wrote:
>
> GitHub Codespaces use a Git credential helper that provides access to
> authorized private GitHub repos. To do this, it requires access to the
> `GITHUB_TOKEN` env var, so add it to FETCH_EXPORT_VARS.

Which fetcher would be using this environment variable? Presumably it
would be picked up by some external executable run by one of the
fetchers, which one is that?

Alex

