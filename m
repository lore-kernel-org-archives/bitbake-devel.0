Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD3E8FDD9
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 07:43:38 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.13192.1696405410367442967
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Oct 2023 00:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=MLSz/FPR;
 spf=pass (domain: snapchat.com, ip: 209.85.218.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9936b3d0286so324848666b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 00:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1696405409; x=1697010209; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h0mo5iLh6Du9zzeStSctIy5Ehw6zttSiD1o87sNKOBo=;
        b=MLSz/FPRIc05zxamOz01uCyWJ1CAmmNoQKrFP2XDCj0P/hnSdQ8WX9TRMv84GY5Ffp
         L48OtAgjCYt3x+KvvhpJavy0Q49pG99aN2cU4Y2338xIq117uZVNPmO/4Wc0yo50tnSA
         6TniEt4Exo6d/s8Gz+KzceTyiuXtSBZz8KAls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696405409; x=1697010209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0mo5iLh6Du9zzeStSctIy5Ehw6zttSiD1o87sNKOBo=;
        b=RcC0pow8MAcmx9CflIAd8zbbOfQyxzniCvtVodmFpsJ7+fYjrSVrGvHcwvlX+oGZuX
         qJtfWV2uHDmp1RV3COsXVSVMjFq5H7eBNKjMbPpEtIp+71i2o83B+GnE7qXumLA0jVx1
         bRb/sbi18hxpOQ64GYQjyoM3Ma2gtZm/7rQxRrSr0A31KKJMnyBmbzQed3JDxHW6GLwJ
         4LtvPiSE+tZBkUXGx1pv+Vvbtd2hBt0CoRC85TFpgcc6cP7wTdbF6BOgflC1seTcXilQ
         ja4IyjoIFyNFw0Zk8xOv0V4rG64dUibGzHmqWsd1hy7zPrSOCJvMONZcghdqge+9zQEC
         2LXw==
X-Gm-Message-State: AOJu0YwZMsMd9UYbVSyhc4m9kMNfThmkV2Cdpth/80cA66DFsXnmDui2
	4kM+bnNF0H5ZrZlPC+ThXOY1HsjBrpNKTIinITQLfQ==
X-Google-Smtp-Source: AGHT+IG+AErECueo2xIDDa6C6ciEESHOkH6gF/2fmeWJhDfmyOSdTppE8j4mxeEgV0YU09hOx8QblWvs4lzWc/T/ypc=
X-Received: by 2002:a17:906:3197:b0:9af:4561:591d with SMTP id
 23-20020a170906319700b009af4561591dmr1415377ejy.18.1696405408649; Wed, 04 Oct
 2023 00:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230921075658.509846-1-ecordonnier@snap.com> <0d94ff1c8efe8d37471f3c0bfe09403a7d8c5af8.camel@linuxfoundation.org>
 <1786E57180396CF1.29236@lists.openembedded.org>
In-Reply-To: <1786E57180396CF1.29236@lists.openembedded.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 4 Oct 2023 09:43:17 +0200
Message-ID: <CAHUKmYasZWwwZ_QZmd0WvFx=mE8na+0OCn3ddS1zNCp_O4rRBw@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH] bitbake-worker: add header with
 length of message
To: ecordonnier@snap.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000c7846c0606df2912"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 07:43:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15181

--000000000000c7846c0606df2912
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is the patch OK? I think it should be merged independently of whether the
amount of data sent through the IPC gets reduced or not.

--
Etienne

On Thu, Sep 21, 2023 at 1:09=E2=80=AFPM Etienne Cordonnier via
lists.openembedded.org <ecordonnier=3Dsnap.com@lists.openembedded.org> wrot=
e:

