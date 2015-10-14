Return-Path: <elliot.smith@intel.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 392D473CBD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 09:15:33 +0000 (UTC)
Received: by igbni9 with SMTP id ni9so74969120igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 02:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=3pr+fyPeYcBJVZv0Aw/57NZOZ1PDr0aub+i3+8pYiZw=;
	b=TD5ANj/50mHZFa8G/jd7Rdxc3+dyR57nyQh+tUD8QckXMokZRYBAF30fpK30FK5m8f
	fqfWZKsB9LzR2Cpn1RYmdWGjwsdyFMLzb9MUZ6+w9JF5iKbN7vPoeclbUT75Ih1JJ41R
	atHFTs2PW+AvB1IRgWY+jr/USIY9zSkluEDYbdj/fzlxCPx5ipL1RWomQ9V8bycuEbmi
	XqhmsulZ/Vl0XdYZSbhdGedNewfcYPwbgf33OqkMJnVMkc0Aobua8LYwOuNUOr+kq/to
	XAuj3M+qTsrU8gee4uoFwdxlRk9tOreFvuNQIGO0DvI4P7dKbIRecqdBnckJwIgjehp6
	mTAQ==
X-Gm-Message-State: ALoCoQnyZrV/OPYU1USStWxbzM8RJqxhIeQTRTrBqN8IOqb8LF6zf3O/C8dzW8WvwEaavOtcBu4e
MIME-Version: 1.0
X-Received: by 10.50.4.65 with SMTP id i1mr2733538igi.0.1444814134021; Wed, 14
	Oct 2015 02:15:34 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Wed, 14 Oct 2015 02:15:33 -0700 (PDT)
In-Reply-To: <1444813752-27425-1-git-send-email-elliot.smith@intel.com>
References: <1444813752-27425-1-git-send-email-elliot.smith@intel.com>
Date: Wed, 14 Oct 2015 10:15:33 +0100
Message-ID: <CA+1hgUg17ZW7SGhJMO8=PgsJgKqNWJs9uA_oOg_mJFqtoYQHAg@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: buildinfohelper Detect command line builds
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
X-List-Received-Date: Wed, 14 Oct 2015 09:15:36 -0000
Content-Type: multipart/alternative; boundary=001a11c2a3a039f5ad05220d01d6

--001a11c2a3a039f5ad05220d01d6
Content-Type: text/plain; charset=UTF-8

On 14 October 2015 at 10:09, Elliot Smith <elliot.smith@intel.com> wrote:

> From: Michael Wood <michael.g.wood@intel.com>
>
> When we're building using toaster as just a listener to bitbake
> (analysis mode) we need to handle the case where the toaster configuration
> data
> isn't present so we don't need to try and update the existing information.
>

I submitted this upstream as was (I decided toaster is probably OK as a
subject), and have added it to toaster-next.

Elliot


