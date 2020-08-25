Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.15656.1598368047130356101
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 08:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rsrli187;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id u1so1359503edi.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnyH9baXBInqeMrIu4mF863ba+z1KwsTm7ZOr3gpyW0=;
        b=rsrli18775bIi9uPlFY6g0fiHBMlpNUGxlAJMZdoOnfH1uTVsz62WlNfliOSQxfTYt
         rfkyiqTOXvieoIZJyErPPPVBiaoGvM1rIy1Be85XtWoqNFLGLCXdV/TyysISdXUQP6I2
         l2nh7RxFLBWhFSKcCSF/KDFhlo+6v65uZ3VQzQjNAxPpQNa0tTNYSWDLxP5glE25IC86
         H71mfSIvyarY2gP7is3IwmTEo8xtZRtUDy8BGZdh7u4OY4WjT+SkVDOgGsybgrf0HQyW
         6u6hM4QgFeo64eq5YxQPWCitVTBCIv4u0RX1vYnbeuimP7d7wcR2/t6HJVIS97lptj3B
         jA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnyH9baXBInqeMrIu4mF863ba+z1KwsTm7ZOr3gpyW0=;
        b=H+MdqtoA7vy5Ovau9UG7R3Yvd6ki42c8moyQ9CA1Rbpwe0W1fcZSMGO3GlclRq4Zk/
         neO4RPsZGG0T+ur4AzpEO6tUv31NeROjZ+Lc4Ksh5S7wSPcjj5nIGaf7e7Amb3/EJ5GO
         Rs2XhbuQOQ93625ZTlSyTryRe68hAIQaqaiB1M5uLW8A5lKQwf01GK7TtbL9a682Pkz0
         tQpCkBVECT/LGz6sF59BZLo7T2MoOaQSLhbTUOdczqKs9hiQoh+ssXsBACiiTiWsIwF5
         sRh9Zeowx9LNBHgXomRXTkGBadkIGsbUjMzsJZBf4xkyXJ0Kly2IZo/e8tJU87W5UjdP
         /sQA==
X-Gm-Message-State: AOAM533261s0pz8O3oNhgkJDvZb7GIFqUb/8KgJDXza5saJo2O91VS2h
	AOFeguMFpsbGcIuWjWYNa5SobCkUrPCOIJpXWUQ=
X-Google-Smtp-Source: ABdhPJwz/tyKVMuLwzi5wt/XU92PO+N6G13HlJmZhnZXdJGN7oGlO6urR8Cg+FWI1ArmNeuxigLuJ84jvnkbxI9YyVE=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr11000155edy.52.1598368045382;
 Tue, 25 Aug 2020 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200825135643.1422253-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20200825135643.1422253-1-richard.purdie@linuxfoundation.org>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Tue, 25 Aug 2020 08:07:14 -0700
Message-ID: <CABcZANktF96XZifgAmbZ_W9O8dAd-6+MJj6ChTzRxtDMYOtVNg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Drop globbing supprt in file:// SRC_URIs
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000090c1c305adb50f52"

--00000000000090c1c305adb50f52
Content-Type: text/plain; charset="UTF-8"

Good riddance! Thanks for this.

