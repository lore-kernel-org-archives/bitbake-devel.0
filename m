Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
	[209.85.220.175])
	by mail.openembedded.org (Postfix) with ESMTP id 27FE173D3D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 19:39:48 +0000 (UTC)
Received: by qkgx75 with SMTP id x75so93474808qkg.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=YmieGLE1rMbE5/vzNoUPn8hIow/x+/i/65QwXjKFvqY=;
	b=dC7o38EPvmeOi/qKs3JPf+mc7HEwkbBkVISgLoPR1UlnU8JTuwYvpN8S9DB1gZpQAG
	1XTb/nJ4Xs8bcv90KrVY+ChyW6Au9RJXKVeB0vvhnSyXO4clg6TLvZdWSIolC7IP5eQh
	7CKeZ8qF/VwhtMzVxL5LU2Kk22HBEmaBCF0Ussb7PRJ3sdTfnrNAa97H3kHKCjt40Iwx
	S3ugNEci9egwXl+NbGfIt3ZIF0Ad7MqRUEAd/nIqBOTR9OT83eaR7zKg+I9PanqzThvU
	dzWw5eeL1BxeJfGUKddJTVIMgl0+4lh8ycMeZx2dKsFI504SKE7u9nhRshvJR0IhMXXH
	5JNw==
X-Received: by 10.55.25.91 with SMTP id k88mr55435892qkh.57.1429126755121;
	Wed, 15 Apr 2015 12:39:15 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.34 with HTTP; Wed, 15 Apr 2015 12:38:54 -0700 (PDT)
In-Reply-To: <1429109002-25246-1-git-send-email-ed.bartosh@linux.intel.com>
References: <CABcZANnTuVDDisxj3W1EjE_RN3MAaLnk2-9Wm_rcnq4E1jR=ew@mail.gmail.com>
	<1429109002-25246-1-git-send-email-ed.bartosh@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 15 Apr 2015 12:38:54 -0700
X-Google-Sender-Auth: FL77jKWdSvLKHWGsZZDGbSDwVFI
Message-ID: <CABcZANnOghZ-ek19v0KH8L2EdC1m2vDOW2Eyv_zOV2zfFaLnWg@mail.gmail.com>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Allow environment variables and ~ in bblayers
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
X-List-Received-Date: Wed, 15 Apr 2015 19:39:50 -0000
Content-Type: multipart/alternative; boundary=001a11473cee94014e0513c880d2

--001a11473cee94014e0513c880d2
Content-Type: text/plain; charset=UTF-8

On Wed, Apr 15, 2015 at 7:43 AM, Ed Bartosh <ed.bartosh@linux.intel.com>
wrote:

> Enabled processing of environment variables in bblayers paths using
> bitbake apporved_variables API.
>
> Enabled processing of ~ if HOME environment variable is approved.
>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
> index 6c11a60..05b3986 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -25,6 +25,7 @@
>  import os, sys
>  from functools import wraps
>  import logging
> +import string
>  import bb
>  from bb import data
>  import bb.parse
> @@ -269,8 +270,13 @@ class CookerDataBuilder(object):
>              layers = (data.getVar('BBLAYERS', True) or "").split()
>
>              data = bb.data.createCopy(data)
> +            approved = dict((var, data.getVar(var, True)) \
> +                                  for var in bb
> .utils.approved_variables())
>              for layer in layers:
>                  parselog.debug(2, "Adding layer %s", layer)
> +                layer = string.Template(layer).safe_substitute(approved)
> +                if 'HOME' in approved:
> +                    layer = os.path.expanduser(layer)
>                  data.setVar('LAYERDIR', layer)
>                  data = parse_config_file(os.path.join(layer, "conf",
> "layer.conf"), data)
>                  data.expandVarref('LAYERDIR')
>

Why the use of string.Template here? We already have a variable expansion
mechanism.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11473cee94014e0513c880d2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Apr 15, 2015 at 7:43 AM, Ed Bartosh <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ed.bartosh@linux.intel.com" target=3D"_blank">ed.bartosh@linux.i=
ntel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=
=3D":1kl" class=3D"a3s" style=3D"overflow:hidden">Enabled processing of env=
ironment variables in bblayers paths using<br>
<span class=3D"il">bitbake</span> apporved_variables API.<br>
<br>
Enabled processing of ~ if HOME environment variable is approved.<br>
<br>
Signed-off-by: Ed Bartosh &lt;<a href=3D"mailto:ed.bartosh@linux.intel.com"=
>ed.bartosh@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/co=
okerdata.py | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</s=
pan>/cookerdata.py b/<span class=3D"il">bitbake</span>/lib/<span class=3D"i=
l">bb</span>/cookerdata.py<br>
index 6c11a60..05b3986 100644<br>
--- a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/co=
okerdata.py<br>
+++ b/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/co=
okerdata.py<br>
@@ -25,6 +25,7 @@<br>
=C2=A0import os, sys<br>
=C2=A0from functools import wraps<br>
=C2=A0import logging<br>
+import string<br>
=C2=A0import <span class=3D"il">bb</span><br>
=C2=A0from <span class=3D"il">bb</span> import data<br>
=C2=A0import <span class=3D"il">bb</span>.parse<br>
@@ -269,8 +270,13 @@ <span class=3D"il">class</span> CookerDataBuilder(obje=
ct):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layers =3D (data.getVar(&#3=
9;BBLAYERS&#39;, True) or &quot;&quot;).split()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D <span class=3D"il"=
>bb</span>.data.createCopy(data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 approved =3D dict((var, data.get=
Var(var, True)) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for var in <span class=3D"il"=
>bb</span>.utils.approved_variables())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for layer in layers:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parselog.debu=
g(2, &quot;Adding layer %s&quot;, layer)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer =3D string.T=
emplate(layer).safe_substitute(approved)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;HOME&#39; =
in approved:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 laye=
r =3D os.path.expanduser(layer)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.setVar(&=
#39;LAYERDIR&#39;, layer)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D pars=
e_config_file(os.path.join(layer, &quot;<span class=3D"il">conf</span>&quot=
;, &quot;layer.<span class=3D"il">conf</span>&quot;), data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.expandVa=
rref(&#39;LAYERDIR&#39;)</div></blockquote></div><br>Why the use of string.=
Template here? We already have a variable expansion mechanism.<br>-- <br><d=
iv class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot c=
om<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>=
Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a11473cee94014e0513c880d2--
