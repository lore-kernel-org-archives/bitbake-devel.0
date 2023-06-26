Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E2EB64DD
	for <webhook@archiver.kernel.org>; Mon, 26 Jun 2023 13:24:14 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
 by mx.groups.io with SMTP id smtpd.web11.7815.1687785849239040661
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jun 2023 06:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=flD8VJIC;
 spf=pass (domain: gmail.com, ip: 209.85.217.43, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-440c14d6a5eso920820137.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jun 2023 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687785848; x=1690377848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BbCUTnxsStaZiBiYIOGL9XDkSZJiTXFs25obni7R2es=;
        b=flD8VJICeGdko5qUCtPuBKqGXmk06O9oYWaCdk2b5mFRT8y3aBtVghvpTpRcBVRvls
         F/eP9IYVKdSekx0x/2xYiUYe2iwraAtnwdCTAzEhDUXJ98NMUq9stP70saXMStkhakUl
         R27ZkKct+2q9MnYOzv4naOV5nNjq8DJtadie/kLn7e9mgztaZqbd2OJgZYkmTNF0fVMD
         XTr1VZlpF/gtS7ErqfGm5q2OAdbuXuQIXVyhvP4OIPED0u9QcLRpBIoLjAuOdJtM8j7j
         nMihCz0Vy+pJ2SQDjN9tZqvrZja3piuI7cKZiZOo4incEKlRedmFXnKa4NPrpT1jF1Qh
         XHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687785848; x=1690377848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbCUTnxsStaZiBiYIOGL9XDkSZJiTXFs25obni7R2es=;
        b=KWi/hduUM9R7tCbvruKCJ/2g1ekeREatAXIZSosnLbGYi7pX4R7XqqPqC2/3dqjLiQ
         OT6ejPyZO9Ktm5Luh0E2g9jj4uopSDQbCTIaxmN0LSzcgynpYcHfUCfCg5AabKXd1GQe
         3mb9Mmmni1HnMPk22R7O9zsbnNEkOpjrYR8MM5GZoiA7q9hWTL3taHHYnpEnOwLoDMq9
         3xSfVPUNlpAARuwyjHS0edVq5hArbfidFIB4bOF034NONBzursD38SINKKQNOyU/4zrD
         VfBl0p5aJG12PfYy9XU++qx0NeToyUsFHK3AXhxr2jymR6T8MEEZB8S+wFtIxWWP6Jiu
         bGpQ==
X-Gm-Message-State: AC+VfDzitHzQrZ4WGdH7qMY858tQQzkMVxcCOF69hHbv7WOOwRglWlqF
	WkPWKtwufNmUmMUWqjRUHyRIlnEBfy7nTcMoc9E=
X-Google-Smtp-Source: ACHHUZ78IdNm3iINEX1eHOKQ9DOi1NV+J3gOSrRLrJqvkXa19zfzzpE1R0vINeDmI8P5rjxIBLSOQ+77MFlhuOCt1Kw=
X-Received: by 2002:a67:edc9:0:b0:43b:2fa9:eb3a with SMTP id
 e9-20020a67edc9000000b0043b2fa9eb3amr12262139vsp.9.1687785848159; Mon, 26 Jun
 2023 06:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <AS4PR02MB81841D675E74F5FC5444743D8426A@AS4PR02MB8184.eurprd02.prod.outlook.com>
 <b00872e3a5e11c351022ef836e1bd0800bb22458.camel@linuxfoundation.org>
In-Reply-To: <b00872e3a5e11c351022ef836e1bd0800bb22458.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 26 Jun 2023 14:23:57 +0100
Message-ID: <CANPvuRmbE+cYJmuXE=Rtg6O9wYxO762WcUqFwauftCKMY1to6Q@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake race failure with BBMULTICONFIG and setscene
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: ari.parkkila@qt.io, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000efc9b805ff084360"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jun 2023 13:24:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14862

--000000000000efc9b805ff084360
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Looks like this issue is on TI am62xx-evm where I've also come across
several problems like this.
Most of them I fixed when I stopped sharing the TMP folder between machines=
.

Can you try this patch?
https://lists.yoctoproject.org/g/meta-ti/message/14767

Also sent a second version but none of them were accepted which
I even understand because this is actually more of a workaround instead of
a real fix.
https://lists.yoctoproject.org/g/meta-ti/message/15699

Jose

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia
segunda, 26/06/2023 =C3=A0(s) 11:16:

> On Mon, 2023-06-26 at 10:02 +0000, Ari Parkkila via lists.openembedded.or=
g
> wrote:
> >
> > Bitbake (or some yocto-4.2.1 configuration) seems to have a race-like
> problem when running populate_lic with BBMULTICONFIG and setscene. This
> occurs only when BBMULTICONFIG has at least two configurations and
> sstate-cache is ready for setscene task, see log below.
>
> What should happen is that either the two configurations have the same
> task checksum for this do_populate_lic task and therefore just run
> once, or they have different task checksums and run in different work
> directories.
>
> Bitbake is supposed to detect the case differing checksums are in the
> same work directory but that is hard to do and I suspect the check
> might be failing here.
>
> You can run "bitbake XXX -S none" to generate the stamp files without
> running the build itself. Try that and see if the task hashes are the
> same or different.
>
> Cheers,
>
> Richard
>
>
> >
> > --- snip --- snap ---
> >
> > NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> > ...
> > NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> > ERROR: mc:k3r5-hs-fs:glibc-2.37-r1 do_populate_lic_setscene: Error
> executing a python function in exec_func_python() autogenerated:
> > The stack trace of python calls that resulted in this exception/failure
> was:
> >  *** 0002:do_populate_lic_setscene(d)
> > File: 'poky/meta/classes-global/license.bbclass', lineno: 424, function=
:
> do_populate_lic_setscene
> >  *** 0424:    sstate_setscene(d)
> > File: 'poky/meta/classes-global/sstate.bbclass', lineno: 803, function:
> sstate_setscene
> >  *** 0803:    accelerate =3D sstate_installpkg(shared_state, d)
> > File: 'poky/meta/classes-global/sstate.bbclass', lineno: 402, function:
> sstate_installpkg
> >  *** 0402:    return sstate_installpkgdir(ss, d)
> > File: 'poky/meta/classes-global/sstate.bbclass', lineno: 424, function:
> sstate_installpkgdir
> >  *** 0424:        bb.utils.rename(sstateinst + state[0], state[1])
> > File: 'poky/bitbake/lib/bb/utils.py', lineno: 1778, function: rename
> >  *** 1778:            raise err
> > File: 'poky/bitbake/lib/bb/utils.py', lineno: 1772, function: rename
> >  *** 1772:        os.rename(src, dst)
> > Exception: FileNotFoundError: [Errno 2] No such file or directory:
> 'build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r=
1/sstate-install-populate_lic/license-destdir'
> ->
> 'build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r=
1/license-destdir'
> > WARNING: Logfile for failed setscene task is
> build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1=
/temp/log.do_populate_lic_setscene.910886
> > WARNING: Setscene task
> (mc:k3r5-hs-fs:poky/meta/recipes-core/glibc/glibc_2.37.bb:do_populate_lic=
_setscene)
> failed with exit code '1' - real task will be run instead
> > NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> > ERROR: mc:k3r5-gp:glibc-2.37-r1 do_populate_lic_setscene: Error
> executing a python function in exec_func_python() autogenerated:
> > The stack trace of python calls that resulted in this exception/failure
> was:
> >  *** 0002:do_populate_lic_setscene(d)
> > File: 'poky/meta/classes-global/license.bbclass', lineno: 424, function=
:
> do_populate_lic_setscene
> >  *** 0424:    sstate_setscene(d)
> > File: 'poky/meta/classes-global/sstate.bbclass', lineno: 803, function:
> sstate_setscene
> >  *** 0803:    accelerate =3D sstate_installpkg(shared_state, d)
> > File: 'poky/meta/classes-global/sstate.bbclass', lineno: 402, function:
> sstate_installpkg
> >  *** 0402:    return sstate_installpkgdir(ss, d)
> > File: 'poky/meta/classes-global/sstate.bbclass', lineno: 424, function:
> sstate_installpkgdir
> >  *** 0424:        bb.utils.rename(sstateinst + state[0], state[1])
> > File: 'poky/bitbake/lib/bb/utils.py', lineno: 1778, function: rename
> >  *** 1778:            raise err
> > File: 'poky/bitbake/lib/bb/utils.py', lineno: 1772, function: rename
> >  *** 1772:        os.rename(src, dst)
> > Exception: FileNotFoundError: [Errno 2] No such file or directory:
> 'build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r=
1/sstate-install-populate_lic/license-destdir'
> ->
> 'build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r=
1/license-destdir'
> >
> > WARNING: Logfile for failed setscene task is
> build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1=
/temp/log.do_populate_lic_setscene.910888
> > WARNING: Setscene task
> (mc:k3r5-gp:poky/meta/recipes-core/glibc/glibc_2.37.bb:do_populate_lic_se=
tscene)
> failed with exit code '1' - real task will be run instead
> > NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
> > NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Succeeded
> >
> > --- snip --- snap ---
> >
> > It seems that multiple tasks are running sstate_installpkgdir()
> simultaneously and trying to rename from
> sstate-install-populate_lic/license-destdir/ to license-destdir/.
> Buildstats indicate also that there might be multiple concurrent tasks:
> > Event: TaskStarted
> > glibc-2.37-r1: do_populate_lic_setscene
> > Status: PASSED
> > Event: TaskStarted
> > Event: TaskStarted
> > Event: TaskStarted
> >
> > I can reproduce this on my machine (with 24 CPUs) quite reliably so I'm
> happy to try any patches. Here are the steps to repro
> > - clone
> https://codereview.qt-project.org/c/yocto/boot2qt-manifest/+/478020
> > - export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
> > - bitbake b2qt-embedded-qt6-image # to build sstate-cache
> > - rm -rf tmp/
> > - bitbake b2qt-embedded-qt6-image # to copy licenses from sstate-cache
> >
> > These workarounds are good on my machine:
> > - Run bitbake multiple times without cleaning tmp/
> > - Run bitbake with BB_NUMBER_THREADS =3D "1"
> >
> > Also tried with --no-setscene but that caused maybe unrelated problem:
> > ERROR: mc:k3r5-hs-se:texinfo-dummy-native-1.0-r0 do_populate_lic: QA
> Issue: texinfo-dummy-native: LIC_FILES_CHKSUM points to an invalid file:
> /media/ariparkkila/d/ti/build-am62xx-evm/tmp/work/x86_64-linux/texinfo-du=
mmy-native/1.0-r0/COPYING
> [license-checksum]
> >
> > I'm not very familiar with this but it seems that maybe
> "license-destdir" should be named as per each configuration to make sure
> that BBMULTICONFIGs are not racing for the same folder, and not overridin=
g
> each others license files.
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14861):
> https://lists.openembedded.org/g/bitbake-devel/message/14861
> Mute This Topic: https://lists.openembedded.org/mt/99784422/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/leave/10441984/5052612/190=
1433512/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000efc9b805ff084360
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br>Looks like this issue is on TI am62=
xx-evm=C2=A0where I&#39;ve also come across several problems like this.</di=
v><div>Most of them I fixed when I stopped sharing the TMP folder between=
=C2=A0machines.<br><br>Can you try this patch?<br><a href=3D"https://lists.=
yoctoproject.org/g/meta-ti/message/14767">https://lists.yoctoproject.org/g/=
meta-ti/message/14767</a><br><br>Also sent a second version but none of the=
m were accepted which<br>I even understand because this is actually more of=
 a workaround instead of a real fix.<br><a href=3D"https://lists.yoctoproje=
