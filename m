Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5219C53209
	for <webhook@archiver.kernel.org>; Sun, 26 Jul 2026 20:12:00 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16860.1785096712194852907
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jul 2026 13:11:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SchxAiCL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so1249055f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785096710; x=1785701510; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1na09e2GmbCzQh8pBl9VX4CEhQqKN0mIT2JZC3pGpL8=;
        b=SchxAiCLqelE3AOLoak6o2Kg6rOtgoNymzjwu6T9eo0qNsYAQB5JC4ly1NmGKVP7OD
         CzSfrANndIxe/Ym+5zMB2SdU/V3/Wwcgm40eQZpNxgNduFe3D+V/iFqJ/Wq7Nv5fOBVO
         QmVKHX3mofBKdPeHAJgH8sR76TuqMDjztmyJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785096710; x=1785701510;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1na09e2GmbCzQh8pBl9VX4CEhQqKN0mIT2JZC3pGpL8=;
        b=XTQCRwNt5WHe74g4ppi9uUQDN/cBGLE0C6yMpFfVfh8APzyO9mkzoUi2M+4ZeXcQ6N
         EfMe5zHjAbIvNI4QAbJ/xYjKkWRycKj0MghyG+ZE0Mo/VDpMG80TYEKSarlqICN3pF3p
         PDjFxGvFKO1QwhqWftwgmQNV1ey8KkWpJjabiz7ZLx+iSaFAtwMhHBibBl+ZmDDm2Bv3
         A7/1oWhtH8Vh/tIzgIbs839RMVbKe4MPglM63E4hlCLK417+OKJoBk1vYWGEUd17jvUV
         CDjS9HnHyv7m9cq1uuALubeNwy1/KnDV0B0/wRHfbqX/aijUsawBblB61BUOALVDtybn
         nYyw==
X-Gm-Message-State: AOJu0Yx25nF5YTmyAdc/40QrjmssLBUVcggikMfMd7LImfX60zJpeTwr
	5vxSyjXIjCH+isCpFr0o7VG9SDXH91ITg1/P7Os0dsWh5VcuxI68Kqxs8/gKOc6MI5o=
X-Gm-Gg: AR+sD13dzwK0qvxRkmRTfzd+2h9to/3Jk74f+CFg6jB6UrLttSd2Z1KJVRIntOKwyYu
	+x6DPP51SjhDMWrw+byl/GMiB7Q7rBo4EbpGBIErSNXx83/ctYZmlbJIRXxThSFZeCXj/q4G35G
	PZngbJmbIE+3DfjNcmtT9H1zwqYCptRuwaGImwzrKtszas6L1DXRJEssyUCQMIESap2SqXc2PTH
	kvD4A3Uf3Zy92IcU20/R8APPddq4B/ethwXmw/ECf8d9akbgTKWWCqlg/EIn8GUPCK+7HiGBhvg
	I8hIaEX9vBp0eaCgwzoeNAgf5ZVnEPjK/JICkoP9yvFxMKlN8tLaaghFRPTKEMupaKAXiTH9QSm
	lv2OPCUphZh+o48potGf8nbbN4mDJMlBDEmZxXJtHCqIDhWhrpGGEqUVvngdaeZL88mxXNzwe3T
	4/QqZ9jIYd0jd5sT4y3y54bEAptvPBX7mmVSqwLxdbgnC5aL6//hl6OAKPWCRqQ39568c=
X-Received: by 2002:a05:6000:613:b0:47f:903a:5eea with SMTP id ffacd0b85a97d-47f9fc89cf5mr7306228f8f.4.1785096710324;
        Sun, 26 Jul 2026 13:11:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a3ed:a478:dbfa:c28f? ([2001:8b0:aba:5f3c:a3ed:a478:dbfa:c28f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm41638260f8f.33.2026.07.26.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:11:49 -0700 (PDT)
Message-ID: <31e8eeb405240dac2aa53d750a5253e55e6eaabd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] data_smart: fix operations lost
 when an override name contains a variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Minh =?UTF-8?Q?Ti=E1=BA=BFn_Nguy=E1=BB=85n?= <zizuzacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sun, 26 Jul 2026 21:11:48 +0100
In-Reply-To: <CAH9t78za_ncy=tnBv--DFqBvsxU-VCX8xGZaj_P-ef3PGvircA@mail.gmail.com>
References: <20260725143002.23596-1-zizuzacker@gmail.com>
	 <20260725143002.23596-2-zizuzacker@gmail.com>
	 <dd3a79ae52d3d42959ee98c1b6e1d3df4c0a2dee.camel@linuxfoundation.org>
	 <CAH9t78za_ncy=tnBv--DFqBvsxU-VCX8xGZaj_P-ef3PGvircA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 20:12:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19864

On Sun, 2026-07-26 at 21:53 +0700, Minh Ti=E1=BA=BFn Nguy=E1=BB=85n wrote:
> > I think this is because expandKeys() calls renameVar and then
> > renameVar itself also calls renameVar() on the same element, which
> > breaks things. [...] then I think that resolve the issue?
>=20
> Yes, it does, and it is the better fix. Both keys are already in the
> todolist with their expanded names, so expandKeys() can rename them
> both. My patch only worked around the second rename with expand().
>=20
> I tested your diff on a fresh clone at c251833d2. It fixes the exact
> form from the bug report, :prepend and :remove, a conditional override
> with no operation keyword, several variables in one override name, and a
> variable in the key as well as in the override name, all of which fail
> on master. bb.tests.data passes, oe-core parses clean at 952 recipes
> with no new warnings, and both v1 test cases pass on your diff unchanged.

I have to wonder whether my reply is just being fed to AI? :/

The project's policy is that AI use isn't prohibited but it's use
should be made clear...

Cheers,

Richard


