Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDFC021A9
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 22:21:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.6254.1739830882566234734
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 14:21:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EXB5xmZR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f403edb4eso836631f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 14:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739830881; x=1740435681; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ap0RlIkpyEkFB5eiHEjzwJrUYukSqvT6KnH2FkV8weQ=;
        b=EXB5xmZR8/85j97x4c/nYV+4meioZZDb2sYIUBPmCPZyWHhS8ctkZmaOdSO1ZCwWmV
         1lesMgTVuaLe8F8+DVbw5odD6jCUs+eHG0TyN41W1kYwyPP4t4c5qsXKNEPql9lyAPkE
         rHSrvozt+Mjyxiy/V5+FUAGeRYnpf5IID/nbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739830881; x=1740435681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ap0RlIkpyEkFB5eiHEjzwJrUYukSqvT6KnH2FkV8weQ=;
        b=Fu/50FcgIoeRQ381f1G6K49KdlufT8XvlJ8B4lkUUsrVGaxDfBQ/OiOkVgjAUP8h8w
         K57zZpUA/RqoY/L6czWLd2tWVLNZ/PsMRSAJKIu60ouCey9Ibupk9MbiTpnYdpMVsF5D
         7qIZM6CMbVWC7Rub3YqbxA+8ZDFbP0Q88A650A3auV2a5MFTPEP5UNm4Tko6oME+SDce
         HR4x7F6vT31mE+h7Q2plr5gDY/xy0BXO1+/8Ut4Smdy2HZNAbPnXof7mQccaxZtujLLX
         Ben2oUVLQknzKN2PfmGHJScxbgG5d2z7y9XhRsIxcvv28RdDFL0nCA9Kiyx+uRiT/ll/
         Q8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/dCiprQtUWUUeECjtZk+XwNb1SRmgP2pdmb5znK/BkYLh7rK6xtktpzmCzoLyfa+Z7VyniL820QwG1bd/@lists.openembedded.org
X-Gm-Message-State: AOJu0YxxgadMSEsMuaxV8zBc3xOEOBO3IoJtBvBm5f3xVrkX/Epiz9qW
	UM3/JGi7U3ZF3XoNvznWVOwUskuT/JUIgziWIVSRhrRNmxUcFsPSlJ9RVuyaNUU=
X-Gm-Gg: ASbGncuhpxvhNN6px+bnEwEPDSB6mhGvz3+0KkYPci0SBPRYF47yMuw+Y77WD3oj5uZ
	SOvB8mcHcX1VhnOWy81QHXDcgtMcqxkY97CfQWifQr6HX7C+jBPRq6Sjjt97DfKLLVy7965N242
	cOzb+VTYKQyoG1iC0scaMvjIT2LQ5rNtFh2iP9EwPP2N+yxxqkBFYrzw1PGOECwtyLjFD6/g+lR
	17/L5XPjNk8WYRxfcULOHrV9id0YPmfcW9BLiYtAOzwMsEIebVBfSwK9hNMSeXR70FkWF0hnPAx
	HED6CIGk4fv9eieXSEB0XZe4N3lgoPvissAkpKELUSGk7lEtNdnItn7V//92zsRk/WOR6uzOPY5
	ozj2V
X-Google-Smtp-Source: AGHT+IF/RuhDOesH0/SiRYO7dYkwIaXDi781u4EZHvtDFilMgn4K5bcN7ztZoQo+XMtH/1Tjg5/YyA==
X-Received: by 2002:a05:6000:18a6:b0:38f:4f63:5117 with SMTP id ffacd0b85a97d-38f4f635229mr2195392f8f.39.1739830880990;
        Mon, 17 Feb 2025 14:21:20 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f127:df56:488b:353b? ([2001:8b0:aba:5f3c:f127:df56:488b:353b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd46sm13312998f8f.21.2025.02.17.14.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 14:21:19 -0800 (PST)
Message-ID: <9ea525464fe8b072e33e681d35dd20b230469541.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/4] fetch2/git: Add support for fast
 initial shallow fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan-koch@siemens.com, bitbake-devel@lists.openembedded.org
Cc: simon.sudler@siemens.com, jan.kiszka@siemens.com, alex.kanavin@gmail.com
Date: Mon, 17 Feb 2025 22:21:17 +0000
In-Reply-To: <20250214155057.1748020-1-stefan-koch@siemens.com>
References: <20250214155057.1748020-1-stefan-koch@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 22:21:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17238

On Fri, 2025-02-14 at 16:50 +0100, Koch, Stefan via lists.openembedded.org =
wrote:
> When `ud.shallow_fast =3D=3D 1`:
> - Prefer an initial shallow clone over an initial full bare clone,
> =C2=A0 while still utilizing any already existing full bare clones.
> - `ud.shallow` will be automatically set to "1".
>=20
> This improves:
> - Resolves timeout issues during initial clones on slow internet connecti=
ons
> =C2=A0 by reducing the amount of data transferred.
> - Eliminates the need to use an HTTPS tarball `SRC_URI`
> =C2=A0 to reduce data transfer.
> - Allows SSH-based authentication (e.g. cert and agent-based) when
> =C2=A0 using non-public repos, so additional HTTPS tokens may not be requ=
ired.
>=20
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
> =C2=A0lib/bb/fetch2/git.py | 96 ++++++++++++++++++++++++++++++++++-------=
---
> =C2=A01 file changed, 75 insertions(+), 21 deletions(-)

I'm left wondering if we should simply adopt this behaviour by default?
Do we really need to have users select the fast option? What would be
the reason someone would do that?

I continue to be quite worried about piling lots of different code
paths into the git fetcher and turning something that should be
relatively simple into something so complex nobody understand all the
different codepath combinations.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
init_cmd +=3D " --bare"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfetchcmd(init_cmd, d,=
 workdir=3Ddest)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfetchcmd("%s remote add or=
igin %s" % (ud.basecmd, ud.clonedir), d, workdir=3Ddest)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Use repourl when creating a=
 fast initial shallow clone
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfetchcmd("%s remote add or=
igin %s" % (ud.basecmd, shlex.quote(repourl) if ud.shallow_fast and not os.=
path.exists(ud.clonedir) else ud.clonedir), d, workdir=3Ddest)
> =C2=A0

I'd comment that the logic hidden here is just about unreadable and
should be split into two fetchcmds even if it does duplicate some code.

Cheers,

Richard

