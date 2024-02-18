Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588FC48BF6
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 17:36:34 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.22499.1708277791976769413
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 09:36:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dYs4fv8n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41262ec677fso2897985e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708277790; x=1708882590; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrX5WrC57cJzYBoTFJmdRkFp0DuA7Tgzq4aeZQNIMLI=;
        b=dYs4fv8nB7bCkWRwW5zzIYq9ELr4fd9A3Bf0mMDpSJFkOPfJyHaAgwFHpMqyj8fHAE
         b/BodH0WTg+C4T9aHuAYMXIrzUulqaJOfFeZenGrEtU/f2qz6VzBmSRLrk8l8YLsIGXs
         bXe53jr+J8ooZeMLQBEH5wWNzYYg4yI910Nmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708277790; x=1708882590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrX5WrC57cJzYBoTFJmdRkFp0DuA7Tgzq4aeZQNIMLI=;
        b=H9iUgF5ABVogXvn3hkM70VDSyKDXfUZWolVPW4xMf3hPmIKlJpzATME+Gp5K+V0H0t
         RL2oYGT8dAf+1UNc48QZF6MkoGK0ViGmt5QMz2n2Fx0GgJbTB6r5a3Jn+7qzFPryO91+
         Rq2eL0c1SdVeaZyPAp2m9BYXu1RDfozlPaGIw9DZUfYdhhBT0gddi7rgBrUIYSajKCw1
         TF31oCHdHqZBD4s0zR1QZjcZHma+ZWK3wB7gQeb23C7OI/WFxHigW3Y7Sxugoq+ha2eR
         VCZg/Mk2qpp6eQ9zrMpUfKFC8KtMS3bnBI19yRlbw7fZnKArM83wDVC+2+UgiF3stxlX
         /6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdVaSZQknumneqjuEaFXa6VU0IUwNMEsGVFsz5xWFvGB1d1q7trDgKuN9Z3+0yO5yLs6EoS5iYdVLwR3otMoFmFxqr63ro3N7Azv5JgzJ6RU/Ivks=
X-Gm-Message-State: AOJu0YzZKu+ExaiwkuYy2JH6+LwuTFdjoMk/BDTEAqWa39R3ZMGZQikE
	vW6MdyZi1RkldBuKa+mmLtJHyiZ0m5ppTCe5DDcffvdKAgn4PgYxSGRVCOnTIRU=
X-Google-Smtp-Source: AGHT+IHz6N3Nkx5ZRRJtxOWBpQ0m0cWSf1UlkI9vCmm4P2ssXToBKTcegIRxIedrr9sd6n50N/snlw==
X-Received: by 2002:adf:f187:0:b0:33d:82a:14af with SMTP id h7-20020adff187000000b0033d082a14afmr5953546wro.64.1708277790034;
        Sun, 18 Feb 2024 09:36:30 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d44:5cd8:cef2:3070? ([2001:8b0:aba:5f3c:3d44:5cd8:cef2:3070])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d6daa000000b0033d170a5d6dsm7884124wrs.98.2024.02.18.09.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 09:36:29 -0800 (PST)
