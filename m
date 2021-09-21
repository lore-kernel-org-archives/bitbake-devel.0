Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.1213.1632244984731422138
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 10:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Bvgb65bV;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id h3-20020a17090a580300b0019ce70f8243so2481457pji.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Sep 2021 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxYmoD9WC/YktUeeyN5qVIsj2h8ZpQw6U5zZdl55i6E=;
        b=Bvgb65bVV7apPYRZGd7DX9fPzUserEVJWF1cAtZQ37E4yTdqAMydR5QINrjyEiaJrb
         d3f1t6SJP6x+go3jwZS3Xn0hIhdP7eaNtd67QCn3W0MGlQgrW9VQ00VsYFZlw+GyYrUs
         dRHFQmGW45XXmw82Iarq+PPNokClJVVq5zrcoXHHphkG9Dp5LR/Ud7WQtGjFcVLED6fV
         b85kGc0JggvEqs7Wj3SeqJpQeS3ZNNqkaN4xHJSh3rpegM3psK9DCI+7M4y418TUZnWY
         q4VwXtJ4t4QK8+674t+M6MNksGakrAjiDqlVKkFaCTvX9vsRu1FL7HH7tLDIbwqIc/KK
         LG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxYmoD9WC/YktUeeyN5qVIsj2h8ZpQw6U5zZdl55i6E=;
        b=M45MOQoxlhIZXZWc/j9tRA9Ja1gNtAVx04FMZOByFf9i4fgz7J6wzHEkL87D8wwiAt
         +iHigves45v0mOff8kuCInFlN4Q+24HEEJ/+lv6h5wPHJUE4ZGAKSIiqVDoZCn9AkHHY
         8/+zyOPXyjAnUu940/a+6av0Vi4FM87604iA12aWZrl8vd0u6jMcOdSJwQhCXNsAXBZw
         H/XnqDaNcY3MC+0MqhlgCpHNL4zX0YH/xBGpk2WykhfvcPnRjWuP6DS4vPeFyNA3FMke
         gRb/+tFrIt4Q7hu2VPQnu7zWJEN26zBw2JhsV7FmQqH2XOdNIEWrDi2jq2eYsJciTepK
         Io0g==
X-Gm-Message-State: AOAM531wAjTJcra+HLHXmZjV/JLk/L0UMvXgxbQn5WVa7DSbMA2Dfove
	jpUpT3y+WvMMc03ZSFX0qJs+Ickn7GLrZYdHnew=
X-Google-Smtp-Source: ABdhPJyWKQewqb/pjV2OFQg5NimE5TVjlG085ufcsjnOxHaixBdrs2Yc8pdm4ZmAmaAg+wZ8jEwAuyEaI478Dghk6zk=
X-Received: by 2002:a17:90a:130f:: with SMTP id h15mr6587826pja.183.1632244984324;
 Tue, 21 Sep 2021 10:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632212181.git.anuj.mittal@intel.com>
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 21 Sep 2021 19:22:52 +0200
Message-ID: <CA+chaQfenZRTfeWsPieee10fQSw4Um3xj8SQW+WoPaSyNonjuw@mail.gmail.com>
Subject: Re: [bitbake-devel] [hardknott][PATCH 0/8] Review request
To: Anuj Mittal <anuj.mittal@intel.com>, Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000007a251e05cc84a614"

--0000000000007a251e05cc84a614
Content-Type: text/plain; charset="UTF-8"

LGTM

For next round of bitbake patches, can you please include 3 bitbake changes
from:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14542
?

All 3 (fc58ad84a9deb2620ad90611684dad65dafedb11
e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8
9eee9fd4f2f96789ad2b037e74d561bdc1426856) apply cleanly on bitbake 1.46,
1.48 and 1.50.

+Steve Sakoman <steve@sakoman.com> to consider for dunfell as well.

Thanks

On Tue, Sep 21, 2021 at 10:35 AM Anuj Mittal <anuj.mittal@intel.com> wrote:

> Please review these changes for hardknott/1.50. Tested with oe-core and
> no related problems seen.
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2625
>
> Thanks,
>
> Anuj
>
> The following changes since commit
> 4d83d9103d9225a2ac42c0f3dfada2f5cf140b68:
>
>   build: Catch and error upon circular task references (2021-09-16
> 22:17:07 +0100)
>
> are available in the Git repository at:
>
>   git://push.openembedded.org/bitbake-contrib stable/1.50-next
>
> Martin Jansa (1):
>   cooker/process: Fix typos in exiting message
>
> Richard Purdie (7):
>   cookerdata: Show error for no BBLAYERS in bblayers.conf
>   cookerdata: Improve missing core layer error message
>   data_smart: Improve error display for handled exceptions
>   runqueue: Clean up task stats handling
>   bitbake-worker: Improve error handling
>   cookerdata: Show a readable error for invalid multiconfig name
>   runqueue/knotty: Improve UI handling of setscene task counting
>
>  bin/bitbake-worker       | 10 ++++++----
>  lib/bb/cooker.py         |  2 +-
>  lib/bb/cookerdata.py     |  7 +++++++
>  lib/bb/data_smart.py     |  2 ++
>  lib/bb/runqueue.py       | 43 +++++++++++++++++++++++-----------------
>  lib/bb/server/process.py |  2 +-
>  lib/bb/ui/knotty.py      |  2 +-
>  lib/bb/ui/uihelper.py    |  4 ++--
>  8 files changed, 45 insertions(+), 27 deletions(-)
>
> --
> 2.31.1
>
>
> 
>
>

--0000000000007a251e05cc84a614
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">LGTM<div><br></div><div>For next round of bitbake patches,=
 can you please include 3 bitbake changes from:</div><div><a href=3D"https:=
//bugzilla.yoctoproject.org/show_bug.cgi?id=3D14542" target=3D"_blank">http=
s://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14542</a><br></div><div>?</=
div><div><br></div><div>All 3 (fc58ad84a9deb2620ad90611684dad65dafedb11 e2c=
1afda4cb8023ed4ffeb5dc5bee4f0055659a8 9eee9fd4f2f96789ad2b037e74d561bdc1426=
856) apply cleanly on bitbake 1.46, 1.48 and 1.50.</div><div><br></div><div=
><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:steve@s=
akoman.com" tabindex=3D"-1">+Steve Sakoman</a>=C2=A0to consider for dunfell=
 as well.<br></div><div><br></div><div>Thanks</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 21, 2021 at =
10:35 AM Anuj Mittal &lt;<a href=3D"mailto:anuj.mittal@intel.com" target=3D=
"_blank">anuj.mittal@intel.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Please review these changes for hardknott/1.5=
0. Tested with oe-core and<br>
no related problems seen.<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/83/build=
s/2625" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproje=
ct.org/typhoon/#/builders/83/builds/2625</a><br>
<br>
Thanks,<br>
<br>
Anuj<br>
<br>
The following changes since commit 4d83d9103d9225a2ac42c0f3dfada2f5cf140b68=
:<br>
<br>
=C2=A0 build: Catch and error upon circular task references (2021-09-16 22:=
17:07 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://push.openembedded.org/bitbake-contrib" rel=
=3D"noreferrer" target=3D"_blank">push.openembedded.org/bitbake-contrib</a>=
 stable/1.50-next<br>
<br>
Martin Jansa (1):<br>
=C2=A0 cooker/process: Fix typos in exiting message<br>
<br>
Richard Purdie (7):<br>
=C2=A0 cookerdata: Show error for no BBLAYERS in bblayers.conf<br>
=C2=A0 cookerdata: Improve missing core layer error message<br>
=C2=A0 data_smart: Improve error display for handled exceptions<br>
=C2=A0 runqueue: Clean up task stats handling<br>
=C2=A0 bitbake-worker: Improve error handling<br>
=C2=A0 cookerdata: Show a readable error for invalid multiconfig name<br>
=C2=A0 runqueue/knotty: Improve UI handling of setscene task counting<br>
<br>
=C2=A0bin/bitbake-worker=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++++----<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0lib/bb/cookerdata.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++++++<br>
=C2=A0lib/bb/data_smart.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0lib/bb/runqueue.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 43 +++++++++++++++++++=
++++-----------------<br>
=C2=A0lib/bb/server/process.py |=C2=A0 2 +-<br>
=C2=A0lib/bb/ui/knotty.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0lib/bb/ui/uihelper.py=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A08 files changed, 45 insertions(+), 27 deletions(-)<br>
<br>
-- <br>
2.31.1<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000007a251e05cc84a614--
