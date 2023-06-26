Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2BEB64D7
	for <webhook@archiver.kernel.org>; Mon, 26 Jun 2023 10:16:53 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.4362.1687774602449581095
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jun 2023 03:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=S/gxdbkG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fa9850bfd9so6032555e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jun 2023 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687774601; x=1690366601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmZOqLADdaJJV8cYW1QwtrzKlRyCMVbCF92d0OH+whk=;
        b=S/gxdbkGbEKlPtwNWrvP9ewgbGuhO//7rlXjjbNFANwiAt8e9PvLjnljKPKO+od/NG
         V0s0CfUnaY30JSNNdiPcNrWtbzXuQ8sL7r0O1bHbPJuDbDgR6Ls7BadrUc2/ER6IW/BK
         EzpISNos11aNjKK/QPJ1NoSir7KJmYW1sSFZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687774601; x=1690366601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmZOqLADdaJJV8cYW1QwtrzKlRyCMVbCF92d0OH+whk=;
        b=KY1Q1zitVhgyvk4fDisUWWOPA7VOLCbfmvDZMUdBC99vMC5x+6TjSn9++jL5pRWW8j
         efe3lrc3E0boZjc8c9Rm25uHX0pz8LDMugofrnwFRfvgHONf2wgZT5hHyaLH41ce1g4b
         T/QzwBkJBaH0xs5exA1rWXH3UN9b+i6lLooluFYePqi7EfXH1Lyr196TwGPFi0ibhRSR
         CmkFri2NHrZuQiOtmkEkUKpz9LB+HBxlGmt7XPwRo8L1Thxdk+1tnVcNctqw0DiZcEWV
         ULd280ceUHWU7jBmsc0/lao+DAMvhjgRhA4jaWNIjnkBZyKUeqRDLuuSGyxwVW80bvhN
         PYng==
X-Gm-Message-State: AC+VfDyrE9X5uySJIjD6RETLJXwn2mPC27VYmjs8XDYuVMsMjaXxe8gu
	DrYShAnho3A6qwTWPaeRCDvV9Q==
X-Google-Smtp-Source: ACHHUZ4E5j+zD5AXy6faukTzYGaAyJM6IPRWLZKFzrn3MvHkInlsETvpGYReu0KFxsl6jtTX9NzREQ==
X-Received: by 2002:a7b:c399:0:b0:3fa:9590:a365 with SMTP id s25-20020a7bc399000000b003fa9590a365mr1708033wmj.17.1687774600740;
        Mon, 26 Jun 2023 03:16:40 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3f54:77a:5419:fb87? ([2001:8b0:aba:5f3c:3f54:77a:5419:fb87])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c3acb00b003f7f475c3bcsm11091805wms.1.2023.06.26.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:16:40 -0700 (PDT)
Message-ID: <b00872e3a5e11c351022ef836e1bd0800bb22458.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake race failure with BBMULTICONFIG and
 setscene
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ari.parkkila@qt.io, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 26 Jun 2023 11:16:39 +0100
In-Reply-To: <AS4PR02MB81841D675E74F5FC5444743D8426A@AS4PR02MB8184.eurprd02.prod.outlook.com>
References: 
	<AS4PR02MB81841D675E74F5FC5444743D8426A@AS4PR02MB8184.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jun 2023 10:16:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14861

On Mon, 2023-06-26 at 10:02 +0000, Ari Parkkila via lists.openembedded.org =
wrote:
>=20
> Bitbake (or some yocto-4.2.1 configuration) seems to have a race-like pro=
blem when running populate_lic with BBMULTICONFIG and setscene. This occurs=
 only when BBMULTICONFIG has at least two configurations and sstate-cache i=
s ready for setscene task, see log below.

What should happen is that either the two configurations have the same
task checksum for this do_populate_lic task and therefore just run
once, or they have different task checksums and run in different work
directories.

Bitbake is supposed to detect the case differing checksums are in the
same work directory but that is hard to do and I suspect the check
might be failing here.

You can run "bitbake XXX -S none" to generate the stamp files without
running the build itself. Try that and see if the task hashes are the
same or different.

Cheers,

Richard


