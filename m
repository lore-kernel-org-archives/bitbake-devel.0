Return-Path: <t9360341@ntut.org.tw>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail.openembedded.org (Postfix) with ESMTP id 2C3CE74D6E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2018 17:55:07 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id a15-v6so9555630wrm.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2018 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ntut-org-tw.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=ir02Wykh81wCaOuyb/e1k9059y4aK5Oj3fqam0VNXWA=;
	b=bWmYr+a53vS47Ag0W1TO6vBxYSQeRZg+clz9Sn47GtfsoEhmuE3ufBiiV78JumMYU9
	3Ots1rwGZB/dMZoxe+uvuqdP4jCrgJM2TTylX7GNTRBqxKGzMmZKP5n9M3HIWLPY6uk/
	SkLsVi3Kttghit0CYeq7csWNBZjVpBwB4RrfaBoLhwiHfNdoztUrpHysIKwpdmsuUBbR
	AiKkB0iNqXZZ4LXUSOKdD19R72MTNkZun5TSAl2P15VZn9feVPKHqtWMtNqije55MWdZ
	zYwoh6n9hO95h8B75BsNTMCQ12iPJvuvB2l3fNYY903dHROHOI9gN9A6F7F3SKfTzPma
	5sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=ir02Wykh81wCaOuyb/e1k9059y4aK5Oj3fqam0VNXWA=;
	b=COPcUZjM87C/OnWcLgiDXw6GhNwW9bee0euQG0gU3EAW3lAZC3TRc+xgLJujuAkeSK
	Kc/+sAa7iqtgbgRCVd2xyiREXCWKCNoDu+s8vxy21DA+GSJHzs3FU37LB7z8ElWqJUuu
	QrzbCmel1GkvUyfWqfs6yn20EsB7nD43bQ9h2S3XGAtX34Tm5CgB+wezhtEr76CpBnj1
	ow6eVIIzhwYRfrdWFlhpZcy9GQbLEmj9RGBLu2r8K0OxgpsiAFe7/SO7SkDSvXCvlXO7
	DqKR0JcM+uVlKhJJCDWWTDFyfwLXwn5HwN7yZH19qupMcC7sLRCjkjcswyrDseBiFmvS
	HsYQ==
X-Gm-Message-State: ALKqPwdjhXfdMyzyeMNL9u/l4zRDZSbKcsf8d+87m8Sk+UuMb9t9g9Z4
	drbqoVCFuCWRdLU54bkB3OLLQvLnT35N8em607NuMTkXF8M=
X-Google-Smtp-Source: AB8JxZoeVRR8GDDlfJO1aDM7dS0UCu2kLrW1QJTXbWXjn5g6hIUptgmESDDYCwLSjZCbXfcvvdWOpTprc6tgOsIcMfY=
X-Received: by 2002:adf:a6f8:: with SMTP id
	t111-v6mr15992418wrc.161.1526925307507; 
	Mon, 21 May 2018 10:55:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.228.67 with HTTP; Mon, 21 May 2018 10:54:45 -0700 (PDT)
From: =?UTF-8?B?5p6X5a2Q57+U?= <t9360341@ntut.org.tw>
Date: Tue, 22 May 2018 01:54:45 +0800
Message-ID: <CAKDHjadaBtyNMUyCMo5Oycba2OC8su7Te8Dr=sQrFFuGxE7GgA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix import spawn error on Python 3.6.5(Default Python version on Ubuntu 18.04 LTS). - Copy the find_executable() function from python3.5/distutils/spawn.py - npm.py do not need to import spawn
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
X-List-Received-Date: Mon, 21 May 2018 17:55:08 -0000
Content-Type: multipart/alternative; boundary="0000000000008d99d3056cbb0058"

--0000000000008d99d3056cbb0058
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Paul and all,

Thanks for your reply.
1) OK. I will follow the "Commit Patch Message Guidelines" and revise my
patch.
2) I am sorry that I forgot to consider the licensing issue.
    I will remove these codes in my revised patch.
3) I totally agree with you. It's awesome to use "/usr/bin/env <command>
<options>" right here.

