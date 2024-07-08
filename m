Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020EAC3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 09:25:57 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.75746.1720430752216282229
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 02:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gT9J8eig;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9a920e73so4578274e87.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430750; x=1721035550; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SmrnYNkxrDRrA0HYMCKZ5CbjTSNwqdg+x/l84umVo+k=;
        b=gT9J8eigatQdRuJMKboeI0nfBCv0o8fgFayd2vBcIle/tscxobOW33o4l1e3ISQrtU
         cwJcCR9HT6RTn0O0f20ZVpp/5xWO6ZqyjXIMn44k1fKzV5dgo6da0c2Q0J+JBVFuUhSE
         w7wdhtGbuIdbAd+IgEdi+FpQHo+EG4WV2XHnnvizEu/t1phCIt+o3OGjnRau/Jb4FWdb
         ouiv81Vzc7nhI6ww9dNpBTqFyBdi4kZPWeOzAY4Xn/TddUZhGjdsqHC9PUtHRvN/+IAx
         Y3uYaHuPidWf9nhpSamJZjFpfQXjp/Hs9OFJyWkkoQhvXu91yHdwt4hDQ5stSQPIpn+l
         0LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430750; x=1721035550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmrnYNkxrDRrA0HYMCKZ5CbjTSNwqdg+x/l84umVo+k=;
        b=rDQW7eYdMRgJ+GGuFXeUDThNtNfPpjNlTFUAQ3j8Hck9bP9JTGhmJiUt7wr2ql9O76
         joISi/nMsUS4Y32S0YN8Qd/aDZ70L0kq9/Nv5qL8srBeyenpSMBBEtxygtdfZqyiTtX9
         IFz0P8iMMRGufNI2cUiCIVpADBTkCmwe8NlE6YrXVUGRIOUQG2zFvdOxhzOPtCpxbZFq
         VhS77twJFhSiDHLXgocYqZ6BofvazKmM2CpqDQdODD4ezNnqstxfAGAPJx+HDDFdPsW7
         arpI1Bs9d4s3sruXlpUV7FsdK8BrZoXPHy/QgJQ2dUBcjlZP6VB+1Jsm4AqvKNwn1/Im
         HdoA==
X-Forwarded-Encrypted: i=1; AJvYcCXJrmB+hSvdScxOf9iV7WBKrUZgVrX/DH3AR/b2M+QTZxRZgzurtqRGD3gtNKpP/0G1sJD7PVtbQ/T+cVjMVlmtAy90qTr+UbsXYvIdnY6irhYlsOM=
X-Gm-Message-State: AOJu0YxkrIyqRtP++/4PjNrHyhMO4JQBhVOIuazxH7/vkhYPh1U7B9sF
	DSCw6qxkK4xOkm9MUzS1ZSGrijHPej9aQWQSfz5s2riCmTEXHATE1924MwDaOVlTfc6ykjxfhTR
	oP7rTZPv0EvcSl3nSZbZNfG11/tM=
X-Google-Smtp-Source: AGHT+IHfiQ4ndDsaIqgC33xpNAuDJhioUT8J6FG0T9v7PAIMhcsqXQPHIXjPrbMJ9mFii8myMom1VBCuWVHIVT0r89Y=
X-Received: by 2002:a19:ee08:0:b0:52c:9383:4c16 with SMTP id
 2adb3069b0e04-52ea062dacamr7343043e87.22.1720430749732; Mon, 08 Jul 2024
 02:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240708081034.1474312-1-changqing.li@windriver.com>
 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com> <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
In-Reply-To: <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 8 Jul 2024 11:25:38 +0200
Message-ID: <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
To: ChenQi <Qi.Chen@windriver.com>
Cc: changqing.li@windriver.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 09:25:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16400

On Mon, 8 Jul 2024 at 11:12, ChenQi <Qi.Chen@windriver.com> wrote:
> This problem has reported to Ubuntu for 4 months. It was discussed on
> the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not
> very optimistic about getting a solution from Ubuntu.

I do not agree. The last comment  (#10, added two weeks ago) in
https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555 shows
how to create an apparmor profile specifically for bitbake, so once
this is added to apparmor upstream and makes its way into Ubuntu the
problem will be solved. At that point the forced network disabling
will become unnecessary and damaging. Ubuntu release notes imply
they've done it for things like Chrome and Discord, but they expect
more to be added:

https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements

Alex

