Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BEFC0218A
	for <webhook@archiver.kernel.org>; Sat,  1 Feb 2025 13:29:56 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.42838.1738416592438793197
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Feb 2025 05:29:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ijSTIOfE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so28951785e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Feb 2025 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738416590; x=1739021390; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYW5P19E25QEXRncY6PLB6gQuw+j1E5p+8ZFTpPvgWE=;
        b=ijSTIOfEx7us2VbQHPShqG1rC7oBxF+vZE/VCSwWVIIl+NsDC/Wt2O5bSR7IJFb/tr
         xeOPhOcCntYgvm95FL7C6TNoxDqPy6zvjkOx6sZoK8XqkHzdxciBmiGP9sadapOLtWaV
         H0hA8reDfJakR1naWkFkSXBlyJ0WVj/ly1p/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738416590; x=1739021390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYW5P19E25QEXRncY6PLB6gQuw+j1E5p+8ZFTpPvgWE=;
        b=W+JxKDonNtagGl53cCZMgbmHZUGiWAyZreOGvswYFqqJhnVAAmHhi+Xkq5CYJwx47Q
         9GtXNZkrnULgoAA+PSc7RbAkKSPKRKAm8XcgGvGtyTZBKWe9yIXSSzN6bl3KUppM214g
         6b1nSXZjNKRh5Lckz8wRZYR7E+IUzqDKBhUF/e8rfbrPH2kjSQgTsfY7icpdjBOqQ7yD
         jKUGL5kRTjsfZCSn58tx3W0Xs3pE0nU7nPJ51HBn8J7DeLpiqXmPzO6OmAUILvVEXku2
         cZXfbIVmRbwScaHW9oZqK9cx5R7jP8Yo1835KpAf6ICHGVyMlP+XnABL7ginkN8oQ1TK
         rduw==
X-Forwarded-Encrypted: i=1; AJvYcCVT+fdYLYsFofiSVHtUfVqj7St8zVPjSpgvBCkAtIpxOiBXkAizS4A0DzdyqOAT7SgvG+t0vzGHwhbE1KKQ@lists.openembedded.org
X-Gm-Message-State: AOJu0Yzgx1TpxByICIYgwr0Zo/63MXVSUHOs7helA9A8ZlUQboIpf8Bg
	0xhWFp5YN0HUVL/x5hB9bcxZgehD8UWYmukGl09GsNfMaCVlolY/ieqXLHuAa/sjNoJvk3IV/pI
	n
X-Gm-Gg: ASbGncs7xxMmK3JMoIPpZO2hI9hjY0ASpkgxgfaWmMSqdb4Pjs4W5h4d5QVEVDpID+0
	AiOgzMBM4Q15L7m+FIHZDVDxQ2c+5iYND/5xzYSfu8kf0XEDwJqAReGmIQERMzbB/dUkAWjxACt
	7g4TYlatA71tCEiXrahK87Yx/dvMw2fcwLGVRwvotguTTuZ/AS3ItSzeMj2HvWrsQxXZJyHdbSm
	DukE24P9tBkd/afmKPiT7pZUFRb4QE7V2ic/6MRGwG6Q6Icj7aW3x2fgslpNbF/UwArm5U76IM/
	qO4Gvz0/T5GaDdL2ebLiGF2oiTUy1o8P6XPe4jWN2BTqP5K8pvR5RFcyazTQShloZzA/QZfCkod
	fi5NR
X-Google-Smtp-Source: AGHT+IFUWuxctvQm/ud1Bay3tKJjsUhsAP+t0DN5ua16NpM+EbAA/wlB3Vv/FwoIYFREdH88NLbJ3A==
X-Received: by 2002:a05:600c:4e45:b0:434:f623:a004 with SMTP id 5b1f17b1804b1-438dc3ca1d7mr143828185e9.16.1738416590644;
        Sat, 01 Feb 2025 05:29:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d54e:ac44:1af7:8635? ([2001:8b0:aba:5f3c:d54e:ac44:1af7:8635])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2f73asm123863575e9.24.2025.02.01.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 05:29:48 -0800 (PST)
Message-ID: <fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to
 ${.}, ${+}, and ${:} variables
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: n.merinov@inango-systems.com, bitbake-devel@lists.openembedded.org
Date: Sat, 01 Feb 2025 13:29:47 +0000
In-Reply-To: <20250129185531.3752682-1-n.merinov@inango-systems.com>
References: <20250129185531.3752682-1-n.merinov@inango-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Feb 2025 13:29:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17121

On Wed, 2025-01-29 at 20:55 +0200, Nikolay Merinov via lists.openembedded.o=
rg wrote:
> Old code that parse variable names in assignment commands behave differnt=
ly for
> variables that ends with special symbol for single-character variable nam=
es and
> multi-character variable names. For example:
>=20
> =C2=A0 A+=3D"1"=C2=A0=C2=A0 # Change variable ${A}, '+' glued to '=3D'
> =C2=A0 A+ =3D "1" # Change variable ${A+}
>=20
> =C2=A0 +=3D"1"=C2=A0=C2=A0=C2=A0 # Change variable ${+}, the '+' symbol n=
ot part of assignment operator
> =C2=A0 + =3D "1"=C2=A0 # Change variable ${+}
>=20
> New code would always assume that '.=3D', '+=3D', and ':=3D' is assignmen=
t operator.
> As result code like the following would raise parsing error
>=20
> =C2=A0 +=3D"value"
>=20
> While code with extra spaces would work as before
>=20
> =C2=A0 + =3D "value" # Change variable ${+}
>=20
> This change allow to catch issues in code that generate bitbake configura=
tion
> files in a manner like "echo ${VARNAME}+=3D${VALUE} >> conf/local.conf"
>=20
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> ---
> =C2=A0lib/bb/parse/parse_py/ConfHandler.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0lib/toaster/toastermain/management/commands/buildimport.py | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)

This is an interesting bug, thanks for reporting it and sending a patch.

I'm a little torn on what the right thing to do here is. I'm wondering
if it is time to say that whitespace around the assignment operator is
required. That will break metadata and I've found a few hundred places
it would break. Equally, those can be fixed and we'd end up with a
better end result as the whitespace does make recipe files more
readable. I have a patch to fix most of the references in OE-Core.

I'm worried that if we do what you patch does, we're complicating the
code and potentially setting ourselves up for other new interesting
future problems.

I'd also love to see some test cases adding to lib/bb/tests/parse.py so
that "bitbake-selftest bb.tests.parse" would detect these problems if
we ever introduced them in future.

Cheers,

Richard





