Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
	[209.85.215.48])
	by mail.openembedded.org (Postfix) with ESMTP id 43E9260DE0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 22:34:20 +0000 (UTC)
Received: by mail-la0-f48.google.com with SMTP id n7so5868363lam.35
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=M2LiFvTtxalrnPDBGfaupYl9ReZPNDjInVZQcN8JInk=;
	b=x6zJ/D+p+DLIWnvcIM59mdqRO2v2F1VWnIRIth522UDA69UoO+yKaHOhM8iKDtZ24a
	1rlN5CmV1uPMhVfkhRmZi+d6epkTwrpjXbxSf3MmyqM/w1eike+JMTzwC99/NvNiHjw5
	4OBG+PtLoZp0Y7EW/5Day5yVEkaY+C/iTRNy4otAjZelaeokzdxd9W7ta3QfUi6rmKHk
	xhTQDz7YhssY2faKR360SkpASPIq6t/1MNNFEMY6ILWi00tYKizQDbnH4vTV1whs1NBO
	SB0BAZ6BeSR28xuuzsQmbK45d4aJi3zkntkp5C2BMoSqG7t0bGj45xk91A5XWnvFLDo/
	U+Jg==
MIME-Version: 1.0
X-Received: by 10.112.52.6 with SMTP id p6mr2317343lbo.67.1388442860269; Mon,
	30 Dec 2013 14:34:20 -0800 (PST)
Sender: kergoth@gmail.com
Received: by 10.112.22.167 with HTTP; Mon, 30 Dec 2013 14:34:20 -0800 (PST)
In-Reply-To: <1388441430.11527.80.camel@ted>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
Date: Mon, 30 Dec 2013 15:34:20 -0700
X-Google-Sender-Auth: K5wKvus0B-hdR8q0e8fRXhMYcJM
Message-ID: <CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Mon, 30 Dec 2013 22:34:20 -0000
Content-Type: multipart/alternative; boundary=001a11c3cd4a7a34e504eec80b1d

--001a11c3cd4a7a34e504eec80b1d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 30, 2013, Richard Purdie wrote:

> On Mon, 2013-12-30 at 17:35 +0100, Martin Jansa wrote:
> > On Mon, Dec 30, 2013 at 09:29:38AM -0700, Chris Larson wrote:
> > > On Mon, Dec 30, 2013 at 9:18 AM, Chris Larson <clarson@kergoth.com<ja=
vascript:;>>
> wrote:
> > >
> > > > On Sat, Dec 28, 2013 at 6:24 AM, Martin Jansa <
> martin.jansa@gmail.com <javascript:;>>wrote:
> > > >
> > > >> On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie wrote:
> > > >> > Its useful to understand where the delta starts against an
> existing
> > > >> sstate cache
> > > >> > for a given target. Adding this to the output of the -S option
> seems
> > > >> like a
> > > >> > natural fit.
> > > >> >
> > > >> > We use the hashvalidate function to figure this out and assume i=
t
> can
> > > >> find siginfo
> > > >> > files for more than just the setscene tasks.
> > > >>
> > > >> I haven't tried to find smaller reproducer or exact part of code
> where
> > > >> it happends, but in bigger builds I have it fails with
> > > >>
> > > >> I'll try to reproduce and narrow it a bit, but if you have tip whe=
re
> > > >> to look first..
> > > >>
> > > >> IndexError: list index out of range:
> > > >
> > > >
> > > > I=E2=80=99m hitting this now as well.
> > >
> > >
> > > To clarify further, I=E2=80=99m hitting this with stock poky master, =
qemux86,
> > > bitbake -S core-image-base.
> > >
> > > Actually, this is getting in my way trying to do something I don=E2=
=80=99t
> want it
> > > doing anyway. I want to dump the signature data from one config, and
> use
> > > bitbake-whatchanged from another build. If I wanted to compare
> something
> > > right here, I=E2=80=99d have run bitbake-whatchanged. This change con=
fuses me a
> > > bit. -S emits signature data, according to the bitbake help and the
> > > semantics of the command. Are we trying to kill bitbake-whatchanged i=
n
> > > favor of making -S do both jobs, emit and compare?
> >
> > Same here, I'm using bitbake -S from
> > oe-core/scripts/sstate-diff-machines.sh
> >
> > and this added analysis and output is IMHO very useful, but it would be
> > nice to control it with some new option (and keep default -S behavior
> > fast and simple).
> >
> > It looks like the error is triggered for every task which wasn't built
> > before (e.g. running bitbake -S with empty sstate-cache/tmp-eglibc or
> > bitbake -S world after bitbake some-image).
> >
> > I see it for many do_fetch and do_rm_work_all tasks.
>
> To put things in context, I was trying to work with the existing
> "whatchanged" type tools or more specifically I wanted to know "why
> isn't my sstate cache being used". Having to do a two step process for
> any of these enquires seems a little odd. There are also two specific
> and as it turns our quite different work flows:
>
> a) What changed since my last build?
> b) What is the least delta between my current build and whatever I have
> cached?


