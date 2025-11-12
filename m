Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7887CD3429
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 17:23:49 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2922.1762968221057769764
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 09:23:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i7oBSXqL;
 spf=pass (domain: gmail.com, ip: 209.85.128.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787da30c50fso10966577b3.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762968220; x=1763573020; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVI2oMU270PzPwMz8Hu1ngko8sCFv5dcVyye88Lblyk=;
        b=i7oBSXqL6fbSO5+2/IgAw9rXjv3jKdtp1+rdYVKRWKyfDWt1At+DiKJGe84Fw5VkRN
         hr0TE0wDKPLsZiFiKjrWTcZ6G/RzjhVsTvvkDpbxbX2OsFkv82+zfXGjeRcUcNuTmLpM
         2Hlo1mbXg7kY2XYmyv5GWJ1I/TQy24hPZf+9bMV3F9f7CxXDHk6Xc751Y6ta/oyeWuV6
         bLEK5a8aNzdQxhu2CIJbLOFux3/TpkNNMt391IRPCQ8WI2fT16qxdhFhvYdOoMXYpf9M
         43jw+G7vSorrQxTh9QCMVX5lF/a5nL3PNTOXvysNoLqpdskTYKvsDNlA6lEYYJaT9ST+
         3I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968220; x=1763573020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVI2oMU270PzPwMz8Hu1ngko8sCFv5dcVyye88Lblyk=;
        b=sN6ThdhgWJDG+9NFcOUnDdNTNRmOkmQVt3HIdCcOvBDtj+u6op3w7jW4kVQSpVkc8e
         TmWve5v4oYQCy4HV4VuHqZXrv2qoK3do+IPVAKzMSPgkzdtWfAWUWIt8Wjr1NxIBNiiS
         nH0XFqULH/B2ibw0Dyw15eKFyG4JAcxIEMOQ5eS4si8vFy9wp0Rzz5aWZdUtezuZly3n
         hxbJAVscmL9tH+wHzxig1hDAnV3zYwxL289X8s7n8oDqn6K+TOhcieOWreOjtvusxxVV
         JjxSPwyaP6KJvDCJN9+Eh61veMlqFjzGKCplq3pCvBtvcZ0dB7YZNPuBAwWU3tSYARH8
         aMCQ==
X-Gm-Message-State: AOJu0Yy1juHcdZeA7Iyl79jcUiDZ/Z2F0EiDaq9dX4df3frJfzzsgES8
	dfIuS2MEEnEmDQ9WJOC5bqzV73ayhSBp+9xobtSF/jHYk17LbB4tHKmMg2a7l6RHoLZAqcOXwPA
	9ttallXtnSWAfCPdXb9/yXmX2x0GPR6M=
X-Gm-Gg: ASbGncsXW+KJq2XKst7wlgoHBKoLtvBr1Lnk9xIuNrXp2YgYfPATf0vKaS0fi/9TmYP
	tL06kj/1vMIiP9GVsDxQrUyA3KBZcM12oMuhYj+OPMki6+FIMV7k0Cqi/1mHdUW2aXdWexpI5Ql
	Tkj2RC92ATMca1cpi22hUzpvduF+Ez/G3uO5ar2Ds4Es8rFISUN68tOj32UxAaKACxUI1fZAemz
	Wd5iU3F+12xjbWl0Gynk9gUOfSkk1+xwa3UaLup/Yu5ODU1CT1gCRGKnHjU7Mwos6VcIW5X+ko=
X-Google-Smtp-Source: AGHT+IHeplks35B+yHcSzhR+4jIrDYv9ZWHIPTfBhXP8Xdj+qt/F7xR+YX9FFV41hi4lbBU9P2uKmn5gLeiVAIa/oVE=
X-Received: by 2002:a05:690c:c92:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-7881360a2c3mr57122987b3.17.1762968220090; Wed, 12 Nov 2025
 09:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20251112154121.3750738-1-JPEWhacker@gmail.com> <CANNYZj_4xCdBiMmEpfsW9myGA1G3ZMa2iC2B1rM01nv2mkQvXQ@mail.gmail.com>
In-Reply-To: <CANNYZj_4xCdBiMmEpfsW9myGA1G3ZMa2iC2B1rM01nv2mkQvXQ@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 12 Nov 2025 10:23:27 -0700
X-Gm-Features: AWmQ_bkUBmvQReJ_3xNvYn3fTgDuyHMZXU3vqTez0M6tYl-Zt4d-E4rymEueleg
Message-ID: <CAJdd5GYPk7qhjEgFNWT=6XoNb-7tkDALk7jtCwOUY-H9FN6Zvg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-setup: Set DL_DIR and
 SSTATE_DIR in default site.conf
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 17:23:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18361

On Wed, Nov 12, 2025 at 9:18=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Wed, 12 Nov 2025 at 16:41, Joshua Watt via lists.openembedded.org
> <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> > +                    DL_DIR =3D "{dl_dir}"
>
> This I agree with.
>
> > +                    SSTATE_DIR =3D "{top_dir}/sstate"
>
> This needs further discussion and should be taken out of this patch
> and added separately. Particularly:
>
> - it should be a setting like dl-dir, and not hardcoded to top_dir/sstate=
.
>
> - if it is shared in this way, shouldn't we also figure out how to
> share the hashequiv server? Right now each build will start their own
> private server, which will use their own private database, which will
> lead to baffling lack of sstate reuse, despite builds sharing the
> sstate dir.

Right that was the intention. I think it probably makes sense to do
both SSTATE_DIR and hash equivalence together in a separate patch
though. I'll send a V2

>
> Alex

