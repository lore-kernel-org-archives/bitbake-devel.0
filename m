Return-Path: <kergoth@gmail.com>
Received: from mail-ot0-f180.google.com (mail-ot0-f180.google.com
	[74.125.82.180])
	by mail.openembedded.org (Postfix) with ESMTP id 79E0877AF0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 20:07:26 +0000 (UTC)
Received: by mail-ot0-f180.google.com with SMTP id 102so49704317otv.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=MCK8E4Lqzk97wbI/YqtD8Mu6KyT0MoeSdgxpdnu8BD0=;
	b=clhVxL2Cwcd0XEq0V2pqqT4+kWnQPd6XSsP5MXXI8V3gNEOVWkCtqKaFHBf6El/6si
	VbT7ddUN5lcEIvv4dWMpbhNc2bf3G1dVcBKMhC+CaDqDEZ6Ud96J/qRxvkRvnktPCjoh
	2NpFDXb7SJXpieWFnSHagS4XpRLPY17W4qgDFExSMGPGpM/14sE9I2LlNZ1jP/ppCFrv
	kVfN9Zz5dMyfUlj3yBB+EcOOt5Xzf/7wIyEgsB3ZuR2HmI+8SfL3AyH4HceKVlnbwSQz
	TYedc0ReAzcXlA9e+Ht1DoqsF+6JzSGyP3VQ/p/ZqjfvsJkLrYagHxb2JTgv5jXeW5/n
	xOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=MCK8E4Lqzk97wbI/YqtD8Mu6KyT0MoeSdgxpdnu8BD0=;
	b=Qgi5aR/dheUvWQJswqFQMJwU+ZX23QsQcBRP+Ihn3X6vDhjD8bmD2SnqhSF49eF3nO
	8RW0CETbgmfvENzmtcl08Mlg05wVC0s2AmzubvFZj6bpFQEYkfOzCg7EomSOfgb5/Glx
	8qqRFBBrT5eiUYMLpceSw6oedbrF3jhZMKPd8jfiRMc6ib5WIYUZTlnay0njyTFGBAUD
	wCQfXZoR4gOhhhn3ujpup4oreclA4IKw/P+nKUCtvl8gvYdaBzyRceKEwRszv4/Vwuco
	0PWn2X+0v5tQdH6mhihCRv99rG6urh1MUumBa+St++TjwnzHM1TF4qD9nDCEyq+f117R
	cNZQ==
X-Gm-Message-State: AFeK/H0fjhyDEeahW+2k+CQWdjTnf1ppQb7Q9BXtNyD4lut0nbCn6unbEopqLJbd/d1QIbf1+JMVbh5O6zQ2VA==
X-Received: by 10.157.4.5 with SMTP id 5mr13741060otc.205.1490731647948; Tue,
	28 Mar 2017 13:07:27 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.32.161 with HTTP; Tue, 28 Mar 2017 13:07:07 -0700 (PDT)
In-Reply-To: <CABcZANkJ2HVMMJUaqWd_x8vdmwCTPn842my-vL88HLof-PjuWg@mail.gmail.com>
References: <cover.1490662146.git.paul.eggleton@linux.intel.com>
	<93968aed34753e90e05945b2bce34ccfb4743a60.1490662146.git.paul.eggleton@linux.intel.com>
	<CABcZANnahbPL5bLobQ8TTQu=+UmdyHpmi8u7wbduZFSkcQzBgQ@mail.gmail.com>
	<4811829.bIhWvhHDll@peggleto-mobl.ger.corp.intel.com>
	<CABcZANkJ2HVMMJUaqWd_x8vdmwCTPn842my-vL88HLof-PjuWg@mail.gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Tue, 28 Mar 2017 13:07:07 -0700
X-Google-Sender-Auth: lHsgdNLPL_VHHKne3URlv2ZF5cs
Message-ID: <CABcZANnJFyogPJ+YMk_Z_gU14nnJkaqx8LCf7h6u82zN44zHeQ@mail.gmail.com>
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
X-List-Received-Date: Tue, 28 Mar 2017 20:07:27 -0000
Content-Type: multipart/alternative; boundary=001a1137030254df54054bd00275

--001a1137030254df54054bd00275
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 1:04 PM, Christopher Larson <chris_larson@mentor.co=
m
> wrote:

