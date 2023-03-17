Return-Path: <jamestiotio@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC4C6FD1D
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 03:39:46 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.11793.1679024378807318655
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 20:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OuTpRKcf;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: jamestiotio@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id y14so3783312ljq.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679024377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovfM3b11bZIcJsnWSuxyc37Co5a7oRia4ut1Yb1L7HY=;
        b=OuTpRKcfnyhEZ0cI1OSe9dnJUKDELiQnifGsBy6Pr3LQxZY8mrZhJNoYbPrJetkRT/
         45yp5/pc/YaNWG8nuKg/tKAJUPE77AE7Fj5F4sy9DFQ98J8ZujaGugZpQtkA19I+bnZM
         +3eL+mYzD+z9N9XV9Kz0d03gYPwZXHxUazgd5ALkMuxQ6r/+VJ14fAP462F9RSRzxwup
         eO9X1qQa2fIWMxhgJFZJF4gn7nfHKe89C56YlTT+6UGqnBVPI7dn8Gh5MQaUGkldItlh
         PGE3tBmbWcWuQttzXCRIJilRVFT2sOGp2X0Q07gD8EBqdU+NCN+MHZv4Dyqn3wMOvt3C
         Qt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679024377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovfM3b11bZIcJsnWSuxyc37Co5a7oRia4ut1Yb1L7HY=;
        b=MlVkHGhKig2nQeUtk2LmlWozEXCLneUpLcCGaMo9n17ZqXV81BQBnR2Oemt81qDqPM
         rZx9fhK9tIiO5CD+caBLp5W7qy8BzCC8uVg6QzwiI/lzEXPD+cUyjb4k28R9cuR+je3N
         tmalj5FylQuz/bolY8Bf1OJRPqEREjdgs/+uIhGs67Y/inqA05/0iBsh6Gi0DhCJs2pF
         Wq1UCkN5OP+5y1DMKHIWnDHwGVO1/YEir47LxjbztM1oBI/1sYXJtIW+D5URroGB4rBA
         R1VGmzjHPmFHUjrXyrg9qD5bxF4xHaDFKv3DV1+9PFNK1nv6q8ERawDpyo/1trlxjat/
         VHFg==
X-Gm-Message-State: AO0yUKWKocViXnMhrunfHD7wMUMsWP0g1oLYGXZT55Fgnibz0rB3TKup
	axnrPyAUzC1zkT2uTlsFIG4Z5dJiq5yfOXcSMSc=
X-Google-Smtp-Source: AK7set8Q7Fhf7WXWnvaIuMO9GqqxXlyG0abSvJi0XtZdWKO5kfYWMqGzUdcp4EFrOvqMrh5R/jx3RAHl/X9Kc3abmjU=
X-Received: by 2002:a2e:7213:0:b0:299:9de5:2f10 with SMTP id
 n19-20020a2e7213000000b002999de52f10mr1533945ljc.3.1679024376859; Thu, 16 Mar
 2023 20:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230316165705.58445-1-jamestiotio@gmail.com> <4a646f8e56f63a29fa11226a7e24037214a8a0ea.camel@linuxfoundation.org>
In-Reply-To: <4a646f8e56f63a29fa11226a7e24037214a8a0ea.camel@linuxfoundation.org>
From: James R T <jamestiotio@gmail.com>
Date: Fri, 17 Mar 2023 11:39:00 +0800
Message-ID: <CAA_Li+vEbFZA8oinj3xHKs=aw76kipDwbrR1i2Pbghr_zqyA3g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] ConfHandler: Allow the '@' character
 in variable flag names
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 03:39:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14597

On Fri, Mar 17, 2023 at 1:42=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> After some though, I did wonder if we should change things so that the
> first character has more restriction and @ is only allowed mid string
> as a compromise?

Sure, that sounds good. I can modify the regex to restrict the first
character in v4 of the patch. Will update the test as well.

Best regards,
James Raphael Tiovalen

