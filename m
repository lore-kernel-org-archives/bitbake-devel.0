Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.3321.1606251634665215668
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Nov 2020 13:00:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=IzaLOKaz;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id y4so254921edy.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2020 13:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9rh+76dTUMWdFHQPwjkY6f2fc9Fx7Mw8u+/e8aZdUE=;
        b=IzaLOKaz5xd1dOWVZgcEKDciylhPhIVn/Shz3IjOp7MsStDA1Z+VIHrphKLHquwVWq
         RMXYtlZjPT+trSbJuarQtvPnS72iWtgHci+IlZV9AD2qzt9/Sb/BdOzzHXlZi/Nmxh6A
         KBiR85FAAqG8Gq0aFN8pHg3cAx87nRjTkVX3s7GIWOC+a52qim75cijMcM3hmpDE+Xaq
         BNvl+4GPAGXckwKfjHl4BpSez+qHSFXIsl4IThlAxmt55h1J8llvYWzFzyun5JqXg9nS
         mUFt5Cg5fcFjTiI77zXi07v4odo1/YicTvkXL94BPdUu4BrK8pIDQPoxwlS+KcdlMuCC
         sdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9rh+76dTUMWdFHQPwjkY6f2fc9Fx7Mw8u+/e8aZdUE=;
        b=A/UAZNLXKWeJQ6hczgSym1JL3UfiwUWtQAADia+wplhEicoUixeVDNH46mfsBMj4ky
         fHgo4tEgS+T3nGWENNyaj5UZDnnKM6sOVlDgZ6ydaaex2368zAzxoEYz/KFkrWtkzMMC
         ZhwqPNj7EE2V/4C9V8tGcspBtWTz9EzLf2uM3pMx70t+IP5RCPKxoylUxKyTbTtMBiH+
         PB+JxI+9X/x16NZONUfw63ws/B++rX7OMuc4yl0Uv8gpJbjyOUZTLJSnojgvwWNTDJ+T
         18VyiElFJ4YXwUw6vaNtPPo+HVtJDPjxAJA9Yvn0tsfc2DNOtwQCfsIjsqKXW+nMRe2E
         entg==
X-Gm-Message-State: AOAM5305+C6lBi+S4QEV74O6XcqP9BNmRSe2IHoSfOHuHJkngQAfD3n5
	XFff9ZZCzdV6oUm3PVjuBGPtkjWb9CRkF60seHo=
X-Google-Smtp-Source: ABdhPJybDg2Nhv2Sb/BXDBaXgY4YDKw+KresCSy2G0i0rnZqZ8ij8e/7Sdi0gP0WwSO2Lg8mX+FedHM9oUr9bvCrPCA=
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr359784edt.219.1606251628478;
 Tue, 24 Nov 2020 13:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20201124203617.35637-1-javier.tia@hpe.com>
In-Reply-To: <20201124203617.35637-1-javier.tia@hpe.com>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Tue, 24 Nov 2020 14:00:17 -0700
Message-ID: <CABcZANmna7TCPY2yZKkzgUqTw6ofyKg_cOTJZ1uTBTik+1M0zg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Add variable-key quality checker
To: Javier Tia <javier.tia@hpe.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000bc466805b4e0991e"

--000000000000bc466805b4e0991e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ERROR_QA and WARN_QA are OE variables, not bitbake ones, and they are space
separated lists of words, so would need to be split to be used.

On Tue, Nov 24, 2020 at 1:36 PM Javier Tia <javier.tia@hpe.com> wrote:

> Allow to select between a warning or error message when variable key
> replace the original key.
>
> Signed-off-by: Javier Ti=C3=A1 <javier.tia@hpe.com>
> ---
>  lib/bb/data.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 0d75d0c1..ca14d64a 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -100,7 +100,16 @@ def expandKeys(alterdata, readdata =3D None):
>          if newval is not None:
>              val =3D alterdata.getVar(key, False)
>              if val is not None:
> -                bb.warn("Variable key %s (%s) replaces original key %s
> (%s)." % (key, val, ekey, newval))
> +                msg =3D "Variable key %s (%s) replaces original key %s
> (%s)." % (key, val, ekey, newval)
> +                error_qa =3D alterdata.getVar('ERROR_QA', False)
> +                warn_qa =3D alterdata.getVar('WARN_QA', False)
> +                if error_qa and 'variable-key' in error_qa:
> +                    bb.error(msg)
> +                elif warn_qa and 'variable-key' in warn_qa:
> +                    bb.warn(msg)
> +                else:
> +                    bb.warn(msg)
> +
>          alterdata.renameVar(key, ekey)
>
>  def inheritFromOS(d, savedenv, permitted):
> --
> 2.29.2
>
>
>=20
>
>

--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000bc466805b4e0991e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ERROR_QA and WARN_QA are OE variables, not bitbake ones, a=
nd they are space separated lists of words, so would need to be split to be=
 used.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Tue, Nov 24, 2020 at 1:36 PM Javier Tia &lt;<a href=3D"mailto:javi=
er.tia@hpe.com">javier.tia@hpe.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Allow to select between a warning or erro=
r message when variable key<br>
replace the original key.<br>
<br>
Signed-off-by: Javier Ti=C3=A1 &lt;<a href=3D"mailto:javier.tia@hpe.com" t=
arget=3D"_blank">javier.tia@hpe.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/data.py | 11 ++++++++++-<br>
=C2=A01 file changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/data.py b/lib/bb/data.py<br>
index 0d75d0c1..ca14d64a 100644<br>
--- a/lib/bb/data.py<br>
+++ b/lib/bb/data.py<br>
@@ -100,7 +100,16 @@ def expandKeys(alterdata, readdata =3D None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if newval is not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D alterdata.getVar(k=
ey, False)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if val is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Var=
iable key %s (%s) replaces original key %s (%s).&quot; % (key, val, ekey, n=
ewval))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D &quot;Var=
iable key %s (%s) replaces original key %s (%s).&quot; % (key, val, ekey, n=
ewval)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_qa =3D alte=
rdata.getVar(&#39;ERROR_QA&#39;, False)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_qa =3D alter=
data.getVar(&#39;WARN_QA&#39;, False)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if error_qa and &=
#39;variable-key&#39; in error_qa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.=
error(msg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif warn_qa and =
&#39;variable-key&#39; in warn_qa:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.=
warn(msg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.=
warn(msg)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0alterdata.renameVar(key, ekey)<br>
<br>
=C2=A0def inheritFromOS(d, savedenv, permitted):<br>
-- <br>
2.29.2<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></=
div>

--000000000000bc466805b4e0991e--