> Those experiments revealed some big holes in the sstate metadata and
> some good improvements there. It also highlights that there are two
> different questions which have different answers.
>
> In the process, I found bitbake does have some state in runqueue which
> can help pinpoint the "whatchanged" part of the problem much more
> accurately/quickly. Obviously that state is lost after bitbake -S
> finishes so I started printing out some extra data.
>
> Clearly bitbake shouldn't crash, that is a bug and I think Martin is
> heading in the right direction with the other patch.
>
> As for bitbake -S being kept fast, I think (but I need to double check
> with measurements) that the parsing part of bitbake -S is the slow part
> and this extra data is effectively "for free".
>
> So basically consider the current state an experiment to see if we can
> make -S more useful/interesting (without much cost) and to try to better
> understand where/what functionality we need going forward.
>

I can see that, but I think you're making the semantics of the command-line
argument confusing by trying to combine the two operations into one. I also
think that trying to find the "least delta" is extremely weird, and not
always likely to produce anything worthwhile. My SSTATE_DIR has weeks if
not months of output from hundreds of builds of different combinations of
machine, distro, layer selection, upstream vs mel, as well as between tons
of build environments with slight local alterations. Unless I'm
misunderstanding something, how exactly is it going to know what I want it
to compare against, and how it is going to keep finding the "least delta"
fast, amongst all that data? With the current tools, I can explicitly use
-S in one env and whatchanged in another (with appropriate STAMPS_DIR) to
compare between two exact build environments, rather than letting bitbake
try to automagically find what I meant. Now that the two are combined into
one, I'm not seeing how to do what I'm currently doing. Can you explain
this?

-Chris


--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c3cd4a7a34e504eec80b1d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 30, 2013, Richard Purdie  wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">On Mon, 2013-12-30 at 17:35 +0100, Martin Jansa wrote:<=
br>

&gt; On Mon, Dec 30, 2013 at 09:29:38AM -0700, Chris Larson wrote:<br>
&gt; &gt; On Mon, Dec 30, 2013 at 9:18 AM, Chris Larson &lt;<a href=3D"java=
script:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;clarson@kergoth.com&#39=
;)">clarson@kergoth.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On Sat, Dec 28, 2013 at 6:24 AM, Martin Jansa &lt;<a href=3D=
"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;martin.jansa@gmail=
.com&#39;)">martin.jansa@gmail.com</a>&gt;wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie=
 wrote:<br>
&gt; &gt; &gt;&gt; &gt; Its useful to understand where the delta starts aga=
inst an existing<br>
&gt; &gt; &gt;&gt; sstate cache<br>
&gt; &gt; &gt;&gt; &gt; for a given target. Adding this to the output of th=
e -S option seems<br>
&gt; &gt; &gt;&gt; like a<br>
&gt; &gt; &gt;&gt; &gt; natural fit.<br>
&gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt;&gt; &gt; We use the hashvalidate function to figure this out=
 and assume it can<br>
