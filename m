Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E216C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 11:05:49 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.47900.1700478342048561243
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 03:05:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yr5p9rmr;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso53528201fa.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700478340; x=1701083140; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9btLPb17pFp5z8WggZCmSZ2ZC7r4WYiLtQaC4XzlMpU=;
        b=Yr5p9rmr3tXoPPsMoYeYYnDwmTyODi2Bu8x5+RYSDOSIOoDtX2Q2YXndiD4HOMT1tt
         iMMJagxNPE8bMn2bL8kx5iod9Y0DpZCD4nOqEUYFGQSz8haOK8c0n2INGnuRstpcmqbb
         3GXztLksfqSNONiETg7fWeGd79K7WXwQpttIC3pq7zfNhb5CYKWhLi74crh3KPqU3yQ8
         2uz8If4AY84ql0Y+kStJcnTyz10s6UgvdXiurGcCse7jbEdnv0I3hIrYpL4gMzYUCeIO
         5mUsTH1Axi5ZHLqeWBVUwSSGHZ6/EA9h1rEzI1c0unESg5H81I+jibC1ciNVF81QsPZU
         JfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478340; x=1701083140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9btLPb17pFp5z8WggZCmSZ2ZC7r4WYiLtQaC4XzlMpU=;
        b=gAr6wiknOiKulc0WF8WxPXXC5M3/OJKRs1x1RLHQNuQKAwbvlMkMQfPj8E7PzcZa6e
         S/Cm662pIwsSS9B9ogypxy6IR/VSdt90emhhN7xZrmx8uajEHef5X/uRmcSLWQKm2k1G
         Jjv5PaldZ0+lpBD4MDRJm0v7h3uEblFD5BXyJ5DJ/O508MlGmvv6vQuGyEsN2N4G9+S6
         i+6D3u1+zsDLusiyGjXe9PLeNnWOxBdfALws/q6StQrBET328pY/EHN4jJfmQG54mhAj
         lWJGnrhEapDdmKooH1EHykMd/6lSBCUnKcQ52FEAPTvyBSsm9atHFEY3x9KkJxnTc8Qy
         b0JQ==
X-Gm-Message-State: AOJu0YwoCh16Cnrb3h2QdU/H63AVLxriCAyXlv3DcVX9Dn30GPi8Lb1P
	5+hdgo9UFI23XhHx1VqMwssVkqTVcfl/vkU9k82hA1qb
X-Google-Smtp-Source: AGHT+IEZeQwtgTGEsuz0dojVVIys5i6834z7vaAKyHUlWVXnr9SXDs1I167qA/g1gsxKpoltB+HtExpBpdmTBebdoTM=
X-Received: by 2002:a2e:3c02:0:b0:2c7:610:2dd1 with SMTP id
 j2-20020a2e3c02000000b002c706102dd1mr4846091lja.47.1700478339780; Mon, 20 Nov
 2023 03:05:39 -0800 (PST)
MIME-Version: 1.0
References: <4851356.GXAFRqVoOG@n95hx1g2>
In-Reply-To: <4851356.GXAFRqVoOG@n95hx1g2>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 20 Nov 2023 12:05:28 +0100
Message-ID: <CANNYZj-cc2wDXUODqveROB6Hdpr0CnHoNLt49Nywfcpgs_19xA@mail.gmail.com>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline" builds?
To: Christian Eggers <ceggers@arri.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006412b0060a937792"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 11:05:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15533

--0000000000006412b0060a937792
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 11:59, Christian Eggers <ceggers@arri.de> wrote:

> When having NPM based application in my SDK (e.g. quicktype [1], recipe is
> attached), the "fetch" tasks perform a full build of nodejs before starting
> the actual download of the quicktype sources. But building nodejs (and its
> dependencies) during the "fetch" stage, compromises my wish to perform the
> actual build in an offline environment.
>

I'm not sure I understand what is being compromised here. If you want an
offline build, throw away the sstate cache that was created in the fetching
step, and nodejs will be again rebuilt together with everything else.

Alex

--0000000000006412b0060a937792
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, 20 Nov 2023 at 11:59, Christian Eggers &lt;<a href=3D"mailto=
:ceggers@arri.de">ceggers@arri.de</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><div>When having NPM based applicatio=
n in my SDK (e.g. quicktype [1], recipe is<br>attached), the &quot;fetch&qu=
ot; tasks perform a full build of nodejs before starting<br>the actual down=
load of the quicktype sources. But building nodejs (and its<br>dependencies=
) during the &quot;fetch&quot; stage, compromises my wish to perform the<br=
>actual build in an offline environment.<br></div></div></blockquote></div>=
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">I&#39;m not=
 sure I understand what is being compromised here. If you want an offline b=
uild, throw away the sstate cache that was created in the fetching step, an=
d nodejs will be again rebuilt together with everything else.</div><div cla=
ss=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Alex<br></div></div=
>

--0000000000006412b0060a937792--

