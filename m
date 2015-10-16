Return-Path: <elliot.smith@intel.com>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
	[209.85.213.182])
	by mail.openembedded.org (Postfix) with ESMTP id A7B9E7715E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 15:57:22 +0000 (UTC)
Received: by igdg1 with SMTP id g1so4005512igd.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=8i9GbZYXPzpkulBq34i/l6LZaC5HJES4ta/70Ahezaw=;
	b=e6iAXOtzLZeTBQgLtlcj8oEzXGDZX6AJTLiMMaO7RUVZFFRf0h6HSP4aXYjSksZzgn
	+uBcfCfXUZMDMCLHbhvgwVo2N7ISaH2q1WSf9tNaRdDun4Lv6Zzx+ia6Ytb88s9NZXez
	Fpiigak1GT/4hCLPiBQd39fMCJ3oCHw5pfwjgrbVJYcR6wfEcopIviYCal4P+Bws1cFr
	vNJIMEKTyRkuKfyAzEFba4J4GfCCBTziMZgkLdIEsr619NZ4NbQmw3CtXvPT+PSnaw2s
	3B1eHcogrTBXhQH/SQoBiwl+tjgv5ZoR3HVNWozh9Y8yAdKT0R49Ze+KMW9ixPgQ8zda
	HN5A==
X-Gm-Message-State: ALoCoQnigVrtK+DaI4UnsHVwVprrY6eO3GGv6s8x+Q9F7lVCQOtJGamPQk0AykO3qfGNbB72cIy3
MIME-Version: 1.0
X-Received: by 10.50.4.65 with SMTP id i1mr6784164igi.0.1445011040727; Fri, 16
	Oct 2015 08:57:20 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Fri, 16 Oct 2015 08:57:20 -0700 (PDT)
In-Reply-To: <1444555346.14364.24.camel@linuxfoundation.org>
References: <1444555346.14364.24.camel@linuxfoundation.org>
Date: Fri, 16 Oct 2015 16:57:20 +0100
Message-ID: <CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Fri, 16 Oct 2015 15:57:24 -0000
Content-Type: multipart/alternative; boundary=001a11c2a3a0c7b59d05223ad943

--001a11c2a3a0c7b59d05223ad943
Content-Type: text/plain; charset=UTF-8

Thanks for these, Richard.

On 11 October 2015 at 10:22, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The console log data is written to is created at console initialisation
> time and does not change over reset events. This ensures the
> BB_CONSOLELOG value is correct over such resets by preserving it.
>

I've put your three patches on top of master and ran a few builds. The
result is that all of the logs for those builds are going into a single
timestamped file. Before, they went to separate files. Is this intentional,
or was the old behaviour incorrect? (Ideally, toaster needs a separate log
file for each build.)

Thanks.
Elliot




>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bitbake/lib/bb/cooker.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 9c9d761..ba0a8fe 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -244,6 +244,11 @@ class BBCooker:
>          self.state = state.initial
>          self.caches_array = []
>
> +        # Need to preserve BB_CONSOLELOG over resets
> +        consolelog = None
> +        if hasattr(self, "data"):
> +            consolelog = self.data.getVar("BB_CONSOLELOG", True)
> +
>          if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
>              self.enableDataTracking()
>
> @@ -270,6 +275,8 @@ class BBCooker:
>          self.data = self.databuilder.data
>          self.data_hash = self.databuilder.data_hash
>
> +        if consolelog:
> +            self.data.setVar("BB_CONSOLELOG", consolelog)
>
>          # we log all events to a file if so directed
>          if self.configuration.writeeventlog:
>
>
>


-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a11c2a3a0c7b59d05223ad943
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Than=
ks for these, Richard.</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">On 11 October 2015 at 10:22, Richard Purdie <span dir=3D"l=
tr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_bl=
ank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">The console log data is written to is created at conso=
le initialisation<br>
time and does not change over reset events. This ensures the<br>
BB_CONSOLELOG value is correct over such resets by preserving it.<br></bloc=
kquote><div><br></div><div>I&#39;ve put your three patches on top of master=
 and ran a few builds. The result is that all of the logs for those builds =
are going into a single timestamped file. Before, they went to separate fil=
es. Is this intentional, or was the old behaviour incorrect? (Ideally, toas=
ter needs a separate log file for each build.)</div><div><br></div><div>Tha=
nks.</div><div>Elliot</div><div><br></div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/cooker.py | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br>
index 9c9d761..ba0a8fe 100644<br>
--- a/bitbake/lib/bb/cooker.py<br>
+++ b/bitbake/lib/bb/cooker.py<br>
@@ -244,6 +244,11 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.state =3D state.initial<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.caches_array =3D []<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Need to preserve BB_CONSOLELOG over resets<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 consolelog =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hasattr(self, &quot;data&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 consolelog =3D self.data.getVar(=
&quot;BB_CONSOLELOG&quot;, True)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if CookerFeatures.BASEDATASTORE_TRACKING =
in self.featureset:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enableDataTracking()<b=
r>
<br>
@@ -270,6 +275,8 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data =3D self.databuilder.data<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.data_hash =3D self.databuilder.data_=
hash<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if consolelog:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.data.setVar(&quot;BB_CONSOL=
ELOG&quot;, consolelog)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# we log all events to a file if so direc=
ted<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.configuration.writeeventlog:<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Enginee=
r<br>Intel Open Source Technology Centre</div></div></div>
</div></div>

--001a11c2a3a0c7b59d05223ad943--
