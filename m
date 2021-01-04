Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.16887.1609780371427906481
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Jan 2021 09:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dnopM0oa;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: jdegges@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id r4so14859946pls.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Jan 2021 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxaTFRiLS6dwFhL5Tj1TtKI+JhGZxE8sSLoQ5564P4M=;
        b=dnopM0oauHuAeC65FalutqMOsXb2kcXu7NdZvxOuxSeLF5YX63msjN2PxYp8cifgHx
         G4B6Wfut8zjJsNGYMIMIuopEImBwsEOhOBgy4WhJB+shiV63C2kZw+bdXP4TUj8NIBZH
         H1PkNcOzD+hjHJx0ynpDrnaP6V6nubp+JJyheosr8as6Tej+uY00SjR3+/wONSHUiaIt
         aK+BVD0jiQ2TS0CFjjUUIW0TCF/MUDc/Fp0eZ2llWNhi0PakEapJ3YSxINTMEKfbwy0W
         RIkiE5A4CU08DkFMMAB/qHUlm7vq49qg4jvCUA4ZuQ0FDaHih1GqiekT8YZtLDT1joyk
         xgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxaTFRiLS6dwFhL5Tj1TtKI+JhGZxE8sSLoQ5564P4M=;
        b=FtQc4kNpZZOCdbcGhOa4hzKO7Eb59DwVTLyLXWXy32+MrTgc7IYXEttzroCMH0ATUS
         /zxvFmTkdy6xou9FPkddyj6OxT7TlN2RPQXTy8cWKml5MMO6w1E417EajiK9F6IvpTIr
         pH3oRTrx4u0KPQrqNd5+2rnKvWOigsEEWSboT48C3EIH7pXzf1QKxUgqW6jrgAYQHrMT
         arwQ+nEm1yMB6ulvwRSLYqabKFI6wakIPRYXuwJu9sOLnt2p1xKrAB2+Ig+VHPPj2o0M
         3bcD9HQPXlHoQQiITTruQcmdu+X+kEBtCoz++ISFMcwyRbwkkeAs355QXZcUNhcykZ6e
         GUbQ==
X-Gm-Message-State: AOAM531Dmi/Wg4l0QxPqAzlftRv/pd2vZ7XtOH+3Ks0gbtm0InQBTJEo
	5zsFQ9J+G6AlP5vn0a0kuHEBWdPI5BDw9yfw9KE=
X-Google-Smtp-Source: ABdhPJzKSMnZz8Bopf6SIwiFwqhXOA9VDYjA0BHdkCDEhcDBIjsf0ekaFUeMTmWGJBsGKiJkUMYwt06M6/sPsIh5jJA=
X-Received: by 2002:a17:90a:5993:: with SMTP id l19mr30331874pji.203.1609780370851;
 Mon, 04 Jan 2021 09:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20201214094308.15483-1-jdegges@gmail.com>
In-Reply-To: <20201214094308.15483-1-jdegges@gmail.com>
From: "Joey Degges" <jdegges@gmail.com>
Date: Mon, 4 Jan 2021 09:12:40 -0800
Message-ID: <CAFYOfTE=OgvMCqTeOkoz-rHMPY5yaw0hQjEEKPSqqAjG=6M4vA@mail.gmail.com>
Subject: Re: [PATCH] bitbake: fetch/git: Fix usehead for non-default names
To: richard.purdie@linuxfoundation.org, markus.lehtonen@linux.intel.com, 
	jonathan.yong@intel.com, srifenbark@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002bc9b805b816336b"

--0000000000002bc9b805b816336b
Content-Type: text/plain; charset="UTF-8"

Hello all,

I noticed that you've each had a hand in the usehead feature since it was
introduced. Any thoughts on this patch? Is this the right forum to submit
such a change?

This patch is intended to allow the usehead feature to work for URLs with
non-default names.

Best,
Joey

On Mon, Dec 14, 2020 at 1:43 AM Joey Degges <jdegges@gmail.com> wrote:

> The usehead url parameter for git repositories causes bitbake to use
> whatever commit the repository HEAD is pointing to if the repository
> happens to have the name 'default'. This is the default name so in many
> cases it works just fine, but if a different name is specified with the
> url parameter 'name=newName' then it will fail to parse the recipe with
> an error along the lines of:
>
> ERROR: ExpansionError during parsing /path/to/my/recipe.bb
> Traceback (most recent call last):
>   File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 235, in
> Git.urldata_init:
>     >        ud.setup_revisions(d)
>   File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1302, in
> FetchData.setup_revisions:
>              for name in self.names:
>     >            self.revisions[name] = srcrev_internal_helper(self, d,
> name)
>   File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1167, in
> srcrev_internal_helper(name='newName'):
>          if srcrev == "AUTOINC":
>     >        srcrev = ud.method.latest_revision(ud, d, name)
>   File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1562, in
> Git.latest_revision(name='newName'):
>              except KeyError:
>     >            revs[key] = rev = self._latest_revision(ud, d, name)
>                  return rev
>   File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 650, in
> Git._latest_revision(name='newName'):
>              raise bb.fetch2.FetchError("Unable to resolve '%s' in
> upstream git repository in git ls-remote output for %s" % \
>     >            (ud.unresolvedrev[name], ud.host+ud.path))
> bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression
> was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError:
> Fetcher failure: Unable to resolve 'master' in upstream git repository in
> git ls-remote output for /path/to/local/git/repo
>
> Let's fix this by setting the unresolved rev of _all_ repository names
> to 'HEAD' when the usehead url parameter is specified.
>
> This change preserves existing behavior that allows usehead to be
> overridden by a valid looking revision if one happens to be specified
> instead of AUTOREV.
>
> Signed-off-by: Joey Degges <jdegges@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 490d57fb..df9538a6 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -220,7 +220,12 @@ class Git(FetchMethod):
>              ud.shallow = False
>
>          if ud.usehead:
> -            ud.unresolvedrev['default'] = 'HEAD'
> +            # When usehead is set let's associate 'HEAD' with the
> unresolved
> +            # rev of this repository. This will get resolved into a
> revision
> +            # later. If an actual revision happens to have also been
> provided
> +            # then this setting will be overridden.
> +            for name in ud.names:
> +                ud.unresolvedrev[name] = 'HEAD'
>
>          ud.basecmd = d.getVar("FETCHCMD_git") or "git -c
> core.fsyncobjectfiles=0"
>
> --
> 2.24.3 (Apple Git-128)
>
>

--0000000000002bc9b805b816336b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div>I noticed that you&#39;ve ea=
ch had a hand in the usehead=C2=A0feature since it was introduced. Any thou=
ghts on this patch? Is this the right forum to submit such a change?</div><=
div><br></div><div>This patch is intended to allow the usehead feature to w=
ork for URLs with non-default names.</div><div><br></div><div>Best,</div><d=
iv>Joey</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Dec 14, 2020 at 1:43 AM Joey Degges &lt;<a href=3D"mai=
lto:jdegges@gmail.com">jdegges@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">The usehead url parameter for git r=
epositories causes bitbake to use<br>
whatever commit the repository HEAD is pointing to if the repository<br>
happens to have the name &#39;default&#39;. This is the default name so in =
many<br>
cases it works just fine, but if a different name is specified with the<br>
url parameter &#39;name=3DnewName&#39; then it will fail to parse the recip=
e with<br>
an error along the lines of:<br>
<br>
ERROR: ExpansionError during parsing /path/to/my/<a href=3D"http://recipe.b=
b" rel=3D"noreferrer" target=3D"_blank">recipe.bb</a><br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/path/to/poky/bitbake/lib/bb/fetch2/git.py&quot;, line 23=
5, in Git.urldata_init:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.setup_revisions(d)<br>
=C2=A0 File &quot;/path/to/poky/bitbake/lib/bb/fetch2/__init__.py&quot;, li=
ne 1302, in FetchData.setup_revisions:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for name in self.names:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.revisions[=
name] =3D srcrev_internal_helper(self, d, name)<br>
=C2=A0 File &quot;/path/to/poky/bitbake/lib/bb/fetch2/__init__.py&quot;, li=
ne 1167, in srcrev_internal_helper(name=3D&#39;newName&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if srcrev =3D=3D &quot;AUTOINC&quot;:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 srcrev =3D ud.method.latest_r=
evision(ud, d, name)<br>
=C2=A0 File &quot;/path/to/poky/bitbake/lib/bb/fetch2/__init__.py&quot;, li=
ne 1562, in Git.latest_revision(name=3D&#39;newName&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except KeyError:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs[key] =3D r=
ev =3D self._latest_revision(ud, d, name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rev<br=
>
=C2=A0 File &quot;/path/to/poky/bitbake/lib/bb/fetch2/git.py&quot;, line 65=
0, in Git._latest_revision(name=3D&#39;newName&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.fetch2.FetchError(=
&quot;Unable to resolve &#39;%s&#39; in upstream git repository in git ls-r=
emote output for %s&quot; % \<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ud.unresolvedr=
ev[name], ud.host+ud.path))<br>
bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression =
was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetch=
er failure: Unable to resolve &#39;master&#39; in upstream git repository i=
n git ls-remote output for /path/to/local/git/repo<br>
<br>
Let&#39;s fix this by setting the unresolved rev of _all_ repository names<=
br>
to &#39;HEAD&#39; when the usehead url parameter is specified.<br>
<br>
This change preserves existing behavior that allows usehead to be<br>
overridden by a valid looking revision if one happens to be specified<br>
instead of AUTOREV.<br>
<br>
Signed-off-by: Joey Degges &lt;<a href=3D"mailto:jdegges@gmail.com" target=
=3D"_blank">jdegges@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/git.py | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index 490d57fb..df9538a6 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -220,7 +220,12 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.shallow =3D False<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.usehead:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.unresolvedrev[&#39;default&#3=
9;] =3D &#39;HEAD&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # When usehead is set let&#39;s =
associate &#39;HEAD&#39; with the unresolved<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # rev of this repository. This w=
ill get resolved into a revision<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # later. If an actual revision h=
appens to have also been provided<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # then this setting will be over=
ridden.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in ud.names:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.unresolvedrev[n=
ame] =3D &#39;HEAD&#39;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basecmd =3D d.getVar(&quot;FETCHCMD_gi=
t&quot;) or &quot;git -c core.fsyncobjectfiles=3D0&quot;<br>
<br>
-- <br>
2.24.3 (Apple Git-128)<br>
<br>
</blockquote></div>

--0000000000002bc9b805b816336b--
