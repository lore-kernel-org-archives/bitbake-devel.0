Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.1702.1615494648007063796
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 12:30:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=T8Ym9+FH;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id y6so4762583eds.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Mar 2021 12:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHcJ1RDmtvaHN2X+8FCrOu9+Mhhk5g9ZfiLO+NYW/h8=;
        b=T8Ym9+FHVMj76+sf+99qlDCuyYrEg3bT6ZmZFe12wdKwxQ+m6PdPZBzAhIUhwd/M8M
         9ycZDOjHhr3lUHDxkpaG4utD5mzgOfVRWfriJiJxYkt+wCNtOAVTrpckXWBROQmJiA6z
         zwYA6uLkC9L1N4bgTkIOgAPIMAvow0exVtdgivpsSYxyvE27hTTovCe/vrHztO9W1oN5
         8AjhdUCvBEDBHB8WfTuX26USwDk3GilzfyJgLmK5rusKJSeheHz4OOybn6yze8A5y2Sh
         MS8b/jK7LhZVPv+sDDP9DWMQVhvTvuzaWUU18W0C+Z2YfoWQZcO0cPVvLcJTn47IbTxI
         AC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHcJ1RDmtvaHN2X+8FCrOu9+Mhhk5g9ZfiLO+NYW/h8=;
        b=PSi7Cy7/oXu3Dz8d2ppvW8u57mQkH7LZrHAP9hPIkSzaH1PmfQAZ6E7x2N+KXad/nl
         1AUkDrQ8ds6rc7MTQw2ai9AyOm0PXXkAuAGASkdtzfxnWmyVrHv/FyVh6PMIspGmdiL+
         Loe3P9y8rJjOKMJdaiQXokrdV0eKUIAr5BXkshMGE/f83PcSk64M7RdVjSCasTU+mSDQ
         JNpOjf5LQVk5exQIL/EWZESff5kT9lwLaYmkFJIij7C/WK2Mb4Hc915KTEpg46y0FjdO
         eQuBX7DsrK/+ivJDI8laC+4Vs6WF4IuHb4iy0mZaQEKqxx+p5UxKv9Pfn4xkqsSIjl4t
         0BrQ==
X-Gm-Message-State: AOAM530kMzaQgyYQqF7h+N16KNDIqIQF2HxlySMgtayhVgxN/vAuPl8E
	tnEhvBs5N4do/AaT/gNBABlfVluSPHuWUELPNn4=
X-Google-Smtp-Source: ABdhPJx9WYnjJtaU6UxwQzL7ohEll0+/3uJKeDA1eRMcLse+/swMS+OSTxXL4zGP57SAmAGgeexWyBAtejKcEdseGUw=
X-Received: by 2002:a05:6402:1115:: with SMTP id u21mr10331484edv.383.1615494646341;
 Thu, 11 Mar 2021 12:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Thu, 11 Mar 2021 13:30:35 -0700
Message-ID: <CABcZANm4HaVHzrzhfWbsvRB=RyaR-+C16-EJPJ=_Q_Fjgf2vmw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] event: Fix multiconfig event handler change performance regressions
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000088244f05bd48a845"

--00000000000088244f05bd48a845
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 11, 2021 at 6:46 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> There were two issues in this code, firstly the code could stack duplicates
> in the variable, secondly, calling "if data" caused the datastore to
> compute
> len(data) which is comparitively expensive. Checking "if data is not None"
> is much much faster/cheaper.
>
> The issue was clear from "bitbake -p -P" output where the time in
> register()
> showed large amounts of time in the __len__ function of the datastore.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/event.py | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 3e5718395b..22171a9ca5 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -118,7 +118,7 @@ def fire_class_handlers(event, d):
>              if _eventfilter:
>                  if not _eventfilter(name, handler, event, d):
>                      continue
> -            if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
> +            if d and not name in (d.getVar("__BBHANDLERS_MC") or set()):
>

Shouldn't this one also be doing a 'is not None' check?
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--00000000000088244f05bd48a845
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 11, 2021 at 6:46 AM Richa=
rd Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard=
.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">There were two issues in this code, firstly the =
code could stack duplicates<br>
in the variable, secondly, calling &quot;if data&quot; caused the datastore=
 to compute<br>
len(data) which is comparitively expensive. Checking &quot;if data is not N=
one&quot;<br>
is much much faster/cheaper.<br>
<br>
The issue was clear from &quot;bitbake -p -P&quot; output where the time in=
 register()<br>
showed large amounts of time in the __len__ function of the datastore.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/event.py | 22 +++++++++++-----------<br>
=C2=A01 file changed, 11 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/lib/bb/event.py b/lib/bb/event.py<br>
index 3e5718395b..22171a9ca5 100644<br>
--- a/lib/bb/event.py<br>
+++ b/lib/bb/event.py<br>
@@ -118,7 +118,7 @@ def fire_class_handlers(event, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if _eventfilter:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not _event=
filter(name, handler, event, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d and not name in (d.getVar(&=
quot;__BBHANDLERS_MC&quot;) or []):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d and not name in (d.getVar(&=
quot;__BBHANDLERS_MC&quot;) or set()):<br></blockquote><div><br></div><div>=
Shouldn&#39;t this one also be doing a &#39;is not None&#39; check?=C2=A0</=
div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>F=
ounder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Men=
tor Graphics</div></div></div></div></div>

--00000000000088244f05bd48a845--
