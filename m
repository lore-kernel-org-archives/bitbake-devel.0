Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DACAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 21:50:55 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.web10.377.1759441853402570189
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 14:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bULPhFTZ;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-633b87e7b9fso1534051d50.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441852; x=1760046652; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU2NTKhkmmb5K8MFXNlXBmlzBh1+1WP4qTgUf+8t8Is=;
        b=bULPhFTZEPZv4ILLxzl1NKLGH5zBYvDkNEeS4MqSCxlN/j3Y+WqkigS8aaGF7ZQFIw
         +gXxQyyhpoRXNhfHkSjYqVAaL5CeWbAsplD7S5IL8kU2j4tLycGOLUdw9JS7Rii2GrBA
         Zty2uFf4cRlpmclNs1bOIS8dC5OPxM80CxP/LwbZotRtRhbihbLGBDhuEz+nodh8HIei
         ezLiV6Zme14GdXzaztMM6YYIxnaGmAinxSnVHFMrJWfK+cz0jgxS3m9AJcKWqSvTrIIQ
         Y6MbhIfRHjNWFPlszWsU4cciAcYcPrqmrOtAm//ylzm2mznr6JlQMh11Ixj1q8fghT/K
         XJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441852; x=1760046652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU2NTKhkmmb5K8MFXNlXBmlzBh1+1WP4qTgUf+8t8Is=;
        b=rTrzKPz8iuBSHLldW2DjMGJBJEIADoLfGs+k4Z0H+hO23M8yB86pL+zePycJh4x+eq
         OP59o9F8IGbCkPNdcyrO2VoSZ6UL3gq81+siTC8vHnZS64S+ja7XVlmPT8D+3zjJdP9o
         d8teHmTtSX96p0NjuO1yaL1rRAlK4/ArsnZbTekN1PVncaP+iFYpzHUNBIAUNVOG/cbB
         P8eDtYp18dufDB7i6aXT7XbkzyBvtdaQkFLQd4MqitPyQ7OUTRuzVTkSmjkyGszyqbSa
         7RGqEn3PEAYyGXB/1bqnrVi8CM0Abs4M8j1tIghQicBFKbWMKSl1dELtlpfPkLfxEPW1
         CBVg==
X-Forwarded-Encrypted: i=1; AJvYcCUr1Raawyicl/JVXpw+15Zi4gfT8Z+Kl5HyD6hGu8NhW1neUqvTfYI58BSfThE9+F/tMa+H2pSmUPry4csl@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw6vlSQIgIoM+5gE1pfmLdxaaotg1K7gnVXDR9+vuMJvnnSVbNs
	Qi662ytyOgGLi5HwBYQcGRAtYrgQ1J64ZMghcADgtdBuilCsZT6atJmz2klWScR8Fj4Oh/2ViFc
	V1yzXm+Jt9TcNMkxzRSUZKEVkT72YiM0=
X-Gm-Gg: ASbGncuhMMYaqU0s9CMEm8BBH6GrvIYRDrGCJ4YqN2yxoeg13Tjy6aj5l1nG9RpXZQR
	xl1aFxYdR4cYlzokCjIeqdoxikvow5U9WUt6q+g15CXugerjixDNNWXkk7XlVxrt4nykpZF+HCT
	NPcvq1pLQK7ms52Odmd82D2tYHfJVlLF9j/97mN/qdVLbleecRW9/aQFepfzIBJ7gYzb1FvZhWh
	qdbkEYCZ80kxz9Bk/Sjw/DXT2HEqRt5gD2FdbTFF6276Q==
X-Google-Smtp-Source: AGHT+IF9ObpvXLfa1hOpU9yHpkhF2zsViTw/02ZCEQHYrEZKwW3rsDi4PEHSe2fXrvkdxOVZ2zbvEsNe8wbTVNvuncg=
X-Received: by 2002:a53:ea44:0:b0:631:559c:7426 with SMTP id
 956f58d0204a3-63b9a08346dmr701140d50.13.1759441852466; Thu, 02 Oct 2025
 14:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr>
 <CANNYZj8RicOLzYbtQ6anggqiMkQMDJ=REBztppNa3CP6dLOkcw@mail.gmail.com> <CAMSfU+52JC1=3q=G=eEjoh4rGtAKJO590tOYw8sLEgpqUOMRTw@mail.gmail.com>
In-Reply-To: <CAMSfU+52JC1=3q=G=eEjoh4rGtAKJO590tOYw8sLEgpqUOMRTw@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 2 Oct 2025 15:50:40 -0600
X-Gm-Features: AS18NWChWU19ViVnHc5e7HkPJZegk_H67poc9AvCWthxMG6TdGYyWsadpoxLQuA
Message-ID: <CAJdd5GZ1gLhJYx5GQ7tY8UTv4L9y5Gj_Fjco6EjSJ-Dw4ZWAYg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
To: yoann.congal@smile.fr
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 21:50:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18127

On Thu, Oct 2, 2025 at 3:06=E2=80=AFPM Yoann Congal via lists.openembedded.=
org
<yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
>
>
>
> Le jeu. 2 oct. 2025 =C3=A0 18:22, Alexander Kanavin <alex.kanavin@gmail.c=
om> a =C3=A9crit :
>>
>> On Thu, 2 Oct 2025 at 17:52, Yoann Congal via lists.openembedded.org
>> <yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
>>
>> > +                        ],
>> > +                    },
>> > +                },
>> > +            },
>> > +        ],
>> > +    },
>>
>> I don't know Yoann, these still need to be perfectly balanced and
>> they're still visual clutter (admittedly not as bad as xml was), which
>> is what yaml frees one from.
>
>
> Yes, I agree with you on JSON visual clutter.
>
> I pushed JSON5 to not stray too far from the python-stdlib-supported defa=
ult JSON.
>
> But, thinking about it, we could use the "install an extra module to read=
 better but incompatible config format" idea to switch to YAML. Should I se=
nd another RFC patch to see what that looks like?

If we are going with external dependencies, YAML makes more sense
IMHO. YAML is a strict superset of JSON, so if you use a YAML parser
it can parse either YAML or JSON documents, so all the existing
documents would also parse just fine.

That said, if the point is to make things interchangeable, it might be
annoying to have some documents in YAML and some in JSON, so I'm not
convinced this is a good idea on the face of it.

>
> Another idea I heard was to support a plugin mechanism in bb-setup to let=
 everyone implement their own format but that sounds like a maintenance nig=
htmare.
>
>>
>> What's the particular need for comments? You said someone else wanted
>> them, what did they say?
>
>
> They said nothing in particular but here is how I would use them (same ne=
ed as comment in code) :
> * provide documentation (in the case the "description" field is not enoug=
h),
> * giving the intent of the author,
> * // TODO: ...,
> * "temporarily" commented code blocks,
> * a licence for the file,
> * a small tutorial on how to use the config (should be in the README next=
 to it though)
>
>>
>>
>> Alex
>
>
>
> --
> Yoann Congal
> Smile ECS
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18126): https://lists.openembedded.org/g/bitbake-deve=
l/message/18126
> Mute This Topic: https://lists.openembedded.org/mt/115555001/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

