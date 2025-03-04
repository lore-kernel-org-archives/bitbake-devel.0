Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A3C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 16:18:06 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.25854.1741105078136859090
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Mar 2025 08:17:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gHjLqQ/X;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6009508e87.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Mar 2025 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105076; x=1741709876; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnkmv6jJW3hhiAUHDrbikfvZJqfcca40I+lrr7AqIHA=;
        b=gHjLqQ/XzIhoQVrvcBfYMufwNYlROZJU7coEUEFfg9sm9CxTTxZ9C5yBoN3nQ6jo+V
         tfEDuCVwUIl2jmRg0ENltIyKqG6/sBOQtW/rXFlrwFuooJtH/sF4bnKF6HbssTIHKFd6
         xzD2M46aXtQ8nOCmLbQLafv2AFMmvE9Y5OnPAhd5WGaNi6Ct8+s68HnBay0z0mtSd4cl
         8j85sT3KxlBt0O4Fad87IVC2yalSxtLKdmneQGnFqsA8MMjPHfr6OXZtQziILHuahQuT
         +puvuwyW/eu8vxcRnsJEFqiOEb24sguceTQKo4daG8oJj/5FmQrbqecvSOLikxDlk/Ow
         3pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105076; x=1741709876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnkmv6jJW3hhiAUHDrbikfvZJqfcca40I+lrr7AqIHA=;
        b=SxY6+F4Mb6CK4HgoCDwiqvw08Jx+o3xgEnuztoaq57EqdCA4uzVS3dDnWGPHpDCh/J
         N1nNGwt2d+zUNmhpJB4TjEUwm9DtSNah2ndvHfIzvVYXLtyEtqU9uNdRvUJ7kpKl8GiQ
         VyOrq3IE02R8UygcAbuvgOwo/g/gJQupy2V9aDr/6xLjCVVlkDSj4tY1QJJCvQofwXjM
         3Yypp0C/3DpobAqI0SDMNTqqeeSmimfrBWiga/CLmyxuSKTx6NFdL4urq+SkgZvnPVkB
         bha3TA0F7MztC0uqVsJf5aH1zJwxySJ2TpOQsNOj19y0HGLCF6GhdeXPNezj14aEceoi
         dmNA==
X-Gm-Message-State: AOJu0YxoGzp1PemXyAkFVF+4OBN6v6uo1VGIl+ihA3FSVX3LZSb5TewF
	b7pRQt5/Ho1xNwX+ZlzOEH5y8FkDH+11GkXI6OktKnA87vKZ3vHF0uN7819fLIJCH3yTPIAqmoY
	2yW0G1Og+tUGZYwfq1QmMI5EaDuE=
X-Gm-Gg: ASbGncuEp9n7YFsl+KMIQi6EIGcV4d6jBMu8IwM/Sq3BZKvmSA2i7MSzbITMLKpVaWl
	oGaOm8dwanSNuX9lk9GOzXen/5jDuI29SghUU2t4u1BF46ksb3Z4/0fZy2ovDvUDeEztHBxelId
	gAHSakRtHhG0kgChEFQaputB5LgYeHFImu5B9Vmmb/
X-Google-Smtp-Source: AGHT+IEhF+BpdCm9jAwngKBMpgVaMIYR29gFTvjf/MyVJUtFdaE6/+e4GGuvN8bj/QEtywIIRjpmv7vqcIxRhtlXXiU=
X-Received: by 2002:a05:6512:158f:b0:545:2776:8529 with SMTP id
 2adb3069b0e04-5494c10c62emr6396938e87.5.1741105075878; Tue, 04 Mar 2025
 08:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org> <20250303130628.1656131-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250303130628.1656131-2-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 4 Mar 2025 09:17:42 -0700
X-Gm-Features: AQ5f1JqBGxDjTF7Q7F3HD1Qh9u0EHjfSKxvhV2Ywz9r4M0FYpSqNVCvmu0ypGWg
Message-ID: <CAJdd5GaMEgvpHE8HgwE5dUJ9uc_yrHT0oMi5T88CgekwiEEqaw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/4] utils: Tweak lock_timeout logic
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Mar 2025 16:18:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17381

On Mon, Mar 3, 2025 at 6:06=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> We should really try and take the lock in the try/finally block so that
> in some rare cases such as badly timed interrupt/signal, we always releas=
e
> the lock.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index da8c20fe95..992e200641 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1881,8 +1881,8 @@ def path_is_descendant(descendant, ancestor):
>  # we exit at some point than hang. 5 minutes with no progress means we'r=
e probably deadlocked.
>  @contextmanager
>  def lock_timeout(lock):
> -    held =3D lock.acquire(timeout=3D5*60)
>      try:
> +        held =3D lock.acquire(timeout=3D5*60)

If lock.acquire() raises an exception, then the `finally` will fail
because `held` is not defined, so I'm not sure this is correct

>          if not held:
>              bb.server.process.serverlog("Couldn't get the lock for 5 min=
s, timed out, exiting.\n%s" % traceback.format_stack())
>              os._exit(1)
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17370): https://lists.openembedded.org/g/bitbake-deve=
l/message/17370
> Mute This Topic: https://lists.openembedded.org/mt/111487227/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

