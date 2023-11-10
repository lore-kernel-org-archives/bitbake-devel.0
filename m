Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6EC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 14:06:55 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.28111.1699625210527744676
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 06:06:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QIXePYAG;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-408425c7c10so15702145e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699625208; x=1700230008; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu7LHHoP0HSX6f0ME+xhNatwX7qkKCdeT2LyZRNdSdU=;
        b=QIXePYAGdr1ga2zDQTNlbVmq7CqKF63oOtsHXfoSwKcNiL+5lumWU6hGBMPoJNS7Mf
         d7zPsWiy3o5gm8q/XidAosmko7zN1dUy0SdbP2hlsrJ42Izwbh1o600itX1ykHYdCQwP
         67ExnO6j5lcAyB2As9LZJHkkst2+VX+k83Ae4fHtcmJqAiXSZyd37Xb6coNb6Y1d5qHU
         Vm3G/TxSrTF91IAtrmZu+UFSVdp+ayOvu1zqOwMIcPxA+uAykqDuEVO79ZGHuz8B7eFs
         8oyjDEhCcbg9dDqrkc7qNcQFo3Ue5vEp5UYPt1tQcHuvgtU4pUMOao/ulQzkUseEYbTJ
         s+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625208; x=1700230008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mu7LHHoP0HSX6f0ME+xhNatwX7qkKCdeT2LyZRNdSdU=;
        b=p/E7FzgTFPcFIyUJDk2TTlK7g+coGO02r5MXPAguhbf2SW3akJCv/8DYZ51HuEbkjT
         ZnYMe9HLkQRXcBXQxOIkPavYYVj02PmlYvXiAsq1v+j1mqVxSYsRNgfmjsX/0P+kj0i2
         6WXgHNPz/PrPbreF74fW5hydfjC+QX7NZh5BVVgH010EfOuFQIKNd7H6kcQyqlzDXaFI
         PdK3G8VPJ4wqicS3VvKBoabZWkjo5pQkHgxar3oc5mfUPt7mwuhxiiixO4dK8d+WJr+9
         Eo+5V/O3w5aCGrZULW9YfQAOGFsFQvyfytLplzuKGnrQ/BnlHbDhUj2Mwfx6+XjAYAei
         yYPA==
X-Gm-Message-State: AOJu0YyAWif8bWTgqI50gKmO6idOkx0l8D12An+VGss2/HtPo/fhLd9L
	RtBytin1Lrsx4XU13pNGKVcrJN9pnWGVzcL67PU=
X-Google-Smtp-Source: AGHT+IFMEJLkmZoFgvnac17Ko0sBc6iXwFny7rLh6LA/rb6JEiFvM/h2TRAbEpClNRxTFPqxEL6LUwNx79ravFinOZ0=
X-Received: by 2002:a05:600c:3511:b0:409:7900:f3d0 with SMTP id
 h17-20020a05600c351100b004097900f3d0mr7387428wmq.34.1699625208040; Fri, 10
 Nov 2023 06:06:48 -0800 (PST)
MIME-Version: 1.0
References: <17964777D58C012A.3202@lists.openembedded.org>
In-Reply-To: <17964777D58C012A.3202@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 10 Nov 2023 15:06:34 +0100
Message-ID: <CA+chaQc3jWaE0Bto1MQFf45bUVdY_8UvAb9N1vFM=A1-Q_RnGA@mail.gmail.com>
Subject: Re: [bitbake-devel] [2.0][PATCH 1/5] runqueue: fix PSI check calculation
To: martin.jansa@gmail.com
Cc: bitbake-devel@lists.openembedded.org, steve@sakoman.com, 
	Chen Qi <Qi.Chen@windriver.com>, Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Randy Macleod <randy.macleod@windriver.com>
Content-Type: multipart/alternative; boundary="000000000000c6d1590609ccd42e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 14:06:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15499

--000000000000c6d1590609ccd42e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to include [RFC] tag in the subject, because these changes might
be a bit controversial.

From my testing:
https://github.com/shr-project/test-oe-build-time/commit/d5111f4472ac397c0f=
1197eb6366ac7d2e56453f
the reasonable pressure values for 2.0 (in kirkstone) and 2.6 (in nanbield)
are significantly different due to these changes in PSI calculation and
logic so while 1000 was reasonable value for my system in 2.0, I need
100000 with 2.6.

