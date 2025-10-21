Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F47CCD1A5
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 19:25:07 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web10.21885.1761074703598644876
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 12:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QR3WdkOL;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: adam.blank.g@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3caae20a290so2090787fac.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761074703; x=1761679503; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9hb8GHiffawYttXTSL9WwSA6MCUJx45FsZz7Rihofc=;
        b=QR3WdkOLLsl000RUlH8/Fp6WkdGTumtipoVlAzx8NMc4cUHsWnaONKYrjzKtczqqCE
         kfvetcqK9hu5hoGVNiNaITeM9uv5xo+LupgYdOsIG8ppHQey602hKCPjoAB7Ad+fdcfB
         Sto7P/vUjnpilgPJ8dAvGDDLA0SN4f58Qa3pfWtwKsrbkzZ3i0ESqUoEPPljNCPohRFg
         sUBbU+GpJyHwPjA/VmWccPA9vZyTTanv9ZoBdvaXLVaEKgu1+yCqB+d8cDJjBx1tl1u+
         jC/AbG8fxvy18d8hYKU/fIMyepSUE+CbTYMdSH4LqoBKbY7wzBhRrqFJfROB5zsv4Qbb
         fPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074703; x=1761679503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9hb8GHiffawYttXTSL9WwSA6MCUJx45FsZz7Rihofc=;
        b=oomzvB5R5N7KVqOW0Q/1QM7HpqsuRsoddaX9j7aufQCLbJTUstUTLfvHwcsEmLkzia
         xRaGYxThId4GaIv4Dsvmr2/9G3qHR5dRKsQo/f0UxIDUVWmtr+aZeRBotlTJN0E6oHCQ
         pXthkPMaLToRB6rSjVD/tDL6WwHHLQx1PmS2lENHsJLo+3oO7JVG2GdnGIYHf05Z6W3I
         41yfnVyclf/b1WwQKwUbBHAC9WE2VKwWjqxmmGQhp1g2EbxlpF3KTM8TlMO70AC8m72l
         U1kzu1KjtdDa/9DK2r7n34ObmvSsPDdZ1/RzZSjmrL0+owsrBVsH1G1HDE5YFEXLMNns
         +FPw==
X-Gm-Message-State: AOJu0Yw2ebef+AnUzcIW5Bs815Lobjw3Pu9wQAuFetbBJLmt+OdoBLqk
	NFtwzMQBW10biQmeYusIur27IdhZvvwMrV+Vhef4Ida6GRyctvkM1MBiFe8R3LLA0LM1N/GgbRM
	5wHvUN8bXvOlIhDsEZ/A8FiJYTZrOmKE=
X-Gm-Gg: ASbGnctRWx2Uv65LjSK4CRKHgk/Sp4MX0HUobkKAu1hW82OBnujN4D3GOR+wVmLFyaM
	AWcYzPV5N4JHXC8YmDHUEy3PWa81yvPadN1/ZnjuGG6nxtgp8/2T659qbLPLdWohPsx6MGCa7RF
	vLCattVsw8X0gPHiIoPHbRl3/kJBZVT3pf6zzDu8OkprqZM0Y42x5CnL19Ao+r4VJtg/LDPOUxg
	KMHYv41Co2ORlIBMBrNY5n2AXku+KzpZwOpjyDY99tUqLKvf0v/b/gAhmMNtifJi1mnBcmrB55g
	PmEQzei5wa6IOBMplUs5HVy9WzEm
X-Google-Smtp-Source: AGHT+IHxjFY+vKB7HbgjWJYWFRhlCwN83FYtJpn+v9jntCO2EuOoX/3Aqp4bE9ifccH6wmTVPvyR9Oi/uDg2uDMWxfg=
X-Received: by 2002:a05:6871:285:b0:370:49f7:afad with SMTP id
 586e51a60fabf-3c98cfce894mr7709010fac.22.1761074702830; Tue, 21 Oct 2025
 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
 <20251021182834.11403-2-adam.blank.g@gmail.com> <CANNYZj89auY9L+aeYNuRpxBqV0kX=3pmDMVx8w8+diAuoQuMMQ@mail.gmail.com>
 <CAFAffzy7rhcF5mxRUhX8kyRz3pezVEA9oSAD5Ukt5ax=ZsL=xA@mail.gmail.com> <CANNYZj9y7VoyCCdz2v6eGyy=bpazPUPRR-eYMGQgs2mkk2GiyQ@mail.gmail.com>
In-Reply-To: <CANNYZj9y7VoyCCdz2v6eGyy=bpazPUPRR-eYMGQgs2mkk2GiyQ@mail.gmail.com>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Tue, 21 Oct 2025 21:24:50 +0200
X-Gm-Features: AS18NWCu99Bj5oQ1MAQy__tzZt2OuxQOFMxGK8_lWkc3nZd1ldCvWhVNoTNF83M
Message-ID: <CAFAffzwKGa=sR56si52bfiODzgZixs5AGCZEtmo_4+jXtxkf3g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] doc: bitbake-user-manual: describe
 UNPACKDIR in fetching
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000015cebf0641b028c5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 19:25:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18204

--00000000000015cebf0641b028c5
Content-Type: text/plain; charset="UTF-8"

Heh :-) Now I would be tempted to change this patch, so that it merely
improves this "non-compliant" example, but I have a gut feeling, that "as
long as nobody complains about it, there's no reason to touch it".

Thanks,
Adam

On Tue, 21 Oct 2025, 21:13 Alexander Kanavin, <alex.kanavin@gmail.com>
wrote:

> On Tue, 21 Oct 2025 at 20:59, Adam Blank <adam.blank.g@gmail.com> wrote:
> > Yes, of course you are right. That being said, I must say it is truly
> difficult to grasp the convention used in Bitbake's manual. One time an
> oe-core class is referenced by name in a note, or an example, the other
> time the same thing is explicitly discouraged :-) One time an abstract, non
> oe-core example is requested, the other time a specific oe-core variable is
> used, while an abstract one would fit just as well.
>
> Yes, the documentation is not perfect. Neverthless, bitbake docs
> should describe only what is implemented in bitbake itself, and strive
> to use abstract examples.
>
> Alex
>

--00000000000015cebf0641b028c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Heh :-) Now I would be tempted to change this patch, so t=
hat it merely improves this &quot;non-compliant&quot; example, but I have a=
 gut feeling, that &quot;as long as nobody complains about it, there&#39;s =
no reason to touch it&quot;.<div dir=3D"auto"><br></div><div dir=3D"auto">T=
hanks,</div><div dir=3D"auto">Adam</div></div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 21 Oc=
t 2025, 21:13 Alexander Kanavin, &lt;<a href=3D"mailto:alex.kanavin@gmail.c=
om">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On Tue, 21 Oct 2025 at 20:59, Adam Blank &lt;<a href=3D"mailto:adam.=
blank.g@gmail.com" target=3D"_blank" rel=3D"noreferrer">adam.blank.g@gmail.=
com</a>&gt; wrote:<br>
&gt; Yes, of course you are right. That being said, I must say it is truly =
difficult to grasp the convention used in Bitbake&#39;s manual. One time an=
 oe-core class is referenced by name in a note, or an example, the other ti=
me the same thing is explicitly discouraged :-) One time an abstract, non o=
e-core example is requested, the other time a specific oe-core variable is =
used, while an abstract one would fit just as well.<br>
<br>
Yes, the documentation is not perfect. Neverthless, bitbake docs<br>
should describe only what is implemented in bitbake itself, and strive<br>
to use abstract examples.<br>
<br>
Alex<br>
</blockquote></div>

--00000000000015cebf0641b028c5--

