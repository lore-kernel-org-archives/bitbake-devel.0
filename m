Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
	[209.85.213.51])
	by mail.openembedded.org (Postfix) with ESMTP id 90BBD76104
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:11:37 +0000 (UTC)
Received: by vkhf67 with SMTP id f67so110039535vkh.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Uxo+5uJU8xVGK54Axx893WYuPTzKVSzHIWpSOyRB9IM=;
	b=lYtG6QkP4oENWB8FVyk7vRStfhemwNVXABToUgUlWP8IAGaBPtcddS4RRwYLXwOz4J
	NkOXvFO/53f0kq2hoPnTqrlOGay8rMopHXzXPs49TwwtxrRJKAQI75hxjYnI94q5BFjg
	CSHYAo7aRsJvBNXm79l74Fi/4CrTr70MXls5JDhq7Y1YuWhYgQIoe21eG/xvg2IEFRlI
	JwGdTr1EIZiEDL/vmBDfbfey+c5FDc4onGB3ySOtljM695dhFd2YCt13IrsyYsrmD2jI
	/CogCBUqmXz+v0BH49vphIeqN2+hSRzsoQiie8r9+giSmNe3QV4BfxIFwseCcH16Jal8
	uh5w==
X-Received: by 10.31.58.68 with SMTP id h65mr23111588vka.139.1442437897226;
	Wed, 16 Sep 2015 14:11:37 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.31.203.2 with HTTP; Wed, 16 Sep 2015 14:11:17 -0700 (PDT)
In-Reply-To: <1442437075.26666.172.camel@linuxfoundation.org>
References: <1442437075.26666.172.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 16 Sep 2015 14:11:17 -0700
X-Google-Sender-Auth: a3YgTC9ucfVutv_3pNoDqLBRAZA
Message-ID: <CABcZANnwO2oSzOocFSgAOGMUKbkmU86wtCaa_YsiUBA2RW9RTw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Expand overrides cache recursively
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
X-List-Received-Date: Wed, 16 Sep 2015 21:11:38 -0000
Content-Type: multipart/alternative; boundary=001a1143e6a27991c8051fe3bed8

--001a1143e6a27991c8051fe3bed8
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 16, 2015 at 1:57 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> +        while changed:
>              self.inoverride = True
>              # Can end up here recursively so setup dummy values
>              self.overrides = []
> @@ -431,6 +435,14 @@ class DataSmart(MutableMapping):
>              self.overridesset = set(self.overrides)
>              self.inoverride = False
>              self.expand_cache = {}
> +            newoverrides = (self.getVar("OVERRIDES", True) or
> "").split(":") or []
> +            if newoverrides == self.overrides:
> +                changed = False
> +            self.overrides = newoverrides
> +            self.overridesset = set(self.overrides)
> +            count += 1
> +            if count > 5:
> +                bb.fatal("Overrides could not be expanded into a stable
> state after 5 iterations, overrides must be being referenced by other
> overridden variables in some recursive fashion. Please provide your
> configuration to bitbake-devel so we can laugh, er, I mean try and
> understand how to make it work.")
>

We know the maximum number of iterations here, so it might be worth doing a
for count in range(5): .. if newoverrides == self.overrides: break, and the
else block on the loop would indicate it never broke and therefore we hit
the count > 5 case. That'd eliminate the manual count bits.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1143e6a27991c8051fe3bed8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Sep 16, 2015 at 1:57 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":4oc" class=3D"a3s" style=3D"overflow:hidden">+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 while changed:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.inoverride =3D True<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Can end up here recursive=
ly so setup dummy values<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.overrides =3D []<br>
@@ -431,6 +435,14 @@ <span class=3D"il">class</span> DataSmart(MutableMappi=
ng):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.overridesset =3D set(s=
elf.overrides)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.inoverride =3D False<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.expand_cache =3D {}<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newoverrides =3D (self.getVar(&q=
uot;OVERRIDES&quot;, True) or &quot;&quot;).split(&quot;:&quot;) or []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if newoverrides =3D=3D self.over=
rides:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changed =3D False<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.overrides =3D newoverrides<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.overridesset =3D set(self.o=
verrides)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if count &gt; 5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span class=3D"il"=
>bb</span>.fatal(&quot;Overrides could not be expanded into a stable state =
after 5 iterations, overrides must be being referenced by other overridden =
variables in some recursive fashion. Please provide your configuration to <=
span class=3D"il">bitbake</span>-devel so we can laugh, er, I mean try and =
understand how to make it work.&quot;)</div></blockquote></div><br>We know =
the maximum number of iterations here, so it might be worth doing a for cou=
nt in range(5): .. if newoverrides =3D=3D self.overrides: break, and the el=
se block on the loop would indicate it never broke and therefore we hit the=
 count &gt; 5 case. That&#39;d eliminate the manual count bits.<br>-- <br><=
div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot =
com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br=
>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1143e6a27991c8051fe3bed8--
