Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF90C61D9B
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 12:10:38 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.17911.1700655029104870018
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Nov 2023 04:10:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eQzehJrH;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso85261691fa.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 04:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700655027; x=1701259827; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VwBoWJ4S0MCh1YKqnTl4LYgLR6KrndELCUl0eDZWUJs=;
        b=eQzehJrHIksKVcS8tTk5BnfTxqRf5llnDdDwJbs1GWKH1xzhK6EYbYZza0VdhASlfa
         QgC71m8RdZIXxwXJ5SDE7czkCzMlAafNBVwDebfeTehsTNIj6FRbrGRwCMhDWC5xh4eU
         1M5Fayr0dvaLyYs5PTzl960OG/3CYJYLw3JlQGIPQ0xpYnV/W8N5G9DV3P9pNb3Xkbp2
         VxhOerU4hdXpdMFP6X1wzxKDZ5ZEwfbWe0SRK2qn7Aadg0Adzwe4Hx/9EYKEd+bSlxjf
         W9OSblbs1VF1zIB1UzuHbb4K2GeTqdm6xr6a5eNmffIxZWJKiKHmF4SPMDs3JHTnVv2K
         r0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700655027; x=1701259827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwBoWJ4S0MCh1YKqnTl4LYgLR6KrndELCUl0eDZWUJs=;
        b=En0+HBXgop7gSblhNhIHizbjqpkvn2pzeaWVQriuT2TZpWvnDKdxxFQif9xWLEzON1
         qFzOTYYwT2zE71n6V/1vGvmRcRNtT3fu6F8aDEATKYuND2Z9adFdWRGir2TwSqSBqkgR
         7zHhIpjzAWI6bwvH69STfY1FkQOBTzcW5SE7FhMHw0T7XzwH9PkGEF0U/6oKUcSQcwAG
         pNdVnjyZ47U+MLTSPfvIw2SWFZJdug9a+uvmvh/13jaKudbaebkBWYay0QECz+p3SQxB
         lG/OtPEySYcDgxFDTHx1QUDCiqpoToS2i9EQBCLNGlnstdy0sX1r1B7Uxowac3uC/Qw5
         D2FQ==
X-Gm-Message-State: AOJu0YzftHYk4mpO2ltEnASx4fIm5bdwYTagb+wNXMe0PMk4djzKLnt1
	/6l1Xh7axtMWKmg/mbfCrOxNE52b0OO0QQ48BgQ=
X-Google-Smtp-Source: AGHT+IHeAkmCVsTEEjA4S+PjE13HEw8uTfyrsNJgJ4vehflGdAGLrMFsJ27H8SU+CeaEauOzaij7zl5r0UVmjG8IMYU=
X-Received: by 2002:a2e:ab1a:0:b0:2c8:83c7:4046 with SMTP id
 ce26-20020a2eab1a000000b002c883c74046mr1636448ljb.26.1700655026921; Wed, 22
 Nov 2023 04:10:26 -0800 (PST)
MIME-Version: 1.0
References: <3556314.iIbC2pHGDl@n95hx1g2> <CANNYZj83WzD9L6=rw3JRG4TQSjkPjCC+_5gatOzUDr+ZL_4bNw@mail.gmail.com>
 <1994066.usQuhbGJ8B@n95hx1g2>
In-Reply-To: <1994066.usQuhbGJ8B@n95hx1g2>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 22 Nov 2023 13:10:14 +0100
Message-ID: <CANNYZj8Ouq0wZQayaRd1NHGhs+XWjTzJ8TPAQfCH7O+8pRyKiw@mail.gmail.com>
Subject: Re: [bitbake-devel] Keeping STAMPS_DIR between CI builds?
To: Christian Eggers <ceggers@arri.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000c3e529060abc9a57"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 12:10:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15562

--000000000000c3e529060abc9a57
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 12:36, Christian Eggers <ceggers@arri.de> wrote:

>
> that sounds like not every task's output goes to the shared state cache
> (is there documentation about this?). As do_compile doesn't go to cache,
> all previous tasks (also not cached?) have to be rerun.
>

I'm not sure if there is, but for the actual binary artefacts the first
task that does put things into sstate is do_package.


>
> Would it make sense to put the result of do_compile into the cache for my
> particular recipe?
>

No. You would deviate from standard yocto practices too far here. Your goal
should be to write as little custom code as possible, and stay as close to
standard, understandable builds as you can.


>
> > I'd suggest that instead of embedding any build id data into the binary
> > from its recipe, you can do the same step when building the image. There
> > are hooks for this, e.g. ROOTFS_POSTPROCESS_COMMAND.
>
> Of course this is much more straight forward (and what I already do). Be
> for
> some use cases (automatic testing), we handle with individual IPK files /
> executables
> rather than with complete rootfs images. For this use case it would be
> helpful
> if the application could "identify" itself.
>

But then you can perhaps write the build id into ipk metadata rather than
the binary itself? I don't remember if there are convenient hooks for that,
but that would allow direct shortcut to package_write_ipk if nothing else
changed, as that would take do_package from sstate.

Alex

--000000000000c3e529060abc9a57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, 22 Nov 2023 at 12:36, Christian Eggers &lt;<a href=3D"mailto=
:ceggers@arri.de">ceggers@arri.de</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><div><br>that sounds like not every t=
ask&#39;s output goes to the shared state cache<br>(is there documentation =
about this?). As do_compile doesn&#39;t go to cache,<br>all previous tasks =
(also not cached?) have to be rerun.<br></div></div></blockquote><div><br><=
/div><div>I&#39;m not sure if there is, but for the actual binary artefacts=
 the first task that does put things into sstate is do_package.</div><div>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div=
><br>Would it make sense to put the result of do_compile into the cache for=
 my<br>particular recipe?<br></div></div></blockquote><div><br></div><div>N=
o. You would deviate from standard yocto practices too far here. Your goal =
should be to write as little custom code as possible, and stay as close to =
standard, understandable builds as you can.<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div><div><br>&gt; I&#39;d sug=
gest that instead of embedding any build id data into the binary<br>&gt; fr=
om its recipe, you can do the same step when building the image. There<br>&=
gt; are hooks for this, e.g. ROOTFS_POSTPROCESS_COMMAND.<br><br>Of course t=
his is much more straight forward (and what I already do). Be for<br>some u=
se cases (automatic testing), we handle with individual IPK files / executa=
bles<br>rather than with complete rootfs images. For this use case it would=
 be helpful<br>if the application could &quot;identify&quot; itself.<br></d=
iv></div></blockquote></div><div><br></div><div>But then you can perhaps wr=
ite the build id into ipk metadata rather than the binary itself? I don&#39=
;t remember if there are convenient hooks for that, but that would allow di=
rect shortcut to package_write_ipk if nothing else changed, as that would t=
ake do_package from sstate.</div><div><br></div><div>Alex<br></div></div>

--000000000000c3e529060abc9a57--