> Hi Richard,
> we have a use-case similar to the use-case for the externalsrc class,
> where we add whole directories containing many source-code files to SRC_U=
RI
> of various recipes (instead of pointing to a tarball or to a git reposito=
ry
> like poky recipes do). For that reason, we transmit 180MB of "workerdata"
> for one build instead of 18MB of workerdata e.g. for core-image-sato. The
> workerdata contains the signatures of many files and is therefore quite b=
ig
> (the "sigdata" field of the workerdata dictionary).
> However with this fix the transmission is quite fast (about 1.5 seconds
> for the call to "RunQueue.send_pickled_data(worker, workerdata,
> "workerdata")", and could probably be optimized even more by passing the
> length-header first in the IPC and doing only one blocking read for all t=
he
> data).
>
> Here is an analysis of the workerdata payload in my test setup (I dumped
> workerdata to a file, then used awk '{ print length }' file.txt to count
> each line):
> 'taskdeps': 16.520.856
> 'fakerootenv': 10.318.907
> 'fakerootdirs': 884.364
> 'fakerootnoenv': 569.865
> 'sigdata': 160.786.962
> 'logdefaultlevel': 23
> 'build_verbose_shell': 30
> 'build_verbose_stdout': 31
> 'logdefaultdomain': 24
> 'prhost': 16
> 'buildname': 31
> 'date': 20
> 'time': 18
> 'hashservaddr': 22
> 'umask': 17
>
> Reducing the size of the data is maybe an option (I don't know enough
> about bitbake architecture to judge whether it's possible or not), but I
> would improve the IPC anyway, since there is no drawback in making it mor=
e
> efficient.
>
> Etienne
>
> On Thu, Sep 21, 2023 at 10:22=E2=80=AFAM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Thu, 2023-09-21 at 09:56 +0200, Etienne Cordonnier via
>> lists.yoctoproject.org
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.yoctoprojec=
t.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNo=
nVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D11AFtkuAPLmyyZbu73s_NJ98bO45wx63X=
ixN5V-1juUffwxOK25p5bXA2b9tA-UX&s=3DlNJwDNb9Qjcyy3HwPW3pD8ENHA3amzROyreHrTz=
s7xE&e=3D>
>> wrote:
>> > From: Etienne Cordonnier <ecordonnier@snap.com>
>> >
>> > The IPC mechanism between runqueue.py and bitbake-worker is currently
>> > not scalable:
>> >
>> > The data is sent with the format <tag>pickled-data</tag>, and
>> bitbake-worker
>> > has no information about the size of the message. Therefore, the
>> bitbake-worker
>> > is calling select() and read() in a loop, and then calling
>> "self.queue.find(b"</" + item + b">")"
>> > for each chunk received.
>> >
>> > This does not scale, because queue.find has a linear complexity
>> relative to the size of the queue,
>> > and workerdata messages get very big e.g. for builds which reference a
>> lot of files in SRC_URI.
>> > The number of chunks varies, but on my test system a lot of chunks of
>> 65536 bytes are sent, and each
>> > iteration takes 0.1 seconds, making the transfer of the "workerdata"
>> data very slow (on my test setup
>> > 35 seconds before this fix, and 1.5 seconds after this fix).
>> >
>> > This commit adds a 4 bytes header after <tag>, so that bitbake-worker
>> knows how many bytes need to be
>> > received, and does not need to constantly search the whole queue for
>> </tag>.
>> >
>> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
>> > ---
>> >  bin/bitbake-worker | 34 +++++++++++++++++++++++-----------
>> >  lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
>> >  2 files changed, 45 insertions(+), 23 deletions(-)
>>
>> This does look interesting. The IPC mechanism was never intended to
>> carry large data and it has changed over time in ways it was never
>> really designed for.
>>
>> I'm guessing just one of the objects is particularly large? You mention
>> lots of files in SRC_URI causing the issue, I'd like to better
>> understand that.
>>
>> I'm just wondering whether instead of improving the IPC, we could avoid
>> some of the data in the first place?
>>
>> Cheers,
>>
>> Richard
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15102):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_15102&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D11=
AFtkuAPLmyyZbu73s_NJ98bO45wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&s=3D35XolLdH=
iGgz7p5y-cijay8jWjCYklOw3Ao5BblsE_g&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_101496046_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D11AFtkuAPLmyy=
Zbu73s_NJ98bO45wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&s=3D27u-Kj3KVuMWX7dENA5=
Cp4uFi1bzjhHiTJK9Jrliirk&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D11AFtkuAPL=
myyZbu73s_NJ98bO45wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&s=3DDp6Bh7DLleq67c9k=
K9wfJeNF6n8TE0PgJa092Me7eww&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000c7846c0606df2912
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is the patch OK? I think it should be merged independently=
 of whether the amount of data sent through the IPC gets reduced or not.<br=
><br>--<br>Etienne</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Sep 21, 2023 at 1:09=E2=80=AFPM Etienne Cordonnie=
r via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> =
&lt;ecordonnier=3D<a href=3D"mailto:snap.com@lists.openembedded.org">snap.c=
om@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr">Hi Richard,<br>we have a use-case=
 similar to the use-case for the externalsrc class, where we add whole dire=
