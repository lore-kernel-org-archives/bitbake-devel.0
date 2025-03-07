Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DA7C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 17:17:41 +0000 (UTC)
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
 by mx.groups.io with SMTP id smtpd.web11.16665.1741367854025013287
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 09:17:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lfk2vqhC;
 spf=pass (domain: gmail.com, ip: 209.85.222.67, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-86714f41f5bso885915241.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741367853; x=1741972653; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xNCtwvzWC4g0Q7w3jhR0KwnedCeGNIvndw9bZ97I1Y=;
        b=lfk2vqhCnw3WsOZwS8s0S0CEEM8d9s0kdMGTvUzFrNVYpcdJfPnWvovYMJkN3/EHkc
         0x6MVfMnmVq96XdpIRKC8vdqtPAIm3sg7/cQGaUU2m7JpK4ook39umD5zFv37a7QmW92
         JhTm8J6G8n+9bxDxkdzOyCfFy9EQmz51OPYOJIDno+PXpzmBiCHDhPcfv3WRh4rd0PNk
         6SHFSLeClqqW4g6wz0Fk1y3XQZAUyQX/q4YUL5RyULxL3m1+ubZWWJTdPteX1IuHUd16
         KRKNoAYqfSMOvi6LdgWGO16vvjfzLYSianOjgKjYJkpe5dMe+EYHyVBAW8cKFXFWTyr1
         dXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367853; x=1741972653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xNCtwvzWC4g0Q7w3jhR0KwnedCeGNIvndw9bZ97I1Y=;
        b=Q8DgXoLgS5WgKYGUSNkvluEwVh9YXNSy4cu8nhwbyeQC3zjoAnkOKLWVKmSy2slv2E
         CPQzACu6+uHw9xIEwo2ft+tm77qsAwouT2041R0YMxXtFUmTYdDLCun4NDBXothCb38v
         x0CRmAARTEdXdxsVBVdBLex6httZZsNMaSPvA0SRG2sZOFmVZ2QR0YvIfbCVYmH+FNcR
         UYLpsE0SZ9x4FzUEkOw1l1YuiPjpZedSa87BUny8sx+uHZaMFcf9j66KiIYCc7O+2pFq
         CY1WzD7YtjUGpP+fR7zVPXwPptNS9RuFBmCTKyYoeG+zyASdi1Fa1yibzkWikFzFJocF
         ALVw==
X-Gm-Message-State: AOJu0YzoTXjzhkOV697WK4hbvgbxheedE791XWN8ft5XLYq+xkKmAPTl
	iKp+w3bGI02tKRv5NdonZtEkVCbgXhWNtR7JgKsXRQ1Mh+DSz8omCt0SXZjJ2eztjUnevlZzSyu
	WPkjwxft+3l3ekK5sgkMysiMH9AE=
X-Gm-Gg: ASbGncuRsNWzvS3tlXoYoYzi5mE+4nc2PyeaUqPlc/qvo1tcsJw/raSGyINrbgSTQV7
	r+8+4urHXLJqzLxaUGYdn2pn9YGA6lQ9Ze4mLDdMgcnMosyfhLSf3z08hDab74Gjp+07wMaA2nC
	TnnVtofI6okpNypd7tLO+czZirOA==
X-Google-Smtp-Source: AGHT+IF8tH66jVGsPBL7htRACBKocZqA496U/XCgPmCnOO822d8RfAi/2+x/3c/FYnz4q6ec0WkX7Q4Pktp9Oa/Kskw=
X-Received: by 2002:a05:6102:2ad1:b0:4c3:c9:c667 with SMTP id
 ada2fe7eead31-4c30a718ebfmr2695529137.24.1741367852867; Fri, 07 Mar 2025
 09:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20250228130137.400-1-eric.meyers@arthrex.com> <20250228130137.400-3-eric.meyers@arthrex.com>
 <CAB=6tBRU3+bKeNsbNpiHChBpeXbjR7Or3rOVT66-5K81OgZK2Q@mail.gmail.com>
In-Reply-To: <CAB=6tBRU3+bKeNsbNpiHChBpeXbjR7Or3rOVT66-5K81OgZK2Q@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Fri, 7 Mar 2025 11:17:28 -0600
X-Gm-Features: AQ5f1JrmKzbc3WusR6g43kK-Nc0YPAqJSSka_60RndFW98L2tWB4D-NDcMtS93s
Message-ID: <CA+cKJ+GOjzvBoHrFr_Y634cOUJTrD1VC8864CfDKkRJp_ey2gQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000004b28b9062fc3cc02"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 17:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17412

--0000000000004b28b9062fc3cc02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:09=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.co=
m> wrote:

> On Fri, Feb 28, 2025 at 5:01=E2=80=AFAM Eric Meyers <eric.meyers15310@gma=
il.com>
> wrote:
>
>> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
>> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
>> Cc: Chuck Wolber <chuckwolber@gmail.com>
>> ---
>>  .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git
>> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index 858de6347..00300d0d8 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -692,6 +692,12 @@ overview of their function and contents.
>>        Within an executing task, this variable holds the hash of the tas=
k
>> as
>>        returned by the currently enabled signature generator.
>>
>> +   :term:`BB_USE_HOME_NPMRC`
>> +      Controls whether or not BitBake uses the user's .npmrc file withi=
n
>> their
>> +      home directory within the npm fetcher. This can be used for
>> authentication
>> +      of private NPM registries, among other uses. This is turned off b=
y
>> default
>> +      and requires the user to explicitly set it to "1" to enable.
>> +
>>     :term:`BB_VERBOSE_LOGS`
>>        Controls how verbose BitBake is during builds. If set, shell
>> scripts
>>        echo commands and shell script output appears on standard out
>>
>
>
> Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>
>
> ..Ch:W..
>

Apologies if this isn't the correct process (this is my first time
submitting a patch), but what's needed to merge this patch into
master-next, then master?

