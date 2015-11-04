Return-Path: <zoltan.kuscsik@linaro.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 89D7960125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Nov 2015 13:02:31 +0000 (UTC)
Received: by wmff134 with SMTP id f134so40898199wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Nov 2015 05:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro_org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=T9gT1GWWEiE1Ci7WWVL2lJE9rPbGujz21n9K+LQK5fE=;
	b=Zl9WJrs/b22xIUgFdf3vSHPvQ+x7q4AuRad9GPlhP9Zz7xnqmkqNGMWcZ6YBGvP9Gs
	DBcyi+Isfbc5XE+pZaPEbnmYPDL+CFFGZ6fiW4kgd7IybTDwNaDfKScnCffjDje9FLLw
	9PnCL0JhTI78CPxQiJKbzF/QwVP4YicDeNt+DSfV+Qnrs+YqXbnoJ5WcfawoppkLFvqb
	VTRWmKJUImCAAwOCsoBIkh6XLzXhnsiiY0a3ivlw35FnIcEvNieq5Rey9zwDTEEbN2Qg
	ymDw0Nd2h/BCLo9TorMV9Ke7sSRsIJJhSL8BsCTgqvtwGT9QCEZj/mHy7sqNjjY1/j2g
	hFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=T9gT1GWWEiE1Ci7WWVL2lJE9rPbGujz21n9K+LQK5fE=;
	b=S191hHR6NurYLn7dF+BHuppZvyUU0ox1uXNK1YR85E+UFl7KsiAquCMuxd1WRL79T1
	AnLAztuG0HHRS91z8tVcm+f8I1B5CRUeYLJlEiQdyyfsV6aBylCTkANFKN/GQwk4Rlgq
	ly+fC8Ae1EX1ti7VMbW9p2CoYqjiIsKGX+uS3A5+X8VJIkQnlTOXA6b59B4OEX0SP70D
	/Nj1sNfUmW9ZVHIXfzG0puzVwiVpAZS/1tkIdSNsragXmDheE1U9jK9Z/7VWOHVtus8e
	N4y3PsnwgMGAm32O7U7nxkPvvoeKHvWv6RUGNNcmaow5SEGIVtnC0JjjJXlocSByuywv
	VFKQ==
X-Gm-Message-State: ALoCoQmua1bgCxYOyp8mmQ4B3lLbBOxaxe3Vgb20XXDm8G24C99+dvKlDEMJuglCf9NmVoVl9+EI
X-Received: by 10.28.23.141 with SMTP id 135mr3434705wmx.84.1446642151615;
	Wed, 04 Nov 2015 05:02:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.27.127.213 with HTTP; Wed, 4 Nov 2015 05:02:12 -0800 (PST)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC7C6F013E7B9@xmail3.se.axis.com>
References: <1446567045-31179-1-git-send-email-zoltan.kuscsik@linaro.org>
	<A612847CFE53224C91B23E3A5B48BAC7C6F013E5B9@xmail3.se.axis.com>
	<CAAzKXnj54DBeM0odK58U0yLx438NDLcAEsjHhfksOmPtKzH0JQ@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC7C6F013E7B9@xmail3.se.axis.com>
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
Date: Wed, 4 Nov 2015 14:02:12 +0100
Message-ID: <CAAzKXnhx6_3Ci7YP-v5pJ-r_+2armtFipnuaB4SszRFPgN0b5Q@mail.gmail.com>
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
X-List-Received-Date: Wed, 04 Nov 2015 13:02:33 -0000
Content-Type: multipart/alternative; boundary=001a1147180e90a4270523b69f5a

--001a1147180e90a4270523b69f5a
Content-Type: text/plain; charset=UTF-8

Thanks for noticing it.
I double checked the comments. I believe all of them are processed in v3.

Z

On 4 November 2015 at 12:44, Peter Kjellerstedt <peter.kjellerstedt@axis.com
> wrote:

> You seem to have missed a couple of comments.
>
>
>
> //Peter
>
>
>
> *From:* Zoltan Kuscsik [mailto:zoltan.kuscsik@linaro.org]
> *Sent:* den 4 november 2015 05:08
> *To:* Peter Kjellerstedt
> *Cc:* bitbake-devel@lists.openembedded.org
> *Subject:* Re: [bitbake-devel] [PATCH] bb.fetch2: added support for
> gclient
>
>
>
> Thanks Peter, all comments addressed in PATCHv2.
>
> I also created a test for the patch:
>
>
>
> https://github.com/kuscsik/meta-testing/tree/master/recipes-core/fetcher
>
>
>
> Br,
>
>
>
> Z
>
>
>
> On 4 November 2015 at 01:36, Peter Kjellerstedt <
> peter.kjellerstedt@axis.com> wrote:
>
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
>
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
>
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
>
>
>
> --
>
> Zoltan Kuscsik
>
>
>
> Senior Software Developer, Linaro Digital Home Group
>
> email: zoltan.kuscsik@linaro.org
>
> IRC: zoli_ on irc.linaro.org
>



-- 
Zoltan Kuscsik

Senior Software Developer, Linaro Digital Home Group
email: zoltan.kuscsik@linaro.org
IRC: zoli_ on irc.linaro.org

