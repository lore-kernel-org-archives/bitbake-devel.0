Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4BC433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:31:54 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web09.11328.1636461113536003889
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:31:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KqEmE3a0;
 spf=pass (domain: gmail.com, ip: 209.85.208.54,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id f4so75696481edx.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GTa2BEck2TGa5G91Q3uBBHcTe/tQAJfr0fuxE+juxA=;
        b=KqEmE3a0rTuK9mCe4veZ+F/xcQ1pxFaW8qQuAMDuIN5BDlj3/BDgRQfqPz3xW4EiZm
         tTjF4nXn3riKTEF8shOPSjA2rXYBX4lZ1XZwar07c1Bc3rVh2QxXjShH4gL6dhUihEH3
         0S5Ch51TFf9Uz6FeyHiA+RlI2ajEkfMPZIWylqxoiEJpu3O96nF0CdoWozluPqB+e4fQ
         odHBW29I1KGuAj0Xcm1KoDYUhYMfNHcJtFd+r9RCUR2B3nEVwaKyFKoLzsQcpzZ7lKcm
         l0+eB72tx42+jmS02KBkY69f32DNBOWiPOp8QuYTBKAV5qMxwEWtqWHN5WqM4wthBO5V
         kocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GTa2BEck2TGa5G91Q3uBBHcTe/tQAJfr0fuxE+juxA=;
        b=gOdJnsqbjhOMQ/pm2jg17/EkS5YB4TQRci6+6DXz/MI8VKCZEoEXnvYphYCFw1Rk5J
         awmTdnnJFhHgyNTX/0OCFE7l4FIoVTmsYBqDckmDbEytMHkz/+Iq08HjYs2PPlvNrrx1
         1mstR1M15lCnynTmONfIkMCw6yQ/8i4oKE7DptEdOsBBjwHWGBXq0A/J9JZVSpTVwLyt
         z/uCoyzQIHTqXPx/TPE+u+9TUkA4vnDqqVka+nD85fGgyez54db6z4a2N5TDCQ1kEr9I
         Xod+mkGRbjQuolRBXBUciEDEPtv1UAo8CUmXr/YBMb8uCEAhnzlyxtzvfcTVBdIEHecY
         vT3w==
X-Gm-Message-State: AOAM530yDWyALdfiLYDeUYhcIhKFl1fYnudlYkRv9Cj7jVQerlMhudOz
	XSzd0h+SrCWPd3sJ8i3egulHYXOSXEwmCaHjt5A=
X-Google-Smtp-Source: 
 ABdhPJzrDrPXCBpUnHDIWIOiRgu6v6lq4LMSzwRDVKqkSlzPgrHOhKwEud33B35nSII694QXV11PuC+5cKy+70dNGhY=
X-Received: by 2002:a05:6402:d0a:: with SMTP id
 eb10mr9731183edb.186.1636461111764;
 Tue, 09 Nov 2021 04:31:51 -0800 (PST)
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
 <16B5E0648E5826A2.410@lists.openembedded.org>
In-Reply-To: <16B5E0648E5826A2.410@lists.openembedded.org>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Tue, 9 Nov 2021 13:31:40 +0100
Message-ID: 
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Mikko.Rapeli@bmw.de,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000416b5a05d05a4b36"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:31:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12969

--000000000000416b5a05d05a4b36
Content-Type: text/plain; charset="UTF-8"

Sorry for double-posting BTW. Hit the resend button after I had an issue
with the local vpn here.

Funny thing is: I only get feedback from people who contributed for 10+
years or they of themselves that they are old. Can the early contributors
that are <35 yrs old and recently started contributing speak up and share
their thoughts? That would be very appreciated.

Anyways, time for lunch. I'll leave it at that I think.

Am Di., 9. Nov. 2021 um 13:26 Uhr schrieb Marius Kriegerowski via
lists.openembedded.org <marius.kriegerowski=gmail.com@lists.openembedded.org
>:

> Point is: I actually don't care if you merge or use the MR to create a
> patch for peer review as long as I don't have to use email...
>
> If the process that kraj is doing manually can be automated then this
> would combine the best of both worlds :thumbsup:
>
> Marius
>
>
> Am Di., 9. Nov. 2021 um 13:21 Uhr schrieb Richard Purdie <
> richard.purdie@linuxfoundation.org>:
>
>> On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski wrote:
>> > I'm sure there is a readon not to hit the merge button but instead
>> doing that
>> > manually which I don't understand.
>>
>> No, you don't understand and it is actually a *really* important
>> difference.
>>
>> We are a community project with wide peer review. *Nobody* gets to merge
>> changes
>> without that peer review. I may be the maintainer for some of it but even
>> my own
>> patches get peer review. This means there is no single "this patch can
>> merge"
>> point without it having been on the mailing list for potential discussion.
>>
>> If a patch gets sent via the github MR, someone needs to take that, put
>> it on
>> the mailing list and ensure the community gets to review it. Khem has
>> kindly
>> taken on that role for some patches which is his choice. If there is
>> review
>> feedback, it puts him in a tricky position since he then has to merge
>> that back
>> to the github discussion somehow. We do not encourage this and in the
>> case of
>> the repositories I maintain, I simply do not have the bandwidth to try
>> and do
>> this for multiple github MRs.
>>
>> I understand it is easier for people to submit but our processes simply
>> don't
>> scale to that and people would get *very* upset if changes through github
>> MRs
>> were bypassing normal peer review. This is why Khem cannot simply hit the
>> merge
>> button and why our other repos don't support that workflow.
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>>
>>
>>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12968):
> https://lists.openembedded.org/g/bitbake-devel/message/12968
> Mute This Topic: https://lists.openembedded.org/mt/86911583/6547911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> marius.kriegerowski@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000416b5a05d05a4b36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry for double-posting BTW. Hit the resend button a=
fter I had an issue with the local vpn here.</div><div><br></div><div>Funny=
 thing is: I only get feedback from people who contributed for 10+ years or=
 they of themselves that they are old. Can the early contributors that are =
&lt;35 yrs old and recently started contributing speak up and share their t=
houghts? That would be very appreciated.</div><div><br></div><div>Anyways, =
time for lunch. I&#39;ll leave it at that I think.<br></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov.=
 2021 um 13:26=C2=A0Uhr schrieb Marius Kriegerowski via <a href=3D"http://l=
ists.openembedded.org">lists.openembedded.org</a> &lt;marius.kriegerowski=
=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.open=
embedded.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div>Point is: I actually don&#39;t care if you merg=
e or use the MR to create a patch for peer review as long as I don&#39;t ha=
ve to use email...</div><div><br></div><div>If the process that kraj is doi=
ng manually can be automated then this would combine the best of both world=
s :thumbsup:</div><div><br></div><div>Marius</div><div><br></div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9.=
 Nov. 2021 um 13:21=C2=A0Uhr schrieb Richard Purdie &lt;<a href=3D"mailto:r=
ichard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfo=
undation.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski wrote:<br>
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
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12968): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12968" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12968</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86911583/6547=
911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86911583/6547911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:marius.kriegerowski@gmail.com" tar=
get=3D"_blank">marius.kriegerowski@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000416b5a05d05a4b36--

