Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E58C19F2D
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 21:48:20 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.241.1660081692526886154
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Aug 2022 14:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=gYuL/DKl;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.49,
 mailfrom: steve@sakoman.com)
Received: by mail-ej1-f49.google.com with SMTP id gb36so24459465ejc.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Aug 2022 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3V3doWX58zRgkZekpRoSPwmiKbUHTKhJTZ9E9eB5xk=;
        b=gYuL/DKl+LUhQHh8oxPi5Y1/FRf8OTJWmChuDiMEBRwLpfmV6LcvU9WPAUkyUhl6YF
         l/TwpUzGg0KuJMRRi5dBASvNjA3ES8nXZAF2hM3s30utf7iJVqiVno1KymDO5WbBgobO
         PW8EI3WxGnyNsduU2L/eG10qH1koSiGeNunlA+2Vn+dQCtWrRtwpmXlTBNrGWnPtbMTR
         NiBFIMOnFznt9vYVwvQqAk6uZOxtzsoWXSm0ZcqZ3a49NYOyI1XjOkKnHu2e5uERf9Hl
         axP7+4avwXUgH/8349kbjXrUDC9YPeqN2lejBz5vIRJHamohij6rVtjV1HvuNCJSxHMn
         Kqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3V3doWX58zRgkZekpRoSPwmiKbUHTKhJTZ9E9eB5xk=;
        b=WreBg6L2Du4l4kSBdhjQk0O4CFP7pUCP8ov5EoweL5zyxQl/AFL7pnnzaZHjRpJJ51
         HjnOd1p5ue0qF1RXhNnpTXWQR6lCFt5EGQz1FzoirRcqC6OWUDqQrF1tj14RAdJySDmK
         PsDZm89ShdR76lpAzfnaHFuFJ5D32bWcTw1E7rB127xnCYiuPFMfUtBVlm5PpUStf/Yk
         SQSwrsMThIgLrdSIgvHXK2GFdG+lMooi42nu4YUl58cXJUwW9TMB4uHWfoj9+x5Cv+SM
         qSxn0de7YlCUWcGz/LU9w55yjSsXn7B6IQ71Dsy2dVfdHND/6KU35XrU42WSPxFjqLM5
         iZtw==
X-Gm-Message-State: ACgBeo2qDPdkxHtZI5BiRnDQcqNznC/nkEjhhvTZy/vf4o5dyZth53nD
	YKpZgDXLEqhL08agwx+Jg+rCQT1/iN0V4wXs5OKxFQ==
X-Google-Smtp-Source: 
 AA6agR5rv+1sZs7JwtOaMA7yHRjPm+1V5hphdlamSrwjvyln9+inm3BSMUi0XclC9K1iUVfH7dF0tABZ1dLbmEePseQ=
X-Received: by 2002:a17:907:2e01:b0:731:1eb0:b9ff with SMTP id
 ig1-20020a1709072e0100b007311eb0b9ffmr12818279ejc.728.1660081690870; Tue, 09
 Aug 2022 14:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220803140441.1196056-1-JPEWhacker@gmail.com>
 <20220804112648.71c80544@booty>
 <CAJdd5GZRRUOf3ZMSQQnxOgU0oxqW2-ty5P0QKbAKTEitD7HnfA@mail.gmail.com>
In-Reply-To: 
 <CAJdd5GZRRUOf3ZMSQQnxOgU0oxqW2-ty5P0QKbAKTEitD7HnfA@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Tue, 9 Aug 2022 11:47:59 -1000
Message-ID: 
 <CAOSpxda8h1Wzc6odfQxqn4EUJzgY7Os-sWi9wynk2GKiuKNVpA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] siggen: Fix insufficent entropy in sigtask
 file names
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 bitbake-devel@lists.openembedded.org,
	rasmus.villemoes@prevas.dk
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Aug 2022 21:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13877

On Tue, Aug 9, 2022 at 11:44 AM Joshua Watt <jpewhacker@gmail.com> wrote:
>
> On Thu, Aug 4, 2022 at 4:26 AM Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> >
> > Hi Joshua,
> >
> > On Wed,  3 Aug 2022 09:04:41 -0500
> > "Joshua Watt" <JPEWhacker@gmail.com> wrote:
> >
> > > Signature generation uses mkstemp() to get a file descriptor to a unique
> > > file and then write the signature into it. However, the unique file name
> > > generation in glibc is based on the system timestamp, which means that
> > > with highly parallel builds it is more likely than one might expect
> > > expected that a conflict will occur between two different builder nodes.
> >
> > s/expect expected/expect/
> >
> > Taken in my testing branch with the above fix.
>
> Steve, can you please backport this to kirkstone and dunfell? There
> may be a context failure backporting it to dunfell, let me know if you
> want me to send a new patch with the correct context.

Yes! I'll probably get to that tomorrow after I finish up testing for
the 4.0.3 release.  I'll let you know if I run into any issues I'm not
confident about resolving.

Steve

