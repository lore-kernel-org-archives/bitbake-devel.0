Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587A2C04A68
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 12:00:40 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.18892.1658923238722771274
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Jul 2022 05:00:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=WorHJ+hl;
 spf=pass (domain: gmail.com, ip: 209.85.208.178,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id p21so11905688ljh.12
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Jul 2022 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OcUWr05chDV4esHhmJQim8o1sS3vO2QhyQOZiRG4uA=;
        b=WorHJ+hlbRS71OoNEwUqxpAO/Yz4Ab6sZ5rVvDaUvO6+FqOQFXCumHZZmMReboN6F4
         +Pnqt1KJZ7UTrOsmlxOEoICyRFErZLZMYJAic9XoQjm8Ew717zeZ5QFTwcXZoiuzHvk7
         IWpGF99nJLSXQoTIB2TJ2N1Ayg8RITyIQD4O1Lbp/T0G/xYXb2v8A8/X5AT96pdvIw7v
         xEmfEw096Azx0yBORp6n9oFzWiSbnEPdmQZ0QpODm/Df+DTrDYe1AFdyWACAm26zfdDd
         DMJBUZJp9gN7PB1bX4amv+4cbST79C8eFwCSXfU7wnsUe4wW5QMfCHxzKMovIZKL8irc
         asYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OcUWr05chDV4esHhmJQim8o1sS3vO2QhyQOZiRG4uA=;
        b=p/Et/2sHGPjRcICBkgohuNtMR/Sc1DwvbjR4wMvYxwpxi8MEK5tnuydN2xfRaKt6gQ
         AyG2DoP6pBhgHIakfltHJR/YT/0qGjMgLkoq2W/rtAKUVfF7BVtuFktKxkaE2h5AA4C5
         aM46PBYs/9L0gyGjQSk6/f+NsqnKEgDfMwiI6b52QKy4HQ31fqRzeCyNvcM+uVf36qzm
         6Yk0Gw2sica/wdfUDpKdjKwK/q+TB8uRb+f6o+65DI5dUi2gKdjbP16hzvtje0UcPYBy
         mrqX4nIcBpacjN9mnNYt50wlR8kIWMPRf7xbITOJNB2uTGrgi40INOY1ulHFTShkrOGb
         j3rw==
X-Gm-Message-State: AJIora9mJwML4hZn5O7MXSNH6wIlMHNeRbbrIdewgp8zQ0c0mLEOVYfv
	zEpgWfvpcqle0iRGFdxNJJZ54iz5dOK3RNVTYh4=
X-Google-Smtp-Source: 
 AGRyM1uKW58caYCa3p7fH2ruiCY06jIhug5lWSUK00Lx90e3hMtj74HkmoVk5VixuMoaOBMnsx8U1g9t7AGlXU5g/tM=
X-Received: by 2002:a2e:941:0:b0:25d:fda4:6576 with SMTP id
 62-20020a2e0941000000b0025dfda46576mr6179728ljj.109.1658923235416; Wed, 27
 Jul 2022 05:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
 <CANNYZj99t0x08TYJ6JmZC9uT7VderpqjPCdKRp-QNzJAS2s6Qw@mail.gmail.com>
 <YuAPBJrwSDriYmTZ@heinlein.stwcx.org.github.beta.tailscale.net>
In-Reply-To: <YuAPBJrwSDriYmTZ@heinlein.stwcx.org.github.beta.tailscale.net>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 27 Jul 2022 14:00:24 +0200
Message-ID: 
 <CANNYZj9Dr5U8G+FqoSKpMWQGbjwGkHYPa=DmceUYDm3nputP-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
To: Patrick Williams <patrick@stwcx.xyz>
Cc: Paulo Neves <ptsneves@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Jul 2022 12:00:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13857

On Tue, 26 Jul 2022 at 17:57, Patrick Williams <patrick@stwcx.xyz> wrote:
> A seriously more complex example we have is that we have our own u-boot
> recipes and used the same `u-boot-foo.inc` file names as are present in
> `meta/`.  It happens that the recipes in `meta/recipes-bsp/u-boot` end
> up, even though we'd never use them, using our `u-boot-foo.inc` files
> and ending up with totally bogus SRC_URIs in the parsing phase (and
> thus failing).  Essentially, whenever there is a new version of u-boot
> in `meta` we're going to end up having to make some bogus empty
> files[2].

Reusing the same filenames to me seems like asking for trouble. It's
really better to name your own u-boot items in a way that is
guaranteed not to get in the way with what items in meta/ look for.
u-boot-openbmc-* or similar would do.

Alex

