Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web11.3127.1606906224963088046
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Dec 2020 02:50:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@blade-group.com header.s=google header.b=W4wPj4m3;
 spf=pass (domain: blade-group.com, ip: 209.85.210.50, mailfrom: yann.dirson@blade-group.com)
Received: by mail-ot1-f50.google.com with SMTP id b18so618329ots.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Dec 2020 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blade-group.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8osH+12ZZ046bUDlrPrP6I4HMP/+d/9wNFkFTDDmxU=;
        b=W4wPj4m3zZIeH04t+ySofUbtug9AUco7ehnCZgFIoSzRtj02f2dqyDK5SXDvG7Tdo5
         o/OJAuqOmiIJ514F+B+nUYaZMbyHKLz2W9hoPNmLXDMJYwq/Txo6UTTTGQdMuMb6fpSW
         eEADAAYbdwX+8XPiR4mjyeA+isL8SV+qB+bngtq5KZ+KS2MbuhPBtIe86PZaHtaUPfAv
         kmMHjB/wOfgyzKzp10Dlf0RIwYp+E+amYnozWJMS/d7IDwaHE4gV5YwgYhTmnYyF/xW+
         iXcaEgzzAl/HQm5oY5aTrA1H9MxV+Hr5raSZFCxPULY+NNPyEUWC8TaTKYDVYZLAERnp
         376Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8osH+12ZZ046bUDlrPrP6I4HMP/+d/9wNFkFTDDmxU=;
        b=lG2fVjrr1p/5KzBCAt3epHoeURnA9HyVAkqyjzb0qTMdt1VlDWe7lFOlqb+c8JrW/x
         g9O8+StpDzIkEmh7kpDX6XawrU4EEkltWdrXLysOUFWGYaqHp5vW7jV+nMlkXdpo6IX5
         Gxqr2110sDHnbjZD3JeLTgJZkF79TKMJaQrbDIzYartWojlJG8g6eHt8sQesFbZReLQ7
         SK+wx5fRsbIvEv60tFFmNoqvLgxutGzf+rFgp9XZhVPo0RnKwxwwEqiFYt6winUFV6jy
         +Lnp4NRSBOqRoez6yr7Df9sFSXYhILOMyiLsU6Jmx91oprW37MeoQVJDzG0NJZhCNPS/
         njhg==
X-Gm-Message-State: AOAM531h5emH2T5dLMR4ovRW2yfJ1M12/vsyxXPLVDK/wIbweUw6TtLP
	tAozIDFK1QpkzVAEoEY9UMhCyyCN1EmiCN+oPVn1PY1HxHnXgw==
X-Google-Smtp-Source: ABdhPJyApD1ZrBNOCeVzrFmQSEe4zqwkZS7p8VKCDwhZmL1JlXlIQ1fNBa5QwI25J+qJDJQtMT8UmXToHA/4UA6J56Q=
X-Received: by 2002:a9d:7392:: with SMTP id j18mr1373918otk.288.1606906224069;
 Wed, 02 Dec 2020 02:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20201202095020.1439530-1-yann@blade-group.com>
In-Reply-To: <20201202095020.1439530-1-yann@blade-group.com>
From: "Yann Dirson" <yann.dirson@blade-group.com>
Date: Wed, 2 Dec 2020 11:50:12 +0100
Message-ID: <CA+4=imaDYQ0XT=04cOrymvBeia=qYB2-PuWAfTYCdtRpqGKEhA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fetch2.wget: add support for per-source download flags
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann@blade-group.com>
Content-Type: multipart/alternative; boundary="000000000000ac652905b57902af"

--000000000000ac652905b57902af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

An alternative I thought about would be to:

1. expose all the FETCHCMD_$method vars with their default values through
setVar,
so we can _append them, as today it is only possible to fully override them

2. use something like FETCHCMD_$method_append_srcuri-$name=3D"--foo".
However that
would require to add "srcuri-$name" to overrides temporarily for each file
fetched, and I don't
quite see how that could fit in the current codebase




Le mer. 2 d=C3=A9c. 2020 =C3=A0 10:50, <yann.dirson@blade-group.com> a =C3=
=A9crit :

