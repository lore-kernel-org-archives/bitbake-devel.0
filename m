Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0308C48260
	for <webhook@archiver.kernel.org>; Sat, 10 Feb 2024 20:42:53 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.23424.1707597771196733100
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Feb 2024 12:42:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d8ER2jtv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410a2adf878so3209635e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707597769; x=1708202569; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WXLH3A27ULq4ky+AN79FCXoFyllqItUUe9/o9ddB4l8=;
        b=d8ER2jtvCHUyVuJql25ePpTWZO1g+6rT9zKBzbS1/9Ja4SRMJ+uKKDnIEAjeEf76Uj
         N9P9o2sJMC7Wodg9EBxDAP6Wqxahs8xrrPS4Y+rolHRnFMyafApmxMByWC7qQj8hrBoj
         lbJwPIKD/vkzRlsdLqBCN9lTp4NQDgFueSVas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597769; x=1708202569;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXLH3A27ULq4ky+AN79FCXoFyllqItUUe9/o9ddB4l8=;
        b=UvaYa8yWoVu1eLLmHbOyWnwbz+eue63n6fPFeDcnpAZj2gQ2FexBPFbe0NLfBMBWRN
         ZB3U6rfSKDV6JcgfN9Pe6MvX56rcF+LAuqI0eT51m4jGLm5e+WyqHl0wtYBypb7FSqNU
         gkEwxUbdEBDLrIOo+ech3/rAuky2c/4ObmJJ87BfxA09JfoLCNOinuxt2J72/yh68avD
         XlFiL5qqsJqfSK53BHJca5TmRst1jHEYoj+woY7GWaXsHyxxUJMSg605lnI6T3uEi7Sk
         W/L/oIl2hoAOQ4V8sR44Eq7DfYKivIPZw3uW7loIAQe8lp4/oyKA48/an8rY6BlK/fcT
         8f/Q==
X-Gm-Message-State: AOJu0YxGT5FAREUbVVLjVAXFrxaGPdGp8DxNMNrLYLdmnJQKoCXQUnyo
	0Ld44+oCnui0/jfCWxgApT7pACaJfJ6PHL7NFoVQanosljUD6mGPQbchKClumy0=
X-Google-Smtp-Source: AGHT+IEZesMbnNcfarfD6DBZFGxbPXnCJNyTuByNms4y71717F/5rxY/AEe5Cq7FGebR0UvCmjSlkw==
X-Received: by 2002:a05:6000:dc3:b0:33b:6a7b:d623 with SMTP id dw3-20020a0560000dc300b0033b6a7bd623mr1822697wrb.32.1707597768792;
        Sat, 10 Feb 2024 12:42:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVR/PNEYKEW9qVFLIbL4CvAd2kfbj8CaaEyX6WmOGu8Cf7H3B2oZ6guPIHjagZlE2RiITPalBLMgWYsays7IPU900mjj0kIgszyjTRJA8U2kS4ht4s=
Received: from ?IPv6:2001:8b0:aba:5f3c:c350:b3c8:3bca:cef1? ([2001:8b0:aba:5f3c:c350:b3c8:3bca:cef1])
        by smtp.gmail.com with ESMTPSA id m25-20020a056000025900b0033af5086c2dsm2648782wrz.58.2024.02.10.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:42:48 -0800 (PST)
Message-ID: <adf4c2ad6379c81acc9086b7617c1b9a69bc3905.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] regression of 'world' performance?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Sat, 10 Feb 2024 20:42:47 +0000
In-Reply-To: <17B2894C95E031D0.14481@lists.openembedded.org>
References: 
	<CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
	 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
	 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
	 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
	 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
	 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
	 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
	 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
	 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
	 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
	 <17B24084174823DE.15017@lists.openembedded.org>
	 <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
	 <17B255DB2CE33879.588@lists.openembedded.org>
	 <17B257441406400D.588@lists.openembedded.org>
	 <17B2894C95E031D0.14481@lists.openembedded.org>
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
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 20:42:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15874

