Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3267EC433FE
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 14:55:44 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
 by mx.groups.io with SMTP id smtpd.web09.6291.1668178541387404445
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Nov 2022 06:55:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=jyL8XRM4;
 spf=pass (domain: gmail.com, ip: 209.85.217.50, mailfrom: kergoth@gmail.com)
Received: by mail-vs1-f50.google.com with SMTP id 128so5375559vsz.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0WKteATFezb0uRfG0zMS4bvOYoS3BieBjSrG+HVsGro=;
        b=jyL8XRM4x8tmBqvdwsf3CVyZh7vRzZH5BwuP1lbCrCHdo8s2OzJN4htJq8cvlyxtfW
         p8Ly3x3+S25Hc7LunB+pvBvz6C9oE40De9v6sg//X1/RLc6+t+iQ7iAeoGe+QB6X9zGv
         JsdmWFoHLoinlgAOlKAPRw/JwzpZEJnW7usnLwUNHRI2gJCjTdF+DPVL+PYATEcLIxX/
         +nwoAvARVgAesE/sbX1agEZXZ0Qe6stWBZ/u5xMRyDnSXtqQxg5Zx92aafcGkVHACav4
         fCUqhtCzm4A3B5eFslklM0qvp1Xe11pmHFiCzG++IrbJsEiDG6qZb4thmU25b4OuQz9+
         BG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WKteATFezb0uRfG0zMS4bvOYoS3BieBjSrG+HVsGro=;
        b=DcAeeyknnlYUjSJcWpz1wixLOm29wTaD8hP9EYU7bts6ZGLCq0uFUUS2qgeI63gtXG
         IBL7tpWs6gHnnEmuF9OlhASsr0BqDYSjC9ZnccSrjw9uXyDJ6Ykl8Emt5oaTQLzTo3xL
         Qubz1FOhRUSFM162VWDyTlE/gJxMtmZb/boGABduFkbPIQBHdIPUHUMOtuEPtsL/aq/r
         CvbcCTV1BzLnYMs6dhoI4V9Is8+/0NtZ46KMY4yuOQBCeIpq5JrH6gnx1mp4oI4f9M6x
         GYWKFx8VmlqLc5iAsmtgDWjkWqU0GlJOGh1anykdIZzR+yFf8ExHSF5AEr9LTYzP8cIp
         DzZw==
X-Gm-Message-State: ANoB5plMzv2MD6VTTD0A96MbaT9y/uenqGSFzHRs2m+5QQiaj+lB8pRk
	6DjfxRK1aRO9qyPpKRNl+NNfFyzGO7pSiZOUFlk=
X-Google-Smtp-Source: AA0mqf59wT5rtsrdr7zcsFu9ZGJkrVe36sq0RGz+ReqO5/7tdLGOhPM1bo3mb9FDnc/r/ORU9J5qyHVUCJfwixeX1EY=
X-Received: by 2002:a05:6102:6d6:b0:3ac:40c9:558e with SMTP id
 m22-20020a05610206d600b003ac40c9558emr925874vsg.81.1668178540135; Fri, 11 Nov
 2022 06:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20221111142618.2309492-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221111142618.2309492-1-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 11 Nov 2022 07:55:28 -0700
Message-ID: <CABcZANkqUCXJUDqFa73xtBEK4zYYrMO8oVJ=fAbOwx=p3fZ=Ww@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] data/data_smart/build: Clean up datastore
 finalize/update_data references
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004e8e4205ed3315ec"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 14:55:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14071

--0000000000004e8e4205ed3315ec
Content-Type: text/plain; charset="UTF-8"

Huzzah!

Acked-by: Christopher Larson <chris_larson@mentor.com>

