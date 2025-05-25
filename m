Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13561C54ED0
	for <webhook@archiver.kernel.org>; Sun, 25 May 2025 07:48:33 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.5433.1748159305587962525
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 May 2025 00:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U+ZcSV4Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe574976so8923265e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 00:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748159304; x=1748764104; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCjm4VFMDCtUaxU7IJ0e3/iMuiCrvO/Xiq5jxUo8dY8=;
        b=U+ZcSV4Y/7PBcmt0DRcOF+tC8KaSDcflqARYzDA2Yu6D3CP3rNm3n7fET4eNlYj+7F
         p4M7NDZJrpU3url0dBrVMoJ/KENeeCTNAWx7D8C1C1LgL4hF4+8t26SQvmKtlD160Y7B
         WfpbfEXd8BOTDDWmwDbAzWR/mp7CHK2HRKRhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748159304; x=1748764104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCjm4VFMDCtUaxU7IJ0e3/iMuiCrvO/Xiq5jxUo8dY8=;
        b=wUVxWHq1NbQveoLU9wlIK7W02x8aP22oxUMxFCTytiaC2Z7z0Tx0F3TfQXj9aHZs9w
         J0uTGRK7wldoMhxJv9rQqJ1qqP0R6n33KWyB5zUfSwyC07XHFASX4pyLOyn2VItxYPg9
         spMtxOatDoSd63f1U/vzkQt0cusRNKl2sLs5hsR+7SYEBtDbgpH22U7J9xvQtWjYkAd9
         Wkikq/yt2AHAVwJfjeKvlVvcvXyqTNZH8Gc9YMh9ZKWkDJjvWmPT0H0XoL11G53DnJGE
         G3IJ5jA4uBipY0JjIsRedr3vLWrycZseOqkkvBr9QyM3BepYjF9qB8VhuWgY+NE5G7WQ
         ZM5g==
X-Forwarded-Encrypted: i=1; AJvYcCXBCVP6c4pCCVbffPL0Z04ZZnLiKfUnzKr+XbKIA4C4315KZUeioWQ+7fXFNsbEmX3+IvLiVJ93GgcJMaKX@lists.openembedded.org
X-Gm-Message-State: AOJu0YwMrbHFmlll/c4/Obm/bK/TNPPQb6/rFeM6g0vZu75tXuTOwaNA
	bSOQwMPgAH/+y7wAsQWoaKCMvrhUlUcMf5auiFYfkEQQQlJAW79sRE1+pyUh0y58ewU=
X-Gm-Gg: ASbGncu1c5GJhb8X/GVN5XXfUGBT5jrrJq/52jQDuNXlSCZ/62oi7WRndji3Ei13IqH
	lkX39iU64v7JXf6jBO/9qFkvOZuK5n/R+sSoOBpYIUE6veYsJoEKvbR44vnJSPNfU4NfOyC51eH
	boBzxI8pVfDx5hRBZ04Qfg4ZtOhxhlMT9Zvd45PyaimYWvBYiyrCZxUMJt8d8iYxhJPbDInAqpn
	Zum/U6u8pDEIh7IOeUmPQ59OZmvZ1MyNmtaDnfUfE3b0B0VgvkZaEzBJ3cbx/nbZv6WrQPW9nCe
	mW9l4cYtxpvLfOk9nUNk7xuCBNqvfF2ilQzBEkjwLg8TD3zDVXBrSOi0hAVAWLSR22zvnU7L1Ry
	87YJSKj9dmmUdf0hClZB4YKaKU3YJ/SLYicsG9dKejjaw20wJStI=
X-Google-Smtp-Source: AGHT+IEjGMWXSyWXNWVg1xQuVNrgslAl3h3w+fbDo5zeRqtCJyTmtyvuHr8eh9UHj+ZGE0gGE2Ghew==
X-Received: by 2002:a05:600c:348c:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-44c8ee86f59mr45388835e9.0.1748159303723;
        Sun, 25 May 2025 00:48:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:eeed:a623:5d92:7ad3? ([2001:8b0:aba:5f3c:eeed:a623:5d92:7ad3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44ab793a7d5sm110893495e9.1.2025.05.25.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 00:48:22 -0700 (PDT)
Message-ID: <4dbdecf888d3d81cb0bc81d172c45f410e8b5667.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Why doesn't BB_WORKERCONTEXT cause task hash
 mismatches?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 25 May 2025 08:48:21 +0100
In-Reply-To: <DM8PR12MB543079199282BB54BBB054B68B98A@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB543079199282BB54BBB054B68B98A@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 07:48:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17636

On Fri, 2025-05-23 at 13:26 +0000, Chris Laplante via lists.openembedded.or=
g wrote:
> I=E2=80=99m trying to wrap my head around how BB_WORKERCONTEXT doesn=E2=
=80=99t cause task hash mismatches. For example:
> =C2=A0
> # Recipe which depends on something that deploys .bin files in DEPLOY_DIR=
_IMAGE
> =C2=A0
> def get_deployed_bin_files(d):
> =C2=A0=C2=A0=C2=A0 if d.getVar("BB_WORKERCONTEXT") !=3D "1":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> =C2=A0=C2=A0=C2=A0 f =3D d.expand("${DEPLOY_DIR_IMAGE}/*.bin")
> =C2=A0=C2=A0=C2=A0 return " ".join(f)
> =C2=A0
> BIN_FILES =3D "${@get_deployed_bin_files(d)}"
> =C2=A0
> do_handle_bin_files() {
> =C2=A0=C2=A0=C2=A0 # do something with ${BIN_FILES}
> =C2=A0=C2=A0=C2=A0ls ${BIN_FILES}
> }
> =C2=A0
> (Yes, this is a contrived example, and in practice I=E2=80=99d just expan=
d the glob in the do_handle_bin_files task.)
> =C2=A0
> =C2=A0
> Why doesn=E2=80=99t BitBake flag this as a hash mismatch? Especially sinc=
e BB_WORKERCONTEXT is in BB_HASHEXCLUDE_COMMON. To be clear =E2=80=93 I=E2=
=80=99m grateful that it works :), I just don=E2=80=99t really understand w=
hy.

BB_HASHEXCLUDE_COMMON passes it into BB_BASEHASH_IGNORE_VARS and BB_HASHCON=
FIG_IGNORE_VARS:

BB_BASEHASH_IGNORE_VARS ?=3D "${BB_HASHEXCLUDE_COMMON} PSEUDO_INCLUDE_PATHS=
 BUILDHISTORY_DIR ...
BB_HASHCONFIG_IGNORE_VARS ?=3D "${BB_HASHEXCLUDE_COMMON} DATE TIME SSH_AGEN=
T_PID ...

which means bitbake will ignore it when calculating the hashes, both
for tasks and for the base configuration. Since it isn't included in
either worker or non-worker contexts, the hashes match and you don't
see any warning?

Cheers,

Richard

