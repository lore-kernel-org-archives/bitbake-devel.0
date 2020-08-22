Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.147748.1598058732332771417
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 18:12:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=fbm7C+2e;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id i20so2990499qkk.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q2I3sVw02CjeAtqW7FIu8jUqZ9pPYoEgkczRBlCkqFc=;
        b=fbm7C+2eq02oZv5DtE764D4ljeGoFr85cjBzKkFElNHY2OoiSRZGoQa1JEiW0VSUPw
         /xFhDU3DN95rud8ZbKXYuDLugc9rV0OMsRUYVZnOYHys3K84LuPpJxKTynL2YYlXXETO
         ePWHFxmm4ACN5EERJhGoCTbZmBEonF+lslRePQ8mYPPgvUE0PKOgTLtXXjV7iS7fYk5J
         JiMBX4RwsaFkGX3FtNEor25VHabsU/U8ojH1zBx9hHDpz9QxMjzAt5i86Eama1RBU9a4
         HNq5eCjAtKxmDZYVgty+zdv9VfaQZHWs7AUlX/BRVjRxDDJTw/7ZdiISgS3v4wezNcvx
         u1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q2I3sVw02CjeAtqW7FIu8jUqZ9pPYoEgkczRBlCkqFc=;
        b=kgRyWbdmLQkniYs2WqkRLpJM3Euu+4zHV9yy4Njz8CjqyKhXe/9LYCaR08X5x3x/6e
         6Zg9JMF/CLxT6/thUBo8tCdan9kBKcLDjhLucNz/c++7xU54KGt2pPtfT3Rqqpo+hq7V
         QR31lvRsyg228v+Yz3XfIUkprcSbWma3vKixSC8ZNxMG0ysM8FxCQ4sLK5BJobs3YIlf
         fH7hKz+4MUSO/rtZuUrAchEnAQtlnpe6axTFQfwJ5a2AqgaZ5k9k72b5cIg9vd8jka6B
         s84IJbERiCuR8rQd8wdzIDxOLGjadcQkIGu3upF60/SkB9OokWzwKSED3xNmMW/yHUQc
         J9fg==
X-Gm-Message-State: AOAM532rSu2kHIdT+O1LIUVYh7iwrvSvMFZo9cpO98+xzpgLsQyIzh5Y
	2tWfcy9FVxJpGXr4sRwbcAQ=
X-Google-Smtp-Source: ABdhPJyXVr+/e331Nl3N8zpr/hnMmvHiMgeK7mKzBbEhSiUEUeseaHzxl+Rv66twXjTKLVvo/wxa4Q==
X-Received: by 2002:a37:8c82:: with SMTP id o124mr4916959qkd.35.1598058731284;
        Fri, 21 Aug 2020 18:12:11 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from [10.0.0.29] ([135.0.225.35])
        by smtp.gmail.com with ESMTPSA id r6sm3801407qtu.93.2020.08.21.18.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 18:12:10 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
In-Reply-To: <c96fadd369237d98c0ffb1f5168e6b4776f2b95c.camel@linuxfoundation.org>
Date: Fri, 21 Aug 2020 21:12:09 -0400
Cc: bitbake-devel@lists.openembedded.org,
 =?utf-8?Q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
 guillaume.champagne@sonatest.com
Message-Id: <A8B861AF-5766-4559-B428-A82BC3B819ED@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
 <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
 <29032972-1F01-4FE9-A3BD-13E1FFD43790@gmail.com>
 <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
 <866732CC-FB4E-4F0F-853B-1225FBAC9749@gmail.com>
 <c96fadd369237d98c0ffb1f5168e6b4776f2b95c.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hey again!

> On Aug 21, 2020, at 18:41, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> No, although I was struggling to remember why it does this. The answer
> is:
>=20
> =
http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/siggen.py?=
id=3D5a3a7e0f746ad5dd160bc297d8c8b0e770630d89

I understand. Thank you for this.

>=20
> although these days I don't think we use shared work tasks.
>=20
>> If true, then could we not simply only snip the path itself, and
>> leave the rest in the same order?
>>=20
>> So
>> 'mc:X:virtual:A:B:C:/this/is/a/long/path/recipedir/recipe_verison.bb:
>> do_task'
>> would become 'mc:X:virtual:A:B:C:recipedir/recipe_verison.bb:do_task'
>> ?
>>=20
>> That would definitely simplify the implementation and be more future
>> proof, would it not?
>=20
> Well, there was a reason it does this. That reason may no longer be
> heavily used but there is a bit of work in deprecating and removing
> that shared work support which in turn would allow this to be cleaned
> up.

I am writing the unit tests now.

=46rom what I see though, it seems like the 'virtual:xyz' and 'mc:abc' =
are mirrored in the output. Meaning that:

'mc:X:virtual:A:B:C:/path/recipedir/recipe_version.bb:do_task'

becomes:

'recipedir/recipe_version.bb:do_task:virtual:A:B:C:mc:X'

Is this completely wanted and necessary?

Sorry for the counter examination! Just seeing what the actual real =
requirements are. Once the unit tests are in place they will carry that =
torch onward. ;)

