Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBCC46CD2
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 14:10:00 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.17602.1704809396858712575
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 06:09:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=FsysEJsF;
 spf=pass (domain: snapchat.com, ip: 209.85.218.52, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28fb463a28so297817366b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 06:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1704809395; x=1705414195; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2t+VxBRJC7KiaZTBFMqafqjLx8n1CD7TzXKQgZYV24=;
        b=FsysEJsFh/rszaXzZ3MSESvzIIkHTwwGLMRYtPzVDCjm1Rbz6BICsaN9TkFX0xRoO5
         i0rhDwtl0MugK6BYlSwGwJTDbUDR5VTD8SkBOBBQRYlxXh1OoI4lsuJjcRg4gDUQ/WQQ
         hsYX84adACGoMJU7kQszH/sBj7UTY8T6capIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809395; x=1705414195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2t+VxBRJC7KiaZTBFMqafqjLx8n1CD7TzXKQgZYV24=;
        b=tTsDuw9mS5+sHZV+5ZaUApfvJNivYmEtFGFmoulG/TqN8SvuwTwA7GJU9KeG0/0B1z
         vZoI9FXsAGXL+s72h0s7fVJ5Iied7r1HQozrFawKxumG5ajB055gl4rdaSJdvYdl4pQ3
         FLzmlpF05pBsD9VqpDd3ZuLDwU+m5756B+bNxGfhW56PH4JODjHiayHUD7zLwSHNZ5pH
         YEQi6ykcHTc5+TNrdbZfFkNenilPpET9hkFbtX8Rib7BW7r+wkdnA6lKIOiC25PnqbzH
         yyv9EWRy1trK0mlLOWYa4Dp7z59yU1mlobhI0zAxzxfWSBc1uUjfp2r/42es3IwWoWWK
         qx+A==
X-Gm-Message-State: AOJu0YyHkrW+k5fQ0RcvsczXyCUvz1YUeqASGtoLcXjqlvWfnNJ45M57
	lmtwHr0MKi8ZBN5KDpWC/SnlouFPKb+yEJ3nejR+suxu8Kp6REiNOvmruPSgkLklzg==
X-Google-Smtp-Source: AGHT+IHgWtfopiL6FtWwEZPf+WhQ3tAYs0tG1j13t1Xc5LoEm/PlpHgzkCh8MtyhLJCtq9dN1ZUl8bVmSugVmmUtil0=
X-Received: by 2002:a17:906:f287:b0:a23:35d2:cf97 with SMTP id
 gu7-20020a170906f28700b00a2335d2cf97mr542499ejb.64.1704809395173; Tue, 09 Jan
 2024 06:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 9 Jan 2024 15:09:44 +0100
Message-ID: <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Randy MacLeod <Randy.MacLeod@windriver.com>
Content-Type: multipart/alternative; boundary="000000000000692287060e83de31"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 14:10:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15762

--000000000000692287060e83de31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
how much logging is this generating for your local builds? I'm
using BB_PRESSURE_MAX_CPU=3D"500", and this patch generates hundreds of lin=
es
of logs during a typical build (on kirkstone 4.0.15). Is that the expected
behavior? It makes it hard to read other logs.

E.g. this incremental build with 300 tasks printed 280 lines of Pressure
status change:

...
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
495.3/500.0, IO: 1723.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
985.3/500.0, IO: 2201.8/None, Mem: 176.8/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
420.8/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
4049.8/500.0, IO: 14719.7/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake
threads
NOTE: Tasks Summary: Attempted 928 tasks of which 635 didn't need to be
rerun and all succeeded.
...


On Thu, Jul 13, 2023 at 12:53=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> It is currently hard to tell when bitbake is throttling task execution
> due to system pressure changes. Add notes to the console output to make
> this clearer, only generating output when the values change.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 241a746ebb..020ad210d8 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -212,6 +212,10 @@ class RunQueueScheduler(object):
>                      exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure a=
nd
> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) >
> self.rq.max_cpu_pressure
>                      exceeds_io_pressure =3D  self.rq.max_io_pressure and
> (float(curr_io_pressure) - float(self.prev_io_pressure)) >
> self.rq.max_io_pressure
>                      exceeds_memory_pressure =3D self.rq.max_memory_press=
ure
> and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) >
> self.rq.max_memory_pressure
> +            pressure_state =3D (exceeds_cpu_pressure, exceeds_io_pressur=
e,
> exceeds_memory_pressure)
> +            if hasattr(self, "pressure_state") and pressure_state !=3D
> self.pressure_state:
> +                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem=
:
> %s" % pressure_state)
> +            self.pressure_state =3D pressure_state
>              return (exceeds_cpu_pressure or exceeds_io_pressure or
> exceeds_memory_pressure)
>          return False
>
> --
> 2.39.2
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14881):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_14881&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D2-=
D0LIZ9jb_OQ0moDf52X1uxL_mzlLgg8a-EtbfpZ_puk14Q5m5U-o6j9Z5SyEhW&s=3DHjxf_Hw5=
nNdsxYpgqQ_Wqrx3puDIhkG90ziaM598yaA&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_100117828_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D2-D0LIZ9jb_OQ=
0moDf52X1uxL_mzlLgg8a-EtbfpZ_puk14Q5m5U-o6j9Z5SyEhW&s=3D3oXO64d9MSfEwmmOaRS=
rprXDBuuz3pyuHrJ-kXt7UxA&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_leave_12014517_7048771_89430669_xyzzy&d=3DDwIFaQ&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3D2-D0LIZ9jb_OQ0moDf52X1uxL_mzlLgg8a-EtbfpZ_puk14Q5m5=
U-o6j9Z5SyEhW&s=3Djyn0SAZ3VS4StYDnGqsmCY4F29xjKG26cMKCObc1fxw&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000692287060e83de31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br>how much logging is this generating for you=
r=C2=A0local builds? I&#39;m using=C2=A0BB_PRESSURE_MAX_CPU=3D&quot;500&quo=
t;, and this patch generates hundreds of lines of logs during a typical bui=
ld (on kirkstone 4.0.15). Is that the expected behavior? It makes it hard t=
o read other logs.<br><br>E.g. this incremental build with 300 tasks printe=
d 280 lines of Pressure status change:<br><br>...<br>NOTE: Pressure status =
changed to CPU: False, IO: None, Mem: None (CPU: 495.3/500.0, IO: 1723.0/No=
ne, Mem: 0.0/None) - using 1/48 bitbake threads<br>NOTE: Pressure status ch=
anged to CPU: True, IO: None, Mem: None (CPU: 985.3/500.0, IO: 2201.8/None,=
 Mem: 176.8/None) - using 1/48 bitbake threads<br>NOTE: Pressure status cha=
