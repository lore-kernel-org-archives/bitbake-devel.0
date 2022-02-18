Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224AC433F5
	for <webhook@archiver.kernel.org>; Fri, 18 Feb 2022 11:10:34 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by mx.groups.io with SMTP id smtpd.web09.9587.1645182629445381128
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Feb 2022 03:10:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pOFXFSn9;
 spf=pass (domain: gmail.com, ip: 209.85.217.41,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f41.google.com with SMTP id y26so5610923vsq.8
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Feb 2022 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWRnAe56TGgy+S9iDx3+V8vydcQGISiQz5HHA4COTZA=;
        b=pOFXFSn9ooLetHCoHB66ku63QcyRxw/US2aI9zJCQoPKjvJkEQwM3OaK7ai0lSYXHM
         71eS0YNakJo383DPN69Z3ANRovRQV4+n4iMbk3lSKtdXpkBW7KI+yEhJtlgmZvXe3XAe
         3KdcTXT0HnSc+GN8/R9LT6sl6N7fkWsenxNkYL3ClS6pgM8bhg1DUipa26xMbL8sejli
         4V3dzA2ZwNX3qRB2pPOdfOVFtrcPDRIy3Jn6DtG9nHFINKGKT5ccOUO4PGtO+qDmcWi/
         6S/H/LQfiaV7Dyz+xcU/3rBSg8h+CM902/HI+5GZdk28BJMBdkHr3h8IxSM7qu1cKZch
         iz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWRnAe56TGgy+S9iDx3+V8vydcQGISiQz5HHA4COTZA=;
        b=Igp2RydKVILPighWYfeIZ8Sw32y5kLcj7mWL00d3x/aiqGG56DeqFcr3lI0HZn8l+t
         /cqTH+bdZ1sSeCG4JJhhG3WPQQwbojf98XHPH0ZzqmC9kyH0hk1Vt95JaQUbvLfBT1qj
         OS7SS/rkfo6XGDq3II0lbNMyBJ3P4jvGlFPBmdSwX7jVoIa4ezNaYcOu9Xydplyivdfe
         ejqdnZGpMm76SMGA/DJihjEhkf4tycruJ+z2FtaC1BKwqd1BKhxdaycZ8erxgZKhsyRf
         5MlUnD+pWb2zaA/pjb4wEAxY0sYxFh3bXe3xszrOTuc3+P9GcI/1we+jIIcjKvScg+7L
         7vRA==
X-Gm-Message-State: AOAM530Y4SXTVNiV3VS8n8dV5z8ikDWOCFsdLZYGljbSVc2CxfyG2Xbn
	9PY48VFzR3fcZHXWiN4UCICJ/sZL79vTM39Rk9I=
X-Google-Smtp-Source: 
 ABdhPJzXS9WDSpk69IviqFxh1F95vjcoYbTaoPEg1c9jUdVkUTJ+1mQVuHxEYbrbmglWfL2w98B8SFkoe1udd8qr9KQ=
X-Received: by 2002:a05:6102:20d1:b0:30e:dfe6:de1a with SMTP id
 i17-20020a05610220d100b0030edfe6de1amr3253544vsr.73.1645182628605; Fri, 18
 Feb 2022 03:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
 <bbab3b39fefc448199235b2c458ba378@axis.com>
 <8229aa5ea01b346aa9c2519c7c46883e4c06b48b.camel@linuxfoundation.org>
 <CANNYZj8mR7Ov9w+=b3mv1QVLc_0G9Nusj1D3ZmzYq3yn3pA5MA@mail.gmail.com>
 <e067eac4230def7edd9541d847461a9d84746dd0.camel@linuxfoundation.org>
In-Reply-To: 
 <e067eac4230def7edd9541d847461a9d84746dd0.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 18 Feb 2022 12:10:17 +0100
Message-ID: 
 <CANNYZj-+R-iVH8at=ork0O82zzYyjJSeQip4OCSKY4DZ397Ogg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision
 handling with floating upstreams
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Feb 2022 11:10:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13367

On Fri, 18 Feb 2022 at 11:59, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> The fix seems to be:
>
> https://git.yoctoproject.org/poky-contrib/commit/?h=rpurdie/t222&id=90750e3dfe137370651bca14d9927a9c74e492b4
>
> Can you let me know if that resolves things? It did in my quick local test.

Yes, it works :)

Alex

