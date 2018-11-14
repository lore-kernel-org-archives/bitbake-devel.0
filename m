Return-Path: <kergoth@gmail.com>
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
	[209.85.210.65])
	by mail.openembedded.org (Postfix) with ESMTP id E775C60685
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 21:23:48 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id 32so15580848ota.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8tYOPnhP1oc5KfzdM6EVplskiVh6mIfN8LNiaQ26L0w=;
	b=U84JgWS7sBDougf98cvc2ktsLwJyLwVVBIty+Y0MTX0rfRrFSqGUHgUfbOGsV2Ek+V
	XNJt79OO1tYpku/oXzqtNrbOKdHxDU2PNHD0jpFmnCbmOFaBHS2z6ziX4bVKEfW/E429
	nmFU+zhOchmllxJMatjaGN79qmf3x3w2mNev9cf08e+92MwhBDmCzTGEHPhY0t4PvMt1
	I07mYglLSuXTezAFubuujGCEcVu8tYgdRlm1bx51COp9bkKfVopA8ngdJDYaGx6wqPql
	G63QInXAfcpryBk6UOa8/cSpSzksL4ioz16AgZmnofLzPAfC3nAxtOwwIfEe2Jsi6Uhe
	n4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8tYOPnhP1oc5KfzdM6EVplskiVh6mIfN8LNiaQ26L0w=;
	b=DCcB693M8vdjUBTn3ZVL581U4E6x4QRs/Tm7hcrubUm0rvb1qO0kiPGGEfHBRbOpl6
	XmOwW/3mEIhIFJ1m1h65oeSvnOhXkF3g4OeBPy3Tjf/WLdmTJ7Ayhp8Iu0gr72qOUb1v
	B3r82/qil3jJt5vJ66EaYw1pUG5w/7HTkXE2i60ixIX/GIRIiOknmtXmROWh7cXnRU/M
	/8oaBNWNcwhb7D6QgQe/kIvVuRiAoH/1Q/3przmRcg6T9iQPO/Ew3vFFPQJ7OdZpp6Ad
	Fp+SLU6twub9Y2UYzwV/vjHjUDNFUilFAzJK22wcCBo6XLW7Wr4OtY2/a/uclYWI8rOx
	sZ5Q==
X-Gm-Message-State: AGRZ1gLJZimdAEyQmP6JpKMJ2Cg9THYE/Gli35shZvxEEmbbGfsoo3wY
	bQi0BeHudiqYBMZFQjQY6Ld9Rkox6VbUQiqAjvHQfdMc
X-Google-Smtp-Source: AJdET5f8LwESELL57E3lJD5DmSMBLADcHLGXSMIrSmvm5y40EoNNK0vSTgCn04d0E8HoqS0GjHtAqNo72EU/PWYazhA=
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr2214223otl.115.1542230629734; 
	Wed, 14 Nov 2018 13:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20181008081455.16384-1-urs.fassler@bbv.ch>
	<20181008081455.16384-4-urs.fassler@bbv.ch>
In-Reply-To: <20181008081455.16384-4-urs.fassler@bbv.ch>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 14 Nov 2018 14:23:38 -0700
Message-ID: <CABcZANmWohuRuOAHY_h2i-R2A-pvxM9AUKHwgCpO3DcoU3=Mhw@mail.gmail.com>
To: urs.fassler@bbv.ch
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2 3/3] fetch2/git: provide information about missing sources
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 14 Nov 2018 21:23:49 -0000
Content-Type: multipart/alternative; boundary="000000000000d8df2b057aa68c21"

--000000000000d8df2b057aa68c21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 8, 2018 at 2:48 AM Urs F=C3=A4ssler <urs.fassler@bbv.ch> wrote:

> Provide more information in the case the sources are not found in the
> unpack step.
>
> Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bbv.ch>
> Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
> ---
>  lib/bb/fetch2/git.py  | 29 +++++++++++++++++++++--------
>  lib/bb/tests/fetch.py |  2 ++
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 51259df9..15858a62 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -476,14 +476,27 @@ class Git(FetchMethod):
>          if os.path.exists(destdir):
>              bb.utils.prunedir(destdir)
>
> -        clonedir_is_up_to_date =3D not self.clonedir_need_update(ud, d)
> -        if clonedir_is_up_to_date:
> -            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd,
> ud.cloneflags, ud.clonedir, destdir), d)
> -        elif ud.shallow and os.path.exists(ud.fullshallow):
> -            bb.utils.mkdirhier(destdir)
> -            runfetchcmd("tar -xzf %s" % ud.fullshallow, d,
> workdir=3Ddestdir)
> -        else:
> -            raise bb.fetch2.UnpackError("No up to date source found",
> ud.url)
> +        source_found =3D False
> +        source_error =3D []
> +
> +        if not source_found:
> +            clonedir_is_up_to_date =3D not self.clonedir_need_update(ud,=
 d)
