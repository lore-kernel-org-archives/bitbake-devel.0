Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B96C6FA8F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 10:33:15 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.7723.1692873188204439718
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 03:33:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YEfa0J9S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso8061434e87.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692873186; x=1693477986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JLaVM+J6WkMlZ20EhZXIft66TJdZbPiF/2y+cVUFzW4=;
        b=YEfa0J9SgkxNUKfiwSceW2GDJgh1c8lgqUfE4mZYgjwy1GF3V0lDEs+A6krXQc31ja
         w9oSUrBoF6fuJlt5ceKuM/R5nBUZXKsV0PpialnhXX8/VNrFF8g+lXIjKqn6WPhcgn42
         vDkY435yUJcOPaAHRWf4XMZ2b7uLxs8g0cdZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873186; x=1693477986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLaVM+J6WkMlZ20EhZXIft66TJdZbPiF/2y+cVUFzW4=;
        b=XNGS5MpePvZgaeU7f9q+kU3jXMKsPKNp96Fh+NCjqfqiQZm/q/dw08on11P298WSt1
         2eHbxq/eKDBXkK0BV50zpYs9sIDlHR57BH8aAbFYtQzmkJ+amUzqkem2Ps+tCoJ/SHwb
         sSKnZFyDPQtwi8T0oAh2ksqZkLnVKvatkAT25VUVqy5OqkFbnz0LK8ueifwNHy1l1Fi6
         d90ExTGN+7vi6pmhTCPlfSqgX3hc4jkKll340QZTjBWINSbcrIYHiny4s334VMJ0tjYf
         zcBFDfg+WxvsjBIRzJcxnLVFX5iUdt16kipMwnjX5VhZ/JE5nPOQZoZSj7dBAgfIGgo+
         3RLw==
X-Gm-Message-State: AOJu0Yz13VvEoGfOHVBUMaRBSGSDP5Ze6Rch0eBJ1oHUnhrmjdvDCdPu
	nWpim4y4tbG8NUNkmUMYszRpcg==
X-Google-Smtp-Source: AGHT+IHesGSjMmYLTA0WMEMrFArP3agJZq+MP6TdMHwCz9X7v3rvbl/nq63xv5b7EcamhIbQIm3p7w==
X-Received: by 2002:a05:6512:1329:b0:4ff:a02e:a53f with SMTP id x41-20020a056512132900b004ffa02ea53fmr11253631lfu.52.1692873186168;
        Thu, 24 Aug 2023 03:33:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5461:c902:2158:9a5d? ([2001:8b0:aba:5f3c:5461:c902:2158:9a5d])
        by smtp.gmail.com with ESMTPSA id a19-20020a5d4573000000b003143add4396sm21792450wrc.22.2023.08.24.03.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:33:05 -0700 (PDT)
Message-ID: <26588a5e03f82a558bdcf705cc7b298931c9a59e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] siggen.py: Improve taskhash
 reproducibility
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: luca.ceresoli@bootlin.com, Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Aug 2023 11:33:04 +0100
In-Reply-To: <20230824095806.356563f2@booty>
References: <20230822203350.264625-1-paulo@myneves.com>
	 <20230824095806.356563f2@booty>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 10:33:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14975

On Thu, 2023-08-24 at 09:58 +0200, Luca Ceresoli via
lists.openembedded.org wrote:
> Hello Paulo,
>=20
> On Tue, 22 Aug 2023 20:33:58 +0000
> "Paulo Neves" <paulo@myneves.com> wrote:
>=20
> > file checksums are part of the data checksummed
> > to generate the task hash. The list of file checksums
> > was not ordered.
> >=20
> > In this commit we make sure the task hash checksum takes
> > a list of checksum data that is ordered by unique file name
> > thus guaranteeing reproducibility.
> >=20
> > Signed-off-by: Paulo Neves <paulo@myneves.com>
>=20
> Lots of errors like the following on the autobuilders are possibly
> caused by this patch:
>=20
> Hash for task dependency pseudo-native:do_populate_sysroot changed from f=
4435f759ac00c51c07eaa840d9d61249f38f82d39a8dbffa4e8f599d874a3c6 to 07a20019=
8639768d86d5c2c654fcbd0d4ea23d333e735848ac22c12474db1c2d
> (and a lot more errors)
>=20
> Logs:
>=20
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5592/st=
eps/14/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5646/st=
eps/14/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1954/s=
teps/15/logs/stdio

FWIW I had this patch in master-next and didn't see those issues so it
is possibly a different change...

Cheers,

Richard