Thanks,
-Eric

--0000000000004b28b9062fc3cc02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 202=
5 at 12:09=E2=80=AFPM Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.=
com">chuckwolber@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"f=
ont-family:monospace">On Fri, Feb 28, 2025 at 5:01=E2=80=AFAM Eric Meyers &=
lt;<a href=3D"mailto:eric.meyers15310@gmail.com" target=3D"_blank">eric.mey=
ers15310@gmail.com</a>&gt; wrote:</div></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Eric Meyers &=
lt;<a href=3D"mailto:eric.meyers@arthrex.com" target=3D"_blank">eric.meyers=
@arthrex.com</a>&gt;<br>
Cc: Geoff Parker &lt;<a href=3D"mailto:geoffrey.parker@arthrex.com" target=
=3D"_blank">geoffrey.parker@arthrex.com</a>&gt;<br>
Cc: Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.com" target=3D"_bl=
ank">chuckwolber@gmail.com</a>&gt;<br>
---<br>
=C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
index 858de6347..00300d0d8 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
@@ -692,6 +692,12 @@ overview of their function and contents.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Within an executing task, this variable holds th=
e hash of the task as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0returned by the currently enabled signature gene=
rator.<br>
<br>
+=C2=A0 =C2=A0:term:`BB_USE_HOME_NPMRC`<br>
+=C2=A0 =C2=A0 =C2=A0 Controls whether or not BitBake uses the user&#39;s .=
npmrc file within their<br>
+=C2=A0 =C2=A0 =C2=A0 home directory within the npm fetcher. This can be us=
ed for authentication<br>
+=C2=A0 =C2=A0 =C2=A0 of private NPM registries, among other uses. This is =
turned off by default<br>
+=C2=A0 =C2=A0 =C2=A0 and requires the user to explicitly set it to &quot;1=
&quot; to enable.<br>
+<br>
=C2=A0 =C2=A0 :term:`BB_VERBOSE_LOGS`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Controls how verbose BitBake is during builds. I=
f set, shell scripts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0echo commands and shell script output appears on=
 standard out<br>
</blockquote></div><div><br clear=3D"all"></div><br><div><span class=3D"gma=
il_default" style=3D"font-family:monospace">Signed-off-by: </span><span cla=
ss=3D"gmail_default" style=3D"font-family:monospace">Chuck Wolber &lt;<a hr=
ef=3D"mailto:chuckwolber@gmail.com" target=3D"_blank">chuckwolber@gmail.com=
</a>&gt;<br></span></div><div><span class=3D"gmail_default" style=3D"font-f=
amily:monospace"><br></span></div><div><span class=3D"gmail_default" style=
=3D"font-family:monospace">..Ch:W..</span></div></div></blockquote><div><br=
></div><div>Apologies if this isn&#39;t the correct process (this is my fir=
st time submitting a patch), but what&#39;s needed to merge this patch into=
 master-next, then master?</div><div><br></div><div>Thanks,</div><div>-Eric=
</div><div><br></div><div><br></div></div></div>

--0000000000004b28b9062fc3cc02--

