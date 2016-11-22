Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1B68F719C8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 20:34:04 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id u15so4469836oie.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 12:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=2DJxcFcUGQwoRaiqm6gGajKii9/vCdCA9VEFocCutSM=;
	b=okz7/FBdD9Mq7Zm+qCCHjmCo/t91gyP4D9OZr4Ft4yyaiPbv1OyVyDIi2lyk+pvehr
	jlGtdVcfsXxwFZ7O5OAHer4jqAdpByKAdiXFCOXfLnljiSXo47z95lfKNQ2EwQ6risQY
	wlN3GYXoMAfyTtbiDEzj4vh1xe7MJVkjvw2H1g4CeiPfTldyOml4r4Iju6QikyAt1dHd
	q4wblmjRPqJsqeOEWlFgoBm0Nbxm2juxFXSUMLSXaAGz8wDISYsWqo2NODTDd1+ba/Je
	NODx9hU80OHeZ5Xc3wgZqUhgR6wjxd5as8F6JSIa0H0jXeYgj/HFG7MRXE2Vmc4Nhsoo
	lQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=2DJxcFcUGQwoRaiqm6gGajKii9/vCdCA9VEFocCutSM=;
	b=JdWo2WZ64WZ0l3cpRutqO689ZeBPe6XjkAi5JrXhUEJH9tTcL2axF2hHf93bZisIY9
	uvTDBW/M6lMO0/VExCxyd8U0czzXtbs440xErOml26PiWSAaV1RpKAvbF1IWS8Hn/Ap/
	o0NQ3x6Ywbsp5KpSffQ9nNPZ61I2b1E5gEJAmzblgBJVylWjM1HjGKB8hzGrmFUh/3s3
	RgYsaadzbjWG4ziaNgpH5aVYHApYhsKGdSMpLFh/1dwjpmckAObj6zHs1ZVb90fNLefm
	3VsYPEqhIwNkYDL5aeUxKmRTAPCSwnRLSeRxeYcbnXGylFVptkfpJDxqOg2smKS5CfTJ
	icrQ==
X-Gm-Message-State: AKaTC03y4YnyothuJYDAYzEjcQG8PRnPzF5tPKuY3U8kDGxJxMthZ3K9T5CSBwnT1Cgw/5vv4jkzqb0/Z22/PQ==
X-Received: by 10.202.89.197 with SMTP id n188mr13785540oib.156.1479846846382; 
	Tue, 22 Nov 2016 12:34:06 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.35.65 with HTTP; Tue, 22 Nov 2016 12:33:46 -0800 (PST)
In-Reply-To: <4380989.s9a6u3CJO3@peggleto-mobl.ger.corp.intel.com>
References: <CADyYWLmiBkOd9xuc2SqfUG3sO6FdLGd9y5=+SNtGCCVC65tZ8w@mail.gmail.com>
	<CADyYWL=Zz0oHNW=gF--i3DD=ZU8ZgVd_K50MC7nwVx0RcHy4Fw@mail.gmail.com>
	<4380989.s9a6u3CJO3@peggleto-mobl.ger.corp.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 22 Nov 2016 13:33:46 -0700
X-Google-Sender-Auth: epIYjTkgr1ilApQeA9tzn-Abo0o
Message-ID: <CABcZANksQCU7kfMAzsnkz9OyzScyXAsCm3ZTopSThvngpYQCVA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: getAllKeysWithFlags: Issue when returning the dump var
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
X-List-Received-Date: Tue, 22 Nov 2016 20:34:06 -0000
Content-Type: multipart/alternative; boundary=001a113d31ce99dc550541e9b1cf

--001a113d31ce99dc550541e9b1cf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 1:11 PM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> On Tue, 22 Nov 2016 16:20:30 sujith h wrote:
> > Finally I found that not all data in my case was
> > string/list/tuple/dict/None/int/float. That is those data types which
> can
> > be marshalled: https://docs.python.org/3/library/xmlrpc.client.html. Bu=
t
> > there was a data type :
> > v =3D <subprocess.Popen object at 0x7f56f4964ef0>. So this was causing =
the
>
> What on earth is a subprocess.Popen object doing in the datastore? Which
> variable / flag is that?


It=E2=80=99s an internal class, the object is tucked into the metadata to e=
xchange
info between event handlers. The variable starts with =E2=80=98_=E2=80=99 s=
o is clearly
meant to be internal. That said, there=E2=80=99s nothing preventing use of =
any
arbitrary type in a metadata value, so if code is expecting particular
types, it should be fixed to exclude types it doesn=E2=80=99t understand, o=
r just
str() the values.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113d31ce99dc550541e9b1cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Nov 22, 2016 at 1:11 PM, Paul Eggleton <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@=
linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an class=3D"">On Tue, 22 Nov 2016 16:20:30 sujith h wrote:<br>
&gt; Finally I found that not all data in my case was<br>
&gt; string/list/tuple/dict/None/<wbr>int/float. That is those data types w=
hich can<br>
&gt; be marshalled: <a href=3D"https://docs.python.org/3/library/xmlrpc.cli=
ent.html" rel=3D"noreferrer" target=3D"_blank">https://docs.python.org/3/<w=
br>library/xmlrpc.client.html</a>. But<br>
&gt; there was a data type :<br>
&gt; v =3D &lt;subprocess.Popen object at 0x7f56f4964ef0&gt;. So this was c=
ausing the<br>
<br>
</span>What on earth is a subprocess.Popen object doing in the datastore? W=
hich<br>
variable / flag is that?</blockquote></div><br>It=E2=80=99s an internal cla=
ss, the object is tucked into the metadata to exchange info between event h=
andlers. The variable starts with =E2=80=98_=E2=80=99 so is clearly meant t=
o be internal. That said, there=E2=80=99s nothing preventing use of any arb=
itrary type in a metadata value, so if code is expecting particular types, =
it should be fixed to exclude types it doesn=E2=80=99t understand, or just =
str() the values.<br>-- <br><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br>Fo=
under - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior S=
oftware Engineer, Mentor Graphics</div>
</div></div>

--001a113d31ce99dc550541e9b1cf--