> +            if clonedir_is_up_to_date:
> +                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd,
> ud.cloneflags, ud.clonedir, destdir), d)
> +                source_found =3D True
> +            else:
> +                source_error.append("clone directory not available or no=
t
> up to date: " + ud.clonedir)
> +
> +        if not source_found:
> +            if ud.shallow and os.path.exists(ud.fullshallow):
> +                bb.utils.mkdirhier(destdir)
> +                runfetchcmd("tar -xzf %s" % ud.fullshallow, d,
> workdir=3Ddestdir)
> +                source_found =3D True
> +            else:
> +                source_error.append("shallow clone not enabled or not
> available: " + ud.fullshallow)
>

This logic is flawed. In the case where the source hasn=E2=80=99t been foun=
d and
ud.shallow is false, as shallow is disabled, the else clause tries to
access ud.fullshallow, which isn=E2=80=99t an existing attribute:

Exception: AttributeError: 'FetchData' object has no attribute 'fullshallow=
'
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000d8df2b057aa68c21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Mon, Oct 8, 2018 at 2:48 AM Urs F=C3=A4ssler &lt;<a href=3D"m=
ailto:urs.fassler@bbv.ch">urs.fassler@bbv.ch</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding=
-left:1ex">Provide more information in the case the sources are not found i=
n the<br>
unpack step.<br>
<br>
Signed-off-by: Urs F=C3=A4ssler &lt;<a href=3D"mailto:urs.fassler@bbv.ch" t=
arget=3D"_blank">urs.fassler@bbv.ch</a>&gt;<br>
Signed-off-by: Pascal Bach &lt;<a href=3D"mailto:pascal.bach@siemens.com" t=
arget=3D"_blank">pascal.bach@siemens.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/git.py=C2=A0 | 29 +++++++++++++++++++++--------<br>
=C2=A0lib/bb/tests/fetch.py |=C2=A0 2 ++<br>
=C2=A02 files changed, 23 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index 51259df9..15858a62 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -476,14 +476,27 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(destdir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.prunedir(destdir)<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 clonedir_is_up_to_date =3D not self.clonedir_n=
eed_update(ud, d)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if clonedir_is_up_to_date:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s clone %s %s=
/ %s&quot; % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif ud.shallow and os.path.exists(ud.fullshal=
low):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(destdir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;tar -xzf %s&qu=
ot; % ud.fullshallow, d, workdir=3Ddestdir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.UnpackError(&quo=
t;No up to date source found&quot;, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 source_found =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 source_error =3D []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not source_found:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clonedir_is_up_to_date =3D not s=
elf.clonedir_need_update(ud, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if clonedir_is_up_to_date:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
%s clone %s %s/ %s&quot; % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir=
), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_found =3D T=
rue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_error.appen=
d(&quot;clone directory not available or not up to date: &quot; + ud.cloned=
ir)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not source_found:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.shallow and os.path.exists=
(ud.fullshallow):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier=
(destdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
tar -xzf %s&quot; % ud.fullshallow, d, workdir=3Ddestdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_found =3D T=
rue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_error.appen=
d(&quot;shallow clone not enabled or not available: &quot; + ud.fullshallow=
)<br></blockquote><div><br></div><div>This logic is flawed. In the case whe=
re the source hasn=E2=80=99t been found and ud.shallow is false, as shallow=
 is disabled, the else clause tries to access ud.fullshallow, which isn=E2=
=80=99t an existing attribute:</div><div><br></div><div>Exception: Attribut=
eError: &#39;FetchData&#39; object has no attribute &#39;fullshallow&#39;</=
div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>F=
ounder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Men=
tor Graphics</div></div></div></div></div></div>

--000000000000d8df2b057aa68c21--
