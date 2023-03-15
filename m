Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D5AC6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 19:00:36 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.2139.1678906829409831755
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 12:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SGehN7mN;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id r27so25527137lfe.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678906827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8CAhyffd+l8/rFvPSjCdO4c/ymZWNfWSlOFbPyqCSTg=;
        b=SGehN7mNVLQQfjYVtIdaxU/akDyZVqoafub+fnzIm7d948NMbmGKUXzGO/k+I33Esl
         xNmyJwF9wvChHvRITWTK2m6U5Fu7PHfA61P9Be+fB3wIadAU2UKgSXdxYBF5+gLqCPes
         q/sW7KObAxVzt35Z8LSTpsfbSKUpO9jdUGnyGLoIKgKAlLHv6pFoDZknCwTt6o5ZYYKU
         dLUGyyGWLRY9oGll5txYiW6uUoEL+x0Yu466KLQRPZ2lMZZvnZGkDOez/vmlaFuwGEBD
         JGUHIDnfLdtEUg9K7MK+iwWBkaKbL2J98BiaeZejBK/rJ6tHAu3jli9BHB8wVImkPtO4
         8i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CAhyffd+l8/rFvPSjCdO4c/ymZWNfWSlOFbPyqCSTg=;
        b=pTiLGuebDZLQ0Zw8kzEufD56chrR8HuP115a/I1ez36nHAm8X/mXadWHc1nbdLUJjL
         4/jYhqlWJncHaPPpjT3rQxrqcUe+q9KOlUmpnyRO2duG6wMmwCSNKTMoyVYbaOo+W3Ll
         dIuauQUuE4yzoXR3ghfIjxgovI1fDiv8RyRNOamHcmKaElLsGZbj6BhcnNrHu+Sja1IQ
         HsKqodHfzBx7vTxrbebCvMJxOAwVoe1G0C4Ps61TIFUkL0ome69gJ+6qXhRW0ejcaD3B
         eZ3CfMcxdKTu7SA39b+A/wHHXgFKCX3+JjHCVIPUIXTsqQjNTeS3jtEp2TPPbbJXQQW1
         6a5A==
X-Gm-Message-State: AO0yUKVnKvKb0XqKMruPJVX0r2MUgRSJkjuQ1hhLL9/QAvXZafmHpYNL
	HozBUJMusB8+SXlLd72HLOCHtha94QB46Y1tWZk=
X-Google-Smtp-Source: AK7set87IrNeZtWYnqnHHreMT1+yArG3vSlW6y8PXvxnthnnhmUPdO6zLgLERhFbc8x88RUMA4DCuTABWzjLEKVE2a0=
X-Received: by 2002:ac2:43d4:0:b0:4e0:822f:9500 with SMTP id
 u20-20020ac243d4000000b004e0822f9500mr2326124lfl.12.1678906827462; Wed, 15
 Mar 2023 12:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
 <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
 <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com>
 <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com> <CANNYZj9msRQ5MnC9wHtD0w9zscDXeq2+dxt8fwzZzNnAcPquWg@mail.gmail.com>
In-Reply-To: <CANNYZj9msRQ5MnC9wHtD0w9zscDXeq2+dxt8fwzZzNnAcPquWg@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 15 Mar 2023 20:00:15 +0100
Message-ID: <CA+cAkeoSQSPCyfQBrUcky0Og+SsqWDQiquV4YqspgqotVJV23A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000fdbd105f6f4f548"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 19:00:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14575

--0000000000000fdbd105f6f4f548
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok great, I have everything I need go further on this. Thank you all

Le mer. 15 mars 2023, 19:47, Alexander Kanavin <alex.kanavin@gmail.com> a
=C3=A9crit :

> On Wed, 15 Mar 2023 at 19:26, Fr=C3=A9d=C3=A9ric Martinsons
> <frederic.martinsons@gmail.com> wrote:
> > But I still need some answers to go further:
> >     - Should checksum verification for crate fetcher be mandatory ?
>
> Yes.
>
> >     - What about librsvg ? It doesn't include any crate:// but needs to
> inherit cargo_common, what should I do for this recipe ?
>
> I think this was mentioned by mistake. You might want to check if
> meta-oe recipes would need fixing though.
>
> Alex
>

--0000000000000fdbd105f6f4f548
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ok great, I have everything I need go further on this. Th=
ank you all=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le mer. 15 mars 2023, 19:47, Alexander Kanavin &lt;<a href=
=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank" rel=3D"noreferrer">ale=
x.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Wed, 15 Mar 2023 at 19:26, Fr=C3=A9d=C3=A9ric Martinsons<b=
r>
&lt;<a href=3D"mailto:frederic.martinsons@gmail.com" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt; wrote:<br>
&gt; But I still need some answers to go further:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Should checksum verification for crate fetcher be=
 mandatory ?<br>
<br>
Yes.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0- What about librsvg ? It doesn&#39;t include any c=
rate:// but needs to inherit cargo_common, what should I do for this recipe=
 ?<br>
<br>
I think this was mentioned by mistake. You might want to check if<br>
meta-oe recipes would need fixing though.<br>
<br>
Alex<br>
</blockquote></div>

--0000000000000fdbd105f6f4f548--

