Return-Path: <alexandru.damian@intel.com>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id D96F06C86C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 13:56:50 +0000 (UTC)
Received: by mail-ie0-f178.google.com with SMTP id to1so7404859ieb.37
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 06:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=fc0wIewRaLR++hmTyqP99Y1Cry4MN/2hpiKF6GoqGuI=;
	b=CLMUx5KL0ecVUDXSyvZA0lFD9sQAeMny+Q3WNZGPXuf6XNZNBmAdfYYsPeaHZsKWhd
	SMBjfjDWImm7ywB/5kpzowaiIQamMqLTxe6bdY2RBJkiixBtgXRU2YLcaehC9DjpLFa2
	IiLoaQjM/R06Jcc24sB9geDd4HW2YNnEyf5pcYlHX2dyTbeMZ/qUNB8hDSWdtTq7KfgE
	Rsz+9EaBT+RNjVkEPwNSndw5Dz15ZPxJz/JFtRivnPvhifW3RM/UwMvVJMi54PKNTMxN
	oseL8oroZBvgBgtG8IvNaTA2zOQshD/JZv8y6WzdRx5T60g4CfYFAdEoysem9KWiteRO
	YKJQ==
X-Gm-Message-State: ALoCoQmfRjQfqJJeHQLwFH4gRuuFoOAmw5jQ+taB9zvXJ2bnw1d7MYym4bneNzF1Q8rBYA2n+Xw/
X-Received: by 10.50.49.65 with SMTP id s1mr6349560ign.43.1379339812753; Mon,
	16 Sep 2013 06:56:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.229.169 with HTTP; Mon, 16 Sep 2013 06:56:32 -0700 (PDT)
In-Reply-To: <1379339207.3484.304.camel@ted>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<389466a059c3e6ba345bec88bb710f9dd3311189.1379338189.git.alexandru.damian@intel.com>
	<1379339207.3484.304.camel@ted>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 14:56:32 +0100
Message-ID: <CAJ2CSBtavqusHtJXRkELi2QfTmxp2c5T31AaZ8X1_srsZ0iJ2A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 6/7] bitbake: event: adding events to allow bbclasses to push custom info
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
X-List-Received-Date: Mon, 16 Sep 2013 13:56:51 -0000
Content-Type: multipart/alternative; boundary=e89a8f5038e2906bb504e6809327

