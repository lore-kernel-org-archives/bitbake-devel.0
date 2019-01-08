Return-Path: <linus.ziegert@holoplot.com>
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com
	[209.85.161.46])
	by mail.openembedded.org (Postfix) with ESMTP id DD5437BD20
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 16:36:18 +0000 (UTC)
Received: by mail-yw1-f46.google.com with SMTP id k188so1777338ywa.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Jan 2019 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=holoplot-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+rj+C0YlAS51a6JnkxTjJDRsZSkEHWSVqmmdqaooBTU=;
	b=hcUSZXnTkMRN0V6ansUsUtfuQgYHr9qRiHSsrRzLaW5ssORM/C/FlLulv173S0QNyd
	GzKsLjF7b32BqAEcZ0v1sSzf7XbMsqq8g/sPWu5Bq/YREGb7KXIEeI15coJr9EaW82y9
	2WAqo/kCfNxP0wDZw1/XKPy8/uj+Nh7Co7uiDMGOGbFn6u4Nu/eKlAWQB3ReE/2WewyY
	swmXsiM6eLa3mNLfG58ZnJ23WTknr1PYc/JgyRdo+lXs8q7as9KY6UDoHDSX61rrbRSd
	bUApge8MqFXNHDtJ3new3nOm2SnFvTmGo7IhNOh8IMlNwRBJnFjh2xfeTSOdlWxWloFt
	rxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+rj+C0YlAS51a6JnkxTjJDRsZSkEHWSVqmmdqaooBTU=;
	b=BURY9dU/KFsQgOVk5zW7cZL7MZ6YhDdluZeRp4Ah/gBoVzf2RfbPsjasq8NeTI8poD
	ioXSzITTNHrar9kbIMKFcO6Ws+wr9SC1dDu8v+STHrAz9SeJEqFA3vy3gn7lciz41XZS
	SO9T/HT68J/CDW1W3QJHY6eT9ZZVXlxFHWDhEJ+kvgBjWxfzJA0S95jjA2TdxrbiZReI
	DGi5/1tsqhRwdQAkggZJCJHORMeos57kJb1uzodz+cYHpwe3AzcqqYYtIyJikfNU0aCH
	NPyBK4t7taCPuwzIg7MNSgEV3JRLkNOirRYoynjUjuPt/O6unIWjqIKBjV9a7voFsZfg
	fzpA==
X-Gm-Message-State: AJcUukccBG+Fh1Khw73TU2KOajYZL1eEjkoIzvpMWEc9fGAT/ODENkqe
	Bkkuj7uwv7TB8c/V9ApiSDxWzidt5jC1KygLPWSCmw==
X-Google-Smtp-Source: ALg8bN6VM80JmfX1oja3Kv2eMzrGJlkny+2EA/PxLrDp/eMqrNmVsmYSfU1j99ukttbnKir6EZ8Q5+poMIM9ZmpuSqM=
X-Received: by 2002:a81:d84c:: with SMTP id n12mr2321011ywl.280.1546965379443; 
	Tue, 08 Jan 2019 08:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108074737.15427-1-krystian.garlinski@comarch.pl>
In-Reply-To: <20190108074737.15427-1-krystian.garlinski@comarch.pl>
From: Linus Ziegert <linus.ziegert@holoplot.com>
Date: Tue, 8 Jan 2019 17:35:42 +0100
Message-ID: <CAPm2bJ_ZAmsCU04_sqRL9KL7YELUPj2iMi8_efUNvtnKOgT=nw@mail.gmail.com>
To: =?UTF-8?Q?Krystian_Garli=C5=84ski?= <krystian.garlinski@comarch.pl>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] fetch2/gitsm.py: Change the URI construction logic
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
X-List-Received-Date: Tue, 08 Jan 2019 16:36:19 -0000
X-Groupsio-MsgNum: 9923
Content-Type: multipart/mixed; boundary="000000000000ec2e2f057ef4f198"

--000000000000ec2e2f057ef4f198
Content-Type: multipart/alternative; boundary="000000000000ec2e2c057ef4f196"

--000000000000ec2e2c057ef4f196
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello people,

