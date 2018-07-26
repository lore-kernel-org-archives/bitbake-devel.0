Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
	[209.85.161.194])
	by mail.openembedded.org (Postfix) with ESMTP id 76F0778C0C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 14:23:26 +0000 (UTC)
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so627567ywb.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hgDw4GIkwEYglRkz3TPBdHOxPHdvFdhUlLrknmlf1EA=;
	b=VM6wrkMPXrJwg5OSPSjTC4PDC4DiwwosIXcU5MOK5oIdJUEdVkrb3szoAZYRwhBbhH
	R+fsKGgtzLtjU6/jekdFLr4moC3cQuSY+EQb5EdzDQDBP8GkDdugwbM/IWpjg291N00I
	IE1kqv2Ocs3FPTKt7GpSbuBzetgoxUt1/MQsybG5Jv7+fMY84uBVSEEdijmZSxGVmihv
	+7bpTFDP7QfakjCUUsz2POmzTFF1f6wA3A6MhRfT20kPNnlVtHzVAr1pTggmhoxEJcdj
	h2Sgrd3iIQqqNITj3I2lb37e1eYW/ehBPNamJluki1PPNwndtIYxcbUZ/Aa+QQ4cgRB7
	zXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hgDw4GIkwEYglRkz3TPBdHOxPHdvFdhUlLrknmlf1EA=;
	b=anqEK8HJzd8TRrtp7f57vJ+li/hdVrsYCsFB9AwNxygnr7SedZqG4kqf0tzYvxUPmD
	y4aqUd3cHqyU4GUG6N96DLQpXheTKXv8UU48Zn+FuqrjRBlt2IINOjdvHERBw4ajDExR
	9G6KuH6iK6W3qLDBRNFpoGVGuzIlAPUCtMKqQdG0OxZQ7bg1nZaRjUHr0tYXAMvdaOjd
	3FZq2FMQdzk8koiTCV8o/D+pvclUdof9M/wxdISkOq9GnFa6RqeUGfOAG/eaLsxvsHyM
	gbXaMLCH+sFYg5sItWiJZ5TQGGhF62J4OVzKivm5yqkWZLuyaQfGgbG0/Dmp4AUmOjRB
	JO7w==
X-Gm-Message-State: AOUpUlGS0t0sCr4KRE6DFyxPq7S1pN1vx/51pPC5q7NfqFnTlaESsuQi
	Ck5BQbhU5yrUTyOvIeb3cVDg6OK+6CeCzWLJkoA=
X-Google-Smtp-Source: AAOMgpdxhLiwkS8+80C8Rwpxvn1kki7CPKvf4osK89PWYhD+MLqF92LgCUzBBxTiBnfzInmLQH9+gUX7PnICtLiXxtw=
X-Received: by 2002:a81:b54:: with SMTP id 81-v6mr1063311ywl.363.1532615007167;
	Thu, 26 Jul 2018 07:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgxT3_QyunmpzGW69j27sR_BFvvhisQVtG+-uGnMxhsO8mCLg@mail.gmail.com>
	<CAJgxT3-Jrr2baQz8Y6c_VzNf0Jn6qSEfgNbDYu7xGN4g1PRT=A@mail.gmail.com>
	<18ef0e1f0af7576bbdc5841c8eaa064bc865e0ff.camel@linuxfoundation.org>
In-Reply-To: <18ef0e1f0af7576bbdc5841c8eaa064bc865e0ff.camel@linuxfoundation.org>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Thu, 26 Jul 2018 09:22:51 -0500
Message-ID: <CAJgxT3_kmGREWd_0kuULP-NMCd1U39YbT+c9YAeZ+=aikK0aWA@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [yocto] Ordering of anonymous Python functions and task signature calculations
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
X-List-Received-Date: Thu, 26 Jul 2018 14:23:26 -0000
Content-Type: multipart/alternative; boundary="0000000000001468e10571e7bda7"

--0000000000001468e10571e7bda7
Content-Type: text/plain; charset="UTF-8"

Thanks for the reply.

