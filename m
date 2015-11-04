Return-Path: <zoltan.kuscsik@linaro.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 05B5B60034
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Nov 2015 04:08:15 +0000 (UTC)
Received: by wikq8 with SMTP id q8so84318400wik.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Nov 2015 20:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro_org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=iTEseuzk1LzC4GYj1E8oTiCTq+dxlwDVv1Kjjd7rr24=;
	b=b34ZDPO+P8rUXPBSIVUzLysw5GY0VcKWMeGIDrRyg0ih2TSh+0WCvOil6/aAgQVOgI
	S9Lm9u1wfi5KNiQkkAbaihWn60eEQG/Q53H7VC3X4m0wBXp0qRY4TXGbLHOPiYG8MIvk
	geG96/kwk4s0tsSOfKpgc23AUUECvDz7U3o+aJMIdhuoAemlKlP1A3OYqrhUMC1ejBU8
	uKPLdfjoNn9uO+OB8PZQodF/5flSQ0nMBCrTvR8W4IZ/O2kvzR8L6GPsvZV+/r6Es8QY
	ExXQMBQ9xRU7sw46PYP3Jq20KgBBRGa2TFZrU+N+HxITk7AM3UnfFS9QvaBUu0SrOlLP
	f4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=iTEseuzk1LzC4GYj1E8oTiCTq+dxlwDVv1Kjjd7rr24=;
	b=LiKHkuO6MatA+lyxdKf19X8mj/JpoTQ3IaLWtUUIO34fJlZW3dV/T8Phb1/f6LvVTy
	pwxkp7gZ98LB75PSu43NIJJAO6k2Zu5p8bLooRdzY70DXvuKboUUim4ORLwP/m8t1qmn
	IJVtb+5/Qp69Lnk3wrYGyDsjCiLMF80aomAQ1kVKyRCLuK2hK4TGcvzptcSlZ160jDj0
	o53oBOEAITRrbIMtexFYSvZfTUuu233xbJVyMXfwXT4zxJ8EvnGzkghm5BhbMMeRSop4
	4soZDRgWDScU8BXi/iaXUY98wxbqRF+1gmu2o5gfyajseu4aiSQqxmNZOaj6jPFb7i9B
	3LIA==
X-Gm-Message-State: ALoCoQmANZ/HJuRia972BA6GNOZe/ugBvmVlXJFnhZ0k6MHWWrDQmT5pMWBvPKwVhV9sgrdcG69a
X-Received: by 10.194.22.234 with SMTP id h10mr32987113wjf.72.1446610095620;
	Tue, 03 Nov 2015 20:08:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.27.127.213 with HTTP; Tue, 3 Nov 2015 20:07:56 -0800 (PST)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC7C6F013E5B9@xmail3.se.axis.com>
References: <1446567045-31179-1-git-send-email-zoltan.kuscsik@linaro.org>
	<A612847CFE53224C91B23E3A5B48BAC7C6F013E5B9@xmail3.se.axis.com>
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
Date: Wed, 4 Nov 2015 05:07:56 +0100
Message-ID: <CAAzKXnj54DBeM0odK58U0yLx438NDLcAEsjHhfksOmPtKzH0JQ@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bb.fetch2: added support for gclient
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
X-List-Received-Date: Wed, 04 Nov 2015 04:08:16 -0000
Content-Type: multipart/alternative; boundary=047d7b5d56b2e0f58e0523af28eb

--047d7b5d56b2e0f58e0523af28eb
Content-Type: text/plain; charset=UTF-8

Thanks Peter, all comments addressed in PATCHv2.
I also created a test for the patch:

https://github.com/kuscsik/meta-testing/tree/master/recipes-core/fetcher

Br,

Z

On 4 November 2015 at 01:36, Peter Kjellerstedt <peter.kjellerstedt@axis.com
> wrote:

> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Zoltan Kuscsik
> > Sent: den 3 november 2015 17:11
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] bb.fetch2: added support for gclient
> >
> > Gclient is tool for updating source code from
> > multiple SCM repository locations.
> >
> > Signed-off-by: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
> > ---
> >  lib/bb/fetch2/__init__.py |   3 +-
> >  lib/bb/fetch2/gclient.py  | 151
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 153 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/bb/fetch2/gclient.py
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 288a1c8..5ca3bc7 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1529,7 +1529,6 @@ class Fetch(object):
> >          fn = d.getVar('FILE', True)
> >          if cache and fn and fn in urldata_cache:
> >              self.ud = urldata_cache[fn]
> > -
>
> Restore the empty line.
>
> >          for url in urls:
> >              if url not in self.ud:
> >                  try:
> > @@ -1775,6 +1774,7 @@ from . import hg
> >  from . import osc
> >  from . import repo
> >  from . import clearcase
> > +from . import gclient
> >
> >  methods.append(local.Local())
> >  methods.append(wget.Wget())
> > @@ -1791,3 +1791,4 @@ methods.append(hg.Hg())
> >  methods.append(osc.Osc())
> >  methods.append(repo.Repo())
> >  methods.append(clearcase.ClearCase())
> > +methods.append(gclient.Gclient())
> > diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py
> > new file mode 100644
> > index 0000000..de06eb5
> > --- /dev/null
> > +++ b/lib/bb/fetch2/gclient.py
> > @@ -0,0 +1,151 @@
> > +# ex:ts=4:sw=4:sts=4:et
> > +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> > +"""
> > +BitBake "Fetch" gclient implementation
> > +
> > +gclient fetcher support the SRCU_URI in the following format:
>                                ^^^^^^^^
> Correct the spelling of SRC_URI.
>
> > +
> > +    SRC_URI = "gclient://some.host/path/;optionA=xxx,optionB=xy"
> > +
> > +Supported SRC_UIR options are:
>              ^^^^^^^
> Correct the spelling of SRC_URI.
>
> > +
> > +- branch
> > +  The git branch of the root gclient project. The default is
> > +  "master".
> > +
> > +- tag
> > +  Git tag for gclient to retrieve.
> > +
> > +- protocol
> > +  The method to use for accessing the gclient core project. The default
> > +   is https.
> > +
> > +- project-name
> > +  Passing the --name command line argument to gclient. Not default is
> empty.
>
> Change "Passing" to "Pass" and "Not" to "The".
>
> > +
> > +- rev
> > +  Specify git commit id for gclient. Default is empty.
> > +
> > +- deps-file
> > +  Set the --deps-file command line argument for gclient.
> > +
> > +"""
> > +
> > +# Copyright (C) 2015 Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
> > +#
> > +# Based on git.py which is:
> > +# Copyright (C) 2005 Richard Purdie
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License version 2 as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> along
> > +# with this program; if not, write to the Free Software Foundation,
> Inc.,
> > +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > +
> > +import os
> > +import bb
> > +from   bb    import data
> > +from   bb.fetch2 import FetchMethod
> > +from   bb.fetch2 import runfetchcmd
> > +import string
> > +
> > +class Gclient(FetchMethod):
> > +    """Class to fetch a module or modules using gclient"""
> > +
> > +    def __fetch_url(self, ud):
> > +        return "%s://%s%s" % (ud.proto, ud.host, ud.path)
> > +
> > +    def supports(self, ud, d):
> > +        """
> > +        Check to see if a given url can be fetched with repo.
>                                                            ^^^^
> Repo? I thought this was for gclient...
>
> > +        """
> > +        return ud.type in ["gclient"]
> > +
> > +    def urldata_init(self, ud, d):
> > +        """
> > +        Init gclient
> > +        """
> > +        ud.proto = ud.parm.get('protocol', 'https')
> > +
> > +        ud.branch = ud.parm.get('branch', 'master')
> > +        ud.tag = ud.parm.get('tag','')
> > +        ud.rev = ud.parm.get('rev','')
> > +
> > +        ud.deps_file = ud.parm.get('deps-file', '')
> > +        ud.project_name = ud.parm.get('project-name', '')
> > +
> > +        if( ( ('tag' in ud.parm) + ('branch' in ud.parm) + ('res' in
> ud.parm)) > 1):
>
> Rewrite as:
>
>         if ('tag' in ud.parm) + ('branch' in ud.parm) + ('res' in ud.parm)
> > 1:
>
> > +            raise bb.fetch2.ParameterError("Confliting revision setting
> SRC_URI. Setting only one of the options: 'branch', 'tag', 'res'.", ud.url)
>                                                ^^^^^^^^^^
> Correct the spelling of "Conflicting". Change "revision setting SRC_URI"
> to "revisions specified in SRC_URI" and "Setting only" to "Specify only".
>
> > +
> > +        dldir = d.getVar("DL_DIR", True)
> > +
> > +        gclient_src_name = 'gclient_%s%s' % (ud.host.replace(':', '.'),
> ud.path.replace('/', '.').replace('*', '.'))
> > +
> > +        ud.syncdir = os.path.join(dldir, gclient_src_name)
> > +        ud.localfile = ud.syncdir
> > +
> > +        if ud.tag:
> > +            ud.revision =  "refs/tags/%s" % ud.tag
>                              ^
> Remove unnecessary space.
>
> > +        elif ud.rev:
> > +            ud.revision = ud.rev
> > +        else:
> > +            ud.revision = "refs/heads/%s" % ud.branch
> > +
> > +    def download(self, ud, d):
> > +        """Fetch url"""
> > +
> > +        if not os.path.exists(ud.localpath):
> > +            bb.utils.mkdirhier(ud.localpath)
> > +        os.chdir(ud.localpath)
> > +        gclient_url = self.__fetch_url(ud)
> > +
> > +
> > +        # Add optional parameters
> > +        extra_params=[]
> > +        if(ud.deps_file):
>
> Rewrite as:
>
>         if ud.deps_file:
>
> > +            extra_params.append("--deps-file=%s" % ud.deps_file)
> > +
> > +        if(ud.project_name):
>
> Rewrite as:
>
>         if ud.project_name:
>
> > +            extra_params.append("--name=%s" % ud.project_name)
> > +
> > +        extra_args = string.join(extra_params, sep = " ")
> > +
> > +        runfetchcmd("gclient config %s %s " % (gclient_url,
> extra_args), d)
> > +
> > +        # Gclient parameters used
> > +        # -f                    - force sync
> > +        # -nohooks              - skip hooks execution at this time
> > +        # --with_branch_heads   - gclient can't find a commit ID if it
> is not in a branch
> > +        #
> > +        # Note: We should enable --no-history after some more testing
> > +
> > +        runfetchcmd("gclient sync --with_branch_heads -f  --nohooks
> --revision %s" % ud.revision, d)
> > +
> > +    def unpack(self, ud, destdir, d):
> > +        """ Unpack the src to destdir """
> > +        destsuffix = "gclient/"
> > +        destdir = ud.destdir = os.path.join(destdir, destsuffix)
> > +        # Use rsync for copying. Creating a tar package here would be
> very
> > +        # time consuming.
> > +        runfetchcmd("rsync -av %s/ %s/" %(ud.syncdir, destdir), d)
> > +        return True
> > +
> > +    def need_update(self, ud, d):
> > +        return True
> > +
> > +    def clean(self, ud, d):
> > +        """ Clean the gclient directory """
> > +        bb.utils.remove(ud.localpath, True)
> > +
> > +    def localpath(self, ud, dr):
> > +        return ud.syncdir
> > +
> > +    def supports_srcrev(self):
> > +        return False
> > --
> > 1.9.1
>
> //Peter
>
>


-- 
Zoltan Kuscsik

Senior Software Developer, Linaro Digital Home Group
email: zoltan.kuscsik@linaro.org
IRC: zoli_ on irc.linaro.org

--047d7b5d56b2e0f58e0523af28eb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Peter, all comments addressed in PATCHv2. =C2=
=A0<br></div><div>I also created a test for the patch:<div><div><div><br></=
div><div><a href=3D"https://github.com/kuscsik/meta-testing/tree/master/rec=
ipes-core/fetcher">https://github.com/kuscsik/meta-testing/tree/master/reci=
pes-core/fetcher</a><br></div><div><br></div></div></div><div>Br,</div><div=
><br></div><div>Z</div></div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On 4 November 2015 at 01:36, Peter Kjellerstedt <span dir=
=3D"ltr">&lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blan=
k">peter.kjellerstedt@axis.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org">=
bitbake-devel-bounces@lists.openembedded.org</a> [mailto:<a href=3D"mailto:=
bitbake-">bitbake-</a><br>
&gt; <a href=3D"mailto:devel-bounces@lists.openembedded.org">devel-bounces@=
lists.openembedded.org</a>] On Behalf Of Zoltan Kuscsik<br>
&gt; Sent: den 3 november 2015 17:11<br>
&gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-de=
vel@lists.openembedded.org</a><br>
&gt; Subject: [bitbake-devel] [PATCH] bb.fetch2: added support for gclient<=
br>
&gt;<br>
&gt; Gclient is tool for updating source code from<br>
&gt; multiple SCM repository locations.<br>
&gt;<br>
&gt; Signed-off-by: Zoltan Kuscsik &lt;<a href=3D"mailto:zoltan.kuscsik@lin=
aro.org">zoltan.kuscsik@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/__init__.py |=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 lib/bb/fetch2/gclient.py=C2=A0 | 151<br>
&gt; ++++++++++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 153 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 lib/bb/fetch2/gclient.py<br>
&gt;<br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index 288a1c8..5ca3bc7 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -1529,7 +1529,6 @@ class Fetch(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D d.getVar(&#39;FILE&#39;, True=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if cache and fn and fn in urldata_ca=
che:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ud =3D urldata_ca=
che[fn]<br>
&gt; -<br>
<br>
</span>Restore the empty line.<br>
<div><div class=3D"h5"><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for url in urls:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if url not in self.ud:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; @@ -1775,6 +1774,7 @@ from . import hg<br>
&gt;=C2=A0 from . import osc<br>
&gt;=C2=A0 from . import repo<br>
&gt;=C2=A0 from . import clearcase<br>
&gt; +from . import gclient<br>
&gt;<br>
&gt;=C2=A0 methods.append(local.Local())<br>
&gt;=C2=A0 methods.append(wget.Wget())<br>
&gt; @@ -1791,3 +1791,4 @@ methods.append(hg.Hg())<br>
&gt;=C2=A0 methods.append(osc.Osc())<br>
&gt;=C2=A0 methods.append(repo.Repo())<br>
&gt;=C2=A0 methods.append(clearcase.ClearCase())<br>
&gt; +methods.append(gclient.Gclient())<br>
&gt; diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000..de06eb5<br>
&gt; --- /dev/null<br>
&gt; +++ b/lib/bb/fetch2/gclient.py<br>
&gt; @@ -0,0 +1,151 @@<br>
&gt; +# ex:ts=3D4:sw=3D4:sts=3D4:et<br>
&gt; +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +BitBake &quot;Fetch&quot; gclient implementation<br>
&gt; +<br>
&gt; +gclient fetcher support the SRCU_URI in the following format:<br>
</div></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^<br>
Correct the spelling of SRC_URI.<br>
<span class=3D""><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 SRC_URI =3D &quot;gclient://some.host/path/;optionA=3Dx=
xx,optionB=3Dxy&quot;<br>
&gt; +<br>
&gt; +Supported SRC_UIR options are:<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^<br>
Correct the spelling of SRC_URI.<br>
<span class=3D""><br>
&gt; +<br>
&gt; +- branch<br>
&gt; +=C2=A0 The git branch of the root gclient project. The default is<br>
&gt; +=C2=A0 &quot;master&quot;.<br>
&gt; +<br>
&gt; +- tag<br>
&gt; +=C2=A0 Git tag for gclient to retrieve.<br>
&gt; +<br>
&gt; +- protocol<br>
&gt; +=C2=A0 The method to use for accessing the gclient core project. The =
default<br>
&gt; +=C2=A0 =C2=A0is https.<br>
&gt; +<br>
&gt; +- project-name<br>
&gt; +=C2=A0 Passing the --name command line argument to gclient. Not defau=
lt is empty.<br>
<br>
</span>Change &quot;Passing&quot; to &quot;Pass&quot; and &quot;Not&quot; t=
o &quot;The&quot;.<br>
<div><div class=3D"h5"><br>
&gt; +<br>
&gt; +- rev<br>
&gt; +=C2=A0 Specify git commit id for gclient. Default is empty.<br>
&gt; +<br>
&gt; +- deps-file<br>
&gt; +=C2=A0 Set the --deps-file command line argument for gclient.<br>
&gt; +<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +# Copyright (C) 2015 Zoltan Kuscsik &lt;<a href=3D"mailto:zoltan.kusc=
sik@linaro.org">zoltan.kuscsik@linaro.org</a>&gt;<br>
&gt; +#<br>
&gt; +# Based on git.py which is:<br>
&gt; +# Copyright (C) 2005 Richard Purdie<br>
&gt; +#<br>
&gt; +# This program is free software; you can redistribute it and/or modif=
y<br>
&gt; +# it under the terms of the GNU General Public License version 2 as<b=
r>
&gt; +# published by the Free Software Foundation.<br>
&gt; +#<br>
&gt; +# This program is distributed in the hope that it will be useful,<br>
&gt; +# but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<=
br>
&gt; +# GNU General Public License for more details.<br>
&gt; +#<br>
&gt; +# You should have received a copy of the GNU General Public License a=
long<br>
&gt; +# with this program; if not, write to the Free Software Foundation, I=
nc.,<br>
&gt; +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
&gt; +<br>
&gt; +import os<br>
&gt; +import bb<br>
&gt; +from=C2=A0 =C2=A0bb=C2=A0 =C2=A0 import data<br>
&gt; +from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>
&gt; +from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
&gt; +import string<br>
&gt; +<br>
&gt; +class Gclient(FetchMethod):<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Class to fetch a module or modules us=
ing gclient&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __fetch_url(self, ud):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;%s://%s%s&quot; % (ud.proto,=
 ud.host, ud.path)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def supports(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Check to see if a given url can be fetche=
d with repo.<br>
</div></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^=
^^<br>
Repo? I thought this was for gclient...<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.type in [&quot;gclient&quot;]<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def urldata_init(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Init gclient<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.proto =3D ud.parm.get(&#39;protocol&#3=
9;, &#39;https&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.branch =3D ud.parm.get(&#39;branch&#39=
;, &#39;master&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.tag =3D ud.parm.get(&#39;tag&#39;,&#39=
;&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.rev =3D ud.parm.get(&#39;rev&#39;,&#39=
;&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.deps_file =3D ud.parm.get(&#39;deps-fi=
le&#39;, &#39;&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.project_name =3D ud.parm.get(&#39;proj=
ect-name&#39;, &#39;&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if( ( (&#39;tag&#39; in ud.parm) + (&#39;=
branch&#39; in ud.parm) + (&#39;res&#39; in ud.parm)) &gt; 1):<br>
<br>
</span>Rewrite as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (&#39;tag&#39; in ud.parm) + (&#39;branch&#3=
9; in ud.parm) + (&#39;res&#39; in ud.parm) &gt; 1:<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.ParameterEr=
ror(&quot;Confliting revision setting SRC_URI. Setting only one of the opti=
ons: &#39;branch&#39;, &#39;tag&#39;, &#39;res&#39;.&quot;, ud.url)<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^<br>
Correct the spelling of &quot;Conflicting&quot;. Change &quot;revision sett=
ing SRC_URI&quot;<br>
to &quot;revisions specified in SRC_URI&quot; and &quot;Setting only&quot; =
to &quot;Specify only&quot;.<br>
<span class=3D""><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dldir =3D d.getVar(&quot;DL_DIR&quot;, Tr=
ue)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gclient_src_name =3D &#39;gclient_%s%s&#3=
9; % (ud.host.replace(&#39;:&#39;, &#39;.&#39;), ud.path.replace(&#39;/&#39=
;, &#39;.&#39;).replace(&#39;*&#39;, &#39;.&#39;))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.syncdir =3D os.path.join(dldir, gclien=
t_src_name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D ud.syncdir<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.tag:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D=C2=A0 &quot=
;refs/tags/%s&quot; % ud.tag<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
Remove unnecessary space.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif ud.rev:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D ud.rev<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D &quot;refs/=
heads/%s&quot; % ud.branch<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def download(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Fetch url&quot;&quot;&q=
uot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(ud.localpath):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(ud.local=
path)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.localpath)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gclient_url =3D self.__fetch_url(ud)<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add optional parameters<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params=3D[]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(ud.deps_file):<br>
<br>
</span>Rewrite as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.deps_file:<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params.append(&quot;-=
-deps-file=3D%s&quot; % ud.deps_file)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(ud.project_name):<br>
<br>
</span>Rewrite as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.project_name:<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params.append(&quot;-=
-name=3D%s&quot; % ud.project_name)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args =3D string.join(extra_params, =
sep =3D &quot; &quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;gclient config %s %s &q=
uot; % (gclient_url, extra_args), d)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Gclient parameters used<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # -f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - force sync<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # -nohooks=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - skip hooks execution at this time<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # --with_branch_heads=C2=A0 =C2=A0- gclie=
nt can&#39;t find a commit ID if it is not in a branch<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Note: We should enable --no-history aft=
er some more testing<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;gclient sync --with_bra=
nch_heads -f=C2=A0 --nohooks --revision %s&quot; % ud.revision, d)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def unpack(self, ud, destdir, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Unpack the src to dest=
dir &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 destsuffix =3D &quot;gclient/&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 destdir =3D ud.destdir =3D os.path.join(d=
estdir, destsuffix)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use rsync for copying. Creating a tar p=
ackage here would be very<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # time consuming.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;rsync -av %s/ %s/&quot;=
 %(ud.syncdir, destdir), d)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def need_update(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def clean(self, ud, d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Clean the gclient dire=
ctory &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.localpath, True)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def localpath(self, ud, dr):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.syncdir<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def supports_srcrev(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
&gt; --<br>
&gt; 1.9.1<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">//Peter<br>
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

--047d7b5d56b2e0f58e0523af28eb--
