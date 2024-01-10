Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AEEC4707B
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 17:14:30 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.17427.1704906869309338514
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jan 2024 09:14:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=fKnnGb0w;
 spf=pass (domain: snapchat.com, ip: 209.85.218.46, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28bd9ca247so486329766b.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 09:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1704906868; x=1705511668; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6XwON7wic12rJgFB+hIBLUecLKsZsXIs97vBAjwDgE=;
        b=fKnnGb0wLQfsCpYI/aZvb2MlyVxCpH8Shrl14ooHLu63RTn/fu+JppwWyO1aMfTREn
         YSFSTo4TBZ5xoGwzRT9ChWUOJ4woGm1bJjLONMeMuCQyaJy42BOik+VDfRHwwd7dRxUP
         eUjoVKI+PXc0ReLtwPaVEZEouqjr5dsHJkRmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704906868; x=1705511668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6XwON7wic12rJgFB+hIBLUecLKsZsXIs97vBAjwDgE=;
        b=X7oVeQR6DbMuHH3v0SgILFw5QSc58dgA69zNT8uODG8USMq5alyNS9or5ktubNhzbp
         V3YVAq8FLVf4d7EIWWnGietcQOaTCYI560EJN+g5lTkQqWjmJ9XiqvwiwBN7X4XeVZhR
         mpxrhatFW4F3KnDWRlnAkUfIE9nB8zSTfgPmu5OO0slrtGTZxtRTXG0UhErBuUQrUf61
         dqxQmPva4fSdAF4svZY7d66Symbf/eQBfjvODBN7GJXTUn2UW80nHSd4f+SSBD3vQEEb
         MmoellRm68Z0YEse93PetmW5CeSuxMzCoN9LkXjyt1lByk0oKlHgOVSe9Hv8Z+xXZOhl
         OfBg==
X-Gm-Message-State: AOJu0YxfTmghcgJewsuoN6qAETtQth0JUr26PukHMoOBUU1qwwdWlcik
	MK/1NGd/8jRwBwNBtVcqMGYipvnCL5DzsH7pAwpMR9TZ6kBLpg==
X-Google-Smtp-Source: AGHT+IEu7LSzasWEu2Qq2j3Q0dKkUzTC54e9cG3BfZ1296RkdnTONYXTsXSQsKI443WhEtw4xmxKb2jBSGSWrHZMozo=
X-Received: by 2002:a17:906:19c:b0:a29:1648:6030 with SMTP id
 28-20020a170906019c00b00a2916486030mr693138ejb.86.1704906867598; Wed, 10 Jan
 2024 09:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
 <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
 <c0a11023-9bc7-40de-9240-0006c98f1607@windriver.com> <c527e73b-7e94-4495-b155-437d48284359@windriver.com>
 <CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com>
 <aab3f796-728e-4716-b094-daee2e822612@windriver.com> <CA+chaQfuyyOACJ1SL6gu=0ASnzqgD++Q73H2+ibbZRA4YsLBwg@mail.gmail.com>
In-Reply-To: <CA+chaQfuyyOACJ1SL6gu=0ASnzqgD++Q73H2+ibbZRA4YsLBwg@mail.gmail.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 10 Jan 2024 18:14:16 +0100
Message-ID: <CAHUKmYbY9RjgQGOxQEZwMyykAGUmkamQxhY0P=aheP1u1J4o+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
To: Martin Jansa <martin.jansa@gmail.com>
Cc: randy.macleod@windriver.com, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000385cf8060e9a9036"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 17:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15781

--000000000000385cf8060e9a9036
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Randy: "Also, despite the logs, do you find that pressure regulation is
useful for you?"
-> yes, testing a while back showed that setting this value to 500 reduced
the clean-build durations of several minutes, which is why I added this
configuration a year ago

@Martin: thanks for the info! I indeed configured the value to 500 after
doing some testing while I was on kirkstone 4.0.4 (long before
https://github.com/yoctoproject/poky/commit/a76bc698c43a3e9792ec0ff8c97c446=
a20c1439e
which was added in 4.0.15), and missed that I needed to change the value
after updating to 4.0.15. I'll test with higher values

On Wed, Jan 10, 2024 at 5:47=E2=80=AFPM Martin Jansa <martin.jansa@gmail.co=
m> wrote:

> I think your limit 500 is just too low after:
> https://lists.openembedded.org/g/bitbake-devel/message/15499
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedde=
d.org_g_bitbake-2Ddevel_message_15499&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4=
vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DX=
GfSv6zHSImmkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&s=3DB4aqICG=
4GUIKccICnUztvgZdL24Ztt98IIZMsBNoUZk&e=3D>
> was backported (already included in kirkstone-4.0.15).
>
> FWIW: on 64 thread AMD Threadripper 3970X I'm using much higher CPU_MAX
> limit and much lower bitbake thread count and still trigger these message=
s
> (but I still find them useful).
>
> This was just "small incremental build" of "bitbake -k lib32-kmscube
> lib32-wavpack":
>
> Sstate summary: Wanted 62 Local 0 Mirrors 0 Missed 62 Current 431 (0%
> match, 87% complete)
> Removing 48 stale sstate objects for arch mach: 100%
> Removing 1 stale sstate objects for arch x86_64: 100%
> NOTE: Executing Tasks
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 533768.7/200000.0, IO: 3306.5/None, Mem: 2611.1/None) - using 2/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 172224.8/200000.0, IO: 9830.9/None, Mem: 0.0/None) - using 2/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 426774.0/200000.0, IO: 3229.3/None, Mem: 0.0/None) - using 2/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 170159.7/200000.0, IO: 798.0/None, Mem: 0.0/None) - using 2/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 201391.4/200000.0, IO: 132.8/None, Mem: 0.0/None) - using 2/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 159116.4/200000.0, IO: 0.0/None, Mem: 0.0/None) - using 2/8 bitbake threa=
ds
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 210248.5/200000.0, IO: 270.8/None, Mem: 0.0/None) - using 3/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 198485.4/200000.0, IO: 1577.3/None, Mem: 0.0/None) - using 3/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 219595.7/200000.0, IO: 3824.7/None, Mem: 0.0/None) - using 3/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 199729.1/200000.0, IO: 1121.1/None, Mem: 0.0/None) - using 3/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 304074.6/200000.0, IO: 5498.7/None, Mem: 44.2/None) - using 3/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 194765.9/200000.0, IO: 2600.7/None, Mem: 0.0/None) - using 3/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 201263.5/200000.0, IO: 2437.4/None, Mem: 0.0/None) - using 4/8 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 195733.7/200000.0, IO: 2454.0/None, Mem: 0.0/None) - using 4/8 bitbake
> threads
> NOTE: Tasks Summary: Attempted 1473 tasks of which 1335 didn't need to be
> rerun and all succeeded.
>
> On Wed, Jan 10, 2024 at 4:28=E2=80=AFPM Randy MacLeod via lists.openembed=
ded.org
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.openembedded=
.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNon=
VuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DXGfSv6zHSImmkkXtVGhYi8KvF7P-URlnWS=
S4yjgh00mSKcgkdUb_w74W6PwFLlOg&s=3D1CqYM87mmPOKlTX29Ag8j0-3WXx1ZhPx0vB9Zjrd=
Apo&e=3D>
> <randy.macleod=3Dwindriver.com@lists.openembedded.org> wrote:
>
>> Hi Etienne,
>>
>> On 2024-01-10 9:09 a.m., Etienne Cordonnier wrote:
>>
>> "How many physical/virtual cores are actually available?
>>
>> Is some other activity doing CPU intensive work on the system?
>> Is the one task running > 48 compile jobs and causing CPU contention in
>> the system?"
>>
>> -> This is a physical PC with 24 physical cores and 48 cores when you
>> take hyperthreading into account (Intel Xeon Gold 6240R)
>>
>> Thanks.
>>
>> -> there is no other activity doing CPU intensive work
>> -> some bitbake tasks can easily load 48 cores, yes (this is a custom
>> image with some extra layers added)
>>
>>
>> I see, then other than deferring new tasks, there's not much that
>> pressure regulation can do to help once one of these
>> CPU intensive tasks is started.
>>
>> Other than the log verbosity which we likely won't change for a while,
>> did you have any PSI-related concerns?
>>
>> I did notice that your last log was:
>> > NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
>> 21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake
>> threads
>>
>> When there's memory pressure, that's usually an indication that the
>> system is paging to disk.
>>
>>
>> Also, despite the logs, do you find that pressure regulation is useful
>> for you?
>> You can always leave it turned off and only rely on the task and job
>> limits.
>>
>> Thanks,
>>
>> ../Randy
>>
>>
>>
>> Etienne
>>
>>
>> --
>> # Randy MacLeod
>> # Wind River Linux
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#15779):
>> https://lists.openembedded.org/g/bitbake-devel/message/15779
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedd=
ed.org_g_bitbake-2Ddevel_message_15779&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_=
4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D=
XGfSv6zHSImmkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&s=3Do0eGuV=
u9EDjTnjX6J0BuJ1YzBW3dlc3UVSYYslDY0gs&e=3D>
>> Mute This Topic: https://lists.openembedded.org/mt/100117828/3617156
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedd=
ed.org_mt_100117828_3617156&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkI=
CC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DXGfSv6zHSIm=
mkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&s=3DRWBsbi9oTfLo48SrG=
XNbjtF13PxjrJX1y-PoEimQFS4&e=3D>
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedd=
ed.org_g_bitbake-2Ddevel_unsub&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabg=
GkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DXGfSv6zH=
SImmkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&s=3DbpBRZ_4shRibij=
ymE6MJZi-SHIkHCZMsixgigmP-rJ0&e=3D>
>> [martin.jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>

--000000000000385cf8060e9a9036
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0">@Randy=
: &quot;</a>Also, despite the logs, do you find that pressure regulation is=
 useful for you?&quot;<br>-&gt; yes, testing a while back showed that setti=
ng this value to 500 reduced the clean-build durations of several minutes, =
which is why I added this configuration a year ago<br><br>@Martin: thanks f=
or the info! I indeed configured the value to 500 after doing some testing =
while I was on kirkstone 4.0.4 (long before=C2=A0<a href=3D"https://github.=
com/yoctoproject/poky/commit/a76bc698c43a3e9792ec0ff8c97c446a20c1439e">http=
s://github.com/yoctoproject/poky/commit/a76bc698c43a3e9792ec0ff8c97c446a20c=
1439e</a> which was added in 4.0.15), and missed that I needed to change th=
e value after updating to 4.0.15. I&#39;ll test with higher values<br></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, Jan 10, 2024 at 5:47=E2=80=AFPM Martin Jansa &lt;<a href=3D"mailto:marti=
n.jansa@gmail.com">martin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">=
<div>I think your limit 500 is just too low after:</div><div><a href=3D"htt=
ps://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_=
g_bitbake-2Ddevel_message_15499&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF=
_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E=
&amp;m=3DXGfSv6zHSImmkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&a=
mp;s=3DB4aqICG4GUIKccICnUztvgZdL24Ztt98IIZMsBNoUZk&amp;e=3D" target=3D"_bla=
nk">https://lists.openembedded.org/g/bitbake-devel/message/15499</a><br></d=
iv><div>was backported (already included in=C2=A0kirkstone-4.0.15).</div><d=
iv><br></div></div><div dir=3D"ltr">FWIW: on 64 thread AMD Threadripper 397=
0X I&#39;m using much higher CPU_MAX limit and much lower bitbake thread co=
unt and still trigger these messages (but I still find them useful).<div><b=
r></div><div>This was just &quot;small incremental build&quot; of &quot;bit=
bake -k lib32-kmscube lib32-wavpack&quot;:<br></div><div><br></div><div>Sst=
ate summary: Wanted 62 Local 0 Mirrors 0 Missed 62 Current 431 (0% match, 8=
7% complete)<br>Removing 48 stale sstate objects for arch mach: 100%=C2=A0<=
br>Removing 1 stale sstate objects for arch x86_64: 100%=C2=A0<br>NOTE: Exe=
cuting Tasks<br>NOTE: Pressure status changed to CPU: True, IO: None, Mem: =
None (CPU: 533768.7/200000.0, IO: 3306.5/None, Mem: 2611.1/None) - using 2/=
8 bitbake threads<br>NOTE: Pressure status changed to CPU: False, IO: None,=
 Mem: None (CPU: 172224.8/200000.0, IO: 9830.9/None, Mem: 0.0/None) - using=
 2/8 bitbake threads<br>NOTE: Pressure status changed to CPU: True, IO: Non=
e, Mem: None (CPU: 426774.0/200000.0, IO: 3229.3/None, Mem: 0.0/None) - usi=
ng 2/8 bitbake threads<br>NOTE: Pressure status changed to CPU: False, IO: =
None, Mem: None (CPU: 170159.7/200000.0, IO: 798.0/None, Mem: 0.0/None) - u=
sing 2/8 bitbake threads<br>NOTE: Pressure status changed to CPU: True, IO:=
 None, Mem: None (CPU: 201391.4/200000.0, IO: 132.8/None, Mem: 0.0/None) - =
using 2/8 bitbake threads<br>NOTE: Pressure status changed to CPU: False, I=
O: None, Mem: None (CPU: 159116.4/200000.0, IO: 0.0/None, Mem: 0.0/None) - =
using 2/8 bitbake threads<br>NOTE: Pressure status changed to CPU: True, IO=
: None, Mem: None (CPU: 210248.5/200000.0, IO: 270.8/None, Mem: 0.0/None) -=
 using 3/8 bitbake threads<br>NOTE: Pressure status changed to CPU: False, =
IO: None, Mem: None (CPU: 198485.4/200000.0, IO: 1577.3/None, Mem: 0.0/None=
) - using 3/8 bitbake threads<br>NOTE: Pressure status changed to CPU: True=
, IO: None, Mem: None (CPU: 219595.7/200000.0, IO: 3824.7/None, Mem: 0.0/No=
ne) - using 3/8 bitbake threads<br>NOTE: Pressure status changed to CPU: Fa=
lse, IO: None, Mem: None (CPU: 199729.1/200000.0, IO: 1121.1/None, Mem: 0.0=
/None) - using 3/8 bitbake threads<br>NOTE: Pressure status changed to CPU:=
 True, IO: None, Mem: None (CPU: 304074.6/200000.0, IO: 5498.7/None, Mem: 4=
4.2/None) - using 3/8 bitbake threads<br>NOTE: Pressure status changed to C=
PU: False, IO: None, Mem: None (CPU: 194765.9/200000.0, IO: 2600.7/None, Me=
m: 0.0/None) - using 3/8 bitbake threads<br>NOTE: Pressure status changed t=
o CPU: True, IO: None, Mem: None (CPU: 201263.5/200000.0, IO: 2437.4/None, =
Mem: 0.0/None) - using 4/8 bitbake threads<br>NOTE: Pressure status changed=
 to CPU: False, IO: None, Mem: None (CPU: 195733.7/200000.0, IO: 2454.0/Non=
e, Mem: 0.0/None) - using 4/8 bitbake threads<br>NOTE: Tasks Summary: Attem=
pted 1473 tasks of which 1335 didn&#39;t need to be rerun and all succeeded=
.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, Jan 10, 2024 at 4:28=E2=80=AFPM Randy MacLeod via <a hre=
f=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.openembedd=
ed.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&a=
mp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DXGfSv6zHSImmkkXt=
VGhYi8KvF7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&amp;s=3D1CqYM87mmPOKlTX29A=
g8j0-3WXx1ZhPx0vB9ZjrdApo&amp;e=3D" target=3D"_blank">lists.openembedded.or=
g</a> &lt;randy.macleod=3D<a href=3D"mailto:windriver.com@lists.openembedde=
d.org" target=3D"_blank">windriver.com@lists.openembedded.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
  <div>
    <div>Hi Etienne,</div>
    <div><br>
    </div>
    <div>On 2024-01-10 9:09 a.m., Etienne
      Cordonnier wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">&quot;How many physical/virtual cores are actually
        available?
        <p>Is some other activity doing CPU intensive work on the
          system?<br>
          Is the one task running &gt; 48 compile jobs and causing CPU
          contention in the system?&quot;<br>
          <br>
          -&gt; This is a physical PC with 24 physical cores and 48
          cores when you take hyperthreading into account (Intel Xeon
          Gold 6240R)<br>
        </p>
      </div>
    </blockquote>
    Thanks.<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <p>-&gt; there is no other activity doing CPU intensive work<br>
          -&gt; some bitbake tasks can easily load 48 cores, yes (this
          is a custom image with some extra layers added)<br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I see, then other than deferring new tasks, there&#39;s not much tha=
t
      pressure regulation can do to help once one of these <br>
      CPU intensive tasks is started.</p>
    <p>Other than the log verbosity which we likely won&#39;t change for a
      while, did you have any PSI-related concerns?</p>
    <p>I did notice that your last log was:<br>
      &gt; NOTE: Pressure status changed to CPU: True, IO: None, Mem:
      None (CPU: 21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) -
      using 1/48 bitbake threads</p>
    <p>When there&#39;s memory pressure, that&#39;s usually an indication t=
hat
      the system is paging to disk.<br>
    </p>
    <p><br>
    </p>
    <p>Also, despite the logs, do you find that pressure regulation is
      useful for you?<br>
      You can always leave it turned off and only rely on the task and
      job limits.<br>
    </p>
    <p>Thanks,<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <p><br>
          Etienne</p>
      </div>
    </blockquote>
    <br>
    <pre cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15779): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15779&a=
mp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DXGfSv6zHSImmkkXtVGhYi8Kv=
F7P-URlnWSS4yjgh00mSKcgkdUb_w74W6PwFLlOg&amp;s=3Do0eGuVu9EDjTnjX6J0BuJ1YzBW=
3dlc3UVSYYslDY0gs&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.openembedded.org/g/bitbake-devel/message/15779</a><br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_100117828_3617156&amp;d=3DDwMFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DXGfSv6zHSImmkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKc=
gkdUb_w74W6PwFLlOg&amp;s=3DRWBsbi9oTfLo48SrGXNbjtF13PxjrJX1y-PoEimQFS4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100117828/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwMFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DXGfSv6zHSImmkkXtVGhYi8KvF7P-URlnWSS4yjgh00mSKcg=
kdUb_w74W6PwFLlOg&amp;s=3DbpBRZ_4shRibijymE6MJZi-SHIkHCZMsixgigmP-rJ0&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/=
bitbake-devel/unsub</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=
=3D"_blank">martin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000385cf8060e9a9036--