On Wed, Jul 25, 2018 at 4:58 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2018-07-25 at 08:47 -0500, Matt Hoosier wrote:
> > Quite a while ago I wrote the following message:
> > On Tue, Jan 24, 2017 at 11:55 AM Matt Hoosier <matt.hoosier@gmail.com
> > > wrote:
> > > In order to support a use-case that embeds information about the
> > > Git revision of Yocto itself that was used to make a build, I would
> > > like to run some arbitrary Python code and dump the results (Git
> > > SHA1's, tag names, etc) into a Bitbake variable.
> > >
> > > The idea is that the variable would get consumed in a do_install()
> > > task to populate some cookie-crumb file in the package payload.
> > >
> > > Something like:
> > >
> > >   DEPENDS = "git-native"
> > >
> > >   python () {
> > >     # This pseudocode isn't strictly functional for invoking Git,
> > > but you get the idea
> > >     d.setVar('GIT_INFO', subprocess.Popen(['git', 'rev-list',
> > > ...]).communicate().stdout)
> > >   }
> > >
> > >   do_install () {
> > >     install -d ${D}/etc
> > >     echo "${GIT_INFO}" > ${D}/etc/git-info.txt
> > >   }
> > >
> > > This all works on a fresh run, but Bitbake appears not to be
> > > evaluating the anonymous Python function on each execution. This
> > > leads it to have out-of-date information about the Git working copy
> > > when global state changes but happens not to impact the particular
> > > recipe holding this logic.
> > >
> > >
> >
> > The replies given at the time were very helpful in letting me
> > accomplish my immediate goals, but I never really did get to the
> > bottom of the real question:
> >
> > > Is there any trick available to cause the Python function to
> > > execute (and hence update the value of ${GIT_INFO} each Bitbake
> > > execution so that the up-to-the-moment contents of it filter into
> > > the calculation of the signature for do_install()? Or am I just
> > > trying a wrong-headed approach and doing something illegitimate?
> > >
> >
> > Some build systems I know of [1] that are based on hashes rather than
> > timestamps have a way that you can inform the task execution engine
> > to always poison the inputs to a certain task's up-to-dateness check.
> > Is there anything in Bitbake that would allow a declaration to force
> > such-and-such variable in a recipe always to be re-evaluated:
> >
> >   EXTERNALLY_INFLUENCED_VARIABLE = "${@int(random.random() * 10)}"
> >   do_install[vardepsalwaysdirty] = " EXTERNALLY_INFLUENCED_VARIABLE "
> >
> >   do_install() {
> >     echo '${ EXTERNALLY_INFLUENCED_VARIABLE }' > ${D}/etc/stuff.txt
> >   }
> >
> > Don't read too much into the example calling random() here. That's
> > not really what I want to do; the point is just that the variable's
> > value (though deterministic) isn't computed strictly from Bitbake
> > metadata. So I'm searching for a way to get the value of
> > EXTERNALLY_INFLUENCED_VARIABLE to be re-computed each time Bitbake
> > starts. If the computed value ends up matching what was seen on the
> > last execution, then any dependent tasks wouldn't need re-run.
> >
> > Any ideas?
> >
> > [1] I'm thinking particularly of Waf's hash-based task graph, which
> > supports annotations that can be used to always cause a task to be
> > re-run even if all the inputs feeding into it appear up-to-date.
>
> From a bitbake perspective there are two things you need to ensure
> here, that the recipe gets reparsed at every execution


Your advice about BB_DONT_CACHE does cause reparsing to get triggered. I
can see that in logs.


> and that the
> task dependency exists. You have the dependency above and that is the
> easier piece to fix.
>

But this part I'm not seeing. The variable's value is always recalculated
(sometimes more than once during a Bitbake run, but that's okay because
it's idempotent), but the task only re-executes if the payload of the .bb
file itself has changed. The blurb I wrote above:

  do_install[vardepsalwaysdirty] = " EXTERNALLY_INFLUENCED_VARIABLE "

is just some nonsense syntax I wrote there to illustrate my point. I don't
think there's any var flag called "vardepsalwaysdirty". Did you have this
line in mind when you were saying that I'd already gotten the task made
dependent on the variable? Or were you just noting that the syntactic use
of the variable inside of the task should engage the normal hash-based
task-dependency calculation logic?


>
> If the recipe is reparsed, the anon python reruns and the task hash
> recalculated.
>

Is there anything extra I need to do to cause the reparsed variable's hash
to cascade to the task?


>
> If a recipe sets BB_DONT_CACHE, it will be reparsed upon each run and
> the hashes will dynamically change as you want. BB_SRCREV_POLICY !=
> "cache" uses that behind the scenes so that it can dynamically update
> srcrevs.
>
> Hope that helps...
>
> Cheers,
>
> Richard
>
>

Thanks! -Matt

--0000000000001468e10571e7bda7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Thanks for the reply.</div=
><div dir=3D"ltr"><br></div><div dir=3D"ltr">On Wed, Jul 25, 2018 at 4:58 P=
M Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">=
richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">On Wed, 2018-07-25 at 08:47 -0500, Matt Hoosier wrote:<br>
&gt; Quite a while ago I wrote the following message:<br>
&gt; On Tue, Jan 24, 2017 at 11:55 AM Matt Hoosier &lt;<a href=3D"mailto:ma=
tt.hoosier@gmail.com" target=3D"_blank">matt.hoosier@gmail.com</a><br>
&gt; &gt; wrote:<br>
&gt; &gt; In order to support a use-case that embeds information about the<=
br>
&gt; &gt; Git revision of Yocto itself that was used to make a build, I wou=
ld<br>
&gt; &gt; like to run some arbitrary Python code and dump the results (Git<=
br>
&gt; &gt; SHA1&#39;s, tag names, etc) into a Bitbake variable.<br>
&gt; &gt; <br>
&gt; &gt; The idea is that the variable would get consumed in a do_install(=
)<br>
&gt; &gt; task to populate some cookie-crumb file in the package payload.<b=
r>
&gt; &gt; <br>
&gt; &gt; Something like:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0DEPENDS =3D &quot;git-native&quot;<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0python () {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0# This pseudocode isn&#39;t strictly functiona=
l for invoking Git,<br>
&gt; &gt; but you get the idea<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0d.setVar(&#39;GIT_INFO&#39;, subprocess.Popen(=
[&#39;git&#39;, &#39;rev-list&#39;,<br>
&gt; &gt; ...]).communicate().stdout)<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0do_install () {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0install -d ${D}/etc<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0echo &quot;${GIT_INFO}&quot; &gt; ${D}/etc/git=
-info.txt<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt; This all works on a fresh run, but Bitbake appears not to be<br>
&gt; &gt; evaluating the anonymous Python function on each execution. This<=
br>
&gt; &gt; leads it to have out-of-date information about the Git working co=
py<br>
&gt; &gt; when global state changes but happens not to impact the particula=
r<br>
&gt; &gt; recipe holding this logic.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; <br>
&gt; The replies given at the time were very helpful in letting me<br>
&gt; accomplish my immediate goals, but I never really did get to the<br>
&gt; bottom of the real question:<br>
&gt;=C2=A0 <br>
&gt; &gt; Is there any trick available to cause the Python function to<br>
&gt; &gt; execute (and hence update the value of ${GIT_INFO} each Bitbake<b=
r>
&gt; &gt; execution so that the up-to-the-moment contents of it filter into=
<br>
&gt; &gt; the calculation of the signature for do_install()? Or am I just<b=
r>
&gt; &gt; trying a wrong-headed approach and doing something illegitimate? =
<br>
&gt; &gt; <br>
&gt; <br>
&gt; Some build systems I know of [1] that are based on hashes rather than<=
br>
&gt; timestamps have a way that you can inform the task execution engine<br=
>
&gt; to always poison the inputs to a certain task&#39;s up-to-dateness che=
ck.<br>
&gt; Is there anything in Bitbake that would allow a declaration to force<b=
r>
&gt; such-and-such variable in a recipe always to be re-evaluated:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0EXTERNALLY_INFLUENCED_VARIABLE =3D &quot;${@int(random.ran=
dom() * 10)}&quot;<br>
&gt;=C2=A0 =C2=A0do_install[vardepsalwaysdirty] =3D &quot; EXTERNALLY_INFLU=
ENCED_VARIABLE &quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0do_install() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0echo &#39;${ EXTERNALLY_INFLUENCED_VARIABLE }&#39; =
&gt; ${D}/etc/stuff.txt<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; Don&#39;t read too much into the example calling random() here. That&#=
39;s<br>
&gt; not really what I want to do; the point is just that the variable&#39;=
s<br>
&gt; value (though deterministic) isn&#39;t computed strictly from Bitbake<=
br>
&gt; metadata. So I&#39;m searching for a way to get the value of<br>
&gt; EXTERNALLY_INFLUENCED_VARIABLE to be re-computed each time Bitbake<br>
&gt; starts. If the computed value ends up matching what was seen on the<br=
>
&gt; last execution, then any dependent tasks wouldn&#39;t need re-run.<br>
&gt; <br>
&gt; Any ideas?<br>
&gt; <br>
&gt; [1] I&#39;m thinking particularly of Waf&#39;s hash-based task graph, =
which<br>
&gt; supports annotations that can be used to always cause a task to be<br>
&gt; re-run even if all the inputs feeding into it appear up-to-date.<br>
<br>
From a bitbake perspective there are two things you need to ensure<br>
here, that the recipe gets reparsed at every execution</blockquote><div><br=
></div><div>Your advice about BB_DONT_CACHE does cause reparsing to get tri=
ggered. I can see that in logs.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"> and that the<br>
task dependency exists. You have the dependency above and that is the<br>
easier piece to fix.<br></blockquote><div><br></div><div>But this part I&#3=
9;m not seeing. The variable&#39;s value is always recalculated (sometimes =
more than once during a Bitbake run, but that&#39;s okay because it&#39;s i=
dempotent), but the task only re-executes if the payload of the .bb file it=
self has changed. The blurb I wrote above:</div><div><br></div><div>=C2=A0=
=C2=A0<span style=3D"font-size:small;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">do_install[vardepsalwaysdirty] =3D &quot;<span>=C2=A0</span></span>=
<span style=3D"font-size:small;text-decoration-style:initial;text-decoratio=
n-color:initial;background-color:rgb(255,255,255);float:none;display:inline=
">EXTERNALLY_INFLUENCED_VARIABLE</span><span style=3D"font-size:small;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial;float:none;display:inline"><span>=C2=A0</span>&quot;</span></=
div><div><span style=3D"font-size:small;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial;float:none;displ=
ay:inline"><br></span></div><div><span style=3D"font-size:small;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;float:none;display:inline">is just some nonsense syntax I wrote the=
re to illustrate my point. I don&#39;t think there&#39;s any var flag calle=
d &quot;vardepsalwaysdirty&quot;. Did you have this line in mind when you w=
ere saying that I&#39;d already gotten the task made dependent on the varia=
ble? Or were you just noting that the syntactic use of the variable inside =
of the task should engage the normal hash-based task-dependency calculation=
 logic?</span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If the recipe is reparsed, the anon python reruns and the task hash<br>
recalculated.<br></blockquote><div><br></div><div>Is there anything extra I=
 need to do to cause the reparsed variable&#39;s hash to cascade to the tas=
k?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If a recipe sets BB_DONT_CACHE, it will be reparsed upon each run and<br>
the hashes will dynamically change as you want. BB_SRCREV_POLICY !=3D<br>
&quot;cache&quot; uses that behind the scenes so that it can dynamically up=
date<br>
srcrevs.<br>
<br>
Hope that helps...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br></blockquote><div><br></div><div><br></div><div>Thanks! -Matt=C2=A0</di=
v></div></div>

--0000000000001468e10571e7bda7--
