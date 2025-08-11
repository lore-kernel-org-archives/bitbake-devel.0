Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC7CA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:04:54 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.43431.1754899486603036900
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 01:04:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZrSEjsrs;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70749d4c5b5so35948326d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899485; x=1755504285; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWH1aNFbUFo1AM2Q8xPAN0VJyhsXVTvdpOF1E/B7yNU=;
        b=ZrSEjsrs8DzGmwedheWJAo9rG5FozV5mWJ3dElXr0/LX5TLEpJbhHL4CS9uZkLRJ1K
         mUlVi5kARzvLtrxAsB0CFjuPaRH3xcLWQkybajG66ev+DPcFWd7O2ugg+3EOOd8c8+U3
         fI/P567K4ITPauCsTCrNNbYnJ3sbR70T0XrQwpUPzDl8QJ3haZxyh3ZTbTO9PNU4Rj6Y
         YENMiuG1Irw0b4pAvzCyqXXSWM1P2DzbOfJ107dApWCGDBCzxWk7U4dJliPcejAEXyJh
         PsTyrmucDqWP9kNmZfnVVJ+ItVRnO1dTse4CMjg+rGVO0w+LSJdXGTCh2etKWLY4eXVi
         uWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899485; x=1755504285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWH1aNFbUFo1AM2Q8xPAN0VJyhsXVTvdpOF1E/B7yNU=;
        b=EFKUczSl8Z5W99tqFVesjYbFhKMkst/3jmXcbkLDNtyWa7kze8/pQzv0b9y7kIrQMc
         lDLnA7y+ews41scEXGjlKzjLrkjfHDg1Wf8Jm9fSomzncevfvvj2/gFiEJ26hLdaiUqh
         Dnk49d/hXqv4WLNWs54bfmelcurxQmKOHAGT8HUtbIWFYanG8laJ8s22FnkIy6MIGKQz
         vF1/93z8Yx8o35mz46whpK1p5fY/BaD+NO1NchnZYpwl4aCRgcXWlvOVp5gteecitCxn
         vzdb7UnZb5nLNwfDuU+oB9zAvU04hjpVTw3sQCAPOMB9AtoM8IYF2cJC+KD3K7P/LkAX
         M/cg==
X-Gm-Message-State: AOJu0YyxUSmCHERTJfTgXHiS1EIMul8anRWeH82ubkj3pc3K9GgB0aGX
	k6ORawPKu0RCpt9LiPheWvQVL6ZfLmuRyvP7Gu2chVzPpKgxmZ0J2RTvyOqEdXG7g9QbJDMCutz
	BdvxlK/CIzppWtpK281wym2v1xBXg1Uc=
X-Gm-Gg: ASbGncs6dVPs0u9FtTSdyTKTYixBsorHc60cD2ImVPV3lXhYM+5f3D/DDLSieyUwMEo
	OHn7JgjjZiJfiFMlKkrgVsqnCpd1VpT9TJVjb9mPO2p99NU6+7ef9jkk8Dy1Hjt1Sx3AxWvM68b
	ZWtQbXudwDrDDG2Ec6STPXgc6dnXWuqAzfqQH7am6L9YzdOYWnzvAghZ2IuJLZpq3ZUurJMGzEq
	vlW6T0=
X-Google-Smtp-Source: AGHT+IFIvl8vVVseFqNOUsQN4yRlV9uR/MkKVMjiNeyc6Vxr1dfVwVt00/Qva8mIZyLiO638v5uo7mLRDdy52PLaUcI=
X-Received: by 2002:a05:6214:27e4:b0:707:1b3c:4124 with SMTP id
 6a1803df08f44-7099a2a08f8mr186419366d6.6.1754899485277; Mon, 11 Aug 2025
 01:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754898959.git.liezhi.yang@windriver.com> <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
In-Reply-To: <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 11 Aug 2025 10:04:33 +0200
X-Gm-Features: Ac12FXyhq5KfWRUrGmOxbRhw7aoRdZrrduCn7RnHIYpIGsMfNQdtfc834xIwLx0
Message-ID: <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: try_mirrors(): Skip invalid
 local url
To: liezhi.yang@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:04:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17855

On Mon, 11 Aug 2025 at 09:58, Robert Yang via lists.openembedded.org
<liezhi.yang=windriver.com@lists.openembedded.org> wrote:
> Skip fetching from an invalid local url since it would be failed.
> -        ret = try_mirror_url(fetch, origud, uds[index], ld, check)
> +        ud = uds[index]
> +        # Skip fetching it when the local url's path doesn't exist
> +        if ud.parm.get('protocol', '') == 'file' and not os.path.exists(ud.path):
> +            continue
> +        ret = try_mirror_url(fetch, origud, ud, ld, check)

Can you please explain the use case? I'd think failing is the correct
action, so that the invalid url can be removed from configuration.

Alex