Message-ID: <7461170e0a5ee05698999ab57e53586ab95fd09b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] taskexp_ncurses: ncurses version of
 taskexp.py
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: david.reyna@windriver.com, bitbake-devel@lists.openembedded.org
Date: Sun, 18 Feb 2024 17:36:28 +0000
In-Reply-To: <17B4F59E3ECA4807.31287@lists.openembedded.org>
References: <cover.1708252029.git.David.Reyna@windriver.com>
	 <c3864291243d501bcaae5ed79cb1fd4577ac324a.1708252029.git.David.Reyna@windriver.com>
	 <17B4F59E3ECA4807.31287@lists.openembedded.org>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=mQINBGN1PzgBEADqZynxX+ivalgYtZ+AoHoGynCiJw0lR+H9rC83sj9z38nlKHBCuh8r8KOqelDUf1B73E9oCLjZQVwqKLmao6ZDQYt7utG+h6qGLEgyDfeochYkLwElvRtjhTp0Ks5WPIHUgE4lwfqmsLrHbkEfRYui9eSd+zJpPKTRgQ7WhTGfRaXPEVYn24fWEo637biLyoEop1qaZMoY/mPsflDYDISWgAeunFx63oL9zNAhOWbLIy2uicKq2GyS56CooPzQkpUv7ssQBOqXp/FSuGJ49RV7Npj/eXyEepAh3BtMliJF08rAj07Hpywp3skXku8YcwUAD7TqOnJ4Wr6G8vpJlQKSITIGMBqtq3f8+SwImWEMRVXxDzrmznihOC7qEUWH4tN/AEkz2BJQbGYnp3iQjZqsoqKblyC83/5MCCUHHpDg20HooEWVNTUxUa8dGWaJehKC5fX1276Sm4WLaoqbQwSGCmwS1e+LjO9lFT80WHIELw07iDhQxshNqVLIxCt3pZfWRlf9fHCtxStiQIRrQLAKN7ze+//YjExjkDOt1ZFIsgMmKIQmJ6b8kRAAmQUraTcn4E/hy0mArFLmROyPSc1nD8hQMeELDcjyjEmo7j3qQCsU464v4tcvJVXyqPc4TU1GDQdZBaKP0/jR68aR3ZOvzx99jdocPdHNW4Kpbv6PnQARAQABtDNSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz6JAlcEEwEKAEECGwEFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQQRclb3b/q6zLA9Fn+aUMY1GLyygAUCY3VBgQIZAQAKCRCaUMY1GLyygAtOEADglyjAhkCSGGetbs40FJ4
 xdHKck7aaB1FgbpGn9e9/WAeAPC722eJsxhujxgKaS9b7mHcTcWeMP7KFut4yKTDHovt4VbQOd PGqwyUmi8z0yd2ORlT9E3RjEEllpj/Z2Wfzs3H4qR5wz3Rij1BCirDH8LD5yAO8PpIW2N1Y4VbzFDTPX2KtLGQYIraOHZQQe8XjAJnXflVQbzSIbNw14IlVWnF94UwkamxRhhCVAdA4139ebU+R0inaVsG0Bb7GP3KiED4C1I/tj171G4bOsyz3zYkpuV64yuq5pVevLBuCJv1Z/yiBdbB02B+FkosKLWRvoZFa2gqK2xpZT8RvDdkBQTmZTs/hP59mh1QSt4d2p1KsBu7cx2fjRBuf9XVG+uR/XnbD5T1BQRVV641ZNzPTjtE3rEZzR1nsUv+vcFYv0V/FPcLg5f3Ui+4cuYj/xDykMKZlrBIVGExBOJr7Anbzwq8o4nYUsrbFE3Fu88l8/mWrQCkAIZqc2NRyuXplZrDanB9Abi2XmZO0B3Q9wKvzmH0yJyLfswmzrejf3oVOJNEKJP5acPnXfQqAr5F7gdeLvdHbOAtg1iU8GujkOvRA7ad5ahT/1mDzKlkjaf36p4jodsGzPydOks2/jbVZxbZsR1il3BuDXb0agChNXJH4IpcnrjAliBtTKwnEYuLQeLQsUmljaGFyZCBQdXJkaWUgPHJwdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz6JAlQEEwEKAD4WIQQRclb3b/q6zLA9Fn+aUMY1GLyygAUCY3VBEAIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCaUMY1GLyygA0tD/4l5GVZ1OTKoCsHzQuSUVnyzmSwYmJD7W7E1VeVVvVk5bfFf/w6p3dXfGjhZ8zFackE+RmT3//8kQ+Zs68csd0wjX8klyFXgA5PWP3DxNkejnHCq7wiLouOGC/E9RSUULn1DYb68yPzvdGQBooqPQZORtXzNgM
 NuWDKH+9uvhGbdvURJHCRPTpgcdCo64d+IMzA+XmZUg0P722IyVmB+I2TgjaIRr/NsbsGP4x3u8 TVfJPXmE1IS9nrKEm023ntuy1AH9JlACLZ4LGvpxf8x7ZVKaXXqWOQ1aQ5BCQoOc41AiVUyeiq2wdLRQaNOxbb8+ED34BYLyMjZdII9eovZMbMt7kLSjkbOs/k3s7wtQ2eY7QnSggf8/MWUSUaJzLKHnOBRcqGjdFdlZ0BKXL+v9NrpjcUBsG1TY5XORIahk6Pt1+cPyIsKdycKU4RHtNfwX5fidE8AhU97U04z3tIYs121J4M/EG3bEfOtwDaH7BRTZHK5B05Mks/kX608CwLSJSbX2dSENInh5+dSVQ0egbFbXQGcHFmCCMjYH09hcNUSEyI4OUQHVu8HHQIfvutPqIsZEtJ1K/s3ZD3Zyq35UUiwnCu5hYohX9B0o0TwgDaI85dS2edHy2bnM3a9yuTPiwNYpfR6dp6cg8BM+9qqkJvwp5LiMcZcJC8S5xR3U0FtbQiUmljaGFyZCBQdXJkaWUgPHJwdXJkaWVAcnBzeXMubmV0PokCVAQTAQoAPhYhBBFyVvdv+rrMsD0Wf5pQxjUYvLKABQJjdUEhAhsBBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEJpQxjUYvLKA/iUQAJJkVW2yDzxrH/5szOuG0ZDDH6X6Yrdp+m+F4hHHJQkTYgdRPeoHYKyXNOettdVKrZyEDkztBWkB7Sd7zuVHR3Q4PVTsEh09ZzkqBgN8OevMA7RPHZOa2PYJ8pAx7eTah1whM2eOf+VZGKrW1R9ouTluV7/c4o5loaKuh+t61W2nH6E+lQt3/gKnwj4QmUb5V957ZSHO1cnjtHrd4FFmkYQOCbolEfC25lT9vh4ldY+dILQPcq4at/LEABp4xEgS6R7K4E3cDnjWogrZTiniAUrR7P0SNYv7WCpAbvk4Z9DGCHXpKod
 KjTi3em7xDpqA1Rxd/rV4z9VQJrbpL/oiPCnTW/iCx+eMH70dRk+gHxSU8FWVf+CucFZprvO9UMi tGHLvfpBxfnGDT2EOqOoFOYgYHq7MfSDZT+zM/gBWfHXbyz6W9RYqycwWCIhG5jhMhT2sEWr4FlwmXfogvSqxvKondwPfXsgNT1MdBqa0Hhm0pIJYs4ovKWnvymTraziqSWI2C9X5lPmf6ugNiuzJt5BqlilNHxsej9OC53HfBbkgDONdcJbduW9nrJlIl9OLanB4/fvuqG1ZIS/eFFAkb2YnBBuS2TNz3aPd7vFkOoMU7VegDic/sH23eZPGQm3XWcTYwIY2djBU8Jzyy4mRIOQZMGXb/ygrGXAuIxL2R2O1uFYEY3VB1RIIKoZIzj0DAQcCAwQzkAYGjbS/m2SeumSYfDZKeazIkOpwUxpTQ7kPxz0ijiquKSsEZzlPMFzhA+iBJh2jdCyabi5K+8+v3VZZglbWAwEIB4kCNgQYAQoAIBYhBBFyVvdv+rrMsD0Wf5pQxjUYvLKABQJjdUHVAhsMAAoJEJpQxjUYvLKAr6UQAMyaDatvvCkxvOyFgO6jxLLzbkwl40hTNB/TsG5RdwL6FXnBMzkIa5lEfgV1u2zwu0p7SKWH9J3DSNqYKjUCAfwDEv6aDKrFYqGQZMuke1ZAfKqmWTIYOKYG4vRgvvF1u0aCOrRJiipjEPnrw1LC6eaqpnI3WGJyy8Wgr8aO0RBUO93ax/+Mpw3QG+jQqZjuomBWGvUwsjRtzE9j2QUcGxjyTrocVsR2qjK0boE4jLGJWNreSIgs5Nllww++3l0pabmXhyXqDdoYE1U0WkI/yemsc8ydDtjpeG4uzv9rfd5VUqHoZpuYZ1sc4DTGFrEAoght/9FXWsOFOtX8vZprLFFi7iFNSDChIFEsyuizHOW5wl/PYkGCCMZvwPK61IvCARKwevdnSrle9omYEqjnU/HjVZ/kvtKxn1VN15j1NNF
 0zgmm+/RfbZFHbeuea/lVInXpNBMDj+pl3VyygUae65DMFWgYVSLtXPTRLVMb2mIxiNpk3T2UcuVW 1XC9LWup6h8jHEJ0zBCPjPyd1tFQ9hHVOJnwRthV+VG3zuBf8sri1TPnz5XjNpu3Q3r/6turvh+Khal2itb980tITH5fDbLUewPiA2jCAgZCkVMQcvYTS4rZCC+hpHSMte4m1n7AcmF9ohhw6tt41AEhwbMh+nRkyjDkY+k/vivg0obC2JpruDMEY3VCGBYJKwYBBAHaRw8BAQdArl5/9Fe2aA9JEc+HRm2rnCl6NMb7DZJLnM0xmQg1ouyJAq0EGAEKACAWIQQRclb3b/q6zLA9Fn+aUMY1GLyygAUCY3VCGAIbAgCBCRCaUMY1GLyygHYgBBkWCAAdFiEEHKt8QO5c0zRDdmiGodJewzbIKeYFAmN1QhgACgkQodJewzbIKeawUgEAzEwjSYf8lXVNcZVYL/4SLX9FEop83Q8+WmwT2rGhA+MBAKga5Fl8afYVHuPlPOxB/M7aQdP8vfYEx/cWmHmQEUICQxQQAJd85C4//BU0FOUPlEQ1vofZGNC1wTzVA7cQtYlIRrgQOmjR4tOFTxEzusA8QvXxOYkMkDlaa/Ai4/nicMqadnWPQ37BmTAW3/O5PVA22mWaC/ZVeG6DGBGVWb/OAwZe9KMxOR6say+bEIM6B6iDgc3V/HNsLWYYPHaj5HebHOKAJ7dqGGUlFV02OrVW5yAaOUEI61cKw0QuwoN1fZgih94EvFicNaLnDVDV64cbOnNyxGlJhbv4WMErtU4RVD3tT1soESmDB4jS2v49reBpsVVXg2G/M1xFO3sUcczHeo5LRaKtXpkXNh4WO3HDT/eb/IWP8Me2YKpwa5dzlrUz0AYi2s+h+LGclOP0Mls0tgS8sQSVdTj/feLk1FSSQGhSKdHMMGTlSsqj7XjToTAnIheq+5sdaY8UCEYu4s6jDiKu6G02HlF
 WpERQ9FmtGo2PVqnMaZy2w9lkNNn8ccyMWpP2EwGuCxONQrc22a7WnCYLTpOukLUSD7ApH7M2Jk8on
 kPGvi48NFq7PWaTkvG3vuSm+eApSToeyz7AVtFt8QOUnHTiNHbuiNpQsDd3y5bLLhU9mIJTbsWNP/72oXV7Tcz7w8zVh2qmuZqhu5qz9rcox3D9unGQ49N3i+CO9c7SqxcLckEjd9o62HsDDpqYv3cdtFNajNsHD8bFU9bb+swCuDMEY3VCRhYJKwYBBAHaRw8BAQdAjoQBsbbnpigttLSFJOFohHY6BGWmjCi520kt0UBBgG+JAjYEGAEKACAWIQQRclb3b/q6zLA9Fn+aUMY1GLyygAUCY3VCRgIbIAAKCRCaUMY1GLyygAQbD/0WyvGz8jA3CTAMTa8yoAlcX73+7aHQaP+DT1PaVU6W85Mm/Bv5JXJ+RWyCCa1jllAWTOhqkOXZ1lXqgislBGtpY22LdwlXW4NGETWwZb79ypR+nayuIPnjOrxkxPOFpcH+wCk9wX0qYi4/8xFTeIZtoty6ayP2bZUZL8aQ91kyUn7nrLmAymPhDq1AAjg+Dkz6DDyzkzXDsY6OY9SpKcWxLkcOm8oXn5B5K5Pl3FaRfYrmX2pAZ6DliQsvPMtXlA01qJ6W4nvRN5ROfjXefNGdyRK8LfJ8BkfDqtZ9/5UrMrW1b7CPA9/7dC5P2jfImtU6R90fz/S4ua2jzeVY2gt7olSDsBqJDOMBPwqEETDROu1+oCIXvdrrZszBu0pTCLV8r+rQqqjICZtK17CEXH3jmDeD/Q6MmAQqeyIhi3uQpGOaveP81WMiC8DDLRXmSuMYOIH/KebzgNnaCQzlQl3a+8tD2qQ48RqzR6JLcKu6h0A6KWItZScfshopNRVsm7FIWM1XUGm1nG6lmPtpVYsXF75hx+YxpAogbzm6fOnUJWFiP1/NVRgtWiii2HG8YCIrEeR3LCUQd/5aYS0CI0cy8WATg/1qkLbcr0lVaCRLT2KZd5WH7tz/4IBanSdCAj6vEfovE5ilWNThQHwg8aPQI6COaHFcTcervMD4Sy
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 17:36:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15915

