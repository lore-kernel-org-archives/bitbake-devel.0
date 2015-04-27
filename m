Return-Path: <alexandru.damian@intel.com>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
	[209.85.223.173])
	by mail.openembedded.org (Postfix) with ESMTP id CD489735FA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Apr 2015 14:23:22 +0000 (UTC)
Received: by iejt8 with SMTP id t8so127145143iej.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Apr 2015 07:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=ywj1dWSaPTg/yLavM1rfC/D8kqtAmKCCtzUJaKEXW54=;
	b=Mr8HjvL7DA0m+kOVWzYzzO074sot68e4brexXFwzqlngN73vnMNNQ/ohWm3hfoXYDK
	VszxrSCCsikI4QHYmPYSyTXZNojYDGVkx1yQgb5In9nbudAtl/vM4BVBU1Jj+EHlYBHK
	z8wpLHsJsgDRfmraHBylFUk4KnEsl66VtN9bh+xq3fc1U7b+pORvw63mEK80i8fSk2I2
	rEdZS16XEuwEPXTh7WRm6wSlYkdJ1ulPlDPT2e52UUfiKwIQmd8hVveZFUXZwTRR5Xdw
	cdou5+0xIkbuO3G/03hjjr6E/ax2SB34RE74h/nOQRa0L9LQEcRXBmbcA2mhOLoYGf8Q
	ozWQ==
X-Gm-Message-State: ALoCoQkOkFpB75+d8lGTnt7RxcaODZ+wmg3+AursxCg8JkKhAeRYrbgwcEGhT6rwTt3rwpZ/ptHY
X-Received: by 10.43.66.131 with SMTP id xq3mr12933977icb.9.1430144603564;
	Mon, 27 Apr 2015 07:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.10.67 with HTTP; Mon, 27 Apr 2015 07:23:03 -0700 (PDT)
In-Reply-To: <fd1f6fda7a7629f4660235313dc99adb3c190952.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
	<e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
	<fd1f6fda7a7629f4660235313dc99adb3c190952.1429195580.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 27 Apr 2015 15:23:03 +0100
Message-ID: <CAJ2CSBt78778gnSmKeCqe1wHgeGAa815Cp0eG-Ggxm5+5vwunQ@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: Re: [PATCH 4/8] toaster: add layer source in admin throws an error
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
X-List-Received-Date: Mon, 27 Apr 2015 14:23:25 -0000
Content-Type: multipart/alternative; boundary=001a11c2159812ca690514b57d55

--001a11c2159812ca690514b57d55
Content-Type: text/plain; charset=UTF-8

Hello,

I am going to revert this patch because it messes up the class
instantiation for layer sources saved through the admin. We need a better
solution for 7437.

Alex

