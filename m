Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E213C61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 19:23:00 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3073.1788290571746880900
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 12:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I1ONXttJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso2140185e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788290570; x=1788895370; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4o7O7oOn5ONOyl/CzyRDzUpHF+3bNOwoDx/azzvjIgg=;
        b=I1ONXttJSjR5xJQ3Bpojc8JUSIEsi4qivUyFQjOMUwkefE1Jr2mftsoF/LL10o9nCb
         CkTawTvpGF+BcfiE+D5OV1DMoh0qcFXqzOPvvH6Us9NTweFvscxq1n+32Vk+iXhGMs7R
         2lWlZIP3KS43hc8BKFUsMTJxL7LYBDix+WASw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290570; x=1788895370;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4o7O7oOn5ONOyl/CzyRDzUpHF+3bNOwoDx/azzvjIgg=;
        b=IVkjRtGSfYM8fEcOxL8jXPMqE4n6lUM55Y88OkPCmXc3McGnYnZSFYCknlJcQI24hN
         nswb+SspFV0jZx7kJDyvDTJ0EFz522LAofKZ3Nmk253XxID3/nBs7ROwcqxS0pIy8MbW
         q+iFkffFZiSEPNcK+/28LO636nUaAWUFrpy0sxK+G1VD3xWhRwy/KcHVD4DnTJgvq06a
         fPWD+O2bMbzrAuCuMZdkaWgAl44IwWr02UkMQ4pHt/+NLV4Gns+Udm4+m+CC7bj2CUfU
         PJmkcjKECbc6Gmq3B+rdNO2982/poJs4S/QFlmSZWnskFDs2gdJhEz1hzX/FBC85QYkl
         RK9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpGkLbcB68mMPvp97wt/Jb0Nt4Gz+vDbbA45hkn6rVonjCki9msBeKte0x/yDps+NO/2T7DRXuFb7o507rJ@lists.openembedded.org
X-Gm-Message-State: AFuF++kQ99XFycoptB+xoxp84eyZ4HS0KS0MZLVGJyY70/vsLlFCBz6W
	v78Ps0dmS37DOrlmIvN/z6+zYeTVxUKv/2VzBdbz/HcEFIOQSBC5/dGEtXxGe+vNOJ8=
X-Gm-Gg: AR+sD11LhmihVdb0PnIg0U0NVQAWAy3vxTGTAj+f2m0Ma2TJPnZaptB1jFdaX5nKTP8
	jK7eXUNj0tMfVTikKnXvpDdsIxNFEWPYj+3EiTv1gEj/agMuXmVcw/9/ucm0wj5y3P5fRMLwPIn
	8lzSXBxRYNzAsN48loIOmZy1I2sesqxRyNp48Uje0ziKnwlNdZc3SifWnEf0L6W3ucXaiGyLoG2
	jBbOLaL+SNECWzWxvwH0sgD2Sih36K5MF+m6RVLR5KiLvGMgLzg/Bg33+F4mB8fXKGlI0j/WhiO
	dEtt3hcEsGWEnQff7Xh7d4tUpsbbf2PZl3cljfVRfc1Q/fDveUNBCrYtH9F4spylOa/vlcR2zgj
	sRiHONEp0ElPmpAbR0BD7jWOSVWSc4Vom5ZV/f8zpv83bhJmUJZrAgjJ6JwjoaypBLcqXyDPzTc
	ajsxJHT5g+SO8w5eeL0cvPOK4Fk1Ortst8aNro0jfqvjxTmDtOtbezZotHkzrNKft+vztnalknY
	2ozfap3GIoaqD1az4R18cmnxhJxYf/nPVW09czDZ9YrKxC3oTXeyQ==
X-Received: by 2002:a05:600c:8b74:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49ce37e4a2amr51548325e9.4.1788290569783;
        Tue, 01 Sep 2026 12:22:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727? ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce478daf6sm14229395e9.15.2026.09.01.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:22:48 -0700 (PDT)
Message-ID: <bd9bf095e420c01a261a4464b3fb28f96be9a45d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC] parse/ast: add support for additive
 built-in fragments
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 01 Sep 2026 20:22:48 +0100
In-Reply-To: <CANNYZj8cso=2X3Wi3u=59Xzt92g5V6CvuDtLD-Y8r3HycKBOVQ@mail.gmail.com>
References: <20260901-appending-fragments-v1-1-2e359cf751ce@bootlin.com>
	 <afffba8970ad228db773766f7f6c894cbb021279.camel@linuxfoundation.org>
	 <CANNYZj8cso=2X3Wi3u=59Xzt92g5V6CvuDtLD-Y8r3HycKBOVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 19:23:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20139

On Tue, 2026-09-01 at 20:28 +0200, Alexander Kanavin wrote:
> On Tue, 1 Sept 2026 at 14:15, Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>=20
> > It is definitely an interesting one and the syntax isn't too bad..
> > Are
> > there uses beyond class inherit though?
> >=20
> > machine/distro were added as they are clear variables in common use
> > which avoided tons of boilerplate in layer definitions. Do we have
> > similar needs here or are these inherits better captured in config
> > fragments?
>=20
> Antonin first wanted to just add 'real' fragments (that are defined
> in
> files) for common class inherits, and it was my idea to implement
> additive built-ins that make it generic. It's something we can
> consider and discuss, I don't necessarily insist on a generic
> implementation.
>=20
> I guess we can all look at our various local.conf lying around, and
> check what's piled up in them over the years. In mine, two variables
> immediately jump out as candidates for additions: IMAGE_INSTALL,
> IMAGE_FEATURES. Those certainly will not work with regular fragments.

I guess there are a few things to keep in mind.

Firstly, we're never going to replace local.conf, there are always
going to be some things which users need to do locally for their work
and these do belong there.

The alternative is a fragment language which is an abbreviated short
form of the main bitbake syntax and I'm not sure that is feasible or
desirable.

The things which should become fragments are commonly used groups of
settings, things which set set as a group.

The machine/distro shortcuts are nice as they cover the biggest control
everyone sets immediately but beyond that, is there a pressing case?

I guess some of the "classes" are in fact policy "selections" and kind
of like fragments in their own right but are there enough of them to
justify specific syntax.

Once you get above a handful of image features or image install
packages, that is a packagegroup or a config fragment in their own
right and I'm worried about the abuse such things might get...

I'm not saying "no" but I do have worries.

Cheers,

Richard

