Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B1C4332F
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 00:50:30 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.25197.1672620624903306647
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Jan 2023 16:50:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hCoB9+U+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id z16so8561845wrw.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 01 Jan 2023 16:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEqAWHPXvS7pp9Bxt/IKB3VXxB2ni1+yseS0cR0wG94=;
        b=hCoB9+U+Isg5Q/OQJQayztmBXEbcrV588TNDwtJv3AAZ9ziL+uht3zOtt7WwBUQF5Y
         geaWErrgShsQp6JI+BW9hgukXrymKNv/iW/mD5QATaBPcIyhBLsOmXZOJ/yDBuB1VpfO
         yNGUXpDXdzly2yomjFAvIkmr98FYacfimsfI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEqAWHPXvS7pp9Bxt/IKB3VXxB2ni1+yseS0cR0wG94=;
        b=etrgCIf76WQeklFuQH1LoEk+9DfQ+BxbIEiqqFCvgcN4LUPlaGBHFkGaWCCmp1zjxZ
         TmoX54cugHvN0oyHSDZYYLsHtgVkIjAgnw/5WDgaBnp1PHH/yyUlpX/oIrgdQBJecmzd
         H4kksqdzUx2Qq6iGknqf7EefFkoZNxUhdjddDaqcgw/UsFsT+OX7XHHFoD/u94S7cQDA
         JZPSJwQwpZfTHobY89vEuETUC+qRMo69fr0k+N2kH4kmjBelauWZkK3///LC8oEsWxWf
         fEvkwBhu1FyrYYkiaa+2bjZKTcl+E6h7bH0sJlAzdP4F+Dld3hysyAIrBgVRL8AUbRBE
         xv0A==
X-Gm-Message-State: AFqh2kqnytnJWPDu6xBBPn+ONNeFl2jeCy4IP230mi+2tucu24kpjA0Y
	S0QpCNxeiBy7NQAUewhiinlAhQ==
X-Google-Smtp-Source: AMrXdXvOmYjPnXYtVb1IF6cEpn+GK4qKlDcqxGbrWeE7QyKcJL7iwDs7gv30JwMNw0DgHSZ8bqXe9A==
X-Received: by 2002:a05:6000:10d2:b0:299:4e2f:fca6 with SMTP id b18-20020a05600010d200b002994e2ffca6mr1298292wrx.58.1672620622381;
        Sun, 01 Jan 2023 16:50:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:409d:216c:1a2:8d83? ([2001:8b0:aba:5f3c:409d:216c:1a2:8d83])
        by smtp.gmail.com with ESMTPSA id s18-20020adfdb12000000b00241fde8fe04sm27327153wri.7.2023.01.01.16.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 16:50:21 -0800 (PST)
Message-ID: <9d512b49ed3254cc9ef67f21cc1a0facdaff9479.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Fix cache/reparsing issue
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jan 2023 00:50:21 +0000
In-Reply-To: <59224516-17d8-4c43-9f2b-38c5034cfdba@Spark>
References: <20230101142509.1022073-1-richard.purdie@linuxfoundation.org>
	 <59224516-17d8-4c43-9f2b-38c5034cfdba@Spark>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 00:50:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14275

On Sun, 2023-01-01 at 09:55 -0700, Christopher Larson wrote:
> On Jan 1, 2023 at 7:25 AM -0700, Richard Purdie
> <richard.purdie@linuxfoundation.org>, wrote:
> > When setting the LAYERSERIES_COMPAT and LAYERSERIES_CORENAMES
> > variables,
> > we need to be deterministic. The random ordering from the sets was
> > causing
> > unexpected reparses.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > lib/bb/cookerdata.py | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > index b4e0c4216b..8198f509e2 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -425,7 +425,7 @@ class CookerDataBuilder(object):
> > data.delVar('LAYERDIR_RE')
> > data.delVar('LAYERDIR')
> > for c in compat_entries:
> > - data.setVar("LAYERSERIES_COMPAT_%s" % c, compat_entries[c])
> > + data.setVar("LAYERSERIES_COMPAT_%s" % c,
> > sorted(compat_entries[c]))
>=20
>=20
> Missed a =E2=80=9C =E2=80=9C.join() here, it=E2=80=99s currently setting =
the variable to a
> generator object, afaik :)

Well spotted, fix pushed, thanks.

Cheers,

Richard

