Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
	[209.85.223.169])
	by mail.openembedded.org (Postfix) with ESMTP id 50F1776645
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 18:17:58 +0000 (UTC)
Received: by ioeg141 with SMTP id g141so93638269ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=BuCs1YNftE6V95GFFBkKNptkmffNVJ7HsyOm54UKthE=;
	b=mLl6Bsd8f/3ZLqxiUCheNH7hhx2cSWakOuy1gjK8xBwsmMJgrXZXK1S9tMlvJX3i7p
	sB6tWHv7OfA3LBY7OCun7njK/lOWWDjhoYA86+05i3GZR2djqIaQ4NPfHa7KFzsyqiZ6
	7Ro6kDDX5OsSgQTe5M+p1tJKuYg2q3zfdfLN2QZdtNtC41zUWP5b9D/7IwpjxH2hoWKZ
	UxersD/DWZOOtne94K1aVswcHLd31/X0wIFlEJfpEAeRwCzx6Vva7baYo904GLjXu1FN
	RG+aDFlwITN2pBgzewE1SjVZcMKYW0P20cAIxbpdnL7fdJMkQK8fu4JJKFWDxumCuPHm
	Zx4A==
X-Received: by 10.107.15.210 with SMTP id 79mr7186507iop.192.1438366679005;
	Fri, 31 Jul 2015 11:17:59 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.199 with HTTP; Fri, 31 Jul 2015 11:17:39 -0700 (PDT)
In-Reply-To: <1438366606-23283-1-git-send-email-kergoth@gmail.com>
References: <1438366606-23283-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 31 Jul 2015 11:17:39 -0700
X-Google-Sender-Auth: FYDtgqYt4oSbCrGy19boO4Iyk5o
Message-ID: <CABcZANkk2O2oFBHGamAddjLmNOGuz-DCOs9N1NMpDznqY_rLoQ@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 1/2] bb.cookerdata: don't show traceback for ParseError/ExpansionError
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
X-List-Received-Date: Fri, 31 Jul 2015 18:17:59 -0000
Content-Type: multipart/alternative; boundary=001a113fe63af57eaa051c2fd696

--001a113fe63af57eaa051c2fd696
Content-Type: text/plain; charset=UTF-8

On Fri, Jul 31, 2015 at 11:16 AM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> Tracebacks are of extremely limited usefulness in this context. The
> exceptions
> carry the necessary context already, and the user doesn't care about the
> calls
> in bitbake internals that led to an expansion or parse failure.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>


Example of a parse error:

    ERROR: Traceback (most recent call last):
      File "/scratch/poky/bitbake/lib/bb/cookerdata.py", line 175, in
wrapped
        return func(fn, *args)
      File "/scratch/poky/bitbake/lib/bb/cookerdata.py", line 185, in
parse_config_file
        return bb.parse.handle(fn, data, include)
      File "/scratch/poky/bitbake/lib/bb/parse/__init__.py", line 108, in
handle
        return h['handle'](fn, data, include)
      File "/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py",
line 155, in handle
        statements.eval(data)
      File "/scratch/poky/bitbake/lib/bb/parse/ast.py", line 39, in eval
        statement.eval(data)
      File "/scratch/poky/bitbake/lib/bb/parse/ast.py", line 63, in eval
        bb.parse.ConfHandler.include(self.filename, s, self.lineno, data,
False)
      File "/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py",
line 106, in include
        raise ParseError("Error parsing %s: %s" % (fn, exc.strerror),
parentfn, lineno)
    ParseError: ParseError at /scratch/poky/meta/conf/bitbake.conf:679:
Error parsing /scratch/build/conf/local.conf: Permission denied

ERROR: Unable to parse conf/bitbake.conf: ParseError at
/scratch/poky/meta/conf/bitbake.conf:679: Error parsing
/scratch/build/conf/local.
conf: Permission denied

Example of an expansion error:

    ERROR: Traceback (most recent call last):
      File "/scratch/poky/bitbake/lib/bb/cookerdata.py", line 175, in
wrapped
        return func(fn, *args)
      File "/scratch/poky/bitbake/lib/bb/cookerdata.py", line 185, in
parse_config_file
        return bb.parse.handle(fn, data, include)
      File "/scratch/poky/bitbake/lib/bb/parse/__init__.py", line 108, in
handle
        return h['handle'](fn, data, include)
      File "/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py",
line 155, in handle
        statements.eval(data)
      File "/scratch/poky/bitbake/lib/bb/parse/ast.py", line 39, in eval
        statement.eval(data)
      File "/scratch/poky/bitbake/lib/bb/parse/ast.py", line 63, in eval
        bb.parse.ConfHandler.include(self.filename, s, self.lineno, data,
False)
      File "/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py",
line 96, in include
        bb.parse.handle(fn, data, True)
      File "/scratch/poky/bitbake/lib/bb/parse/__init__.py", line 108, in
handle
        return h['handle'](fn, data, include)
      File "/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py",
line 155, in handle
        statements.eval(data)
      File "/scratch/poky/bitbake/lib/bb/parse/ast.py", line 39, in eval
        statement.eval(data)
      File "/scratch/poky/bitbake/lib/bb/parse/ast.py", line 111, in eval
        val = e.expand(groupd["value"], key + "[:=]")
      File "/scratch/poky/bitbake/lib/bb/data_smart.py", line 380, in expand
        return self.expandWithRefs(s, varname).value
      File "/scratch/poky/bitbake/lib/bb/data_smart.py", line 370, in
expandWithRefs
        raise ExpansionError(varname, s, exc)
    ExpansionError: Failure expanding variable FOO[:=], expression was
