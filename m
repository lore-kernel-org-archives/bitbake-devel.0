Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E91CD98C5
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 11:52:33 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89698.1781351547549932796
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Jun 2026 04:52:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=N35S/fI4;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccea53f35cso22253586d6.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 13 Jun 2026 04:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781351546; cv=none;
        d=google.com; s=arc-20240605;
        b=fcq19fN1OLWXCtbpb7Rxgz5WcFRg8hwURBIUjS+cZWQvyT0PAaTGsLOs9kP1H0oAd8
         2fx3us8JHFpVMBKcPb1vtSHrUbPbJH06HJfmTFFf3oGYGRtIJGzG2mfm/Z2prLRcN/E8
         RmA6uoyprnsFEyplrbjVU+TkDbu8L6uWrVIbYf3cKVlWvleuuAdOQh89+xCHyedQpcIq
         W+b997RGoa4sLqaiW8awFJVudNf4108+DFlTz1otlXScPSK0XMKkYWp7Ug4gqIkNYVH0
         8ARzRrrM2dVsbmLqr1JcvNEnT/stmEGuDKq3H2y2ghxMLmQgSdRtsaxZSR9qaQ6tp9QH
         GEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWHqNFWNWPbESp20tmIm/5swOSmvuoZ6VbXDA325l6Y=;
        fh=WOWCrZxEhHmiJ69XyVWZHmP77adXc+d5cjYrilytvsw=;
        b=k+pyOmpPjYNgywuE69lsRnFlyLhNOOJv5XeDcERWpu0k3tJEjLi9wspD2z0QaFLxDV
         cmQyQqeIqDGw8dyhb2dHh7sCqPh1+oqh8wVXyJMiS+alN+VR0i0gRxNDHLN5+9KiwHcK
         DX9Zfc4hh4RrSSngvdz1uEzxJgDkVz7mb2Uo+DUoJFDPYG9vm+JJtT8JLu0Dt86SveiA
         SFiYRhuk0SA2GUasfANfyzz7pjFFP8Bmo/kvnTL+BtgffNGco4jU1XepUQ02FJyMuUn7
         9faVSu5SB2F+oSVkqUFMHAEjuHNIY4AxVKQ/hr1P8bsq3qHTlLqij9qvosDvL9KTO1uJ
         axqg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781351546; x=1781956346; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWHqNFWNWPbESp20tmIm/5swOSmvuoZ6VbXDA325l6Y=;
        b=N35S/fI4rFlnXKp54ZCVMNbku4elaKGFZa8Do8TqtTWmWfLrN0XxaYWQkjQDhPJWBS
         /hUu4w4XnJxqu75erDi1hv7ySVypOqWxXKQawHob1oTj/NwuQ2U11lmqhGdg6Ig4tvXi
         VUoKSAPld6PB24U+YxJCMi5bx9kj/NO8J6ePW4Ps9g0ft3q5c5W3+0lqTcFdEpDcl1Dy
         idgURaIV9Goa8cMkUJ7s/Scth3UyrXLIOAhhoIeDf50jrWSyOpaWxjvzIba5rX2k6icy
         MOaA5crSTyIfXeyQCC3NtdaZmgT4ij52jrTdZdRkyyb1x4BHHl8EQ9TGoadqciqkDfaG
         TjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781351546; x=1781956346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PWHqNFWNWPbESp20tmIm/5swOSmvuoZ6VbXDA325l6Y=;
        b=chGkyO81wpQ140lJQ4K2Gbk4eGucnqPeDbQYyppt4ukKICoMMr9eHvBdx6k6uC+ptN
         RVv9AIVB8dRsSLEAtaWBTEhu4m2g557RcU3xIak/3KW2GZ3gYJ9RT//siG0Dpjw3oPkQ
         5IyCGNRfwmXszxv3Jkl8nwvYkq9Ux5/h+1RlPfXSRDihR9euZh8S0Deak/2zftpSv7Bc
         MbNbEwbCkdlReU03pJ58Cci01qh9V/6Sz5va6+DSTI1Gl8orL5TKOmxFXGdJ+GBMW7YS
         rk65ZR4OpCRC5EuzuGqELWRjWyCYp4zvIarzUeWnl1aIfP9stiRoQhUjQ/snoYgyEiOt
         J8Tw==
