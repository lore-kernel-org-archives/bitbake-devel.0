Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1Ti9SM-00077H-MM; Mon, 10 Dec 2012 20:56:02 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so2172080lag.6
	for <multiple recipients>; Mon, 10 Dec 2012 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=pjijrkC9IBbpG2F5PE85Ja6CUIDYblSDpk1QC8ThQXk=;
	b=BvZh4XfeKq/gEu9jWVag6luwgUC4WekvfofWLoPuv5QYtdU7FRorP4DbjPyc9/v1oZ
	RIYv/2OfexW4qH7m31S8RE5smNsnqK0umATNPMyPGP8rCj+7NhPNBy2BC85cX0fMWx80
	UVMOQbt2E+8olFvAjbHRViLrKKyEWvv4HLQNSTMcnf2EG8DnbxB4oJ6ktT+YnfLoRDzO
	YtJPErA19sbAJkdEIrIIWfF7AC7AV4WnkSDlaPNu75vYhg6IYsvVTxWPUHne9cZwyaJu
	j6Gs56hKYRkOVGmJF0oImZS+RF6IcEEjFUgTCpXC5v2wDbILthQXrcaUD5hQ9eeCkh3Z
	o96Q==
Received: by 10.152.111.41 with SMTP id if9mr1781205lab.23.1355168491444; Mon,
	10 Dec 2012 11:41:31 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Mon, 10 Dec 2012 11:41:11 -0800 (PST)
In-Reply-To: <1355161495.28775.1.camel@ted>
References: <1355155747.29967.31.camel@ted>
	<CABcZANkOXMWf-v=6uEMgcGhnQZrgfOTDgjtJwarM9NRzGUupug@mail.gmail.com>
	<1355161495.28775.1.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 10 Dec 2012 12:41:11 -0700
X-Google-Sender-Auth: KmbplGlnI8_QCDvEs2dH128cok0
Message-ID: <CABcZANnVEBGUFLNKgD4RQFdUsfKXapT65+9L5crBJ4F9No1Spw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: EXPORT_FUNCTIONS - change in behaviour proposal
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 10 Dec 2012 19:56:02 -0000
Content-Type: multipart/alternative; boundary=f46d040715298b17a004d084c039

--f46d040715298b17a004d084c039
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 10, 2012 at 10:44 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> > E.g. in class alpha:
> >
> > inherit beta
> >
> > alpha_do_stuff () {
> >    pre_stuff
> >    beta_do_stuff
> >    post_stuff
> > }
> >
> > But this is a theoretical case, and often we hack around things via
> > _prepend/_append rather than doing things like this, so I doubt this
> > is actually done anywhere in practice.
>
> With an "EXPORT_FUNCTIONS = do_stuff" in alpha.bbclass, wouldn't that
> still work without the intermediaries though?
>

Hmm, yes, good point. Perhaps it was to allow the user to override an
intermediate function that might or might not exist?

E.g. in the do_configure calls gnomebase_do_configure calls
autotools_do_configure case, the user could override
gnomebase_do_configure, without having to know whether or not gnomebase
actually defines a configure function?

I'm guessing here, but that *could* be why it was implemented this way. In
practice, however, we have to know what our classes are doing anyway, most
of the time, for a wide variety of reasons. E.g. uses of overrides have to
be operated against carefully to avoid your changes being blown away.
-- 
Christopher Larson

--f46d040715298b17a004d084c039
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">On Mon, Dec 10, 2012 at 10:44 AM, Richard Purdie=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org=
" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote=
:<br>

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div class=3D""><div class=3D"i=
m">&gt; E.g. in class alpha:<br>


&gt;<br>
&gt; inherit beta<br>
&gt;<br>
&gt; alpha_do_stuff () {<br>
&gt; =C2=A0 =C2=A0pre_stuff<br>
&gt; =C2=A0 =C2=A0beta_do_stuff<br>
&gt; =C2=A0 =C2=A0post_stuff<br>
&gt; }<br>
&gt;<br>
&gt; But this is a theoretical case, and often we hack around things via<br=
>
&gt; _prepend/_append rather than doing things like this, so I doubt this<b=
r>
&gt; is actually done anywhere in practice.<br>
<br>
</div></div>With an &quot;EXPORT_FUNCTIONS =3D do_stuff&quot; in alpha.bbcl=
ass, wouldn&#39;t that<br>
still work without the intermediaries though?<br></blockquote></div><br>Hmm=
, yes, good point. Perhaps it was to allow the user to override an intermed=
iate function that might or might not exist?</div><div class=3D"gmail_extra=
">

<br></div><div class=3D"gmail_extra">E.g. in the=C2=A0<span style=3D"color:=
rgb(80,0,80);font-family:arial,sans-serif;font-size:13px">do_configure call=
s gnomebase_do_configure calls autotools_do_configure case, the user could =
override gnomebase_do_configure, without having to know whether or not gnom=
ebase actually defines a configure function?</span></div>

<div class=3D"gmail_extra"><font color=3D"#500050" face=3D"arial, sans-seri=
f"><br></font></div><div class=3D"gmail_extra"><font color=3D"#500050" face=
=3D"arial, sans-serif">I&#39;m guessing here, but that *could* be why it wa=
s implemented this way. In practice, however, we have to know what our clas=
ses are doing anyway, most of the time, for a wide variety of reasons. E.g.=
 uses of overrides have to be operated against carefully to avoid your chan=
ges being blown away.<br>

</font>-- <br>Christopher Larson<br>
</div>

--f46d040715298b17a004d084c039--
