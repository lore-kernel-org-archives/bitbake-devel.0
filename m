Return-Path: <sujith.h@gmail.com>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
	[209.85.220.175])
	by mail.openembedded.org (Postfix) with ESMTP id 67DB270016
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 11:01:16 +0000 (UTC)
Received: by mail-qk0-f175.google.com with SMTP id h8so78958027qka.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=mNw+hhwVW+hoq6LwoD82fpcoaGFYseNOVkDqT7Htq8s=;
	b=uNrNlIiUz3ztwG7jpEoOxwG1Y4a9SHOVKf5u1WdGmYJpE+5FCs8lUAT/sYkzGui/q/
	6ojuOh3WCfhagoh8JV76Qgq/Pe5uUP6dg2vPP5RyPVrMJH/tvWUxa8ASsRTEo7VQttLU
	w42f0zrrzOWAkqNtzK0LB8zF4fvtOO5K+NE9N32JpfJ/ZEfEgV+7OLmwQ0MNEm751a0p
	6GQQKDG/xjBp49rJi3NFpI9cWQYk77qCIi4kwbE5J7unklSzcDglLKLkc7yirx/b2Gec
	bpA1ogj5erj/vuI8knaOR1eqVjUeE+Bh8YDgcmf9fgGvfQIGj4Ife2OrFXVFfNh0Y2oI
	xHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=mNw+hhwVW+hoq6LwoD82fpcoaGFYseNOVkDqT7Htq8s=;
	b=VARe5sqT9ZvGay0YJLIuKgUl5EvvGmXy6+qFTArw+SmYrIQWkkKZya0CIpztSY2+Aw
	xID3R+iihM+h272uU7rHEJu+kyTLnkoDkyu99+GNq4ve6IcCrjg5VxOQdAJAPRfY+4Af
	PBs+5+l7PeRonIpdFXq4Wf/9PkS7791ynhiWW6EgbuC3ameNTLlP5A+i3xFyuh/YGEqy
	jxSLmiQM7/DnILqJ7HPOArJ8gN41MIOHNkytu/rwxEmso5FA4cS6K1wWZzPnaoXt/3Rp
	hbKHTzPjAnXFwAMidP4U5SyETUFh/QtjXwwh9xZ7SCSipzCdMXreVcr7VbgbjTJTLJye
	BHVw==
X-Gm-Message-State: AE9vXwO+8B7Ey1Q6AR/DQwaSOYEhiNlgHkFfVgmVdF0JMI0OjALGpA16UkTd1/Abf+Pg4jrP03/HvtRx29Evbw==
X-Received: by 10.55.168.78 with SMTP id r75mr14697480qke.19.1474023677496;
	Fri, 16 Sep 2016 04:01:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.183.1 with HTTP; Fri, 16 Sep 2016 04:00:57 -0700 (PDT)
In-Reply-To: <1471880556-9232-8-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
	<1471880556-9232-8-git-send-email-elliot.smith@intel.com>
From: sujith h <sujith.h@gmail.com>
Date: Fri, 16 Sep 2016 16:30:57 +0530
Message-ID: <CADyYWLnZVn2+yB-zPb8bOqRA=EtN3ssc9ZBZPP7FF58kGOkf7A@mail.gmail.com>
To: Elliot Smith <elliot.smith@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 8/9] toaster: Allow git information to be null for BRLayer
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
X-List-Received-Date: Fri, 16 Sep 2016 11:01:17 -0000
Content-Type: multipart/alternative; boundary=94eb2c07514cb016d4053c9de1af

--94eb2c07514cb016d4053c9de1af
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Seems like the migration changes are not merged upstream. Only models
changes are there.

Thanks,
Sujith H

On Mon, Aug 22, 2016 at 9:12 PM, Elliot Smith <elliot.smith@intel.com>
wrote:

> From: Michael Wood <michael.g.wood@intel.com>
>
> We no longer only deal with layers that have their source in a gir
> repository, we also allow for local directories too so update the
> BRLayer model to reflect this.
>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  .../migrations/0007_brlayers_optional_gitinfo.py   | 29
> ++++++++++++++++++++++
>  bitbake/lib/toaster/bldcontrol/models.py           | 11 ++++----
>  2 files changed, 35 insertions(+), 5 deletions(-)
>  create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0007_
> brlayers_optional_gitinfo.py
>
> diff --git a/bitbake/lib/toaster/bldcontrol/migrations/0007_brlayers_opti=
onal_gitinfo.py
> b/bitbake/lib/toaster/bldcontrol/migrations/0007_
> brlayers_optional_gitinfo.py
> new file mode 100644
> index 0000000..4be42a4
> --- /dev/null
> +++ b/bitbake/lib/toaster/bldcontrol/migrations/0007_
> brlayers_optional_gitinfo.py
> @@ -0,0 +1,29 @@
> +# -*- coding: utf-8 -*-
> +from __future__ import unicode_literals
> +
> +from django.db import migrations, models
> +
> +
> +class Migration(migrations.Migration):
> +
> +    dependencies =3D [
> +        ('bldcontrol', '0006_brlayer_local_source_dir'),
> +    ]
> +
> +    operations =3D [
> +        migrations.AlterField(
> +            model_name=3D'brlayer',
> +            name=3D'commit',
> +            field=3Dmodels.CharField(max_length=3D254, null=3DTrue),
> +        ),
> +        migrations.AlterField(
> +            model_name=3D'brlayer',
> +            name=3D'dirpath',
> +            field=3Dmodels.CharField(max_length=3D254, null=3DTrue),
> +        ),
> +        migrations.AlterField(
> +            model_name=3D'brlayer',
> +            name=3D'giturl',
> +            field=3Dmodels.CharField(max_length=3D254, null=3DTrue),
> +        ),
> +    ]
> diff --git a/bitbake/lib/toaster/bldcontrol/models.py
> b/bitbake/lib/toaster/bldcontrol/models.py
> index 83b6969..409614b 100644
> --- a/bitbake/lib/toaster/bldcontrol/models.py
> +++ b/bitbake/lib/toaster/bldcontrol/models.py
> @@ -126,13 +126,14 @@ class BuildRequest(models.Model):
>  # These tables specify the settings for running an actual build.
>  # They MUST be kept in sync with the tables in orm.models.Project*
>
> +
>  class BRLayer(models.Model):
> -    req         =3D models.ForeignKey(BuildRequest)
> -    name        =3D models.CharField(max_length =3D 100)
> -    giturl      =3D models.CharField(max_length =3D 254)
> +    req =3D models.ForeignKey(BuildRequest)
> +    name =3D models.CharField(max_length=3D100)
> +    giturl =3D models.CharField(max_length=3D254, null=3DTrue)
>      local_source_dir =3D models.CharField(max_length=3D254, null=3DTrue)
> -    commit      =3D models.CharField(max_length =3D 254)
> -    dirpath     =3D models.CharField(max_length =3D 254)
> +    commit =3D models.CharField(max_length=3D254, null=3DTrue)
> +    dirpath =3D models.CharField(max_length=3D254, null=3DTrue)
>      layer_version =3D models.ForeignKey(Layer_Version, null=3DTrue)
>
>  class BRBitbake(models.Model):
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



--=20
=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=B5=8D =E0=B4=B9=E0=B4=B0=
=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=B5=8D
Bangalore
<Project>Contributor to KDE project
<Project>Contributor to Yocto project
http://fci.wikia.com/wiki/Anti-DRM-Campaign
<Blog> http://sujithh.info
C-x C-c

