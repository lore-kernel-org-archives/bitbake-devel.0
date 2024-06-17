Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C3C27C6E
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 09:37:04 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web10.52764.1718617016358611188
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jun 2024 02:36:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WkEmoPRS;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso45943201fa.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718617014; x=1719221814; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cD3GzBAR9kbC7ZqCSzsrkSyXF6NwcDl+zpmvzUnW2Z8=;
        b=WkEmoPRSAFU/qtnCI9E/AakE3VVw8E/xrD8zL/6Qnnn3P/wepaiF3LjDEaLvOT4Nz0
         6QqcmK1YyZMbj5dm0ConDNNW9Tyn0F2djlDShmk7U8atWS3zObLIMo/pNL18qoglX3in
         Q/frVWj9w9avKa0+EmjIU39LVVCQfY/mO5LQHplr1sN/3YQzqkJzhhpysZTgzdxUzKYb
         F810nzfk4JBpCA9PYkGoSJrzvntRt66m4+zRvKSAlww55R6+XhvQdFehx/sl6HCSkhHw
         Y+FOT0hL+gQzRGleHwEzQZUWeFNDHlQSBMG7nJ9naqh6jtBQz9c9RaoWCUnvtnKoQ/1v
         Z07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617014; x=1719221814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD3GzBAR9kbC7ZqCSzsrkSyXF6NwcDl+zpmvzUnW2Z8=;
        b=eon9p4IK+ydsoS9BPUqhXcsEalb/Z+IvliZHRo3vQIzpiNI8dqZ3xStItihNprrD+Q
         SLZ7jF9AXSS55jdyj9piPWBrJD6FM3mb2F4uUFFwNyT/wKvPpN4aE/ohzrYQsbc4m33/
         TN5YU0s+K/fv7lxtAy5ZkdYiw15wHlWPbjICkAq2JPx6FVpWPiGTj+vk3a40wbTKqFC9
         +XiXejzQlGqfwlCjk7lAc8mrtcrnBG9X/qKt3LHXRomCYwzkvFEbVRJgXvazszaq7bsR
         jAMaQce8inittfvd0ZtMJWgFug/nFwPeuRSnOxpp/wRKEIxnZo8SrOxausFzoyrpazN3
         rguw==
X-Gm-Message-State: AOJu0YwsdcFPLgQqZ8SKvfYyVdUlYCyJ9AZZr+9mvpdB0hOlNVj9hdi9
	l9u6hYm+Vp34HGx05L6wEQqdkvm/kZTh8zHZPxRvLnvQfD4JAT8BE8Qze2GcaA7EPWTpX4HXFJ1
	hODnaZuIjuH3sur0j+9YLpZnyhcI=
X-Google-Smtp-Source: AGHT+IEgCkqtsm9Ir/fZW92MIvhP7itBpTyRIirpWtWXRN8kss8Zre4FQUWibduowW+5/8LN7FBtmJ25G7o/wJRDsn0=
X-Received: by 2002:a2e:95c9:0:b0:2ec:2e2c:7cdd with SMTP id
 38308e7fff4ca-2ec2e2c7d39mr11897781fa.3.1718617013954; Mon, 17 Jun 2024
 02:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20106.1718449089919947051@lists.openembedded.org> <Groupsio.1.20106.1718449089919947051@lists.openembedded.org>
In-Reply-To: <Groupsio.1.20106.1718449089919947051@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Jun 2024 11:36:51 +0200
Message-ID: <CANNYZj_t75pGbnAUvSvVzwvHgYz38Hg0cXt1E=X4dTxV=8WHVQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH v3] fetch2/wget: Add user_agent
 parameter so it can be used optionally
To: egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 09:37:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16359

On Sat, 15 Jun 2024 at 13:01, Livius via lists.openembedded.org
<egyszeregy=freemail.hu@lists.openembedded.org> wrote:
> In openjdk-8 272 recipe all of link are broken if wget downloading doeas not use any custom user-agent.
> https://layers.openembedded.org/layerindex/recipe/44301/
>
> does not work -> wget https://hg.openjdk.java.net/jdk8u/jdk8u/langtools/archive/jdk8u272-ga.tar.bz2
> works -> wget --user-agent='bitbake/2.8.0' https://hg.openjdk.java.net/jdk8u/jdk8u/langtools/archive/jdk8u272-ga.tar.bz2

The layer is using an obsolete download location. The correct location
is in the release announcement:
https://mail.openjdk.org/pipermail/jdk8u-dev/2020-October/012817.html

and it does work with wget:
https://openjdk-sources.osci.io/openjdk8/openjdk8u272-ga.tar.xz

The complete list of releases is at:
https://wiki.openjdk.org/display/jdk8u/Main

It's also likely tarball downloads with wget from mercurial VCS were
explicitly disabled; trying to fake user agent will not go down well
if that's the case.

Please dig a bit deeper instead of giving up at the 'wget does not work' step.

> So it seems this patch is necessary to provide and it able to solve this kind of issues in the future.

I'm still not convinced it is necessary. Both known incidents can be
solved without the patch.

Alex

