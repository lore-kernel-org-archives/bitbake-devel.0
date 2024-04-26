Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213B8C04FFE
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 17:52:28 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.2529.1714153942381438660
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 10:52:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nVky2Fio;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso38243911fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714153940; x=1714758740; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/h8gZGjsUD0DcFdrMcpFpo9SUYjUzURhMkaL1tHQFo=;
        b=nVky2FiomU61Z+KNSlTLBNNf/rAeAMN0Kad/Cb/uAmmpiyXF3MJbe+AlgCBW6aMk0E
         u478MPuESGlqfoZb3HNs4gvUszOK+DqdQ92UN5fbr2gcx0ejGtfUEHyUTCWZArfBKdY3
         ddSa3UShvOAa8MafJi8RhnhU/Xc+/p9ZL8BvL8A109XGvItmbnn5ijMxnM/gxi22/MQj
         JZXMnpsZh592z8WZkmCb7ifHY2jX1mHXq1/VdcydCN8cA12g6pPvGsj9THsnlW4DuxbQ
         KFD6mXXC+piqdMRKPlTWNzPVf+wSmspRKIJSz3RbrcGAwZiE6ibB3NyHxIY12ZdAUB1C
         mpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714153940; x=1714758740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/h8gZGjsUD0DcFdrMcpFpo9SUYjUzURhMkaL1tHQFo=;
        b=Ki+8rVvIM2U/Tc1HVZc55VmNHsGXQEljgSnWM6aSZmv+ZcCbr+2YB3KdOgUtvUgk6A
         1aa0gFg+SUPhbWZ6aBuoVeSpV51j6v169oxSvSlxol3qT5izVM5cr3HleUqTWHH750Fc
         4TI4FSzv4Mzc46PW1l5QkTupyq+g0/yX7HhD0ojptIXrwwowLG34MwPURpts9qjOkzQp
         vZiaVtcjL7hEf3K67K5+RyNgZ1gF1qB3O5WYrMXl3GeNeZ+4UHhXLDJ6NVFWAk5BkSgN
         VGIXPpbdaDBUuYDqdGfgPZbpWNXOqr6xKUzICgycTk2d5w7OhqNTvQA2GQhei7vOxhKa
         L1tw==
X-Gm-Message-State: AOJu0YyYWhZNaPd1OQlT3jvIO+ow4uuJhxLcAmt5wTP5tFg5wr8VUGaf
	WIMkPN7jN2FHIegP4k/zkjDWBqtuOybmMdSy//olyLlnYpmkSe2sVVhQECwihdwZsoLRrxPayxD
	Sb3S1RNbtW9ZUf+aKHzU+aQr8ALg=
X-Google-Smtp-Source: AGHT+IFrTHtKwnSPN+bhj9zRDewgjkwFbiQl/wVou0UGHMbyroUOsbthF0vEGZSafdU4yMZ0DyipekOCAvOUuUb0nII=
X-Received: by 2002:a2e:978c:0:b0:2de:ca7f:c849 with SMTP id
 y12-20020a2e978c000000b002deca7fc849mr2652450lji.43.1714153940277; Fri, 26
 Apr 2024 10:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240423182543.226113-1-JPEWhacker@gmail.com> <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org> <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
 <17C9D59E2FED0839.6322@lists.openembedded.org> <17C9D5CD5F9CF1DF.16940@lists.openembedded.org>
 <a165f4b7-1317-4163-98a7-7ccfaf055485@bootlin.com>
In-Reply-To: <a165f4b7-1317-4163-98a7-7ccfaf055485@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 26 Apr 2024 11:52:08 -0600
Message-ID: <CAJdd5GbAYdDEicvpejLmE6pkapOCkRvHQa-9vTiX3Xt2b=suqA@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 17:52:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16145

On Fri, Apr 26, 2024 at 7:50=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
>
> On 4/26/24 at 14:56, Michael Opdenacker via lists.openembedded.org wrote:
> >
> > On 4/26/24 at 14:53, Michael Opdenacker via lists.openembedded.org wrot=
e:
> >> By the way, I still had empty databases after leaving the tests, but
> >> adding:
> >> self.conn.commit()
> >> after a group or INSERT or UPDATE commands did the trick.
> >
> >
> > For the record, my database was created with the below settings:
> >
> > self.connection.execute("PRAGMA synchronous =3D NORMAL;")
> > self.connection.execute("PRAGMA journal_mode =3D WAL;")
>
> Oh, forget it, it's gone again (databases being empty again). Maybe, I
> looked too quickly.
> I'll keep investigating and will keep you posted.

I'm thinking something else is wrong then (maybe in the test setup?).
The original code as I read it would probably have had some sort of
database error due to the exclusive lock instead of just being empty,
and I can't think of any case in the new code where the database would
just appear empty if both servers are actually pointing to the same
database

> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