ct.org/g/meta-ti/message/15699">https://lists.yoctoproject.org/g/meta-ti/me=
ssage/15699</a><br><br>Jose<br><br></div><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:richard=
.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; esc=
reveu no dia segunda, 26/06/2023 =C3=A0(s) 11:16:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Mon, 2023-06-26 at 10:02 +0000, Ari Pa=
rkkila via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" tar=
get=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; <br>
&gt; Bitbake (or some yocto-4.2.1 configuration) seems to have a race-like =
problem when running populate_lic with BBMULTICONFIG and setscene. This occ=
urs only when BBMULTICONFIG has at least two configurations and sstate-cach=
e is ready for setscene task, see log below.<br>
<br>
What should happen is that either the two configurations have the same<br>
task checksum for this do_populate_lic task and therefore just run<br>
once, or they have different task checksums and run in different work<br>
directories.<br>
<br>
Bitbake is supposed to detect the case differing checksums are in the<br>
same work directory but that is hard to do and I suspect the check<br>
might be failing here.<br>
<br>
You can run &quot;bitbake XXX -S none&quot; to generate the stamp files wit=
hout<br>
running the build itself. Try that and see if the task hashes are the<br>
same or different.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
&gt; <br>
&gt; --- snip --- snap ---<br>
&gt; <br>
&gt; NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started<br>
&gt; ...<br>
&gt; NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started<br>
&gt; ERROR: mc:k3r5-hs-fs:glibc-2.37-r1 do_populate_lic_setscene: Error exe=
cuting a python function in exec_func_python() autogenerated:<br>
&gt; The stack trace of python calls that resulted in this exception/failur=
e was:<br>
&gt; =C2=A0*** 0002:do_populate_lic_setscene(d)<br>
&gt; File: &#39;poky/meta/classes-global/license.bbclass&#39;, lineno: 424,=
 function: do_populate_lic_setscene<br>