On Thu, Apr 16, 2015 at 3:47 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: David Reyna <David.Reyna@windriver.com>
>
> Preset uninitialized object members to bootstrap new layer source creation.
>
> [YOCTO #7437]
>
> Signed-off-by: David Reyna <David.Reyna@windriver.com>
> ---
>  lib/toaster/orm/models.py | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index 625eb1e..4a6ca8f 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -640,17 +640,25 @@ class LayerSource(models.Model):
>          raise Exception("Abstract, update() must be implemented by all
> LayerSource-derived classes (object is %s)" % str(vars(self)))
>
>      def save(self, *args, **kwargs):
> -        if isinstance(self, LocalLayerSource):
> -            self.sourcetype = LayerSource.TYPE_LOCAL
> -        elif isinstance(self, LayerIndexLayerSource):
> -            self.sourcetype = LayerSource.TYPE_LAYERINDEX
> -        elif isinstance(self, ImportedLayerSource):
> -            self.sourcetype = LayerSource.TYPE_IMPORTED
> +        if self.sourcetype == LayerSource.TYPE_LOCAL:
> +            self.__class__ = LocalLayerSource
> +        elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
> +            self.__class__ = LayerIndexLayerSource
> +        elif self.sourcetype == LayerSource.TYPE_IMPORTED:
> +            self.__class__ = ImportedLayerSource
>          elif self.sourcetype == None:
>              raise Exception("Unknown LayerSource-derived class. If you
> added a new layer source type, fill out all code stubs.")
>          return super(LayerSource, self).save(*args, **kwargs)
>
>      def get_object(self):
> +        # preset an un-initilized object
> +        if None == self.name:
> +            self.name=""
> +        if None == self.apiurl:
> +            self.apiurl=""
> +        if None == self.sourcetype:
> +            self.sourcetype=LayerSource.TYPE_LOCAL
> +
>          if self.sourcetype == LayerSource.TYPE_LOCAL:
>              self.__class__ = LocalLayerSource
>          elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--001a11c2159812ca690514b57d55
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,<br><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:tahoma,sans-serif">I am going to revert this patch because it messes =
up the class instantiation for layer sources saved through the admin. We ne=
ed a better solution for 7437.<br><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:tahoma,sans-serif">Alex<br></div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Thu, Apr 16, 2015 at 3:47 PM, A=
lex DAMIAN <span dir=3D"ltr">&lt;<a href=3D"mailto:alexandru.damian@intel.c=
om" target=3D"_blank">alexandru.damian@intel.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">From: David Reyna &lt;<a href=3D"mailto:David=
.Reyna@windriver.com">David.Reyna@windriver.com</a>&gt;<br>
<br>
Preset uninitialized object members to bootstrap new layer source creation.=
<br>
<br>
[YOCTO #7437]<br>
<br>
Signed-off-by: David Reyna &lt;<a href=3D"mailto:David.Reyna@windriver.com"=
>David.Reyna@windriver.com</a>&gt;<br>
---<br>
=C2=A0lib/toaster/orm/models.py | 20 ++++++++++++++------<br>
=C2=A01 file changed, 14 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py<br>
index 625eb1e..4a6ca8f 100644<br>
--- a/lib/toaster/orm/models.py<br>
+++ b/lib/toaster/orm/models.py<br>
@@ -640,17 +640,25 @@ class LayerSource(models.Model):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&quot;Abstract, update() =
must be implemented by all LayerSource-derived classes (object is %s)&quot;=
 % str(vars(self)))<br>
<br>
=C2=A0 =C2=A0 =C2=A0def save(self, *args, **kwargs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(self, LocalLayerSource):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sourcetype =3D LayerSource.=
TYPE_LOCAL<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif isinstance(self, LayerIndexLayerSource):<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sourcetype =3D LayerSource.=
TYPE_LAYERINDEX<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif isinstance(self, ImportedLayerSource):<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sourcetype =3D LayerSource.=
TYPE_IMPORTED<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.sourcetype =3D=3D LayerSource.TYPE_LOC=
AL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__class__ =3D LocalLayerSou=
rce<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.sourcetype =3D=3D LayerSource.TYPE_L=
AYERINDEX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__class__ =3D LayerIndexLay=
erSource<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.sourcetype =3D=3D LayerSource.TYPE_I=
MPORTED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__class__ =3D ImportedLayer=
Source<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif self.sourcetype =3D=3D None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Exception(&quot;Unkno=
wn LayerSource-derived class. If you added a new layer source type, fill ou=
t all code stubs.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return super(LayerSource, self).save(*arg=
s, **kwargs)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_object(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # preset an un-initilized object<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if None =3D=3D <a href=3D"http://self.name" ta=
rget=3D"_blank">self.name</a>:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.name" tar=
get=3D"_blank">self.name</a>=3D&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if None =3D=3D self.apiurl:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.apiurl=3D&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if None =3D=3D self.sourcetype:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sourcetype=3DLayerSource.TY=
PE_LOCAL<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.sourcetype =3D=3D LayerSource.TYP=
E_LOCAL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.__class__ =3D LocalLay=
erSource<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif self.sourcetype =3D=3D LayerSource.T=
YPE_LAYERINDEX:<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></d=
iv><div>SSG / OTC=C2=A0</div></div></div>
</div>

--001a11c2159812ca690514b57d55--