Paul Eggleton <paul.eggleton@linux.intel.com> =E6=96=BC 2018=E5=B9=B45=E6=
=9C=8821=E6=97=A5=E9=80=B1=E4=B8=80 12:13 =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi there,
>
> Thanks for the patch. A few comments:
>
> 1) All patches need to have Signed-off-by and a proper commit message.
> Please
> refer to: http://www.openembedded.org/wiki/Commit_Patch_Message_Guideline=
s
>
> 2) We shouldn't be copying in functions verbatim from Python, that's
> potentially problematic for licensing reasons if nothing else.
>
> 3) I wonder, is this even necessary? It should be searching PATH already,
> thus
> we should be able to just put the name of the executable we want to run
> without needing to find the full path. Looking at the other fetcher
> modules we
> typically use "/usr/bin/env <command> <options>" so I think that should
> work
> here as well.
>
> Cheers,
> Paul
>
> On Monday, 21 May 2018 2:51:52 AM NZST Tzu Hsiang Lin wrote:
> > ---
> >  lib/bb/fetch2/clearcase.py | 28 ++++++++++++++++++++++++++--
> >  lib/bb/fetch2/npm.py       |  1 -
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
> > index 36beab6a..28589dbc 100644
> > --- a/lib/bb/fetch2/clearcase.py
> > +++ b/lib/bb/fetch2/clearcase.py
> > @@ -69,7 +69,6 @@ from   bb.fetch2 import FetchMethod
> >  from   bb.fetch2 import FetchError
> >  from   bb.fetch2 import runfetchcmd
> >  from   bb.fetch2 import logger
> > -from   distutils import spawn
> >
> >  class ClearCase(FetchMethod):
> >      """Class to fetch urls via 'clearcase'"""
> > @@ -107,7 +106,7 @@ class ClearCase(FetchMethod):
> >          else:
> >              ud.module =3D ""
> >
> > -        ud.basecmd =3D d.getVar("FETCHCMD_ccrc") or
> spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
> > +        ud.basecmd =3D d.getVar("FETCHCMD_ccrc") or
> _find_executable("cleartool") or _find_executable("rcleartool")
> >
> >          if d.getVar("SRCREV") =3D=3D "INVALID":
> >            raise FetchError("Set a valid SRCREV for the clearcase
> fetcher in
> your recipe, e.g. SRCREV =3D \"/main/LATEST\" or any other label of your
> choice.")
> > @@ -207,6 +206,31 @@ class ClearCase(FetchMethod):
> >              output =3D runfetchcmd(cmd, d, workdir=3Dud.ccasedir)
> >              logger.info("rmview output: %s", output)
> >
> > +    def _find_executable(executable, path=3DNone):
> > +        """Tries to find 'executable' in the directories listed in
> 'path'.
> > +
> > +        A string listing directories separated by 'os.pathsep';
> defaults to
> > +        os.environ['PATH'].  Returns the complete filename or None if
> not
> found.
> > +        """
> > +        if path is None:
> > +            path =3D os.environ['PATH']
> > +
> > +        paths =3D path.split(os.pathsep)
> > +        base, ext =3D os.path.splitext(executable)
> > +
> > +        if (sys.platform =3D=3D 'win32') and (ext !=3D '.exe'):
> > +            executable =3D executable + '.exe'
> > +
> > +        if not os.path.isfile(executable):
> > +            for p in paths:
> > +                f =3D os.path.join(p, executable)
> > +                if os.path.isfile(f):
> > +                    # the file exists, we have a shot at spawn working
> > +                    return f
> > +            return None
> > +        else:
> > +            return executable
> > +
> >      def need_update(self, ud, d):
> >          if ("LATEST" in ud.label) or (ud.customspec and "LATEST" in
> ud.customspec):
> >              ud.identifier +=3D "-%s" % d.getVar("DATETIME",d, True)
> > diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> > index 730c346a..408dfc3d 100644
> > --- a/lib/bb/fetch2/npm.py
> > +++ b/lib/bb/fetch2/npm.py
> > @@ -32,7 +32,6 @@ from   bb.fetch2 import runfetchcmd
> >  from   bb.fetch2 import logger
> >  from   bb.fetch2 import UnpackError
> >  from   bb.fetch2 import ParameterError
> > -from   distutils import spawn
> >
> >  def subprocess_setup():
> >      # Python installs a SIGPIPE handler by default. This is usually no=
t
> what
> >
>
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
>
>
>

--0000000000008d99d3056cbb0058
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear=C2=A0<span style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial;float:none;display:inline">Paul and all,</sp=
an></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for your repl=
y.</div><div>1) OK. I will follow the &quot;Commit Patch Message Guidelines=
&quot; and=C2=A0revise my patch.</div><div>2) I am sorry that I forgot to c=
onsider the licensing issue.</div><div>=C2=A0 =C2=A0 I will remove these co=
des in my revised=20

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">patch</span>.</div><div>3)=C2=A0I totally agree w=
ith you. It&#39;s=C2=A0awesome to use<span style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">=C2=A0<span =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;float:n=
one;display:inline">&quot;/usr/bin/env &lt;command&gt; &lt;options&gt;&quot=
;<span>=C2=A0right here.</span></span></span></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr">Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@l=
inux.intel.com" target=3D"_blank">paul.eggleton@linux.intel.com</a><wbr>&gt=
; =E6=96=BC 2018=E5=B9=B45=E6=9C=8821=E6=97=A5=E9=80=B1=E4=B8=80 12:13 =E5=
=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi there,<br>
<br>
Thanks for the patch. A few comments:<br>
<br>
1) All patches need to have Signed-off-by and a proper commit message. Plea=
se <br>
refer to: <a href=3D"http://www.openembedded.org/wiki/Commit_Patch_Message_=
Guidelines" rel=3D"noreferrer noreferrer" target=3D"_blank">http://www.open=
embedded.org/<wbr>wiki/Commit_Patch_Message_<wbr>Guidelines</a><br>
<br>
2) We shouldn&#39;t be copying in functions verbatim from Python, that&#39;=
s <br>
potentially problematic for licensing reasons if nothing else.<br>
<br>
3) I wonder, is this even necessary? It should be searching PATH already, t=
hus <br>
we should be able to just put the name of the executable we want to run <br=
>
without needing to find the full path. Looking at the other fetcher modules=
 we <br>
