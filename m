Return-Path: <sven.schwermer@disruptive-technologies.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56259C25B75
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 12:51:46 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
 by mx.groups.io with SMTP id smtpd.web10.10983.1717159827944556165
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 May 2024 05:50:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@disruptive-technologies.com header.s=google header.b=mYqevLu4;
 spf=pass (domain: disruptive-technologies.com, ip: 209.85.221.170, mailfrom: sven.schwermer@disruptive-technologies.com)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4e4f0600656so1048875e0c.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=disruptive-technologies.com; s=google; t=1717159827; x=1717764627; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaFgym7IJevxbnBvdt1i5b3sgrMpkzj4Q4yt7+nDhpE=;
        b=mYqevLu47NIANY7WQQpAjO9Ky7DUkLy5MmPNB/N89zkYvGxDsfOlD/MnzuW+EF0C9H
         U9bGjYy3yWaOuPVn5okQloRbLBVmZNBS3WMHk3CpdvnprsQEew8F0YB8Neku4B6bSXHB
         bJ44Ivh/ECGS4zqcrGIVTXYeiIwdN/eeJAa1bW501TGzq9m7W5bL7qp4izfKpIXR1G4i
         vk7bO3GUtlorPvLfPHoYbh9M2f26TthkyhFAF3kJJpN+SAkPwlwxXoffrRsIGM5nt8Bn
         F6Ud/1akRL3zT98h6NEc+uYceUF6ZeqBmZnxMJ0f5UbIex/dmmjmzJXQeBOzOBqtPof0
         3J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717159827; x=1717764627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaFgym7IJevxbnBvdt1i5b3sgrMpkzj4Q4yt7+nDhpE=;
        b=QIa2QJamDn9G04bh8i7O1hHBccqP5DAfim5BAq02V2fpIFdVmCSn3Td10HbmMs0fQB
         FA5s1ibDz8Fde2dORy06a7MxzcPYQMW8y30aMbLWc6l6GFrLUSFM2i2KvNDpv6mi3IkX
         NLiwSm2Sa5jpzVBAkNILnhZxPfBroEve+//Ew01t+UqfJzC2lq+IotjnosELWxPdOJ2O
         PdGB1xdmtn02wBYP4NLTFq/+LGSLJMey8cGTzMD1u8iHhCVI3VcTXJqlSy590o5Z5UXV
         v/klNOfD6UPa4cGe/4Twv2TeM03ajw3PTEGI0oLdAUblrbTH86RMslwTfK2lWjKmQ3QY
         pYrA==
X-Gm-Message-State: AOJu0Yz8fSSvbw+YW2n0EZZkqIjloDKvEhJcxOWbY3Q773APYuEZIYga
	wGsyYwszC34b+ndee5xzpAHnjze+nsPE4EO6wn+YPEMBCN2pXn1+X29YhXy1QNsmZk5/cxgnFBY
	YfizeKbarEJJiM+W5sz4xcG6Y+U3Obrb9uBe/pQ==
X-Google-Smtp-Source: AGHT+IE8DGmzGsvTEhwkxnMde6IqQY9C92rZpUIhuym7rDmt7OvJOZou6TLdKoePR9FQ7UxyBhmEG7x3tF/QW9tAeGM=
X-Received: by 2002:a05:6122:6010:b0:4d3:34f4:7e99 with SMTP id
 71dfb90a1353d-4eb01e64a59mr1112829e0c.0.1717159826848; Fri, 31 May 2024
 05:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <8fJ7.1716980201481658392.yosx@lists.openembedded.org> <9e01adf4ac8c6621781e46d8b86bc93748cda697.camel@linuxfoundation.org>
In-Reply-To: <9e01adf4ac8c6621781e46d8b86bc93748cda697.camel@linuxfoundation.org>
From: "Sven" <sven.schwermer@disruptive-technologies.com>
Date: Fri, 31 May 2024 05:51:39 -0700
Message-ID: <CANcZeZH7_Gc==c4QZcmk0bcSq5PiYapfdx614nY36Q1r7ft5ww@mail.gmail.com>
Subject: Re: [bitbake-devel] Pseudo errors in lib/bb/__pycache__ #bitbake
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
X-Old-Date: Fri, 31 May 2024 14:50:15 +0200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 12:51:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16299
Message-ID: <20240531125139.uY9vyQjCeV9c3H0S0NGGoE0KqXtXhwavhHKY5lVqIyw@z>