X-Gm-Message-State: AOJu0YwJHYY3lZSDV+X21YSmSr1JlbrQ8QSwQy5WolwtsymOWwnYn7/P
	YqyWGLW/yx8yy1CQUOyER6ojaXVwFUHrWXULOoEkL57kczLbLfySn6lrjcK9JVSKxApAWUcwESv
	bm7qrBqec8oXvWviGrEG/2HPonhRiiKc=
X-Gm-Gg: Acq92OEmygcxRVcYtm4E8b/1cyb0rYnPFP0/EhUdRYSUy3uTYE/TofmIjJNm+Nebcr8
	zOCB3bPTgUmjvGkZtKqToE8EpJiNWCplyDfacCWKuwRekubheUlM6dz8eDN3xCUt9DadX/ReV7X
	SCfyBzr1EGEH66MuWd8WhmScAif6k5g0ZDuPdhFjmf5v2vfHV2F9yKmZ4lDVkPHkF4Exd3897zS
	t7yCjaZiKZow6WLCS33Se9/I3TRK1vC0oIWLMBHyknF/zCoEzmG6TQtL5pjaYkMQYwtdXW26nOT
	IifMoyf+5AHlV2OrTP+fq0/WyxzwRwmiYhUixxSrqQ==
X-Received: by 2002:a05:6214:3d06:b0:8ce:a542:361 with SMTP id
 6a1803df08f44-8d44dcded4dmr67419036d6.13.1781351546438; Sat, 13 Jun 2026
 04:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech> <20260612-landlock-v1-1-77891f63ed7f@est.tech>
In-Reply-To: <20260612-landlock-v1-1-77891f63ed7f@est.tech>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 13 Jun 2026 13:52:15 +0200
X-Gm-Features: AVVi8CcibaZ9r8nYYI1R0cUefi8zC9yogPxIdOJvCd0-mQAClqEUVY-8qs040-M
Message-ID: <CANNYZj_gX=vNggcmyS0CtPoE+dYc0AjOf4=Z0QwcU46-Ccx4EA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH [RFC] 1/2] utils: Add landlock_restrict_network
 function
To: david.nystrom@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Jun 2026 11:52:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19681

On Fri, 12 Jun 2026 at 14:01, David Nystr=C3=B6m via lists.openembedded.org
<david.nystrom=3Dest.tech@lists.openembedded.org> wrote:
> +def landlock_restrict_network():
> +    """Block TCP bind/connect using Landlock LSM (ABI v4+, kernel 6.7+).
> +    Gracefully skipped on older kernels. Stacks with disable_network()."=
""
> +
> +    NR_CREATE =3D 444  # landlock_create_ruleset
> +    NR_SELF   =3D 446  # landlock_restrict_self
> +    NET_TCP   =3D 0x3  # BIND_TCP | CONNECT_TCP
> +
> +    libc =3D ctypes.CDLL('libc.so.6')
> +
> +    abi =3D libc.syscall(NR_CREATE, 0, 0, 1)
> +    if abi < 4:
> +        return False
> +
> +    attr =3D struct.pack("QQ", 0, NET_TCP)
> +    buf =3D ctypes.create_string_buffer(attr)
> +    fd =3D libc.syscall(NR_CREATE, buf, len(attr), 0)
> +    if fd < 0:
> +        return False
> +
> +    libc.prctl(38, 1, 0, 0, 0)  # PR_SET_NO_NEW_PRIVS
> +    r =3D libc.syscall(NR_SELF, fd, 0)
> +    os.close(fd)
> +    return r =3D=3D 0

Far too many magic numbers. I would really want to do this with an API.

This also needs some kind of test, e.g. that the function indeed has
the desired effect.

Alex

