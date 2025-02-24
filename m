Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3155C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 12:29:36 +0000 (UTC)
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
 by mx.groups.io with SMTP id smtpd.web10.87470.1740400169015773486
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 04:29:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cI4vhd2Y;
 spf=pass (domain: gmail.com, ip: 209.85.222.67, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-8692998b122so1179526241.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740400168; x=1741004968; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GW5Mb/GcseQaDq3HUNU2yLRFpzh4ZNujfAC8ZovBRe0=;
        b=cI4vhd2YDCxXeE0xSQJnlNURbU73Ebpg/wcFraG9tjxBlin9UqXmKcOThKL4hWNdwK
         u/shWFS10dREla66SdnjHiuvc9yYRRYyuBIKMlFI7ioid7rNjXELwKYBlVugtTcEyytf
         Q3MtFP8VDWAxW1F6DDKzkluzmln/+CStlAviwvNN7MRkBpPT9r25dKRZoubOPFn4gabf
         UXrdoP0kvk8Ms4VYMdbsR8GJrWZ4ZeBUzctm04SQeKb3ZVphClrDITpbyl3vH3Z//i8m
         yqRfZSYBakEuTNEaoTNRRxB12/beOkGX+MBqRrVhAAEhtMzoaRDBu1rnWj9Xdlk2wumo
         zVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400168; x=1741004968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW5Mb/GcseQaDq3HUNU2yLRFpzh4ZNujfAC8ZovBRe0=;
        b=IZnxMfKScf1KGTZHQD+b0VFU0a8lqB4DnxUiJbDtUsnTpZ2Band3eOh/7o+FRcAt4b
         fUuPag/gkSEup8YsbvqiJa8F8hobRvcWud3m4Ah4hD+86mirIWHj7NItrhTM37Ud7piX
         of45knSiKYaA1vJMh3MXmuQa6tnzVNIQ2JoSWroPiSmpBD82vUNuC1AG3tHRjDejtf3+
         s1UKsCBXkbYd29D2V4pwjoshVBGdzFJijcIi8NK+v6Ux/fCkTUxuIZmv4JZQXMcob7fG
         wJ7HeMB4HgFyBx5PosaB67evvBMPvGoB1GNfyh1inqRNvsUZQxrecxwzHKR1Bti2ppIK
         BLVA==
X-Forwarded-Encrypted: i=1; AJvYcCUv3dSRQuFeTjnpWd05l8eQ8B+wOo7Q4rPUL8iFyihBqySO9DUDqMT+wuSELEveN2pSR60Px5b2uP9eLoN2@lists.openembedded.org
X-Gm-Message-State: AOJu0YwWKZLPPQEE0RNp36jiiDzf6D5PfpjjyhNEs6xDWUawGz6OoKQx
	pVwruQme95us6++75Gb1JpJbHkrwgwklPiQQ4rUUrA5x12sLCTxUEC+6xhUNOfxqd8E5aXn/J17
	T4qAWFOs28LL9CcRltXUnZ4aCVyM=
X-Gm-Gg: ASbGncuixM4312axeOVE5cmVVK3zZcn1DU7t+LXjmC592JLL79fRN82OMsXjzsthbPN
	8gtNWzpRyPlGWVKSpwDma8SxY9biBDLG/1eRALd7SfWaGQHZ88ePsEaRVxX4BPDMxh+FsEb9IEU
	+KRVyr79Q=
X-Google-Smtp-Source: AGHT+IGN1dzsT2XCZvkYxNhGnWx9nkBTciVsrbfEJ1LQWvGcJhbsynHo4cWPBN3jnb2w4tJP6FLcTBqEPhjzz0z1SJg=
X-Received: by 2002:a05:6102:4408:b0:4bb:dba6:99cd with SMTP id
 ada2fe7eead31-4bfc27c8d6emr5686909137.8.1740400167930; Mon, 24 Feb 2025
 04:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20250220143030.12982-1-eric.meyers@arthrex.com>
 <20250220143030.12982-2-eric.meyers@arthrex.com> <CANNYZj_d1vuPc9M6+6WBnrQ-RRDRArngsDxSi_8ghjeK=pDO4A@mail.gmail.com>
 <CA+cKJ+Gvb8FjFwTnjT4EFDhU-c-gQYA8G34-wAEmcYMYSyBQMA@mail.gmail.com> <CAB=6tBSOFHMAja1JyhiXW2jMctsLfNFjA_1kXXDe2PTh4a5u5w@mail.gmail.com>
In-Reply-To: <CAB=6tBSOFHMAja1JyhiXW2jMctsLfNFjA_1kXXDe2PTh4a5u5w@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Mon, 24 Feb 2025 06:29:22 -0600
X-Gm-Features: AWEUYZmC8U8XzV7EbzQhDrlwms-vlaEfYmj-RLZEqs3QaBMs7Xw6504jJPNcZbs
Message-ID: <CA+cKJ+FCC4bsam7GpSfOaF-zz=suyzb+No4VxTMwDWFti5hDfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: multipart/alternative; boundary="000000000000c6d4f2062ee27d74"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 12:29:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17293

--000000000000c6d4f2062ee27d74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:08=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.com=
> wrote:

>
> Can we disable this behavior by default and allow it to be enabled in the
> distro
> or local config with a flag?
>

That seems like a reasonable request - although in the past, I've seen some
folks push back on adding variables to bitbake, but in this scenario it
seems like it's the easiest/cleanest approach.


> Correct, it is definitely undesirable. Can you simply grab the credential=
s
> from a
> user's npmrc if they happen to be available? Or does that fall into the
> "easier
> said than done" bucket?
>

After digging into it more, it looks like this is exactly what the netrc
authenticator does in the wget fetcher (i.e. it extracts the credentials
from ~/.netrc):

   - wget fetcher:
   https://github.com/openembedded/bitbake/blob/71fba3b193711104c83c15c961c=
15da346da6d4f/lib/bb/fetch2/wget.py#L399
   - netrc authenticator:
   https://github.com/python/cpython/blob/69426fcee7fcecbe34be66d2c5b58b6d0=
ffe2809/Lib/netrc.py#L70

And while theoretically I can create an extractor that will pull out
various fields from the npmrc file, I think the nature of scoped packages
coupled with variations in how to specify authentication strings in npm
will make this easier said than done.

I will submit a v3 patch within the coming days that adds support for a
bitbake variable (defaults to off and allows the user to turn this
functionality on/off), along with a bb.warn log to let the user know
they're using this functionality. Thanks for the insights Chuck!

-Eric

--000000000000c6d4f2062ee27d74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Feb 20, 2025 at 1:08=E2=80=AFPM Chuck Wolber &lt;<a=
 href=3D"mailto:chuckwolber@gmail.com" target=3D"_blank">chuckwolber@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:monospace"><=
br></div></div><div class=3D"gmail_quote"><div><div style=3D"font-family:mo=
nospace">Can we disable this behavior by default and allow it to be enabled=
 in the distro</div><div style=3D"font-family:monospace">or local config wi=
th a flag?</div></div></div></div></blockquote><div><br></div><div>That see=
ms like a reasonable request - although in the past, I&#39;ve seen some fol=
ks push back on adding variables to bitbake, but in this scenario it seems =
like it&#39;s the easiest/cleanest approach.=C2=A0</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_quote"><div><div style=3D"font-family:monospace">Correct, it is d=
efinitely undesirable. Can you simply grab the credentials from a</div><div=
 style=3D"font-family:monospace">user&#39;s npmrc if they happen to be avai=
lable? Or does that fall into the &quot;easier</div><div style=3D"font-fami=
ly:monospace">said than done&quot; bucket?</div></div></div></div></blockqu=
ote><div><br></div><div>After digging into it more, it looks like this is e=
xactly what the netrc authenticator does in the wget fetcher (i.e. it extra=
cts the credentials from ~/.netrc):</div><div><ul><li>wget fetcher: <a href=
=3D"https://github.com/openembedded/bitbake/blob/71fba3b193711104c83c15c961=
c15da346da6d4f/lib/bb/fetch2/wget.py#L399" target=3D"_blank">https://github=
.com/openembedded/bitbake/blob/71fba3b193711104c83c15c961c15da346da6d4f/lib=
/bb/fetch2/wget.py#L399</a></li><li>netrc authenticator:=C2=A0<a href=3D"ht=
tps://github.com/python/cpython/blob/69426fcee7fcecbe34be66d2c5b58b6d0ffe28=
09/Lib/netrc.py#L70" target=3D"_blank">https://github.com/python/cpython/bl=
ob/69426fcee7fcecbe34be66d2c5b58b6d0ffe2809/Lib/netrc.py#L70</a></li></ul><=
/div><div>And while theoretically I can create an extractor that will pull =
out various fields from the npmrc file, I think the nature of scoped packag=
es coupled with variations in how to specify authentication strings in npm =
will make this easier said than done.=C2=A0</div><div><br></div><div>I will=
 submit a v3 patch within the coming days that adds support for a bitbake v=
ariable (defaults to off and allows the user to turn this functionality on/=
off), along with a bb.warn log to let the user know they&#39;re using this =
functionality. Thanks for the insights Chuck!</div><div><br></div><div>-Eri=
c</div><div>=C2=A0</div></div></div></div></div>
</div>

--000000000000c6d4f2062ee27d74--

