Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web09.33327.1610367342554675870
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Jan 2021 04:15:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista-com.20150623.gappssmtp.com header.s=20150623 header.b=uP+j00VY;
 spf=permerror, err=parse error for token &{10 18 websitewelcome.com}: parse error for token &{10 18 _spf.google.com}: limit exceeded (domain: mvista.com, ip: 209.85.218.52, mailfrom: mshah@mvista.com)
Received: by mail-ej1-f52.google.com with SMTP id t16so24285075ejf.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Jan 2021 04:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VAlt1IRYMenHDgsvddEbIPtuLu1j/8LzhrjvHq4Jeno=;
        b=uP+j00VYRMsDEDOlbfB+rR7UJLoJa0uYaWfWtsmDZMpkdUnff3aQf2ZvLanEeSydYd
         cOdCcIHyvdbyk4oAlq8pI3e6EGb7qsRyNNlneI4numrwitFMsT07Jguz50KTMwBmswlt
         XJr/YKn+hfBiXnYIp9nag6f9Suw6yQmeYlymPsnbOHyjPIbEoWKjRhq3wMr0KEDjg3g9
         Kn/VuLjGNUQWOAhv//liGKxw+R2JTE/H4tN3JX/NuT+KTJvGSlA2+bIordWWmUDBOUHH
         RmlSRwoUX1MTRgYKSYS9jSz1frO+HxowhGpO93L+3d276tnW/nLzrdpq9wpFwJLVxc28
         y3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VAlt1IRYMenHDgsvddEbIPtuLu1j/8LzhrjvHq4Jeno=;
        b=Luo58mrgJ2LzSLemLm54UmAiwFlUlvyR+LY/z8aBILQ+RNu/ZatFnQqtaIoHTRLJFl
         AWhZ9qGe6BkI9R1z9Bfiin5bbUlxKal4WVGwzVAGeKKJHGaCzsnhEHUB0STkh+hSS75Y
         z+/+wikFjZe7Ko1FrE2CkA3UdwyYCt/IkcPKh0ycLuh7F8CVdEWc70BefudsGPfPOidz
         g0MQtKMjin1gyujc4PZmVBG/5+aSCZc1Qb5M1ilHjEtpKHNswL6MOsQBXkpm79w1vyCw
         mbOlCzuGcH+PLqe1lUfO4IeF6n+CKHzxpiD5lDfuAa6JXL1VJZM5AEPMwJCNmnlTaeTA
         gGhw==
X-Gm-Message-State: AOAM533pnCHaSxe+MjznwCaoBzEgOPKpKN70Mly3lCbZwltZxzhp6LFq
	mONRXzZ9Gzd8Z1kX9l55z5nM7HOH5K3kz0NNixUKImgPUpI=
X-Google-Smtp-Source: ABdhPJywU7gGpnM073mb9FIb+Nit0TvzGhZrsAN+h6KI+/6lB4yOU1hSI8j0wZHOcHe/R1QAj6uzGxZMLyZK2OUQHok=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr10369567ejb.314.1610367340544;
 Mon, 11 Jan 2021 04:15:40 -0800 (PST)
MIME-Version: 1.0
References: <1609839118-2342-1-git-send-email-mshah@mvista.com>
In-Reply-To: <1609839118-2342-1-git-send-email-mshah@mvista.com>
From: "Milan Shah" <mshah@mvista.com>
Date: Mon, 11 Jan 2021 17:45:04 +0530
Message-ID: <CA+=qD9NuCZ7KeAU3YDDnK=kLa8UVeucOMAyPi6CB+wxTf79Mbg@mail.gmail.com>
Subject: Re: [PATCH] bitbake: utils: add docstrings to functions
To: bitbake-devel@lists.openembedded.org, 
	Randy MacLeod <randy.macleod@windriver.com>, brian.avery@intel.com
Content-Type: multipart/alternative; boundary="0000000000004a9ae005b89edd0d"

--0000000000004a9ae005b89edd0d
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is a gentle reminder to review this patch.

-----------------------
Thanks & Regards,
*Milan Shah*
MontaVista Software, Bangalore, India


On Tue, Jan 5, 2021 at 3:02 PM Milan Shah <mshah@mvista.com> wrote:

