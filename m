Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EDFFF4955
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 07:10:06 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45550.1774854597776814989
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 00:09:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KIk1Vd5h;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so54660185e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774854596; x=1775459396; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YghSZomjvXdR6veCXabmSfahYUk3ordOs+R0cP2l6rI=;
        b=KIk1Vd5hJrrUlmDnNUMw2kt0tXpsi+t46nOPWUGr3Pmu25CIu1sqjFqUJwwvYz2uTi
         SE7F8i4cvNJp4aKboAIreS0uIjyM5vKceuCdaDx6STPy6RCT8JgICaI18LFpomKRjwkA
         lFaLUJouFm8dxonggBp4nr26GjqBC04HZmAgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774854596; x=1775459396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YghSZomjvXdR6veCXabmSfahYUk3ordOs+R0cP2l6rI=;
        b=k5JbZOxJdpNPgIPVV50xjFhyQPNrWCXmrZGg5xQ+uPsaipkUG948x6eaZEOk899Y0Z
         fKOqtXPfMbM55wxzLX3630Edzcg69nihzJ7/fo1kvpvJU1fJ8FHB/z/OXUcgu7i1yhAo
         5fesvdRW793sOYjgXISkzavKhCltAjyeavXEkD6HUx/S8PURG4p3T8S1SNdn3C8alNZi
         51W6kPj6AmJxhahk6i0vdrZnbgdCHr/yuKQ24au9Ew7z4d4Kd8Y4ccoVtkBLRMzTy5HN
         sksECNX76j/IAO6ItxR8Md5jjEnDLlxWStAeEFT/58bvxMuxmdftOXKDnQKxQPl7P9eW
         +ZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRq92KzCpAnSFGXNMHAS3TOvObEOZZDDTu5fM+mggWDnytvQ1l0H+ZH5xmVJQNJrSWm/0xuAWSkMFYzSCu@lists.openembedded.org
X-Gm-Message-State: AOJu0YzHMQgICxlL6w3fYYpC2cPxj3UcM7M6KoP/LX3KeuNJYOLfMebN
	L737PQwFwfpYWn80JcsuCW1wipxLDFExC5LigMNLt4kkN9CNAJ68/Up8vcq3FUrvGlo=
X-Gm-Gg: ATEYQzzcPjxHtWVrALMXAgQljNGJuyofFt9uNu0Ynkks505gy9bCegMrGQreSSWTy4A
	+pjMtqtPE5glwEAuot8IYETdAKwsyvyMjFbnyJSUG8sJOgC5E1epM35LlfFDBjXu/v+i/heVyZI
	ac9Ishxm4+HYi2V9Ljx6ZetIouYRrxfoTg0kiIRAm4PkSCRXz0hX1Afv841hE++DKNujEu99oC3
	ky9f8HQqQrh3Bu3721+ff7z3yt2SA/Z25cTj6z5f91wjrpnmK3YL6nlI1AadMoXfGHmAN4nk0Yi
	7OjAJtS+G1eqsBf2IsBU1MC+ZawTNjLClHSXKiAtbTYEUzC2DgLHPZq8r/kJ/WTscWJadjepi+3
	K0gAsd0DfWyvnqaY9q2/6mfyA+cwImSVtcJDTEp2T4nNq0b4OCfR1MoyyxMueTMCXeYMUhN8bwu
	AgU5/13dLzejsUUdY8YLJ5hJ0VFC+8vzSCC2nhyy1ZXFbYVe/662fw24IvX0KwPO/iYh4gePhkV
	/0sivT+
X-Received: by 2002:a05:600c:64c3:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48727d59bb9mr188998565e9.7.1774854596146;
        Mon, 30 Mar 2026 00:09:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ca:b2c5:317:d887? ([2001:8b0:aba:5f3c:ca:b2c5:317:d887])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069961esm164572535e9.12.2026.03.30.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:09:55 -0700 (PDT)
Message-ID: <565cf6848e8f3c0f9e626a61e27cb7ed482fe33f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/14] bitbake-setup: improvements,
 VSCode workspace generation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Date: Mon, 30 Mar 2026 08:09:54 +0100
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 07:10:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19278

On Sun, 2026-03-29 at 20:32 +0200, Adrian Freihofer via lists.openembedded.=
org wrote:
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>=20
> Changes from v2 to v3:
> - Rebased on master-next from 29.3.2026:
> - New commit:
> =C2=A0 bitbake-setup: Fix type annotation for descriptions parameter in p=
rint_configs
> =C2=A0 might be squashed into commit on master-next
> - New exception: bb.fetch2.RebaseError
> =C2=A0 - Adapted tests accordingly
> =C2=A0 - Simplified code in bitbake-setup accordingly
> - New commit:
> =C2=A0 bitbake-setup: catch unexpected exceptions and show a clean error =
message
> - Documentation
> =C2=A0 - git fetcher unpack_update
> =C2=A0 - bitbake-setup non destructive update mode

Sorry Adrian, this caused an issue on the autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/5/builds/3443
https://autobuilder.yoctoproject.org/valkyrie/#/builders/92/builds/3471
(and probably a few more)

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/qemuarm64-
tc/build/repos/bitbake/bin/bitbake-setup", line 49, in <module>
    def print_configs(prompt: str, choices: list[str], descriptions:
list[str] | None =3D None):
TypeError: unsupported operand type(s) for |: 'types.GenericAlias' and 'Non=
eType'

python version specific?

Cheers,

Richard