--001a1147180e90a4270523b69f5a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for noticing it.=C2=A0<div>I double checked the com=
ments. I believe all of them are processed in v3.<div><div><br></div><div>Z=
</div></div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On 4 November 2015 at 12:44, Peter Kjellerstedt <span dir=3D"ltr">&l=
t;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">peter.kj=
ellerstedt@axis.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNor=
mal"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;color:#943634">You seem to have missed a couple of comments.<u></u><u>=
</u></span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#943634"><u></u>=C2=A0<u></u></=
span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,sans-serif;color:#943634">//Peter<u></u><u></u></span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:#943634"><u></u>=C2=A0<u></u></span></p><d=
iv style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.=
0pt"><div><div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:=
3.0pt 0cm 0cm 0cm"><p class=3D"MsoNormal"><b><span style=3D"font-size:11.0p=
t;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> Zoltan Ku=
scsik [mailto:<a href=3D"mailto:zoltan.kuscsik@linaro.org" target=3D"_blank=
">zoltan.kuscsik@linaro.org</a>] <br><b>Sent:</b> den 4 november 2015 05:08=
<br><b>To:</b> Peter Kjellerstedt<br><b>Cc:</b> <a href=3D"mailto:bitbake-d=
evel@lists.openembedded.org" target=3D"_blank">bitbake-devel@lists.openembe=
dded.org</a><br><b>Subject:</b> Re: [bitbake-devel] [PATCH] bb.fetch2: adde=
d support for gclient<u></u><u></u></span></p></div></div><div><div class=
=3D"h5"><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><div><div><p class=
=3D"MsoNormal">Thanks Peter, all comments addressed in PATCHv2. =C2=A0<u></=
u><u></u></p></div><div><p class=3D"MsoNormal">I also created a test for th=
e patch:<u></u><u></u></p><div><div><div><p class=3D"MsoNormal"><u></u>=C2=
=A0<u></u></p></div><div><p class=3D"MsoNormal"><a href=3D"https://github.c=
om/kuscsik/meta-testing/tree/master/recipes-core/fetcher" target=3D"_blank"=
>https://github.com/kuscsik/meta-testing/tree/master/recipes-core/fetcher</=
a><u></u><u></u></p></div><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u><=
/p></div></div></div><div><p class=3D"MsoNormal">Br,<u></u><u></u></p></div=
><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p class=3D=
"MsoNormal">Z<u></u><u></u></p></div></div></div><div><p class=3D"MsoNormal=
"><u></u>=C2=A0<u></u></p><div><p class=3D"MsoNormal">On 4 November 2015 at=
 01:36, Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.co=
m" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt; wrote:<u></u><u></=
u></p><blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padd=
ing:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm"><p class=3D"MsoNo=
rmal">&gt; -----Original Message-----<br>&gt; From: <a href=3D"mailto:bitba=
ke-devel-bounces@lists.openembedded.org" target=3D"_blank">bitbake-devel-bo=
unces@lists.openembedded.org</a> [mailto:<a href=3D"mailto:bitbake-" target=
=3D"_blank">bitbake-</a><br>&gt; <a href=3D"mailto:devel-bounces@lists.open=
embedded.org" target=3D"_blank">devel-bounces@lists.openembedded.org</a>] O=
n Behalf Of Zoltan Kuscsik<br>&gt; Sent: den 3 november 2015 17:11<br>&gt; =
To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blan=
k">bitbake-devel@lists.openembedded.org</a><br>&gt; Subject: [bitbake-devel=
] [PATCH] bb.fetch2: added support for gclient<br>&gt;<br>&gt; Gclient is t=
ool for updating source code from<br>&gt; multiple SCM repository locations=
.<br>&gt;<br>&gt; Signed-off-by: Zoltan Kuscsik &lt;<a href=3D"mailto:zolta=
n.kuscsik@linaro.org" target=3D"_blank">zoltan.kuscsik@linaro.org</a>&gt;<b=
r>&gt; ---<br>&gt;=C2=A0 lib/bb/fetch2/__init__.py |=C2=A0 =C2=A03 +-<br>&g=
t;=C2=A0 lib/bb/fetch2/gclient.py=C2=A0 | 151<br>&gt; +++++++++++++++++++++=
+++++++++++++++++++++++++<br>&gt;=C2=A0 2 files changed, 153 insertions(+),=
 1 deletion(-)<br>&gt;=C2=A0 create mode 100644 lib/bb/fetch2/gclient.py<br=
>&gt;<br>&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init=
__.py<br>&gt; index 288a1c8..5ca3bc7 100644<br>&gt; --- a/lib/bb/fetch2/__i=
nit__.py<br>&gt; +++ b/lib/bb/fetch2/__init__.py<br>&gt; @@ -1529,7 +1529,6=
 @@ class Fetch(object):<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D d=
.getVar(&#39;FILE&#39;, True)<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
cache and fn and fn in urldata_cache:<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self.ud =3D urldata_cache[fn]<br>&gt; -<br><br>Restore=
 the empty line.<u></u><u></u></p><div><div><p class=3D"MsoNormal"><br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for url in urls:<br>&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if url not in self.ud:<br>&gt;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>&gt; @@ -1775,=
6 +1774,7 @@ from . import hg<br>&gt;=C2=A0 from . import osc<br>&gt;=C2=A0=
 from . import repo<br>&gt;=C2=A0 from . import clearcase<br>&gt; +from . i=
mport gclient<br>&gt;<br>&gt;=C2=A0 methods.append(local.Local())<br>&gt;=
=C2=A0 methods.append(wget.Wget())<br>&gt; @@ -1791,3 +1791,4 @@ methods.ap=
pend(hg.Hg())<br>&gt;=C2=A0 methods.append(osc.Osc())<br>&gt;=C2=A0 methods=
.append(repo.Repo())<br>&gt;=C2=A0 methods.append(clearcase.ClearCase())<br=
>&gt; +methods.append(gclient.Gclient())<br>&gt; diff --git a/lib/bb/fetch2=
/gclient.py b/lib/bb/fetch2/gclient.py<br>&gt; new file mode 100644<br>&gt;=
 index 0000000..de06eb5<br>&gt; --- /dev/null<br>&gt; +++ b/lib/bb/fetch2/g=
client.py<br>&gt; @@ -0,0 +1,151 @@<br>&gt; +# ex:ts=3D4:sw=3D4:sts=3D4:et<=
br>&gt; +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-<b=
r>&gt; +&quot;&quot;&quot;<br>&gt; +BitBake &quot;Fetch&quot; gclient imple=
mentation<br>&gt; +<br>&gt; +gclient fetcher support the SRCU_URI in the fo=
llowing format:<u></u><u></u></p></div></div><p class=3D"MsoNormal">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^<br>Correct the spelling of SRC_URI.=
<br><br>&gt; +<br>&gt; +=C2=A0 =C2=A0 SRC_URI =3D &quot;gclient://some.host=
/path/;optionA=3Dxxx,optionB=3Dxy&quot;<br>&gt; +<br>&gt; +Supported SRC_UI=
R options are:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^<b=
r>Correct the spelling of SRC_URI.<br><br>&gt; +<br>&gt; +- branch<br>&gt; =
+=C2=A0 The git branch of the root gclient project. The default is<br>&gt; =
+=C2=A0 &quot;master&quot;.<br>&gt; +<br>&gt; +- tag<br>&gt; +=C2=A0 Git ta=
g for gclient to retrieve.<br>&gt; +<br>&gt; +- protocol<br>&gt; +=C2=A0 Th=
e method to use for accessing the gclient core project. The default<br>&gt;=
 +=C2=A0 =C2=A0is https.<br>&gt; +<br>&gt; +- project-name<br>&gt; +=C2=A0 =
Passing the --name command line argument to gclient. Not default is empty.<=
br><br>Change &quot;Passing&quot; to &quot;Pass&quot; and &quot;Not&quot; t=
o &quot;The&quot;.<u></u><u></u></p><div><div><p class=3D"MsoNormal"><br>&g=
t; +<br>&gt; +- rev<br>&gt; +=C2=A0 Specify git commit id for gclient. Defa=
ult is empty.<br>&gt; +<br>&gt; +- deps-file<br>&gt; +=C2=A0 Set the --deps=
-file command line argument for gclient.<br>&gt; +<br>&gt; +&quot;&quot;&qu=
ot;<br>&gt; +<br>&gt; +# Copyright (C) 2015 Zoltan Kuscsik &lt;<a href=3D"m=
ailto:zoltan.kuscsik@linaro.org" target=3D"_blank">zoltan.kuscsik@linaro.or=
g</a>&gt;<br>&gt; +#<br>&gt; +# Based on git.py which is:<br>&gt; +# Copyri=
ght (C) 2005 Richard Purdie<br>&gt; +#<br>&gt; +# This program is free soft=
ware; you can redistribute it and/or modify<br>&gt; +# it under the terms o=
f the GNU General Public License version 2 as<br>&gt; +# published by the F=
ree Software Foundation.<br>&gt; +#<br>&gt; +# This program is distributed =
in the hope that it will be useful,<br>&gt; +# but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of<br>&gt; +# MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE.=C2=A0 See the<br>&gt; +# GNU General Public License=
 for more details.<br>&gt; +#<br>&gt; +# You should have received a copy of=
 the GNU General Public License along<br>&gt; +# with this program; if not,=
 write to the Free Software Foundation, Inc.,<br>&gt; +# 51 Franklin Street=
, Fifth Floor, Boston, MA 02110-1301 USA.<br>&gt; +<br>&gt; +import os<br>&=
gt; +import bb<br>&gt; +from=C2=A0 =C2=A0bb=C2=A0 =C2=A0 import data<br>&gt=
; +from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>&gt; +from=C2=A0 =C2=A0=
bb.fetch2 import runfetchcmd<br>&gt; +import string<br>&gt; +<br>&gt; +clas=
s Gclient(FetchMethod):<br>&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Class to f=
etch a module or modules using gclient&quot;&quot;&quot;<br>&gt; +<br>&gt; =
+=C2=A0 =C2=A0 def __fetch_url(self, ud):<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return &quot;%s://%s%s&quot; % (ud.proto, ud.host, ud.path)<br>&gt; +<b=
r>&gt; +=C2=A0 =C2=A0 def supports(self, ud, d):<br>&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;&quot;&quot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Check to=
 see if a given url can be fetched with repo.<u></u><u></u></p></div></div>=
<p class=3D"MsoNormal">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^^^^<br>Repo? I thought this was for gclient...<br><br>&gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return ud.type in [&quot;gclient&quot;]<br>&gt; +<br>&gt; +=C2=A0 =
=C2=A0 def urldata_init(self, ud, d):<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;&quot;&quot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Init gclient<br>&gt=
; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ud.proto =3D ud.parm.get(&#39;protocol&#39;, &#39;https&#39;)=
<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.branch =3D ud.parm.get(&=
#39;branch&#39;, &#39;master&#39;)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.=
tag =3D ud.parm.get(&#39;tag&#39;,&#39;&#39;)<br>&gt; +=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ud.rev =3D ud.parm.get(&#39;rev&#39;,&#39;&#39;)<br>&gt; +<br>&gt; =
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.deps_file =3D ud.parm.get(&#39;deps-file&#3=
9;, &#39;&#39;)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.project_name =3D ud=
.parm.get(&#39;project-name&#39;, &#39;&#39;)<br>&gt; +<br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if( ( (&#39;tag&#39; in ud.parm) + (&#39;branch&#39; in u=
d.parm) + (&#39;res&#39; in ud.parm)) &gt; 1):<br><br>Rewrite as:<br><br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (&#39;tag&#39; in ud.parm) + (&#39;branch&#3=
9; in ud.parm) + (&#39;res&#39; in ud.parm) &gt; 1:<br><br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.fetch2.ParameterError(&quot;Confli=
ting revision setting SRC_URI. Setting only one of the options: &#39;branch=
&#39;, &#39;tag&#39;, &#39;res&#39;.&quot;, ud.url)<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^=
^^^^^^^^<br>Correct the spelling of &quot;Conflicting&quot;. Change &quot;r=
evision setting SRC_URI&quot;<br>to &quot;revisions specified in SRC_URI&qu=
ot; and &quot;Setting only&quot; to &quot;Specify only&quot;.<br><br>&gt; +=
<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dldir =3D d.getVar(&quot;DL_DIR&quot;=
, True)<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gclient_src_name =3D=
 &#39;gclient_%s%s&#39; % (ud.host.replace(&#39;:&#39;, &#39;.&#39;), ud.pa=
th.replace(&#39;/&#39;, &#39;.&#39;).replace(&#39;*&#39;, &#39;.&#39;))<br>=
&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.syncdir =3D os.path.join(dld=
ir, gclient_src_name)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D=
 ud.syncdir<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.tag:<br>&g=
t; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D=C2=A0 &quot;r=
efs/tags/%s&quot; % ud.tag<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>Remove unne=
cessary space.<br><br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif ud.rev:<br>&gt=
; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.revision =3D ud.rev<br>&gt;=
 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ud.revision =3D &quot;refs/heads/%s&quot; % ud.branch<br>&gt;=
 +<br>&gt; +=C2=A0 =C2=A0 def download(self, ud, d):<br>&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;&quot;&quot;Fetch url&quot;&quot;&quot;<br>&gt; +<br>&=
gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(ud.localpath):<br>&g=
t; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(ud.localpa=
th)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.localpath)<br>&gt; +=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gclient_url =3D self.__fetch_url(ud)<br>&gt; +<=
br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add optional parameters<br=
>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params=3D[]<br>&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if(ud.deps_file):<br><br>Rewrite as:<br><br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if ud.deps_file:<br><br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 extra_params.append(&quot;--deps-file=3D%s&quot; % ud.deps_file)=
<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(ud.project_name):<br><br=
>Rewrite as:<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.project_name:<u></u><=
u></u></p><div><div><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><=
br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_params.append(&quo=
t;--name=3D%s&quot; % ud.project_name)<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 extra_args =3D string.join(extra_params, sep =3D &quot; &quot;)<=
br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;gclient co=
nfig %s %s &quot; % (gclient_url, extra_args), d)<br>&gt; +<br>&gt; +=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 # Gclient parameters used<br>&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # -f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - force sync<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # -nohooks=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - skip hooks execution at thi=
s time<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # --with_branch_heads=C2=A0 =C2=
=A0- gclient can&#39;t find a commit ID if it is not in a branch<br>&gt; +=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Note: =
We should enable --no-history after some more testing<br>&gt; +<br>&gt; +=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;gclient sync --with_branch_he=
ads -f=C2=A0 --nohooks --revision %s&quot; % ud.revision, d)<br>&gt; +<br>&=
gt; +=C2=A0 =C2=A0 def unpack(self, ud, destdir, d):<br>&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;&quot;&quot; Unpack the src to destdir &quot;&quot;&qu=
ot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 destsuffix =3D &quot;gclient/&quot=
;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 destdir =3D ud.destdir =3D os.path.j=
oin(destdir, destsuffix)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use rsync f=
or copying. Creating a tar package here would be very<br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 # time consuming.<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ru=
nfetchcmd(&quot;rsync -av %s/ %s/&quot; %(ud.syncdir, destdir), d)<br>&gt; =
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 d=
ef need_update(self, ud, d):<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return Tr=
ue<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 def clean(self, ud, d):<br>&gt; +=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Clean the gclient directory &quot;=
&quot;&quot;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.localp=
ath, True)<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 def localpath(self, ud, dr):<br=
>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.syncdir<br>&gt; +<br>&gt; +=C2=
=A0 =C2=A0 def supports_srcrev(self):<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return False<br>&gt; --<br>&gt; 1.9.1<u></u><u></u></p></div></div><p class=
=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span><span style=3D"color:#8=
88888">//Peter</span></span><u></u><u></u></p></blockquote></div><p class=
=3D"MsoNormal"><br><br clear=3D"all"><u></u><u></u></p><div><p class=3D"Mso=
Normal"><u></u>=C2=A0<u></u></p></div><p class=3D"MsoNormal">-- <u></u><u><=
/u></p><div><div><div><p class=3D"MsoNormal"><span style=3D"color:#888888">=
Zoltan Kuscsik<u></u><u></u></span></p></div><div><p class=3D"MsoNormal"><s=
pan style=3D"color:#888888"><u></u>=C2=A0<u></u></span></p></div><div><p cl=
ass=3D"MsoNormal"><span style=3D"color:#888888">Senior Software Developer, =
Linaro Digital Home Group<u></u><u></u></span></p></div><div><p class=3D"Ms=
oNormal"><span style=3D"color:#888888">email: <a href=3D"mailto:zoltan.kusc=
sik@linaro.org" target=3D"_blank">zoltan.kuscsik@linaro.org</a><u></u><u></=
u></span></p></div><div><p class=3D"MsoNormal"><span style=3D"font-size:9.5=
pt;color:#888888">IRC: zoli_ on=C2=A0</span><span style=3D"color:#888888"><=
a href=3D"http://irc.linaro.org/" target=3D"_blank"><span style=3D"font-siz=
e:9.5pt;color:#1155cc">irc.linaro.org</span></a><u></u><u></u></span></p></=
div></div></div></div></div></div></div></div></div></blockquote></div><br>=
<br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature"><div=
 dir=3D"ltr"><div style=3D"color:rgb(136,136,136)">Zoltan Kuscsik</div><div=
 style=3D"color:rgb(136,136,136)"><br></div><div style=3D"color:rgb(136,136=
,136)">Senior Software Developer, Linaro Digital Home Group</div><div style=
=3D"color:rgb(136,136,136)">email: <a href=3D"mailto:zoltan.kuscsik@linaro.=
org" target=3D"_blank">zoltan.kuscsik@linaro.org</a></div><div style=3D"col=
or:rgb(136,136,136)"><span style=3D"font-size:12.8000001907349px">IRC: zoli=
_ on=C2=A0</span><a href=3D"http://irc.linaro.org/" style=3D"font-size:12.8=
000001907349px;color:rgb(17,85,204)" target=3D"_blank">irc.linaro.org</a><b=
r></div></div></div>
</div>

--001a1147180e90a4270523b69f5a--
