Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57239E80AAF
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 14:14:53 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.18223.1695824089000160589
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 07:14:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TGoJvC2f;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-405e48d8cfdso50845225e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695824087; x=1696428887; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBxwJv5C3UmicTxP6xm/Dw+uRhgX3KztxyR04ncjmVw=;
        b=TGoJvC2fXWO9u3p+yRdAtnbMeSCaFt+kekDIQPCEYd4Hb69f4oPwFA340iQiOLSwom
         SEuGMyTUCSX2hO9w7v75of80NYkMlXQW3Cv3vB/CTdljJPUXIYpC+OByUUkzU+A6a63i
         PtrNThtdObBkggnQVzyMeKDKi4E9xq6jmZLXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824087; x=1696428887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBxwJv5C3UmicTxP6xm/Dw+uRhgX3KztxyR04ncjmVw=;
        b=qwwRTeplvNr87l43+4X3G6Wc6b+DrkBxVdA3ZV3jNLsK+lXc/PGN5Nyc8J4xkrMSvt
         0f/iqM/vykHC21zi9vpT6us7ln6Of3tg+Cm3lsjyIrjQ0m/JjMaiu4yVrHrNzVFXnmSK
         Vy5cHwYk+rQXP1oIu3tN8itfQx/pCCWfjaiCVKo2p+1LNyL3ev16gGPfZzN/fHidVd2I
         hoa0Xqsk5MXTVR8c8M4yVB/idDFzkLOA56A8Ig7pEgGBfORF1Ah+yg7JpjPg1e7HQhN1
         qbeyfjfwVGSHNgWZgqvyt5i/Pe9LTSfr8q8UwHFoZ5y2XV4l7fDIc48qkBwlVAfxrwXp
         +U/A==
X-Gm-Message-State: AOJu0YzFWgZ6GmlCR1tqxVUrWu82LOo/QkHHx4DmnyBT6C+7K8OrfH0S
	bdyXUPkDtC17olqsl5qrS1DEgA==
X-Google-Smtp-Source: AGHT+IEiHnwxyt1D4oXKxHL69TeZwPTfwOxXO7J4/Sz1QSF527rnsc4WyzqJg2mn8H6garW5BVQ25w==
X-Received: by 2002:a7b:ca4d:0:b0:401:dc7c:2488 with SMTP id m13-20020a7bca4d000000b00401dc7c2488mr2153396wml.11.1695824087397;
        Wed, 27 Sep 2023 07:14:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ab67:eb18:db89:ef9a? ([2001:8b0:aba:5f3c:ab67:eb18:db89:ef9a])
        by smtp.gmail.com with ESMTPSA id y2-20020adffa42000000b0031423a8f4f7sm17370881wrr.56.2023.09.27.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:14:47 -0700 (PDT)
Message-ID: <1c57ec8f58775114a465182cf9ad31e6a718aadb.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
	 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 27 Sep 2023 15:14:46 +0100
In-Reply-To: <517a1a06b6ed933a92ade40633b431d7@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
	 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
	 <517df01859172566e88a239658c601be@pianon.eu>
	 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
	 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
	 <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
	 <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
	 <97ecac758fd3b771e56e32e0a6c095d0900629a3.camel@linuxfoundation.org>
	 <bfff73a5d575b2a62fb14782e71e9207@pianon.eu>
	 <3b9ec69856ec79e4ec9856d72395b3cbd36e58b2.camel@linuxfoundation.org>
	 <d15cebdfe85ce07df53132f3e20861ee@pianon.eu>
	 <8e4a6e545b3b2bbe9fc0a053b42521a84ded31da.camel@linuxfoundation.org>
	 <517a1a06b6ed933a92ade40633b431d7@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 14:14:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15136

On Tue, 2023-09-26 at 19:10 +0200, Alberto Pianon wrote:
> finally I got a working patch, tested against a PoC API implementation
> (implementation that I will *not* submit for now, as agreed). I tried to
> take into account all of your concerns and recommendations (including
> your approval to add just checkout dir calculation to the fetcher :) )
>=20
> I know that this is a busy time for you so I kindly ask you to have
> just a quick look the patch below and tell me if we are finally on the
> right track, before officially submitting it to the ML.

I think this is the right direction and basically looks ok. I'm not
100% convinced about UNPACK_TRACER_CLASS but that is something we can
improve as needed. FWIW new bitbake variables should really start with
"BB_" as a prefix.

Thanks for working through this, I think the API does look better for
it and it will be more maintainable.

Cheers,

Richard

