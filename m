Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FEC05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 14:49:35 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.8693.1676386173542438353
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 06:49:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=lhdLiATZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.42, mailfrom: steve@sakoman.com)
Received: by mail-ed1-f42.google.com with SMTP id c1so13951940edt.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Uu3OiqY7oLSwcpB4p6Urelc/fkhlKw3ODxlKAATHf4=;
        b=lhdLiATZvSu5NZjLLPISXldbJNdLqAimLQ5SmPgFnn7XwQYJXO54JGRrzs8e8BpCHn
         uuKvepvJYZWrQAL3hbYJRhZISMNN6mWDNEatHOZDlD5FTTga5Xk3rgP8nrUInc6/Jobb
         hbDXixQqnGMQS7Fb8YSC2VJbqPPWLlnUP1QuG3q18A8q8xNg4UGIwfC/LXEdPmJ3Vj82
         KT95K5LyGwQERr+DugLVqlNLbCJDOPXOZ3cVGGAb2vrhGOQGdAdTri0FhcGgPhuJ4Zep
         x2rVos+nOa5a5H9qK8zFg4Pg4U1e0pIfbLxNNUQduqjLcdLYcIuFHCaeeGAzdIc6OsES
         FqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Uu3OiqY7oLSwcpB4p6Urelc/fkhlKw3ODxlKAATHf4=;
        b=A18Ns+2u1uSwvk8o5llJmb0Cwuh0aKaafdNPCxD1aIN357vK8gMsAop8eN8x7timZa
         fmLwhHpWRS3Qb6gzarZvil04AlNwHtLaTKgUd4xkJK2f+VMGNqAb6lU4TwezPk5913qY
         VEPozUJmOEoni29qS1zbc0PrP2bUC0synApHRXGBU6BBeU2vGjJFlLukGc/pgnBRPmQS
         EipEwrey5QOT1vdhyxJf03sUH9Bnos1l4+RAM1phN+Ct1BGnnV2Yjw2g1hUIp65+VhLJ
         RL2r8w8LkiQ+vSGiEV2qY4JI8Ijdny0lkeW3D+N+Damy2zyuDvCKytCGmRrvdtsRYpYm
         iUoA==
X-Gm-Message-State: AO0yUKXbcF20/gkF3BTaVNV2qXgV7FtnYmLmsdVI0YYYvX+Q1nXfe9cd
	Hqd8xmZJMmKQUp3Jq+LFJFRey+MBhZRlIuNzVesZJA==
X-Google-Smtp-Source: AK7set+GF+adQjlKG8N5VIcfG9iLPyymNrKbXu+q+F96uAjLG1GX/PERsU+nQJbhZTGrU03tAHkiHIe2iCA4zbOiBUU=
X-Received: by 2002:a50:bb66:0:b0:4ab:4dc7:574b with SMTP id
 y93-20020a50bb66000000b004ab4dc7574bmr1326896ede.3.1676386171889; Tue, 14 Feb
 2023 06:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20230214103441.1516378-1-ecordonnier@snap.com>
In-Reply-To: <20230214103441.1516378-1-ecordonnier@snap.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Tue, 14 Feb 2023 04:49:21 -1000
Message-ID: <CAOSpxdb0XrPv7+EesLAM7OxexBaa7j9ZXZBJaY4M3Gav-z-Syw@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] siggen: fix inefficient
 string concatenation
To: ecordonnier@snap.com
Cc: bitbake-devel@lists.openembedded.org, JJ Robertson <jrobertson@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 14:49:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14410

I finished autobuilder testing this patch on both langdale and
kirkstone - will send the review email out later today.

Steve

On Tue, Feb 14, 2023 at 12:35 AM ecordonnier via
lists.openembedded.org <ecordonnier=3Dsnap.com@lists.openembedded.org>
wrote:
>
> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> As discussed in https://stackoverflow.com/a/4435752/1710392 , CPython
> has an optimization for statements in the form "a =3D a + b" or "a +=3D b=
".
> It seems that this line does not get optimized, because it has a form a =
=3D a + b + c:
> data =3D data + "./" + f.split("/./")[1]
>
> For that reason, it does a copy of data for each iteration, potentially c=
opying megabytes
> of data for each iteration.
>
> Changing this line causes SignatureGeneratorBasic::get_taskhash to take 0=
.06 seconds
> instead of 45 seconds on my test setup where SRC_URI points to a big dire=
ctory.
>
> Note that PEP8 recommends explicitely not to use this optimization which =
is specific to CPython:
> "do not rely on CPython=E2=80=99s efficient implementation of in-place st=
ring concatenation for statements in the form a +=3D b or a =3D a + b"
>
> However, the PEP8 recommended form using "join()" also does not avoid the=
 copy and takes 45 seconds in my test setup:
> data =3D ''.join((data, "./", f.split("/./")[1]))
>
> I have changed the other lines to also use +=3D for consistency only, how=
ever those were in the form a =3D a + b
> and were optimized already.
>
> Co-authored-by: JJ Robertson <jrobertson@snap.com>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  lib/bb/siggen.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 130b38d8..2381edd2 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
>
>          data =3D self.basehash[tid]
>          for dep in self.runtaskdeps[tid]:
> -            data =3D data + self.get_unihash(dep)
> +            data +=3D self.get_unihash(dep)
>
>          for (f, cs) in self.file_checksum_values[tid]:
>              if cs:
>                  if "/./" in f:
> -                    data =3D data + "./" + f.split("/./")[1]
> -                data =3D data + cs
> +                    data +=3D "./" + f.split("/./")[1]
> +                data +=3D cs
>
>          if tid in self.taints:
>              if self.taints[tid].startswith("nostamp:"):
> -                data =3D data + self.taints[tid][8:]
> +                data +=3D self.taints[tid][8:]
>              else:
> -                data =3D data + self.taints[tid]
> +                data +=3D self.taints[tid]
>
>          h =3D hashlib.sha256(data.encode("utf-8")).hexdigest()
>          self.taskhash[tid] =3D h
> --
> 2.36.1.vfs.0.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14404): https://lists.openembedded.org/g/bitbake-deve=
l/message/14404
> Mute This Topic: https://lists.openembedded.org/mt/96957072/3620601
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [steve@=
sakoman.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

