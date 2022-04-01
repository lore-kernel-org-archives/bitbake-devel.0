Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5479EC433EF
	for <webhook@archiver.kernel.org>; Fri,  1 Apr 2022 14:34:20 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.11461.1648823659517191629
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Apr 2022 07:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=j+Pw2EUx;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: raj.khem@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id gi14so2188639qvb.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Apr 2022 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XMb8z7wEuOcydF2Aa43lVM/g44vU2nBX7jeClS4PkI=;
        b=j+Pw2EUxmKBPvWTxOSw3B+ZJuIJUx9PDo3gVm1NeXXQq4XEGtBNLKktBgSnUS/S4Tl
         uc2wqoVi3Z+XfyqZuqcuGQ4o6T9xs68icQzQ06rclN6ir/avrWK5VyUrdqGUMR4CUAJJ
         kua7RQvtvS67IhcanHAB+YvKVfYCqUnvE5yodIZkcdqk+/fxT8ox7cmBtpfW6VnyPUxm
         aAW5A/fMCmn4gN/GdCdlTfbI2f5M+sFru9781pKGHcK4eSyg8I2ffl2WrR5uWuonxwdw
         tTM6A0U8D5j+wrcWoVTKyV3RkLHBu0Au4VvlA0Wx2vxjzSZjFzCao3ilklDnnKJ7wZlv
         JAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XMb8z7wEuOcydF2Aa43lVM/g44vU2nBX7jeClS4PkI=;
        b=F+RODea3/zUjKUt9Ps54U+AkyG4RWt3ZUJcdzcvPXyJc/1VFSyb8sufHaffRO+Abd8
         8TSZSgU7mVnqwB2A6wqD8xde7yOJP4XJ9RFL3zqTHwurjORjlaHR/Lxv1RwNd1TTAqJc
         pXDYQLtfivvPIkB03joQRBmVcC+XNZEf5GKYmT7YStP77qbSoSaop8m4SDArRnVeeSOx
         9hKSCeiEQlTA9abIuxrhVDc+ZZZy1BLisHLdrCdPM+/HSoGXdGNYkt3G+ClrBCsvQdYj
         a+LHRGp8s7g6eFe6T0vns1VJWRzocrhHGOoWFWOwv/PRMqIWDhiU9fYXrjsRR3sDivtM
         Ch4Q==
X-Gm-Message-State: AOAM530FkZUIqVlTzSRV0pR1X/3y3cFt7a3xawdCP5ry1SkelQ9mTpmw
	q354QB9jW4ZpXLtFKsK4s5l1ZBoDBveGtZQaZOs=
X-Google-Smtp-Source: 
 ABdhPJwOw40SzH/SNmeRCRIGcv9e8ROwvvL913/bklU31rIvqCgeRbOgF7Q2jW4ysDE8Q7fxIOlC6O+Cqg6tM8QSdrI=
X-Received: by 2002:a05:6214:4017:b0:441:35e:fcbd with SMTP id
 kd23-20020a056214401700b00441035efcbdmr39453257qvb.110.1648823658321; Fri, 01
 Apr 2022 07:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <B369.1648819906487355784.8tFf@lists.openembedded.org>
In-Reply-To: <B369.1648819906487355784.8tFf@lists.openembedded.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 1 Apr 2022 07:33:52 -0700
Message-ID: 
 <CAMKF1so0n--D2TAWXwEe7ZD0hOXD3L9hffhgkVSueAc78cWDoQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake fails to find a file in SSTATE_MIRROR
 even though it exists
To: maksym.iliev@litmus.io
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Apr 2022 14:34:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13564

On Fri, Apr 1, 2022 at 6:31 AM Maksym Iliev via lists.openembedded.org
<maksym.iliev=3Dlitmus.io@lists.openembedded.org> wrote:
>
> I have an AWS S3 bucket setup to be an SSTATE_MIRROR. However, there is a=
n occasional error happening where bitbake is not able to find a file that =
actually exists in that bucket. Here is an example of an error:
>
> WARNING: gdk-pixbuf-2.40.0-r0 do_packagedata_setscene: Failed to fetch UR=
L file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0:r0:corei7-64:3=
:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d21906f7e_packageda=
ta.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixbuf:corei7-64-poky-li=
nux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194=
ce4957d21906f7e_packagedata.tgz.siginfo, attempting MIRRORS if available
> ERROR: gdk-pixbuf-2.40.0-r0 do_packagedata_setscene: Fetcher failure: Una=
ble to find file file://3a/83/sstate:gdk-pixbuf:corei7-64-poky-linux:2.40.0=
:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbbde2822d48f7f194ce4957d219=
06f7e_packagedata.tgz.siginfo;downloadfilename=3D3a/83/sstate:gdk-pixbuf:co=
rei7-64-poky-linux:2.40.0:r0:corei7-64:3:3a83036f92542f5385730d42c4ffdffcbb=
de2822d48f7f194ce4957d21906f7e_packagedata.tgz.siginfo anywhere. The paths =
that were searched were:
>     /srv/yocto/sstate-cache
>     /srv/yocto/sstate-cache
>
> The base_local.conf configuration for SSTATE_MIRROR is as below (bucket n=
ame hidden):
>
> INHERIT +=3D "own-mirrors"
> SOURCE_MIRROR_URL =3D "https://*mybucketname*.s3.amazonaws.com/"
>

Thats setting up source mirrors not sstate mirrors. Can you show how
you configured sstate mirror ?
>
>
> My question is what could possibly be causing this issue?
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13562): https://lists.openembedded.org/g/bitbake-deve=
l/message/13562
> Mute This Topic: https://lists.openembedded.org/mt/90178640/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.kh=
em@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

