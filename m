Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F2C61DA3
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:09:59 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.15176.1677236992670254408
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 03:09:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oqnoCS7e;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so3980654wms.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 03:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UiAjp8GvwRIDlPvhCQENzMlSqXHlBPX17sVsXq9tFnc=;
        b=oqnoCS7esNALqZAxVxDM4/7yjUKkCn3sCNJGxANESWDn420QSUkCleC33u8q8aOUvG
         +qvCqG7kHt3wcWoF/77I5M0m54WyyRZEzluTRzifhGY9nf1bQK6ZVDjj5AhJ2ofHBN7X
         d01Au1d+e8FAO+jQEGEoqzbYQunCvOAlhALLVammXzF2hHh2L3FEMp9SFMDPyIostT68
         QOAr5HlW3Q4voCf41uxaVUy8zH08jVxhVXk9p5WSClc6k5FbZrllZ3GsTn7tyr2519Ec
         Wr+wfGYtBgo4zhgxsj6hlSctrnCFPvU9pu+UttvjQz6OTtVohWZqBxMNIDWFoRvTvmCP
         Z50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiAjp8GvwRIDlPvhCQENzMlSqXHlBPX17sVsXq9tFnc=;
        b=OXuoIEMD2mYyhSH9FZw0EwgmzvYmWOuZPSBpaFB61eu3itNChfRE/29Mytk0/1neMw
         Bf2nWbzc4SbYO7Ycm/pkWanJ0cy3CX69zQ1bem7IVi/ZMI12fFYBMwHwnTREosfl/6zW
         NporsGy4LnyrVdppO/TKS0T5YdxxBF5eJ3EgUXmLEBu7j14a962UK13Ewg9t9oBtyJAW
         xotfrGwcBaYMv8VXXOdQCjFYLXZHkNcbgN/dp1lhucPtTHK9S4jt5EbBegsGsdMjHt4K
         HABs0sIh+bSuJEouAp5IHN9bgRSyovPG1FT+/Vstg/88uemMiduQu/IeAIVfJyE05fc0
         jbpg==
X-Gm-Message-State: AO0yUKUihw+GeTz0c6tVuyeINoIlz8UAjAIn6o160TDO658xIhS59UAf
	KY+VOOWSG4YSoGwI1k3zBTII8K6XSwXCoAVMusQdiHduIGo=
X-Google-Smtp-Source: AK7set/Wij8QKxeRJw407qipIDLUWCYQLBGUoRHsVcpYnid6lkQymHD72gGu+1pntioCQzOxLzH+FFNKc6V3CsoX8ZA=
X-Received: by 2002:a05:600c:502c:b0:3df:fc69:e977 with SMTP id
 n44-20020a05600c502c00b003dffc69e977mr1174053wmr.5.1677236991051; Fri, 24 Feb
 2023 03:09:51 -0800 (PST)
MIME-Version: 1.0
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 24 Feb 2023 12:09:36 +0100
Message-ID: <CA+chaQcSZDgrbeZjOU+THvNTrQt+VzCUGg3p1FMVG9qiP4QDAw@mail.gmail.com>
Subject: Bitbake repo using the same tag name as branch
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Lee Chee Yang <chee.yang.lee@intel.com>
Content-Type: multipart/alternative; boundary="0000000000000e4aac05f5702bbe"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 11:09:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14483

--0000000000000e4aac05f5702bbe
Content-Type: text/plain; charset="UTF-8"

Is there some reason why bitbake started to use tag name identical as
branch name from 2.0?

It happens only with 2.0 and 2.2, because previous 1.52 branch had first
release named 1.52.0 not 1.52:
commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:
2021-10-honister, tag: 1.52.0)

bitbake $ git show 1.52.0
tag 1.52.0
Tagger: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Date:   Mon Oct 25 15:16:54 2021 -0700

Tagging for 1.52.0 (yocto-3.4)

This new scheme has small disadvantage:

bitbake $ git push github 2.0
error: src refspec 2.0 matches more than one
error: failed to push some refs to 'github.com:shr-distribution/bitbake.git'

I can work around it by using refs/heads/2.0 and refs/tags/2.0 to
distinguish between them, but that's still a bit unusual and unfortunate.

Adding Chee Yang Lee who authored these 2 tags (see another warning there):

bitbake $ git show 2.0
warning: refname '2.0' is ambiguous.
tag 2.0
Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
Date:   Mon Apr 25 22:27:04 2022 -0700

bitbake $ git show 2.2
warning: refname '2.2' is ambiguous.
tag 2.2
Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
Date:   Sun Oct 23 20:33:14 2022 -0700

--0000000000000e4aac05f5702bbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Is there some reason why bitbake started to use tag n=
ame identical as branch name from 2.0?</div><div><br></div><div>It happens =
only with 2.0 and 2.2, because previous 1.52 branch had first release named=
 1.52.0 not 1.52:</div><div>commit c78ebac71ec976fdf27ea24767057882870f5c60=
 (tag: yocto-3.4, tag: 2021-10-honister, tag: 1.52.0)<br></div><div><br></d=
iv><div>bitbake $ git show 1.52.0<br>tag 1.52.0<br>Tagger: Vineela Tummalap=
alli &lt;<a href=3D"mailto:vineela.tummalapalli@intel.com">vineela.tummalap=
alli@intel.com</a>&gt;<br>Date: =C2=A0 Mon Oct 25 15:16:54 2021 -0700<br><b=
r>Tagging for 1.52.0 (yocto-3.4)<br></div><div><br></div><div>This new sche=
me has small disadvantage:</div><div><br></div>bitbake $ git push github 2.=
0<br>error: src refspec 2.0 matches more than one<br>error: failed to push =
some refs to &#39;github.com:shr-distribution/bitbake.git&#39;<br><div><br>=
</div><div>I can work around it by using refs/heads/2.0 and refs/tags/2.0 t=
o distinguish between them, but that&#39;s still a bit unusual and unfortun=
ate.</div><div><br></div><div>Adding Chee Yang Lee who authored these 2 tag=
s (see another warning there):</div><div><br></div><div>bitbake $ git show =
2.0<br>warning: refname &#39;2.0&#39; is ambiguous.<br>tag 2.0<br>Tagger: C=
hee Yang Lee &lt;<a href=3D"mailto:chee.yang.lee@intel.com">chee.yang.lee@i=
ntel.com</a>&gt;<br>Date: =C2=A0 Mon Apr 25 22:27:04 2022 -0700<br></div><d=
iv><br></div><div>bitbake $ git show 2.2<br>warning: refname &#39;2.2&#39; =
is ambiguous.<br>tag 2.2<br>Tagger: Chee Yang Lee &lt;<a href=3D"mailto:che=
e.yang.lee@intel.com">chee.yang.lee@intel.com</a>&gt;<br>Date: =C2=A0 Sun O=
ct 23 20:33:14 2022 -0700<br></div></div>

--0000000000000e4aac05f5702bbe--

