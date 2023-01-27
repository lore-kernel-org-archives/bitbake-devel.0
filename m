Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6982CC38142
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 13:27:10 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.101762.1674826022945051767
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jan 2023 05:27:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=X6PiczEY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so3466377wms.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8X38gAMa1AbdBl5juLSTsRb1YhWkifaO4BeTin/MLT0=;
        b=X6PiczEY1DDo6jBgCh2DHdrB0dqFmF0MQ1buo2a+5iUfnIELkbosuZI8ACXasIMuQL
         BciTF8fOc/bT9rBzGIxMe03JHFC08r7TBVYvsj2HfQuLvgwXrQz6ShbhF0yRx16EDwB+
         9lAzzjTXzammQzkEvfBhQUBxXP+oJ7vAK885w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8X38gAMa1AbdBl5juLSTsRb1YhWkifaO4BeTin/MLT0=;
        b=tpdOn4I001pCSM/6vGxGZEdjl/kusB/gcMN8iLBL/FA0TYURoKLrlIX3gkqgVAdmtU
         X5yokL9E2lI5NrozSD2JQl3beO7IFwbR017oDa6zc5EBHhpDTgnNgm73qFyrTjiTRyoN
         xCAya1rXjVZfLPHWnscEfXwou9BD0VtO0wThokE+zz+hX9aHJv22Z7LvPXNjjCT+Gcw7
         sjQZV15vohCx1gSmyheSrXXxzHWdcCLk9ZGBNkxymxwwp88oNxkRIbIpbFTXY+emgzRF
         8X9Obdsy3cTJFohov5c24UQRddYNdGWkwSdNhXb71hRAr7Wj9G26Bh1cGNoI1yp1mA1N
         UnAQ==
X-Gm-Message-State: AFqh2kpgc388ELC3/lf6TYgU+JRLqXoaAEIdO6TdvaRblHq5g005r7Ny
	teUE/kHOqmGHRpBUkGwlDyVhRA==
X-Google-Smtp-Source: AMrXdXu6GV+/xxM6JYZmYZsdTbaO+IISD45LsePFMc9dtzJkYzUU1oaXS3215e6xxR4Ni8K3SAlDEA==
X-Received: by 2002:a05:600c:539a:b0:3d9:ef72:190d with SMTP id hg26-20020a05600c539a00b003d9ef72190dmr38251301wmb.19.1674826021053;
        Fri, 27 Jan 2023 05:27:01 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3876:ca46:43a6:4b49? ([2001:8b0:aba:5f3c:3876:ca46:43a6:4b49])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c26d200b003da28dfdedcsm5095141wmv.5.2023.01.27.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:27:00 -0800 (PST)
Message-ID: <5d50798e294101e1135f980e7576fa77a72ba844.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] Saving off warnings to a separate file
 with Python structured logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: quentin.schulz@theobroma-systems.com, Joshua Watt
 <JPEWhacker@gmail.com>,  bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>, Michael Opdenacker
	 <michael.opdenacker@bootlin.com>
Date: Fri, 27 Jan 2023 13:26:59 +0000
In-Reply-To: <d2858712-723b-bb6a-d1a7-6e2a134ced97@theobroma-systems.com>
References: <3c606d49-77d9-d89f-4d8d-96cb0a36f620@gmail.com>
	 <d2858712-723b-bb6a-d1a7-6e2a134ced97@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 13:27:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14359

On Fri, 2023-01-27 at 14:24 +0100, Quentin Schulz via
lists.yoctoproject.org wrote:
> Hi Joshua,
>=20
> This seems to be too valuable information to be lost in the mailing list=
=20
> archives. Any chance of having this somewhere in the bitbake/yocto docs?
>=20
> Cc'ing Michael and the docs mailing list on this.

The context was that we discussed this in triage yesterday and said
making this public was the first step but then we'd document it in the
manuals. Michael was on that call so knows about it! :)

Cheers,

Richard



