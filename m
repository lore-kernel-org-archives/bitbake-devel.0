Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2DC5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 14:34:19 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13937.1787754850346424558
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Aug 2026 07:34:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KsbNQZcm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980dc26022so8349235e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787754848; x=1788359648; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gPZNS1nCLrrTETuVvesghet/a6oSWC4FaVeXsKXHQY=;
        b=KsbNQZcm2IVaRYIhVR7VeiHmLz9qQXbU8UUcPTAboHAfnvzQnvge8vcuKGkvAuL46z
         hmiK6d7o7wu3q02U86Gger3AcgIVO4STBtjaLBtOXTvAa9bQpbUqHsFPRG2G8dWsP+Nb
         1mpC9L439NRRdEbVbgEWkUjVKgZdyrnT9AqCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754848; x=1788359648;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gPZNS1nCLrrTETuVvesghet/a6oSWC4FaVeXsKXHQY=;
        b=DYjwkWQkCfMt7zX/cpf4T0feAofxiQeqJo1r1xIOFqow7rdVwgIfzul4lakeRw1b/e
         LPH4Agvc1cczRqcHtJloT0cOCfMtN04dPeX3dhB5DlrwAtVPErlwDRn6h/rPO4dmsBvn
         HNRCd61e5KHhSU0y3j8eFS5u3zXb7FxWcn7RNWpB680pSND5twf4SMNwM2PtPcC7cApe
         uCNQ2YyhAS/EPZZCF3jV94kUwD7iP35gdzuCQLVMsVDEdulAIs0bU9H5DLCZmxskmGsP
         pK5zqE9yj3qaKKxM8K92kn7VeMyAo4Usakj+/1yB25MQSmG2j8YgEqQuwNXlnQfXK6LL
         Yr2w==
X-Forwarded-Encrypted: i=1; AHgh+RoeE3C8/dJDu+PR0xRuUmFuSMgLZwLAI8NJQRukj10BIOFR4YE0Ir5equEaCENeaOeEmTATBeuNE4MZfpft@lists.openembedded.org
X-Gm-Message-State: AFuF++nLJXvSJijaFG3UP7D/eNrZ+rU8DUlRHSgOJ+P4S6sfcfZlMzCy
	pjpw0o8AlJ7Rylje1XFFvLD1ssWZpW4CxpvAV4gOM156JOu5YrSAw+aZTMue7PfRxSM=
X-Gm-Gg: AR+sD10tDNOhKKevrklGp9d8BaPwS8vO38ZxDatdWb8nJLgw4AzVlSUHyp2H5/iEEnn
	lWH4qCt7gB2FkZqa++1HgMmJzgsZ4ABH0ga1CzQbz68BoQJJosza36gX26XUZNh8Km+8dCgGD3n
	p6jflYYfarEUvOkfPZWfT646g1gdH6p/azPRHTLZwFTPR8oeGO7K/2Y4RDDk+3xXlrS1+bUQwbb
	9sT8QyiOb3PwL+T7BRSQG4xVPO68+LG+/Cvx8A2kYp6SL9ssF7x1UP0QpDi4xsnfej4BMiJHTW6
	nZTOoGeSncf61acJ+6o8IUO6jnWUlXQ0Rq2JZ3bV8MwlNFNpR52+JuncCvblxn2hF58pA7Qm0eD
	nJvzQIW2Yli+pI0qctRg3JLBg6pzNQ4jQVcagoA/m8naO0oYfaAFwQiBDGZ4OnEuiMg4+vAaDSM
	6n/4DVqTpHs/EpGGvSYPn+3kkJHkYDQZMtczIbgbQqJtsS9wuvoLtGXY4GXqG1ztBDC6ImrU1D7
	sOvoIoG1cSj+l5qCZ4qiH+BWGP1MqPQeBVktozndnBX041SDWMoJw==
X-Received: by 2002:a05:600c:a0d:b0:499:bdf1:7578 with SMTP id 5b1f17b1804b1-499dc6e9b00mr75217245e9.3.1787754848446;
        Wed, 26 Aug 2026 07:34:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e581:1e52:aeaa:4925? ([2001:8b0:aba:5f3c:e581:1e52:aeaa:4925])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dcae3216sm28383525e9.15.2026.08.26.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:34:07 -0700 (PDT)
Message-ID: <f7a6195f5b8b379f87370dc31b7a1fcbd5c95690.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace
 in parsed lines
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jaipaul.cheernam@est.tech, bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2026 15:34:06 +0100
In-Reply-To: <1880129.1787221871218113438@lists.openembedded.org>
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
	 <20260806112435.25128-1-jaipaul.cheernam@est.tech>
	 <DKNWRTWPZT8T.1ZLGV8S99L5N9@bootlin.com>
	 <DU7PPF66507B2D7DF3AD4504715A950243CF3DB2@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
	 <1880129.1787221871218113438@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 14:34:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20057

Hi Jaipaul,

On Thu, 2026-08-20 at 03:31 -0700, Jaipaul Cheernam via lists.openembedded.=
org wrote:
> Both oe-core and metaopenembedded serires are accepted.=C2=A0
>=20
> https://patchwork.yoctoproject.org/project/oe-core/list/?series=3D49858&a=
rchive=3Dboth&state=3D*
> https://patchwork.yoctoproject.org/project/oe/list/?series=3D49954&archiv=
e=3Dboth&state=3D*
> =C2=A0
> Can you check on bitbake patch.=C2=A0

I've given this one a lot of thought and also asked around the
community. The general consensus is we don't want to make the parser
this pedantic. I think it is fine to fix the whitespace issues and we
have done, but the extra complexity in the parser doesn't seem to be in
line with where people want to focus their time/energy right now. I'm
therefore probably not going to take the bitbake change.

Cheers,

Richard