&gt; =C2=A0*** 0424: =C2=A0 =C2=A0sstate_setscene(d)<br>
&gt; File: &#39;poky/meta/classes-global/sstate.bbclass&#39;, lineno: 803, =
function: sstate_setscene<br>
&gt; =C2=A0*** 0803: =C2=A0 =C2=A0accelerate =3D sstate_installpkg(shared_s=
tate, d)<br>
&gt; File: &#39;poky/meta/classes-global/sstate.bbclass&#39;, lineno: 402, =
function: sstate_installpkg<br>
&gt; =C2=A0*** 0402: =C2=A0 =C2=A0return sstate_installpkgdir(ss, d)<br>
&gt; File: &#39;poky/meta/classes-global/sstate.bbclass&#39;, lineno: 424, =
function: sstate_installpkgdir<br>
&gt; =C2=A0*** 0424: =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.rename(sstateinst =
+ state[0], state[1])<br>
&gt; File: &#39;poky/bitbake/lib/bb/utils.py&#39;, lineno: 1778, function: =
rename<br>
&gt; =C2=A0*** 1778: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise err<br>
&gt; File: &#39;poky/bitbake/lib/bb/utils.py&#39;, lineno: 1772, function: =
rename<br>
&gt; =C2=A0*** 1772: =C2=A0 =C2=A0 =C2=A0 =C2=A0os.rename(src, dst)<br>
&gt; Exception: FileNotFoundError: [Errno 2] No such file or directory: &#3=
9;build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1=
/sstate-install-populate_lic/license-destdir&#39; -&gt; &#39;build-am62xx-e=
vm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/license-destdir=
&#39;<br>
&gt; WARNING: Logfile for failed setscene task is build-am62xx-evm/tmp/work=
/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/temp/log.do_populate_lic_s=
etscene.910886<br>
&gt; WARNING: Setscene task (mc:k3r5-hs-fs:poky/meta/recipes-core/glibc/gli=
bc_2.37.bb:do_populate_lic_setscene) failed with exit code &#39;1&#39; - re=
al task will be run instead<br>
&gt; NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started<br>
&gt; ERROR: mc:k3r5-gp:glibc-2.37-r1 do_populate_lic_setscene: Error execut=
ing a python function in exec_func_python() autogenerated:<br>
&gt; The stack trace of python calls that resulted in this exception/failur=
e was:<br>
&gt; =C2=A0*** 0002:do_populate_lic_setscene(d)<br>
&gt; File: &#39;poky/meta/classes-global/license.bbclass&#39;, lineno: 424,=
 function: do_populate_lic_setscene<br>