--e89a8f5038e2906bb504e6809327
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 16, 2013 at 2:46 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > We add a new event that will be triggered by the
> > package-building class, containing the information
> > about the currently built package.
> >
> > Adding an event that will passi information about the
> > content of each package file that gets built.
> >
> > Knotty UI will ignore these events by default.
> >
> > Maybe a mechanism for using a single generic event is in order ?
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  bitbake/lib/bb/event.py     | 16 ++++++++++++++++
> >  bitbake/lib/bb/ui/knotty.py |  2 ++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> > index 67cfcea..7dd9236 100644
> > --- a/bitbake/lib/bb/event.py
> > +++ b/bitbake/lib/bb/event.py
> > @@ -589,6 +589,22 @@ class PackageInfo(Event):
> >          Event.__init__(self)
> >          self._pkginfolist = pkginfolist
> >
> > +class SinglePackageInfo(Event):
> > +    """
> > +    Single Package Information sent on emit_pkgdata
> > +    """
> > +    def __init__(self, data):
> > +        Event.__init__(self)
> > +        self._data = data
> > +
> > +class PackageFileSizes(Event):
> > +    """
> > +    Event that contains information about the file sizes contained in a
> package.
> > +    """
> > +    def __init__(self, data):
> > +        Event.__init__(self)
> > +        self._data = data
> > +
> >  class SanityCheck(Event):
> >      """
>
> Your explanation in the commit message isn't as detailed as it could
> be.
>
> I'm guessing but I suspect the problem we have is that the event cannot
> be rebuilt on the other side of an XMLRPC connection without having the
> event class in a common namespace?
>
> This is therefore a hack to allow the event to exist in all the client
> side namespaces.
>

[Alex] Yep, this is an ugly hack.


>
> Ideally we should really have an API which allows the classes themselves
> to declare their event formats and not require adding to event.py every
> time a new piece of code/event is added.
>

[Alex] I would favor a single "GenericEvent" that will take a set of
defined parameters,
that would allow "subclassing" at runtime - sort of introspection if you
will.

Something like this:

class GenericInfo(Event):
    def __init__(self, type, data):
        Event.__init__(self)
        self._type = type
        self._data = data

with a call like

bb.event.fire(bb.event.GenericInfo("PackageInfo", pkginfolist), e.data)

the UI handlers / anybody would subscribe to GenericInfo events,
and the processing code would look like:

if isinstance(event, bb.event.GenericInfo):
    if event._type == "PackageInfo":
         savePackageInfo(event)
    elif event._type == "PackageFileSizes":
        ....


What do you think ?


>
> Presumably there is some change required to OE-Core in order for this
> get used to?
>

The code using the e

>
> Is the PackageFileSizes not contained in the other event data?
>

[Alex] Not  that I could find.

>
> I appreciate we allowed PackageInfo in but I didn't like it at the time,
> I like it even less now I see we're just going to keep doing this :(.
>
> >      Event to issue sanity check
> > diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> > index 0211b50..03baa75 100644
> > --- a/bitbake/lib/bb/ui/knotty.py
> > +++ b/bitbake/lib/bb/ui/knotty.py
> > @@ -477,6 +477,8 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
> >
> >              # ignore
> >              if isinstance(event, (bb.event.BuildBase,
> > +                                  bb.event.PackageFileSizes,
> > +                                  bb.event.SinglePackageInfo,
> >                                    bb.event.StampUpdate,
> >                                    bb.event.ConfigParsed,
> >                                    bb.event.RecipeParsed,
>
>
> Given the event masking that is now in knotty, do we need to do this?
> Can't we remove this block?
>

[Alex] Yep, it should get removed. I refrained from doing so since it
wasn't deleted
when the subscription code got merged in.


> Cheers,
>
> Richard
>
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--e89a8f5038e2906bb504e6809327
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Sep 16, 2013 at 2:46 PM, Richard Purdie <span dir=3D"ltr">&=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">=
richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D""><div class=3D"h5">On Mon, 2013-09-16 at 14=
:33 +0100, Alex DAMIAN wrote:<br>


&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; We add a new event that will be triggered by the<br>
&gt; package-building class, containing the information<br>
&gt; about the currently built package.<br>
&gt;<br>
&gt; Adding an event that will passi information about the<br>
&gt; content of each package file that gets built.<br>
&gt;<br>
&gt; Knotty UI will ignore these events by default.<br>
&gt;<br>
&gt; Maybe a mechanism for using a single generic event is in order ?<br>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bitbake/lib/bb/event.py =C2=A0 =C2=A0 | 16 ++++++++++++++++<br>
&gt; =C2=A0bitbake/lib/bb/ui/knotty.py | =C2=A02 ++<br>
&gt; =C2=A02 files changed, 18 insertions(+)<br>
&gt;<br>
&gt; diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py<br>
&gt; index 67cfcea..7dd9236 100644<br>
&gt; --- a/bitbake/lib/bb/event.py<br>
&gt; +++ b/bitbake/lib/bb/event.py<br>
&gt; @@ -589,6 +589,22 @@ class PackageInfo(Event):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Event.__init__(self)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._pkginfolist =3D pkginfolist<br=
>
&gt;<br>
&gt; +class SinglePackageInfo(Event):<br>
&gt; + =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; + =C2=A0 =C2=A0Single Package Information sent on emit_pkgdata<br>
&gt; + =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; + =C2=A0 =C2=A0def __init__(self, data):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0Event.__init__(self)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self._data =3D data<br>
&gt; +<br>
&gt; +class PackageFileSizes(Event):<br>
&gt; + =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; + =C2=A0 =C2=A0Event that contains information about the file sizes co=
ntained in a package.<br>
&gt; + =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; + =C2=A0 =C2=A0def __init__(self, data):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0Event.__init__(self)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self._data =3D data<br>
&gt; +<br>
&gt; =C2=A0class SanityCheck(Event):<br>
&gt; =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
</div></div>Your explanation in the commit message isn&#39;t as detailed as=
 it could<br>
be.<br>
<br>
I&#39;m guessing but I suspect the problem we have is that the event cannot=
<br>
be rebuilt on the other side of an XMLRPC connection without having the<br>
event class in a common namespace?<br>
<br>
This is therefore a hack to allow the event to exist in all the client<br>
side namespaces.<br></blockquote><div><br></div><div>[Alex] Yep, this is an=
 ugly hack.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">


<br>
Ideally we should really have an API which allows the classes themselves<br=
>
to declare their event formats and not require adding to event.py every<br>
time a new piece of code/event is added.<br></blockquote><div><br></div><di=
v>[Alex] I would favor a single &quot;GenericEvent&quot; that will take a s=
et of defined parameters,</div><div>that would allow &quot;subclassing&quot=
; at runtime - sort of introspection if you will.</div>

<div><br></div><div>Something like this:</div><div><span style=3D"color:rgb=
(80,0,80)"><br></span></div><div><font color=3D"#000000">class GenericInfo(=
Event):<br></font></div><div><font color=3D"#000000">=C2=A0 =C2=A0 def __in=
it__(self, type, data):<br>

=C2=A0 =C2=A0 =C2=A0 =C2=A0 Event.__init__(self)</font></div><div><font col=
or=3D"#000000">=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._type =3D type<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self._data =3D data<br></font></div><div><font color=
=3D"#000000"><br></font></div><div><font color=3D"#000000">with a call like=
</font></div>

<div><font color=3D"#000000"><br></font></div><div><font color=3D"#000000">=
bb.event.fire(bb.event.GenericInfo(&quot;PackageInfo&quot;, pkginfolist), e=
.data)</font></div><div><font color=3D"#000000"><br></font></div><div><font=
 color=3D"#000000">the UI handlers / anybody would subscribe to GenericInfo=
 events,=C2=A0</font></div>

<div><font color=3D"#000000">and the processing code would look like:</font=
></div><div><br></div><div>if isinstance(event, bb.event.GenericInfo):</div=
><div>=C2=A0 =C2=A0 if event._type =3D=3D=C2=A0<span style=3D"color:rgb(0,0=
,0)">&quot;PackageInfo&quot;:</span></div>

<div><span style=3D"color:rgb(0,0,0)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sav=
ePackageInfo(event)</span></div><div><span style=3D"color:rgb(0,0,0)">=C2=
=A0 =C2=A0 elif event._type =3D=3D &quot;PackageFileSizes&quot;:</span></di=
v><div><span style=3D"color:rgb(0,0,0)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 ....</s=
pan></div>

<div><span style=3D"color:rgb(0,0,0)"><br></span></div><div><span style=3D"=
color:rgb(0,0,0)"><br></span></div><div><span style=3D"color:rgb(0,0,0)">Wh=
at do you think ?</span></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex">


<br>
Presumably there is some change required to OE-Core in order for this<br>
get used to?<br></blockquote><div><br></div><div>The code using the e=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:s=
olid;padding-left:1ex">


<br>
Is the PackageFileSizes not contained in the other event data?<br></blockqu=
ote><div><br></div><div>[Alex] Not =C2=A0that I could find.</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-lef=
t:1ex">


<br>
I appreciate we allowed PackageInfo in but I didn&#39;t like it at the time=
,<br>
I like it even less now I see we&#39;re just going to keep doing this :(.<b=
r>
<div class=3D"im"><br>
&gt; =C2=A0 =C2=A0 =C2=A0Event to issue sanity check<br>
&gt; diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py=
<br>
&gt; index 0211b50..03baa75 100644<br>
&gt; --- a/bitbake/lib/bb/ui/knotty.py<br>
&gt; +++ b/bitbake/lib/bb/ui/knotty.py<br>
&gt; @@ -477,6 +477,8 @@ def main(server, eventHandler, params, tf =3D Term=
inalFilter):<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# ignore<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(event, (=
bb.event.BuildBase,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.PackageFileSiz=
es,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.SinglePackageI=
nfo,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.StampUpdate=
,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.ConfigParse=
d,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.RecipeParse=
d,<br>
<br>
<br>
</div>Given the event masking that is now in knotty, do we need to do this?=
<br>
Can&#39;t we remove this block?<br></blockquote><div><br></div><div>[Alex] =
Yep, it should get removed. I refrained from doing so since it wasn&#39;t d=
eleted</div><div>when the subscription code got merged in.</div><div><br>

</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:s=
olid;padding-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div></div=
>
</div></div>

--e89a8f5038e2906bb504e6809327--
