Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D2CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 08:42:19 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.11955.1758616936109643222
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Sep 2025 01:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CHvVu8da;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46c889b310dso22987875e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758616934; x=1759221734; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncX5gLxpcYVCgU0FrLvhFQjgOKQRy7D3zldxEGQipzo=;
        b=CHvVu8dapAxASf9wY2Fldqu4YtOWytRCXGR6OQ0vSMdv1vtY+YbbahNI2T8okapUVr
         gFPBArDuNG/og3SCBGQroQepPOJsEDaanLW2KYKtr8CYMfcrH/na0zkNmq43nP0z0aDy
         UQ533gb49UXBWX3+2tqmPe0YULs/ud/jAUGx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616934; x=1759221734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncX5gLxpcYVCgU0FrLvhFQjgOKQRy7D3zldxEGQipzo=;
        b=TJOUzSs1FbBVQMYXV9YDYPPTojcR+igKKrdLHqy/aKgQZAjHGwz+1BKaUfukAB6o3h
         QodqL3V/7mwtX2zpz35a6Mo858FIp23B2CZcy/Y8KO/6PKgvW207Vg0Wz23QgQe/De7g
         St1L/4MOM9V6Pb8+FuVnoVvt8nUfxz4YslrPLUy29oLgAaNMiXdwWgbNrYaBTThAr/xW
         TyGfvNw9fMxKteYU1uGmuB+bAO/5JtytwU4kp66sTlfCR9KzIaghMJR8S71X9J3uegsP
         FftZYyF2/HZu1qMlXqeTRMmXPQGRXlb/yJp+nXTh7hSncmEWe5Km47aIIakHoI2euGd4
         xacA==
X-Forwarded-Encrypted: i=1; AJvYcCX8aZhqwf3kPYcGxXe7IZgl87o5zZoP6OlS3XvJpmxmPvajrSy3Xtl4GbLLNydz+vDRxvxjc41Cp1gBWS0w@lists.openembedded.org
X-Gm-Message-State: AOJu0YwGHY7toZlg7cpoBlFZVHk8ndN3RvQ9kyDNfxQMrLxCglBPzOS/
	tf2w8+j0nLA8XoUqgvQ9ttVhWIsEYCf3QS9NJHCN5myfXx0SjfNeX13rJXly3x27PKM=
X-Gm-Gg: ASbGncsQimaESjvJYeKawg5Q8l6axpwAw3FfuOXGberjbC5EE4jpNLUiVx7slGVrpwt
	NmOoXxDP6KSNB3RxbYYBVQplJWZnJs/m0tdF0FUrkYkvCyksRGfaj0iREM3DELaAIZRD+GqaFPK
	5oboyDcScTtOMgZXKgcUT9tCZMPzHXdc8ah/bRUNS6q+OOTXdFN9AJN4iODausiXjeJmw/NUkaW
	I1dLEpeFowOCe7yABcjT5gFhlebj5ydquwzG/p0Bdz+Zv1frjuA+7BBB8oo5RLPM+gCn5v7tdqh
	59VNd1zAs1XzGbqpDfzhuZS4BMr5sOyXzY8SGoreIRKbBYoljbqOfM4XqFWxnZup+txs+ZWAN+P
	D9cY+6L2sNel6GEItJphq6l3M1+8EaP3l9zn4XitFtbW1pWOEgkjvqtb+a95kGujLcPrIt80QlP
	RCuLRcU4uKm+8=
X-Google-Smtp-Source: AGHT+IEXKfddXj805p1kiNLUwu5fv/gzfjUDJ3Mb7K13tA+m7rVVuA7XWmj3sd5+BPcUX+anp3Qs5Q==
X-Received: by 2002:a05:600c:89a:b0:46d:38c4:1ac9 with SMTP id 5b1f17b1804b1-46e1e0f7c81mr10112605e9.2.1758616934473;
        Tue, 23 Sep 2025 01:42:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fe09:3ae7:900c:f751? ([2001:8b0:aba:5f3c:fe09:3ae7:900c:f751])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ce16406sm10347405e9.0.2025.09.23.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:42:13 -0700 (PDT)
Message-ID: <780bf8b5a76373ed64fa3ac1c8874a54176666cc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/repo: add support for fetching
 submodules
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: johanneskauffmann@hotmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 23 Sep 2025 09:42:12 +0100
In-Reply-To: <AM0PR02MB576490C2267B6F4B73E297DAA612A@AM0PR02MB5764.eurprd02.prod.outlook.com>
References: 
	<AM0PR02MB576490C2267B6F4B73E297DAA612A@AM0PR02MB5764.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 08:42:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18079

On Mon, 2025-09-22 at 09:47 +0200, Johannes Kauffmann via lists.openembedde=
d.org wrote:
> Add the fetch_submodules parameter, which allows fetching submodules of
> projects by passing the --fetch-submodules option to repo sync.
>=20
> Signed-off-by: Johannes Kauffmann <johanneskauffmann@hotmail.com>
> ---
> =C2=A0doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 +++-
> =C2=A0lib/bb/fetch2/repo.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 9 +++++++--
> =C2=A02 files changed, 10 insertions(+), 3 deletions(-)

This isn't as clear cut as you'd first think. How does this work with
mirroring with PREMIRRORS? Does the submodule inforation appear on
software manifests?

I'm a bit worried that this will allow information into the system
which doesn't follow the expected behaviour of fetchers :/

Cheers,

Richard