--94eb2c07514cb016d4053c9de1af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>Seems like the migration c=
hanges are not merged upstream. Only models changes are there.<br><br></div=
>Thanks,<br></div>Sujith H<br><div><div><div><div><div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Mon, Aug 22, 2016 at 9:12 PM, Elli=
ot Smith <span dir=3D"ltr">&lt;<a href=3D"mailto:elliot.smith@intel.com" ta=
rget=3D"_blank">elliot.smith@intel.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">From: Michael Wood &lt;<a href=3D"mailto:michael.g.wood=
@intel.com">michael.g.wood@intel.com</a>&gt;<br>
<br>
We no longer only deal with layers that have their source in a gir<br>
repository, we also allow for local directories too so update the<br>
BRLayer model to reflect this.<br>
<br>
Signed-off-by: Michael Wood &lt;<a href=3D"mailto:michael.g.wood@intel.com"=
>michael.g.wood@intel.com</a>&gt;<br>
Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.com">e=
lliot.smith@intel.com</a>&gt;<br>
---<br>
=C2=A0.../migrations/0007_brlayers_<wbr>optional_gitinfo.py=C2=A0 =C2=A0| 2=
9 ++++++++++++++++++++++<br>
=C2=A0bitbake/lib/toaster/<wbr>bldcontrol/models.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 11 ++++----<br>
=C2=A02 files changed, 35 insertions(+), 5 deletions(-)<br>
=C2=A0create mode 100644 bitbake/lib/toaster/<wbr>bldcontrol/migrations/000=
7_<wbr>brlayers_optional_gitinfo.py<br>
<br>
diff --git a/bitbake/lib/toaster/<wbr>bldcontrol/migrations/0007_<wbr>brlay=
ers_optional_gitinfo.py b/bitbake/lib/toaster/<wbr>bldcontrol/migrations/00=
07_<wbr>brlayers_optional_gitinfo.py<br>
new file mode 100644<br>
index 0000000..4be42a4<br>
--- /dev/null<br>
+++ b/bitbake/lib/toaster/<wbr>bldcontrol/migrations/0007_<wbr>brlayers_opt=
ional_gitinfo.py<br>
@@ -0,0 +1,29 @@<br>
+# -*- coding: utf-8 -*-<br>
+from __future__ import unicode_literals<br>
+<br>
+from django.db import migrations, models<br>
+<br>
+<br>
+class Migration(migrations.<wbr>Migration):<br>
+<br>
+=C2=A0 =C2=A0 dependencies =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (&#39;bldcontrol&#39;, &#39;0006_brlayer_local=
_source_<wbr>dir&#39;),<br>
+=C2=A0 =C2=A0 ]<br>
+<br>
+=C2=A0 =C2=A0 operations =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrations.AlterField(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 model_name=3D&#39;brlayer&#39;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&#39;commit&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field=3Dmodels.CharField(max_<wb=
r>length=3D254, null=3DTrue),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrations.AlterField(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 model_name=3D&#39;brlayer&#39;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&#39;dirpath&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field=3Dmodels.CharField(max_<wb=
r>length=3D254, null=3DTrue),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrations.AlterField(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 model_name=3D&#39;brlayer&#39;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D&#39;giturl&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field=3Dmodels.CharField(max_<wb=
r>length=3D254, null=3DTrue),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 ]<br>
diff --git a/bitbake/lib/toaster/<wbr>bldcontrol/models.py b/bitbake/lib/to=
aster/<wbr>bldcontrol/models.py<br>
index 83b6969..409614b 100644<br>
--- a/bitbake/lib/toaster/<wbr>bldcontrol/models.py<br>
+++ b/bitbake/lib/toaster/<wbr>bldcontrol/models.py<br>
@@ -126,13 +126,14 @@ class BuildRequest(models.Model):<br>
=C2=A0# These tables specify the settings for running an actual build.<br>
=C2=A0# They MUST be kept in sync with the tables in orm.models.Project*<br=
>
<br>
+<br>
=C2=A0class BRLayer(models.Model):<br>
-=C2=A0 =C2=A0 req=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D models.ForeignKey(<=
wbr>BuildRequest)<br>
-=C2=A0 =C2=A0 name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D models.CharField(max_len=
gth =3D 100)<br>
-=C2=A0 =C2=A0 giturl=C2=A0 =C2=A0 =C2=A0 =3D models.CharField(max_length =
=3D 254)<br>
+=C2=A0 =C2=A0 req =3D models.ForeignKey(<wbr>BuildRequest)<br>
+=C2=A0 =C2=A0 name =3D models.CharField(max_length=3D<wbr>100)<br>
+=C2=A0 =C2=A0 giturl =3D models.CharField(max_length=3D<wbr>254, null=3DTr=
ue)<br>
=C2=A0 =C2=A0 =C2=A0local_source_dir =3D models.CharField(max_length=3D<wbr=
>254, null=3DTrue)<br>
-=C2=A0 =C2=A0 commit=C2=A0 =C2=A0 =C2=A0 =3D models.CharField(max_length =
=3D 254)<br>
-=C2=A0 =C2=A0 dirpath=C2=A0 =C2=A0 =C2=A0=3D models.CharField(max_length =
=3D 254)<br>
+=C2=A0 =C2=A0 commit =3D models.CharField(max_length=3D<wbr>254, null=3DTr=
ue)<br>
+=C2=A0 =C2=A0 dirpath =3D models.CharField(max_length=3D<wbr>254, null=3DT=
rue)<br>
=C2=A0 =C2=A0 =C2=A0layer_version =3D models.ForeignKey(Layer_<wbr>Version,=
 null=3DTrue)<br>
<br>
=C2=A0class BRBitbake(models.Model):<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.7.4<br>
<br>
--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div><div dir=3D"ltr"><div>=E0=B4=B8=E0=B5=81=E0=B4=9C=E0=B4=BF=E0=B4=A4=E0=
=B5=8D =E0=B4=B9=E0=B4=B0=E0=B4=BF=E0=B4=A6=E0=B4=BE=E0=B4=B8=E0=B4=A8=E0=
=B5=8D<br>Bangalore<br>&lt;Project&gt;Contributor to KDE project<br></div><=
div>&lt;Project&gt;Contributor to Yocto project<br></div><div><a href=3D"ht=
tp://fci.wikia.com/wiki/Anti-DRM-Campaign" target=3D"_blank">http://fci.wik=
ia.com/wiki/Anti-DRM-Campaign</a><br>&lt;Blog&gt; <a href=3D"http://sujithh=
.info" target=3D"_blank">http://sujithh.info</a><br></div><div>C-x C-c<br><=
/div></div></div></div></div>
</div></div></div></div></div></div></div>

--94eb2c07514cb016d4053c9de1af--
