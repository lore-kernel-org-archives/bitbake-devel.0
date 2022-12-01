Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FAC47088
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 17:42:05 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.51151.1669916524275786051
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Dec 2022 09:42:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Twg8Hgb3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id q7so3919011wrr.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9g9QqNTFe+kxwAFeymD6MSRnYF0+gwu/h7XhxmGLU7Y=;
        b=Twg8Hgb37plTFbgGpXy7K1tVf++eEmDeIeV85jmrFPseBZG4P/4Qeo56wGvJb1jBGe
         uX1IQZx+OYmXRl4Pl1yf8sW2LUS3w0xwDGnzeYcJ/hEsKIaSY8pD3GA01+PoTVrgIulm
         yqhXCQWBujewScheGW2yxkca8SotnqpxnMcLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g9QqNTFe+kxwAFeymD6MSRnYF0+gwu/h7XhxmGLU7Y=;
        b=TEg7ikUp2aI4BZhV2HGG+MsI6AchBp6jKx50JXwjQ0RoO/1i8kHDZe+8kZFEBvLG1T
         dOVXidtRUy8tb4m2taQ7m4i8B7fYrl5SZEAJaMMCdSAWY8zuHymlRJt7uw2p1U9QzFBn
         1ZlFsAq0RIU6SD5xqDxH+uQHacRhDimS+48Pgi/8MdGFsuNVxxkwQE39uxvgESh6Re5w
         aWDsknRtmkNTsmjZ1TmcVni5N+22jiNm3yVo/M1RJL+oV034Qkb/3IAJHLamkQz6Uphd
         ypAhq/Yb6ri7WOAbvzGobb652JAXrJGDXcn1qggH40gMNPoqOZh7JEqPAFS7cxF7G3Of
         Mm9w==
X-Gm-Message-State: ANoB5plcl7Iov76mlhMe1PX2QxmE1v7v9tqB3FYK7jiLFlVEUYNAve9x
	58xqekYmmfXfUdpms4QcrxJh+Q==
X-Google-Smtp-Source: AA0mqf7kWbgPqDPSa/9w2OldnPU0aXPrF8pVHJVjISuuK+OyqF+TZUJx0Q6ruVMDbngj0iizNO2Wxw==
X-Received: by 2002:adf:d847:0:b0:242:e13:44c2 with SMTP id k7-20020adfd847000000b002420e1344c2mr15767332wrl.529.1669916522780;
        Thu, 01 Dec 2022 09:42:02 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3f4c:de93:c029:9984? ([2001:8b0:aba:5f3c:3f4c:de93:c029:9984])
        by smtp.gmail.com with ESMTPSA id x11-20020adfec0b000000b00241f029e672sm4911619wrn.107.2022.12.01.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:42:02 -0800 (PST)
Message-ID: <f2e0d6375c704510a3b10d7ef7a8bef6f7d6c951.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup
 bb.cache.parse_recipe
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, Martin Jansa
	 <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, Chen Qi <Qi.Chen@windriver.com>
Date: Thu, 01 Dec 2022 17:42:01 +0000
In-Reply-To: <a15e22da-3175-09bf-0199-4e0c047d1469@windriver.com>
References: <20221124091045.12018-1-Qi.Chen@windriver.com>
	 <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
	 <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
	 <CA+chaQeFjOD-=ppAj063EVZkd3v6E7J+1JQSY134hgg0LoT10A@mail.gmail.com>
	 <a15e22da-3175-09bf-0199-4e0c047d1469@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Dec 2022 17:42:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14128

On Thu, 2022-12-01 at 20:10 +0800, Robert Yang wrote:
> Hi Richard and Martin,
>=20
> I've setup a pure oe-core layerindex (No Wind River specific settings) lo=
cally,
> it works well.
>=20
> For Richard's question, where is the config_data from, it is from=20
> layerindex-web/layerindex/update_layer.py:
>=20
> envdata =3D tinfoil.parse_recipe_file(fn, appends=3DFalse, config_data=3D=
data)
>=20
> The error will be gone if remove "config_date=3Ddata", so we can confirm =
that it=20
> is from the line.
>=20

Thanks, that helps. I've sent a patch to the tinfoil selftests in OE-
Core so we will test this piece of API in future and try and prevent
regressions.

Cheers,

Richard

