Return-Path: <zoltan.kuscsik@linaro.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
	[209.85.160.170])
	by mail.openembedded.org (Postfix) with ESMTP id 2E3F260767
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Dec 2015 17:32:45 +0000 (UTC)
Received: by ykba77 with SMTP id a77so15754508ykb.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Dec 2015 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=xh02uG87Wi6/w96NaYiz9h6FWvGKK0A7OJulMBCc/CY=;
	b=P3Eudlv6sgTOYxgREQhBQSAhSupRbUIZy7ius7F4xMn/KvWZcKXhyc8Pg/GKMY8ASv
	PZ7f0SYVUYs8/4y9kSWVS6IkAThhZpJj2jDDfR+Bddfuhgxo/6WhcXVHh6P4Iiu3idxq
	8GAJ8nAGoLsLHC3ea2iJ2hRw29QdwfqjWqdFAQm+CBgukLoJ2I1xk1biFib09DAUQ5zs
	bO8iOUjlLIl3AMcrWHGA4PNi3FeFrG6iIdgfrk/XvPAuwzqTIfCJAkh0sgmUBfpf/fuQ
	EHuF2t7iUG/q0+vYQZ2vIhisC9kVfNHr5c8Zq2P3rljnFCPEBDH09YQICtH4qDh1uUVU
	7bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=xh02uG87Wi6/w96NaYiz9h6FWvGKK0A7OJulMBCc/CY=;
	b=VO+p+CdxkPJKveY4e13s5XuW+3Bzfrmi5DLyy0O5q5F8lVqVEoU5qiEmh1B/Fuyl2s
	Ax9T/PJeP2bpcue5yd1YSy6IKBeX1W04bc4BimOUNXlCbTj4WAaMq/9uNtNCUVNdI/H8
	X5r9JfTQhI9c5ISFPiuJJds37A7B0EADutwsljm1pugR3B8J9c6WHMBn5Jx1Eq0O+qEb
	K6cjrQauEtzOYcRKRV/33NJAgHE7pW3I5disV0O3GNVaRXHLGxngJyP5VMViiTFH6ncK
	wu/FHsZV5SCTP6rX/XeUyscgJ/Y76yVZ1Pxcbg1GeqkzrTpU5SjiQUrxRx3/CCdUXsFK
	avqg==
X-Gm-Message-State: ALoCoQl9t5iR1Xm15gtF4ifxJyJ9DQpeb2IlUHOWp9bwbNxiEMy6zge8J5LmT3HptEbNS4qutp8X
X-Received: by 10.129.147.194 with SMTP id k185mr4967443ywg.284.1448991166406; 
	Tue, 01 Dec 2015 09:32:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.137.5 with HTTP; Tue, 1 Dec 2015 09:32:26 -0800 (PST)
In-Reply-To: <1446609893-7391-1-git-send-email-zoltan.kuscsik@linaro.org>
References: <1446609893-7391-1-git-send-email-zoltan.kuscsik@linaro.org>
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
Date: Tue, 1 Dec 2015 18:32:26 +0100
Message-ID: <CAAzKXnhysioYyu14Hq0g4HHBEHiqyzeenqY3pL=5H7NKS3=Wzw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCHv2] bb.fetch2: added support for gclient
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
X-List-Received-Date: Tue, 01 Dec 2015 17:32:48 -0000
Content-Type: multipart/alternative; boundary=94eb2c07ee24c1c7e50525d98b56

--94eb2c07ee24c1c7e50525d98b56
Content-Type: text/plain; charset=UTF-8

Could someone please take a look on this?

Thank you,

Zoltan

On 4 November 2015 at 05:04, Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
wrote:

