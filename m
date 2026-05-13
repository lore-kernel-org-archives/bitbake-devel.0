Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5CCD4F24
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 11:33:50 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5411.1778672015887320126
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 04:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NqIywm5S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so111785435e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778672014; x=1779276814; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57wTbMZjhJZAFox6peekKIZ3FCISLwAv8Jgt7dAKc0g=;
        b=NqIywm5SUivM7W+CUP6LIi2G0XembmliHDxrH8t+Thdaq61tU/IIxs0T206twCSROl
         RJc/z5fHGcDKzb8/V2H4fCVj1MO3Jv4qyUx6zc6T1Al+E3uGksqRklDWJw+Yo27g957o
         5eGHqn80ou9BdPjZX1fhQDd10TVI+94JApP64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672014; x=1779276814;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57wTbMZjhJZAFox6peekKIZ3FCISLwAv8Jgt7dAKc0g=;
        b=ThxFPPxbiltOKEL93ISAWl53cFY0xDutjxrNyigBhUghPWCrz/sLCWjdKXK/bvN8A9
         vSciUUV41sRpioTO+NHAHvPG90KeUODG1ya7uRvF1H7sx4FXFHfLVwdwT4tqtBM7kSra
         MCwdct3cMvS8jf7kbIFUwP7O2qXI5xMHLR4qhtmu1j/vT4CmTomqwH2edqN6/8Agx3Lt
         8gUU8bt5TVFFcwkBAi0ICJrT32k0dlkbwq/efv4yauEUfSaR0OI4MnvKOqNy3K3SSHQy
         MFiohLXfeMP4pHKAWkaRmXKmcnCgAzH/RuSOJu2qJ8CjSsOPPv7MK0sYmfUH0RD510Dr
         u/7g==
X-Forwarded-Encrypted: i=1; AFNElJ+FlXr4karW9cg9ZqKrPlSRM28RAE0YNg7JVKd+Dtzutm0JcP61eBDaO/UZ7bCKoCBR8NHSSDj8Is0Fw18m@lists.openembedded.org
X-Gm-Message-State: AOJu0YxYOlNpoWebVkLs0uM8Jpf5LzNq5dMZ8ko2Z2wZzwvtOBdQB+8A
	w1jDGgApXcR0Dd5fsZLaph9hMjhR4Hvka3uWbb1AlLtFLmN9uFh2FP1Q8TYoJKxC+VA=
X-Gm-Gg: Acq92OEwRCbQXOzGv4+k+8LpR32zQjeqZQtj4GEtmm8HJ5MqHko4rsmfx0ke1MEAg8X
	r8WPDbr4JHH/vF2zWvW4mLoZUOly7sV9i92Myg2qmN4swklymEL8hP/vy3abpeAfro/WVj5Ca4x
	Ju/lkt7MM4CDPUlhhXcBW/q0B2K3LTlObPdghf6vSWDp9CXMgm86EE2PqCR1WRqrSGl8ed2AYxe
	bZ6bS8NoAvhQbxyWPnM5WSDI4RKMU6+Z4MfY8t5g1VVQ6kbfYagswq/gJoY+zBBcUBC1iWtnbDV
	nv0fjqRMm4aQ4l0CBlD12FmXHi2WwFHffnF9SmxWURWsey5lfIiTeCe+Qthb79S32KUha64FMLR
	7djzHRVim83TCHUxAV7WJdE3FZcJ1qN8FEllOUdEHhQZG8vv5fdPXGp/EoWkR22VtLHrOwgOXbz
	D7wSK4Qwdy7eX8zawrY9qAqTvyPaXLlMb5AmSUcPaSWXBBCBH1+6NrIdcKwEsb1WyM+3+Ws+6Rz
	qCpLPpkTqCtKA1h
X-Received: by 2002:a05:600c:3e87:b0:48e:8499:4be0 with SMTP id 5b1f17b1804b1-48fce9eec6dmr31907365e9.15.1778672013838;
        Wed, 13 May 2026 04:33:33 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b7ef:b234:c010:91da? ([2001:8b0:aba:5f3c:b7ef:b234:c010:91da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm42170861f8f.32.2026.05.13.04.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:33:33 -0700 (PDT)
Message-ID: <6163fabfba1e616cdd3ef01d79ef47d81b198553.camel@linuxfoundation.org>
Subject: Re: [PATCH] checksum: only split file-checksums entries at
 right-most colon
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <ravi@prevas.dk>, bitbake-devel@lists.openembedded.org
Date: Wed, 13 May 2026 12:33:32 +0100
In-Reply-To: <20260513105549.527210-1-ravi@prevas.dk>
References: <20260513105549.527210-1-ravi@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 11:33:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19509

On Wed, 2026-05-13 at 12:55 +0200, Rasmus Villemoes wrote:
> While paths generally do not contain :, it is not forbidden. Even when
> ordinary files do not contain : anywhere in the path, there is a
> real-world example where the current code ends up emitting a false
> warning:
>=20
> meta-rauc's bundle.bbclass [*] expects the user to set RAUC_KEY_FILE
> and RAUC_CERT_FILE to point at the key/certificate used for signing a
> RAUC bundle. Since those files are not in SRC_URI but are used
> directly in the do_bundle task, they set
>=20
> do_bundle[file-checksums] +=3D "${RAUC_CERT_FILE}:False ${RAUC_KEY_FILE}:=
False"
>=20
> The :False is because they also allow these variables to be pkcs#11
> uris. However, in that case, it will be something like
>=20
> =C2=A0 RAUC_KEY_FILE =3D "pkcs11:object=3Dsome-id"
>=20
> and the file-checksums entry ends up being
> "pkcs11:object=3Dsome-id:False". So the python code ends up seeing
> "object=3Dsome-id" as the [1] entry in the split and "pkcs11" as the [0]
> entry, and the whole thing ends up doing
>=20
> WARNING: Unable to get checksum for system-bundle SRC_URI entry pkcs11: [=
Errno 2] No such file or directory: 'pkcs11'
>=20
> The code really just wants the right-most, colon-delimited field, with
> anything before being the path. So change to use .rsplit(":", 1)
> instead. This should make no functional change for items that contain
> exactly one :, and matches the change done in a70a7376a ("cache:
> correctly handle file names containing colons").
>=20
> [*] https://github.com/rauc/meta-rauc/blob/master/classes-recipe/bundle.b=
bclass
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>=20
> Note: I'm not really sure meta-rauc's use of [file-checksums] in this
> way is correct; it seems that the flag should reflect whether the file
> actually exists, not whether it is guaranteed to exist. But
> regardless, this patch should be correct.

Your patch is probably fine but meta-rauc is not using those correctly,
I suspect it simply won't work or do what they're expecting and the
code is actually pointless in the current form.

Cheers,

Richard