I've backported these changes long time ago for my local builds to use the
same PSI values for all builds.

And the controversy is that backporting these will change the expected
values (so kind of change in behavior which might not be suitable for
stable release). But the commits make it sound as a bug in the logic, so we
can also consider them as bug fixes.

The change in expected pressure values was reported in:
https://lists.openembedded.org/g/bitbake-devel/message/14942

If it's not a bug to be fixed in 2.0 then maybe we should mention different
PSI values in release notes for nanbield (I know I'm too late for that).

Regards,

On Fri, Nov 10, 2023 at 2:54=E2=80=AFPM Martin Jansa via lists.openembedded=
.org
<martin.jansa=3Dgmail.com@lists.openembedded.org> wrote:

> From: Chen Qi <Qi.Chen@windriver.com>
>
> The current PSI check calculation does not take into consideration
> the possibility of the time interval between last check and current
> check being much larger than 1s. In fact, the current behavior does
> not match what the manual says about BB_PRESSURE_MAX_XXX, even if
> the value is set to upper limit, 1000000, we still get many blocks
> on new task launch. The difference between 'total' should be divided
> by the time interval if it's larger than 1s.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 8605c46c8..3e89c38bc 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -198,15 +198,20 @@ class RunQueueScheduler(object):
>                  curr_cpu_pressure =3D
> cpu_pressure_fds.readline().split()[4].split("=3D")[1]
>                  curr_io_pressure =3D
> io_pressure_fds.readline().split()[4].split("=3D")[1]
>                  curr_memory_pressure =3D
> memory_pressure_fds.readline().split()[4].split("=3D")[1]
> -                exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) >
> self.rq.max_cpu_pressure
> -                exceeds_io_pressure =3D  self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) >
> self.rq.max_io_pressure
> -                exceeds_memory_pressure =3D self.rq.max_memory_pressure =
and
> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) >
> self.rq.max_memory_pressure
>                  now =3D time.time()
> -                if now - self.prev_pressure_time > 1.0:
> +                tdiff =3D now - self.prev_pressure_time
> +                if tdiff > 1.0:
> +                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
> self.rq.max_cpu_pressure
> +                    exceeds_io_pressure =3D  self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
> self.rq.max_io_pressure
> +                    exceeds_memory_pressure =3D self.rq.max_memory_press=
ure
> and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
> tdiff > self.rq.max_memory_pressure
>                      self.prev_cpu_pressure =3D curr_cpu_pressure
>                      self.prev_io_pressure =3D curr_io_pressure
>                      self.prev_memory_pressure =3D curr_memory_pressure
>                      self.prev_pressure_time =3D now
> +                else:
> +                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) >
> self.rq.max_cpu_pressure
> +                    exceeds_io_pressure =3D  self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) >
> self.rq.max_io_pressure
> +                    exceeds_memory_pressure =3D self.rq.max_memory_press=
ure
> and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) >
> self.rq.max_memory_pressure
>              return (exceeds_cpu_pressure or exceeds_io_pressure or
> exceeds_memory_pressure)
>          return False
>
> --
> 2.42.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15494):
> https://lists.openembedded.org/g/bitbake-devel/message/15494
> Mute This Topic: https://lists.openembedded.org/mt/102506693/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000c6d1590609ccd42e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I forgot to include [RFC] tag in the subject, because thes=
e changes might be a bit controversial.<div><br></div><div>From my testing:=
</div><div><a href=3D"https://github.com/shr-project/test-oe-build-time/com=
mit/d5111f4472ac397c0f1197eb6366ac7d2e56453f">https://github.com/shr-projec=
t/test-oe-build-time/commit/d5111f4472ac397c0f1197eb6366ac7d2e56453f</a></d=
iv><div>the reasonable pressure values for 2.0 (in kirkstone) and 2.6 (in n=
anbield) are significantly different due to these changes in PSI calculatio=
n and logic so while 1000 was reasonable value for my system in 2.0, I need=
 100000 with 2.6.</div><div><br></div><div>I&#39;ve backported these change=
s long time ago for my local builds to use the same PSI values for all buil=
ds.</div><div><br></div><div>And the controversy is that backporting these =
will change the expected values (so kind of change in behavior which might =
not be suitable for stable release). But the commits make it sound as a bug=
 in the logic, so we can also consider them as bug fixes.</div><div><br></d=