I get these mismatch errors between all sorts of different pairs of
files, it seems to be unpredictable. Another example:
path mismatch [2 links]: ino 6330088 db
'poky/meta/lib/oe/__pycache__/__init__.cpython-312.pyc' req
'build/tmp/work/MACHINE-poky-linux-gnueabi/IMAGE/1.0/rootfs.image_tar/usr/l=
ib/systemd/system/user@0.service.d'.

This is after I added the following lines to my conf/local.conf:
PSEUDO_IGNORE_PATHS .=3D ",${COREBASE}/bitbake"
PSEUDO_IGNORE_PATHS .=3D ",${COREBASE}/meta/lib"

I'm probably doing something wrong in some recipe/class, however, I
don't know how I can find out where to look. What's the way to
troubleshoot these errors? Any help is appreciated.

Thanks!

Best regards,
Sven

On Thu, May 30, 2024 at 12:49=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2024-05-29 at 03:56 -0700, Sven via lists.openembedded.org
> wrote:
> > Hi,
> >
> > I'm using Yocto 5.0 (scarthgap) which comes with bitbake 2.8. Since
> > migrating from kirkstone (bitbake 2.0), I have started seeing pseudo
> > abort errors like these:
> >
> > NOTE: recipe IMAGE-1.0-r0: task do_rootfs: Failed
> > ERROR: Task (poky/../LAYER/recipes-core/images/IMAGE.bb:do_rootfs)
> > failed with exit code '1'
> > Pseudo log:
> > path mismatch [1 link]: ino 1879965 db
> > 'poky/bitbake/lib/bb/__pycache__/__init__.cpython-312.pyc' req
> > 'build/tmp/work/MACHINE-poky-linux-
> > gnueabi/IMAGE/1.0/rootfs/var/lib/opkg/info/jq.postinst'.
> > creat for 'build/tmp/work/MACHINE-poky-linux-
> > gnueabi/IMAGE/1.0/rootfs/var/lib/opkg/info/jq.control' replaces
> > existing 1879952 ['build/tmp/work/MACHINE-poky-linux-
> > gnueabi/IMAGE/1.0/data.ext4'].
> > symlink err : 1879909 ['build/tmp/work/MACHINE-poky-linux-
> > gnueabi/IMAGE/1.0/rootfs/var/cache/opkg/volatile.211108/aae1283bc6927
> > 2c07742f9861f12b8d8_jq_1.7.1-r0_cortexa7t2hf-neon-vfpv4.ipk'] (db
> > 'build/tmp/work/MACHINE-poky-linux-gnueabi/IMAGE/1.0/boot.vfat') db
> > mode 0100644, header mode 0120777 (unlinking db)
> >
> >
> > ERROR: Task (poky/../LAYER/recipes-core/images/IMAGE.bb:do_rootfs)
> > failed with exit code '134'
> > Pseudo log:
> > path mismatch [1 link]: ino 1081932 db 'poky/bitbake/lib/bb/fetch2/__py=
cache__/clearcase.cpython-312.pyc' req 'poky/meta/lib/oe/package_manager/ip=
k/__pycache__/__init__.cpython-311.pyc'.
> >
> > This occurs both on Ubuntu 20.04 (former) and Debian Bookworm
> > (latter). What is this caused by and how can I resolve this issue?
>
> That looks like you're running the clearcase fetcher during image
> construction? There are python cache files being created and pseudo is
> tracking them when it shouldn't be.
>
> Adding the bitbake directory to PSEUDO_IGNORE_PATH (see image.bbclass)
> should avoid those errors but in your position I'd probably want to
> know what was calling into clearcase from under pseudo in the first
> place (or at least calling into the fetcher code)...
>
> Cheers,
>
> Richard