> Gclient is tool for updating source code from
> multiple SCM repository locations.
>
> Signed-off-by: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
> ---
>  lib/bb/fetch2/__init__.py |   2 +
>  lib/bb/fetch2/gclient.py  | 151
> ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 lib/bb/fetch2/gclient.py
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 288a1c8..f93446f 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1775,6 +1775,7 @@ from . import hg
>  from . import osc
>  from . import repo
>  from . import clearcase
> +from . import gclient
>
>  methods.append(local.Local())
>  methods.append(wget.Wget())
> @@ -1791,3 +1792,4 @@ methods.append(hg.Hg())
>  methods.append(osc.Osc())
>  methods.append(repo.Repo())
>  methods.append(clearcase.ClearCase())
> +methods.append(gclient.Gclient())
> diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py
> new file mode 100644
> index 0000000..bc46509
> --- /dev/null
> +++ b/lib/bb/fetch2/gclient.py
> @@ -0,0 +1,151 @@
> +# ex:ts=4:sw=4:sts=4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +"""
> +BitBake "Fetch" gclient implementation
> +
> +gclient fetcher support the SRC_URI in the following format:
> +
> +    SRC_URI = "gclient://some.host/path/;optionA=xxx,optionB=xy"
> +
> +Supported SRC_UIR options are:
> +
> +- branch
> +  The git branch of the root gclient project. The default is
> +  "master".
> +
> +- tag
> +  Git tag for gclient to retrieve.
> +
> +- protocol
> +  The method to use for accessing the gclient core project. The default
> +   is https.
> +
> +- project-name
> +  Pass --name command line argument to gclient. Not default is empty.
> +
> +- rev
> +  Specify git commit id for gclient. Default is empty.
> +
> +- deps-file
> +  Set the --deps-file command line argument for gclient.
> +
> +"""
> +
> +# Copyright (C) 2015 Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
> +#
> +# Based on git.py which is:
> +# Copyright (C) 2005 Richard Purdie
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import os
> +import bb
> +from   bb    import data
> +from   bb.fetch2 import FetchMethod
> +from   bb.fetch2 import runfetchcmd
> +import string
> +
> +class Gclient(FetchMethod):
> +    """Class to fetch a module or modules using gclient"""
> +
> +    def __fetch_url(self, ud):
> +        return "%s://%s%s" % (ud.proto, ud.host, ud.path)
> +
> +    def supports(self, ud, d):
> +        """
> +        Check to see if a given url can be fetched with gclient.
> +        """
> +        return ud.type in ["gclient"]
> +
> +    def urldata_init(self, ud, d):
> +        """
> +        Init gclient
> +        """
> +        ud.proto = ud.parm.get('protocol', 'https')
> +
> +        ud.branch = ud.parm.get('branch', 'master')
> +        ud.tag = ud.parm.get('tag','')
> +        ud.rev = ud.parm.get('rev','')
> +
> +        ud.deps_file = ud.parm.get('deps-file', '')
> +        ud.project_name = ud.parm.get('project-name', '')
> +
> +        if( ( ('tag' in ud.parm) + ('branch' in ud.parm) + ('res' in
> ud.parm)) > 1):
> +            raise bb.fetch2.ParameterError("Conflicting revision setting
> SRC_URI. Specify only one of the options: 'branch', 'tag', 'res'.", ud.url)
> +
> +        dldir = d.getVar("DL_DIR", True)
> +
> +        gclient_src_name = 'gclient_%s%s' % (ud.host.replace(':', '.'),
> ud.path.replace('/', '.').replace('*', '.'))
> +
> +        ud.syncdir = os.path.join(dldir, gclient_src_name)
> +        ud.localfile = ud.syncdir
> +
> +        if ud.tag:
> +            ud.revision =  "refs/tags/%s" % ud.tag
> +        elif ud.rev:
> +            ud.revision = ud.rev
> +        else:
> +            ud.revision = "refs/heads/%s" % ud.branch
> +
> +    def download(self, ud, d):
> +        """Fetch url"""
> +
> +        if not os.path.exists(ud.localpath):
> +            bb.utils.mkdirhier(ud.localpath)
> +        os.chdir(ud.localpath)
> +        gclient_url = self.__fetch_url(ud)
> +
> +
> +        # Add optional parameters
> +        extra_params=[]
> +        if ud.deps_file:
> +            extra_params.append("--deps-file=%s" % ud.deps_file)
> +
> +        if ud.project_name:
> +            extra_params.append("--name=%s" % ud.project_name)
> +
> +        extra_args = string.join(extra_params, sep = " ")
> +
> +        runfetchcmd("gclient config %s %s " % (gclient_url, extra_args),
> d)
> +
> +        # Gclient parameters used
> +        # -f                    - force sync
> +        # -nohooks              - skip hooks execution at this time
> +        # --with_branch_heads   - gclient can't find a commit ID if it is
> not in a branch
> +        #
> +        # Note: We should enable --no-history after some more testing
> +
> +        runfetchcmd("gclient sync --with_branch_heads -f  --nohooks
> --revision %s" % ud.revision, d)
> +
> +    def unpack(self, ud, destdir, d):
> +        """ Unpack the src to destdir """
> +        destsuffix = "gclient/"
> +        destdir = ud.destdir = os.path.join(destdir, destsuffix)
> +        # Use rsync for copying. Creating a tar package here would be very
> +        # time consuming.
> +        runfetchcmd("rsync -av %s/ %s/" %(ud.syncdir, destdir), d)
> +        return True
> +
> +    def need_update(self, ud, d):
> +        return True
> +
> +    def clean(self, ud, d):
> +        """ Clean the gclient directory """
> +        bb.utils.remove(ud.localpath, True)
> +
> +    def localpath(self, ud, dr):
> +        return ud.syncdir
> +
> +    def supports_srcrev(self):
> +        return False
> --
> 1.9.1
>
>


-- 
Zoltan Kuscsik

Senior Software Developer, Linaro Digital Home Group
email: zoltan.kuscsik@linaro.org
IRC: zoli_ on irc.linaro.org

--94eb2c07ee24c1c7e50525d98b56
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Could someone please take a look on this?<br><br>Thank you=
,<div><br></div><div>Zoltan</div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On 4 November 2015 at 05:04, Zoltan Kuscsik <span dir=
=3D"ltr">&lt;<a href=3D"mailto:zoltan.kuscsik@linaro.org" target=3D"_blank"=
>zoltan.kuscsik@linaro.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Gclient is tool for updating source code from<br>
multiple SCM repository locations.<br>
<br>
Signed-off-by: Zoltan Kuscsik &lt;<a href=3D"mailto:zoltan.kuscsik@linaro.o=
rg">zoltan.kuscsik@linaro.org</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py |=C2=A0 =C2=A02 +<br>
=C2=A0lib/bb/fetch2/gclient.py=C2=A0 | 151 ++++++++++++++++++++++++++++++++=
++++++++++++++<br>
=C2=A02 files changed, 153 insertions(+)<br>
=C2=A0create mode 100644 lib/bb/fetch2/gclient.py<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index 288a1c8..f93446f 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -1775,6 +1775,7 @@ from . import hg<br>
=C2=A0from . import osc<br>
=C2=A0from . import repo<br>
=C2=A0from . import clearcase<br>
+from . import gclient<br>
<br>
=C2=A0methods.append(local.Local())<br>
=C2=A0methods.append(wget.Wget())<br>
@@ -1791,3 +1792,4 @@ methods.append(hg.Hg())<br>
=C2=A0methods.append(osc.Osc())<br>
=C2=A0methods.append(repo.Repo())<br>
=C2=A0methods.append(clearcase.ClearCase())<br>
+methods.append(gclient.Gclient())<br>
diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py<br>
new file mode 100644<br>
index 0000000..bc46509<br>
--- /dev/null<br>
+++ b/lib/bb/fetch2/gclient.py<br>
@@ -0,0 +1,151 @@<br>
+# ex:ts=3D4:sw=3D4:sts=3D4:et<br>
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-<br>
+&quot;&quot;&quot;<br>
+BitBake &quot;Fetch&quot; gclient implementation<br>
+<br>
+gclient fetcher support the SRC_URI in the following format:<br>
+<br>
+=C2=A0 =C2=A0 SRC_URI =3D &quot;gclient://some.host/path/;optionA=3Dxxx,op=
tionB=3Dxy&quot;<br>
+<br>
+Supported SRC_UIR options are:<br>
+<br>
+- branch<br>
+=C2=A0 The git branch of the root gclient project. The default is<br>
+=C2=A0 &quot;master&quot;.<br>
+<br>
+- tag<br>
+=C2=A0 Git tag for gclient to retrieve.<br>
+<br>
+- protocol<br>
+=C2=A0 The method to use for accessing the gclient core project. The defau=
lt<br>
+=C2=A0 =C2=A0is https.<br>
+<br>
+- project-name<br>
+=C2=A0 Pass --name command line argument to gclient. Not default is empty.=
<br>
+<br>
+- rev<br>
+=C2=A0 Specify git commit id for gclient. Default is empty.<br>
+<br>
+- deps-file<br>
+=C2=A0 Set the --deps-file command line argument for gclient.<br>
+<br>
+&quot;&quot;&quot;<br>
+<br>
+# Copyright (C) 2015 Zoltan Kuscsik &lt;<a href=3D"mailto:zoltan.kuscsik@l=
inaro.org">zoltan.kuscsik@linaro.org</a>&gt;<br>
+#<br>
+# Based on git.py which is:<br>
+# Copyright (C) 2005 Richard Purdie<br>
+#<br>
+# This program is free software; you can redistribute it and/or modify<br>
+# it under the terms of the GNU General Public License version 2 as<br>
+# published by the Free Software Foundation.<br>
+#<br>
+# This program is distributed in the hope that it will be useful,<br>
+# but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+# GNU General Public License for more details.<br>
+#<br>
+# You should have received a copy of the GNU General Public License along<=
br>
+# with this program; if not, write to the Free Software Foundation, Inc.,<=
br>
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+<br>
+import os<br>
+import bb<br>
+from=C2=A0 =C2=A0bb=C2=A0 =C2=A0 import data<br>
+from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>
+from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
+import string<br>
+<br>
+class Gclient(FetchMethod):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Class to fetch a module or modules using g=
client&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def __fetch_url(self, ud):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;%s://%s%s&quot; % (ud.proto, ud.h=
ost, ud.path)<br>
+<br>
+=C2=A0 =C2=A0 def supports(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Check to see if a given url can be fetched wit=
h gclient.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.type in [&quot;gclient&quot;]<br>
+<br>
+=C2=A0 =C2=A0 def urldata_init(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Init gclient<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.proto =3D ud.parm.get(&#39;protocol&#39;, &=
#39;https&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.branch =3D ud.parm.get(&#39;branch&#39;, &#=
39;master&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.tag =3D ud.parm.get(&#39;tag&#39;,&#39;&#39=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.rev =3D ud.parm.get(&#39;rev&#39;,&#39;&#39=
;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.deps_file =3D ud.parm.get(&#39;deps-file&#3=
9;, &#39;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.project_name =3D ud.parm.get(&#39;project-n=
ame&#39;, &#39;&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if( ( (&#39;tag&#39; in ud.parm) + (&#39;branc=
h&#39; in ud.parm) + (&#39;res&#39; in ud.parm)) &gt; 1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.ParameterError(&=
quot;Conflicting revision setting SRC_URI. Specify only one of the options:=
 &#39;branch&#39;, &#39;tag&#39;, &#39;res&#39;.&quot;, ud.url)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dldir =3D d.getVar(&quot;DL_DIR&quot;, True)<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gclient_src_name =3D &#39;gclient_%s%s&#39; % =
(ud.host.replace(&#39;:&#39;, &#39;.&#39;), ud.path.replace(&#39;/&#39;, &#=
39;.&#39;).replace(&#39;*&#39;, &#39;.&#39;))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.syncdir =3D os.path.join(dldir, gclient_src=
_name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D ud.syncdir<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.tag:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D=C2=A0 &quot;refs=
/tags/%s&quot; % ud.tag<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif ud.rev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D ud.rev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D &quot;refs/heads=
/%s&quot; % ud.branch<br>
+<br>
+=C2=A0 =C2=A0 def download(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Fetch url&quot;&quot;&quot;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(ud.localpath):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(ud.localpath)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.localpath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gclient_url =3D self.__fetch_url(ud)<br>
+<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add optional parameters<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params=3D[]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.deps_file:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params.append(&quot;--deps=
-file=3D%s&quot; % ud.deps_file)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.project_name:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params.append(&quot;--name=
=3D%s&quot; % ud.project_name)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args =3D string.join(extra_params, sep =
=3D &quot; &quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;gclient config %s %s &quot; =
% (gclient_url, extra_args), d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Gclient parameters used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # -f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - force sync<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # -nohooks=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - skip hooks execution at this time<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # --with_branch_heads=C2=A0 =C2=A0- gclient ca=
n&#39;t find a commit ID if it is not in a branch<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Note: We should enable --no-history after so=
me more testing<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;gclient sync --with_branch_h=
eads -f=C2=A0 --nohooks --revision %s&quot; % ud.revision, d)<br>
+<br>
+=C2=A0 =C2=A0 def unpack(self, ud, destdir, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Unpack the src to destdir &=
quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 destsuffix =3D &quot;gclient/&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 destdir =3D ud.destdir =3D os.path.join(destdi=
r, destsuffix)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use rsync for copying. Creating a tar packag=
e here would be very<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # time consuming.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;rsync -av %s/ %s/&quot; %(ud=
.syncdir, destdir), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def need_update(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def clean(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Clean the gclient directory=
 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.localpath, True)<br>
+<br>
+=C2=A0 =C2=A0 def localpath(self, ud, dr):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.syncdir<br>
+<br>
+=C2=A0 =C2=A0 def supports_srcrev(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div style=3D"color:rgb(1=
36,136,136)">Zoltan Kuscsik</div><div style=3D"color:rgb(136,136,136)"><br>=
</div><div style=3D"color:rgb(136,136,136)">Senior Software Developer, Lina=
ro Digital Home Group</div><div style=3D"color:rgb(136,136,136)">email: <a =
href=3D"mailto:zoltan.kuscsik@linaro.org" target=3D"_blank">zoltan.kuscsik@=
linaro.org</a></div><div style=3D"color:rgb(136,136,136)"><span style=3D"fo=
nt-size:12.8000001907349px">IRC: zoli_ on=C2=A0</span><a href=3D"http://irc=
.linaro.org/" style=3D"font-size:12.8000001907349px;color:rgb(17,85,204)" t=
arget=3D"_blank">irc.linaro.org</a><br></div></div></div>
</div>

--94eb2c07ee24c1c7e50525d98b56--