typically use &quot;/usr/bin/env &lt;command&gt; &lt;options&gt;&quot; so I=
 think that should work <br>
here as well.<br>
<br>
Cheers,<br>
Paul<br>
<br>
On Monday, 21 May 2018 2:51:52 AM NZST Tzu Hsiang Lin wrote:<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/clearcase.py | 28 ++++++++++++++++++++++++++--<br>
&gt;=C2=A0 lib/bb/fetch2/npm.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
&gt;=C2=A0 2 files changed, 26 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py<b=
r>
&gt; index 36beab6a..28589dbc 100644<br>
&gt; --- a/lib/bb/fetch2/clearcase.py<br>
&gt; +++ b/lib/bb/fetch2/clearcase.py<br>
&gt; @@ -69,7 +69,6 @@ from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>
&gt;=C2=A0 from=C2=A0 =C2=A0bb.fetch2 import FetchError<br>
&gt;=C2=A0 from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
&gt;=C2=A0 from=C2=A0 =C2=A0bb.fetch2 import logger<br>
&gt; -from=C2=A0 =C2=A0distutils import spawn<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class ClearCase(FetchMethod):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Class to fetch urls via &#39;cle=
arcase&#39;&quot;&quot;&quot;<br>
&gt; @@ -107,7 +106,7 @@ class ClearCase(FetchMethod):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.module =3D &quot;&q=
uot;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&quot;FETCHCMD_cc=
rc&quot;) or <br>
spawn.find_executable(&quot;<wbr>cleartool&quot;) or spawn.find_executable(=
&quot;<wbr>rcleartool&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&quot;FETCHCMD_cc=
rc&quot;) or <br>
_find_executable(&quot;cleartool&quot;) or _find_executable(&quot;rcleartoo=
l&quot;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;SRCREV&quot;) =3D=
=3D &quot;INVALID&quot;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Set a =
valid SRCREV for the clearcase fetcher in <br>
your recipe, e.g. SRCREV =3D \&quot;/main/LATEST\&quot; or any other label =
of your <br>
choice.&quot;)<br>
&gt; @@ -207,6 +206,31 @@ class ClearCase(FetchMethod):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D runfetchcmd=
(cmd, d, workdir=3Dud.ccasedir)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logg=
er.info" rel=3D"noreferrer noreferrer" target=3D"_blank">logger.info</a>(&q=
uot;rmview output: %s&quot;, output)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def _find_executable(executable, path=3DNone):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Tries to find &#39;exec=
utable&#39; in the directories listed in &#39;path&#39;.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 A string listing directories separated by=
 &#39;os.pathsep&#39;; defaults to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;PATH&#39;].=C2=A0 Returns=
 the complete filename or None if not <br>
found.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if path is None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D os.environ[&#39;PA=
TH&#39;]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 paths =3D path.split(os.pathsep)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 base, ext =3D os.path.splitext(executable=
)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys.platform =3D=3D &#39;win32&#39;) =
and (ext !=3D &#39;.exe&#39;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 executable =3D executable +=
 &#39;.exe&#39;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.isfile(executable):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for p in paths:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f =3D os.path=
.join(p, executable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.is=
file(f):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # the file exists, we have a shot at spawn working<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return f<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return executable<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def need_update(self, ud, d):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (&quot;LATEST&quot; in ud.label) =
or (ud.customspec and &quot;LATEST&quot; in <br>
ud.customspec):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.identifier +=3D &qu=
ot;-%s&quot; % d.getVar(&quot;DATETIME&quot;,d, True)<br>
&gt; diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
&gt; index 730c346a..408dfc3d 100644<br>
&gt; --- a/lib/bb/fetch2/npm.py<br>
&gt; +++ b/lib/bb/fetch2/npm.py<br>
&gt; @@ -32,7 +32,6 @@ from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
&gt;=C2=A0 from=C2=A0 =C2=A0bb.fetch2 import logger<br>
&gt;=C2=A0 from=C2=A0 =C2=A0bb.fetch2 import UnpackError<br>
&gt;=C2=A0 from=C2=A0 =C2=A0bb.fetch2 import ParameterError<br>
&gt; -from=C2=A0 =C2=A0distutils import spawn<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def subprocess_setup():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Python installs a SIGPIPE handler by default. Th=
is is usually not <br>
what<br>
&gt; <br>
<br>
<br>
-- <br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
<br>
<br>
</blockquote></div></div>

--0000000000008d99d3056cbb0058--