On Fri, Nov 11, 2022 at 7:26 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> We dropped the update_data calls a while ago. Clean up the code
> to match the reality and drop the remaining no-op pieces. Update
> the comments to reflect the slowest operations and let the cookie
> monster's spirit live on!
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/build.py      |  1 -
>  lib/bb/data.py       | 12 +++++-------
>  lib/bb/data_smart.py |  9 +--------
>  3 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index b8c1099ef5..db706d0a3a 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -572,7 +572,6 @@ def _task_data(fn, task, d):
>      localdata.setVar('BB_FILENAME', fn)
>      localdata.setVar('OVERRIDES', 'task-%s:%s' %
>                       (task[3:].replace('_', '-'), d.getVar('OVERRIDES',
> False)))
> -    localdata.finalize()
>      bb.data.expandKeys(localdata)
>      return localdata
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 4be26367d2..3a6af325f4 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -4,14 +4,16 @@ BitBake 'Data' implementations
>  Functions for interacting with the data structure used by the
>  BitBake build tools.
>
> -The expandKeys and update_data are the most expensive
> -operations. At night the cookie monster came by and
> +expandKeys and datastore iteration are the most expensive
> +operations. Updating overrides is now "on the fly" but still based
> +on the idea of the cookie monster introduced by zecke:
> +"At night the cookie monster came by and
>  suggested 'give me cookies on setting the variables and
>  things will work out'. Taking this suggestion into account
>  applying the skills from the not yet passed 'Entwurf und
>  Analyse von Algorithmen' lecture and the cookie
>  monster seems to be right. We will track setVar more carefully
> -to have faster update_data and expandKeys operations.
> +to have faster datastore operations."
>
>  This is a trade-off between speed and memory again but
>  the speed is more critical here.
> @@ -264,10 +266,6 @@ def emit_func_python(func, o=sys.__stdout__, d =
> init()):
>                 newdeps |= set((d.getVarFlag(dep, "vardeps") or
> "").split())
>          newdeps -= seen
>
> -def update_data(d):
> -    """Performs final steps upon the datastore, including application of
> overrides"""
> -    d.finalize(parent = True)
> -
>  def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars,
> d):
>      deps = set()
>      try:
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 62d0c01c41..5415f2fccf 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -481,13 +481,6 @@ class DataSmart(MutableMapping):
>      def expand(self, s, varname = None):
>          return self.expandWithRefs(s, varname).value
>
> -    def finalize(self, parent = False):
> -        return
> -
> -    def internal_finalize(self, parent = False):
> -        """Performs final steps upon the datastore, including application
> of overrides"""
> -        self.overrides = None
> -
>      def need_overrides(self):
>          if self.overrides is not None:
>              return
> @@ -638,7 +631,7 @@ class DataSmart(MutableMapping):
>                  nextnew.update(vardata.references)
>                  nextnew.update(vardata.contains.keys())
>              new = nextnew
> -        self.internal_finalize(True)
> +        self.overrides = None
>
>      def _setvar_update_overrides(self, var, **loginfo):
>          # aka pay the cookie monster
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14070):
> https://lists.openembedded.org/g/bitbake-devel/message/14070
> Mute This Topic: https://lists.openembedded.org/mt/94959431/3617123
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> kergoth@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--0000000000004e8e4205ed3315ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Huzzah!<div><br></div><div>Acked-by: Christopher Larson &l=
t;<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt=
;</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Nov 11, 2022 at 7:26 AM Richard Purdie &lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We d=
ropped the update_data calls a while ago. Clean up the code<br>
to match the reality and drop the remaining no-op pieces. Update<br>
the comments to reflect the slowest operations and let the cookie<br>
monster&#39;s spirit live on!<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/build.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A0lib/bb/data.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++++-------<br>
=C2=A0lib/bb/data_smart.py |=C2=A0 9 +--------<br>
=C2=A03 files changed, 6 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/lib/bb/build.py b/lib/bb/build.py<br>
index b8c1099ef5..db706d0a3a 100644<br>
--- a/lib/bb/build.py<br>
+++ b/lib/bb/build.py<br>
@@ -572,7 +572,6 @@ def _task_data(fn, task, d):<br>
=C2=A0 =C2=A0 =C2=A0localdata.setVar(&#39;BB_FILENAME&#39;, fn)<br>
=C2=A0 =C2=A0 =C2=A0localdata.setVar(&#39;OVERRIDES&#39;, &#39;task-%s:%s&#=
39; %<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (task[3:].replace(&#39;_&#39;, &#39;-&#39;), d.getVar(&#39;OVERRIDES&#3=
9;, False)))<br>
-=C2=A0 =C2=A0 localdata.finalize()<br>
=C2=A0 =C2=A0 =C2=A0bb.data.expandKeys(localdata)<br>
=C2=A0 =C2=A0 =C2=A0return localdata<br>
<br>
diff --git a/lib/bb/data.py b/lib/bb/data.py<br>
index 4be26367d2..3a6af325f4 100644<br>
--- a/lib/bb/data.py<br>
+++ b/lib/bb/data.py<br>
@@ -4,14 +4,16 @@ BitBake &#39;Data&#39; implementations<br>
=C2=A0Functions for interacting with the data structure used by the<br>
=C2=A0BitBake build tools.<br>
<br>
-The expandKeys and update_data are the most expensive<br>
-operations. At night the cookie monster came by and<br>
+expandKeys and datastore iteration are the most expensive<br>
+operations. Updating overrides is now &quot;on the fly&quot; but still bas=
ed<br>
+on the idea of the cookie monster introduced by zecke:<br>
+&quot;At night the cookie monster came by and<br>
=C2=A0suggested &#39;give me cookies on setting the variables and<br>
=C2=A0things will work out&#39;. Taking this suggestion into account<br>
=C2=A0applying the skills from the not yet passed &#39;Entwurf und<br>
=C2=A0Analyse von Algorithmen&#39; lecture and the cookie<br>
=C2=A0monster seems to be right. We will track setVar more carefully<br>
-to have faster update_data and expandKeys operations.<br>
+to have faster datastore operations.&quot;<br>
<br>
=C2=A0This is a trade-off between speed and memory again but<br>
=C2=A0the speed is more critical here.<br>
@@ -264,10 +266,6 @@ def emit_func_python(func, o=3Dsys.__stdout__, d =3D i=
nit()):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newdeps |=3D set((d=
.getVarFlag(dep, &quot;vardeps&quot;) or &quot;&quot;).split())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0newdeps -=3D seen<br>
<br>
-def update_data(d):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Performs final steps upon the datastore, i=
ncluding application of overrides&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 d.finalize(parent =3D True)<br>
-<br>
=C2=A0def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_va=
rs, d):<br>
=C2=A0 =C2=A0 =C2=A0deps =3D set()<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py<br>
index 62d0c01c41..5415f2fccf 100644<br>
--- a/lib/bb/data_smart.py<br>
+++ b/lib/bb/data_smart.py<br>
@@ -481,13 +481,6 @@ class DataSmart(MutableMapping):<br>
=C2=A0 =C2=A0 =C2=A0def expand(self, s, varname =3D None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.expandWithRefs(s, varname).va=
lue<br>
<br>
-=C2=A0 =C2=A0 def finalize(self, parent =3D False):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
-<br>
-=C2=A0 =C2=A0 def internal_finalize(self, parent =3D False):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Performs final steps upon th=
e datastore, including application of overrides&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.overrides =3D None<br>
-<br>
=C2=A0 =C2=A0 =C2=A0def need_overrides(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.overrides is not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
@@ -638,7 +631,7 @@ class DataSmart(MutableMapping):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nextnew.updat=
e(vardata.references)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nextnew.updat=
e(vardata.contains.keys())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new =3D nextnew<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.internal_finalize(True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.overrides =3D None<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _setvar_update_overrides(self, var, **loginfo):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# aka pay the cookie monster<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14070): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14070" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14070</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/94959431/3617=
123" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/94959431/3617123</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:kergoth@gmail.com" target=3D"_blan=
k">kergoth@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><font color=3D=
"#333333">Christopher Larson<br><a>chris_larson@mentor.com</a>,=C2=A0<a>chr=
is.larson@siemens.com</a>,=C2=A0<a>kergoth@gmail.com</a><br>Principal Softw=
are Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemens Digital Industrie=
s Software</font><br></div></div></div>

--0000000000004e8e4205ed3315ec--

