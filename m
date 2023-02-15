Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1AC64ED6
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:46:26 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.12276.1676457978397532933
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:46:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mg4cROV9;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id f18-20020a7bcd12000000b003e206711347so233229wmj.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 02:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xSZves06thaO4aoxibBtS0fO0Ge5/c7KJ4bVJ2tbPyc=;
        b=mg4cROV9mS/uWeDZalZbghiy3MGe9txPQTGWRq0WPK2XMCVRjaz7JuASjpJKSJc9t3
         YBKbFV1FdcjQJFyxROYJR0FRZ+Ou9XSTzenLrRxQ28P9u6Is56Ti8+2RFQe14NSLchl7
         JchCw2zHzk7vX0QNyQFKpRNDm+ql1s2k+UojDESkhFRHXzerJZHr60FenNdoOpvmiYi7
         C7JiX/USemW2PaJP0vwZFc80EMlcZA5JPQRrvkP/JC+ikOyZX2snpxMl/OPfvYmIt/1g
         BCrs3oFCSy43nvTn4lya6g5/SqTlqGqvNxYuWk0dHL1/ZopbzggyhWEOCrl2b3O+Jnkw
         gF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSZves06thaO4aoxibBtS0fO0Ge5/c7KJ4bVJ2tbPyc=;
        b=dvHg+/bnR3oj+CccB8m9En4JzWa/mrkqUPbEWTcycu08KKjzK9LOYHwdCroLcpbh7c
         aKrB/Z0WIPaSQT+ulo6cRcN88ruX3DQut+57zA36VxQ7DUiuIbQ0yv5Wku8PcGyfpQ1A
         mMKULJXQ+x4PEU/qzL1gLHy5PfkreaMEteKKW/ewK+iDde2GJAy13WHmQ0Us4CO8h96X
         0ygu4BhpZu5M9Lj68t2eFkeaMe4NsoqTvbzfhO7vxfrkI61RbqmSNzVZ6MAumo6aDDzI
         cCrNhWJwRSCjtQi4KT1Q83bA5l5u4r0EFLS7tUyfkMh8SdF/SpFENhSQ8Tf2B5q+ncjp
         GUAA==
X-Gm-Message-State: AO0yUKW8EodxZIprma0xT2LlskCYmMVgS3+0BGvUzWWTN1VaHsbJidWv
	qHeEorJVjmTH7z/p0dQQDo9SIN9aMnlmaHD26aoPixpe6LQ=
X-Google-Smtp-Source: AK7set8hKABEgSsle2GQ+u5LGcQwhbNPUtgUQnM/9mLAlxFIZdK7jxdCJ2gsKll9OqKAjBzE7Y+2ayKkz60/IDgDwBg=
X-Received: by 2002:a05:600c:3b89:b0:3dc:5b14:8d56 with SMTP id
 n9-20020a05600c3b8900b003dc5b148d56mr164513wms.171.1676457976924; Wed, 15 Feb
 2023 02:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20221127214934.541723-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221127214934.541723-1-richard.purdie@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 15 Feb 2023 11:46:04 +0100
Message-ID: <CA+chaQcs0KVqKYA_FJnaTfmFk25F+XrxGRzofCo5eH9L-BGwfA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH RFC] data: Evaluate the value of
 export/unexport/network flags
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000032103f05f4baca7c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:46:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14433

--00000000000032103f05f4baca7c
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 27, 2022 at 10:49 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Currently the export/unexport/network flags are acted on only by presence
> or lack of in the data store. This is deliberate due to performance reasons
> since a given recipe shell task might export ~80-90 variables and this
> means
> expanding flags for every one of them.
>
> This does catch users unaware since values which expand to nothing don't
> work
> e.g. ${@""} and setting values to "0" wouldn't work either.
>
> The downside to this patch is slow down in parsing speed of around 4%.
>
> The network flag is easier to change and doesn't affect performance, it was
> made to operate the same as export/unexport for consitency reasons.
>

You already know my opinion, but for others on ML I'm in favor of this
change.

Parsing time is negligible compared to do_compile times in most of my
builds.

Expanding this will allow to resolve e.g. icecc.bbclass to respect
ICECC_DISABLED before enabling network in all tasks:
https://lists.openembedded.org/g/openembedded-core/message/167731
I already have such change for icecc.bbclass and will send it when/if this
bitbake change is merged.

Thanks
Cheers,

--00000000000032103f05f4baca7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sun, Nov 27, 2022 at 10:49 PM Richard =
Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.pu=
rdie@linuxfoundation.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Currently the export/une=
xport/network flags are acted on only by presence<br>
or lack of in the data store. This is deliberate due to performance reasons=
<br>
since a given recipe shell task might export ~80-90 variables and this mean=
s<br>
expanding flags for every one of them.<br>
<br>
This does catch users unaware since values which expand to nothing don&#39;=
t work<br>
e.g. ${@&quot;&quot;} and setting values to &quot;0&quot; wouldn&#39;t work=
 either.<br>
<br>
The downside to this patch is slow down in parsing speed of around 4%.<br>
<br>
The network flag is easier to change and doesn&#39;t affect performance, it=
 was<br>
made to operate the same as export/unexport for consitency reasons.<br></bl=
ockquote><div><br></div><div>You already know my opinion, but for others on=
 ML I&#39;m in favor of this change.</div><div><br></div><div>Parsing time =
is negligible compared to do_compile times in most of my builds.</div><div>=
<br></div><div>Expanding this will allow to resolve e.g. icecc.bbclass to r=
espect ICECC_DISABLED before enabling network in all tasks:</div><div><a hr=
ef=3D"https://lists.openembedded.org/g/openembedded-core/message/167731">ht=
tps://lists.openembedded.org/g/openembedded-core/message/167731</a><br></di=
v><div>I already have such change for icecc.bbclass and will send it when/i=
f this bitbake change is merged.</div><div><br></div><div>Thanks</div><div>=
Cheers,</div></div></div>

--00000000000032103f05f4baca7c--