> A list of functions that now has a docstring.
> * vercmp_string
> * explode_dep_versions
> * prunedir
> * prune_suffix
> * to_boolean
> * contains_any
> * export_proxies
>
> See [YOCTO #9725] for details.
>
> Signed-off-by: Milan Shah <mshah@mvista.com>
> ---
>  lib/bb/utils.py | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index f73d31f..5c775bd 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -129,6 +129,7 @@ def vercmp(ta, tb):
>      return r
>
>  def vercmp_string(a, b):
> +    """ Split version strings and compare them """
>      ta = split_version(a)
>      tb = split_version(b)
>      return vercmp(ta, tb)
> @@ -247,6 +248,12 @@ def explode_dep_versions2(s, *, sort=True):
>      return r
>
>  def explode_dep_versions(s):
> +    """
> +    Take an RDEPENDS style string of format:
> +    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
> +    skip null value and items appeared in dependancy string multiple times
> +    and return a dictionary of dependencies and versions.
> +    """
>      r = explode_dep_versions2(s)
>      for d in r:
>          if not r[d]:
> @@ -692,7 +699,7 @@ def remove(path, recurse=False, ionice=False):
>                  raise
>
>  def prunedir(topdir, ionice=False):
> -    # Delete everything reachable from the directory named in 'topdir'.
> +    """ Delete everything reachable from the directory named in 'topdir'.
> """
>      # CAUTION:  This is dangerous!
>      if _check_unsafe_delete_path(topdir):
>          raise Exception('bb.utils.prunedir: called with dangerous path
> "%s", refusing to delete!' % topdir)
> @@ -703,8 +710,10 @@ def prunedir(topdir, ionice=False):
>  # but thats possibly insane and suffixes is probably going to be small
>  #
>  def prune_suffix(var, suffixes, d):
> -    # See if var ends with any of the suffixes listed and
> -    # remove it if found
> +    """
> +    See if var ends with any of the suffixes listed and
> +    remove it if found
> +    """
>      for suffix in suffixes:
>          if suffix and var.endswith(suffix):
>              return var[:-len(suffix)]
> @@ -956,6 +965,10 @@ def umask(new_mask):
>          os.umask(current_mask)
>
>  def to_boolean(string, default=None):
> +    """
> +    Check input string and return boolean value True/False/None
> +    depending upon the checks
> +    """
>      if not string:
>          return default
>
> @@ -999,6 +1012,23 @@ def contains(variable, checkvalues, truevalue,
> falsevalue, d):
>      return falsevalue
>
>  def contains_any(variable, checkvalues, truevalue, falsevalue, d):
> +    """Check if a variable contains any values specified.
> +
> +    Arguments:
> +
> +    variable -- the variable name. This will be fetched and expanded
> (using
> +    d.getVar(variable)) and then split into a set().
> +
> +    checkvalues -- if this is a string it is split on whitespace into a
> set(),
> +    otherwise coerced directly into a set().
> +
> +    truevalue -- the value to return if checkvalues is a subset of
> variable.
> +
> +    falsevalue -- the value to return if variable is empty or if
> checkvalues is
> +    not a subset of variable.
> +
> +    d -- the data store.
> +    """
>      val = d.getVar(variable)
>      if not val:
>          return falsevalue
> @@ -1560,8 +1590,8 @@ def set_process_name(name):
>      except:
>          pass
>
> -# export common proxies variables from datastore to environment
>  def export_proxies(d):
> +    """ export common proxies variables from datastore to environment """
>      import os
>
>      variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
> --
> 2.7.4
>
>

--0000000000004a9ae005b89edd0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi All,</div><div><br></div><div>Thi=
s is a gentle reminder to review this patch.<br></div><div><div><div dir=3D=
"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><font face=3D"times new roman, serif"><br></=
font></div><div dir=3D"ltr"><font face=3D"times new roman, serif">---------=
--------------<br></font></div><div dir=3D"ltr"><font face=3D"times new rom=
an, serif">Thanks &amp; Regards,</font><div><font face=3D"times new roman, =
serif"><b>Milan Shah</b></font></div><div><span style=3D"background-color:r=
gb(255,255,255)"><font color=3D"#ff0000"><font face=3D"times new roman, ser=
if">MontaVista Software, </font></font></span><span style=3D"background-col=
or:rgb(255,255,255)"><font color=3D"#ff0000"><font face=3D"times new roman,=
 serif"><span style=3D"font-family:&quot;times new roman&quot;,serif">Banga=
lore</span></font><span style=3D"font-family:&quot;times new roman&quot;,se=
rif">, India</span></font></span><br></div></div></div></div></div></div><b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, Jan 5, 2021 at 3:02 PM Milan Shah &lt;<a href=3D"mailto:msh=
ah@mvista.com">mshah@mvista.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">A list of functions that now has a docstri=
ng.<br>
* vercmp_string<br>
* explode_dep_versions<br>
* prunedir<br>
* prune_suffix<br>
* to_boolean<br>
* contains_any<br>
* export_proxies<br>
<br>
See [YOCTO #9725] for details.<br>
<br>
Signed-off-by: Milan Shah &lt;<a href=3D"mailto:mshah@mvista.com" target=3D=
"_blank">mshah@mvista.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/utils.py | 38 ++++++++++++++++++++++++++++++++++----<br>
=C2=A01 file changed, 34 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index f73d31f..5c775bd 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -129,6 +129,7 @@ def vercmp(ta, tb):<br>
=C2=A0 =C2=A0 =C2=A0return r<br>
<br>
=C2=A0def vercmp_string(a, b):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot; Split version strings and compare them &q=
uot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0ta =3D split_version(a)<br>
=C2=A0 =C2=A0 =C2=A0tb =3D split_version(b)<br>
=C2=A0 =C2=A0 =C2=A0return vercmp(ta, tb)<br>
@@ -247,6 +248,12 @@ def explode_dep_versions2(s, *, sort=3DTrue):<br>
=C2=A0 =C2=A0 =C2=A0return r<br>
<br>
=C2=A0def explode_dep_versions(s):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Take an RDEPENDS style string of format:<br>
+=C2=A0 =C2=A0 &quot;DEPEND1 (optional version) DEPEND2 (optional version) =
...&quot;<br>
+=C2=A0 =C2=A0 skip null value and items appeared in dependancy string mult=
iple times<br>
+=C2=A0 =C2=A0 and return a dictionary of dependencies and versions.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0r =3D explode_dep_versions2(s)<br>
=C2=A0 =C2=A0 =C2=A0for d in r:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not r[d]:<br>
@@ -692,7 +699,7 @@ def remove(path, recurse=3DFalse, ionice=3DFalse):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
<br>
=C2=A0def prunedir(topdir, ionice=3DFalse):<br>
-=C2=A0 =C2=A0 # Delete everything reachable from the directory named in &#=
39;topdir&#39;.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot; Delete everything reachable from the dire=
ctory named in &#39;topdir&#39;. &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0# CAUTION:=C2=A0 This is dangerous!<br>
=C2=A0 =C2=A0 =C2=A0if _check_unsafe_delete_path(topdir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&#39;bb.utils.prunedir: c=
alled with dangerous path &quot;%s&quot;, refusing to delete!&#39; % topdir=
)<br>
@@ -703,8 +710,10 @@ def prunedir(topdir, ionice=3DFalse):<br>
=C2=A0# but thats possibly insane and suffixes is probably going to be smal=
l<br>
=C2=A0#<br>
=C2=A0def prune_suffix(var, suffixes, d):<br>
-=C2=A0 =C2=A0 # See if var ends with any of the suffixes listed and<br>
-=C2=A0 =C2=A0 # remove it if found<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot; <br>
+=C2=A0 =C2=A0 See if var ends with any of the suffixes listed and<br>
+=C2=A0 =C2=A0 remove it if found <br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0for suffix in suffixes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if suffix and var.endswith(suffix):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return var[:-len(suffix)]<b=
r>
@@ -956,6 +965,10 @@ def umask(new_mask):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.umask(current_mask)<br>
<br>
=C2=A0def to_boolean(string, default=3DNone):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot; <br>
+=C2=A0 =C2=A0 Check input string and return boolean value True/False/None<=
br>
+=C2=A0 =C2=A0 depending upon the checks <br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0if not string:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return default<br>
<br>
@@ -999,6 +1012,23 @@ def contains(variable, checkvalues, truevalue, falsev=
alue, d):<br>
=C2=A0 =C2=A0 =C2=A0return falsevalue<br>
<br>
=C2=A0def contains_any(variable, checkvalues, truevalue, falsevalue, d):<br=
>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Check if a variable contains any values sp=
ecified.<br>
+<br>
+=C2=A0 =C2=A0 Arguments:<br>
+<br>
+=C2=A0 =C2=A0 variable -- the variable name. This will be fetched and expa=
nded (using<br>
+=C2=A0 =C2=A0 d.getVar(variable)) and then split into a set().<br>
+<br>
+=C2=A0 =C2=A0 checkvalues -- if this is a string it is split on whitespace=
 into a set(),<br>
+=C2=A0 =C2=A0 otherwise coerced directly into a set().<br>
+<br>
+=C2=A0 =C2=A0 truevalue -- the value to return if checkvalues is a subset =
of variable.<br>
+<br>
+=C2=A0 =C2=A0 falsevalue -- the value to return if variable is empty or if=
 checkvalues is<br>
+=C2=A0 =C2=A0 not a subset of variable.<br>
+<br>
+=C2=A0 =C2=A0 d -- the data store.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0val =3D d.getVar(variable)<br>
=C2=A0 =C2=A0 =C2=A0if not val:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return falsevalue<br>
@@ -1560,8 +1590,8 @@ def set_process_name(name):<br>
=C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
-# export common proxies variables from datastore to environment<br>
=C2=A0def export_proxies(d):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot; export common proxies variables from data=
store to environment &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0import os<br>
<br>
=C2=A0 =C2=A0 =C2=A0variables =3D [&#39;http_proxy&#39;, &#39;HTTP_PROXY&#3=
9;, &#39;https_proxy&#39;, &#39;HTTPS_PROXY&#39;,<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div></div>

--0000000000004a9ae005b89edd0d--
