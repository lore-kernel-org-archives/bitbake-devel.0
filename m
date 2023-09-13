Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA9EDEC7B
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 15:48:20 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.186.1694620099204018263
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 08:48:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=PWAA/jbv;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so1358682e87.0;
        Wed, 13 Sep 2023 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694620097; x=1695224897; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pK23cyHJvXY2ZzwXEuWEiFcEjlY7syeAg2cBPKmfEs=;
        b=PWAA/jbvy/GaazHA5nj2HBrhkE4m5jWrglgT1af/6f492Z5p2SBQR9BZPxItj5EMGc
         j+5M4FymQ6FnJ8P9YIX7MqJ7HUcMtg8Q0eF/jaKpC3ywvX3bQsF2aGGxhyg2sI/Tz4YR
         xI4OOV9CjAANEHfSXvVRn7gg15NqFykes8fQ0Qd3ZMeuCuGwTI6bE5wuXbBrxcRb07fG
         nlgHP9qr5GA/DL6dy21OaG1a7Cn9wMmjQ1onAzHZNYQDRXKNbIEfSdeCW90aZ1QhqRlB
         wgcctT64yehbJKfLp2q1LX+0ZH3SRi5kl5F4tfuadVcEbKGY/9N+PJUgb1n6PaV4naZ5
         2bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620097; x=1695224897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pK23cyHJvXY2ZzwXEuWEiFcEjlY7syeAg2cBPKmfEs=;
        b=vkwjRR8jpLEX27tfNC/OvT1CxHDODTMoWg4YGMei2gZClRbvF2V9XqI7xm4vTaSAC4
         Vvzlr97bsiNxY0FUa+Asaw2p7otC/GuGqWMWTTwJvVCLTGRqxSftTrJxOy/vkqAY2ZiN
         QTJQU3dKuhHFpuua/TgTc1/XTu0sM4FaBsU97rqtA9zqcWLI2U0YgoIJoU306YT9Ulfs
         cDRLbM1kEfGOiPwW3g1mSs8x+Wjm8ys48jq+JnoNzUbahNHvw6K7+0ERJ0ESayeeRI4C
         jW0qlyl+fJY34wiTXp+BXClVwKW8YXlHB5QMMxZWHyrV4NjOC+A3vfF2y9TOZ20E5xjT
         Mwng==
X-Gm-Message-State: AOJu0Yzz2CD4fThQd/evO3qc7vrwCGH7jNE3smxON88WuJej2B6s5qPw
	IBdscEChhE9gJweRwQt9U06AATXMUBiJIpkX+g5nLnHh
X-Google-Smtp-Source: AGHT+IFQFpKf+143ObU6ldqJu5mnMgMORbYSkYm2NzxL0/hs0i6mkSZ3Iq4nOicO4OaBb6EVNfZkgoKod6ii5UuHTX8=
X-Received: by 2002:a05:6512:3f11:b0:500:d96e:f6eb with SMTP id
 y17-20020a0565123f1100b00500d96ef6ebmr2172339lfa.19.1694620096445; Wed, 13
 Sep 2023 08:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230913154645.3699632-1-JPEWhacker@gmail.com>
In-Reply-To: <20230913154645.3699632-1-JPEWhacker@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 Sep 2023 09:48:04 -0600
Message-ID: <CAJdd5Ga8MR_7s9s0woxWE3d4wPd5DrhKaPsqM3wfxwkjzfbKYA@mail.gmail.com>
Subject: Re: [OE-core][PATCH] fetch2: git: Use samestat() instead of path for
 repo check
To: openembedded-core@lists.openembedded.org
Cc: mikko.rapeli@linaro.org, martin.jansa@gmail.com, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 15:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15054

Oops sorry I sent this to the wrong mailing list. Should be
bitbake-devel not openembedded-core

Anyway, this should fix your problem Mikko and Martin

On Wed, Sep 13, 2023 at 9:46=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com> =
wrote:
>
> Using path prefixes to check if the git directory is a descendant of the
> clone directory can be easily confused with symlinkes and bind mounts,
> causing directories to be deleted unnecessarily. Instead, use
> os.path.samestat() which is immune to the these sorts of problems. The
> code needs manually check all parent directories until it has recursed
> up to the root to make sure, but in the common case where the
> directories do actually contain the correct git repository, this will
> only run a single iteration.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index e11271b757a..5703ba335e0 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -374,19 +374,25 @@ class Git(FetchMethod):
>                  # Since clones can be bare, use --absolute-git-dir inste=
ad of --show-toplevel
>                  output =3D runfetchcmd("LANG=3DC %s rev-parse --absolute=
-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
>
> -                toplevel =3D os.path.abspath(output.rstrip())
> -                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip('/'=
)
> -                # The top level Git directory must either be the clone d=
irectory
> -                # or a child of the clone directory. Any ancestor direct=
ory of
> -                # the clone directory is not valid as the Git directory =
(and
> -                # probably belongs to some other unrelated repository), =
so a
> -                # clone is required
> -                if os.path.commonprefix([abs_clonedir, toplevel]) !=3D a=
bs_clonedir:
> -                    logger.warning("Top level directory '%s' doesn't mat=
ch expected '%s'. Re-cloning", toplevel, ud.clonedir)
> +                clonedir_stat =3D os.stat(ud.clonedir)
> +                toplevel =3D os.path.abspath(output.rstrip()).rstrip("/"=
)
> +                check_dir =3D toplevel
> +
> +                while check_dir:
> +                    check_stat =3D os.stat(check_dir)
> +                    if os.path.samestat(check_stat, clonedir_stat):
> +                        break
> +                    check_dir =3D os.path.dirname(check_dir).rstrip("/")
> +
> +                if not check_dir:
> +                    logger.warning("Top level directory '%s' is not a de=
scendant of '%s'. Re-cloning", toplevel, ud.clonedir)
>                      needs_clone =3D True
>              except bb.fetch2.FetchError as e:
>                  logger.warning("Unable to get top level for %s (not a gi=
t directory?): %s", ud.clonedir, e)
>                  needs_clone =3D True
> +            except FileNotFoundError as e:
> +                logger.warning("%s", e)
> +                needs_clone =3D True
>
>              if needs_clone:
>                  shutil.rmtree(ud.clonedir)
> --
> 2.34.1
>