nged to CPU: False, IO: None, Mem: None (CPU: 420.8/500.0, IO: 0.0/None, Me=
m: 0.0/None) - using 1/48 bitbake threads<br>NOTE: Pressure status changed =
to CPU: True, IO: None, Mem: None (CPU: 4049.8/500.0, IO: 14719.7/None, Mem=
: 0.0/None) - using 1/48 bitbake threads<br>NOTE: Pressure status changed t=
o CPU: False, IO: None, Mem: None (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/N=
one) - using 1/48 bitbake threads<br>NOTE: Pressure status changed to CPU: =
True, IO: None, Mem: None (CPU: 21922.9/500.0, IO: 10137.8/None, Mem: 194.8=
/None) - using 1/48 bitbake threads<br>NOTE: Tasks Summary: Attempted 928 t=
asks of which 635 didn&#39;t need to be rerun and all succeeded.<br>...<br>=
<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Jul 13, 2023 at 12:53=E2=80=AFPM Richard Purdie &lt;<a href=3D"=
mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">It is currently hard to tell when bitbake is throttling task execution<br=
>
due to system pressure changes. Add notes to the console output to make<br>
this clearer, only generating output when the values change.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/runqueue.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 241a746ebb..020ad210d8 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -212,6 +212,10 @@ class RunQueueScheduler(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exceeds_cpu_pressure =3D=C2=A0 self.rq.max_cpu_pressure and (float(curr_=
cpu_pressure) - float(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressur=
e<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exceeds_io_pressure =3D=C2=A0 self.rq.max_io_pressure and (float(curr_io=
_pressure) - float(self.prev_io_pressure)) &gt; self.rq.max_io_pressure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exceeds_memory_pressure =3D self.rq.max_memory_pressure and (float(curr_=
memory_pressure) - float(self.prev_memory_pressure)) &gt; self.rq.max_memor=
y_pressure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure_state =3D (exceeds_cpu_=
pressure, exceeds_io_pressure, exceeds_memory_pressure)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hasattr(self, &quot;pressure_=
state&quot;) and pressure_state !=3D self.pressure_state:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.note(&quot;Pres=
sure status changed to CPU: %s, IO: %s, Mem: %s&quot; % pressure_state)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pressure_state =3D pressure=
_state<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (exceeds_cpu_pressur=
e or exceeds_io_pressure or exceeds_memory_pressure)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
<br>
-- <br>
2.39.2<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14881): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_14881&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D2-D0LIZ9jb_OQ0moDf52X1ux=
L_mzlLgg8a-EtbfpZ_puk14Q5m5U-o6j9Z5SyEhW&amp;s=3DHjxf_Hw5nNdsxYpgqQ_Wqrx3pu=
DIhkG90ziaM598yaA&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_14881&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3D2-D0LIZ9jb_OQ0moDf52X1uxL_mzlLgg8a-EtbfpZ_puk14Q5m5U-o6j9Z5SyEhW&amp;s=
=3DHjxf_Hw5nNdsxYpgqQ_Wqrx3puDIhkG90ziaM598yaA&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_100117828_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D2-D0LIZ9jb_OQ0moDf52X1uxL_mzlLgg8a-EtbfpZ_puk1=
4Q5m5U-o6j9Z5SyEhW&amp;s=3D3oXO64d9MSfEwmmOaRSrprXDBuuz3pyuHrJ-kXt7UxA&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_100117828_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D2-D0LIZ9jb_OQ0moDf52X1uxL_mzlLg=
g8a-EtbfpZ_puk14Q5m5U-o6j9Z5SyEhW&amp;s=3D3oXO64d9MSfEwmmOaRSrprXDBuuz3pyuH=
rJ-kXt7UxA&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_leave_12014517_7048771_8943066=
9_xyzzy&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&=
amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D2-D0LIZ9jb_OQ0m=
oDf52X1uxL_mzlLgg8a-EtbfpZ_puk14Q5m5U-o6j9Z5SyEhW&amp;s=3Djyn0SAZ3VS4StYDnG=
qsmCY4F29xjKG26cMKCObc1fxw&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">h=
ttps://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.or=
g_g_bitbake-2Ddevel_leave_12014517_7048771_89430669_xyzzy&amp;d=3DDwIFaQ&am=
p;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_=
Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D2-D0LIZ9jb_OQ0moDf52X1uxL_mzlLgg8a-Etbfp=
Z_puk14Q5m5U-o6j9Z5SyEhW&amp;s=3Djyn0SAZ3VS4StYDnGqsmCY4F29xjKG26cMKCObc1fx=
w&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D"_bl=
ank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000692287060e83de31--