On Tue, Aug 25, 2020 at 6:56 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Globbing in file:// urls is terminally broken. Currently when its used, the
> file checksum code is basically bypassed. This means changes to the source
> files don't change the task checksum, the task doesn't rebuild when the
> inputs change and things generally break.
>
> To make globbing work generically, we'd have to scan the file system for
> all possible matches to the glob and log whether they exist or not. We
> can't
> simply log the files which exist, we have to also know which files could
> later exist and influence the choice of file so we know when to reparse.
>
> For a simple file://xxx/*, this could be done but for bigger patterns,
> it becomes much more problemtic. We already support file://xxx/ in urls.
>
> So, lets decide we'll not support globs in file://urls. Worse case users
> can put files in a directory and reference that, moving files into place
> if needed.
>
> Remove all the glob special cases (see the comments if anyone doesn't
> believe this is terminally broken) and error to the user if they have
> such urls.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cache.py           |  2 +-
>  lib/bb/fetch2/__init__.py | 12 ------------
>  lib/bb/fetch2/local.py    | 15 +++------------
>  3 files changed, 4 insertions(+), 25 deletions(-)
>
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index b819a0c2da..9e0c931a07 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -636,7 +636,7 @@ class Cache(NoCache):
>                  # Have to be careful about spaces and colons in filenames
>                  flist = self.filelist_regex.split(fl)
>                  for f in flist:
> -                    if not f or "*" in f:
> +                    if not f:
>                          continue
>                      f, exist = f.split(":")
>                      if (exist == "True" and not os.path.exists(f)) or
> (exist == "False" and os.path.exists(f)):
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 756f60212f..7ec1fea5d0 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1195,8 +1195,6 @@ def get_checksum_file_list(d):
>              paths = ud.method.localpaths(ud, d)
>              for f in paths:
>                  pth = ud.decodedurl
> -                if '*' in pth:
> -                    f = os.path.join(os.path.abspath(f), pth)
>                  if f.startswith(dl_dir):
>                      # The local fetcher's behaviour is to return a path
> under DL_DIR if it couldn't find the file anywhere else
>                      if os.path.exists(f):
> @@ -1365,9 +1363,6 @@ class FetchMethod(object):
>          # We cannot compute checksums for directories
>          if os.path.isdir(urldata.localpath):
>              return False
> -        if urldata.localpath.find("*") != -1:
> -            return False
> -
>          return True
>
>      def recommends_checksum(self, urldata):
> @@ -1430,11 +1425,6 @@ class FetchMethod(object):
>          iterate = False
>          file = urldata.localpath
>
> -        # Localpath can't deal with 'dir/*' entries, so it converts them
> to '.',
> -        # but it must be corrected back for local files copying
> -        if urldata.basename == '*' and file.endswith('/.'):
> -            file = '%s/%s' % (file.rstrip('/.'), urldata.path)
> -
>          try:
>              unpack = bb.utils.to_boolean(urldata.parm.get('unpack'), True)
>          except ValueError as exc:
> @@ -1613,8 +1603,6 @@ class FetchMethod(object):
>          """
>          if os.path.exists(ud.localpath):
>              return True
> -        if ud.localpath.find("*") != -1:
> -            return True
>          return False
>
>      def implicit_urldata(self, ud, d):
> diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
> index 01d9ff9f8f..25d4557db6 100644
> --- a/lib/bb/fetch2/local.py
> +++ b/lib/bb/fetch2/local.py
> @@ -17,7 +17,7 @@ import os
>  import urllib.request, urllib.parse, urllib.error
>  import bb
>  import bb.utils
> -from   bb.fetch2 import FetchMethod, FetchError
> +from   bb.fetch2 import FetchMethod, FetchError, ParameterError
>  from   bb.fetch2 import logger
>
>  class Local(FetchMethod):
> @@ -33,6 +33,8 @@ class Local(FetchMethod):
>          ud.basename = os.path.basename(ud.decodedurl)
>          ud.basepath = ud.decodedurl
>          ud.needdonestamp = False
> +        if "*" in ud.decodedurl:
> +            raise bb.fetch2.ParameterError("file:// urls using globbing
> are no longer supported. Please place the files in a directory and
> reference that instead.", ud.url)
>          return
>
>      def localpath(self, urldata, d):
> @@ -55,12 +57,6 @@ class Local(FetchMethod):
>              logger.debug(2, "Searching for %s in paths:\n    %s" % (path,
> "\n    ".join(filespath.split(":"))))
>              newpath, hist = bb.utils.which(filespath, path, history=True)
>              searched.extend(hist)
> -        if (not newpath or not os.path.exists(newpath)) and
> path.find("*") != -1:
> -            # For expressions using '*', best we can do is take the first
> directory in FILESPATH that exists
> -            newpath, hist = bb.utils.which(filespath, ".", history=True)
> -            searched.extend(hist)
> -            logger.debug(2, "Searching for %s in path: %s" % (path,
> newpath))
> -            return searched
>          if not os.path.exists(newpath):
>              dldirfile = os.path.join(d.getVar("DL_DIR"), path)
>              logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
> @@ -70,8 +66,6 @@ class Local(FetchMethod):
>          return searched
>
>      def need_update(self, ud, d):
> -        if ud.url.find("*") != -1:
> -            return False
>          if os.path.exists(ud.localpath):
>              return False
>          return True
> @@ -95,9 +89,6 @@ class Local(FetchMethod):
>          """
>          Check the status of the url
>          """
> -        if urldata.localpath.find("*") != -1:
> -            logger.info("URL %s looks like a glob and was therefore not
> checked.", urldata.url)
> -            return True
>          if os.path.exists(urldata.localpath):
>              return True
>          return False
> --
> 2.25.1
>
> 
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--00000000000090c1c305adb50f52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good riddance! Thanks for this.</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 6:5=
6 AM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.or=
g">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1=
ex">Globbing in file:// urls is terminally broken. Currently when its used,=
 the<br>
file checksum code is basically bypassed. This means changes to the source=
<br>
files don&#39;t change the task checksum, the task doesn&#39;t rebuild whe=
n the<br>
inputs change and things generally break.<br>
<br>
To make globbing work generically, we&#39;d have to scan the file system f=
or<br>
all possible matches to the glob and log whether they exist or not. We can=
&#39;t<br>
simply log the files which exist, we have to also know which files could<b=
r>
later exist and influence the choice of file so we know when to reparse.<b=
r>
<br>
For a simple file://xxx/*, this could be done but for bigger patterns,<br>
it becomes much more problemtic. We already support file://xxx/ in urls.<b=
r>
<br>
So, lets decide we&#39;ll not support globs in file://urls. Worse case use=
rs<br>
can put files in a directory and reference that, moving files into place<b=
r>
if needed.<br>
<br>
Remove all the glob special cases (see the comments if anyone doesn&#39;t<=
br>
believe this is terminally broken) and error to the user if they have<br>
such urls.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfo=
undation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<=
br>
---<br>
=C2=A0lib/bb/cache.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-=
<br>
=C2=A0lib/bb/fetch2/__init__.py | 12 ------------<br>
=C2=A0lib/bb/fetch2/local.py=C2=A0 =C2=A0 | 15 +++------------<br>
=C2=A03 files changed, 4 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/lib/bb/cache.py b/lib/bb/cache.py<br>
index b819a0c2da..9e0c931a07 100644<br>
--- a/lib/bb/cache.py<br>
+++ b/lib/bb/cache.py<br>
@@ -636,7 +636,7 @@ class Cache(NoCache):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Have to be=
 careful about spaces and colons in filenames<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flist =3D se=
lf.filelist_regex.split(fl)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for f in fli=
st:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
not f or &quot;*&quot; in f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
not f:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0f, exist =3D f.split(&quot;:&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (exist =3D=3D &quot;True&quot; and not os.path.exists(f)) or (exist =
=
=3D=3D &quot;False&quot; and os.path.exists(f)):<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index 756f60212f..7ec1fea5d0 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -1195,8 +1195,6 @@ def get_checksum_file_list(d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0paths =3D ud.method.localp=
aths(ud, d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for f in paths:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pth =3D ud.d=
ecodedurl<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;*&#39; in=
 pth:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f =
=3D os.path.join(os.path.abspath(f), pth)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if f.startsw=
ith(dl_dir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0# The local fetcher&#39;s behaviour is to return a path under DL_DIR if=
 it couldn&#39;t find the file anywhere else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if os.path.exists(f):<br>
@@ -1365,9 +1363,6 @@ class FetchMethod(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We cannot compute checksums for direct=
ories<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.isdir(urldata.localpath):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata.localpath.find(&quot;*&quot;) !=3D=
 -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
=C2=A0 =C2=A0 =C2=A0def recommends_checksum(self, urldata):<br>
@@ -1430,11 +1425,6 @@ class FetchMethod(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iterate =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file =3D urldata.localpath<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Localpath can&#39;t deal with &#39;dir/*&#3=
9; entries, so it converts them to &#39;.&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # but it must be corrected back for local fil=
es copying<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata.basename =3D=3D &#39;*&#39; and fi=
le.endswith(&#39;/.&#39;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file =3D &#39;%s/%s&#39; % (fil=
e.rstrip(&#39;/.&#39;), urldata.path)<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unpack =3D bb.utils.to_boo=
lean(urldata.parm.get(&#39;unpack&#39;), True)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except ValueError as exc:<br>
@@ -1613,8 +1603,6 @@ class FetchMethod(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.localpath.find(&quot;*&quot;) !=3D -1:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def implicit_urldata(self, ud, d):<br>
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py<br>
index 01d9ff9f8f..25d4557db6 100644<br>
--- a/lib/bb/fetch2/local.py<br>
+++ b/lib/bb/fetch2/local.py<br>
@@ -17,7 +17,7 @@ import os<br>
=C2=A0import urllib.request, urllib.parse, urllib.error<br>
=C2=A0import bb<br>
=C2=A0import bb.utils<br>
-from=C2=A0 =C2=A0bb.fetch2 import FetchMethod, FetchError<br>
+from=C2=A0 =C2=A0bb.fetch2 import FetchMethod, FetchError, ParameterError=
<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
<br>
=C2=A0class Local(FetchMethod):<br>
@@ -33,6 +33,8 @@ class Local(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basename =3D os.path.basename(ud.deco=
dedurl)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basepath =3D ud.decodedurl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.needdonestamp =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;*&quot; in ud.decodedurl:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.ParameterError(=
&quot;file:// urls using globbing are no longer supported. Please place the=
 files in a directory and reference that instead.&quot;, ud.url)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
<br>
=C2=A0 =C2=A0 =C2=A0def localpath(self, urldata, d):<br>
@@ -55,12 +57,6 @@ class Local(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(2, &quot;Sear=
ching for %s in paths:\n=C2=A0 =C2=A0 %s&quot; % (path, &quot;\n=C2=A0 =C2=
=A0 &quot;.join(filespath.split(&quot;:&quot;))))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newpath, hist =3D bb.utils=
.which(filespath, path, history=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0searched.extend(hist)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (not newpath or not os.path.exists(newpath=
)) and path.find(&quot;*&quot;) !=3D -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # For expressions using &#39;*&=
#39;, best we can do is take the first directory in FILESPATH that exists<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newpath, hist =3D bb.utils.whic=
h(filespath, &quot;.&quot;, history=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 searched.extend(hist)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(2, &quot;Searching=
 for %s in path: %s&quot; % (path, newpath))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return searched<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not os.path.exists(newpath):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dldirfile =3D os.path.join=
(d.getVar(&quot;DL_DIR&quot;), path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(2, &quot;Defa=
ulting to %s for %s&quot; % (dldirfile, path))<br>
@@ -70,8 +66,6 @@ class Local(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return searched<br>
<br>
=C2=A0 =C2=A0 =C2=A0def need_update(self, ud, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.url.find(&quot;*&quot;) !=3D -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
@@ -95,9 +89,6 @@ class Local(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check the status of the url<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata.localpath.find(&quot;*&quot;) !=3D=
 -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" =
rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;URL %s looks lik=
e a glob and was therefore not checked.&quot;, urldata.url)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(urldata.localpath):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></=
div>

--00000000000090c1c305adb50f52--
