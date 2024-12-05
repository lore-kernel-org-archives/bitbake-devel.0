Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B3E7716D
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 15:47:54 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.14508.1733413666833346270
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 07:47:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ESpzHgTW;
 spf=pass (domain: gmail.com, ip: 209.85.167.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea52520327so652986b6e.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413666; x=1734018466; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RCRMkU8XOXcFH3n221aix/sNDo8RsUl2BWtRFUXd/n4=;
        b=ESpzHgTWVWjB9o9l0EHq1DveuRln17H/HQT6KxAuOx6zSeqn01FRH9HRnKXOf3DPJP
         2/xcUekmOwMmi5d25OT+skwCVP/LAKOmnxdookFF+NQlKGq4t9FzTpg7HncwDmVV0bcn
         LPUrBxrBcghTczfjfInzrr1PookA6/qPWhZz5i5abrx9zfq/yEFAtc3HSez/wuo+y1gs
         4I15/hOdQYlFmkEhexHhInTMcYAqIbDkzd8cTIFB0SQsdN2aCrUvBKLkGvwfxe4qi4sB
         zLmQUa+ubMl2amvC8+Cv9LzdBjZAsEZzyvf4VrkEwTnorr0ASevVFzwpQWvEJsUpBARg
         skQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413666; x=1734018466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCRMkU8XOXcFH3n221aix/sNDo8RsUl2BWtRFUXd/n4=;
        b=pdKfLjpgGzBfjJwf76uAJuM1oDPcfip+uvAHfuziFVvp3I+EFdhOvR5SJMMBHpMMZr
         RT8/y0kFMypKItbfX1Z0Q03FmgX+rp6n+n5w31Ajv/XC3eX6waZO3eNfE4L0t8Mne2Gt
         iMPXh0txQyjeZwbZ+NDplGCYpiuKA5KW+AzA1cstjWVzc1zSROznDKGA+u7nwFPlEsaP
         o8/j0bMUGVcz2UjFAkuO2YMKExjfSeTgwN2XFkrDJyurVt2S8HZ64uCMm6KyvruIYlmE
         zoTpFTvKr1D3nl0klXu+bl2AKbWsdVK0UUZ0uMenJhdyEAzevEpx8RPCJSOLcv4v/w8a
         4TXA==
X-Gm-Message-State: AOJu0YwKi20oAtzSsZ6BlA2trmBBs3kc9qUg6oS4pK6zQThOnRnccy21
	ffA+pnpIJMW5lczfbIYT3/oCDIZEjqeYLB0VOzQ7dkjU7jd6ajHTsdZ2hCbXlTQzggnAx479oca
	0LrgtmbhE95EquJUXhLhYcz6LypeeNg==
X-Gm-Gg: ASbGncuAQUdIMPtuYPSyDzZi0oni3r7Cj5unqaiEhwXMFNSxSKtMAj0AQWDEnhy99+C
	NawDMU/Mh6HRiY84F1R2eKTojQZCrBBhX/0XDSJ/Lh6Bk8V0D6/lHbamTIdfwvEeAEA==
X-Google-Smtp-Source: AGHT+IFf1dyVxGgnKnwzgJY0dSSFbmhlTwAedEnqXfpD+no3rZI6VDJ/n8GVGYaqNAy2YvA9NLnOQaixEPCnVqo3oOU=
X-Received: by 2002:a05:6808:10cb:b0:3ea:60b0:f6cd with SMTP id
 5614622812f47-3eae4f3b6d5mr13039309b6e.17.1733413666108; Thu, 05 Dec 2024
 07:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
 <20241118162610.1423384-3-alex.kanavin@gmail.com> <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
 <CANNYZj8hDKYRQ3cCLQGb0ddch3Q4stYyx=o15uF9ohSs8Bh1DA@mail.gmail.com> <70cd6dd736551401d88185c060ee45fcc3d02819.camel@linuxfoundation.org>
In-Reply-To: <70cd6dd736551401d88185c060ee45fcc3d02819.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 5 Dec 2024 16:47:35 +0100
Message-ID: <CANNYZj93zQDL_3zOTATNgfh30_Y=SCkaKoqs4NNgHuaYH=-Q7g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] parse: add support for
 'addfragments' directive
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 15:47:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16879

On Thu, 5 Dec 2024 at 16:28, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> The patch is therefore probably ok but I am a bit worried about this
> potentially breaking in the future if someone else (or I!) miss the
> subtly in the code.

I still need to improve variable naming. I'll do that and send v2, but
I'm not sure at the moment what can be done about this subtlety.

Alex

