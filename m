Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88A8EE3F29
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 21:05:26 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.1940.1694552723548972774
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 14:05:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=JmOHrF2+;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso98988351fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694552721; x=1695157521; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR9wRDvyYZCsMY21vJIq90OXCwR+tA/3/R52+wPGDqM=;
        b=JmOHrF2+EpE/PXx4NZ//MNheURWa5ROl0E8nn/DW2KMwEwNoman2ufrO4iFUMNhK+F
         DBKYrvi6vte0ENNDUCdj4B/nFKLlWud0CmxTLrwy6ba0mBTrmAiJ9XY40jBLLVpyj7PC
         /WuzzX00Hyrw5mpXUq/84NKesRBapgusKyD8XjgYcQDPfoKzzaYxoBPhD77xTKaHOJPW
         QX7lwA1DRNXOnBhwH6KC/rEhH1ExM5nc0Off7AT2HveVR9ciXe7gOOeafQu58uI4gsG0
         lgyBHTS8C/ivpjWCPw0+0HTjDDgY8VRDLPpryJjrjiUk3lQ0qgd62CDV7zwbcJCpbCin
         z7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552721; x=1695157521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FR9wRDvyYZCsMY21vJIq90OXCwR+tA/3/R52+wPGDqM=;
        b=ktnEJF7+vtMEIqiYV0zv7VK1Y+zfVJBuWg5/Zl5XJSB10ZTWSCvCjylcPldXgNm/Ud
         UPOdYaTGR6Ki+HGm8jlu2Pkk67JG2nhrKdOlXdJg44t9nG77fqX6GSYcRb8k/fjOamJx
         tflFhkE8xh7gzKU/kDbhqx8eWK5G1wQdPbZDZlb5VMvGQrYtonCLltSb3X6/T74nZi82
         OY80jCq9nMgV5xyVoFza/BOBke81jY1nWy4UEJGfMkp4bVGHYm7EjpkWyKrXfA+mvIlx
         XX6+TGcvgQoaGuLoTw8lCgQ8S3acg+OP7vCiQoUn0aV2uKHOijSav62cHx5H2E0g29S9
         aNkw==
X-Gm-Message-State: AOJu0Yw5m8/0ZpnrhU25ZwUsqg6xKdB9UYmJfYFg/JbsoXLLosJtjhDV
	joOy+2kTUkZ1TJC3MdbS+0Ado07T3JrEw/ndlJY=
X-Google-Smtp-Source: AGHT+IHofePvVQVU895ffaVkpVMKzrFlXQt1ZloSFl7UK1nwK9z7TcAlmHTn/TYgD1zHb8hjG2lZLQMF79KKjZkkiMQ=
X-Received: by 2002:a05:6512:686:b0:4fe:2c6:1d76 with SMTP id
 t6-20020a056512068600b004fe02c61d76mr619167lfe.21.1694552721187; Tue, 12 Sep
 2023 14:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
In-Reply-To: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 12 Sep 2023 15:05:09 -0600
Message-ID: <CAJdd5Gb5wn7GG-1T_5CYjyESdBXU1RGghVYkAtAwF_GNBpnayg@mail.gmail.com>
Subject: Re: initial idea for hooks needed for source tracing
To: Alberto Pianon <alberto@pianon.eu>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Bitbake Devel <bitbake-devel@lists.openembedded.org>, Carlo Piana <carlo@piana.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 21:05:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15034

On Tue, Sep 12, 2023 at 2:55=E2=80=AFPM Alberto Pianon <alberto@pianon.eu> =
wrote:
>
> Hi Richard,
>
> as I said at today's meeting there is no hurry, but right after the
> meeting I had an idea and I wanted to fix it in my mind and test it
> before losing it :)
>
> It's just a temporary/WIP patch, but it should not be too far from a
> working implementation of the hooks we were talking about:
>
> http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/srctrac=
e4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
>
> There is no interference nor modification to the unpack process any
> more, just collection of needed metadata through the urldata object.
> Modifications to the core unpack function are minimal and (I hope!)
> straightforward, and there is no fetcher-specific logic in it ant more.
>
> When you find some time, could you please have a look and tell me if
> this may be the right direction?

I think this is much better; there's still a few rough edges
(`function.__name__ =3D=3D "unpack_submodules"` is kinda gross :), but
this is much simpler and I think easier to understand. Also, I feel
like this is actually reasonably testable; presumably there would be
some mechanism to "plug" a different Trace class in instead of the
pre-canned one, and tests could be written that use a special test
implementation of that class to verify that it is being called
correctly. This also means your special source tracing classes can
live elsewhere instead of needing to be integrated into bitbake
immediately

My thoughts at least.

>
> Thanks!
>
> Cheers
>
> Alberto
>

