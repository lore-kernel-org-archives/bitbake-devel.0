Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id 16BF1748F0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 08:57:44 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so3597611wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=FVdWmaX1Z/NGdwbsos0OOUizBjjblLY0l5F/0WdYWlk=;
	b=EiIaTQmgx7wEl+Y9fgzUoM/Z6/AOIVo4miKRet+Um9iXvMv9qLVkZ7V7zoHjyMQ454
	WR/Fm+Z4lZ4QpysMugbSVdNE67wiKNWlwttnGf0AqrWxde3kYsOQVLTN449kKIugtdu/
	maXqIT0LfQhzQ1vqCUJxiu1bbsb7U5uWeAobPmUewVIlVML+D3PWGftM4KVW1NDFHADK
	yojVp/VgoCfurtrELNxUY/QG0qKR68iInUP3gjVQvjuGc+1MIxKHv16ZyV322H8Iw1wP
	5rsdqJRGHRTfnzyzSYHtqqTzDvP9EeEcubPX0aLGNCwh9nDV7eJU6as4pZsfzDpKtPw7
	Di+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=FVdWmaX1Z/NGdwbsos0OOUizBjjblLY0l5F/0WdYWlk=;
	b=T6+igKM5mF8sXWmhoOX7p9gb1qn5Uzt37hVhWLDH3mtAnB300jyKmh6ytShYfiY+H9
	CgrCR2+P19b3btwA0tjPVJXarT2008zC8LNy6Z5BSuknrG6OgDAgIEa6iOOeMGQ2qvWS
	nM74pCEKlBJOFJgAdPl2nxSI3hoBVzV5LapV//68Xo+NJuHpLXXQT5y1g60b1acIY+AY
	Jmv0+Xbyxbch7h+BRG4D0qpRmMmg6bYQrcQfheVLypUMDiN6GoBpdj5hdCLusWSfI9vl
	zEd4IA6vE2JuBWkEslYGnXzVmNPOWyk5u69h4KiSWGrojefQ3K+gUlEtIb9u1n0jAeRV
	KJgw==
X-Gm-Message-State: ABuFfoiDmPW3/nUrvSWCyvFd21r61e/HydgFJ9DIKasRqkpBlI0YDC0D
	hgOXgO+GwqIUyuWfMfhml6omgLxZ7C6vL74bt9RfeooV
X-Google-Smtp-Source: ACcGV60ihAE++MY9Gd0IpPlKxIEblgU656LPy/JqNPimsgrMuH6A1fg0fT3cgyiBXB6T5N5j42X8VZo+0yfKNxBMqkY=
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr3737039wml.15.1539939465613;
	Fri, 19 Oct 2018 01:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
	<20181018092246.1445-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20181018092246.1445-2-richard.purdie@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 19 Oct 2018 10:57:38 +0200
Message-ID: <CA+chaQdmU3WeTOy6UT3TGm97ucX98tXA=DOD5uTgY=tsB=4Y8A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/7] data_smart: Micro optimise _remove handling
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
X-List-Received-Date: Fri, 19 Oct 2018 08:57:45 -0000
Content-Type: multipart/alternative; boundary="000000000000d2d6400578911811"

--000000000000d2d6400578911811
Content-Type: text/plain; charset="UTF-8"

This one and "data_smart: Fix expand_cache and _remove operator interaction
issues" are slightly changing the behavior, not sure if this change was
intended.

Since last bitbake upgrade I've started seeing:
ERROR: ca-certificates-20180409-r0 do_package_qa: QA Issue: ca-certificates
rdepends on openssl, but it isn't a build dependency? [build-deps]
ERROR: nativesdk-bash-completion-2.8-r0 do_package_qa: QA Issue:
nativesdk-bash-completion rdepends on bash, but it isn't a build
dependency? [build-deps]

