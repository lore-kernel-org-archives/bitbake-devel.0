Return-Path: <alex.r.damian@gmail.com>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
	[209.85.213.178])
	by mail.openembedded.org (Postfix) with ESMTP id BE8AC72D4D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jan 2015 18:05:24 +0000 (UTC)
Received: by mail-ig0-f178.google.com with SMTP id hl2so3294320igb.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jan 2015 10:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=aFFImihUA/dvJO8IUwV4SsyINQBFMDjPCN2bJpc7afo=;
	b=EHSPmjczHyyvwiLzfTqbMYAEzVajZEZLoQ3dLzq+lAWy7AIjWyupr36qRxk0QtKMKL
	I4Dz9NsZGBrH/QdkTboTxd5QxKQdrVmwi5qscfnDLe6K4LpoAUJls5UJxsuHw77oB5oO
	PO2XEDd+ocg4J07WfAC+u9/n9GWEDEmFQMV5Vzuwmz6vIvvf+YTB1irchCoT95ibXomq
	i48AnGqSen7XuUDQzD61tP+UJGl/LBwimABZbycCfaCEU5n6+JkW3Kpbd3vtSCQa5jWX
	yyEL/OqkCHH0me8dKntlcpKD2oP/tKsl14PGz2qwGNG8TI7SOf56hY3t4NHJtxgvMrOW
	cXCA==
MIME-Version: 1.0
X-Received: by 10.107.157.67 with SMTP id g64mr5228682ioe.72.1422036325128;
	Fri, 23 Jan 2015 10:05:25 -0800 (PST)
Received: by 10.36.39.200 with HTTP; Fri, 23 Jan 2015 10:05:25 -0800 (PST)
In-Reply-To: <3577015.nPVb6vKuGn@peggleto-mobl5.ger.corp.intel.com>
References: <1421938639.19798.17.camel@linuxfoundation.org>
	<3577015.nPVb6vKuGn@peggleto-mobl5.ger.corp.intel.com>
Date: Fri, 23 Jan 2015 18:05:25 +0000
Message-ID: <CAL7ttbf_DjowNkx8i2z4Nx=cm5aoq3zU0s8q9JtWo9GY=CHabA@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Lifecycle issues in Bitbake
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
X-List-Received-Date: Fri, 23 Jan 2015 18:05:32 -0000
Content-Type: multipart/alternative; boundary=001a1140cd1e046249050d55a2ef

--001a1140cd1e046249050d55a2ef
Content-Type: text/plain; charset=UTF-8

My 2 cents -

In managed mode, this bug is not a issue for Toaster as we start and stop
the bitbake server separately for each build, for unrelated reasons. This
only appears for the "interactive" model, when toaster logs commands ran
from the CLI.

Details below.

Cheers,
Alex


On Fri, Jan 23, 2015 at 10:33 AM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> Hi Richard,
>
> On Thursday 22 January 2015 14:57:19 Richard Purdie wrote:
> > Looking at and thinking about:
> >
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=5187
> >
> > We have several issues. Firstly, DATE and TIME are locked in stone when
> > the base configuration is parsed. This may cause images to overwrite
> > previous versions for example if DATE and TIME are not re-evaluated. We
> > could fix this by specifically setting DATE and TIME in bitbake at
> > BuildStart?
>
> We could certainly do this. Another mechanism I did think about was to have
> some way of indicating to BitBake that on buildstart the value should be
> reset
> to the immediate evaluation of an expression; perhaps a varflag. At least
> that
> way we could handle other such variables, although it's conceivable that
> having built-in DATE and TIME in BitBake wouldn't be the worst thing in the
> world.
>

I think this would be the most elegant solution; however I think there is a
catch-22 here, as the build will not start until the datastore is parsed
and evaluated, and we need to parse and evaluate the entire datastore as a
variable as wildly used as DATE and TIME (and maybe others) change at the
start of the build .

I'm not seeing a clean get-away from this ...