&gt; =C2=A0*** 0424: =C2=A0 =C2=A0sstate_setscene(d)<br>
&gt; File: &#39;poky/meta/classes-global/sstate.bbclass&#39;, lineno: 803, =
function: sstate_setscene<br>
&gt; =C2=A0*** 0803: =C2=A0 =C2=A0accelerate =3D sstate_installpkg(shared_s=
tate, d)<br>
&gt; File: &#39;poky/meta/classes-global/sstate.bbclass&#39;, lineno: 402, =
function: sstate_installpkg<br>
&gt; =C2=A0*** 0402: =C2=A0 =C2=A0return sstate_installpkgdir(ss, d)<br>
&gt; File: &#39;poky/meta/classes-global/sstate.bbclass&#39;, lineno: 424, =
function: sstate_installpkgdir<br>
&gt; =C2=A0*** 0424: =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.rename(sstateinst =
+ state[0], state[1])<br>
&gt; File: &#39;poky/bitbake/lib/bb/utils.py&#39;, lineno: 1778, function: =
rename<br>
&gt; =C2=A0*** 1778: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise err<br>
&gt; File: &#39;poky/bitbake/lib/bb/utils.py&#39;, lineno: 1772, function: =
rename<br>
&gt; =C2=A0*** 1772: =C2=A0 =C2=A0 =C2=A0 =C2=A0os.rename(src, dst)<br>
&gt; Exception: FileNotFoundError: [Errno 2] No such file or directory: &#3=
9;build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1=
/sstate-install-populate_lic/license-destdir&#39; -&gt; &#39;build-am62xx-e=
vm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/license-destdir=
&#39;<br>
&gt; <br>
&gt; WARNING: Logfile for failed setscene task is build-am62xx-evm/tmp/work=
/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/temp/log.do_populate_lic_s=
etscene.910888<br>
&gt; WARNING: Setscene task (mc:k3r5-gp:poky/meta/recipes-core/glibc/glibc_=
2.37.bb:do_populate_lic_setscene) failed with exit code &#39;1&#39; - real =
task will be run instead<br>
&gt; NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started<br>
&gt; NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Succeeded<b=
r>
&gt; <br>
&gt; --- snip --- snap ---<br>
&gt; <br>
&gt; It seems that multiple tasks are running sstate_installpkgdir() simult=
aneously and trying to rename from sstate-install-populate_lic/license-dest=
dir/ to license-destdir/. Buildstats indicate also that there might be mult=
iple concurrent tasks:<br>
&gt; Event: TaskStarted<br>
&gt; glibc-2.37-r1: do_populate_lic_setscene<br>
&gt; Status: PASSED<br>
&gt; Event: TaskStarted<br>
&gt; Event: TaskStarted<br>
&gt; Event: TaskStarted<br>
&gt; <br>
&gt; I can reproduce this on my machine (with 24 CPUs) quite reliably so I&=
#39;m happy to try any patches. Here are the steps to repro<br>
&gt; - clone <a href=3D"https://codereview.qt-project.org/c/yocto/boot2qt-m=
anifest/+/478020" rel=3D"noreferrer" target=3D"_blank">https://codereview.q=
t-project.org/c/yocto/boot2qt-manifest/+/478020</a><br>
&gt; - export MACHINE=3Dam62xx-evm &amp;&amp; source ./setup-environment.sh=
<br>
&gt; - bitbake b2qt-embedded-qt6-image # to build sstate-cache<br>
&gt; - rm -rf tmp/<br>
&gt; - bitbake b2qt-embedded-qt6-image # to copy licenses from sstate-cache=
<br>
&gt; <br>
&gt; These workarounds are good on my machine:<br>
&gt; - Run bitbake multiple times without cleaning tmp/<br>
&gt; - Run bitbake with BB_NUMBER_THREADS =3D &quot;1&quot;<br>
&gt; <br>
&gt; Also tried with --no-setscene but that caused maybe unrelated problem:=
<br>
&gt; ERROR: mc:k3r5-hs-se:texinfo-dummy-native-1.0-r0 do_populate_lic: QA I=
ssue: texinfo-dummy-native: LIC_FILES_CHKSUM points to an invalid file: /me=
dia/ariparkkila/d/ti/build-am62xx-evm/tmp/work/x86_64-linux/texinfo-dummy-n=
ative/1.0-r0/COPYING [license-checksum]<br>
&gt; <br>
&gt; I&#39;m not very familiar with this but it seems that maybe &quot;lice=
nse-destdir&quot; should be named as per each configuration to make sure th=
at BBMULTICONFIGs are not racing for the same folder, and not overriding ea=
ch others license files.<br>
&gt; <br>
&gt; <br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14861): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14861" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14861</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/99784422/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/99784422/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/leav=
e/10441984/5052612/1901433512/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.openembedded.org/g/bitbake-devel/leave/10441984/5052612/190143=
3512/xyzzy</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--000000000000efc9b805ff084360--

