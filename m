Received: from mail-lpp01m020-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1RseQP-0000hI-Bk; Wed, 01 Feb 2012 18:56:53 +0100
Received: by lbol12 with SMTP id l12so216901lbo.6
	for <multiple recipients>; Wed, 01 Feb 2012 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type;
	bh=1H8rVdweeLvAuG90UKDHr6NNjeZ4gsfRE4hISz+iCxk=;
	b=Ie0ScCl03BqqYoKZthdQOgZxrV2K2oG9OG9mFliLOgV5+f347c4sYcI+4CNv+QXVlj
	g18IGj2fynblLEp4sXTdwLagB55Mhkl7VO2TN4lY4crCQ2Mk5pQ4iRu/BaHC7AcKJs50
	BiFvfux68QNECBDSL8aqVf7L/Ee8kwLBXnK/E=
MIME-Version: 1.0
Received: by 10.112.23.104 with SMTP id l8mr1398852lbf.50.1328118538018; Wed,
	01 Feb 2012 09:48:58 -0800 (PST)
Sender: otavio.salvador@gmail.com
Received: by 10.112.46.199 with HTTP; Wed, 1 Feb 2012 09:48:57 -0800 (PST)
In-Reply-To: <CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
	<CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
Date: Wed, 1 Feb 2012 15:48:57 -0200
X-Google-Sender-Auth: 3ssAWq81uy4282si608dvlqJlJ0
Message-ID: <CAP9ODKo5EQEWr2CU9uQdz6mXKPJfN6zhbSkTcC01k8rU2D4kQg@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: McClintock Matthew-B29882 <B29882@freescale.com>, 
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: Patches and discussions about the oe-core layer
	<openembedded-core@lists.linuxtogo.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 17:56:53 -0000
Content-Type: multipart/alternative; boundary=e0cb4efe30dcad9e5f04b7eab126

--e0cb4efe30dcad9e5f04b7eab126
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 1, 2012 at 15:07, McClintock Matthew-B29882 <
B29882@freescale.com> wrote:

> On Wed, Feb 1, 2012 at 10:04 AM, Khem Raj <raj.khem@gmail.com> wrote:
> > Hi
> >
> > patchwork instance that we have currently handles patches for
> > oe-devel, oe-core and bitbake
> > layers which use oe-devel maintain and use the patch queues ok so it
> > makes sense to have it
> > there. But patch flow for oe-core and bitbake is handled differently
> > via pull requests. Would it
> > make sense to turn it off for these two projects. Is someone using
> > patchwork and/or finds
> > it useful to have the patchwork catch those patches please let me know
>
> Patchworks is useful for pulling patches into a git repo and having
> discussion on a patch documented. I don't think it should just be
> turned off, it can be left there for all the see and use.


The major issue with it is the burden work of keeping it clean regarding of
the merged patches. Otherwise it ends being useless due the amount of not
archived patches.

-- 
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br

--e0cb4efe30dcad9e5f04b7eab126
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Feb 1, 2012 at 15:07, McClintock Matthew=
-B29882 <span dir=3D"ltr">&lt;<a href=3D"mailto:B29882@freescale.com">B2988=
2@freescale.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Wed, Feb 1, 2012 at 10:04 AM, Khem Raj &lt;<a href=3D"=
mailto:raj.khem@gmail.com">raj.khem@gmail.com</a>&gt; wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; patchwork instance that we have currently handles patches for<br>
&gt; oe-devel, oe-core and bitbake<br>
&gt; layers which use oe-devel maintain and use the patch queues ok so it<b=
r>
&gt; makes sense to have it<br>
&gt; there. But patch flow for oe-core and bitbake is handled differently<b=
r>
&gt; via pull requests. Would it<br>
&gt; make sense to turn it off for these two projects. Is someone using<br>
&gt; patchwork and/or finds<br>
&gt; it useful to have the patchwork catch those patches please let me know=
<br>
<br>
</div>Patchworks is useful for pulling patches into a git repo and having<b=
r>
discussion on a patch documented. I don&#39;t think it should just be<br>
turned off, it can be left there for all the see and use.</blockquote><div>=
<br></div><div>The major issue with it is the burden work of keeping it cle=
an regarding of the merged patches. Otherwise it ends being useless due the=
 amount of not archived patches.</div>
<div>=A0</div></div>-- <br>Otavio Salvador=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0O.S. Systems<br>E-mail: <a href=3D"mailto:otavio=
@ossystems.com.br" target=3D"_blank">otavio@ossystems.com.br</a>=A0 <a href=
=3D"http://www.ossystems.com.br" target=3D"_blank">http://www.ossystems.com=
.br</a><br>
Mobile: +55 53 9981-7854=A0 =A0 =A0 =A0=A0 =A0 =A0 =A0<a href=3D"http://pro=
jetos.ossystems.com.br" target=3D"_blank">http://projetos.ossystems.com.br<=
/a><br><br>

--e0cb4efe30dcad9e5f04b7eab126--