with bitbake 5463c16e3619d324aed137f47f93f0997a227d29
# $RDEPENDS_ca-certificates [4 operations]
#   _remove[pn-iputils] conf/distro/include/some-distro.inc:52
#     " ${PN}-ping6"
#   append oe-core/meta/recipes-support/ca-certificates/
ca-certificates_20180409.bb:85
#     "openssl"
#   _remove
meta-webos/recipes-support/ca-certificates/ca-certificates_%.bbappend:24
#     "openssl"
#   rename from RDEPENDS_${PN} data.py:117 [expandKeys]
#     " openssl"
# pre-expansion value:
#   " openssl"
RDEPENDS_ca-certificates=" "

and do_package_qa sees the openssl in rdepends:

NOTE: recipe ca-certificates-20180409-r0: task do_package_qa: Started
WARNING: ca-certificates-20180409-r0 do_package_qa: build-dep:
ca-certificates-dev
WARNING: ca-certificates-20180409-r0 do_package_qa: build-dep: openssl
WARNING: ca-certificates-20180409-r0 do_package_qa: rdep_data for rdepend:
openssl are {}
WARNING: ca-certificates-20180409-r0 do_package_qa: trying
/jenkins/mjansa/build-signage-master/BUILD/pkgdata/m16pp/runtime-rprovides/openssl/
ERROR: ca-certificates-20180409-r0 do_package_qa: QA Issue: ca-certificates
rdepends on openssl, but it isn't a build dependency? [build-deps]
WARNING: ca-certificates-20180409-r0 do_package_qa: build-dep:
ca-certificates
ERROR: ca-certificates-20180409-r0 do_package_qa: QA run found fatal
errors. Please consider fixing them.
ERROR: ca-certificates-20180409-r0 do_package_qa: Function failed:
do_package_qa
ERROR: Logfile of failure stored in:
/jenkins/mjansa/build-signage-master/BUILD/work/all-signage-linux/ca-certificates/20180409-r0/temp/log.do_package_qa.46878
NOTE: recipe ca-certificates-20180409-r0: task do_package_qa: Failed

with bitbake a68de8ace62eaba23856bfb301efbbe1824322aa
# $RDEPENDS_ca-certificates [4 operations]
#   _remove[pn-iputils] conf/distro/include/some-distro.inc:52
#     " ${PN}-ping6"
#   append oe-core/meta/recipes-support/ca-certificates/
ca-certificates_20180409.bb:85
#     "openssl"
#   _remove
meta-webos/recipes-support/ca-certificates/ca-certificates_%.bbappend:24
#     "openssl"
#   rename from RDEPENDS_${PN} data.py:116 [expandKeys]
#     " "
# pre-expansion value:
#   " "
RDEPENDS_ca-certificates=" "

git log --oneline a68de8a..5463c16e | tee
5463c16e test/data: Add new tests for task checksum changing/not changing
796a20d2 data/siggen: Extract task hash generation code into a function
57d2ee17 bitbake: data: Ensure task checksums account for remove data
136100dc data/data_smart: Allow getVarFlag to return the variable parser
object
a039052f data_smart: Fix expand_cache and _remove operator interaction
issues
6d19eb32 data_smart: Micro optimise _remove handling

With the micro optimise commit 6d19eb32 it already has openssl in "rename
from RDEPENDS_${PN}":
# $RDEPENDS_ca-certificates [4 operations]
#   _remove[pn-iputils] conf/distro/include/some-disto.inc:52
#     " ${PN}-ping6"
#   append oe-core/meta/recipes-support/ca-certificates/
ca-certificates_20180409.bb:85
#     "openssl"
#   _remove
meta-webos/recipes-support/ca-certificates/ca-certificates_%.bbappend:24
#     "openssl"
#   rename from RDEPENDS_${PN} data.py:116 [expandKeys]
#     " openssl"
# pre-expansion value:
#   " "
RDEPENDS_ca-certificates=" "

The bbappend doesn't do anything special, just this:
# ca-certificates is allarch, so it either has to RDEPENDS on
${MLPREFIX}openssl or
# in this case it's easier to just remove the dependency and pull it from
somewhere
# else
RDEPENDS_${PN}_remove = "openssl"

and similar _remove bbappend for bash-completion:
VIRTUAL-RUNTIME_bash ?= "bash"
RDEPENDS_${PN}_append_class-target = " ${VIRTUAL-RUNTIME_bash}"
RDEPENDS_${PN}_remove = "bash"