${@alpha beta theta} which triggered exception SyntaxError: invalid syntax
(FOO[:=], line 1)

    ERROR: Unable to parse conf/bitbake.conf: Failure expanding variable
FOO[:=], expression was ${@alpha beta theta} which triggered exception
SyntaxError: invalid syntax (FOO[:=]
    , line 1)


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113fe63af57eaa051c2fd696
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Jul 31, 2015 at 11:16 AM, Christopher Larson <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">ker=
goth@gmail.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">From: Christopher Larson =
&lt;<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&=
gt;<br>
<br>
Tracebacks are of extremely limited usefulness in this context. The excepti=
ons<br>
carry the necessary context already, and the user doesn&#39;t care about th=
e calls<br>
in bitbake internals that led to an expansion or parse failure.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</blockquote><div><br></div><div>Examp=
le of a parse error:</div><div><br></div><div>=C2=A0 =C2=A0 ERROR: Tracebac=
k (most recent call last):</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scrat=
ch/poky/bitbake/lib/bb/cookerdata.py&quot;, line 175, in wrapped</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return func(fn, *args)</div><div>=C2=A0 =C2=A0 =
=C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/cookerdata.py&quot;, line 18=
5, in parse_config_file</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bb.par=
se.handle(fn, data, include)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scr=
atch/poky/bitbake/lib/bb/parse/__init__.py&quot;, line 108, in handle</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return h[&#39;handle&#39;](fn, data, inclu=
de)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/=
parse/parse_py/ConfHandler.py&quot;, line 155, in handle</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 statements.eval(data)</div><div>=C2=A0 =C2=A0 =C2=A0 F=
ile &quot;/scratch/poky/bitbake/lib/bb/parse/ast.py&quot;, line 39, in eval=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 statement.eval(data)</div><div>=C2=
=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/parse/ast.py&quot=
;, line 63, in eval</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.parse.ConfHand=
ler.include(self.filename, s, self.lineno, data, False)</div><div>=C2=A0 =
=C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHa=
ndler.py&quot;, line 106, in include</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
raise ParseError(&quot;Error parsing %s: %s&quot; % (fn, exc.strerror), par=
entfn, lineno)</div><div>=C2=A0 =C2=A0 ParseError: ParseError at /scratch/p=
oky/meta/conf/bitbake.conf:679: Error parsing /scratch/build/conf/local.con=
f: Permission denied</div><div><br></div><div>ERROR: Unable to parse conf/b=
itbake.conf: ParseError at /scratch/poky/meta/conf/bitbake.conf:679: Error =
parsing /scratch/build/conf/local.</div><div>conf: Permission denied</div><=
div><br></div><div>Example of an expansion error:</div><div><br></div><div>=
=C2=A0 =C2=A0 ERROR: Traceback (most recent call last):</div><div>=C2=A0 =
=C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/cookerdata.py&quot;, =
line 175, in wrapped</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return func(fn, =
*args)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/=
bb/cookerdata.py&quot;, line 185, in parse_config_file</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return bb.parse.handle(fn, data, include)</div><div>=C2=
=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/parse/__init__.py=
&quot;, line 108, in handle</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return h[=
&#39;handle&#39;](fn, data, include)</div><div>=C2=A0 =C2=A0 =C2=A0 File &q=
uot;/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py&quot;, line =
155, in handle</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 statements.eval(data)<=
/div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/pars=
e/ast.py&quot;, line 39, in eval</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 stat=
ement.eval(data)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bi=
tbake/lib/bb/parse/ast.py&quot;, line 63, in eval</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bb.parse.ConfHandler.include(self.filename, s, self.lineno, d=
ata, False)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake=
/lib/bb/parse/parse_py/ConfHandler.py&quot;, line 96, in include</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.parse.handle(fn, data, True)</div><div>=C2=
=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/parse/__init__.py=
&quot;, line 108, in handle</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return h[=
&#39;handle&#39;](fn, data, include)</div><div>=C2=A0 =C2=A0 =C2=A0 File &q=
uot;/scratch/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py&quot;, line =
155, in handle</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 statements.eval(data)<=
/div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/pars=
e/ast.py&quot;, line 39, in eval</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 stat=
ement.eval(data)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bi=
tbake/lib/bb/parse/ast.py&quot;, line 111, in eval</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 val =3D e.expand(groupd[&quot;value&quot;], key + &quot;[:=3D=
]&quot;)</div><div>=C2=A0 =C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/li=
b/bb/data_smart.py&quot;, line 380, in expand</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return self.expandWithRefs(s, varname).value</div><div>=C2=A0 =
=C2=A0 =C2=A0 File &quot;/scratch/poky/bitbake/lib/bb/data_smart.py&quot;, =
line 370, in expandWithRefs</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exp=
ansionError(varname, s, exc)</div><div>=C2=A0 =C2=A0 ExpansionError: Failur=
e expanding variable FOO[:=3D], expression was ${@alpha beta theta} which t=
riggered exception SyntaxError: invalid syntax (FOO[:=3D], line 1)</div><di=
v><br></div><div>=C2=A0 =C2=A0 ERROR: Unable to parse conf/bitbake.conf: Fa=
ilure expanding variable FOO[:=3D], expression was ${@alpha beta theta} whi=
ch triggered exception SyntaxError: invalid syntax (FOO[:=3D]</div><div>=C2=
=A0 =C2=A0 , line 1)</div><div>=C2=A0</div></div><div><br></div>-- <br><div=
 class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>kergoth a=
t gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintaine=
r - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--001a113fe63af57eaa051c2fd696--
