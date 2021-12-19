Return-Path: <linusti@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC89C433EF
	for <webhook@archiver.kernel.org>; Sun, 19 Dec 2021 17:57:06 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.19320.1639936625845895183
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 Dec 2021 09:57:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=GVis6+BL;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: linusti@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id f5so6252859edq.6
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 Dec 2021 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3Mb9yVsVssspLOstS84Ve/EjUfhPR77lT9Jh3kzNd3w=;
        b=GVis6+BL9WLymPo841474kCQKAQCDZ6TFvwKQQ41KzEQlZtkYQFi1K8hsEWiLwfeSu
         5FlIpPCPZssdS7nQn3QeC5s7O7J22PZax9rzgQjP1blMhh4G5h1NgoLspoJKckZ3AyqV
         NgvFT+msxuZrcbH1fobohMESECG70UVSqJh3Kd4e1fR9DbNFKwx8y6MJtbN9f2vRJWd3
         tiPthm3IFBou3DGCOshxXVORcCU+flcCHEfa+7zYAk5A/d+PEV1Fq9f42xwJEkm+Fzi7
         F/hzWrfioG86q3PhSLyaKKFVX5MGrj+aR9ZsqB3J28XVRMoK26f4XSFU+DtNGivwm86d
         iNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3Mb9yVsVssspLOstS84Ve/EjUfhPR77lT9Jh3kzNd3w=;
        b=3GJV5KQY5CzlxCRGJ17WSFGlhlW9ZLQDSR/vNUp78mku46sEYqbmF/XaIf/UhW7AqA
         HYcYnH7pPNnKSRiUp1X4arbSh1c6VcCwsI3qr8Qm4uDAJ+3f9j6P7BhWXuTtkYpyOjmG
         NXfnLP9lfJqYdL/8uxNMYbQ4BcmFb4WC/zLCEAbhw7tIQIU8UbgdSUWcjlsyNuAw7GI+
         yDWWkumOsre9KfWMvnTnMRenWZRcslNeOru8RJtuFQ8EDrtGfLS96RkpehqtCItkrjW0
         EhSM/GeABoqUcliqL7gE4yUVgfl4YZpf7lURCsm5ra6ZoTAxeTpE+WGTkgbGg0I/pAdV
         jaZQ==
X-Gm-Message-State: AOAM531KmDYKNI19Z7S4Cr3eEWUzqKflg0vKiCr34g0UVPBY05Xy6lG2
	71ZtoP0ORWUTmIWTjuaiKOBG6SPDqEs/SL51+y6tmiLqAWCa5A==
X-Google-Smtp-Source: 
 ABdhPJxjXkXEFHhLh9B49C6oC2MTpjUJ+NX04SMuUVxRzErSWSdQgVY0A4p2PYGKvsuuU737haswM6gg01ts5fkFPok=
X-Received: by 2002:a05:6402:1492:: with SMTP id
 e18mr10863297edv.381.1639936623944;
 Sun, 19 Dec 2021 09:57:03 -0800 (PST)
MIME-Version: 1.0
From: Frank Earl <linusti@gmail.com>
Date: Sun, 19 Dec 2021 11:56:53 -0600
Message-ID: 
 <CANepkxDzx9gi_LQMZiMkcXvfLBB6HXpRuc-T9ZLk70frw6EVBA@mail.gmail.com>
Subject: A bit confused about something regarding the new override syntax...
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000eca85505d3837f50"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 19 Dec 2021 17:57:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13196

--000000000000eca85505d3837f50
Content-Type: text/plain; charset="UTF-8"

I'd have thought that the following wasn't the case here...

WARNING: Layer meta-edgeml should set LAYERSERIES_COMPAT_meta-edgeml in its
conf/layer.conf file to list the core layer names it is compatible with.

I was working through modernizing my stuff so I was properly compatible
with Honister and this shows up on all the ones I've worked on to this
point.  Is that not an override?  Everything else looks and acts like it
is- and I'd always understood that the stuff in the layer.conf were those...

--000000000000eca85505d3837f50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;d have thought that the following wasn&#39;t th=
e case here...<br><br>WARNING: Layer meta-edgeml should set LAYERSERIES_COM=
PAT_meta-edgeml in its conf/layer.conf file to list the core layer names it=
 is compatible with.<br><br></div>I was working through modernizing my stuf=
f so I was properly compatible with Honister and this shows up on all the o=
nes I&#39;ve worked on to this point.=C2=A0 Is that not an override?=C2=A0 =
Everything else looks and acts like it is- and I&#39;d always understood th=
at the stuff in the layer.conf were those...<br></div>

--000000000000eca85505d3837f50--

