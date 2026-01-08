Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D1ED1D495
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 21:13:04 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17394.1767906774816429431
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 13:12:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jGrL+rT+;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed9c19248bso33517041cf.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 13:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767906774; x=1768511574; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1WldC55/SY4jX5pu+ZIMUQdXV6+dapYmldsBj+bpqRs=;
        b=jGrL+rT+RlXPhKZ75/Lm+USGiEQbi44X76vMTHQAW5zRFtNnwFmxs7wBAAokTxAYZZ
         ouaRvAbRmMlbxtpRzdF7X1C1kRMarfRnY5ktnJw8fKL6go90/K47Yxxt0FRbzUaxA9ZQ
         vylbuj0iXHtZ9dHTmxjwRjlB0twoEhffL5HkWyjABfAgomg/5UC8x76NsIGYwNRZ9zem
         6WwuEe4X2ZzYWAC6DCLtaYEQr70elhV0zRqjSfNttKcY+FPZCper7/+feiXZ+diMygk/
         emZB8Q+TiMtvFlmMFu4QUvx4y6bFf+xMUeEH3Qtf98MWiJoM7DS9lKxqf746OLobpKoE
         w1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767906774; x=1768511574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WldC55/SY4jX5pu+ZIMUQdXV6+dapYmldsBj+bpqRs=;
        b=RNPSJuzjZzjdPCujpe6fYlYbld5gbfklvjWKmrdVg/td2XXFByc26Sqhm6A5T1WFMU
         XZbCsaMBP29FyFkDmA8sDiyVZ5o0cOlp0ZxiSQ8t3FJUQ/1J4TN3AD/aZUqLOCIeBBFw
         VaxJ0qd+KxKqScoWbYM7r/sPv3iTUIU6Pw9KmdWM3WCS+/CfrUgxdtnDKOEW7EOokQe6
         OyN7Svdm7o0i+DNholERLzzPJX+QmmsiTUFAl/vCPlO0W/el+MDLnFd7PHk94RQwM4OS
         RcGJGIvLxWI5CLJqkCmDRgoHQsvW7QUlxxtEw3OPgIzB/O7sLO0wdiYDgTtWNquaF3P4
         6sIA==
X-Gm-Message-State: AOJu0YxXPjP7z+LmXfwwzVp486yV0K0CloD1YatKwg1k7JuR56IIIhxO
	eBWG7xUvldoTaDlUWALeAS+Z3bM4NR7izMLmVBv2Dgly+m65whncUtX3hntoI5iOPNkBeFbzeh7
	9mJokaETV7Dl2+gpVRZXJqc3v0Rj4Jas=
X-Gm-Gg: AY/fxX5xiHpwV76sEUEfoIio+r4SHBNeAyx1HHlv7j3DuxlwK9KLrhosm5YFuqN5vdM
	CrkQfqx9+kUuzofQak8nb2frr8f9gogSPlRSBdnPTkm0biN1moYt9mmDK0uNMeu/pwXg7J07OhH
	1QNalQBwkX1grhsZHjrl8CYRNodqDWpqRYcrUls/fPVZVe4b4Igp2+FZqNQPEkJNIU6ZdxCjSZ2
	DWwABD1DSYMJ7PGdbHfeEXuNKX2HYn2Hl6lwTom0dk43CLCL+KamLlneun/2bWx82xPt0+idXOc
	gp8ZqfzKdzVpO6EkttteZrsVaMVXyPOeqeVawFgD
X-Google-Smtp-Source: AGHT+IEMWd03uYLTZXkdk2gWlNIjy0jEAppduiH504vEgmP+GAP3A6/9OEa599YAftjAlJjovCJUMWvP5DKEFFins5E=
X-Received: by 2002:a05:622a:4897:b0:4ed:aa7b:db9a with SMTP id
 d75a77b69052e-4ffb4b5a722mr104582661cf.79.1767906773678; Thu, 08 Jan 2026
 13:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20260106121033.3892596-1-alex.kanavin@gmail.com> <2854f27b68c3e3bfaf897fdbfcc97ae715d3e96e.camel@pbarker.dev>
In-Reply-To: <2854f27b68c3e3bfaf897fdbfcc97ae715d3e96e.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 8 Jan 2026 22:12:42 +0100
X-Gm-Features: AQt7F2o4keYFDQOWdb-AzwfJLDasto5QX56m7MslW55raMaG6LamMmc6GQEzPZM
Message-ID: <CANNYZj85QowkLYfWY5n87LXM1c-FWiO=EriwjN2pJL=yGs9Vyw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 01/10] bitbake-setup: move the local
 source tests to the end
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 21:13:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18715

On Thu, 8 Jan 2026 at 16:17, Paul Barker <paul@pbarker.dev> wrote:

> We do have a single very long test case covering bitbake-setup here. We
> should think about splitting it up into separate test cases in the
> future so that pass/fail results are more specific and easier to triage.

Yes. Writing elegant, well-structured test cases is hard, especially
if it's been growing ad hoc.

It's not immediately obvious how to split into test cases: the test
sequence is very linear in the sense that it sets up synthetic input
data, then runs init on a number of configurations, then tries various
update scenarios on those configurations. I'd like to cross out
everything on TODO (and fix the timestamp bug), then I'll look into
it. Or you can take it up!

Alex

