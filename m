Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB2C02195
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 15:33:20 +0000 (UTC)
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
 by mx.groups.io with SMTP id smtpd.web11.90355.1738596792850259172
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 07:33:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l40zylB6;
 spf=pass (domain: gmail.com, ip: 209.85.222.193, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7be3d681e74so403138285a.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738596792; x=1739201592; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iukdKtxSGicJYq8FBavke8aIOhb0V3z3Zy5jquFzzPk=;
        b=l40zylB6P2rorxaNdcri0gyJhm5g65RJE02lMRbCzVBW0hT7vKpQTPfKJ6KuG/8rJ3
         E1X5uxtn3vw7a4WN67S7VTbYZ7dn7NytYYJM/tJKNvV2ERngINVahAADIDFNG0AJ9bXT
         nW1aNcaATHtihMjEq5vf72tHKQgKrgdPlB9NnoHE2YOAVGtJQGOkWSjSQxBXCRycv3s7
         hyvpQWrP2o1iv1tiaS/xtBdNRqiNC1k3N12zuVMVJEbAIOxVj1d4E8m5WqMgRUpgHezM
         rcWpbbppOw/Z1l19RrLQB1bN/2wMxPdAjC7e49BN6VaUkQg4/Cf5AhyuBJzVYTL4FYWP
         KABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596792; x=1739201592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iukdKtxSGicJYq8FBavke8aIOhb0V3z3Zy5jquFzzPk=;
        b=SowCzulEk1MwTjRjGBD5RoZz100mFrXatJVVoYRnxxZPUVPZh2P7K8C1wKtoBkLPUy
         tEZ/G5XGOSofAKqB+R1F9UvfRg9S4E3NBty+TJWxrKvfIglsRLIABomgIDVhu7YjWpXK
         SPWZIf733WrKPNC+MtAiVIbgRRzeuVST1tEcUp8C4sxG7Vjb/y2oWKU5EhKV3v5AQIOl
         Qxb919E5L/BP60tT17ZmqbNfCeuspOGi9y0AJoYm3W8dIB61Y1mYkkfxwGbGGXslYon6
         lzkrCivEnGeVX5DO4XJGKJARZ5nI4vXqqJeIbjaimucYq8Us0+dthukGW+H10fowANFF
         rmFw==
X-Forwarded-Encrypted: i=1; AJvYcCXptRPjkBQz/H3/U8ldUe8F7886Mf3TMcX2DrEw8V8XUi7e+bHQiChgsE4zVt+Sc55+zDy+dyRP4qgGHAm7@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx2tsRedBJUkJ2xb6tApeXomeMZfxUOrWR8Y1H3w3Ml3u1OilYQ
	sd6HrTSaqc6TMDPpG/OCW1Rrr8i0qMH3WB3oeC1Bljxm75m5VXYdRCIrFh4yn/x9Z0+ZW8PbmKr
	/W6xAJFimJxqsHjKqdBK/lOtmhlQ=
X-Gm-Gg: ASbGncubbseXJsJ0SVFQY0VKNZYCpMcCzWcxKUW8iwak6MUD72dPFMmoZuwQhx/wXXm
	oVTp+zAWgYLa3P55ou1OP/E8GorFq9BQyx+OaO6E+3Lg2qCHsCJym/3j2Uj8T7u3bVP/9XWYv
X-Google-Smtp-Source: AGHT+IEHVr2Hy8d/lRRDACX1ZLe9OgYo7fJPS1MRkDiqBcO6pHDrNOy3KVj+25yStJC6pIHxgR4N2G0R5X/N6QPiNA0=
X-Received: by 2002:a05:620a:191c:b0:7be:82e5:5693 with SMTP id
 af79cd13be357-7bffcce96bemr2912242485a.20.1738596791841; Mon, 03 Feb 2025
 07:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20250127142918.163-1-eric.meyers@arthrex.com> <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
 <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
 <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com> <CAB=6tBR1y2Xzpy0MK1uW2TLV7O1opcW_UP_LGd-t=yYg+SAL2Q@mail.gmail.com>
In-Reply-To: <CAB=6tBR1y2Xzpy0MK1uW2TLV7O1opcW_UP_LGd-t=yYg+SAL2Q@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Mon, 3 Feb 2025 09:33:02 -0600
X-Gm-Features: AWEUYZmAhokFOkEPRjqfUbojQuZKaSVCTP27OKVuSuJfa8nHC7abVpJOs6iHgcY
Message-ID: <CA+cKJ+HRxtWLSehYjUc6rLS18xxp2C_kvq8Tx_vJ_FvuxdTPXw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org, 
	"eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 15:33:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17122

On Mon, Jan 27, 2025 at 3:06=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.com=
> wrote:
>
>
>
> On Mon, Jan 27, 2025 at 10:01=E2=80=AFAM Alexander Kanavin via lists.open=
embedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
>>
>> On Mon, 27 Jan 2025 at 16:44, Eric Meyers <eric.meyers15310@gmail.com> w=
rote:
>> > Are you suggesting that instead of username=3D and password=3D paramet=
ers
>> > in the npm/npmsw SRC_URI, it should be an "npmrc" parameter that
>> > effectively the user can point to the location of their .npmrc file
>> > for authentication on an NPM registry? Then, within a user's
>> > associated recipe, they would need to create the npmrc file in a
>> > do_fetch:prepend() step that that corresponds to the path passed into
>> > the SRC_URI?
>>
>> The only acceptable solution would be one that takes passwords written
>> in plain text out of layers and local.conf altogether. And the way to
>> do it is to write these things into ~/.npmrc and ~/.netrc in a secure
>> manner (e.g. pass in to users via encrypted email with instructions
>> that the file must not be readable by anyone but the user), and ensure
>> that npm and wget are able to pick them up from those files (wget does
>> this already, npm I'm not sure).
>
>
> Could this also be solved by letting the end user decide, sort of like th=
e way FETCHCMD_*
> works?
>
> A CREDENTIALCMD_npm variable in local.conf could be saddled with exportin=
g the
> namespace, password, and username values into whatever environment needs =
them in a
> "Just in Time" fashion to lower (but not completely eliminate) exposure.
>
> An identity agent, like the 1P or vault CLI would be an obvious choice he=
re, but one could
> just as easily tie it to a script that devolves down to looking in ~/.npm=
rc if they wanted to.
>
> ..Ch:W..
>
> --
> "Perfection must be reached by degrees; she requires the slow hand of tim=
e." - Voltaire

Last week I had off, so I'm just getting around to addressing these
comments this week. Chuck's suggestion is interesting and I will
definitely consider it. So this amounts to two potential paths forward
for this issue (1 by Alex and 1 by Chuck):

1. Take a similar approach to how the wget fetcher uses default netrc
credentials within the user's home directory and use default
credentials populated by the user within an npmrc file in their home
directory.
    - Pros: Moves away from specifying username/password in recipe,
using precedent set in wget fetcher, potentially less changes in
fetcher (no parameter additions, no creation of npmrc file, etc)
    - Cons: Currently, the wget fetcher relies on default behavior of
"netrc" python library - there is no analogous "npmrc" python library
and we would need to add logic to check this file manually (shouldn't
be too difficult but still would need to rework current NPM
environment behavior in the fetcher). Might pose challenges in CI/CD
environments where these files need to now be created if using private
registries (again should be easy enough).

2. Take a similar approach to how FETCHCMD_npm is used and specify
another variable named "FETCHCREDENTIALCMD_npm" that allows the user
to point to a specific npmrc file to use in their environment.
    - Pros: Moves away from specifying username/password in recipe
    - Cons: Adding another variable to bitbake, lowers (but doesn't
completely eliminate) credential exposure, might require more support
within recipetool within poky

I am going to take a stab at reworking this patch to match approach #1
outlined above, but if any hiccups come up, I'll post issues here and
re-evaluate using another approach (potentially #2 above). #1 feels
like it will be easier to implement and more straightforward than #2,
but perhaps I'm missing something.

