Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C510CC19F2A
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 14:33:35 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by mx.groups.io with SMTP id smtpd.web09.6568.1660142007314735442
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:33:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Dx9FXJGg;
 spf=pass (domain: gmail.com, ip: 209.85.217.46,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-vs1-f46.google.com with SMTP id v128so15304927vsb.10
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8lkLf45RHMNk6V8ORLYSJGWlESVWKPm4KX0VBA6+ozc=;
        b=Dx9FXJGghCY/oSWorG1gtqX55X3dqfJbnao3RTM8YOXwaTPMTHCPPXdwCVLlqNk19w
         UuaQ6El2y1o1Xa99tRyDqjxLRyx8OFJqSRsV7a9mth8uoH5kNnl8l+VZfZgpg1zGR3O9
         LR/6E6fo6hhK6PEV4h6k/OKrm9qMT0Lgu+KkcyhebmT5WbynIx3BTDwKYon/14cMof8k
         FQZxeZ22ZWZbGOX6vs85HVFQ/K5ptAbtOPC1OGx26YcG0LPcNos21n+jub/a8eZjRJfV
         RR1b6jgPH3cCNgqaZZ+m9z7lclQ7gXAp+dOr2V96v3bEeD9vI0N0UOBtUBO218LDRBRt
         m6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8lkLf45RHMNk6V8ORLYSJGWlESVWKPm4KX0VBA6+ozc=;
        b=cAy5PFbHFc3BWovZLWmnWCmTUvRXq19raTMZEoODJ2SIAx0zMOaCB2JS8VDbMU9Jsa
         0K8xc9/gwIAiQjGUAdRIBiqVTqHswIzXgVe5gS3CHG5NNoiOSjLjfmCzbg1VhOLq5IV8
         SNIxa03jjlbqd4CM49yAXpDHdSY4nWjpPuXSnr5kXDvE6R1tLwrymKtfOUoGDBg6Ws4d
         5oO1ko0ix18KiEdKQVfY4F3lLdc51RaDkMWnwPYl9BsrJrADVQrUGm4ydPOGVnfD7Y+D
         opgArTbAN7aetnqeTL4rI2PZ1H4MecD3of4QIIN89yJvp8mLpvKTCdEec59Cb0+Fey6+
         Z8aw==
X-Gm-Message-State: ACgBeo0jHg8XuPLnkcffylOabEkTUsgiV6L5hdWMh/aj6Uk+oY52+nUD
	CU+vCaamS+9Ec5VvYmIOHzPAlYErJZjuPuNLOE0=
X-Google-Smtp-Source: 
 AA6agR4bWIy37UvSNTMXlSmntFyv6VIlqn/PVcIKnP0LbJiJkbs75ArjPVsvWwyCY1vMtq1L2VaUeDeaZ5HHMoXjbXU=
X-Received: by 2002:a05:6102:31bc:b0:388:454a:7961 with SMTP id
 d28-20020a05610231bc00b00388454a7961mr11435230vsh.16.1660142006374; Wed, 10
 Aug 2022 07:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220810084401.3885-1-tomasz.dziendzielski@gmail.com>
 <f853e0fb1daec7c32a1fb1d0ac523cc4b8c2031f.camel@linuxfoundation.org>
In-Reply-To: 
 <f853e0fb1daec7c32a1fb1d0ac523cc4b8c2031f.camel@linuxfoundation.org>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Wed, 10 Aug 2022 16:33:26 +0200
Message-ID: 
 <CAJkqNs2oOCm7h0otnQEmc3brr1Y5RdjkMkGWfSW0tc+yhWCKVg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Switch branch to correct hash
 in case of two premirrors
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Mateusz Marciniec <mateuszmar2@gmail.com>,
 Jan Brzezanski <jan.brzezanski@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009119a605e5e3ee71"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 14:33:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13885

--0000000000009119a605e5e3ee71
Content-Type: text/plain; charset="UTF-8"

>If I understand what that code is doing, even if the upstream branch
>didn't have (and never had) the revision in question, it would force
>that revision onto the branch?
>
>I don't think we want to do that.
Actually yes, since I couldn't find a way to determine the specific branch
for specific git:// entry at this point. It's still better than not being
able to checkout the hash on a branch even though it's there. Maybe the
better solution would be to get rid of 'tmpdir' and just clean the
clonedir and unpack the tarball to clonedir? I wasn't sure if there was
some reason for using tmpdir, so I didn't want to change that.


>Some basic test would be useful here.
I will try to work on some test once we find some solution.

Best regards,
Tomasz Dziendzielski

--0000000000009119a605e5e3ee71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt;If I understand what that code is doi=
ng, even if the upstream branch<br>&gt;didn&#39;t have (and never had) the =
revision in question, it would force<br>&gt;that revision onto the branch?<=
br>&gt;<br>&gt;I don&#39;t think we want to do that.<br>Actually yes, since=
 I couldn&#39;t find a way to determine the specific branch for specific gi=
t:// entry at this point. It&#39;s still better than not being able to chec=
kout the hash on a branch even though=C2=A0it&#39;s there. Maybe the better=
 solution would be to get rid of &#39;tmpdir&#39; and just clean the cloned=
ir=C2=A0and unpack the tarball to clonedir? I wasn&#39;t sure if there was =
some reason for using tmpdir, so I didn&#39;t want to change that.</div><di=
v dir=3D"ltr"><br><br>&gt;Some basic test would be useful here.=C2=A0</div>=
I will try to work on some test once we find some solution.<div><br></div><=
div>Best regards,</div><div>Tomasz Dziendzielski</div></div>

--0000000000009119a605e5e3ee71--

