Return-Path: <kergoth@gmail.com>
Received: from mail-ot0-f175.google.com (mail-ot0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id D410177A8D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 20:05:05 +0000 (UTC)
Received: by mail-ot0-f175.google.com with SMTP id y88so59715831ota.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=pNcB69X+SEg3DSxBkiLK+jN8qMVTjL1DZddSU8kdiDc=;
	b=qgHBdC093L9kUQ2VbGtXeMfrWGsjMQsQpchIdx5zpqbSsom5szhPo0F215flPwr+EI
	R/EEMA3MBZnK1hh1ijZfxau2g/K4eoPdOqT+ObZyNyCn9lroXYWjujFOI92SF9NaNezt
	GYQJFzFQgClgFEv9dJbpZzzXXHMZtGFpA8AHFMNKS8B7BjTo3kw07rEWC0rtZVsJy5k6
	KJ1lJRq72zXii8oI8LEOj5TqIZDyWcT1lQlB3ko2nnO0MVmQ4fFdpEk6/h7bXMviEkib
	tTw17yXpP+2ql69fjgKudyxmQY46e1QxXrhpklXHjPlk8sZaFVUlqCJpFVDbiW0QhdXR
	7KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=pNcB69X+SEg3DSxBkiLK+jN8qMVTjL1DZddSU8kdiDc=;
	b=RGRWwVvUswQe0e3PVeWm1PxA+zdbyAjhKJcD6cG82leu6NqARjjgEnN1u+YcYv2u+1
	6myYkyvX6lrzzpgissE9FtypflkP2hDrxuKxVXzoWbL46lYLIGwEevx6NcceLC5kBmCG
	MBajXfD2Dc9kIiTLanpUO9p4T2NDr+9SReCyTbAUqWXwS9pp+aC0GhijKD+fUTppnBqr
	p+iirJuAyK3KQNruPvBv7RmCOKMLssZcc2xSOvLPU7bhS/VnCZAh2EfVLMR0KLof/VA7
	FSUn5J9kR9Omsss9D4tbnOfaBtI+5wAFC4JekD7B1aGoTyPXoahU0rOXeN9WDgtPzT71
	Qesg==
X-Gm-Message-State: AFeK/H3LaFxBigLm0b/PYE4PefQInBzkGITBiDRLM5YCd59CCTT8CLHbcLxhjaiTRnp++i1nd4nZqzpv7nYFgQ==
X-Received: by 10.157.58.68 with SMTP id j62mr15446342otc.145.1490731506607;
	Tue, 28 Mar 2017 13:05:06 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.32.161 with HTTP; Tue, 28 Mar 2017 13:04:46 -0700 (PDT)
In-Reply-To: <4811829.bIhWvhHDll@peggleto-mobl.ger.corp.intel.com>
References: <cover.1490662146.git.paul.eggleton@linux.intel.com>
	<93968aed34753e90e05945b2bce34ccfb4743a60.1490662146.git.paul.eggleton@linux.intel.com>
	<CABcZANnahbPL5bLobQ8TTQu=+UmdyHpmi8u7wbduZFSkcQzBgQ@mail.gmail.com>
	<4811829.bIhWvhHDll@peggleto-mobl.ger.corp.intel.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Tue, 28 Mar 2017 13:04:46 -0700
X-Google-Sender-Auth: hWVMTYXQKYAL1nkdoJ3lTdB6Nbo
Message-ID: <CABcZANkJ2HVMMJUaqWd_x8vdmwCTPn842my-vL88HLof-PjuWg@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] lib/bb/codeparser: ensure BufferedLogger respects target filtering
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
X-List-Received-Date: Tue, 28 Mar 2017 20:05:06 -0000
Content-Type: multipart/alternative; boundary=001a114929e6e8322b054bcff9e0

