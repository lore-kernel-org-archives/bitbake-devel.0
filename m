Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC7C46CA3
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 11:42:52 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.6525.1702294972048136260
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Dec 2023 03:42:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L9rJjg/c;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336223afe64so651914f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Dec 2023 03:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702294970; x=1702899770; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmpdPBHwcM/VExOh43WBRys8aimRwgf2VQXoFSIY+eE=;
        b=L9rJjg/c6rjU1aeFnsopsMoQrTBi6qXOsgXnuvgHMBECQfxaDbFkFV1OPKl64mr2DO
         ZNtd0y5zkzbH+gGdEr4LbDHY/DhVDEg/AWtLK71ePz7MciYV5hsemqgDYzHl7AlgLIcD
         bWlN1ajPJJuAONLIrsWLnRKh3B5dZIWmbJ/Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702294970; x=1702899770;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmpdPBHwcM/VExOh43WBRys8aimRwgf2VQXoFSIY+eE=;
        b=kySeuZcKyfj+EDF/4+D/qFtEERlC3wiigtrlUHxCVGIwap0V9aGBmPDLNKTv/QYLB3
         u/0IeN5fP84PK4WMig+f+BbL7MAqyZzyTOD9QMqduzATcnregn9v05X+0KALJCSQ9zcm
         Wu4X1Wzotlz/TttKfykZQj/IFiIgJraETDGAvS82AvcqFXskRckIXNFPb6c5/03beD4J
         An0Hsyn7+FqPyIpfhgIA10NSyLmF0e8Td/+3Fmkp7M8ODp7hoMpv03Sosq3wTKcM97gV
         dCZqpdWHxDyWMIjme0tG6xm0SfRjmn6iTcC/Xhm3+8JwtEX88w/8tS6Bl7MvgRRF4U3s
         Osow==
X-Gm-Message-State: AOJu0Yyxp9gNcSpoM9Dx8+0pt4rqgVFInq9Q2eNvyeRpU9gRvdCT+6G5
	uFuPTjU+s8IVsN+lWtZ0rQu6og==
X-Google-Smtp-Source: AGHT+IEjl9xTSxaTjSGOhsT+djt9EE92dLaCdjaBBcWXQlOokO3ydPeVV30Ovn5eRsDFYTgXpo5Ndw==
X-Received: by 2002:a05:600c:1c16:b0:40c:2b5f:7166 with SMTP id j22-20020a05600c1c1600b0040c2b5f7166mr2191122wms.122.1702294970301;
        Mon, 11 Dec 2023 03:42:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:9cd0:1672:92a3:a827? ([2001:8b0:aba:5f3c:9cd0:1672:92a3:a827])
        by smtp.gmail.com with ESMTPSA id fk10-20020a05600c0cca00b0040b3d8907fesm12822695wmb.29.2023.12.11.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:42:50 -0800 (PST)
Message-ID: <abe29b7c57c51807d6a6ff55dd6a384610962fc9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [toaster][PATCHv5 1/1] toaster: Added new
 feature to import eventlogs from command line into toaster using replay
 functionality
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alexandre.belloni@bootlin.com, Marlon Rodriguez Garcia
	 <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Date: Mon, 11 Dec 2023 11:42:46 +0000
In-Reply-To: <2023121110592609a251b0@mail.local>
References: 
	<20231211030706.108629-1-marlon.rodriguez-garcia@savoirfairelinux.com>
	 <20231211030706.108629-2-marlon.rodriguez-garcia@savoirfairelinux.com>
	 <2023121110592609a251b0@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Dec 2023 11:42:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15647

On Mon, 2023-12-11 at 11:59 +0100, Alexandre Belloni via
lists.openembedded.org wrote:
> Hello,
>=20
> This doesn't applied on master, can you rebase?

In the interests of time, I've sorted this on master-next. I also
trimmed out the trailing whitespace.

Cheers,

Richard

