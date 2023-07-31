Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB8C001DE
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 14:18:48 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.8585.1690813120752238526
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Jul 2023 07:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G42JJvRn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so4812362f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 Jul 2023 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690813119; x=1691417919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/CM12q4oNs2ZKr0Fz/sth5KGzZlHhX3mC4c0iKYLWw=;
        b=G42JJvRnvmKA0MU3Pa8vljWEFw84PEjdk13ZrxIrcuLkzthZ9CDcHLxRIJQ9p59t6e
         Q7kTnrPfUZIUIsCPsD3yIChfv2wJ8nCwvelGX5C/yW2eE+ki+6epHo8PlJeADxTOay2Z
         3hjVDkdm+GgWFj/E2O6vGE0nIxxD4BouY03js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813119; x=1691417919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/CM12q4oNs2ZKr0Fz/sth5KGzZlHhX3mC4c0iKYLWw=;
        b=KZ01HFURk9DfSfejt2ifd/ox9mcXbrOykhXWN1FN+BPr5DzRTd08HiMn1h55k4dFl2
         1nLwxnb/YytLaUlSUEqhy3Q9SmDVSPvbFNi1Ack21c616PE3O/sLqMjQMSLBRQBzShxH
         iguI07tTCMBcqhCGIQzwxY9CfvHjAVkNifu93MuJccP8/eICagA1+tIc/GCTsp7ijZUB
         5q7+bRzei7r5zvp/dCsp0jhNy3BJgk+3mhYPiNnSZFm5ciT3BQK/L/Gc+6y+BAs1ird7
         sXLClJagfCP2CpON7r3dgaXTjdEylgdjSX+W2eR1yYeDtUoTj2drcX4eK+Lb4wS01NdA
         v3/Q==
X-Gm-Message-State: ABy/qLa8brtriz2xKb23Bs6eLGicP0RvA3rITuRiFfPlm8nXmSgGh94U
	hhEpJT8vMjbA6jiObHwhPuNaaQ==
X-Google-Smtp-Source: APBJJlEMfwm/4h8VeZOrlCMC8b6oUKZO09FhANXJ+tpnSfUPv0WQa7o/uxg9t3E1NATjkOF3V5DL4g==
X-Received: by 2002:a5d:640f:0:b0:317:5d1c:9719 with SMTP id z15-20020a5d640f000000b003175d1c9719mr9354156wru.9.1690813119215;
        Mon, 31 Jul 2023 07:18:39 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6f93:b696:bedd:c076? ([2001:8b0:aba:5f3c:6f93:b696:bedd:c076])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003144b95e1ecsm13306079wrm.93.2023.07.31.07.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:18:38 -0700 (PDT)
Message-ID: <de7492b54d81991ddf837c2feca7cb0e335d4d0d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add Google Cloud Platform (GCP)
 fetcher
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: eekmecic@snap.com, bitbake-devel@lists.openembedded.org
Date: Mon, 31 Jul 2023 15:18:38 +0100
In-Reply-To: <20230731133444.713728-1-eekmecic@snap.com>
References: <20230731133444.713728-1-eekmecic@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Jul 2023 14:18:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14896

On Mon, 2023-07-31 at 06:34 -0700, eekmecic via lists.openembedded.org
wrote:
> From: Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com>
>=20
> This fetcher allows BitBake to fetch from a Google Cloud Storage
> bucket. The fetcher expects a gs:// URI of the following form:
>=20
> SSTATE_MIRRORS =3D "file://.* gs://<bucket name>/PATH"
>=20
> In addition, a GCP project name must be specified using the
> GCP_PROJECT_NAME variable like so:
>=20
> GCP_PROJECT_NAME =3D "my-project"

In addition to Alexander Kanavin's very valid question/comment, I
wondered about this name. It means you can only have one cloud storage
bucket enabled project wide. Would you expect to have different gs://
url namespaces in different recipes?

In other words, should the project name not be part of the url?

Variables separate to the urls tends to hint at API issues.

Cheers,

Richard


