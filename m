Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA8C4707E
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:38 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web09.13044.1649780796615401847
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 09:26:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=AUBm+RPm;
 spf=pass (domain: gmail.com, ip: 209.85.218.54,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id u15so19734605ejf.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:mime-version:subject:message-id:date:to;
        bh=M7hJwviQtkVF8IB8rUKdx0EQKzALhucKnDwc1D/lDKM=;
        b=AUBm+RPmv89G8eUoW2i3HD4+4aD0sdfNR0mBU7moa/aXDQSoCUNKqCHgxRanfm+aC1
         qNVqV8VUeKEFceyeOHapvnd9zMbjlnHBEKqxma7kz0+le7eQ8TwxzGzn8FGkd27zSyRM
         yFiLfu5Gc4iJNcysuGD6t0SBl8t6Z0Iiq1wylPw8ckocujIgGz4GboN/oWBCswvsASUu
         8LhcQBkb5bTxYWqtru826b2ExXG8AjSQg3PG7MT/Vp6wNpEobu2C741N6Y/29FxDyPkh
         QcvT/nUFR/AsaRPtD+n9S+NVtimvMDnzrkPv2jCrE6jEaigqIar5j9ucADA4vENNjj7e
         rqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=M7hJwviQtkVF8IB8rUKdx0EQKzALhucKnDwc1D/lDKM=;
        b=0IJhzFmuZgmeNP87RGfMYNlKxbF36HBvYL2sl9rm8592LFkQZ9b8e01nHDLNxS2LKt
         JS7Yvqp6sYM/IXVGuyh5A/9PddlGbzZ5urQVX5UIy1I/oUAffjagvHyWTz9KKdzX3h3D
         eBzqYlIoesNDc/0b4S7xP6SH2225UbNOPUZO3WeRDxLL7EjcVbwQI8KBwcUfu4XME79F
         TW71GgFdyS25mglTo4TYEMtzAoP4tnU96ASCBseezlvOgRuftYFz5Ei/c2C2N6i0CQ1V
         V6dQQxK8vfISq1Cb3+uL8t/+lOIOekOZ8pvCxDpO/7Xh2feBha62hXqL98wLxG0sQ34T
         +DWw==
X-Gm-Message-State: AOAM532YiB9ERyxbrgs3SkdCFmztohWWHbAvdq5h8EnNPiXkd7O6a4eb
	/UxfBUNL3zmwro3JbnQ4f8CsoNjzJVo=
X-Google-Smtp-Source: 
 ABdhPJxwm/qQa+testMlpo3Bwfq4qBjdhGQOJCpEaC7wRCYCfux9qm279a7SZj4CwL1XEuvLREoH7Q==
X-Received: by 2002:a17:906:af7b:b0:6e8:8123:78ab with SMTP id
 os27-20020a170906af7b00b006e8812378abmr11996883ejb.434.1649780794979;
        Tue, 12 Apr 2022 09:26:34 -0700 (PDT)
Received: from smtpclient.apple ([79.140.115.47])
        by smtp.gmail.com with ESMTPSA id
 a22-20020a50ff16000000b00410d029ea5csm16725959edu.96.2022.04.12.09.26.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 09:26:34 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D4E53237-9D89-4C67-8079-73861700F443"
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Branch switch doesn't work on openembedded.org
Message-Id: <D247F1F9-1C2C-4B53-828A-ABB4D29800DF@gmail.com>
Date: Tue, 12 Apr 2022 18:26:34 +0200
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Apr 2022 16:46:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13609


--Apple-Mail=_D4E53237-9D89-4C67-8079-73861700F443
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

The branch switch button on the top right on git.openembedded.org =
<http://git.openembedded.org/> seems to be broken. At least it doesn=E2=80=
=99t switch between branches on firefox 99.0.

I tried switching between `master` and `dunfell` on this one (but =
doesn=E2=80=99t seem to switch nowhere):=20

=
http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-dev=
tools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832dc=
9b90f9d5a6&h=3Dmaster =
<http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-de=
vtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832d=
c9b90f9d5a6&h=3Dmaster>

Also, it doesn=E2=80=99t work when clicking the `switch` button after =
selecting a different branch. Am I using it in the wrong way??
=20
Best
Marius


Ps:=20
I tried sending that to the main list but I couldn=E2=80=99t. It is =
tagged as =E2=80=9Cnew member moderated=E2=80=9D but I don=E2=80=99t =
know what that means. I=E2=80=99m not sure this is the right mailing =
list either. So feel free to forward to the right one. Thanks :)=

--Apple-Mail=_D4E53237-9D89-4C67-8079-73861700F443
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D"">Hi,</div><div class=3D""><br class=3D""></div><div =
class=3D"">The branch switch button on the top right on&nbsp;<a =
href=3D"http://git.openembedded.org" =
class=3D"">git.openembedded.org</a>&nbsp;seems to be broken. At least it =
doesn=E2=80=99t switch between branches on firefox 99.0.</div><div =
class=3D""><br class=3D""></div><div class=3D"">I tried switching =
between `master` and `dunfell` on this one (but doesn=E2=80=99t seem to =
switch nowhere):&nbsp;</div><div class=3D""><br class=3D""></div><a =
href=3D"http://git.openembedded.org/meta-openembedded/tree/meta-python/rec=
ipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428f=
f11832dc9b90f9d5a6&amp;h=3Dmaster" =
class=3D"">http://git.openembedded.org/meta-openembedded/tree/meta-python/=
recipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf6784=
28ff11832dc9b90f9d5a6&amp;h=3Dmaster</a><div class=3D""><br =
class=3D""></div><div class=3D"">Also, it doesn=E2=80=99t work when =
clicking the `switch` button after selecting a different branch. Am I =
using it in the wrong way??</div><div class=3D"">&nbsp;</div><div =
class=3D"">Best</div><div class=3D"">Marius</div><div class=3D""><br =
class=3D""></div><div class=3D""><div class=3D""><br class=3D""></div><div=
 class=3D""><div class=3D"">Ps:&nbsp;</div><div class=3D"">I tried =
sending that to the main list but I couldn=E2=80=99t. It is tagged as =
=E2=80=9Cnew member moderated=E2=80=9D but I don=E2=80=99t know what =
that means. I=E2=80=99m not sure this is the right mailing list either. =
So feel free to forward to the right one. Thanks =
:)</div></div></div></body></html>=

--Apple-Mail=_D4E53237-9D89-4C67-8079-73861700F443--