The reason for bash-completion is probably the same as in ca-certificates,
but it's surprising that I have maybe a 100 of bbappends like above with
bash, but only these 2 are causing the QA error.

Will dig a bit more where exactly it was introduced and will try to
reproduce with just oe-core.

On Thu, Oct 18, 2018 at 11:23 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> This brings _remove handling into line with _append/_prepend with regard
> to the parsing flag to getVarFlag.
>
> This is an internal flag and the only times this is used is through getVar
> during renameVar operations and when processing ?= operations to see if
> a variable is set. In either case we don't need to process remove
> operations.
>
> Therefore take the minor speedup and skip processing for parsing=True.
>
> [YOCTO #10945]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/data_smart.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 0a8488ca1b..7b2c0a8943 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -805,7 +805,7 @@ class DataSmart(MutableMapping):
>                  cachename = var + "[" + flag + "]"
>              value = self.expand(value, cachename)
>
> -        if value and flag == "_content" and local_var is not None and
> "_remove" in local_var:
> +        if value and flag == "_content" and local_var is not None and
> "_remove" in local_var and not parsing:
>              removes = []
>              self.need_overrides()
>              for (r, o) in local_var["_remove"]:
> --
> 2.17.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--000000000000d2d6400578911811
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">This one and &quot;data_smart: =
Fix expand_cache and _remove operator interaction issues&quot; are slightly=
 changing the behavior, not sure if this change was intended.</div><div dir=
=3D"ltr"><br></div><div>Since last bitbake upgrade I&#39;ve started seeing:=
</div><div dir=3D"ltr">ERROR: ca-certificates-20180409-r0 do_package_qa: QA=
 Issue: ca-certificates rdepends on openssl, but it isn&#39;t a build depen=
dency? [build-deps]<br></div><div dir=3D"ltr">ERROR: nativesdk-bash-complet=
ion-2.8-r0 do_package_qa: QA Issue: nativesdk-bash-completion rdepends on b=
ash, but it isn&#39;t a build dependency? [build-deps]<br></div><div dir=3D=
"ltr"><br></div><div dir=3D"ltr"><div dir=3D"ltr">with bitbake 5463c16e3619=
d324aed137f47f93f0997a227d29</div><div dir=3D"ltr"># $RDEPENDS_ca-certifica=
tes [4 operations]</div><div dir=3D"ltr">#=C2=A0 =C2=A0_remove[pn-iputils] =
conf/distro/include/some-distro.inc:52</div><div dir=3D"ltr">#=C2=A0 =C2=A0=
 =C2=A0&quot; ${PN}-ping6&quot;</div><div dir=3D"ltr">#=C2=A0 =C2=A0append =
oe-core/meta/recipes-support/ca-certificates/<a href=3D"http://ca-certifica=
tes_20180409.bb:85">ca-certificates_20180409.bb:85</a></div><div dir=3D"ltr=
">#=C2=A0 =C2=A0 =C2=A0&quot;openssl&quot;</div><div dir=3D"ltr">#=C2=A0 =
=C2=A0_remove meta-webos/recipes-support/ca-certificates/ca-certificates_%.=
bbappend:24</div><div dir=3D"ltr">#=C2=A0 =C2=A0 =C2=A0&quot;openssl&quot;<=
/div><div dir=3D"ltr">#=C2=A0 =C2=A0rename from RDEPENDS_${PN} data.py:117 =
[expandKeys]</div><div dir=3D"ltr">#=C2=A0 =C2=A0 =C2=A0&quot; openssl&quot=
;</div><div dir=3D"ltr"># pre-expansion value:</div><div dir=3D"ltr">#=C2=
=A0 =C2=A0&quot; openssl&quot;</div><div dir=3D"ltr">RDEPENDS_ca-certificat=
es=3D&quot; &quot;</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">and do_=
package_qa sees the openssl in rdepends:</div><div dir=3D"ltr"><br></div><d=
iv dir=3D"ltr">NOTE: recipe ca-certificates-20180409-r0: task do_package_qa=
: Started</div><div dir=3D"ltr">WARNING: ca-certificates-20180409-r0 do_pac=
kage_qa: build-dep: ca-certificates-dev</div><div dir=3D"ltr">WARNING: ca-c=
ertificates-20180409-r0 do_package_qa: build-dep: openssl</div><div dir=3D"=
ltr">WARNING: ca-certificates-20180409-r0 do_package_qa: rdep_data for rdep=
end: openssl are {}</div><div dir=3D"ltr">WARNING: ca-certificates-20180409=
-r0 do_package_qa: trying /jenkins/mjansa/build-signage-master/BUILD/pkgdat=
a/m16pp/runtime-rprovides/openssl/</div><div dir=3D"ltr">ERROR: ca-certific=
ates-20180409-r0 do_package_qa: QA Issue: ca-certificates rdepends on opens=
sl, but it isn&#39;t a build dependency? [build-deps]</div><div dir=3D"ltr"=
>WARNING: ca-certificates-20180409-r0 do_package_qa: build-dep: ca-certific=
ates</div><div dir=3D"ltr">ERROR: ca-certificates-20180409-r0 do_package_qa=
: QA run found fatal errors. Please consider fixing them.</div><div dir=3D"=
ltr">ERROR: ca-certificates-20180409-r0 do_package_qa: Function failed: do_=
package_qa</div><div dir=3D"ltr">ERROR: Logfile of failure stored in: /jenk=
ins/mjansa/build-signage-master/BUILD/work/all-signage-linux/ca-certificate=
s/20180409-r0/temp/log.do_package_qa.46878</div><div dir=3D"ltr">NOTE: reci=
pe ca-certificates-20180409-r0: task do_package_qa: Failed</div><div dir=3D=
"ltr"><br></div><div dir=3D"ltr">with bitbake a68de8ace62eaba23856bfb301efb=
be1824322aa</div><div dir=3D"ltr"># $RDEPENDS_ca-certificates [4 operations=
]</div><div dir=3D"ltr">#=C2=A0 =C2=A0_remove[pn-iputils] conf/distro/inclu=
de/some-distro.inc:52</div><div dir=3D"ltr">#=C2=A0 =C2=A0 =C2=A0&quot; ${P=
N}-ping6&quot;</div><div dir=3D"ltr">#=C2=A0 =C2=A0append oe-core/meta/reci=
pes-support/ca-certificates/<a href=3D"http://ca-certificates_20180409.bb:8=
5">ca-certificates_20180409.bb:85</a></div><div dir=3D"ltr">#=C2=A0 =C2=A0 =
=C2=A0&quot;openssl&quot;</div><div dir=3D"ltr">#=C2=A0 =C2=A0_remove meta-=
webos/recipes-support/ca-certificates/ca-certificates_%.bbappend:24</div><d=
iv dir=3D"ltr">#=C2=A0 =C2=A0 =C2=A0&quot;openssl&quot;</div><div dir=3D"lt=
r">#=C2=A0 =C2=A0rename from RDEPENDS_${PN} data.py:116 [expandKeys]</div><=
div dir=3D"ltr">#=C2=A0 =C2=A0 =C2=A0&quot; &quot;</div><div dir=3D"ltr"># =
pre-expansion value:</div><div dir=3D"ltr">#=C2=A0 =C2=A0&quot; &quot;</div=
><div dir=3D"ltr">RDEPENDS_ca-certificates=3D&quot; &quot;</div><div><br></=
div><div><div>git log --oneline a68de8a..5463c16e | tee</div><div>5463c16e =
test/data: Add new tests for task checksum changing/not changing</div><div>=
796a20d2 data/siggen: Extract task hash generation code into a function</di=
v><div>57d2ee17 bitbake: data: Ensure task checksums account for remove dat=
a</div><div>136100dc data/data_smart: Allow getVarFlag to return the variab=
le parser object</div><div>a039052f data_smart: Fix expand_cache and _remov=
e operator interaction issues</div><div>6d19eb32 data_smart: Micro optimise=
 _remove handling</div><div><br></div><div>With the micro optimise commit 6=