> From: Yann Dirson <yann@blade-group.com>
>
> Adds support for a new FETCHFLAGS_wget variable, overridable for
> individual SRC_URI entries:
>
>  FETCHFLAGS_wget =3D "--some-flag"
>  FETCHFLAGS_wget[uriname] =3D "--some-better-flag"
>
> Typical use: add authorization headers to a request, for example to
> access a gitlab private package registry:
>
>  FETCHFLAGS_wget[foo] =3D '--header=3D"Authorization: Bearer
> ${FOO_NPM_REGISTRY_TOKEN}"'
> ---
>  lib/bb/fetch2/wget.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
>
> If this approch is OK, I guess this will need a doc update.
>
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e6d9f528..d9ec6e3b 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -99,6 +99,12 @@ class Wget(FetchMethod):
>          if ud.user and ud.pswd:
>              fetchcmd +=3D " --user=3D%s --password=3D%s --auth-no-challe=
nge" %
> (ud.user, ud.pswd)
>
> +        flags =3D d.getVar("FETCHFLAGS_wget") or ""
> +        pername_flags =3D d.getVarFlags("FETCHFLAGS_wget")
> +        if pername_flags and ud.names[0] in pername_flags:
> +            flags =3D pername_flags[ud.names[0]]
> +        fetchcmd +=3D " " + flags
> +
>          uri =3D ud.url.split(";")[0]
>          if os.path.exists(ud.localpath):
>              # file exists, but we didnt complete it.. trying again..
> --
> 2.29.2
>
>

--=20
Yann Dirson <yann@blade-group.com>
Blade / Shadow -- http://shadow.tech

--000000000000ac652905b57902af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>An alternative I thought about would be to:</div><div=
><br></div><div>1. expose all the FETCHCMD_$method vars with their default =
values through setVar,</div><div> so we can _append them, as today it is on=
ly possible to fully override them</div><div><br></div><div>2. use somethin=
g like FETCHCMD_$method_append_srcuri-$name=3D&quot;--foo&quot;.=C2=A0 Howe=
ver that</div><div>would require to add &quot;srcuri-$name&quot; to overrid=
es temporarily for each file fetched, and I don&#39;t</div><div>quite see h=
ow that could fit in the current codebase</div><div><br></div><div><br></di=
v><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le=C2=A0mer. 2 d=C3=A9c. 2020 =C3=A0=C2=A010:50, &lt;<a hr=
ef=3D"mailto:yann.dirson@blade-group.com">yann.dirson@blade-group.com</a>&g=
t; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">From: Yann Dirson &lt;<a href=3D"mailto:yann@blade-group.com" target=
=3D"_blank">yann@blade-group.com</a>&gt;<br>
<br>
Adds support for a new FETCHFLAGS_wget variable, overridable for<br>
individual SRC_URI entries:<br>
<br>
=C2=A0FETCHFLAGS_wget =3D &quot;--some-flag&quot;<br>
=C2=A0FETCHFLAGS_wget[uriname] =3D &quot;--some-better-flag&quot;<br>
<br>
Typical use: add authorization headers to a request, for example to<br>
access a gitlab private package registry:<br>
<br>
=C2=A0FETCHFLAGS_wget[foo] =3D &#39;--header=3D&quot;Authorization: Bearer =
${FOO_NPM_REGISTRY_TOKEN}&quot;&#39;<br>
---<br>
=C2=A0lib/bb/fetch2/wget.py | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
<br>
If this approch is OK, I guess this will need a doc update.<br>
<br>
<br>
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py<br>
index e6d9f528..d9ec6e3b 100644<br>
--- a/lib/bb/fetch2/wget.py<br>
+++ b/lib/bb/fetch2/wget.py<br>
@@ -99,6 +99,12 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.user and ud.pswd:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchcmd +=3D &quot; --user=
=3D%s --password=3D%s --auth-no-challenge&quot; % (ud.user, ud.pswd)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D d.getVar(&quot;FETCHFLAGS_wget&quot;=
) or &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pername_flags =3D d.getVarFlags(&quot;FETCHFLA=
GS_wget&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if pername_flags and ud.names[0] in pername_fl=
ags:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D pername_flags[ud.names=
[0]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D &quot; &quot; + flags<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uri =3D ud.url.split(&quot;;&quot;)[0]<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# file exists, but we didnt=
 complete it.. trying again..<br>
-- <br>
2.29.2<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Yann Dirson &lt;<a href=3D"mailto:yann@blade-group.com" tar=
get=3D"_blank">yann@blade-group.com</a>&gt;<br>Blade / Shadow -- <a href=3D=
"http://shadow.tech" target=3D"_blank">http://shadow.tech</a><br><br></div>

--000000000000ac652905b57902af--
