Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eu@felipetonello.com>) id 1Sme3V-0005Fz-ND
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jul 2012 06:52:41 +0200
Received: by vbbfr13 with SMTP id fr13so5230993vbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Jul 2012 21:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:x-gm-message-state;
	bh=WLXM8YjWrg8dAKJk7q3XNNPiII97Ex3NBKND5fGR/kg=;
	b=F7e+BZ/MuMSEnXjKTW7LeJvwT2DXXraBAL/LrSq24f3StE+vJRvIrIfnp3ngGnD/ek
	LXWguSouz/IE1LXuV5j4IEGu2QE11k6Y/xW3v8Yl2IkSouHS67vyoymInKM7kM6RCxFn
	qgIFvdclo1JynSwukwUQYvzBSo7/219/KynXUGzfYNPLV0nzaiEJOunp9gd3R9LHmXPG
	PGkjKdLukb69f0qLTlDccZGF/7nA6EkYi+a0eCD3HLHF/0bbD+eeX/UM6tLF4YfmHeuj
	FBsFCqBWLhft39WjqtKJ9CA2m3DT7jimoVvlxLh6/YS4+vTYtfukvKxP8xcpujw2kEEU
	ZPFA==
MIME-Version: 1.0
Received: by 10.220.9.10 with SMTP id j10mr11743692vcj.7.1341463296999; Wed,
	04 Jul 2012 21:41:36 -0700 (PDT)
Received: by 10.220.178.134 with HTTP; Wed, 4 Jul 2012 21:41:36 -0700 (PDT)
Received: by 10.220.178.134 with HTTP; Wed, 4 Jul 2012 21:41:36 -0700 (PDT)
In-Reply-To: <CABcZANnbVf-d=2gZK1cbSR6y3JWAaHgXjszjA2qbo8jYVmuZgA@mail.gmail.com>
References: <CAGrhNMxsvb7Qbcg369748pQi8S3+tO56pNTSr4urQTrH1M23QA@mail.gmail.com>
	<CABcZANnbVf-d=2gZK1cbSR6y3JWAaHgXjszjA2qbo8jYVmuZgA@mail.gmail.com>
Date: Wed, 4 Jul 2012 21:41:36 -0700
Message-ID: <CAGrhNMyJHnf340iWCYndaVuMUbQuzZtUU0pXCGPWXivFXgSA3w@mail.gmail.com>
From: Felipe Tonello <eu@felipetonello.com>
To: Chris Larson <clarson@kergoth.com>
X-Gm-Message-State: ALoCoQlGKGcFfXI+lPv4EmQ+IXCBy3VEM6P307IAGeOoAvjHuE34f5+Y54e4oG1ShWHT/mfoM+q5
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Updating optparse module to argparse module
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
X-List-Received-Date: Thu, 05 Jul 2012 04:52:41 -0000
Content-Type: multipart/alternative; boundary=bcaec54fbaf64bffd404c40dc375

--bcaec54fbaf64bffd404c40dc375
Content-Type: text/plain; charset=ISO-8859-1

Oh right.

Is there any reason to that, since all major distributions come with python
2.7?

Felipe
On Jul 4, 2012 5:41 PM, "Chris Larson" <clarson@kergoth.com> wrote:

> On Wed, Jul 4, 2012 at 4:12 PM, Felipe Tonello <eu@felipetonello.com>
> wrote:
> > It's my first time here. So just to make a short intro, my name is Felipe
> > Ferreri Tonello, I'm from Brazil but I currently live in USA.
> >
> > This patch is just to update the command line parse module to fit the new
> > Python standards.
>
> Sorry, that won't do, just yet. Last I checked, the current required
> python version for bitbake and the main users of it is 2.6, not 2.7.
> --
> Christopher Larson
>

--bcaec54fbaf64bffd404c40dc375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Oh right.</p>
<p>Is there any reason to that, since all major distributions come with pyt=
hon 2.7?</p>
<p>Felipe</p>
<div class=3D"gmail_quote">On Jul 4, 2012 5:41 PM, &quot;Chris Larson&quot;=
 &lt;<a href=3D"mailto:clarson@kergoth.com">clarson@kergoth.com</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Wed, Jul 4, 2012 at 4:12 PM, Felipe Tonello &lt;<a href=3D"mailto:eu@fel=
ipetonello.com">eu@felipetonello.com</a>&gt; wrote:<br>
&gt; It&#39;s my first time here. So just to make a short intro, my name is=
 Felipe<br>
&gt; Ferreri Tonello, I&#39;m from Brazil but I currently live in USA.<br>
&gt;<br>
&gt; This patch is just to update the command line parse module to fit the =
new<br>
&gt; Python standards.<br>
<br>
Sorry, that won&#39;t do, just yet. Last I checked, the current required<br=
>
python version for bitbake and the main users of it is 2.6, not 2.7.<br>
--<br>
Christopher Larson<br>
</blockquote></div>

--bcaec54fbaf64bffd404c40dc375--