d19eb32 it already has openssl in &quot;rename from RDEPENDS_${PN}&quot;:</=
div><div># $RDEPENDS_ca-certificates [4 operations]</div><div>#=C2=A0 =C2=
=A0_remove[pn-iputils] conf/distro/include/some-disto.inc:52</div><div>#=C2=
=A0 =C2=A0 =C2=A0&quot; ${PN}-ping6&quot;</div><div>#=C2=A0 =C2=A0append oe=
-core/meta/recipes-support/ca-certificates/<a href=3D"http://ca-certificate=
s_20180409.bb:85">ca-certificates_20180409.bb:85</a></div><div>#=C2=A0 =C2=
=A0 =C2=A0&quot;openssl&quot;</div><div>#=C2=A0 =C2=A0_remove meta-webos/re=
cipes-support/ca-certificates/ca-certificates_%.bbappend:24</div><div>#=C2=
=A0 =C2=A0 =C2=A0&quot;openssl&quot;</div><div>#=C2=A0 =C2=A0rename from RD=
EPENDS_${PN} data.py:116 [expandKeys]</div><div>#=C2=A0 =C2=A0 =C2=A0&quot;=
 openssl&quot;</div><div># pre-expansion value:</div><div>#=C2=A0 =C2=A0&qu=
ot; &quot;</div><div>RDEPENDS_ca-certificates=3D&quot; &quot;</div><div><br=
></div><div>The bbappend doesn&#39;t do anything special, just this:</div><=
div># ca-certificates is allarch, so it either has to RDEPENDS on ${MLPREFI=
X}openssl or</div><div># in this case it&#39;s easier to just remove the de=
pendency and pull it from somewhere</div><div># else</div><div>RDEPENDS_${P=
N}_remove =3D &quot;openssl&quot;</div></div><div><br></div><div>and simila=
r _remove bbappend for bash-completion:</div><div><div>VIRTUAL-RUNTIME_bash=
 ?=3D &quot;bash&quot;</div><div>RDEPENDS_${PN}_append_class-target =3D &qu=
