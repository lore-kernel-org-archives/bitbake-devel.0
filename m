Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB06C61DC2
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 13:04:55 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35928.1787835893260618529
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 06:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Aye8tbfg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c197e7e4e94so336361466b.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787835891; x=1788440691; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zAQgAXsoC9KFY3H40BosAExfJWzvjVm9zc77sH+IWr0=;
        b=Aye8tbfg2otRq9jxP8X2hWaKQeunI5smFkR/+OdBAAQ5/r6Cf4FefHcdJVvCEMIw/e
         9eQRjMdw28zR4gzJCtlrejlYhW3ubtjQcpe9ozB+DOdtmN6uvBej0mA8VMF655Oj05sn
         NOVAIbEJwvKLn2JcPIQNV3qGkFVIBDsjCYyeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787835891; x=1788440691;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAQgAXsoC9KFY3H40BosAExfJWzvjVm9zc77sH+IWr0=;
        b=HPx4u8OqapXmSOOouwKm4OiVOHKvl4mEU153UPI+/5IQQ14ntXwTsYIvHoXY0r63lM
         Yw+OJobr89Fy4RrvWR6FnoJ/RF2HR1XPk0eHTew6OrX8iaAJF1qn6Cy9AZ/YOcidipDN
         a/KLewkeki2auzDDdHnj1+Bnf+Lj4wB8759bVDL/2mlXRD+e+uf2xCAopl3kjhIlKvK/
         20rsI19SWVcYq149nDy2pUPiKbTTObK7oKVAgS2BNVC/jWICQ64aQWTIxZkEhPIcrvuB
         IZuVbHq4aEWIRBt26Tu5e70ccGktGq0XWT3vqST10P2kuuHKaBKRqrP28vJTkM0ly9zJ
         7qzg==
X-Forwarded-Encrypted: i=1; AHgh+RoiUXoFrDpIYIP2n9Z44kh9Ukm7QRfLlqCtjEovS2MmgwClh1YQV5q60nOp8PNaJi77vAI4fou9ZRt5iRCT@lists.openembedded.org
X-Gm-Message-State: AFuF++lVS+KCphLyK0qxASDMQ0Jx89cJb28PIY5kTRnpat18FvAP4bmV
	HR2e18B8Ml/mZB33L6HLKQUZsRVodgMIuZ3uMZyxQwkjcdrRmVwW4jSt1p/HSZCn25s=
X-Gm-Gg: AR+sD10eL0GcIDh/zg1mmf30DKKKo9QDiPw9erxmnktt6etZbCt0bZcg8Jf8xS8O9ph
	o2X/AKApdXBYb3KepWwuQWofwkQpRbgncWBo8fpPmTTVM9jZaiDobvNiT5PtmsaNK3ZQ1fcuxbE
	Tlf18mfozC+wZS5XV9X+Zhwq/GaJ8vG66omT23jglHP1nyadN7THGUI/GZcVKvOTFOfQDpSLijL
	c9/WnkVn/r6br1oEkK2GlZysHb7X0rCHA0b03qSVXYK127pORl3NCPG1fp8jGgO5X+/E2BpN0y0
	HDwRPSJ10nAjgaM488kPmJFDu7sQ3pDPLzb/XpWLmlwAX8+Q9fTLcGDYkzzQCbhcNNXix2/a77p
	71HpWp8QWRBAhi5O7iv5TF8cL75Kq2aHGYYSdKdKvrhO05fsON1f8a726LES1t67HdLOAt4yLxX
	q3/b1Pg5cdS+1gKju1mNoEtzlWdhiHYBs/6oOIU1giIXUSADKeshIImeuHeYrbInYlRK1AMK+f2
	LMeoiK9F0/hB0VCUEUlhuB4Xc0e1vl04q3h5fm80jPReAL/XoM=
X-Received: by 2002:a17:907:72d4:b0:c24:8a09:8195 with SMTP id a640c23a62f3a-c250bb7f3b1mr1467170266b.3.1787835891378;
        Thu, 27 Aug 2026 06:04:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:297a:6cb9:3a6b:fc8? ([2001:8b0:aba:5f3c:297a:6cb9:3a6b:fc8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a72d6dbsm659247766b.24.2026.08.27.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:04:50 -0700 (PDT)
Message-ID: <d96b6f1d53837a5ca7cc66c4570a20f7011a8947.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] knotty: Hide 'Bitbake still alive'
 message with quiet>2
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rouven.rastetter.ext@karlstorz.com, bitbake-devel@lists.openembedded.org
Date: Thu, 27 Aug 2026 14:04:50 +0100
In-Reply-To: <20260827123925.633743-1-rouven.rastetter.ext@karlstorz.com>
References: <20260827123925.633743-1-rouven.rastetter.ext@karlstorz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 13:04:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20067

On Thu, 2026-08-27 at 14:39 +0200, Rouven Rastetter via lists.openembedded.=
org wrote:
> It can happen that bitbake-getvar takes a very long time, probably due
> to NFS locking. But even with the `--quiet` flag (which equals
> `self.quiet=3D3` in `TerminalFilter`) the 'Bitbake still alive' message i=
s
> still printed, causing errors when using the output of `bitbake-getvar`
> in scripts.
>=20
> This change silences the 'Bitbake still alive' message for `self.quiet>2`=
.
> ---
> =C2=A0lib/bb/ui/knotty.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

The "still alive" messages only happen after 10 minutes. Under what
circumstances does bitbake-getvar take 10 minutes?

This message is really designed more as debug - to give an idea of
where the system is hanging, or an idea of things being alive in very
long running builds. bitbake-getvar shouldn't be hanging on NFS
locking?

I'm just surprised/concerned this patch is even necessary...

Cheers,

Richard