--001a114929e6e8322b054bcff9e0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 12:50 PM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> On Wednesday, 29 March 2017 5:01:31 AM NZDT Christopher Larson wrote:
> > On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton <
> > paul.eggleton@linux.intel.com> wrote:
> > > BufferedLogger was sending log records to the target logger using
> > > handle() - this meant that the filtering (e.g. log level set)
> > > on the target logger was bypassed, leading for example to debug recor=
ds
> > > getting printed when the log level was set to logging.WARNING.
> > >
> > > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> >
> > The =E2=80=98filter=E2=80=99 method of a Logger instance doesn=E2=80=99=
t log anything, it=E2=80=99s a
> > subclass of Filterer, which just checks whether it should be logged. Th=
e
> > =E2=80=98handle=E2=80=99 method of a Logger already consults self.filte=
r(), if you check
> > the code:
> >
> >    def handle(self, record):
> >           """
> >           Call the handlers for the specified record.
> >
> >           This method is used for unpickled records received from a
> socket,
> > as
> >           well as those created locally. Logger-level filtering is
> applied.
> >           """
> >           if (not self.disabled) and self.filter(record):
> >               self.callHandlers(record)
>
> Oops, you're right. I'm still confused about why I'm seeing debugging
> messages
> when the target logger is set to INFO then. Do you have any suggestions o=
n
> how
> we fix this?
>
> (I've attached a simplified test script demonstrating the issue.)


handle() obeys filter(), but it seems filter() only checks to see if this
logger is or isn=E2=80=99t responsible for a given message, it doesn=E2=80=
=99t actually
check to see whether the logger is enabled for a given record given its
level. The level based checking for a logger (as opposed to a handler)
seems to be done in the actual message function, i.e.:

    def debug(self, msg, *args, **kwargs):
          if self.isEnabledFor(DEBUG):
              self._log(DEBUG, msg, args, **kwargs)

The setLevel() for the BufferLogger itself ensures that anything of that
level (logging.DEBUG) or higher severity gets buffered, but then we bypass
the isEnabledFor() on the main logger by calling handle directly rather
than the individual level-based methods. I expect we should use
isEnabledFor rather than filter, and keep the conditional ourselves:

     def flush(self):
         for record in self.buffer:
-            self.target.handle(record)
+            if self.target.isEnabledFor(record.level):
+                self.target.handle(record)
         self.buffer =3D []
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a114929e6e8322b054bcff9e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Mar 28, 2017 at 12:50 PM, Paul Eggleton <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton=
@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span class=3D"g=
mail-">On Wednesday, 29 March 2017 5:01:31 AM NZDT Christopher Larson wrote=
:<br>
&gt; On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton &lt;<br>
&gt; <a href=3D"mailto:paul.eggleton@linux.intel.com">paul.eggleton@linux.i=
ntel.com</a>&gt; wrote:<br>
&gt; &gt; BufferedLogger was sending log records to the target logger using=
<br>
&gt; &gt; handle() - this meant that the filtering (e.g. log level set)<br>
&gt; &gt; on the target logger was bypassed, leading for example to debug r=
ecords<br>
&gt; &gt; getting printed when the log level was set to logging.WARNING.<br=
>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@=
linux.intel.com">paul.eggleton@linux.intel.com</a><wbr>&gt;<br>
&gt;<br>
&gt; The =E2=80=98filter=E2=80=99 method of a Logger instance doesn=E2=80=
=99t log anything, it=E2=80=99s a<br>
&gt; subclass of Filterer, which just checks whether it should be logged. T=
he<br>
&gt; =E2=80=98handle=E2=80=99 method of a Logger already consults self.filt=
er(), if you check<br>
&gt; the code:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 def handle(self, record):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Call the handlers for the spec=
ified record.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This method is used for unpick=
led records received from a socket,<br>
&gt; as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0well as those created locally.=
 Logger-level filtering is applied.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (not self.disabled) and sel=
f.filter(record):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.callHandler=
s(record)<br>
<br>
</span>Oops, you&#39;re right. I&#39;m still confused about why I&#39;m see=
ing debugging messages<br>
when the target logger is set to INFO then. Do you have any suggestions on =
how<br>
we fix this?<br>
<br>
(I&#39;ve attached a simplified test script demonstrating the issue.)</bloc=
kquote></div><br>handle() obeys filter(), but it seems filter() only checks=
 to see if this logger is or isn=E2=80=99t responsible for a given message,=
 it doesn=E2=80=99t actually check to see whether the logger is enabled for=
 a given record given its level. The level based checking for a logger (as =
opposed to a handler) seems to be done in the actual message function, i.e.=
:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div=
 class=3D"gmail_extra">=C2=A0 =C2=A0 def debug(self, msg, *args, **kwargs):=
</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self=
.isEnabledFor(DEBUG):</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._log(DEBUG, msg, args, **kwargs)</div><div=
><br></div><div>The setLevel() for the BufferLogger itself ensures that any=
thing of that level (logging.DEBUG) or higher severity gets buffered, but t=
hen we bypass the isEnabledFor() on the main logger by calling handle direc=
tly rather than the individual level-based methods. I expect we should use =
isEnabledFor rather than filter, and keep the conditional ourselves:</div><=
div><br></div><div><span style=3D"font-size:12.800000190734863px">=C2=A0 =
=C2=A0 =C2=A0def flush(self):</span><br style=3D"font-size:12.8000001907348=
63px"><span style=3D"font-size:12.800000190734863px">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for record in self.buffer:</span><br style=3D"font-size:12.800=
000190734863px"><span style=3D"font-size:12.800000190734863px">-=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.target.handle(record)</span><br style=
=3D"font-size:12.800000190734863px"><span style=3D"font-size:12.80000019073=
4863px">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.target.isEnabled=
For(record.level):</span></div><div><span style=3D"font-size:12.80000019073=
4863px">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.targe=
t.handle(record)</span><br style=3D"font-size:12.800000190734863px"><span s=
tyle=3D"font-size:12.800000190734863px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
elf.buffer =3D []</span><br></div>-- <br><div class=3D"gmail_signature"><di=
v dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Christopher =
Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, Open=
Zaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></div>=
</div></div></div>
</div></div>

--001a114929e6e8322b054bcff9e0--