I am working as well on fetch2/gitsm.py. We have a privat repo with
submodules but the current gitsm.py does not support ssh.

I tested the patch by Krystian but it did not worked for me. I got the
following ERROR:

ERROR: <recipe> do_fetch: The URL: 'gitsm:git@github.com/<user>/<submodule
_name1>.git;protocol=3Dssh;name=3D<submodule_name2>;bareclone=3D1;nocheckou=
t=3D1;
nobranch=3D1' is invalid and cannot be interpreted


The .gitmodules file used looks like this:

[submodule "submodule_name1"]
path =3D submodule_name1
        url =3D git@github.com/<user>/<submodule_name1>.git
[submodule "submodule_name2"]
path =3D submodule_name2
        url =3D git@github.com/<user>/<submodule_name2>.git

Attached you find my proposal.


Am Di., 8. Jan. 2019 um 08:48 Uhr schrieb Krystian Garli=C5=84ski <krystian=
.
garlinski@comarch.pl>:

> Git allows to use both the proper URI's and SCP-like short style syntax
> for the SSH protocol. This commit changes construction logic to detect
> which
> one of the two is used in the submodule specification and to build a
> correct
> URI out of it.
>
> Signed-off-by: Krystian Garli=C5=84ski <krystian.garlinski@comarch.pl>
> ---
>  lib/bb/fetch2/gitsm.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 35729dbc..95d5f652 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -32,6 +32,7 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://"
> requires a clean of your r
>  import os
>  import bb
>  import copy
> +import re
>  from   bb.fetch2.git import Git
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
> @@ -39,6 +40,8 @@ from   bb.fetch2 import Fetch
>  from   bb.fetch2 import BBFetchException
>
>  class GitSM(Git):
> +    scp_regex =3D re.compile(r'^([a-zA-Z0-9_]+)@([a-zA-Z0-9._-]+):(.+)$'=
)
> +
>      def supports(self, ud, d):
>          """
>          Check to see if a given url can be fetched with git.
> @@ -88,8 +91,17 @@ class GitSM(Git):
>              module_hash =3D module_hash.split()[2]
>
>              # Build new SRC_URI
> -            proto =3D uris[module].split(':', 1)[0]
> -            url =3D uris[module].replace('%s:' % proto, 'gitsm:', 1)
> +            uri =3D uris[module]
> +            match =3D GitSM.scp_regex.match(uri)
> +
> +            if match:
> +                # this URI follows the short SCP-like syntax
> +                url =3D 'gitsm://{}@{}/{}'.format(match.group(1),
> match.group(2), match.group(3))
> +                proto =3D 'ssh'
> +            else:
> +                proto =3D uri.split(':', 1)[0]
> +                url =3D 'gitsm' + uri[len(proto):]
> +
>              url +=3D ';protocol=3D%s' % proto
>              url +=3D ";name=3D%s" % module
>              url +=3D ";bareclone=3D1;nocheckout=3D1;nobranch=3D1"
> --
> 2.19.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


--=20

Cheers,
Linus

--000000000000ec2e2c057ef4f196
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hello people,<br><br>I am worki=
ng as well on fetch2/<span class=3D"" id=3D":1oh.1" tabindex=3D"-1" style=
=3D"">gitsm</span>.<span class=3D"" id=3D":1oh.2" tabindex=3D"-1" style=3D"=
">py</span>. We have a <span class=3D"" id=3D":1oh.3" tabindex=3D"-1" style=
=3D"">privat</span> <span class=3D"" id=3D":1oh.4" tabindex=3D"-1" style=3D=
"">repo</span> with <span class=3D"" id=3D":1oh.5" tabindex=3D"-1" style=3D=
"">submodules</span> but the current <span class=3D"" id=3D":1oh.6" tabinde=
x=3D"-1" style=3D"">gitsm</span>.<span class=3D"" id=3D":1oh.7" tabindex=3D=
"-1" style=3D"">py</span> does not support ssh.<br><br>I tested the patch b=
y <span class=3D"" id=3D":1oh.8" tabindex=3D"-1" style=3D"">Krystian</span>=
 but it did not worked for me. I got the following ERROR:<br><br></div></di=
v></div></div><blockquote style=3D"margin:0px 0px 0px 40px;border:none;padd=
ing:0px"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>ERROR: &lt=
;recipe&gt; do_fetch: The URL: &#39;gitsm:git@<span class=3D"" id=3D":1oh.9=
" tabindex=3D"-1" style=3D"">github</span>.com/&lt;user&gt;/&lt;<span class=
=3D"" id=3D":1oh.10" tabindex=3D"-1" style=3D"">submodule</span>_name1&gt;.=
git;protocol=3Dssh;name=3D&lt;<span class=3D"" id=3D":1oh.11" tabindex=3D"-=
1" style=3D"">submodule</span>_name2&gt;;<span class=3D"" id=3D":1oh.12" ta=
bindex=3D"-1" style=3D"">bareclone</span>=3D1;<span class=3D"" id=3D":1oh.1=
3" tabindex=3D"-1" style=3D"">nocheckout</span>=3D1;<span class=3D"" id=3D"=
:1oh.14" tabindex=3D"-1" style=3D"">nobranch</span>=3D1&#39; is invalid and=
 cannot be interpreted</div></div></div></div></blockquote><div dir=3D"ltr"=
><div><br>The .<span class=3D"" id=3D":1oh.15" tabindex=3D"-1" style=3D"">g=
itmodules</span> file used looks like this:<br><br><div>[<span class=3D"" i=
d=3D":1oh.16" tabindex=3D"-1" style=3D"">submodule</span> &quot;<span class=
=3D"" id=3D":1oh.17" tabindex=3D"-1" style=3D"">submodule</span>_name1&quot=
;]</div><div><span style=3D"white-space:pre">	</span>path =3D <span class=
=3D"" id=3D":1oh.18" tabindex=3D"-1" style=3D"">submodule</span>_name1</div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span class=3D"" id=3D":1oh.19" tabindex=3D"-1=
" style=3D"">url</span> =3D git@<span class=3D"" id=3D":1oh.20" tabindex=3D=
"-1" style=3D"">github</span>.com/&lt;user&gt;/&lt;<span class=3D"" id=3D":=
1oh.21" tabindex=3D"-1" style=3D"">submodule</span>_name1&gt;.git=C2=A0</di=
v><div><div>[<span class=3D"" id=3D":1oh.22" tabindex=3D"-1" style=3D"">sub=
module</span> &quot;<span class=3D"" id=3D":1oh.23" tabindex=3D"-1" style=
=3D"">submodule</span>_name2&quot;]<br></div><div><span style=3D"white-spac=
e:pre">	</span>path =3D <span class=3D"" id=3D":1oh.24" tabindex=3D"-1" sty=
le=3D"">submodule</span>_name2</div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
span class=3D"" id=3D":1oh.25" tabindex=3D"-1" style=3D"">url</span> =3D gi=
t@<span class=3D"" id=3D":1oh.26" tabindex=3D"-1" style=3D"">github</span>.=
com/&lt;user&gt;/&lt;<span class=3D"" id=3D":1oh.27" tabindex=3D"-1" style=
=3D"">submodule</span>_name2&gt;.git=C2=A0</div></div><br></div><div>Attach=
ed you find my <span class=3D"" id=3D":1oh.28" tabindex=3D"-1" style=3D"">p=
roposal</span>.</div><div><br></div><div><br></div><div class=3D"gmail_quot=
e"><div dir=3D"ltr">Am Di., 8. Jan. 2019 um 08:48=C2=A0<span class=3D"" id=
=3D":1oh.29" tabindex=3D"-1" style=3D"">Uhr</span> <span class=3D"" id=3D":=
1oh.30" tabindex=3D"-1" style=3D"">schrieb</span> <span class=3D"" id=3D":1=
oh.31" tabindex=3D"-1" style=3D"">Krystian</span> <span class=3D"" id=3D":1=
oh.32" tabindex=3D"-1" style=3D"">Garli=C5=84ski</span> &lt;<span class=3D"=
" id=3D":1oh.33" tabindex=3D"-1" style=3D"">krystian</span>.<span class=3D"=
" id=3D":1oh.34" tabindex=3D"-1" style=3D"">garlinski</span>@<span class=3D=
"" id=3D":1oh.35" tabindex=3D"-1" style=3D"">comarch</span>.pl&gt;:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Git allows to use both =
the proper URI&#39;s and SCP-like short style syntax<br>
for the SSH protocol. This commit changes construction logic to detect whic=
h<br>
one of the two is used in the submodule specification and to build a correc=
t<br>
URI out of it.<br>
<br>
Signed-off-by: Krystian Garli=C5=84ski &lt;<a href=3D"mailto:krystian.garli=
nski@comarch.pl" target=3D"_blank">krystian.garlinski@comarch.pl</a>&gt;<br=
>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 16 ++++++++++++++--<br>
=C2=A01 file changed, 14 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index 35729dbc..95d5f652 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -32,6 +32,7 @@ NOTE: Switching a SRC_URI from &quot;git://&quot; to &quo=
t;gitsm://&quot; requires a clean of your r<br>
=C2=A0import os<br>
=C2=A0import bb<br>
=C2=A0import copy<br>
+import re<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2.git import Git<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
@@ -39,6 +40,8 @@ from=C2=A0 =C2=A0bb.fetch2 import Fetch<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import BBFetchException<br>
<br>
=C2=A0class GitSM(Git):<br>
+=C2=A0 =C2=A0 scp_regex =3D re.compile(r&#39;^([a-zA-Z0-9_]+)@([a-zA-Z0-9.=
_-]+):(.+)$&#39;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def supports(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check to see if a given url can be fetche=
d with git.<br>
@@ -88,8 +91,17 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module_hash =3D module_hash=
.split()[2]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Build new SRC_URI<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 proto =3D uris[module].split(&#3=
9;:&#39;, 1)[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D uris[module].replace(&#3=
9;%s:&#39; % proto, &#39;gitsm:&#39;, 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D uris[module]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D GitSM.scp_regex.match(=
uri)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if match:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # this URI follows=
 the short SCP-like syntax<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D &#39;gitsm=
://{}@{}/{}&#39;.format(match.group(1), match.group(2), match.group(3))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 proto =3D &#39;ssh=
&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 proto =3D uri.spli=
t(&#39;:&#39;, 1)[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D &#39;gitsm=
&#39; + uri[len(proto):]<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &#39;;protocol=3D%=
s&#39; % proto<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;name=3D%s&q=
uot; % module<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;bareclone=
=3D1;nocheckout=3D1;nobranch=3D1&quot;<br>
-- <br>
2.19.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>--=C2=A0<br><br><span c=
lass=3D"" id=3D":1oh.36" tabindex=3D"-1" style=3D"">Cheers</span>,=C2=A0<br=
>Linus</div></div></div></div>

--000000000000ec2e2c057ef4f196--

--000000000000ec2e2f057ef4f198
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fetch2-gitsm.py-Enable-SSH-protocol-option.patch"
Content-Disposition: attachment; 
	filename="0001-fetch2-gitsm.py-Enable-SSH-protocol-option.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jqnz5ir00>
X-Attachment-Id: f_jqnz5ir00

RnJvbSBkNzQyYzI5NTY2MzMwMDdhZWM1ODk0ZmE3OGE4YTgwNjA2OTI1OTJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBaaWVnZXJ0IDxsaW51cy56aWVnZXJ0QGhvbG9wbG90
LmNvbT4KRGF0ZTogVHVlLCA4IEphbiAyMDE5IDE2OjMwOjIyICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gZmV0Y2gyL2dpdHNtLnB5OiBFbmFibGUgU1NIIHByb3RvY29sIG9wdGlvbgoKV2hpbGUgZmV0
Y2hpbmcgZnJvbSBhIHByaXZhdGUgZ2l0IHJlcG8gd2l0aCBzdWJtb2R1bGVzIEkgZW5jb3VudGVy
ZWQgZm9sbG93aW5nIGVycm9yOgoKICAgICAgRVJST1I6IDxyZWNpcGU+IGRvX2ZldGNoOiBUaGUg
VVJMOiAnZ2l0QGdpdGh1Yi5jb20vPHVzZXI+LzxzdWJtb2R1bGVfbmFtZTE+LmdpdDsKICAgICAg
cHJvdG9jb2w9Z2l0QGdpdGh1Yi5jb20vPHVzZXI+LzxzdWJtb2R1bGVfbmFtZTE+LmdpdDtuYW1l
PTxzdWJtb2R1bGVfbmFtZTI+OwogICAgICBiYXJlY2xvbmU9MTtub2NoZWNrb3V0PTE7bm9icmFu
Y2g9MScgaXMgaW52YWxpZCBhbmQgY2Fubm90IGJlIGludGVycHJldGVkCgpUaGUgcmVhc29uIGlz
IHRoYXQgZ2l0c20ucHkgY2Fubm90IGhhbmRsZSB0aGUgc3ludGF4IG9mIGdpdCBzdWJtb2R1bGVz
IHdoaWNoIHVzZQpTU0ggYXMgcHJvdG9jb2wgdHlwZS4gQWZ0ZXIgYSBjb2xvbiBpbiB0aGUgVVJJ
IG9mIGEgc3VibW9kdWxlIGlzIGZvdW5kIHRoZSBzdHJpbmcKYmVmb3JlIHRoZSBjb2xvbiBpcyBh
c3NpZ25lZCBhcyBwcm90b2NvbCB0eXBlLgoKU28gdGhlIGRpZmZlcmVudCBzeW50YXggb2YgZ2l0
IFVSSSdzIGZvciBTU0ggY29ubmVjdGlvbnMgaGFzIHRvIGJlIGNvbnNpZGVyZWQuCgpUbyBmaXgg
dGhpcyB3ZSBzcGxpdCB0aGUgVVJJIGF0IGEgY29sb24uIEFsbCBwcm90b2NvbCB0eXBlcyB0aGF0
IGFyZSBzdXBwb3J0ZWQgYnkKZmV0Y2gyL2dpdC5weSBhbmQgdXNlIFVSSSdzIHVzZSBhIGNvbG9u
IGV4Y2VwdCBTU0guIEluIHRoZSBjYXNlIHRoZXJlIGlzIGEgY29sb24Kd2UgY2FuIHVzZSB0aGUg
c3VmZml4IGFzIHByb3RvY29sIHR5cGUgb3RoZXJ3aXNlIHdlIGFzc2lnbiBTU0ggYXMgcHJvdG9j
b2wuCgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBaaWVnZXJ0IDxsaW51cy56aWVnZXJ0QGhvbG9wbG90
LmNvbT4KLS0tCiBsaWIvYmIvZmV0Y2gyL2dpdHNtLnB5IHwgMTIgKysrKysrKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2xpYi9iYi9mZXRjaDIvZ2l0c20ucHkgYi9saWIvYmIvZmV0Y2gyL2dpdHNtLnB5CmluZGV4IDM1
NzI5ZGJjLi40ZDlmNjAzZCAxMDA2NDQKLS0tIGEvbGliL2JiL2ZldGNoMi9naXRzbS5weQorKysg
Yi9saWIvYmIvZmV0Y2gyL2dpdHNtLnB5CkBAIC04OCw3ICs4OCwxNyBAQCBjbGFzcyBHaXRTTShH
aXQpOgogICAgICAgICAgICAgbW9kdWxlX2hhc2ggPSBtb2R1bGVfaGFzaC5zcGxpdCgpWzJdCiAK
ICAgICAgICAgICAgICMgQnVpbGQgbmV3IFNSQ19VUkkKLSAgICAgICAgICAgIHByb3RvID0gdXJp
c1ttb2R1bGVdLnNwbGl0KCc6JywgMSlbMF0KKyAgICAgICAgICAgIHVyaV9wYXJ0cyA9IHVyaXNb
bW9kdWxlXS5zcGxpdCgnOicsIDEpCisgICAgICAgICAgICBpZiBsZW4odXJpX3BhcnRzKSA+IDE6
CisgICAgICAgICAgICAgICAgcHJvdG8gPSB1cmlfcGFydHNbMF0KKyAgICAgICAgICAgIGVsc2U6
CisgICAgICAgICAgICAjIElmIHRoZXJlIGlzIG5vIGNvbG9uIGluIHVyaSB3ZSBnZXQgdGhlIHBy
b3RvY29sIGZyb20gdGhlIG1vZHVsZQorICAgICAgICAgICAgICAgIHByb3RvID0gdWQucHJvdG8K
KworICAgICAgICAgICAgIHVybCA9IHVyaXNbbW9kdWxlXS5yZXBsYWNlKCclczonICUgcHJvdG8s
ICdnaXRzbTonLCAxKQorICAgICAgICAgICAgaWYgIjovLyIgbm90IGluIHVybDoKKyAgICAgICAg
ICAgICAgICB1cmwgPSAiZ2l0Oi8vJXMiICUgdXJsCisKICAgICAgICAgICAgIHVybCA9IHVyaXNb
bW9kdWxlXS5yZXBsYWNlKCclczonICUgcHJvdG8sICdnaXRzbTonLCAxKQogICAgICAgICAgICAg
dXJsICs9ICc7cHJvdG9jb2w9JXMnICUgcHJvdG8KICAgICAgICAgICAgIHVybCArPSAiO25hbWU9
JXMiICUgbW9kdWxlCi0tIAoyLjE3LjEKCg==

--000000000000ec2e2f057ef4f198
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fetch2-gitsm.py-Enable-SSH-protocol-option.patch"
Content-Disposition: attachment; 
	filename="0001-fetch2-gitsm.py-Enable-SSH-protocol-option.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jqnz67ed1>
X-Attachment-Id: f_jqnz67ed1

RnJvbSBkNzQyYzI5NTY2MzMwMDdhZWM1ODk0ZmE3OGE4YTgwNjA2OTI1OTJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBaaWVnZXJ0IDxsaW51cy56aWVnZXJ0QGhvbG9wbG90
LmNvbT4KRGF0ZTogVHVlLCA4IEphbiAyMDE5IDE2OjMwOjIyICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gZmV0Y2gyL2dpdHNtLnB5OiBFbmFibGUgU1NIIHByb3RvY29sIG9wdGlvbgoKV2hpbGUgZmV0
Y2hpbmcgZnJvbSBhIHByaXZhdGUgZ2l0IHJlcG8gd2l0aCBzdWJtb2R1bGVzIEkgZW5jb3VudGVy
ZWQgZm9sbG93aW5nIGVycm9yOgoKICAgICAgRVJST1I6IDxyZWNpcGU+IGRvX2ZldGNoOiBUaGUg
VVJMOiAnZ2l0QGdpdGh1Yi5jb20vPHVzZXI+LzxzdWJtb2R1bGVfbmFtZTE+LmdpdDsKICAgICAg
cHJvdG9jb2w9Z2l0QGdpdGh1Yi5jb20vPHVzZXI+LzxzdWJtb2R1bGVfbmFtZTE+LmdpdDtuYW1l
PTxzdWJtb2R1bGVfbmFtZTI+OwogICAgICBiYXJlY2xvbmU9MTtub2NoZWNrb3V0PTE7bm9icmFu
Y2g9MScgaXMgaW52YWxpZCBhbmQgY2Fubm90IGJlIGludGVycHJldGVkCgpUaGUgcmVhc29uIGlz
IHRoYXQgZ2l0c20ucHkgY2Fubm90IGhhbmRsZSB0aGUgc3ludGF4IG9mIGdpdCBzdWJtb2R1bGVz
IHdoaWNoIHVzZQpTU0ggYXMgcHJvdG9jb2wgdHlwZS4gQWZ0ZXIgYSBjb2xvbiBpbiB0aGUgVVJJ
IG9mIGEgc3VibW9kdWxlIGlzIGZvdW5kIHRoZSBzdHJpbmcKYmVmb3JlIHRoZSBjb2xvbiBpcyBh
c3NpZ25lZCBhcyBwcm90b2NvbCB0eXBlLgoKU28gdGhlIGRpZmZlcmVudCBzeW50YXggb2YgZ2l0
IFVSSSdzIGZvciBTU0ggY29ubmVjdGlvbnMgaGFzIHRvIGJlIGNvbnNpZGVyZWQuCgpUbyBmaXgg
dGhpcyB3ZSBzcGxpdCB0aGUgVVJJIGF0IGEgY29sb24uIEFsbCBwcm90b2NvbCB0eXBlcyB0aGF0
IGFyZSBzdXBwb3J0ZWQgYnkKZmV0Y2gyL2dpdC5weSBhbmQgdXNlIFVSSSdzIHVzZSBhIGNvbG9u
IGV4Y2VwdCBTU0guIEluIHRoZSBjYXNlIHRoZXJlIGlzIGEgY29sb24Kd2UgY2FuIHVzZSB0aGUg
c3VmZml4IGFzIHByb3RvY29sIHR5cGUgb3RoZXJ3aXNlIHdlIGFzc2lnbiBTU0ggYXMgcHJvdG9j
b2wuCgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBaaWVnZXJ0IDxsaW51cy56aWVnZXJ0QGhvbG9wbG90
LmNvbT4KLS0tCiBsaWIvYmIvZmV0Y2gyL2dpdHNtLnB5IHwgMTIgKysrKysrKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2xpYi9iYi9mZXRjaDIvZ2l0c20ucHkgYi9saWIvYmIvZmV0Y2gyL2dpdHNtLnB5CmluZGV4IDM1
NzI5ZGJjLi40ZDlmNjAzZCAxMDA2NDQKLS0tIGEvbGliL2JiL2ZldGNoMi9naXRzbS5weQorKysg
Yi9saWIvYmIvZmV0Y2gyL2dpdHNtLnB5CkBAIC04OCw3ICs4OCwxNyBAQCBjbGFzcyBHaXRTTShH
aXQpOgogICAgICAgICAgICAgbW9kdWxlX2hhc2ggPSBtb2R1bGVfaGFzaC5zcGxpdCgpWzJdCiAK
ICAgICAgICAgICAgICMgQnVpbGQgbmV3IFNSQ19VUkkKLSAgICAgICAgICAgIHByb3RvID0gdXJp
c1ttb2R1bGVdLnNwbGl0KCc6JywgMSlbMF0KKyAgICAgICAgICAgIHVyaV9wYXJ0cyA9IHVyaXNb
bW9kdWxlXS5zcGxpdCgnOicsIDEpCisgICAgICAgICAgICBpZiBsZW4odXJpX3BhcnRzKSA+IDE6
CisgICAgICAgICAgICAgICAgcHJvdG8gPSB1cmlfcGFydHNbMF0KKyAgICAgICAgICAgIGVsc2U6
CisgICAgICAgICAgICAjIElmIHRoZXJlIGlzIG5vIGNvbG9uIGluIHVyaSB3ZSBnZXQgdGhlIHBy
b3RvY29sIGZyb20gdGhlIG1vZHVsZQorICAgICAgICAgICAgICAgIHByb3RvID0gdWQucHJvdG8K
KworICAgICAgICAgICAgIHVybCA9IHVyaXNbbW9kdWxlXS5yZXBsYWNlKCclczonICUgcHJvdG8s
ICdnaXRzbTonLCAxKQorICAgICAgICAgICAgaWYgIjovLyIgbm90IGluIHVybDoKKyAgICAgICAg
ICAgICAgICB1cmwgPSAiZ2l0Oi8vJXMiICUgdXJsCisKICAgICAgICAgICAgIHVybCA9IHVyaXNb
bW9kdWxlXS5yZXBsYWNlKCclczonICUgcHJvdG8sICdnaXRzbTonLCAxKQogICAgICAgICAgICAg
dXJsICs9ICc7cHJvdG9jb2w9JXMnICUgcHJvdG8KICAgICAgICAgICAgIHVybCArPSAiO25hbWU9
JXMiICUgbW9kdWxlCi0tIAoyLjE3LjEKCg==

--000000000000ec2e2f057ef4f198--
