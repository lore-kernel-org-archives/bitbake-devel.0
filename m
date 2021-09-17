Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.1083.1631897446734394335
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Sep 2021 09:50:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=auMo4Ec/;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id z94so32090061ede.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Sep 2021 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qp6HR2WUWpkulGNNRvmCZ4scjWXjLT4eEE13WVxaiG0=;
        b=auMo4Ec/cujYT2E28onUwttDOtauE0QVlWzzAo0OJp+ntgLRSEDQaTd4Cv8Rem9Qaw
         CzrLLdqoakNEPZu1a+fXEwJOz0kLNLKzp60IueX55fbKnyPtHhesARPCWNzfNVNSRvbA
         hCFIhecYbG5zuDQTG4W4mngAJoLk8zKVPcJUJB39lEY3SYOQ6AwJhizNo5ao+5DbeVDo
         yI3g5AVPkZtJt5evbgCmjo7isTN1oK9t3fmEJgM373RfHeTqTuq3ZNPuqvPjF8FK2CNJ
         fN2N2a5iBDdPXJwpwPJR9MexWon8aGVonmlvAksZ6fFl/IIO+W15de8Xc8sQoahwp3rE
         wHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qp6HR2WUWpkulGNNRvmCZ4scjWXjLT4eEE13WVxaiG0=;
        b=upqJgl6JCT/Sn6zN3lDaZvbz0bSXAB+T9Kb4zFJZ7uBp3hrBed3iVH/jvBr0ymjKTp
         8JuxMlJVDTORttH9ziVcuKSOha37clKeSW9lEOPjO+p60Ty1CMf+y7inlEHhHNzwAWL+
         a6ew/Rzk6pYGv4GiFbqdPW3V0scRkxcYzqhjOPUDatFiSZIKXH2EVcBRKc4riKgu/Htd
         BkVSylB9JR6GD3ht2UUDHgqaemrtc0oD+7m2vLvbEECckVa2BKXosqgfiah2u0kfmaPA
         Z/FkoyZk1Yq/vk5dWcX43BDnMPBJEmoL1ittxU/App0PdyjkWCBxPnR244yENCRu5C77
         oYZg==
X-Gm-Message-State: AOAM530JZ/NFlZ8+31Xvj4usupGz1OpgyqFWfNKwyipMwGqRyDjYnKOu
	ritBHgyCcZmzUPX0XZxCpy9C9/p82OIYsRSVDS8=
X-Google-Smtp-Source: ABdhPJwIpCFhfKLpw6P8YpDmz+0g5LyG8ff4KRGsnq2UCsVJi8j5uY1UONSOdF3MvxKAvjByOwU/gioZvDQ44wh+8Qw=
X-Received: by 2002:a50:eacb:: with SMTP id u11mr13381027edp.209.1631897445167;
 Fri, 17 Sep 2021 09:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210916142549.1464585-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210916142549.1464585-1-richard.purdie@linuxfoundation.org>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Fri, 17 Sep 2021 09:50:36 -0700
Message-ID: <CABcZANnHTKDbdBW1BauJrUURe39yovtaooJ7k_4_CCgqq_zxAA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Avoid races over mirror tarball creation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000008777fe05cc33bbd5"

--0000000000008777fe05cc33bbd5
Content-Type: text/plain; charset="UTF-8"

This looks good, though if we're creating the temporary file in the same
directory as the resulting file, which seems to be the case, could we not
just os.rename() rather than calling a subprocess?

