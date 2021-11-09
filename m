Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7469BC433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:26:02 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web08.11320.1636460761497105675
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Z/wIOKMm;
 spf=pass (domain: gmail.com, ip: 209.85.208.52,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id x15so44770002edv.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8udvyzQfSDLtWwxiqKHu4rXkDQHuZQmn79s41vSYZjY=;
        b=Z/wIOKMmi9EsvUtlzvYGi5yYQWbrfYi7CzMAsQnvQ2ameBUEHU7qDDEbs7F0DSC/Sn
         24W88jJIOQHZ6+oz0ruGuXrx7s+bVIUfCF+IqpX6NYvCtgKiKHxAT95Lik7zXzqYlJqC
         xn70cARiqfUYVMJGlvwXThNMbTT8ExkAejQKxbBzsBBljVF41CbcSxzn2f6GPzaNGzT1
         0Bs1JDUQHKAw82SWcu7b8HuNo5g8WZ3vsQvrRz3QLfxOv7j7DPduqfOQNWio3C/33jF4
         MnfZTxscvVWUSdNBH53+6jwVhPypLXtNQ0ukxzYheXg7377Ik+OjghML9esNPUxblfxa
         X/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8udvyzQfSDLtWwxiqKHu4rXkDQHuZQmn79s41vSYZjY=;
        b=r3KdDz7z46y5kNwsJV7niduEIyLCJz4o5T5LmZ0jKULACTTwV0SNxIJbKvxborTGf2
         JqtwX+doBRYNNLODkNkiRFI1EQN1dt2h55AHYIJrOigQcMsmBd0vnheWHXQmG+a8RzK6
         sExJvUWMfEI5Xq4MAPmg0YApY/nDXtNre5v6MVi2jh73eWZmYw0/QO6C6tUZ00+obHO9
         vjaUWq7/GP6znr3Uq9DSZegu8262yw3eMmeJtVV8WZKxZR30RfJQvpCKP+7Ri0TeQqLj
         r6z7ZktweSMT37LeGQrWZoK9TlXAqE2gkLRY36J1KXCFy0ZQVE9NAyitVc5XWvVbjZhS
         1PyQ==
X-Gm-Message-State: AOAM530+sgZTGBinfJGQPzUHGl967KxVDcgtQHTUbu3WIGyZ6lS6pG46
	IWwSLKNyY2ATjjHanf/Wn/TMmXrZNX6YcQofATE=
X-Google-Smtp-Source: 
 ABdhPJzjAFqugBs0F9iqs9I3mK5kkqskWgfiOw+uWSrLYUn0im7fktg2Tq2k1553sgy+2vmvocZz2+MUohwlAXCsIjw=
X-Received: by 2002:aa7:c656:: with SMTP id z22mr9243720edr.251.1636460759852;
 Tue, 09 Nov 2021 04:25:59 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
 <e5b2f8439e5aab93a2841728e00650185ff60573.camel@linuxfoundation.org>
In-Reply-To: 
 <e5b2f8439e5aab93a2841728e00650185ff60573.camel@linuxfoundation.org>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Tue, 9 Nov 2021 13:25:48 +0100
Message-ID: 
 <CAMaS9hOMPi72-9CikR8b6BvKb7up11Ud62sVswUzKd8pVShUVg@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Mikko.Rapeli@bmw.de, Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000047a93505d05a3612"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:26:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12968

--00000000000047a93505d05a3612
Content-Type: text/plain; charset="UTF-8"

Point is: I actually don't care if you merge or use the MR to create a
patch for peer review as long as I don't have to use email...

If the process that kraj is doing manually can be automated then this would
combine the best of both worlds :thumbsup:

Marius


Am Di., 9. Nov. 2021 um 13:21 Uhr schrieb Richard Purdie <
richard.purdie@linuxfoundation.org>:

> On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski wrote:
> > I'm sure there is a readon not to hit the merge button but instead doing
> that
> > manually which I don't understand.
>
> No, you don't understand and it is actually a *really* important
> difference.
>
> We are a community project with wide peer review. *Nobody* gets to merge
> changes
> without that peer review. I may be the maintainer for some of it but even
> my own
> patches get peer review. This means there is no single "this patch can
> merge"
> point without it having been on the mailing list for potential discussion.
>
> If a patch gets sent via the github MR, someone needs to take that, put it
> on
> the mailing list and ensure the community gets to review it. Khem has
> kindly
> taken on that role for some patches which is his choice. If there is review
> feedback, it puts him in a tricky position since he then has to merge that
> back
> to the github discussion somehow. We do not encourage this and in the case
> of
> the repositories I maintain, I simply do not have the bandwidth to try and
> do
> this for multiple github MRs.
>
> I understand it is easier for people to submit but our processes simply
> don't
> scale to that and people would get *very* upset if changes through github
> MRs
> were bypassing normal peer review. This is why Khem cannot simply hit the
> merge
> button and why our other repos don't support that workflow.
>
> Cheers,
>
> Richard
>
>
>
>
>
>

--00000000000047a93505d05a3612
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Point is: I actually don&#39;t care if you merge or u=
se the MR to create a patch for peer review as long as I don&#39;t have to =
use email...</div><div><br></div><div>If the process that kraj is doing man=
ually can be automated then this would combine the best of both worlds :thu=
mbsup:</div><div><br></div><div>Marius</div><div><br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. =
2021 um 13:21=C2=A0Uhr schrieb Richard Purdie &lt;<a href=3D"mailto:richard=
.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 2021-11-09=
 at 12:56 +0100, Marius Kriegerowski wrote:<br>
&gt; I&#39;m sure there is a readon not to hit the merge button but instead=
 doing that<br>
&gt; manually which I don&#39;t understand.<br>
<br>
No, you don&#39;t understand and it is actually a *really* important differ=
ence.<br>
<br>
We are a community project with wide peer review. *Nobody* gets to merge ch=
anges<br>
without that peer review. I may be the maintainer for some of it but even m=
y own<br>
patches get peer review. This means there is no single &quot;this patch can=
 merge&quot;<br>
point without it having been on the mailing list for potential discussion.<=
br>
<br>
If a patch gets sent via the github MR, someone needs to take that, put it =
on<br>
the mailing list and ensure the community gets to review it. Khem has kindl=
y<br>
taken on that role for some patches which is his choice. If there is review=
<br>
feedback, it puts him in a tricky position since he then has to merge that =
back<br>
to the github discussion somehow. We do not encourage this and in the case =
of<br>
the repositories I maintain, I simply do not have the bandwidth to try and =
do<br>
this for multiple github MRs.<br>
<br>
I understand it is easier for people to submit but our processes simply don=
&#39;t<br>
scale to that and people would get *very* upset if changes through github M=
Rs<br>
were bypassing normal peer review. This is why Khem cannot simply hit the m=
erge<br>
button and why our other repos don&#39;t support that workflow.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--00000000000047a93505d05a3612--

