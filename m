Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web12.16248.1602855948392728157
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Oct 2020 06:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=YR6xquFG;
 spf=pass (domain: gmail.com, ip: 209.85.166.172, mailfrom: ticotimo@gmail.com)
Received: by mail-il1-f172.google.com with SMTP id t12so2713427ilh.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2020 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZFjTsOwXkcd5SH2/w2HS5KyynaX9nIKYLdlny1bnHo=;
        b=YR6xquFGHyS54t04URhZIpdfQ0P/2F9/7eYeZrguXnJkTreHkRabM5OWIQvCP5c3BQ
         /vodAXCcHou3SDDNnaq9W46ZYvHSei7Gji4PP2KmXvLMB/YLquxSEbmEphdI1O0wmgVj
         qBQyArwE14auTlyiptPLgQNqTAww6VkXDi0SEQupT/p8vpphvE0TihSA/7AHktegdm6e
         5Y1F/hWt68ZyShmHZ78qgg0v9+VNASfyQPRQ6J2RIWPmgmZwnt1YQdqmSZDpns5yrikZ
         Kiuqubxt8UGqBKWVoNtTUDwdq4xlBEnmxEgC2AoqLAIzCUsghxt12EExheJMQJRQelaq
         hQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZFjTsOwXkcd5SH2/w2HS5KyynaX9nIKYLdlny1bnHo=;
        b=Ru54q2XehxM4BKTgEURL+4CHg7Dp3chUD9MkC4w5GJpO27YqjKLEfbjDepB7Az8emT
         Rq3E3iL5F9mj2NROv5aWdSCN1Z0uv6eS8ql0B27RIXbycRsLmXeHgnzDv/zgAgUSdY5n
         RM6FpPDHRi/Kzh9mOnSogOI6f/YA6vX7QUd0dvFRffIXduHVAeM/tJ+3eL9eCMW8PUWB
         GL0Z6K4kNLJ+YjKTiUDtRRVBc2lMx/IJZA99DSw4/lxfCzMLDMQTWK0qum/d3GsGwcF5
         FBZ4emGmD/Gk99JBHWeg9CurmNSWBj6EPRvIfvYH702105Rm63hVF9UWWK8vwDcGnYAM
         COeA==
X-Gm-Message-State: AOAM530r6f6hNPjKv8DGjDRZl4QN659ICN/QkoXYJJDU9ZOZ9GMWLL+V
	tYO5gyY0cdx+aSDT1frqv52P/Y6vPPRj0SstxOk=
X-Google-Smtp-Source: ABdhPJxKoxqYX6HsBuJHtlf4W6lTWkLkF19zd+uopYwGlUYGOfDvQvlYl6SSdiijpy+fUsDno2IueDPtiaB6m3grxB4=
X-Received: by 2002:a92:b742:: with SMTP id c2mr2968239ilm.170.1602855947686;
 Fri, 16 Oct 2020 06:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123420.3531477-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20201016123420.3531477-1-richard.purdie@linuxfoundation.org>
From: "Tim Orling" <ticotimo@gmail.com>
Date: Fri, 16 Oct 2020 06:45:36 -0700
Message-ID: <CANx9H-BfyVTUms1z_TMAecKt8SJLSYDvedQn64Z5eLqc8uMGxg@mail.gmail.com>
Subject: Re: [PATCH] ui/toasterui: Fix startup faults from incorrect event sequencing
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000063599305b1c9fb71"

--00000000000063599305b1c9fb71
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 16, 2020 at 5:34 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Toaster has been failing to start correctly when in interactive mode. The
> issue is due to setEventMask being called (which triggers parsing) before
> the environment has been sent from the UI over to the server. This means
> PATH isn't setup, which causes the sanity checks on HOSTTOOLS to fail
> in base.bbclass.
>
> The fix is to ensure the environment is sent to the server before
> other commands are run.
>
> The pain in debugging this highlights other improvements to the logging
> are needed.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
Fixes: [YOCTO #14079]
Reviewed-by: Tim Orling <timothy.t.orling@linux.intel.com>
Tested-by: Tim Orling <timothy.t.orling@linux.intel.com>
>
> ---
>  lib/bb/ui/toasterui.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
> index 9260f5d9d7..ec5bd4f105 100644
> --- a/lib/bb/ui/toasterui.py
> +++ b/lib/bb/ui/toasterui.py
> @@ -131,6 +131,10 @@ def main(server, eventHandler, params):
>
>      helper = uihelper.BBUIHelper()
>
> +    if not params.observe_only:
> +        params.updateToServer(server, os.environ.copy())
> +        params.updateFromServer(server)
> +
>      # TODO don't use log output to determine when bitbake has started
>      #
>      # WARNING: this log handler cannot be removed, as
> localhostbecontroller
> @@ -162,8 +166,6 @@ def main(server, eventHandler, params):
>          logger.warning("buildstats is not enabled. Please enable INHERIT
> += \"buildstats\" to generate build statistics.")
>
>      if not params.observe_only:
> -        params.updateFromServer(server)
> -        params.updateToServer(server, os.environ.copy())
>          cmdline = params.parseActions()
>          if not cmdline:
>              print("Nothing to do.  Use 'bitbake world' to build
> everything, or run 'bitbake --help' for usage information.")
> --
> 2.25.1
>
>

--00000000000063599305b1c9fb71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 16, 2020 at 5:34 AM Richard P=
urdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.pur=
die@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Toaster has been failing to start correctly when in =
interactive mode. The<br>
issue is due to setEventMask being called (which triggers parsing) before<b=
r>
the environment has been sent from the UI over to the server. This means<br=
>
PATH isn&#39;t setup, which causes the sanity checks on HOSTTOOLS to fail<b=
r>
in base.bbclass.<br>
<br>
The fix is to ensure the environment is sent to the server before<br>
other commands are run.<br>
<br>
The pain in debugging this highlights other improvements to the logging<br>
are needed.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r></blockquote><div>Fixes: [YOCTO #14079]</div><div>Reviewed-by: Tim Orling=
 &lt;<a href=3D"mailto:timothy.t.orling@linux.intel.com">timothy.t.orling@l=
inux.intel.com</a>&gt;</div>Tested-by: Tim Orling &lt;<a href=3D"mailto:tim=
othy.t.orling@linux.intel.com">timothy.t.orling@linux.intel.com</a>&gt;<blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/bb/ui/toasterui.py | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py<br>
index 9260f5d9d7..ec5bd4f105 100644<br>
--- a/lib/bb/ui/toasterui.py<br>
+++ b/lib/bb/ui/toasterui.py<br>
@@ -131,6 +131,10 @@ def main(server, eventHandler, params):<br>
<br>
=C2=A0 =C2=A0 =C2=A0helper =3D uihelper.BBUIHelper()<br>
<br>
+=C2=A0 =C2=A0 if not params.observe_only:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.updateToServer(server, os.environ.copy(=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.updateFromServer(server)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0# TODO don&#39;t use log output to determine when bitba=
ke has started<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0# WARNING: this log handler cannot be removed, as local=
hostbecontroller<br>
@@ -162,8 +166,6 @@ def main(server, eventHandler, params):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;buildstats is not en=
abled. Please enable INHERIT +=3D \&quot;buildstats\&quot; to generate buil=
d statistics.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if not params.observe_only:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.updateFromServer(server)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.updateToServer(server, os.environ.copy(=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline =3D params.parseActions()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not cmdline:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;Nothing to do.=
=C2=A0 Use &#39;bitbake world&#39; to build everything, or run &#39;bitbake=
 --help&#39; for usage information.&quot;)<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div></div>

--00000000000063599305b1c9fb71--
