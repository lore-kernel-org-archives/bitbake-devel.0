Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F8AEE49A4
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:40:11 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.43203.1694374811273130939
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:40:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=aJLdZKSB;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so59306301fa.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694374809; x=1694979609; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o74ZmIJO0BC2o8CIg0kls8vilUFfgcXpS/+G1LvjD/o=;
        b=aJLdZKSBwsr2qPtvqXZAlT4/VRvQXL14wJoOpdsHTv104tlDK0OFi7xuRnpucyB/uH
         T3+Qx65NS7gNB71H77CtVhEJ68evLAJd2pRDa53iQMBqqVUONTxe7W0x4xH93RQHECNL
         ZgA0OhnnI1lmKGpTeLILI5QUuK+22UO56j9zO9jNHCHBH+2sBE/shcE6SdqXAdw8U2Co
         x6Wt0XtyGsLQhCjqKYRNe1ROnnCmtto/jAVmQx4UrMU0zPE34zYFxi8f7qsSc510sGZM
         8jlPLntlw8rOsGai66vNI1kWLC67f+foc/jDhWQ4Xgun0lwUhSJe2O6f+7q6i4CjE8v6
         xE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694374809; x=1694979609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o74ZmIJO0BC2o8CIg0kls8vilUFfgcXpS/+G1LvjD/o=;
        b=Q9A+iIAArhgxd4uYPTvHB4tWEUcwy82uM9vKyTJPKwLfAyvBQTE5yAn0Y2MzLeN0fI
         SPfwkznWsoycAnDJfGb19zWZNxMSpLUBT78aPPMHCni6ZqpEWbecDesfHnHDWUPCKUFs
         9/RkbK+qN8vXPMXaGIoUUHYUFvxXMCRmO87d5olu2wmAwro8TFU5ejgLbt9+W2dGmdnA
         SdiawLDT8p8PgkpWCE9DdRmsi28hMW4v5F9xLEeCm1I8ayH0MpfNGCwmrFPtr5RBITZu
         pxOT0NHfldA6PqWmLS96OzhDbPGzy82Oe2HypTAgor98duH5e6Xwk5ttspy1rsOUilsH
         EK4g==
X-Gm-Message-State: AOJu0YzxpoMQUe2i7d6VshfBtN8IkC6YqmAlJECOnD7e0YVZdbEPtr3+
	vl9BuF/+nCZPbscM7hcYLweewqghspJydcqhcco=
X-Google-Smtp-Source: AGHT+IF4YtV/znd8GPY8uyPyd+QF+IHbYuC56bhmjiZPCDqsI9L9pwNgagtE627Qku2uVjsk1fN+AxZPnKYyy6iGY84=
X-Received: by 2002:a2e:8194:0:b0:2b7:117:e54 with SMTP id e20-20020a2e8194000000b002b701170e54mr6208950ljg.4.1694374809195;
 Sun, 10 Sep 2023 12:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230910191445.564413-2-rs@ti.com> <CANNYZj_SNEM1yGkF28vv=oa+89DKptxTJmVAA_mb8qCwBtYUdA@mail.gmail.com>
 <3a26f3d8-b0aa-4ebd-97bb-aaa36c5eed9d@ti.com>
In-Reply-To: <3a26f3d8-b0aa-4ebd-97bb-aaa36c5eed9d@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 10 Sep 2023 21:39:57 +0200
Message-ID: <CANNYZj8AoxpcSoTpQ8KLDMOTpc_u0NQt8oUyLVYHs8=GSNuitg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] bitbake-worker: remove the network flag
To: Randolph Sapp <rs@ti.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	denis@denix.org, reatmon@ti.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:40:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15023

On Sun, 10 Sept 2023 at 21:37, Randolph Sapp <rs@ti.com> wrote:
> I'm aware of the proper solution, but this will address the issues of
> network flag abuse that other layers are introducing.
> My issue is that by exposing the network flag like this any layer can
> come along an introduce build complications. If that's the case, why
> expose this flag at all?

Which other layers? Do tell us, so we can recommend everyone to avoid
using them.

Poorly maintained layers do insane stuff all the time. This doesn't
mean we shouldn't highlight bad practices in a very clear manner, and
make them complicated or impossible whenever possible.

Alex