ot; ${VIRTUAL-RUNTIME_bash}&quot;</div><div>RDEPENDS_${PN}_remove =3D &quot=
;bash&quot;</div></div><div><br></div><div>The reason for bash-completion i=
s probably the same as in ca-certificates, but it&#39;s surprising that I h=
ave maybe a 100 of bbappends like above with bash, but only these 2 are cau=
sing the QA error.</div><div><br></div><div>Will dig a bit more where exact=
ly it was introduced and will try to reproduce with just oe-core.</div></di=
v></div></div></div></div></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Thu, Oct 18, 2018 at 11:23 AM Richard Purdie &lt;<a href=3D"m=
ailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This brings _remov=
e handling into line with _append/_prepend with regard<br>
to the parsing flag to getVarFlag.<br>
<br>
This is an internal flag and the only times this is used is through getVar<=
br>
during renameVar operations and when processing ?=3D operations to see if<b=
r>
a variable is set. In either case we don&#39;t need to process remove opera=
tions.<br>
<br>
Therefore take the minor speedup and skip processing for parsing=3DTrue.<br=
>
<br>
[YOCTO #10945]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/data_smart.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py<br>
index 0a8488ca1b..7b2c0a8943 100644<br>
--- a/lib/bb/data_smart.py<br>
+++ b/lib/bb/data_smart.py<br>
@@ -805,7 +805,7 @@ class DataSmart(MutableMapping):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cachename =3D=
 var + &quot;[&quot; + flag + &quot;]&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D self.expand(value=
, cachename)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if value and flag =3D=3D &quot;_content&quot; =
and local_var is not None and &quot;_remove&quot; in local_var:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if value and flag =3D=3D &quot;_content&quot; =
and local_var is not None and &quot;_remove&quot; in local_var and not pars=
ing:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0removes =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.need_overrides()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (r, o) in local_var[&qu=
ot;_remove&quot;]:<br>
-- <br>
2.17.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--000000000000d2d6400578911811--
