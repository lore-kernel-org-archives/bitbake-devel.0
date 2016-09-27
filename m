Return-Path: <gmstima@gmail.com>
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com
	[209.85.213.53])
	by mail.openembedded.org (Postfix) with ESMTP id 36C4A60234
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 10:24:35 +0000 (UTC)
Received: by mail-vk0-f53.google.com with SMTP id 192so8659318vkl.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=p8IIlnw9yHksBEol9Y12JTHjrERv52ILIB9i9h5fNME=;
	b=TlPsmSpeJV+mhiWB2nMCZwSpQuleYDoSlyR6LooSZL9P2BN96NTSl3PLwpF2H1pzF2
	l6dSZKAKZ1+OdrUU7wcAQPFVOtdFfK+FWCSXOEEkIzboEt1UlYLZYKnJ9oVsaMf4gC75
	HxNc7AyqDt5eqQtgzjecYQRnv/yu17AsmpmFePob0zonNdrBh6C7Gxte39rBFj1DNu7O
	QJoty8PYOXfSvC5uR4xUUIWttBvR9nl+uz0gQjKmYrJ0HJCZjAdxiGSRcqmXhCNO1D4w
	KFz4VjAKAWwzcicttHbEmUyco/qIsJlt3MM5LulrWb3co2FMUTzTo8qxykfweeYZIR/m
	jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=p8IIlnw9yHksBEol9Y12JTHjrERv52ILIB9i9h5fNME=;
	b=ZsEcbxrHTASu8okY/Hjf4POscP0gwl9Jo1TT9mXb/Gn6UEBVXln0AtSYXrzgX6JEdX
	nCNqV3jmn53Lb/1eQLInHFkkaWxjCXFvf4TQFACHfjnVbKP2MwM3OPLpWo9pIxpNTTYy
	nuvjqLZUMra30YJ1N/946MdFqFDplYrxtFKzo7l4b/OfcQcSXG1AxBlYPmT33rRbEoGG
	cpG7cKLeNJSyzIiGNwhVuUGgco/d8kTxzHixz8vlf12LJhDmpZpRLUDOhy5rBNWW4uVx
	tAfQJch1sK0yIhEeSn1CJ8Au1JhCuwye0fWrLFDLZgCf1KE1+2ldxJG/kLmM8S8VK4fi
	+O2g==
X-Gm-Message-State: AA6/9RkFY7djY4Awe1UctMbQrKTRIjpFRwE4RNP/cCJ85/gFUU1RUrbbTknR3nJKdn3Mt2dPYHgmyHcWqcwxAA==
X-Received: by 10.31.72.135 with SMTP id v129mr10406758vka.160.1474971876574; 
	Tue, 27 Sep 2016 03:24:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.65.132 with HTTP; Tue, 27 Sep 2016 03:24:36 -0700 (PDT)
In-Reply-To: <1474971767-30806-1-git-send-email-gmstima@gmail.com>
References: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
	<1474971767-30806-1-git-send-email-gmstima@gmail.com>
From: Roman Savchenko <gmstima@gmail.com>
Date: Tue, 27 Sep 2016 13:24:36 +0300
Message-ID: <CAGpdKUKcORhhTM79eKSXL6qeR5T9QTqHP1yPe7YynDVjSqqeYA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: Correct broken symlink behaviour
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
X-List-Received-Date: Tue, 27 Sep 2016 10:24:38 -0000
Content-Type: multipart/alternative; boundary=001a114e6c58c1cca4053d7aa66f

--001a114e6c58c1cca4053d7aa66f
Content-Type: text/plain; charset=UTF-8

Hi Richard,

I renamed function, probably name is a little bit long, but it fully
displays what it does.

Regards,
Roman.

2016-09-27 13:22 GMT+03:00 Roman Savchenko <gmstima@gmail.com>:

> From: Roman Savchenko <roman.savchenko@attocapital.com>
>
> When making new symlink in case when link name does not exist
> possible broken symlink behaviour should be taken into account.
>
> Signed-off-by: Roman Savchenko <gmstima@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__
> init__.py
> index 6ef0c6f..6638b34 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):
>      bb.utils.movefile(ud.localpath, new_localpath)
>
>
> +def create_symlink_if_not_exist(source, link_name):
> +    """
> +    Tries to make link to passed source if link name does not
> +    exist or it is the invalid symlink.
> +    """
> +    if not os.path.exists(link_name):
> +        if os.path.islink(link_name):
> +            os.unlink(link_name)
> +
> +        os.symlink(source, link_name)
> +
>  def try_mirror_url(fetch, origud, ud, ld, check = False):
>      # Return of None or a value means we're finished
>      # False means try another url
> @@ -962,20 +973,14 @@ def try_mirror_url(fetch, origud, ud, ld, check =
> False):
>                  bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
>                  open(ud.donestamp, 'w').close()
>              dest = os.path.join(dldir, os.path.basename(ud.localpath))
> -            if not os.path.exists(dest):
> -                os.symlink(ud.localpath, dest)
> +            create_symlink_if_not_exist(ud.localpath, dest)
>              if not verify_donestamp(origud, ld) or
> origud.method.need_update(origud, ld):
>                  origud.method.download(origud, ld)
>                  if hasattr(origud.method,"build_mirror_data"):
>                      origud.method.build_mirror_data(origud, ld)
>              return origud.localpath
>          # Otherwise the result is a local file:// and we symlink to it
> -        if not os.path.exists(origud.localpath):
> -            if os.path.islink(origud.localpath):
> -                # Broken symbolic link
> -                os.unlink(origud.localpath)
> -
> -            os.symlink(ud.localpath, origud.localpath)
> +        create_symlink_if_not_exist(ud.localpath, origud.localpath)
>          update_stamp(origud, ld)
>          return ud.localpath
>
> --
> 2.7.4
>
>

--001a114e6c58c1cca4053d7aa66f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Richard,<br><br></div>I renamed function=
, probably name is a little bit long, but it fully displays what it does.<b=
r><br></div>Regards,<br></div>Roman.<br></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">2016-09-27 13:22 GMT+03:00 Roman Savchenko <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:gmstima@gmail.com" target=3D"_blank">g=
mstima@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">From: Roman Savchenko &lt;<a href=3D"mailto:roman.savchenko@attoca=
pital.com">roman.savchenko@attocapital.<wbr>com</a>&gt;<br>
<br>
When making new symlink in case when link name does not exist<br>
possible broken symlink behaviour should be taken into account.<br>
<br>
</span><span class=3D"">Signed-off-by: Roman Savchenko &lt;<a href=3D"mailt=
o:gmstima@gmail.com">gmstima@gmail.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/__init__<wbr>.py | 21 +++++++++++++--------<br>
=C2=A01 file changed, 13 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/__<wbr>init__.py b/bitbake/lib/bb/fetch2=
/__<wbr>init__.py<br>
</span>index 6ef0c6f..6638b34 100644<br>
<span class=3D"">--- a/bitbake/lib/bb/fetch2/__<wbr>init__.py<br>
+++ b/bitbake/lib/bb/fetch2/__<wbr>init__.py<br>
@@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):<br>
=C2=A0 =C2=A0 =C2=A0bb.utils.movefile(ud.<wbr>localpath, new_localpath)<br>
<br>
<br>
</span>+def create_symlink_if_not_exist(<wbr>source, link_name):<br>
<span class=3D"">+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Tries to make link to passed source if link name does not<br=
>
</span>+=C2=A0 =C2=A0 exist or it is the invalid symlink.<br>
<span class=3D"">+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if not os.path.exists(link_name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.islink(link_name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(link_name)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(source, link_name)<br>
+<br>
=C2=A0def try_mirror_url(fetch, origud, ud, ld, check =3D False):<br>
=C2=A0 =C2=A0 =C2=A0# Return of None or a value means we&#39;re finished<br=
>
=C2=A0 =C2=A0 =C2=A0# False means try another url<br>
@@ -962,20 +973,14 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.mkdi=
rhier(os.path.<wbr>dirname(ud.donestamp))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open(ud.dones=
tamp, &#39;w&#39;).close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest =3D os.path.join(dldir=
, os.path.basename(ud.localpath)<wbr>)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(dest):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(ud.loca=
lpath, dest)<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_symlink_if_not_exi=
st(<wbr>ud.localpath, dest)<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ver=
ify_donestamp(origud, ld) or origud.method.need_update(<wbr>origud, ld):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0origud.method=
.download(origud, ld)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if hasattr(or=
igud.method,&quot;build_<wbr>mirror_data&quot;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0origud.method.build_mirror_<wbr>data(origud, ld)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return origud.localpath<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Otherwise the result is a local file://=
 and we symlink to it<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(origud.<wbr>localpath):<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.islink(origud.<wbr>lo=
calpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Broken symbolic =
link<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(origud.l=
ocalpath)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(ud.localpath, origud.=
localpath)<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_symlink_if_not_exist(<wbr>ud.loc=
alpath, origud.localpath)<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
pdate_stamp(origud, ld)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.localpath<br>
<br>
--<br>
2.7.4<br>
<br>
</div></div></blockquote></div><br></div>

--001a114e6c58c1cca4053d7aa66f--
