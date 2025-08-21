Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892D1CA0EF8
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 14:21:42 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web11.10922.1755786095951748598
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 07:21:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gi9n/3IR;
 spf=pass (domain: gmail.com, ip: 209.85.219.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e94eb6b811aso888750276.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755786095; x=1756390895; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aGl6pMCVZM+RAyDFTrmSYrE9XQtZa5zcAArGigBh6Rg=;
        b=gi9n/3IRqc7aVJvWnhcynYYFNcKGnypeXB0BsdqeLeT8w/QaIivNsbt/8m3EGDjaBD
         BOK4iPka6rJTtjerWBRPe+IncBv0DTRArkf1ZMcVVNMMA5ucC4SWlacHH6p6EVsxpuLx
         25c2flTK0EKdAF/enrzXD1KB+N2z8R10WkWnZ5Zh3faFdAMcLZJTS3GoMnf7kgv3pWZx
         9a7p3h54f+3z2ibv9A1WhQHyIAUcvSl9B8gSTWxzFQiE+PjBC9hO1lJBGL46v7oyXPfk
         UU6GPQn0HolvpkfJs8Y4fSIAvP94kRBgD5ti7rKLwB0sj+QOME2V8LIpsGDMfYggV7gi
         s5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786095; x=1756390895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGl6pMCVZM+RAyDFTrmSYrE9XQtZa5zcAArGigBh6Rg=;
        b=dLhWhbHvz+MoC64U24BeZrxD1JKEzR8Jf7WHD/N3h9akjvLdO9C5ua7rQQoAGrPE0/
         EDBhKwsxsHTfu1HIw1YNqXBj1Dzh3UdSSFO0MXSQqMxKz6TN8g0r9NVnY2iIBG+XsmSl
         MzFZOw5s9eUoOKbDoKNTLy/OvLWiY6CLHTXedj5QZpd3j1JQrwIL6ewpFKPRoHoqcf1C
         iAm5Nad7vHqGu8HDRg4SL8Ci4TwDVRTw36eGYtniaz5Lb1xDgDUzJbCK+011dQadd6lb
         ud1uwmes251cRV/lPJcaERphq689lv9+7hm3aGpx++zCNsq1iMzLMA3YsCnfdcCPENL2
         EaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXee5xA0ZsVo8KnutxHwFyPaq+PEHzCmqjxkdH0aFH3dlGS31GgT0wyiU9RA23n7z0qFQIdA/4D88upIIcw@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxv23TB2aLNulScMBXgcr7/joqz0yaUA0sSqR/q3ahuGr5Dmc94
	53KwNgySsEMaHlTijJGevGBs0pSb94c0kdNw1wH93ejkCOtkpzVrGTAZyw7ifnL4fUgEmmiV4XM
	m8SBRnfjbORz0IggVKHzf6Ahj8IGjdHs=
X-Gm-Gg: ASbGncuaHmffFWz5f14cmJudi8KbrTQtwDlvKwZ0I/U1FzFPxbHcdmcATwCi2dHa248
	4JFOdbufKTQZQrmDuqMTbxH/vtC8ufVKwjWlvFMTxU9cemrc5sn1gLmTMygO7atz9/8EmlcPXTE
	2mimZaeM1Bs/MpTSk53YtdpeoAxK4IsVurx8X4+uPdn4+aERigIkGvCbBUiAIngqR2W80xAOFS5
	ty2Fe4nJmY6WwRnkumwVdwEVNzxxxxLjiMqYTCecA==
X-Google-Smtp-Source: AGHT+IELYiTjz6W5rDrUMWh9sjEYMzbbf7FQdrIZY66Nw1mUD7O3r5wSMOOq+v3/kjt16HT0zF44zyrNWKQg7oc7F/c=
X-Received: by 2002:a05:6902:230b:b0:e94:e1e4:581b with SMTP id
 3f1490d57ef6-e9509ba7967mr3064339276.52.1755786094932; Thu, 21 Aug 2025
 07:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250821130715.1904574-1-alex.kanavin@gmail.com>
 <9cfa7c31-cbbc-43a3-a65b-fcb9984c6757@gmail.com> <185DCE00410AEB1B.11247@lists.openembedded.org>
In-Reply-To: <185DCE00410AEB1B.11247@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 21 Aug 2025 16:21:22 +0200
X-Gm-Features: Ac12FXxrfG3VhYrSeRdJNg_QbXjVDeLpKsxEWiW8tJq9G63TwieNnY3AXCRKqfc
Message-ID: <CANNYZj-j5KLGwhzCHyU1t_+gVr=tVF8CTtc4+FpR6eOhgq6E-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: alex.kanavin@gmail.com
Cc: Gyorgy Sarvari <skandigraun@gmail.com>, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 14:21:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17908

On Thu, 21 Aug 2025 at 16:18, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> > > +    bb.process.run("git -C {} init -b main".format(confdir))
> > > +    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
> >
> > Possible bug: This throws an error if git email and name are not
> > configured ("Author identity unknown"). I tried "bitbake-setup init" in
> > a docker image, where I use git with untouched config. But when I ran
> > the same command right away once again, it succeeded, saying that it was
> > already initialized
>
> Yes. bitbake-setup assumes that 'git init' and 'git commit' work, as
> it maintains a local history of configuration revisions with it. Can
> you look into how this can be better handled?

I suspect this can be fixed by passing a hardcoded --author=...
parameter to git commit. Can you check if that works?

Alex

