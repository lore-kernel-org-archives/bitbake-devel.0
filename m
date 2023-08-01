Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D300C001DF
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 17:30:34 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.19446.1690911028073145936
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 10:30:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=SMv029Zz;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9bd59d465so90967231fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690911026; x=1691515826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coy4/HeZRx6nF56HYQdTOD2V5/Fsdyx9A9jT1Dc8X+A=;
        b=SMv029ZzzFlN+MA4NelYZvh+JnLTkgMBYbepl8KwGvPy8w1ciU5dUvgfFgTVx2oKN0
         iYuGCsHhS3qknoxeu/wGJWbkzOeCnV5bjcd2nO4EadGdBFOe5oFjlIBV5n+FUHSpfxIR
         NJdrd6BBrew7BI2ojzdVqwQbJR32iz+ldF6gQyTFE96h5TtWeoxXggnbtHS5WIXh6a+w
         lJcl+z9LV7soFeJ0bzqkUDsirg+3Zp0ZnucYJ9h1Kjx3vNCCIkwjh6SOktV0klrNrql8
         x4IDu5E7z2DkExbicIvL3u3ciqu9/jNqCNwfcLRWD7NU8NmmCF30/KKn8+gQCLH6GXQN
         YQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911026; x=1691515826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coy4/HeZRx6nF56HYQdTOD2V5/Fsdyx9A9jT1Dc8X+A=;
        b=UGJx7+cFHDtoX5XfE+EuDx+L5sNVmSw91/TWSdfNnOayiXUwoXXBKlGHcVw2/Yti7B
         cwuFTyMyIT2zZTjM+vknKGz4FC3+EUg2yBoPT6doS7+2CHHzMibsNSwXetnGsNgj6ZA3
         hEkYFJ03p3rAZYskfdQcy+aGlRw1VJ9ypbvrfjTtBwnRZQ76AZbgVxbeyn3CVDrunsUq
         cFiZVe8mN8RfUF2zqMq+/HDXOwqhu4CnW5nmhrcSSw3DFoPv8R0d8J4GBPmivlveycXE
         3Hu/zAY3LKSLN1Z1J7UgCt6tbEeowE1L4cl+Ep2xomJ9+LaigSHmnVVaXuPsW4y7anrC
         cAAw==
X-Gm-Message-State: ABy/qLbItdX9ojyWleD0z8DiOOwlXLy2H6x1fRF4x2aja9USiqw3BWVG
	XPZeo1IjJmXC4vEPTpPPHhkPHr4jc4Pu6SE0IQE=
X-Google-Smtp-Source: APBJJlGajEW7kychu7yTu41acnkN100989m3z7BZ/l6nUwveH01mAgE4cbNFHtulrk8/Mw/j9UePAjOpCc0qaSOvcrI=
X-Received: by 2002:a05:651c:201:b0:2b9:ee3e:2412 with SMTP id
 y1-20020a05651c020100b002b9ee3e2412mr3292760ljn.22.1690911026052; Tue, 01 Aug
 2023 10:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230801124715.752243-1-eekmecic@snap.com> <CANNYZj8mkTBNfevYz7eWr45D2renfen5FCLc1C6pMNHpUhd03A@mail.gmail.com>
 <CACjag3tMLM_wHyVbSqD6sDHox-dCRjwNXgv-Q75bqfhLzo5eUw@mail.gmail.com>
In-Reply-To: <CACjag3tMLM_wHyVbSqD6sDHox-dCRjwNXgv-Q75bqfhLzo5eUw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 1 Aug 2023 19:30:14 +0200
Message-ID: <CANNYZj-SKotv0PVL_vxcPhX-H+_q8KFQa9Hk4C2Es7kk4hKHPg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: add Google Cloud Platform (GCP) fetcher
To: =?UTF-8?B?RW1pbCBFa21lxI1pxIc=?= <eekmecic@snap.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 17:30:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14906

On Tue, 1 Aug 2023 at 16:30, Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com> wro=
te:

> I am unsure of how (if?) BitBake verifies the integrity of source
> tarballs downloaded from mirrors. We are not using it to fetch source,
> only prebuilt artifacts. I took a look at the other two fetchers
> that implement support for S3 and Azure and I don't see any differences
> in how they would handle a supply chain attack of the type you
> described. Please correct me if I'm wrong. Likewise please let me know
> if there's something that needs to be implemented in the fetcher code
> to prevent such an attack.

Right, I thought you had actual recipes using the fetcher.

I think this bit:

    def recommends_checksum(self, urldata):
        return True

will require checksumming when the fetcher is used in a recipe. I
don't actually know for sure what happens when the fetcher is used
from sstate code and where is the code that prevents tampering with
sstate objects.

Given that the fetcher is the same 'class' as s3/azure - seems
primarily intended for sstate mirrors, I'm not sure if it should have
tests in bitbake/lib/bb/tests/fetch.py. Maybe RP can clarify.

Otherwise, I'm fine with this.

Alex