>
> > Secondly, there is one cooker log file opened for the duration of the
> > cooker lifecycle. This is a cooker log, not a log of each build so that
> > is perhaps not surprising (and is the core problem in the above bug).
> > There is no overwriting of the log file, it just keeps growing with each
> > build.
> >
> > We could trigger knotty to write out build specific log files based on
> > the BuildStart/Finish events?
>
> Yes I think we should do this.
>

This is not very helpful for Toaster; Toaster relies on the server-side
written cooker log file to have information above what the event system is
exposing, and thus it provides the cookerlog file as an optional
downloadable item for the user's benefit.

If we drop the cooker log we'll have a bit of the gap in the information we
provide to the user.

Multiple builds per cooker is not a problem, since, in managed mode,
Toaster will stop the server after each build for unrelated reasons.


>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a1140cd1e046249050d55a2ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">My 2 cents -<div><br></div><div>In managed mode, this bug =
is not a issue for Toaster as we start and stop the bitbake server separate=
ly for each build, for unrelated reasons. This only appears for the &quot;i=
nteractive&quot; model, when toaster logs commands ran from the CLI.</div><=
div><br></div><div>Details below.</div><div><br></div><div>Cheers,</div><di=
v>Alex</div><div><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Jan 23, 2015 at 10:33 AM, Paul Eggleton <span dir=3D"ltr">&lt;<=
a href=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggl=
eton@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">Hi Richard,<br>
<span class=3D""><br>
On Thursday 22 January 2015 14:57:19 Richard Purdie wrote:<br>
&gt; Looking at and thinking about:<br>
&gt;<br>
&gt; <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5187" t=
arget=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5187</=
a><br>
&gt;<br>
&gt; We have several issues. Firstly, DATE and TIME are locked in stone whe=
n<br>
&gt; the base configuration is parsed. This may cause images to overwrite<b=
r>
&gt; previous versions for example if DATE and TIME are not re-evaluated. W=
e<br>
&gt; could fix this by specifically setting DATE and TIME in bitbake at<br>
&gt; BuildStart?<br>
<br>
</span>We could certainly do this. Another mechanism I did think about was =
to have<br>
some way of indicating to BitBake that on buildstart the value should be re=
set<br>
to the immediate evaluation of an expression; perhaps a varflag. At least t=
hat<br>
way we could handle other such variables, although it&#39;s conceivable tha=
t<br>
having built-in DATE and TIME in BitBake wouldn&#39;t be the worst thing in=
 the<br>
world.<br></blockquote><div><br></div><div>I think this would be the most e=
legant solution; however I think there is a catch-22 here, as the build wil=
l not start until the datastore is parsed and evaluated, and we need to par=
se and evaluate the entire datastore as a variable as wildly used as DATE a=
nd TIME (and maybe others) change at the start of the build .</div><div><br=
>I&#39;m not seeing a clean get-away from this ...</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; Secondly, there is one cooker log file opened for the duration of the<=
br>
&gt; cooker lifecycle. This is a cooker log, not a log of each build so tha=
t<br>
&gt; is perhaps not surprising (and is the core problem in the above bug).<=
br>
&gt; There is no overwriting of the log file, it just keeps growing with ea=
ch<br>
&gt; build.<br>
&gt;<br>
&gt; We could trigger knotty to write out build specific log files based on=
<br>
&gt; the BuildStart/Finish events?<br>
<br>
</span>Yes I think we should do this.<br></blockquote><div><br></div><div>T=
his is not very helpful for Toaster; Toaster relies on the server-side writ=
ten cooker log file to have information above what the event system is expo=
sing, and thus it provides the cookerlog file as an optional downloadable i=
tem for the user&#39;s benefit.=C2=A0</div><div><br>If we drop the cooker l=
og we&#39;ll have a bit of the gap in the information we provide to the use=
r.=C2=A0</div><div><br></div><div>Multiple builds per cooker is not a probl=
em, since, in managed mode, Toaster will stop the server after each build f=
or unrelated reasons.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Cheers,<br>
Paul<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div></div></div>

--001a1140cd1e046249050d55a2ef--
