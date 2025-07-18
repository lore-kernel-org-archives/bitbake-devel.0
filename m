Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C747C83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 15:42:04 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.23945.1752853313899903170
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 08:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DlzrjPWS;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so19376481fa.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752853312; x=1753458112; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDP85TgND+zpX4XDMWclhc/Ov7JEgjJWDILUMrfFE04=;
        b=DlzrjPWStnpqoFwDgRQ8qa4YspIKJUVXxK4fWuz76P2mzLsDQMYuYXWo1xXjX7cqBG
         8DFLchBaEYkByjWsivhsxb294gCQRwiY8viiwHBBFokTevCGb65b0LeI/dO0IPotx3D/
         cVr1QThVuBeT3D1EQssLErWRN2EqV6ImZIbI28EoG/yvn8q66RPG2jlmkYylWdMO/VPO
         Kx73kMaP8vdRRpqi5irPB1gJdsB/WzhU2HxOcxQ1v/2kCbibawR6qnLx8SUUHL7FH2II
         P27DFAyV8JckvJpvCgRur9xkpgLFDhgWCmuoJD7fTDFh98sH81X3TjUBYB5KvPkwqSIG
         7laA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853312; x=1753458112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDP85TgND+zpX4XDMWclhc/Ov7JEgjJWDILUMrfFE04=;
        b=qxYHZyklxiMMXd2vnPJiPF4EorLB1nc8eUyMEdd3W2KV5DXCyAgvnZ8s2IbgqCz3t8
         GA00g0M7a5tcclKOH/nfZFnwXSE6AYoDxMqjOLJESi4jUSTd5gTfG89HAjAzQw2DpLTt
         0n85VvVZi+C1vbu0j1pWZ0/pDhTrC3ABXoU9ZvvVkrxmZt+Q3LrS+Htbw/652XyYgG6X
         3BpIvySS9shQRVCDyhBIyPleZBaQMcqiqyLc9wbHQBlXIHZmdh1jOApZSTXw215zMlrg
         W7w8bPhn3EUi7UuaYv+uYU3GGoP7nGkEJDZ/9YGvIAIbsWQXeerSDYbHACH7OQf9QKO6
         jTOg==
X-Gm-Message-State: AOJu0Yz0dPCzuahbH2shg9UIp2E86s3nNkV9hdkANH1iazc5hq1AlcYN
	8UCDAkgZRCpEM89jJ0p9ZE70MQ3AEq2JUfbGP45SnLJs/v5rRDxiHb1U9CDqqcdL1t4KKuMSdXh
	pHbQJcGHnrjMsV9+OTNEj2WuFB1NwPqM=
X-Gm-Gg: ASbGncsWouIXXacqYqZrc9dVXt4Tdia1S+BDWewLg7xOIuDgLxKuMtUd1LAmZ2KEavc
	ImW698DKoqz1AKNT2cFt4S6U8SHM9YnW6oj6/+47UDCYMKLLTtnwtQu1PJ3x1Y3czeJOytNGoUo
	hJJqyHkX4u7QCZv2QUbl2Y17SlitCcxZuivKSlbyFeZ1fMweoq9MhWqUjogJuI5TK1saFkBo2YX
	SujP3F7IbQqDwlR8WntIg==
X-Google-Smtp-Source: AGHT+IHFMWvR1qgsHLUK/8P+rHfRrRjsVxEkPBE9ES+9mWKFpcsq1drJaJebKgJSmWrbgAOAgdWw9LfG6490l7U3NEU=
X-Received: by 2002:a2e:8a8e:0:b0:32b:3104:f89c with SMTP id
 38308e7fff4ca-3308f5e73f7mr31418511fa.29.1752853311686; Fri, 18 Jul 2025
 08:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 18 Jul 2025 09:41:39 -0600
X-Gm-Features: Ac12FXyyyl8FgwVBSJdKcKi9Mgeln7l9AO7NfNP3HPkw7pd7LFdDLQIroTg2Fzc
Message-ID: <CAJdd5GYWWJFhii0ZZF9iZUQ9kKQaawrvYfkNa3m28KoTDGqR+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask performance
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 15:42:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17799

LGTM

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>

On Fri, Jul 18, 2025 at 7:54=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> Running "time bitbake -pP idle" with a valid cache shows around 800,000
> calls to enum creation from python's signal.py. We don't care about this
> overhead and it adversely affects cache load time quite badly.
>
> Try and use _signal directly, falling back to signal, which avoids
> this overhead we don't need and makes cache loading much faster.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index f688f7dd687..016036dbce4 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -2226,6 +2226,15 @@ def path_is_descendant(descendant, ancestor):
>
>      return False
>
> +# Recomputing the sets in signal.py is expensive (bitbake -pP idle)
> +# so try and use _signal directly to avoid it
> +valid_signals =3D signal.valid_signals()
> +try:
> +    import _signal
> +    sigmask =3D _signal.pthread_sigmask
> +except ImportError:
> +    sigmask =3D signal.pthread_sigmask
> +
>  # If we don't have a timeout of some kind and a process/thread exits bad=
ly (for example
>  # OOM killed) and held a lock, we'd just hang in the lock futex forever.=
 It is better
>  # we exit at some point than hang. 5 minutes with no progress means we'r=
e probably deadlocked.
> @@ -2235,7 +2244,7 @@ def path_is_descendant(descendant, ancestor):
>  @contextmanager
>  def lock_timeout(lock):
>      try:
> -        s =3D signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_sign=
als())
> +        s =3D sigmask(signal.SIG_BLOCK, valid_signals)
>          held =3D lock.acquire(timeout=3D5*60)
>          if not held:
>              bb.server.process.serverlog("Couldn't get the lock for 5 min=
s, timed out, exiting.\n%s" % traceback.format_stack())
> @@ -2243,17 +2252,17 @@ def lock_timeout(lock):
>          yield held
>      finally:
>          lock.release()
> -        signal.pthread_sigmask(signal.SIG_SETMASK, s)
> +        sigmask(signal.SIG_SETMASK, s)
>
>  # A version of lock_timeout without the check that the lock was locked a=
nd a shorter timeout
>  @contextmanager
>  def lock_timeout_nocheck(lock):
>      l =3D False
>      try:
> -        s =3D signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_sign=
als())
> +        s =3D sigmask(signal.SIG_BLOCK, valid_signals)
>          l =3D lock.acquire(timeout=3D10)
>          yield l
>      finally:
>          if l:
>              lock.release()
> -        signal.pthread_sigmask(signal.SIG_SETMASK, s)
> +        sigmask(signal.SIG_SETMASK, s)
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17794): https://lists.openembedded.org/g/bitbake-deve=
l/message/17794
> Mute This Topic: https://lists.openembedded.org/mt/114221231/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