>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  bitbake/lib/bb/ui/buildinfohelper.py | 34
> ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/buildinfohelper.py
> b/bitbake/lib/bb/ui/buildinfohelper.py
> index 2d76403..a8c884d 100644
> --- a/bitbake/lib/bb/ui/buildinfohelper.py
> +++ b/bitbake/lib/bb/ui/buildinfohelper.py
> @@ -298,9 +298,13 @@ class ORMWrapper(object):
>                  break
>
>
> -
> -        if created and must_exist:
> -            raise NotExisting("Recipe object created when expected to
> exist", recipe_information)
> +        # If we're in analysis mode then we are wholly responsible for
> the data
> +        # and therefore we return the 'real' recipe rather than the build
> +        # history copy of the recipe.
> +        if  recipe_information['layer_version'].build is not None and \
> +            recipe_information['layer_version'].build.project == \
> +                Project.objects.get_default_project():
> +            return recipe
>
>          return built_recipe
>
> @@ -333,14 +337,20 @@ class ORMWrapper(object):
>          assert 'priority' in layer_version_information
>          assert 'local_path' in layer_version_information
>
> +        # If we're doing a command line build then associate this new
> layer with the
> +        # project to avoid it 'contaminating' toaster data
> +        project = None
> +        if build_obj.project == Project.objects.get_default_project():
> +            project = build_obj.project
> +
>          layer_version_object, _ = Layer_Version.objects.get_or_create(
> -                                    build = build_obj,
> -                                    layer = layer_obj,
> -                                    branch =
> layer_version_information['branch'],
> -                                    commit =
> layer_version_information['commit'],
> -                                    priority =
> layer_version_information['priority'],
> -                                    local_path =
> layer_version_information['local_path'],
> -                                    )
> +                                  build = build_obj,
> +                                  layer = layer_obj,
> +                                  branch =
> layer_version_information['branch'],
> +                                  commit =
> layer_version_information['commit'],
> +                                  priority =
> layer_version_information['priority'],
> +                                  local_path =
> layer_version_information['local_path'],
> +                                  project=project)
>
>          self.layer_version_objects.append(layer_version_object)
>
> @@ -845,7 +855,7 @@ class BuildInfoHelper(object):
>          logger.warn("Could not match layer version for recipe path %s :
> %s", path, self.orm_wrapper.layer_version_objects)
>
>          #mockup the new layer
> -        unknown_layer, _ =
> Layer.objects.get_or_create(name="__FIXME__unidentified_layer",
> layer_index_url="")
> +        unknown_layer, _ = Layer.objects.get_or_create(name="Unidentified
> layer", layer_index_url="")
>          unknown_layer_version_obj, _ =
> Layer_Version.objects.get_or_create(layer = unknown_layer, build =
> self.internal_state['build'])
>
>          # append it so we don't run into this error again and again
> @@ -1067,7 +1077,7 @@ class BuildInfoHelper(object):
>              task_information['disk_io'] = taskstats['disk_io']
>              if 'elapsed_time' in taskstats:
>                  task_information['elapsed_time'] =
> taskstats['elapsed_time']
> -            self.orm_wrapper.get_update_task_object(task_information,
> True)  # must exist
> +            self.orm_wrapper.get_update_task_object(task_information)
>
>      def update_and_store_task(self, event):
>          assert 'taskfile' in vars(event)
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
>


-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a11c2a3a039f5ad05220d01d6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 1=
4 October 2015 at 10:09, Elliot Smith <span dir=3D"ltr">&lt;<a href=3D"mail=
to:elliot.smith@intel.com" target=3D"_blank">elliot.smith@intel.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">From: Michael Wood &lt;<a =
href=3D"mailto:michael.g.wood@intel.com">michael.g.wood@intel.com</a>&gt;<b=
r>
<span class=3D""><br>
When we&#39;re building using toaster as just a listener to bitbake<br>
(analysis mode) we need to handle the case where the toaster configuration =
data<br>
isn&#39;t present so we don&#39;t need to try and update the existing infor=
mation.<br></span></blockquote><div><br></div><div>I submitted this upstrea=
m as was (I decided toaster is probably OK as a subject), and have added it=
 to toaster-next.</div><div><br></div><div>Elliot</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><span class=3D"">
<br>
</span>Signed-off-by: Michael Wood &lt;<a href=3D"mailto:michael.g.wood@int=
el.com">michael.g.wood@intel.com</a>&gt;<br>
Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.com">e=
lliot.smith@intel.com</a>&gt;<br>
<span class=3D"">---<br>
=C2=A0bitbake/lib/bb/ui/buildinfohelper.py | 34 ++++++++++++++++++++++-----=
-------<br>
=C2=A01 file changed, 22 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/build=
infohelper.py<br>
</span>index 2d76403..a8c884d 100644<br>
--- a/bitbake/lib/bb/ui/buildinfohelper.py<br>
+++ b/bitbake/lib/bb/ui/buildinfohelper.py<br>
@@ -298,9 +298,13 @@ class ORMWrapper(object):<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break<br>
<br>
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if created and must_exist:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotExisting(&quot;Recipe o=
bject created when expected to exist&quot;, recipe_information)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we&#39;re in analysis mode then we are wh=
olly responsible for the data<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # and therefore we return the &#39;real&#39; r=
ecipe rather than the build<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # history copy of the recipe.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if=C2=A0 recipe_information[&#39;layer_version=
&#39;].build is not None and \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recipe_information[&#39;layer_ve=
rsion&#39;].build.project =3D=3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Project.objects.ge=
t_default_project():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return recipe<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return built_recipe<br>
<br>
</span>@@ -333,14 +337,20 @@ class ORMWrapper(object):<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert &#39;priority&#39=
; in layer_version_information<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert &#39;local_path&#39; in layer_vers=
ion_information<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we&#39;re doing a command line build then=
 associate this new layer with the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # project to avoid it &#39;contaminating&#39; =
toaster data<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 project =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if build_obj.project =3D=3D Project.objects.ge=
t_default_project():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 project =3D build_obj.project<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_version_object, _ =3D Layer_Version=
.objects.get_or_create(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build =3D build_obj,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer =3D layer_obj,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branch =3D layer_versi=
on_information[&#39;branch&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit =3D layer_versi=
on_information[&#39;commit&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority =3D layer_ver=
sion_information[&#39;priority&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_path =3D layer_v=
ersion_information[&#39;local_path&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build =3D build_obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer =3D layer_obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branch =3D layer_version_info=
rmation[&#39;branch&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit =3D layer_version_info=
rmation[&#39;commit&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority =3D layer_version_in=
formation[&#39;priority&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_path =3D layer_version_=
information[&#39;local_path&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 project=3Dproject)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.layer_version_objects.append(layer_v=
ersion_object)<br>
<br>
</span>@@ -845,7 +855,7 @@ class BuildInfoHelper(object):<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warn(&quot;Could =
not match layer version for recipe path %s : %s&quot;, path, self.orm_wrapp=
er.layer_version_objects)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#mockup the new layer<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown_layer, _ =3D Layer.objects.get_or_crea=
te(name=3D&quot;__FIXME__unidentified_layer&quot;, layer_index_url=3D&quot;=
&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown_layer, _ =3D Layer.objects.get_or_crea=
te(name=3D&quot;Unidentified layer&quot;, layer_index_url=3D&quot;&quot;)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unknown_layer_version_obj, _ =3D Layer_Ve=
rsion.objects.get_or_create(layer =3D unknown_layer, build =3D self.interna=
l_state[&#39;build&#39;])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# append it so we don&#39;t run into this=
 error again and again<br>
</span>@@ -1067,7 +1077,7 @@ class BuildInfoHelper(object):<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0task_infor=
mation[&#39;disk_io&#39;] =3D taskstats[&#39;disk_io&#39;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;elapsed_time&#39; i=
n taskstats:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0task_informat=
ion[&#39;elapsed_time&#39;] =3D taskstats[&#39;elapsed_time&#39;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.orm_wrapper.get_update_task=
_object(task_information, True)=C2=A0 # must exist<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.orm_wrapper.get_update_task=
_object(task_information)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def update_and_store_task(self, event):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert &#39;taskfile&#39; in vars(event)<=
br>
--<br>
</span>1.9.3<br>
<br>
---------------------------------------------------------------------<br>
Intel Corporation (UK) Limited<br>
Registered No. 1134945 (England)<br>
Registered Office: Pipers Way, Swindon SN3 1RJ<br>
VAT No: 860 2173 47<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Enginee=
r<br>Intel Open Source Technology Centre</div></div></div>
</div></div>

--001a11c2a3a039f5ad05220d01d6--
