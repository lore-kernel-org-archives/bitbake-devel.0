Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57950C61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:06:25 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8348.1788339976009447695
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:06:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dRzKTxNN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c255c58156bso121955066b.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788339974; x=1788944774; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E5QClp8EyRBl90sNhhpJfD+kZX+spo7jSuAIM8cOhcI=;
        b=dRzKTxNNjJoDYm8T4vNS8FhSF1o8OO7uEsKzrVmD2yDoO2yi4eDkotIh3bFHlMWKJ6
         edND5vjBq9YXZ+4FFODGxsOtq8HowgWfITc/Vrfy33IAqB57yIMx5mbDBE9FvIzBTwBE
         n7qJC68snC/ExtJYK7tP1xU1NhIPH5c5GW7mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339974; x=1788944774;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5QClp8EyRBl90sNhhpJfD+kZX+spo7jSuAIM8cOhcI=;
        b=LtFcxob4yH8sUJaNpe+n7Vc5M3rjHkUjCdFdlT97o9UTjWMU5yN4Wu2ABAV+90qkYi
         Uzoye9s4nzOgLHH4En+QcwWLJHfpCoZbafJxk+qsObMgKKmvORcdS/LoRZexdou2KIkU
         tPwl/oOPWPopU37ky4ZiEK9TfhdL2n+yvjkwNLJHLg1HbfDdS38kx3vq9FXgksaLFjzS
         AvAo4Y+fyHfPnp7PIsZaYwZlp2ZzCzpnYsdZCZgKC4Fa5YDf5OAirwcPyyGK8uoXaXSN
         S6V2+xnhTCPMsNEvnYSVklJl3pikvfm8KqD9EGrT/Ct1xDpWbr41U3EDHOTCf2k7Co79
         qFNA==
X-Forwarded-Encrypted: i=1; AKwUvByZLPmfAaEUiCRcIpZea/y2RnHd3+DPcFxEHInkwaMKlWNkaEP+kt4oa5jfS9D79xsTtyPb9V9Nn2x4qbk6@lists.openembedded.org
X-Gm-Message-State: AFuF++kCmU8TPvz1VbKbLrazoPtPkjOnHTR7efLVaIv0yzupN73ts/Ui
	JwAfJsqkqbFD9SyfheJSZFLeISEsQVBFNIcMinv6uGUTELXc4Trbmn/K45vbY+mtxDs=
X-Gm-Gg: AYBFou3dgO2+vZTzWE7zZMY3UqOKwS5anabtbVVbtfxzFM3aq37UhVTKBsr/x6SEWGK
	MeiJ4JAcPuv59LYn1mUtB3wpk897hyeBFNjIBZ/1qTYdLdS0b3EjozpPdSuVxhSqRogYHndiJso
	5rfcMgT/yhpJv5EolE999wPi90TdGYOF3TeaHBonVI8+yvpAPM8cXjFtH63uHFqKK2XNbphKnlf
	FKl5roOzj8kjXZge1DHW+dArHOlKNJPzUaUfl1j0ND85MB6gstWb+jKNShNlLTMkkSGoSutvqom
	t5wXCclvxuw83kF6XL3Mb6xQWe95i6dm+8YUrFOH/xUUBBMcXUg59TrIQjnV96YxSVdWlkxCLOJ
	a+k37/ma8MZm5OmXN+hTAC/FMUwFajFFqOAABOBKQfVudlFRLvAEg9zfsG5znfZw1aYiJqZ5kYO
	TLxiepY+N9cAJpzwQP13Jbt68fuTn18Uf/UdgLxui/PgsM6N6zAL8aU/E/r7mfPaaz23smxh3Zh
	/IuhDzt1ae3S3b2wAlbM1YTO4QGv6Qvl3o+qkP4Ox9zv5bEx/Nh6HSlAmW4XnM=
X-Received: by 2002:a17:907:7206:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c25d54768cemr184307466b.6.1788339973829;
        Wed, 02 Sep 2026 02:06:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f76:df95:1110:1117? ([2001:8b0:aba:5f3c:f76:df95:1110:1117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc5a84sm98231666b.13.2026.09.02.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:06:12 -0700 (PDT)
Message-ID: <ad4a8405a86e9c243dd2748a82f3cb0535f02b8a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH] fetch: `touch` mirror tarball stamp
 files on download
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: philip.lorenz@bmw.de, bitbake-devel@lists.openembedded.org
Date: Wed, 02 Sep 2026 10:06:11 +0100
In-Reply-To: <20260902083232.825826-1-philip.lorenz@bmw.de>
References: <20260902083232.825826-1-philip.lorenz@bmw.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:06:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20148

On Wed, 2026-09-02 at 10:32 +0200, Philip Lorenz via lists.openembedded.org=
 wrote:
> The mirror tarball stamp file's mtime is currently only updated on
> creation / initial download. This makes it difficult to detect whether a
> mirror tarball is still relevant in a given build.
>=20
> Improve this by also `touch`ing the mirror tarball stamp files alongside
> the sources primary stamp file.

This gets a bit tricky as we don't touch every download file at every
download, we only touch the end stamp file.

This would mean we touch mirror files and stamp files but not main
download files and I think brings things into more disparity?

I'm reluctant on more complexity in this area, we already have a lot of
problems with the mirror tarballs and code structure.

I can also think of cases where updating the timestamp may cause things
to re-download the tarballs too since you can't know the content in
advance with many of them. This is perhaps the stronger reason not to
do this.

I was also going to say there shouldn't be hardcoded DL_DIR references
in there but I notice the fetcher has a few too many of them already.
That would be a separate bug/issue :(.

Cheers,

Richard