iv><div>The change in expected pressure values was reported in:</div><div><=
a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/14942">htt=
ps://lists.openembedded.org/g/bitbake-devel/message/14942</a><br></div><div=
><br></div><div>If it&#39;s not a bug to be fixed in 2.0 then maybe we shou=
ld mention different PSI values in release notes for nanbield (I know I&#39=
;m too late for that).</div><div><br></div><div>Regards,</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 1=
0, 2023 at 2:54=E2=80=AFPM Martin Jansa via <a href=3D"http://lists.openemb=
edded.org" target=3D"_blank">lists.openembedded.org</a> &lt;martin.jansa=3D=
<a href=3D"mailto:gmail.com@lists.openembedded.org" target=3D"_blank">gmail=
.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@wind=
river.com" target=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
<br>
The current PSI check calculation does not take into consideration<br>
the possibility of the time interval between last check and current<br>
check being much larger than 1s. In fact, the current behavior does<br>
not match what the manual says about BB_PRESSURE_MAX_XXX, even if<br>
the value is set to upper limit, 1000000, we still get many blocks<br>
on new task launch. The difference between &#39;total&#39; should be divide=
d<br>
by the time interval if it&#39;s larger than 1s.<br>
<br>
Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=
=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/runqueue.py | 13 +++++++++----<br>
=C2=A01 file changed, 9 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 8605c46c8..3e89c38bc 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -198,15 +198,20 @@ class RunQueueScheduler(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curr_cpu_pres=
sure =3D cpu_pressure_fds.readline().split()[4].split(&quot;=3D&quot;)[1]<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curr_io_press=
ure =3D io_pressure_fds.readline().split()[4].split(&quot;=3D&quot;)[1]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curr_memory_p=
ressure =3D memory_pressure_fds.readline().split()[4].split(&quot;=3D&quot;=
)[1]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exceeds_cpu_pressu=
re =3D=C2=A0 self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float=
(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exceeds_io_pressur=
e =3D=C2=A0 self.rq.max_io_pressure and (float(curr_io_pressure) - float(se=
lf.prev_io_pressure)) &gt; self.rq.max_io_pressure<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exceeds_memory_pre=
ssure =3D self.rq.max_memory_pressure and (float(curr_memory_pressure) - fl=
oat(self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0now =3D time.=
time()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if now - self.prev=
_pressure_time &gt; 1.0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tdiff =3D now - se=
lf.prev_pressure_time<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if tdiff &gt; 1.0:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
eds_cpu_pressure =3D=C2=A0 self.rq.max_cpu_pressure and (float(curr_cpu_pre=
ssure) - float(self.prev_cpu_pressure)) / tdiff &gt; self.rq.max_cpu_pressu=
re<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
eds_io_pressure =3D=C2=A0 self.rq.max_io_pressure and (float(curr_io_pressu=
re) - float(self.prev_io_pressure)) / tdiff &gt; self.rq.max_io_pressure<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
eds_memory_pressure =3D self.rq.max_memory_pressure and (float(curr_memory_=
pressure) - float(self.prev_memory_pressure)) / tdiff &gt; self.rq.max_memo=
ry_pressure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.prev_cpu_pressure =3D curr_cpu_pressure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.prev_io_pressure =3D curr_io_pressure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.prev_memory_pressure =3D curr_memory_pressure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.prev_pressure_time =3D now<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
eds_cpu_pressure =3D=C2=A0 self.rq.max_cpu_pressure and (float(curr_cpu_pre=
ssure) - float(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
eds_io_pressure =3D=C2=A0 self.rq.max_io_pressure and (float(curr_io_pressu=
re) - float(self.prev_io_pressure)) &gt; self.rq.max_io_pressure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
eds_memory_pressure =3D self.rq.max_memory_pressure and (float(curr_memory_=
pressure) - float(self.prev_memory_pressure)) &gt; self.rq.max_memory_press=
ure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (exceeds_cpu_pressur=
e or exceeds_io_pressure or exceeds_memory_pressure)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
<br>
-- <br>
2.42.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15494): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15494" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15494</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102506693/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/102506693/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"=
_blank">martin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000c6d1590609ccd42e--

