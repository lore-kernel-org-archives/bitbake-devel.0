Return-Path: <gmstima@gmail.com>
Received: from mail-ua0-f195.google.com (mail-ua0-f195.google.com
	[209.85.217.195])
	by mail.openembedded.org (Postfix) with ESMTP id 0D39560778
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 07:55:09 +0000 (UTC)
Received: by mail-ua0-f195.google.com with SMTP id 15so1122713uai.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=MVC14pc5POKjWE4z1GEkUuxUtLs6ORDFQV4HScxD+rU=;
	b=t6xNjoNxIh9QIbSBk1lNu2lHCEeWtpkc/xZNX6Zf3u01pdhvEcxAxC779rDy37ehat
	yObzcvb48TpewvFXxlS/GSXwXXbl5qEcnzDxvSePvwllhOVDEdbV5TcyCJa6+96QEFAQ
	keStYMVG8P4VLv0hoKP80VUWtT2hxlVrhsRB7hFlDdZ5+EkxnZ/f1TH9vnCmAFz5f060
	JJjWiEIZt+4OfOWzAWZo2A6tCIO+aE8hJE7Czd5CetdHUKk84y9q6Pp8WhwfxGySkmZN
	6oKnF48a6G8JDGW1U5AsmohfnX2QGjstjAyRwDrLHe58WX+Es5Fuk5it+3tqkJFNcNTz
	st0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=MVC14pc5POKjWE4z1GEkUuxUtLs6ORDFQV4HScxD+rU=;
	b=Sn0pBltS92J5pEqTLA1dtw1ZQBfwn8W9KX1Kbc9A4n2hveF5qTZDcWf/WJveIfVycG
	x/4T1G+RomoNC9jAkrAgwrrtSixoDkheLx2G+NoS2yVeOegTjIpDcVaLmPgBDnR7gHPp
	UM0r7k9FoBRAsO9sRPCNtN4j8+9+KqJiylNaorvl0OSBCledSez/gNEdXlX5YD4Q6Txe
	14S38evFP8d2A/4jbfktwd+m1ixfiDRAbt91KxqAkOnt/ej7FZgoYHIKOcsG9/u/Z4Ub
	i9ZMQARzMSV9aueBmlY/pBFWBzcNoM7Ugx0189fShwYDoJCUdSNOTeuMHshu0N2NjZMq
	0PhA==
X-Gm-Message-State: AE9vXwMZgKvjLcNmHq1srQJsu1WQTjh+IFscrkZsfpry6483Ki13dNNTmnsIM8nkPTsTPgy9FpX5mCooIRAubA==
X-Received: by 10.176.5.193 with SMTP id e59mr3316051uae.116.1474617310451;
	Fri, 23 Sep 2016 00:55:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.33.226 with HTTP; Fri, 23 Sep 2016 00:55:10 -0700 (PDT)
In-Reply-To: <1474616753-26510-1-git-send-email-gmstima@gmail.com>
References: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
	<1474616753-26510-1-git-send-email-gmstima@gmail.com>
From: Roman Savchenko <gmstima@gmail.com>
Date: Fri, 23 Sep 2016 10:55:10 +0300
Message-ID: <CAGpdKUJ0sctyDhyzSQq3wBCSG3T5ioRETApT7OzdvAvV4U5Xhg@mail.gmail.com>
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
X-List-Received-Date: Fri, 23 Sep 2016 07:55:14 -0000
Content-Type: multipart/alternative; boundary=94eb2c123396f81efd053d2818f0

--94eb2c123396f81efd053d2818f0
Content-Type: text/plain; charset=UTF-8

Hi Richard,

I adjusted commit message and function description. but I do not agree with
proposed
function name `create_valid_symlink`, becasue link creation could fail - so
I left `try_symlink`
to point this behaviour.

Regards,
Roman

2016-09-23 10:45 GMT+03:00 Roman Savchenko <gmstima@gmail.com>:

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
> index 6ef0c6f..d8a3b96 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):
>      bb.utils.movefile(ud.localpath, new_localpath)
>
>
> +def try_symlink(source, link_name):
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
> +            try_symlink(ud.localpath, dest)
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
> +        try_symlink(ud.localpath, origud.localpath)
>          update_stamp(origud, ld)
>          return ud.localpath
>
> --
> 2.7.4
>
>

--94eb2c123396f81efd053d2818f0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Richard,<br><br></div>I adjusted commit messa=
ge and function description. <span class=3D"gmail-short_text" id=3D"gmail-r=
esult_box" lang=3D"en"><span>but I do not</span> <span>agree with</span> <s=
pan class=3D"gmail-">proposed</span><br>function <span class=3D"gmail-">nam=
e</span></span> `create_valid_symlink`, becasue link creation could fail - =
so I left `try_symlink`<br></div>to point this behaviour.<br><div><br></div=
><div>Regards,<br></div><div>Roman<br></div></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">2016-09-23 10:45 GMT+03:00 Roman Savchenko=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gmstima@gmail.com" target=3D"_blan=
k">gmstima@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From=
: Roman Savchenko &lt;<a href=3D"mailto:roman.savchenko@attocapital.com">ro=
man.savchenko@attocapital.<wbr>com</a>&gt;<br>
<br>
When making new symlink in case when link name does not exist<br>
possible broken symlink behaviour should be taken into account.<br>
<span class=3D""><br>
Signed-off-by: Roman Savchenko &lt;<a href=3D"mailto:gmstima@gmail.com">gms=
tima@gmail.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/__init__<wbr>.py | 21 +++++++++++++--------<br>
=C2=A01 file changed, 13 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/__<wbr>init__.py b/bitbake/lib/bb/fetch2=
/__<wbr>init__.py<br>
</span>index 6ef0c6f..d8a3b96 100644<br>
<span class=3D"">--- a/bitbake/lib/bb/fetch2/__<wbr>init__.py<br>
+++ b/bitbake/lib/bb/fetch2/__<wbr>init__.py<br>
@@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):<br>
=C2=A0 =C2=A0 =C2=A0bb.utils.movefile(ud.<wbr>localpath, new_localpath)<br>
<br>
<br>
+def try_symlink(source, link_name):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Tries to make link to passed source if link name does not<br=
>
</span>+=C2=A0 =C2=A0 exist or it is the invalid symlink.<br>
<div class=3D"HOEnZb"><div class=3D"h5">+=C2=A0 =C2=A0 &quot;&quot;&quot;<b=
r>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try_symlink(ud.localpath, dest)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not verify_donestamp(ori=
gud, ld) or origud.method.need_update(<wbr>origud, ld):<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try_symlink(ud.localpath, origud.localpath)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_stamp(origud, ld)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.localpath<br>
<br>
--<br>
2.7.4<br>
<br>
</div></div></blockquote></div><br></div>

--94eb2c123396f81efd053d2818f0--