> On Tue, Mar 28, 2017 at 12:50 PM, Paul Eggleton <
> paul.eggleton@linux.intel.com> wrote:
>
>> On Wednesday, 29 March 2017 5:01:31 AM NZDT Christopher Larson wrote:
>> > On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton <
>> > paul.eggleton@linux.intel.com> wrote:
>> > > BufferedLogger was sending log records to the target logger using
>> > > handle() - this meant that the filtering (e.g. log level set)
>> > > on the target logger was bypassed, leading for example to debug
>> records
>> > > getting printed when the log level was set to logging.WARNING.
>> > >
>> > > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
>> >
>> > The =E2=80=98filter=E2=80=99 method of a Logger instance doesn=E2=80=
=99t log anything, it=E2=80=99s a
>> > subclass of Filterer, which just checks whether it should be logged. T=
he
>> > =E2=80=98handle=E2=80=99 method of a Logger already consults self.filt=
er(), if you check
>> > the code:
>> >
>> >    def handle(self, record):
>> >           """
>> >           Call the handlers for the specified record.
>> >
>> >           This method is used for unpickled records received from a
>> socket,
>> > as
>> >           well as those created locally. Logger-level filtering is
>> applied.
>> >           """
>> >           if (not self.disabled) and self.filter(record):
>> >               self.callHandlers(record)
>>
>> Oops, you're right. I'm still confused about why I'm seeing debugging
>> messages
>> when the target logger is set to INFO then. Do you have any suggestions
>> on how
>> we fix this?
>>
>> (I've attached a simplified test script demonstrating the issue.)
>
>
> handle() obeys filter(), but it seems filter() only checks to see if this
> logger is or isn=E2=80=99t responsible for a given message, it doesn=E2=
=80=99t actually
> check to see whether the logger is enabled for a given record given its
> level. The level based checking for a logger (as opposed to a handler)
> seems to be done in the actual message function, i.e.:
>
>     def debug(self, msg, *args, **kwargs):
>           if self.isEnabledFor(DEBUG):
>               self._log(DEBUG, msg, args, **kwargs)
>
> The setLevel() for the BufferLogger itself ensures that anything of that
> level (logging.DEBUG) or higher severity gets buffered, but then we bypas=
s
> the isEnabledFor() on the main logger by calling handle directly rather
> than the individual level-based methods. I expect we should use
> isEnabledFor rather than filter, and keep the conditional ourselves:
>
>      def flush(self):
>          for record in self.buffer:
> -            self.target.handle(record)
> +            if self.target.isEnabledFor(record.level):
> +                self.target.handle(record)
>          self.buffer =3D []
>

s/\.level/.levelno/


--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a1137030254df54054bd00275
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Mar 28, 2017 at 1:04 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:chris_larson@mentor.com" target=3D"_blank">chris_larson@me=
ntor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"gmail_extra"><span class=3D""><div class=3D"gmail_quote">On Tue, Mar =
28, 2017 at 12:50 PM, Paul Eggleton <span dir=3D"ltr">&lt;<a href=3D"mailto=
:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@linux.intel=
.com</a><wbr>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><span class=3D"m_-3061=
383614194082498gmail-">On Wednesday, 29 March 2017 5:01:31 AM NZDT Christop=
her Larson wrote:<br>
&gt; On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton &lt;<br>
&gt; <a href=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">pau=
l.eggleton@linux.intel.com</a>&gt; wrote:<br>
&gt; &gt; BufferedLogger was sending log records to the target logger using=
<br>
&gt; &gt; handle() - this meant that the filtering (e.g. log level set)<br>
&gt; &gt; on the target logger was bypassed, leading for example to debug r=
ecords<br>
&gt; &gt; getting printed when the log level was set to logging.WARNING.<br=
>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@=
linux.intel.com" target=3D"_blank">paul.eggleton@linux.intel.com</a><wbr>&g=
t;<br>
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
kquote></div><br></span>handle() obeys filter(), but it seems filter() only=
 checks to see if this logger is or isn=E2=80=99t responsible for a given m=
essage, it doesn=E2=80=99t actually check to see whether the logger is enab=
led for a given record given its level. The level based checking for a logg=
er (as opposed to a handler) seems to be done in the actual message functio=
n, i.e.:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a"><div class=3D"gmail_extra">=C2=A0 =C2=A0 def debug(self, msg, *args, **k=
wargs):</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if self.isEnabledFor(DEBUG):</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._log(DEBUG, msg, args, **kwargs)</d=
iv><div><br></div><div>The setLevel() for the BufferLogger itself ensures t=
hat anything of that level (logging.DEBUG) or higher severity gets buffered=
, but then we bypass the isEnabledFor() on the main logger by calling handl=
e directly rather than the individual level-based methods. I expect we shou=
ld use isEnabledFor rather than filter, and keep the conditional ourselves:=
</div><div><br></div><div><span class=3D""><span style=3D"font-size:12.8000=
00190734863px">=C2=A0 =C2=A0 =C2=A0def flush(self):</span><br style=3D"font=
-size:12.800000190734863px"><span style=3D"font-size:12.800000190734863px">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for record in self.buffer:</span><br styl=
e=3D"font-size:12.800000190734863px"><span style=3D"font-size:12.8000001907=
34863px">-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.target.handle(reco=
rd)</span><br style=3D"font-size:12.800000190734863px"></span><span style=
=3D"font-size:12.800000190734863px">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if self.target.isEnabledFor(<wbr>record.level):</span></div><div><spa=
n style=3D"font-size:12.800000190734863px">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0self.target.handle(record)</span><br style=3D"fo=
nt-size:12.800000190734863px"><span style=3D"font-size:12.800000190734863px=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.buffer =3D []</span></div></div></=
blockquote></div><br>s/\.level/.levelno/<br><br clear=3D"all"><div><br></di=
v>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=
<div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv></div></div></div>
</div></div>

--001a1137030254df54054bd00275--
