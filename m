Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8DCD13DE
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 16:01:40 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.780.1762963289988970153
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 08:01:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AspD69eI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c82bf86bso639240f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762963288; x=1763568088; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20FQaACV2clcKWlfv5qj8vcGbtQpk4oz4ZBYV3ct0Pk=;
        b=AspD69eIRuXBFJlONTybhxe573nMw9wD9X8T6ckp/KNCI/+PeHby2CQ++oyK1G50J5
         Zk1t8jkB5Y4WpepBk40yuZGB8ra/GzM1cA2k8eMj8lR4XadpRqqlWDMlm7p1Gpv/nL8f
         QzIT+gqd4E9bKs44a82O2WCqW3TqQTi20b3I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963288; x=1763568088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20FQaACV2clcKWlfv5qj8vcGbtQpk4oz4ZBYV3ct0Pk=;
        b=ViMtRKUbbQCBRGrRLj3LtHFIVtEH6gdOv1cto4gTOHSsINzxnx5NCgipacSYXA9KP5
         jBmsIh0GMyd/HIcsbhKj+4EqtYDQazHrRNrWdvtFT/SLc2Jt6Zwsq6fB/kToRdsSJkSa
         YR9/T6q62zCMvqD/6ljVZlUOLsuuXfylyLfiWCnLsZMGV0wMBKvGRyma2RSie0rxFjCY
         CNB5b+pqpGCAk+FtjdrTDgmqzM4DkBRhb5I4nHNEAmCS4ilQqyca804tSmZL18WmguQP
         /eQPH2+D4ZgpL5Fv6RxOXyyeK8Qbxylto4KZ3/GSfzRuPkZT5VwYl/UMXxMyfk6n8UsR
         dbnA==
X-Forwarded-Encrypted: i=1; AJvYcCVNuoCePxsiw0rBoeeC6FwRUdIv9588b03P1SURnahtUoPU3uMiSljm5+1LOT+KRRFuac1H5pZA83UIrYX4@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx/iyokMNMXI9zUU9Sc+di9Zwvc/bCwx7TIkv0tN2GEjEkjCZVg
	LGHhewEEi/RqCukKT4spMji5AmDMTBQprTPn7cCNvr+ga40RBLGQqRrf6/E8a71l20w=
X-Gm-Gg: ASbGncsbylA9XcaPHtp2hMes4SyGuzSsZNSKEg+I+5OcjV2SQ6Pg9ldf0Jv0XJb1E7A
	4/9IKYEe4jM3wyyDMDQU3hA9phqfr1dSm959oLR0RSFAWTkmpDVfisVoIc7KVk/FnHpxHHYoLJC
	1CwiYr0ol4wPklbhP5VvifnrlalLXSIzeI9wWFpoy06ZQ44b7imn/Wglmkid2w+BZf4aI1KEUZJ
	0dVvqsCjJWktyqREZFNRNtjPa+jZvXr/+/DOo6tBIeAoD3R77qzOT4jKRQkJPDf43n978HsVdYf
	iZwIbXM8yGCFS5T/KrMl96k81yTfd3xN5SVGAT5hHZfO/HVqove3q/lu4rr9OZKCY0wDNz5Xqxf
	R17amCIfee/bhz1d7lioCMTxRlR05GGHTy41F0zb8PKr6DZYBB2jXzYU9j5rkUmXXmpA6IOKX1r
	1tiBmvpYNI4De1wInE63pCLgrmvgWS8aqylhHzKq7hczxMtiqVHhlrm2RKDW+VTYyo
X-Google-Smtp-Source: AGHT+IGeXWTQ51lhfj+Gn+QwGUv2wI2G3y3gA6/aJFLlgpw1YpjMqypNscVJOkkksyCm9GSCDrviNQ==
X-Received: by 2002:a05:6000:2891:b0:429:d6b7:6ba8 with SMTP id ffacd0b85a97d-42b4bb01da2mr2950931f8f.0.1762963287753;
        Wed, 12 Nov 2025 08:01:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff? ([2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677abeasm35493138f8f.33.2025.11.12.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:01:27 -0800 (PST)
Message-ID: <df39c2e5ee59060f170ae7e4904a72acceb73e57.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal
 fragment setting as default value
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Wed, 12 Nov 2025 16:01:26 +0000
In-Reply-To: <20251112055736.3078776-1-Qi.Chen@windriver.com>
References: <20251112055736.3078776-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 16:01:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18358

On Wed, 2025-11-12 at 13:57 +0800, Chen Qi via lists.openembedded.org wrote=
:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> In this way, users can continue to override settings such as MACHINE
> via local.conf and env vars with plain '=3D' setting.
>=20
> Fixes [YOCTO #16060]
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
> =C2=A0lib/bb/parse/ast.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index e6ff1ff76..f9d93aa0f 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -373,7 +373,7 @@ class AddFragmentsNode(AstNode):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
ginfo["detail"] =3D f"{value} ({self.fragments_variable} contains \"{fragme=
nt}\")"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # parsing=3DTrue since we want to emulate X=3DY an=
d allow X:override=3DZ to continue to exist
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 data.setVar(builtin_fragments[prefix], value, parsing=3D=
True, **loginfo)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 data.setVarFlag(builtin_fragments[prefix], '_defaultval'=
, value, parsing=3DTrue, **loginfo)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return True
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return False
>=20


This is a tough one.=C2=A0I've thought about the two sides to this and you
can argue it both ways.

If we do this, we will get questions of "I set this fragment, why
didn't it actually do that?".

I think if you specify a fragment and it should override the conf
files...

Cheers,

Richard





