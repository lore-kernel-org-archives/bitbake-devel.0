Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3200AC433F5
	for <webhook@archiver.kernel.org>; Sun, 22 May 2022 06:59:06 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.14001.1653202745022758588
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 May 2022 23:59:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=TOPmXEj4;
 spf=pass (domain: gmail.com, ip: 209.85.221.52,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id r23so16734662wrr.2
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 May 2022 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr+SIQjqJ9ycTPq3MWGSAeiuBZAld1Q8E3Ujrg+x2dw=;
        b=TOPmXEj4bcHTCYOR05Ch8ACo9eZ6zLIfe9HbylZ0cyvqDRhO8FLtNHf2Dq73LfNvWG
         urFkd8HHY6UPN8wGdngEdXWKZQrOACwADc6dx9NYVKdytrl54pstNq1yMb3jeWbEcjde
         jL8f+PjQWX1YPnebVxiwoMutB7Za0isaio5sNOkCS5sxtfzGTpfnoLZ96H0H937G9ru3
         XhDDiZ/fzcYGBNPRnu90uRV5bs7oS4CeG6PjnP5K8NCpKp9Q4VEAYD+a5jxWu1vubifD
         YHrlPoyU7hn+ncLOOS5i4eUz1a7JHVR2Jqj6Sv9cd+Z6z5a3/25aFDS01g8HomonGGIZ
         5Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr+SIQjqJ9ycTPq3MWGSAeiuBZAld1Q8E3Ujrg+x2dw=;
        b=tWr4vou/psZsjY1M1lh9R8732vM/yWzR6RN5vLcX610El1JH7Q799zMDfLJjBLkDo7
         xzEmyi/qpaDE2nx497SCr5hpZSBo8cRuCJzNACs09Tnz/pqVCsnJJaAAjQTvqmSw0dZV
         YSLbwQvOw8vyuiord8OHI3zluxS5HV8Qh7T9yvp+7+JSlYDrYPCTOfPciRZQMAzB+lhA
         I4sUJkbB4twh3BuUdvoSZaQGS2wdRzIwFk1VdkmvXztH/T3JwTNBet72kDvv81tqwVm/
         7fMIXT8p8Y8L6MeSaQ2Ae8eX0EkmDfxi+TfKPkbKsdcbaZz01gR9HsYKFo53BZxwofIy
         7eiA==
X-Gm-Message-State: AOAM530CDQ5VDMr4hfo36MFfoyIFg48HuuKh/jb4glv8v8IAQmBsdSMw
	hmDfUkn27snMbMuh5JuqV5Ivco9wopmx2Wdvxmc=
X-Google-Smtp-Source: 
 ABdhPJzT1FG6dP4JjzGUjDmMYaIdew81pVYjA0WQZVwfmq9r5hcJGbvOMs4aShc2gNmJtNbMx9tfxYKK7PkKvFW2U4Q=
X-Received: by 2002:adf:f106:0:b0:20d:20a:96e8 with SMTP id
 r6-20020adff106000000b0020d020a96e8mr14841399wro.495.1653202743464; Sat, 21
 May 2022 23:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220519183403.468179-1-viraniac@gmail.com>
In-Reply-To: <20220519183403.468179-1-viraniac@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 22 May 2022 08:58:43 +0200
Message-ID: 
 <CA+chaQe66rd10bnG3mSo_qNuH=0YqFq-+LU5sJQqpmR221T8wg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/osc: Add support to query latest
 revision
To: Gunjan Gupta <viraniac@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000044161105df9442f6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 May 2022 06:59:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13705

--00000000000044161105df9442f6
Content-Type: text/plain; charset="UTF-8"

On Thu, May 19, 2022 at 8:36 PM Gunjan Gupta <viraniac@gmail.com> wrote:

> Add support to query latest revision. This makes it possble to use
> osc fetcher without specifying the rev parameter.
>
> Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
> ---
>  lib/bb/fetch2/osc.py | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
> index eb0f82c8..dd02f037 100644
> --- a/lib/bb/fetch2/osc.py
> +++ b/lib/bb/fetch2/osc.py
> ....



+    def _latest_revision(self, ud, d, name):
> +        """
> +        Fetch latest revision for the given package
> +        """
> +        api_source_cmd = self._buildosccommand(ud, d, "api_source")
> +
> +        output = runfetchcmd(api_source_cmd, d)
> +        match = re.match('<directory ?.* rev="(\d+)".*>', output)
> +        if match is None:
> +            raise FetchError("Unable to parse osc response", ud.url)
> +        return match.groups()[0]
>
...

This causes new warning with new python:
bitbake/lib/bb/fetch2/osc.py:93: DeprecationWarning: invalid escape
sequence '\d'
  match = re.match('<directory ?.* rev="(\d+)".*>', output)

Will send a fix.

--00000000000044161105df9442f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, May 19, 2022 at 8:36 PM Gunjan Gu=
pta &lt;<a href=3D"mailto:viraniac@gmail.com">viraniac@gmail.com</a>&gt; wr=
ote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Add support to query latest revision. This makes it possble=
 to use<br>
osc fetcher without specifying the rev parameter.<br>
<br>
Signed-off-by: Gunjan Gupta &lt;<a href=3D"mailto:viraniac@gmail.com" targe=
t=3D"_blank">viraniac@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/osc.py | 34 +++++++++++++++++++++++++++++-----<br>
=C2=A01 file changed, 29 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py<br>
index eb0f82c8..dd02f037 100644<br>
--- a/lib/bb/fetch2/osc.py<br>
+++ b/lib/bb/fetch2/osc.py<br>....</blockquote><div><br></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 def _lat=
est_revision(self, ud, d, name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Fetch latest revision for the given package<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 api_source_cmd =3D self._buildosccommand(ud, d=
, &quot;api_source&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D runfetchcmd(api_source_cmd, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D re.match(&#39;&lt;directory ?.* rev=
=3D&quot;(\d+)&quot;.*&gt;&#39;, output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if match is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Unable to=
 parse osc response&quot;, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return match.groups()[0]<br></blockquote><div>=
...</div><div>=C2=A0</div><div>This causes new warning with new python:</di=
v><div>bitbake/lib/bb/fetch2/osc.py:93: DeprecationWarning: invalid escape =
sequence &#39;\d&#39;<br>=C2=A0 match =3D re.match(&#39;&lt;directory ?.* r=
ev=3D&quot;(\d+)&quot;.*&gt;&#39;, output)<br></div><div><br></div><div>Wil=
l send a fix.</div><div><br></div></div></div>

--00000000000044161105df9442f6--

