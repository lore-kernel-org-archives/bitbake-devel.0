Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A85C5518F
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 10:28:01 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13442.1785839272440078578
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2026 03:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MFohUdV1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso2868625f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785839271; x=1786444071; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MDTGJbKC1CZ8+sT206UhdnzL2FexpHE+Ajp6TIT3I8Q=;
        b=MFohUdV116YBQmO9AT7A+D0X/d37jPfCJatGZJXtgLw0gKGxiiHpCRWYJpeEQ5bVXf
         lHtXptClIxFMgirji2dD095DHPQ9W94qhaR/Sn8Y43hZiqgG+WFzMpVHKkb4Ry7UONxj
         YPgOGadaqDN2WMLN8XLDDIAEO8jN9WEas/qig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785839271; x=1786444071;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDTGJbKC1CZ8+sT206UhdnzL2FexpHE+Ajp6TIT3I8Q=;
        b=qKt+BirWuOBabb867qdxCXOvyAWrWj3XUH4pNfaObZXG5gDtOI4U3VLtEefJwcITv9
         AZd/1AJqrjNqiG0AnCnmWzLIP9C/ObsOjifpCtgYjsSFp0UAOyrNdfLVZx9F7AGld+bp
         oRFOmmz3QQurQ2CYfbu3PzpgB17OzykFFHPEZGHragyjflPDd/hiMwK/iTLBN2yzaMb1
         cCIjJW75dYNuIbg2ajxcG5F3mlYIWTfAcnqGey09Md4OW7i0nQsQE4y7T/1ScVbS7EWO
         VKFA1+MmTut581T7d2a1xV9DvrDoPTXwiRX6ejYWGd6IKz5xsYJ6x6aYeibIR631fGEs
         W42Q==
X-Forwarded-Encrypted: i=1; AHgh+Robwww4ltwAvcxZwRaNV1DoscV/vUBDZop5HqyPMRqdbTgKjtNGhk16BFR+v9pQrJ6tj0A8XzoFxrc6+33y@lists.openembedded.org
X-Gm-Message-State: AOJu0YxaM2w7wQAPbZEBO9eaEAvWcyCkd1BMBDE59PuXJ6k3jOKOAxhH
	euLa81sYyqYp4ZCGS7oSujBezXllH2f08+CB9wKIeQJDv5KNpsKkybAS8GAzP9V5pHo=
X-Gm-Gg: AR+sD10ECt0X6LlChFxDhbx9ya7yqeUqU7KyrqH8xgEB87yQlVO0HVApZC6ZnpykefH
	KA5ACcx36v9KCxt0MXtj1YbqEpev+HwuomGQZgXIEV7I9uQ8VM5Z4i10nPUrJAxqbJZm46AL/bQ
	4+FPc3QjHXvw/L3F+x9Z172wnhNV1PHPeuewpDoKOdhZPalVSQEfBqIvvmu1k6OFmUTMxeBCWHm
	FLXH5VPum13nzzo9EcjQE04T9jHx8U9k34VcEGuppdPyZjsnvHjR/WpJXmHD08eudi0nYGJFDkY
	b/ysBLUSbr/UcXkiYPMwU7/44pBgmZuny/Yu7A8SmhywpGlKHg2EY02/U9MtRXESWDRInaV/CKE
	pJ03EJ3vAEv+eZAhPcJZct79gEkDHwm4zsbJYjHVuMa9p2jXP6qZ4JirRjqINqyU1EIc1WFPGYz
	7VbrIwhqF1lG2fjfMK3S8OxrjpQ654D33XGsoZBGa6txd1WIZtx2XQSeL7liHFvEB1cRl2AeYEC
	4LDE7gWmvxJNBS+cdSQH8+V/aEfKbPi0X7isYFwu9SKdhGQasRL+w==
X-Received: by 2002:adf:e781:0:b0:47f:4ac9:98bc with SMTP id ffacd0b85a97d-47fd72c68aamr27801178f8f.24.1785839270580;
        Tue, 04 Aug 2026 03:27:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ce15:a763:9e16:7bb4? ([2001:8b0:aba:5f3c:ce15:a763:9e16:7bb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6besm39935640f8f.22.2026.08.04.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:27:49 -0700 (PDT)
Message-ID: <056c55ee98f7d48caa6bf45152cd63115b9d3132.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: warn on trailing whitespace
 after line continuation backslash
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jaipaul.cheernam@est.tech, bitbake-devel@lists.openembedded.org
Date: Tue, 04 Aug 2026 11:27:49 +0100
In-Reply-To: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 10:28:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19898

On Tue, 2026-08-04 at 11:08 +0200, Jaipaul Cheernam via lists.openembedded.=
org wrote:
> rstrip() is called before checking for backslash, so trailing spaces or
> tabs after "\" go unnoticed. For example:
>=20
> =C2=A0=C2=A0=C2=A0 file://foo.patch=C2=A0\<TAB>
> =C2=A0=C2=A0=C2=A0 file://bar.patch=C2=A0\
>=20
> The first line has a trailing tab after the backslash that is invisible
> but ends up in patch context, causing patches to fail to apply on trees
> where it was cleaned up.
>=20
> Emit a warning when this is detected so developers can fix it early.
>=20
> Tested with bitbake-selftest:
> =C2=A0 $ python3 -m unittest lib.bb.tests.parse.ParseTest.test_parse_trai=
ling_whitespace_continuation -v
> =C2=A0 $ python3 -m unittest lib.bb.tests.parse.ParseTest.test_parse_clea=
n_continuation_no_warning -v
>=20
> =C2=A0 2 tests OK
>=20
> Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
> ---
> Problem:
> Ran into this while submitting libssh2 CVE patches to both master and
> wrynose. The libssh2_1.11.1.bb on master has a stray tab after the
> backslash on the CVE-2025-15661-3.patch line. Patches adding new file://
> lines below it applied fine on master but git-am refused them on wrynose
> because that branch doesn't have the trailing tab =E2=80=94 context misma=
tch.

This seems like a lot of code and complexity for what is in reality quite a=
 minor issue which
whilst annoying, doesn't actually break anything?

Cheers,

Richard

