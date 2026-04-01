Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4ED10FCAF0
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 21:44:27 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2930.1775079863987805260
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Apr 2026 14:44:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JInLCoCW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486507134e4so2044935e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Apr 2026 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775079862; x=1775684662; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGr6MYzrHlBaovCCZgZQzsrww4LFMhDCr+zwiRqT3ug=;
        b=JInLCoCW0T8qXHV2S20wVJ5btEXOtVenMxT5aGQ6XqS9GDoLMmaWhhuGXM+RNKb6qO
         3UgsH5XUdasjkw5uze1FWpgmumgJ4ybI3Fzaxpm5Bwq0HTAmRgXs+w1e8Vh4GVgv6/+l
         pwqatWLHJCovHKho2yAzDozNdbK5fTSZ1MPUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775079862; x=1775684662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGr6MYzrHlBaovCCZgZQzsrww4LFMhDCr+zwiRqT3ug=;
        b=ZAAzWJ9p6B31Zwn56WZGTp+zEbAsVea84rPB2SwbuC57CT1jHrR3pwNnPZDhhfoyb7
         i3fiXZGuzK8F3YdB1sI+MgnClMxTsVMo80Ui835Au/BdtxKON1dMRGJ9zA2xKy7M8dju
         XQaU/jUk1a1RbCV1tVsbZxAMvHCzsY7VRQsAa3FMV4/w1GAm65ZMZ9omE03qZlLwcLwA
         6z8yNjkQ3hgrY5PgLFgev5nLzZMW7GJXcUAtfcAnUhi9W3/mT4lepaoOBNsMURfCUU2k
         w82lsO3fm9i214EAkFf6TbXlTWyGUkeEQg+tCRV5TYkP+xZMUCh5IHyEAUh9d0iASsTX
         rK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZUp9Ilt/lGSE0UUHWPRBjAkXriIiGZh3irX7HsUsGgTDl2GznbZ2ANZrVkAW+iUy0+FUxxmYDEXkrHYKo@lists.openembedded.org
X-Gm-Message-State: AOJu0YyIi1MxvCGcNzHrFR+iFgm4dHmOJemWIZ69AMn/2hDd0yHQejD2
	xDQ/DqXg1bKXxzueJ5fJqtGFsBXsTWodZiL3pNuhE6PkvZ6MqC/buHSbZOfP8Yw+oLc=
X-Gm-Gg: ATEYQzwbVmWXL2QHQO3btg5K0a1XYwPd3zbiJL0moha/GngF4cMFGHfAcWzYE4n/beQ
	3Qxw8zkgHeNbDPxJ6s8lq+mTws9ATvdF18Vc5Vo98a6z/4bCqDXaAV/i5ezYyY/q1L8z3TV7i7y
	/5RGHta/K7BMF/UsMw3ahqsG8GYxReYxGIYJ4joGnUmwzKD2tExPbBqqfrHph8N9+p5GGt8FeAZ
	G03qQepPuAnqQzi+bFo5EwAiqJ6JlvaStV7u2KrpmghPBm+sxp35G65Q2rj40YocRX+F2/lqCWV
	dHmmnEzhz7aSsIvHVWc52mKhB37vHsS9jcNAIILctsha5SlkYBpnYfr+c/+YN6HF6kA59mUDjhA
	Ev3pf7lvoerH2YzQV/Rz8y6XZs0mowtp+FfeDDsXcASlVEO9wra2l9IsgPH6QezG2E/YAJ9VZmI
	glZEL7LE7H8Qac42cELl57Xk/ZtmzwvJhK8yWdbwl+qarFzEMGLkz1X8JawUQqyuFDyd3pK2cgo
	kHO4nCd3qCYWaHK
X-Received: by 2002:a05:600c:450f:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-48883569dd5mr87033645e9.2.1775079862340;
        Wed, 01 Apr 2026 14:44:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d91c:a3aa:733d:be2a? ([2001:8b0:aba:5f3c:d91c:a3aa:733d:be2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5468sm2977902f8f.13.2026.04.01.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:44:21 -0700 (PDT)
Message-ID: <fc03b4e55fe901ef7b5ac103340e929af8edd5af.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 01/13] bitbake-setup: Resolve unused
 loop control variables
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Wed, 01 Apr 2026 22:44:21 +0100
In-Reply-To: <20260331160703.3137930-2-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
	 <20260331160703.3137930-2-rob.woolley@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Apr 2026 21:44:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19314

On Tue, 2026-03-31 at 09:06 -0700, Rob Woolley via lists.openembedded.org w=
rote:
> The ruff lint tool reported loop control variables that were
> not being used:
> =C2=A0=C2=A0=C2=A0 B007 Loop control variable `dirs` not used within loop=
 body
>=20
> Adding underscore as a prefix helps indicate that it is not
> being used inside the loop.
>=20
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
> =C2=A0bin/bitbake-setup | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index b02cbc2b1..304fbe6cc 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -134,7 +134,7 @@ def commit_config(config_dir):
> =C2=A0def _write_layer_list(dest, repodirs):
> =C2=A0=C2=A0=C2=A0=C2=A0 layers =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0 for r in repodirs:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for root, dirs, files in os.w=
alk(os.path.join(dest,r)):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for root, _dirs, files in os.=
walk(os.path.join(dest,r)):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if os.path.basename(root) =3D=3D 'conf' and 'layer.conf' in files:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 layers.append(os.path.relpath(os.path.dirname(root=
), dest))
> =C2=A0=C2=A0=C2=A0=C2=A0 layers_f =3D os.path.join(dest, ".oe-layers.json=
")

I'd suggest just using "_" alone as the name as that is how we do it everyw=
here else.

Cheers,

Richard