On Sat, 2024-02-10 at 15:16 +0000, Richard Purdie via
lists.openembedded.org wrote:
> On Fri, 2024-02-09 at 23:59 +0000, Richard Purdie via
> lists.openembedded.org wrote:
> > On Fri, 2024-02-09 at 23:33 +0000, Richard Purdie via
> > lists.openembedded.org wrote:
> > > On Fri, 2024-02-09 at 21:44 +0100, Alexander Kanavin wrote:
> > > > On Fri, 9 Feb 2024 at 18:02, Alexander Kanavin via
> > > > lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded=
.org>
> > > > wrote:
> > > > > I worked around it by running 'bitbake world' without -P so it co=
uld
> > > > > parse recipes successfully, then re-running with -P against pre-p=
arsed
> > > > > data. So profiles are being collected now.
> > > >=20
> > > > Here it is: https://drive.google.com/file/d/1bM1MGJWU5uWRf6kE6AaENQ=
LQKIbopnGW/view?usp=3Dsharing
> > > >=20
> > > > I pressed ctrl-c after some 20 minutes - I took a look into it then
> > > > but somehow couldn't find anything related to execute(). The two
> > > > collected profiles seemingly are just waiting on select().
> > >=20
> > > This didn't make much sense to me so I ended up going digging.
> > >=20
> > > The traceback you showed is reproducible if you trigger parsing while
> > > using -P so a bug needs fixing there. You can avoid it with something
> > > like:
> > >=20
> > > bitbake -p
> > > bitbake world -nP
> > >=20
> > > However what I've then realised is that when we added the second thre=
ad
> > > to cooker, we only dump the performance data for one of the threads,
> > > not the other.
> > >=20
> > > So I suspect we need to fix the profiling to dump the stats on the
> > > second thread, then we'll see what the real issue is.
> > >=20
> > > I can confirm that bitbake world -nP is running much slower than it
> > > should, even just for oe-core.
> >=20
> > I've sent a patch to add the profiling for the other thread. With that
> > applied and a simple "bitbake bash -nP", profile-mainloop.log.processed
> > contains:
> >=20
> >    Ordered by: cumulative time
> >=20
> >    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
> >         1    0.240    0.240  104.476  104.476 /media/build/poky/bitbake=
/lib/bb/server/process.py:421(idle_thread_internal)
> >     12663   75.679    0.006   75.679    0.006 {built-in method select.s=
elect}
> >     13842    0.036    0.000   26.361    0.002 /media/build/poky/bitbake=
/lib/bb/cooker.py:1474(buildTargetsIdle)
> >     13842    0.017    0.000   26.324    0.002 /media/build/poky/bitbake=
/lib/bb/runqueue.py:1624(execute_runqueue)
> >     13842    0.214    0.000   26.306    0.002 /media/build/poky/bitbake=
/lib/bb/runqueue.py:1523(_execute_runqueue)
> >     13842    0.274    0.000   23.590    0.002 /media/build/poky/bitbake=
/lib/bb/runqueue.py:2147(execute)
> >      1621    6.623    0.004   15.030    0.009 /media/build/poky/bitbake=
/lib/bb/runqueue.py:2418(build_taskdepdata)
> >   1338979    3.250    0.000    5.513    0.000 /media/build/poky/bitbake=
/lib/bb/runqueue.py:2407(filtermcdeps)
> >    211156    0.633    0.000    3.877    0.000 /media/build/poky/bitbake=
/lib/bb/runqueue.py:3217(read)
> >     25898    0.058    0.000    3.213    0.000 /media/build/poky/bitbake=
/lib/bb/runqueue.py:1419(read_workers)
> >     37063    0.252    0.000    2.876    0.000 /media/build/poky/bitbake=
/lib/bb/event.py:190(fire_ui_handlers)
> >      1686    0.029    0.000    2.870    0.002 /media/build/poky/bitbake=
/lib/bb/runqueue.py:1328(send_pickled_data)
> >   1411556    1.677    0.000    2.704    0.000 /media/build/poky/bitbake=
/lib/bb/runqueue.py:56(split_tid_mcfn)
> > 8982/8940    0.016    0.000    1.936    0.000 /media/build/poky/bitbake=
/lib/bb/event.py:217(fire)
> >   2284982    1.234    0.000    1.924    0.000 /media/build/poky/bitbake=
/lib/bb/runqueue.py:41(mc_from_tid)
> >       979    0.002    0.000    1.906    0.002 /media/build/poky/bitbake=
/lib/bb/command.py:110(runAsyncCommand)
> >      1686    1.852    0.001    1.852    0.001 {method 'write' of '_io.B=
ufferedWriter' objects}
> >=20
> >=20
> > which even without a world build, says some interesting things about
> > the 1.3 million calls to filtermcdeps and the time spend in
> > build_taskdepdata.
>=20
> I was curious about the time spent in build_taskdepdata() since we can
> fix that. I'll send a patch out shortly but with it applied, the above
> becomes:
>=20
>    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
>         1    0.268    0.268   93.061   93.061 /media/build/poky/bitbake/l=
ib/bb/server/process.py:426(idle_thread_internal)
>     16033   78.812    0.005   78.812    0.005 {built-in method select.sel=
ect}
>     16876    0.038    0.000   11.875    0.001 /media/build/poky/bitbake/l=
ib/bb/cooker.py:1474(buildTargetsIdle)
>     16876    0.019    0.000   11.835    0.001 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:1624(execute_runqueue)
>     16876    0.084    0.000   11.816    0.001 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:1523(_execute_runqueue)
>     16876    0.274    0.000    9.231    0.001 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2149(execute)
>    201858    0.615    0.000    3.589    0.000 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:3227(read)
>     32302    0.062    0.000    2.924    0.000 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:1419(read_workers)
>     37041    0.217    0.000    2.616    0.000 /media/build/poky/bitbake/l=
ib/bb/event.py:190(fire_ui_handlers)
>      1686    0.021    0.000    2.606    0.002 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:1328(send_pickled_data)
>      1686    1.837    0.001    1.837    0.001 {method 'write' of '_io.Buf=
feredWriter' objects}
>       979    0.002    0.000    1.827    0.002 /media/build/poky/bitbake/l=
ib/bb/command.py:110(runAsyncCommand)
> 8960/8929    0.015    0.000    1.798    0.000 /media/build/poky/bitbake/l=
ib/bb/event.py:217(fire)
>      1621    1.355    0.001    1.491    0.001 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2436(build_taskdepdata)
>     17943    0.144    0.000    1.451    0.000 /media/build/poky/bitbake/l=
ib/bb/cooker.py:113(send)
>     28081    0.022    0.000    1.354    0.000 /media/build/poky/bitbake/l=
ib/bb/event.py:237(fire_from_worker)
> [...]
>      3657    0.078    0.000    0.085    0.000 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2409(filtermcdeps)
>=20
> i.e. 1.3 million function calls to filtermcdeps becomes 3657, so
> probably a valid speedup.
>=20
> There is probably something different Alex is running into in his build
> so I'll wait for the data for that case.
>=20
> I'd note that whilst the performance logging patch does work, it can
> mean the cooker is slow to shut down so if the mainloop file isn't
> there, wait for the cooker to exit.

I did try a world build under dryrun and the profile for that is
interesting:

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    1.965    1.965 2141.353 2141.353 /media/build/poky/bitbake/lib=
/bb/server/process.py:421(idle_thread_internal)
    79527    0.362    0.000 2029.951    0.026 /media/build/poky/bitbake/lib=
/bb/cooker.py:1474(buildTargetsIdle)
    79527    0.202    0.000 2029.579    0.026 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1624(execute_runqueue)
    79527    1.243    0.000 2029.377    0.026 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1523(_execute_runqueue)
    79527  820.305    0.010 2007.390    0.025 /media/build/poky/bitbake/lib=
/bb/runqueue.py:2149(execute)
    64340    6.256    0.000  702.802    0.011 /media/build/poky/bitbake/lib=
/bb/runqueue.py:286(next)
    34291  386.267    0.011  696.392    0.020 /media/build/poky/bitbake/lib=
/bb/runqueue.py:225(next_buildable_task)
    32188  174.899    0.005  185.634    0.006 /media/build/poky/bitbake/lib=
/bb/runqueue.py:2436(build_taskdepdata)
147477450   90.392    0.000  156.644    0.000 /media/build/poky/bitbake/lib=
/bb/runqueue.py:38(taskname_from_tid)
    32279    1.105    0.000  142.652    0.004 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1328(send_pickled_data)
    37605  100.098    0.003  100.098    0.003 {built-in method select.selec=
t}
    32279   92.282    0.003   92.282    0.003 {method 'write' of '_io.Buffe=
redWriter' objects}
   703235    6.748    0.000   83.246    0.000 /media/build/poky/bitbake/lib=
/bb/event.py:190(fire_ui_handlers)
    34309   77.040    0.002   77.040    0.002 {method 'difference' of 'set'=
 objects}
   117124    0.501    0.000   76.536    0.001 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1419(read_workers)
   197389    7.075    0.000   76.379    0.000 /media/build/poky/bitbake/lib=
/bb/runqueue.py:3228(read)
149286630   66.616    0.000   66.616    0.000 {method 'rsplit' of 'str' obj=
ects}
   341878   52.515    0.000   52.515    0.000 {built-in method _pickle.dump=
s}
111790/109676    0.394    0.000   51.501    0.000 /media/build/poky/bitbake=
/lib/bb/event.py:217(fire)
    68594   46.275    0.001   46.275    0.001 {method 'difference_update' o=
f 'set' objects}
   591445    0.700    0.000   43.421    0.000 /media/build/poky/bitbake/lib=
/bb/event.py:237(fire_from_worker)
   309599    3.991    0.000   42.746    0.000 /media/build/poky/bitbake/lib=
/bb/cooker.py:113(send)
    34308   25.668    0.001   25.668    0.001 {method 'intersection_update'=
 of 'set' objects}
16970/15322   23.129    0.001   23.278    0.002 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2683(scenequeue_updatecounters)
16739/15091    0.023    0.000   23.236    0.002 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2748(sq_task_failoutright)
    71163    0.436    0.000   20.433    0.000 /media/build/poky/bitbake/lib=
/bb/server/process.py:880(send)
    71163    0.534    0.000   17.511    0.000 /media/build/poky/bitbake/lib=
/bb/server/process.py:874(_send)
    71163    0.422    0.000   16.073    0.000 /usr/lib/python3.11/multiproc=
essing/connection.py:182(send_bytes)

in particular the 147 million calls to taskname_from_tid(). Definitely
something to be done in there.

Cheers,

Richard





