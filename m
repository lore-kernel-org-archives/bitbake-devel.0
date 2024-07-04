Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D7C3065C
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 10:17:35 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.7105.1720088250849179998
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jul 2024 03:17:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RFqOMTnD;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so5967911fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jul 2024 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088249; x=1720693049; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoTOfnuC3ffSBvSG4YfPhn7gjfeB8Lczn/EHGK5xCNc=;
        b=RFqOMTnDseE2MLF7RocanijeHWakuZjNYj2OATRVJO0ka52KFkmpes0qff3XaANuN4
         6u/KMIq+QspFwDqoMk5KaPUAhEEf5aIsNe0Nr0CoL10kJUMeM2BMygvpfCHm/V3UH7Lo
         CJrCTXn88HJD7PfgZf4vmboejUXWJA+SxyMGDAcyQcXfMgvGhZHFa2NyyYZkqfyeWmH2
         AOCRaXgje7Cd5s+i/Mgh5Q2OUDBCT3vTUm/Uc+GVzT7TVcP8M5zcQy7TjIe0zkT9kigg
         EaUDJXoxVj9d8UfNsQbdrbuh1T/YmrrUmmfIUe2BUHWrDC8HnSP07++W1MVn9R8w2MMY
         vdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088249; x=1720693049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoTOfnuC3ffSBvSG4YfPhn7gjfeB8Lczn/EHGK5xCNc=;
        b=HXmTRHlh3fk8h0VMnVWJfPWuvWgi4Bkx//pCPUawiKo80a/lgzz5aaWenIJkNrbsdj
         6zzb7w8RSaU4KXbga+j7GQ1K4ZOelY9AAKeEp28AHj3xHGB6Iz1DjT/2OSE3lbemtLn+
         RTAYGJ5o8PAlaMTt+rForXJdEohGwpkWpf+OIExQ5Qqur0iznJkaquKs7dr8dKfy7JNG
         U9vORZbcuRIX3fIwMLvDBnBsBKj5jfcZ9uma2X4A43DXiRdn1vr3ut2HZwRd1rhm9nbZ
         2j9mHvcolkOq3tpdsVEgDwiDUm1ccBsaII1RNzvAIF+8IEcrN0bz7aOgAFdxmRZXCjTD
         aKqA==
X-Gm-Message-State: AOJu0YxgRwyOdJRALSU9oDi3M1e7SY1ZHPj5ZcOino5ChUVD8JMLtE87
	9We33+mK4dj5TzG++zFMOLyqCvXkrQZiMHLG3KdxD8IbBuPSIs6AFK75p112pvMEF17wcifM0i3
	HZz1gWnL5d1hBWLogofiJaFg01kI=
X-Google-Smtp-Source: AGHT+IG+pyluVR/vb10E6GzpXf+0+MgIGLVQgq2P6lmIxwpPLqQErDd7AEA7LMVC+51W9pi02ayvPvDCX+79IvyWeiU=
X-Received: by 2002:a2e:be03:0:b0:2ec:4f0c:36f9 with SMTP id
 38308e7fff4ca-2ee8ee0e7e4mr13795541fa.36.1720088248779; Thu, 04 Jul 2024
 03:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <a69fcf65d7994a728b5e2e1791f32a38@nokia-sbell.com>
In-Reply-To: <a69fcf65d7994a728b5e2e1791f32a38@nokia-sbell.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 4 Jul 2024 12:17:17 +0200
Message-ID: <CANNYZj__8rYA09zo713LdmdbVYazsaajj74a--aAdvP-ZdoX3g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fix wrong http response for sstate cache checkstatus
To: yang-mark.zhang@nokia-sbell.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jul 2024 10:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16387

Note that reviewing patches sent as attachments is very difficult, as
we can't comment on what is specifically in the patch. Can you make an
account on gmail perhaps and use that to send them? 'git send-email'
will ensure the patch credentials will be the same, it's only for the
patch transport.

Alex

On Thu, 4 Jul 2024 at 07:32, Yang-Mark Zhang (NSB) via
lists.openembedded.org
<yang-mark.zhang=3Dnokia-sbell.com@lists.openembedded.org> wrote:
>
> Hi
>
> It=E2=80=99s about bug and the patch to fix it.
> I tried =E2=80=98git send-email=E2=80=99 but unable to successfully send =
email by this command.
> so I try to send it by office client
>
> the issue is in sstate-cache checkstatus() for http mirrors
> in http checkstatus it use HTTPConnectionCache to share connections
> A request expired 30s timeout and released the connection,
> B request took the connection into use and get the wrong response(meant t=
o response A request and late than 30s)
> details can be found in attached image and patch
>
>
>
> Yang zhang
>
> Central Build SCM Team
>
>
>
>
>
>
> --
>
> Yang zhang
>
> yang-mark.zhang@nokia-sbell.com
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16386): https://lists.openembedded.org/g/bitbake-deve=
l/message/16386
> Mute This Topic: https://lists.openembedded.org/mt/107033227/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

