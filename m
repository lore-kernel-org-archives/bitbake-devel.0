Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C5C77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 07:52:08 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.11012.1683705127071677300
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 00:52:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=LjouAo5s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3079d2afedbso1946349f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683705125; x=1686297125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8/zN13wQYGF4dYlAWnalJmoDGMHThJcpvjkwVpc8dI=;
        b=LjouAo5sTWQKRk8cPRI8ILWIlGrbdzkpdBwPPdfIVr5VUbva+/OjUVOEXAyLeWK4xg
         U1iu5RdbU9826OOqRW+CEJdB+dpuCvkoSOgq1ATYddfxM0onJEVC2GT2h/LudqGdsKCk
         ED8Q+uoZfqu11dMAIzLDBGQc3Ztwg60Qtlnxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705125; x=1686297125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8/zN13wQYGF4dYlAWnalJmoDGMHThJcpvjkwVpc8dI=;
        b=RkRv7S9zJUa91Y23SrWBY26rPgvLzFdd4iop3GPDrIs4Wd457YHhqQTDJLpvWucozL
         3d1y8z72us8vKeMGpLsYsFEsqpm6TcS3sKvVbNfF/+vFh7Gaze0N2/bdHiPPstqPlLHP
         24twZCeebNmw96BcZZqwL9u+z5L02y/g2sKPfrY+8iXnVUvCe5sO972HNnq0i2aE/M+E
         sLzmCSrSpwZ4cn7RrAGp+4AWSYp9AEgFuvH63bo9nj9HGhcS1Ip17lDiLEtd6z+azcS1
         dD2W2xyfu6ydNNTve9HM9gc+hs7t7QWYNRJNXgB7p+yLd/YicSmmC0uj+EF8/wIuBu2k
         XXgg==
X-Gm-Message-State: AC+VfDxSZkfKMh/TkJhor42YZlkg0UuMjrHVs+JyX7nVzcfVJ7C6gcJg
	F5wDe5552MNdjUfYiqzsYsyBNQ==
X-Google-Smtp-Source: ACHHUZ5HyiiJpa+MyFM/gmvgoTkKpdh7WiSEszyO8tI/b4Bp4lD60GCkMwVKvbEvsjZxygsgcMo2uQ==
X-Received: by 2002:adf:e342:0:b0:307:7d1a:20ea with SMTP id n2-20020adfe342000000b003077d1a20eamr10740585wrj.42.1683705125355;
        Wed, 10 May 2023 00:52:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:97c0:2f0a:108:d273? ([2001:8b0:aba:5f3c:97c0:2f0a:108:d273])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b0030642f5da27sm16467865wrn.37.2023.05.10.00.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 00:52:04 -0700 (PDT)
Message-ID: <25b122740ed8d9d0c62068542da4fa99c53e2dd9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Date: Wed, 10 May 2023 08:52:04 +0100
In-Reply-To: <20230510031631.1813338-1-Qi.Chen@windriver.com>
References: <20230510031631.1813338-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 07:52:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14773

On Wed, 2023-05-10 at 11:16 +0800, Chen Qi via lists.openembedded.org
wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> For now, if the client gets no reply from server when running a
> command, it exits after a period of time. The value is currently
> 60s. Looking at the history, this value was increased from 8s to
> 30s, and then it was increased again to 60s.
>=20
> For now, what I can see is that when running one world build on a
> 128 core, 512G server, starting a second build has a chance to fail
> at updateConfig.
>=20
> Instead of increasing this value again and again, let's add an option
> for easier customization of this value.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  bitbake/lib/bb/main.py           |  7 ++++++-
>  bitbake/lib/bb/server/process.py | 19 ++++++++++---------
>  2 files changed, 16 insertions(+), 10 deletions(-)

You're saying that the server can take over a minute to start up and
this is considered acceptable?

What configuration is the other world build running with? I'd suggest
the system is so overloaded it isn't useful any more and you should
have pressure control enabled or other mechanisms to allow the system
to function.

I'm not keen to make this any more configurable as 60s should be enough
and if it isn't, there are different issues at play.

Having bitbake silently hang for minutes at a time isn't good for users
and isn't good for CI either.

Cheers,

Richard