ctories containing many source-code files to SRC_URI of various recipes (in=
stead of pointing to a tarball or to a git repository like poky recipes do)=
. For that reason, we transmit 180MB of &quot;workerdata&quot; for one buil=
d instead of 18MB of workerdata e.g. for core-image-sato. The workerdata co=
ntains the signatures of many files and is therefore quite big (the &quot;s=
igdata&quot; field of the workerdata dictionary).<br>However with this fix =
the transmission is quite fast (about 1.5 seconds for the call to &quot;Run=
Queue.send_pickled_data(worker, workerdata, &quot;workerdata&quot;)&quot;, =
and could probably be optimized even more by passing the length-header firs=
t in the IPC and doing only one blocking read for all the data).<br><br>Her=
e is an analysis of the workerdata payload in my test setup (I dumped worke=
rdata=C2=A0to a file, then used awk &#39;{ print length }&#39; file.txt to =
count each line):<br>&#39;taskdeps&#39;: 16.520.856<br>&#39;fakerootenv&#39=
;: 10.318.907<br>&#39;fakerootdirs&#39;: 884.364<br>&#39;fakerootnoenv&#39;=
: 569.865<br>&#39;sigdata&#39;: 160.786.962<br>&#39;logdefaultlevel&#39;: 2=
3<br>&#39;build_verbose_shell&#39;: 30<br>&#39;build_verbose_stdout&#39;: 3=
1<br>&#39;logdefaultdomain&#39;: 24<br>&#39;prhost&#39;: 16<br>&#39;buildna=
me&#39;: 31<br>&#39;date&#39;: 20<br>&#39;time&#39;: 18<br>&#39;hashservadd=
r&#39;: 22<br>&#39;umask&#39;: 17<br><br>Reducing the size of the data is m=
aybe an option (I don&#39;t know enough about bitbake architecture to judge=
 whether it&#39;s possible or not), but I would improve the IPC anyway, sin=
ce there is no drawback in making it more efficient.<br><br>Etienne</div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Sep 21, 2023 at 10:22=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richa=
rd.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfounda=
tion.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Thu, 2023-09-21 at 09:56 +0200, Etienne Cordonnier via<br>
<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.yoct=
oproject.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epck=
fdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D11AFtkuAPL=
myyZbu73s_NJ98bO45wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&amp;s=3DlNJwDNb9Qjcy=
y3HwPW3pD8ENHA3amzROyreHrTzs7xE&amp;e=3D" rel=3D"noreferrer" target=3D"_bla=
nk">lists.yoctoproject.org</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; The IPC mechanism between runqueue.py and bitbake-worker is currently<=
br>
&gt; not scalable:<br>
&gt; <br>
&gt; The data is sent with the format &lt;tag&gt;pickled-data&lt;/tag&gt;, =
and bitbake-worker<br>
&gt; has no information about the size of the message. Therefore, the bitba=
ke-worker<br>
&gt; is calling select() and read() in a loop, and then calling &quot;self.=
queue.find(b&quot;&lt;/&quot; + item + b&quot;&gt;&quot;)&quot;<br>
&gt; for each chunk received.<br>
&gt; <br>
&gt; This does not scale, because queue.find has a linear complexity relati=
ve to the size of the queue,<br>
&gt; and workerdata messages get very big e.g. for builds which reference a=
 lot of files in SRC_URI.<br>
&gt; The number of chunks varies, but on my test system a lot of chunks of =
65536 bytes are sent, and each<br>
&gt; iteration takes 0.1 seconds, making the transfer of the &quot;workerda=
ta&quot; data very slow (on my test setup<br>
&gt; 35 seconds before this fix, and 1.5 seconds after this fix).<br>
&gt; <br>
&gt; This commit adds a 4 bytes header after &lt;tag&gt;, so that bitbake-w=
orker knows how many bytes need to be<br>
&gt; received, and does not need to constantly search the whole queue for &=
lt;/tag&gt;.<br>
&gt; <br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bin/bitbake-worker | 34 +++++++++++++++++++++++-----------<br>
&gt;=C2=A0 lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------<br>
&gt;=C2=A0 2 files changed, 45 insertions(+), 23 deletions(-)<br>
<br>
This does look interesting. The IPC mechanism was never intended to<br>
carry large data and it has changed over time in ways it was never<br>
really designed for.<br>
<br>
I&#39;m guessing just one of the objects is particularly large? You mention=
<br>
lots of files in SRC_URI causing the issue, I&#39;d like to better<br>
understand that.<br>
<br>
I&#39;m just wondering whether instead of improving the IPC, we could avoid=
<br>
some of the data in the first place?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15102): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15102&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D11AFtkuAPLmyyZbu73s_NJ98=
bO45wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&amp;s=3D35XolLdHiGgz7p5y-cijay8jWj=
CYklOw3Ao5BblsE_g&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_15102&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3D11AFtkuAPLmyyZbu73s_NJ98bO45wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&amp;s=
=3D35XolLdHiGgz7p5y-cijay8jWjCYklOw3Ao5BblsE_g&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_101496046_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D11AFtkuAPLmyyZbu73s_NJ98bO45wx63XixN5V-1juUffw=
xOK25p5bXA2b9tA-UX&amp;s=3D27u-Kj3KVuMWX7dENA5Cp4uFi1bzjhHiTJK9Jrliirk&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_101496046_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D11AFtkuAPLmyyZbu73s_NJ98bO45wx6=
3XixN5V-1juUffwxOK25p5bXA2b9tA-UX&amp;s=3D27u-Kj3KVuMWX7dENA5Cp4uFi1bzjhHiT=
JK9Jrliirk&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3D11AFtkuAPLmyyZbu73s_NJ98bO45wx63XixN5V-1juUffwx=
OK25p5bXA2b9tA-UX&amp;s=3DDp6Bh7DLleq67c9kK9wfJeNF6n8TE0PgJa092Me7eww&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D11AFtkuAPLmyyZbu73s_NJ98bO45=
wx63XixN5V-1juUffwxOK25p5bXA2b9tA-UX&amp;s=3DDp6Bh7DLleq67c9kK9wfJeNF6n8TE0=
PgJa092Me7eww&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000c7846c0606df2912--