On Sun, 2024-02-18 at 12:43 +0000, Richard Purdie via
lists.openembedded.org wrote:
> On Sun, 2024-02-18 at 02:41 -0800, Reyna, David via
> lists.openembedded.org wrote:
> > From: David Reyna <David.Reyna@windriver.com>
> >=20
> > * Create an ncurses version of the GTK app "taskexp.py".
> > * Add these additional features:
> > =C2=A0 - Sort tasks in recipes by their dependency order
> > =C2=A0 - Print individual and/or recipe-wide dependencies to a file
> > =C2=A0 - Add a wild card filter
> > =C2=A0 - Show the target recipes on BOLD
> > * Provide a GUI self test
> > * Provide a non-ncurses self test for ptest
> >=20
> > Signed-off-by: David Reyna <David.Reyna@windriver.com>
> > ---
> > =C2=A0lib/bb/ui/taskexp_ncurses.py | 1511
> > ++++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 1511 insertions(+)
> > =C2=A0create mode 100755 bitbake/lib/bb/ui/taskexp_ncurses.py
> >=20
> > diff --git a/lib/bb/ui/taskexp_ncurses.py
> > b/lib/bb/ui/taskexp_ncurses.py
> > new file mode 100755
> > index 00000000000..ffa91ea1044
> > --- /dev/null
> > +++ b/lib/bb/ui/taskexp_ncurses.py
> > @@ -0,0 +1,1511 @@
> > +#
> > +# BitBake Graphical ncurses-based Dependency Explorer
> > +#=C2=A0=C2=A0 * Based on the GTK implementation
> > +#=C2=A0=C2=A0 * Intended to run on any Linux host
> > +#
> > +# Copyright (C) 2007=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ross Bu=
rton
> > +# Copyright (C) 2007 - 2008 Richard Purdie
> > +# Copyright (C) 2022 - 2024 David Reyna
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +
> > +#
> > +# Execution example:
> > +#=C2=A0=C2=A0 $ bitbake -g -u taskexp_ncurses.py acl zlib
> > +#
> > +# Self-test example (executes a script of GUI actions):
> > +#=C2=A0=C2=A0 $ TASK_EXP_UNIT_TEST=3D1 bitbake -g -u taskexp_ncurses.p=
y zlib
> > acl
> > +#=C2=A0=C2=A0 ...
> > +#=C2=A0=C2=A0 $ echo $?
> > +#=C2=A0=C2=A0 0
> > +#=C2=A0=C2=A0 $ TASK_EXP_UNIT_TEST=3D1 bitbake -g -u taskexp_ncurses.p=
y zlib
> > acl
> > foo
> > +#=C2=A0=C2=A0 ERROR: Nothing PROVIDES 'foo'. Close matches:
> > +#=C2=A0=C2=A0 ofono
> > +#=C2=A0=C2=A0 $ echo $?
> > +#=C2=A0=C2=A0 1
> > +#
> > +# Self-test with no terminal example (only tests dependency fetch
> > from bitbake):
> > +#=C2=A0=C2=A0 $ TASK_EXP_UNIT_TEST_NOTERM=3D1 bitbake -g -u
> > taskexp_ncurses.py_2
> > quilt
> > +#=C2=A0=C2=A0 $ echo $?
> > +#=C2=A0=C2=A0 0
>=20
> Thanks for this David, it is nice to see this ready to go in :)
>=20
> I did make one small tweak to the patch when I queued it to drop the
> .py and .py_2 from the above command examples since it caused them
> not
> to work.
>=20
> I've also queued a script to autobuilder-helper to allow us to run
> these tests.

That helper script didn't work. I do now have the tests working but it
took hours to get it to work correctly due to the lack of a suitably
capable terminal in the test environment on the autobuilder.

I did want to see us resolve this though!

Cheers,

Richard

