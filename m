Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD22BC48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 20:44:38 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.23746.1707511473987628689
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 12:44:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j6Y4qFXi;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0e5210151so1009341fa.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707511472; x=1708116272; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJVKH505uyiprTXKpVL6xJZN/aPNKEZEPTc+gBM7UU0=;
        b=j6Y4qFXiy+bGnF6Rb8QyKAoh8kZmT81ZjO1ZD9j5aeTN2Z8D56BEXWulMujvRW3wNr
         4s3mwca2ToDk9Y2Byq3N/6c6U/mzEAr4AA3yYv5JOTwXhsTP90XiZHm/fteGYdrJfMGE
         JpZIX98AQgW77YcysrjYpA9g45TWkIF8H+rlzV7EMOEVww/S5NxlHvxia5yDNcJh8BhX
         d95WEm5D7+JIYuPZYtC2Z8kIya7kn5f169KLXmKniQTf8fgCEQIXRxmRRwVfoOjtID63
         og5xtXS5zvkC/eDJTFYyO+ZRmzqO6HmcIXc7KRDXrhE55c9tszBVdbee+Fw206GBB0dr
         yb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511472; x=1708116272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJVKH505uyiprTXKpVL6xJZN/aPNKEZEPTc+gBM7UU0=;
        b=eI+5ltG3ROHF1afGNuU45Dqjs6gZR6OzhRUlHoHGCwDJJ7hC3+uOh99dOA7mZSu9eS
         bQYWJRkCIgT+n0oqCqEBBGfqCGR9oa4X+8CQoGZjxEo/+F2aYya6ydDMA+WISRnZW2vl
         DebA0japO1nHmRs2I9YxUwPLHzK7nrYQ0kg0sHJ4XsljPqS5aMdn5BThoVEBRhH4tinH
         o0YKlpCblPmfE07vuGlIY04CNLdzhw6cQD64yTK5Hj5NBKSXJXhjK2Wb8JfLXYt8E1Hs
         qe/XosUF8NxGbzbpTvDpaj7r3pvop9KDTdIzoUQEcTsBmAtq01SNkDZQOpUx6nLdcv4D
         yfbQ==
X-Gm-Message-State: AOJu0YxDSYgsQms2SdgYRzs/fa22DOa+3Kp87XOD4eKWRYZYuSIkMPeI
	H47lF2MFMjFVzs1QwUWG9JNI/xfBzCo3wOKI0NyPcwbr/c/bMRgZXFut9VGBFnipJlwg9trOu0O
	9xYTNFpsl9JvyS0E6IQnJZYejHzo=
X-Google-Smtp-Source: AGHT+IH3PfknHoEIKoxkNWnBuOQ9EK54IJcJErUAJcPhL0JUnlIPWeYlL5D3jggxQzQAucTDLsNaTcnbOguNC/honPA=
X-Received: by 2002:a2e:3c15:0:b0:2d0:af2a:63c8 with SMTP id
 j21-20020a2e3c15000000b002d0af2a63c8mr80606lja.40.1707511471749; Fri, 09 Feb
 2024 12:44:31 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org> <17B24084174823DE.15017@lists.openembedded.org>
In-Reply-To: <17B24084174823DE.15017@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Feb 2024 21:44:19 +0100
Message-ID: <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: alex.kanavin@gmail.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 20:44:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15864

On Fri, 9 Feb 2024 at 18:02, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> I worked around it by running 'bitbake world' without -P so it could
> parse recipes successfully, then re-running with -P against pre-parsed
> data. So profiles are being collected now.

Here it is: https://drive.google.com/file/d/1bM1MGJWU5uWRf6kE6AaENQLQKIbopnGW/view?usp=sharing

I pressed ctrl-c after some 20 minutes - I took a look into it then
but somehow couldn't find anything related to execute(). The two
collected profiles seemingly are just waiting on select().

Alex