On Thu, Sep 16, 2021 at 7:25 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> There is a potential race over the mirror tarballs where a partial git repo
> could be extracted causing fetcher failures if the tarball is being
> rewritten
> whilst another build accesses it.
>
> Create the mirror tarball atomically to avoid this.
>
> [YOCTO #14441]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 488f4c7414..3643a491d7 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -68,6 +68,7 @@ import subprocess
>  import tempfile
>  import bb
>  import bb.progress
> +from contextlib import contextmanager
>  from   bb.fetch2 import FetchMethod
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
> @@ -418,6 +419,20 @@ class Git(FetchMethod):
>                  bb.utils.remove(tmpdir, recurse=True)
>
>      def build_mirror_data(self, ud, d):
> +
> +        # Create as a temp file and move atomically into position to
> avoid races
> +        @contextmanager
> +        def create_atomic(filename, d):
> +            fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
> +            try:
> +                yield tfile
> +                umask = os.umask(0o666)
> +                os.umask(umask)
> +                os.chmod(tfile, (0o666 & ~umask))
> +                runfetchcmd("mv %s %s" % (tfile, filename), d)
> +            finally:
> +                os.close(fd)
> +
>          if ud.shallow and ud.write_shallow_tarballs:
>              if not os.path.exists(ud.fullshallow):
>                  if os.path.islink(ud.fullshallow):
> @@ -428,7 +443,8 @@ class Git(FetchMethod):
>                      self.clone_shallow_local(ud, shallowclone, d)
>
>                      logger.info("Creating tarball of git repository")
> -                    runfetchcmd("tar -czf %s ." % ud.fullshallow, d,
> workdir=shallowclone)
> +                    with create_atomic(ud.fullshallow, d) as tfile:
> +                        runfetchcmd("tar -czf %s ." % tfile, d,
> workdir=shallowclone)
>                      runfetchcmd("touch %s.done" % ud.fullshallow, d)
>                  finally:
>                      bb.utils.remove(tempdir, recurse=True)
> @@ -437,7 +453,8 @@ class Git(FetchMethod):
>                  os.unlink(ud.fullmirror)
>
>              logger.info("Creating tarball of git repository")
> -            runfetchcmd("tar -czf %s ." % ud.fullmirror, d,
> workdir=ud.clonedir)
> +            with create_atomic(ud.fullmirror, d) as tfile:
> +                runfetchcmd("tar -czf %s ." % tfile, d,
> workdir=ud.clonedir)
>              runfetchcmd("touch %s.done" % ud.fullmirror, d)
>
>      def clone_shallow_local(self, ud, dest, d):
> --
> 2.32.0
>
>
> 
>
>

-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--0000000000008777fe05cc33bbd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This looks good, though if we&#39;re creating the temporar=
y file in the same directory as the resulting file, which seems to be the c=
ase, could we not just os.rename() rather than calling a subprocess?</div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 Sep 16, 2021 at 7:25 AM Richard Purdie &lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">There is a potenti=
al race over the mirror tarballs where a partial git repo<br>
could be extracted causing fetcher failures if the tarball is being rewritt=
en<br>
whilst another build accesses it.<br>
<br>
Create the mirror tarball atomically to avoid this.<br>
<br>
[YOCTO #14441]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/fetch2/git.py | 21 +++++++++++++++++++--<br>
=C2=A01 file changed, 19 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index 488f4c7414..3643a491d7 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -68,6 +68,7 @@ import subprocess<br>
=C2=A0import tempfile<br>
=C2=A0import bb<br>
=C2=A0import bb.progress<br>
+from contextlib import contextmanager<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
@@ -418,6 +419,20 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remo=
ve(tmpdir, recurse=3DTrue)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def build_mirror_data(self, ud, d):<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Create as a temp file and move atomically in=
to position to avoid races<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @contextmanager<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def create_atomic(filename, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd, tfile =3D tempfile.mkstemp(d=
ir=3Dos.path.dirname(filename))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yield tfile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 umask =3D os.umask=
(0o666)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.umask(umask)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chmod(tfile, (0=
o666 &amp; ~umask))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
mv %s %s&quot; % (tfile, filename), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.close(fd)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.shallow and ud.write_shallow_tarbal=
ls:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not os.path.exists(ud.fu=
llshallow):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.is=
link(ud.fullshallow):<br>
@@ -428,7 +443,8 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.clone_shallow_local(ud, shallowclone, d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<a href=3D"http://logger.info" rel=3D"noreferrer" target=3D"_blank">logg=
er.info</a>(&quot;Creating tarball of git repository&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runf=
etchcmd(&quot;tar -czf %s .&quot; % ud.fullshallow, d, workdir=3Dshallowclo=
ne)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with=
 create_atomic(ud.fullshallow, d) as tfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 runfetchcmd(&quot;tar -czf %s .&quot; % tfile, d, workdir=3Dshal=
lowclone)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0runfetchcmd(&quot;touch %s.done&quot; % ud.fullshallow, d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finally:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bb.utils.remove(tempdir, recurse=3DTrue)<br>
@@ -437,7 +453,8 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.unlink(ud.=
fullmirror)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://logger.in=
fo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;Creating tar=
ball of git repository&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;tar -czf %s .&=
quot; % ud.fullmirror, d, workdir=3Dud.clonedir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with create_atomic(ud.fullmirror=
, d) as tfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
tar -czf %s .&quot; % tfile, d, workdir=3Dud.clonedir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(&quot;touch %s.=
done&quot; % ud.fullmirror, d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def clone_shallow_local(self, ud, dest, d):<br>
-- <br>
2.32.0<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--0000000000008777fe05cc33bbd5--
