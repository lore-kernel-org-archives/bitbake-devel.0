Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC036CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:49:14 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8127.1779965352097222462
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 03:49:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=iRhGHcHB;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso68210585e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779965350; x=1780570150; darn=lists.openembedded.org;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlPobEsgtN4I/0O4RIidFNg7N1DAS+S3IjwV5Hek1Ac=;
        b=iRhGHcHBkLf16DhiGzdR8oKuWvA7gFIv5RT+tQSfJSb1RqBr6pVD8mXtX1cugOl7L1
         6/vTqxjV0fcG0C+DJSeoXE/6Sjdwzsczk2nk6365JLJacLekqNOVG1hcpr0Go5IVzK5t
         2kz9SY647vSxYJUBSJ21f9/SBK9mJ6h3TyMoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965350; x=1780570150;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlPobEsgtN4I/0O4RIidFNg7N1DAS+S3IjwV5Hek1Ac=;
        b=S56BP+cPZ8Ds2N1gKq4UpAk2qz3IF6MfI9UO0yrad7VshvQyA8xlR/C2OKyJHNydo6
         AhNFh9rzcjmbCuvXKx3xGZyuj9oyAPr7FY2pO4/vF52Tx0TuEtod19vn928Cv6Zk438+
         TcRyhU6vco+t6o5muc+xIOXCGgQ0nnS9TWEV4AYXWD/NDBZAaCtr9CyViXdDnHntn/9O
         C0Nt2jI0Rh1W2jSRk0LYw4XH/8m5Nz7mIarIhvVmM1M8N7PFQM0VpwGk9Uy0q2yvJKqp
         Re8f1uzBZWFHPSmthQdgEr0NEA4bcq2cnOrKEu92zasp4VKiwgWtHEpnRMpP4O5X/RQ6
         LwLg==
X-Forwarded-Encrypted: i=1; AFNElJ9eLJBWeKN1aFicfAD2F8751SBzpU2lukdHs0aEZQTklBGs+9HgvGzWpS4GQMR7xZ21Hlo38P0LXqh49V0p@lists.openembedded.org
X-Gm-Message-State: AOJu0YzqTh+qgtL1OAAOcCRzpm0wiDVhI1RyC5GmBZA2/k2Lq1SW1UdH
	4V3QzM78Dk8O6E4/uKxdwCy9MF7oqtQyOClikUJpnQ/ZO0BZHaVPPQZ8I+MtFsQe/YQVD78gsw+
	C2/h9
X-Gm-Gg: Acq92OFp5jajlfjlxR0IIuNOeq8H+Q/5DAtr8AB92HzKRmj0gJCp1Spuld+rtTJvQP0
	usK7wB2T1CzaBeHk66ya8h4Ac1Y/Ee1GtUpkCLA9pJbu5wjEFdcNxk6jt4OoieUsncqSGXYsF8D
	Qt4x5NEotiYk1ADFLvPolARj93H8au2DgiQi/2Ut/MFM7gRI9c815V+7HRayEY62u7bofxdKUS7
	8lu1cOw5c2jkG31w7sUsoTVVElwFF7j/FlatdzjQqvYaagRNpqVar7fJXAALyFagHy/HFlbO7IU
	WLa6nHuYOQeghLD6LLaBdF/brd66RjHC3Q+iwfOwRhuIusWtgdZ4jRNkWxKkZy8WO0G8WIpZk8e
	XYiPcH+9p1KWoNdQDQuauDgL7sdSwBYwPsaCjZQOlgeixkr86Sol9zKL0olw3iy3FZJCBU2I6Cy
	r0R8/6NzHNQua8wp6VE+dLm02jF//zhi+8bhLs/2hjOEInwALQq0/KvruXtAcCsuvDOLTJEkv0Z
	NeFWxnLR8V5SsFRFToMoeG48g==
X-Received: by 2002:a05:600c:6296:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-49053212604mr345890095e9.20.1779965350334;
        Thu, 28 May 2026 03:49:10 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a817d3sm39124585e9.10.2026.05.28.03.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:49:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 12:49:09 +0200
Message-Id: <DIU9214UKMGR.2QAMKYRYU3VH9@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 5/9] layers.schema.json: Add missing
 schema
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-6-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-6-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 10:49:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19555

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> This resolves the jsonschema error:
>   error: The JSON document is not a valid JSON Schema
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

>  setup-schema/layers.schema.json | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index f42606941..2c192c8b0 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -1,4 +1,5 @@
>  {
> +    "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "OpenEmbedder Layer Setup Manifest",
>      "type": "object",
>      "additionalProperties": false,


--=20
Yoann Congal
Smile ECS