&gt; &gt; &gt;&gt; find siginfo<br>
&gt; &gt; &gt;&gt; &gt; files for more than just the setscene tasks.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; I haven&#39;t tried to find smaller reproducer or exact =
part of code where<br>
&gt; &gt; &gt;&gt; it happends, but in bigger builds I have it fails with<b=
r>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; I&#39;ll try to reproduce and narrow it a bit, but if yo=
u have tip where<br>
&gt; &gt; &gt;&gt; to look first..<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; IndexError: list index out of range:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I=E2=80=99m hitting this now as well.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; To clarify further, I=E2=80=99m hitting this with stock poky mast=
er, qemux86,<br>
&gt; &gt; bitbake -S core-image-base.<br>
&gt; &gt;<br>
&gt; &gt; Actually, this is getting in my way trying to do something I don=
=E2=80=99t want it<br>
&gt; &gt; doing anyway. I want to dump the signature data from one config, =
and use<br>
&gt; &gt; bitbake-whatchanged from another build. If I wanted to compare so=
mething<br>
&gt; &gt; right here, I=E2=80=99d have run bitbake-whatchanged. This change=
 confuses me a<br>
&gt; &gt; bit. -S emits signature data, according to the bitbake help and t=
he<br>
&gt; &gt; semantics of the command. Are we trying to kill bitbake-whatchang=
ed in<br>
&gt; &gt; favor of making -S do both jobs, emit and compare?<br>
&gt;<br>
&gt; Same here, I&#39;m using bitbake -S from<br>
&gt; oe-core/scripts/sstate-diff-machines.sh<br>
&gt;<br>
&gt; and this added analysis and output is IMHO very useful, but it would b=
e<br>
&gt; nice to control it with some new option (and keep default -S behavior<=
br>
&gt; fast and simple).<br>
&gt;<br>
&gt; It looks like the error is triggered for every task which wasn&#39;t b=
uilt<br>
&gt; before (e.g. running bitbake -S with empty sstate-cache/tmp-eglibc or<=
br>
&gt; bitbake -S world after bitbake some-image).<br>
&gt;<br>
&gt; I see it for many do_fetch and do_rm_work_all tasks.<br>
<br>
To put things in context, I was trying to work with the existing<br>
&quot;whatchanged&quot; type tools or more specifically I wanted to know &q=
uot;why<br>
isn&#39;t my sstate cache being used&quot;. Having to do a two step process=
 for<br>
any of these enquires seems a little odd. There are also two specific<br>
and as it turns our quite different work flows:<br>
<br>
a) What changed since my last build?<br>
b) What is the least delta between my current build and whatever I have<br>
cached?</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Those experiments revealed some big holes in the sstate metadata and<br>
some good improvements there. It also highlights that there are two<br>
different questions which have different answers.<br>
<br>
In the process, I found bitbake does have some state in runqueue which<br>
can help pinpoint the &quot;whatchanged&quot; part of the problem much more=
<br>
accurately/quickly. Obviously that state is lost after bitbake -S<br>
finishes so I started printing out some extra data.<br>
<br>
Clearly bitbake shouldn&#39;t crash, that is a bug and I think Martin is<br=
>
heading in the right direction with the other patch.<br>
<br>
As for bitbake -S being kept fast, I think (but I need to double check<br>
with measurements) that the parsing part of bitbake -S is the slow part<br>
and this extra data is effectively &quot;for free&quot;.<br>
<br>
So basically consider the current state an experiment to see if we can<br>
make -S more useful/interesting (without much cost) and to try to better<br=
>
understand where/what functionality we need going forward.<br></blockquote>=
<div><br></div><div>I can see that, but I think you&#39;re making the seman=
tics of the command-line argument confusing by trying to combine the two op=
erations into one. I also think that trying to find the &quot;least delta&q=
uot; is extremely weird, and not always likely to produce anything worthwhi=
le. My SSTATE_DIR has weeks if not months of output from hundreds of builds=
 of different combinations of machine, distro, layer selection, upstream vs=
 mel, as well as between tons of build environments with slight local alter=
ations. Unless I&#39;m misunderstanding something, how exactly is it going =
to know what I want it to compare against, and how it is going to keep find=
ing the &quot;least delta&quot; fast, amongst all that data? With the curre=
nt tools, I can explicitly use -S in one env and whatchanged in another (wi=
th appropriate STAMPS_DIR) to compare between two exact build environments,=
 rather than letting bitbake try to automagically find what I meant. Now th=
at the two are combined into one, I&#39;m not seeing how to do what I&#39;m=
 currently doing. Can you explain this?</div>
<div><br></div><div>-Chris</div><br><br>-- <br>Christopher Larson<br>clarso=
n at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Main=
tainer - Tslib<br>Senior Software Engineer, Mentor Graphics<br>

--001a11c3cd4a7a34e504eec80b1d--