>=20
> --- snip --- snap ---
>=20
> NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> ...
> NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> ERROR: mc:k3r5-hs-fs:glibc-2.37-r1 do_populate_lic_setscene: Error execut=
ing a python function in exec_func_python() autogenerated:
> The stack trace of python calls that resulted in this exception/failure w=
as:
> =C2=A0*** 0002:do_populate_lic_setscene(d)
> File: 'poky/meta/classes-global/license.bbclass', lineno: 424, function: =
do_populate_lic_setscene
> =C2=A0*** 0424: =C2=A0 =C2=A0sstate_setscene(d)
> File: 'poky/meta/classes-global/sstate.bbclass', lineno: 803, function: s=
state_setscene
> =C2=A0*** 0803: =C2=A0 =C2=A0accelerate =3D sstate_installpkg(shared_stat=
e, d)
> File: 'poky/meta/classes-global/sstate.bbclass', lineno: 402, function: s=
state_installpkg
> =C2=A0*** 0402: =C2=A0 =C2=A0return sstate_installpkgdir(ss, d)
> File: 'poky/meta/classes-global/sstate.bbclass', lineno: 424, function: s=
state_installpkgdir
> =C2=A0*** 0424: =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.rename(sstateinst + s=
tate[0], state[1])
> File: 'poky/bitbake/lib/bb/utils.py', lineno: 1778, function: rename
> =C2=A0*** 1778: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise err
> File: 'poky/bitbake/lib/bb/utils.py', lineno: 1772, function: rename
> =C2=A0*** 1772: =C2=A0 =C2=A0 =C2=A0 =C2=A0os.rename(src, dst)
> Exception: FileNotFoundError: [Errno 2] No such file or directory: 'build=
-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/sstate=
-install-populate_lic/license-destdir' -> 'build-am62xx-evm/tmp/work/armv7a=
t2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/license-destdir'
> WARNING: Logfile for failed setscene task is build-am62xx-evm/tmp/work/ar=
mv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/temp/log.do_populate_lic_sets=
cene.910886
> WARNING: Setscene task (mc:k3r5-hs-fs:poky/meta/recipes-core/glibc/glibc_=
2.37.bb:do_populate_lic_setscene) failed with exit code '1' - real task wil=
l be run instead
> NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> ERROR: mc:k3r5-gp:glibc-2.37-r1 do_populate_lic_setscene: Error executing=
 a python function in exec_func_python() autogenerated:
> The stack trace of python calls that resulted in this exception/failure w=
as:
> =C2=A0*** 0002:do_populate_lic_setscene(d)
> File: 'poky/meta/classes-global/license.bbclass', lineno: 424, function: =
do_populate_lic_setscene
> =C2=A0*** 0424: =C2=A0 =C2=A0sstate_setscene(d)
> File: 'poky/meta/classes-global/sstate.bbclass', lineno: 803, function: s=
state_setscene
> =C2=A0*** 0803: =C2=A0 =C2=A0accelerate =3D sstate_installpkg(shared_stat=
e, d)
> File: 'poky/meta/classes-global/sstate.bbclass', lineno: 402, function: s=
state_installpkg
> =C2=A0*** 0402: =C2=A0 =C2=A0return sstate_installpkgdir(ss, d)
> File: 'poky/meta/classes-global/sstate.bbclass', lineno: 424, function: s=
state_installpkgdir
> =C2=A0*** 0424: =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.rename(sstateinst + s=
tate[0], state[1])
> File: 'poky/bitbake/lib/bb/utils.py', lineno: 1778, function: rename
> =C2=A0*** 1778: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise err
> File: 'poky/bitbake/lib/bb/utils.py', lineno: 1772, function: rename
> =C2=A0*** 1772: =C2=A0 =C2=A0 =C2=A0 =C2=A0os.rename(src, dst)
> Exception: FileNotFoundError: [Errno 2] No such file or directory: 'build=
-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/sstate=
-install-populate_lic/license-destdir' -> 'build-am62xx-evm/tmp/work/armv7a=
t2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/license-destdir'
>=20
> WARNING: Logfile for failed setscene task is build-am62xx-evm/tmp/work/ar=
mv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/temp/log.do_populate_lic_sets=
cene.910888
> WARNING: Setscene task (mc:k3r5-gp:poky/meta/recipes-core/glibc/glibc_2.3=
7.bb:do_populate_lic_setscene) failed with exit code '1' - real task will b=
e run instead
> NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Succeeded
>=20
> --- snip --- snap ---
>=20
> It seems that multiple tasks are running sstate_installpkgdir() simultane=
ously and trying to rename from sstate-install-populate_lic/license-destdir=
/ to license-destdir/. Buildstats indicate also that there might be multipl=
e concurrent tasks:
> Event: TaskStarted
> glibc-2.37-r1: do_populate_lic_setscene
> Status: PASSED
> Event: TaskStarted
> Event: TaskStarted
> Event: TaskStarted
>=20
> I can reproduce this on my machine (with 24 CPUs) quite reliably so I'm h=
appy to try any patches. Here are the steps to repro
> - clone https://codereview.qt-project.org/c/yocto/boot2qt-manifest/+/4780=
20
> - export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
> - bitbake b2qt-embedded-qt6-image # to build sstate-cache
> - rm -rf tmp/
> - bitbake b2qt-embedded-qt6-image # to copy licenses from sstate-cache
>=20
> These workarounds are good on my machine:
> - Run bitbake multiple times without cleaning tmp/
> - Run bitbake with BB_NUMBER_THREADS =3D "1"
>=20
> Also tried with --no-setscene but that caused maybe unrelated problem:
> ERROR: mc:k3r5-hs-se:texinfo-dummy-native-1.0-r0 do_populate_lic: QA Issu=
e: texinfo-dummy-native: LIC_FILES_CHKSUM points to an invalid file: /media=
/ariparkkila/d/ti/build-am62xx-evm/tmp/work/x86_64-linux/texinfo-dummy-nati=
ve/1.0-r0/COPYING [license-checksum]
>=20
> I'm not very familiar with this but it seems that maybe "license-destdir"=
 should be named as per each configuration to make sure that BBMULTICONFIGs=
 are not racing for the same folder, and not overriding each others license=
 files.
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14860): https://lists.openembedded.org/g/bitbake-deve=
l/message/14860
> Mute This Topic: https://lists.openembedded.org/mt/99784422/1686473
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [richar=
d.purdie@linuxfoundation.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


