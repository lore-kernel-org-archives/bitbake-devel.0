Return-Path: <vijaikumar.k@mistralsolutions.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail.openembedded.org (Postfix) with ESMTP id F224277527
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 06:27:56 +0000 (UTC)
Received: by mail-wr0-f179.google.com with SMTP id q97so1452047wrb.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Jun 2017 23:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mistralsolutions.com; s=dkim;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=mO4oPqsklPiW5n4XE/oumHc1JeJDJZENmB6lmM874eA=;
	b=vDzmWL0TuT1FEsaBLsVoX+Kst+ENJeUhUPXvn6BS7hbQGrcFKXX5piOuBkUigOzTF3
	4yxoA2kOd/cnto+uzvBq66ejwVzxzvQwJCSavsSdz2/xZ/IlIizQTrvf4a/RDUJFWXzL
	veLDbX/Qa26y6VPAqAkdmPnMpnIgKVYx2O08E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=mO4oPqsklPiW5n4XE/oumHc1JeJDJZENmB6lmM874eA=;
	b=WVJ++mM5p70bfrl4mXOORZhNk0yamtN7l8vAPKTQmRzk0m8q2KzNGPtX95Xatp9vv/
	xJ2u6KtzC3A24l+YoLy76j98TzrU8agHKN3xplveKIvCCoKR+fogc6phFC9+y/ayFZrt
	0qZWTdnsDY3J3lnpPPfOcm/JBTHGvDck3BBoyjO2lVUFl7e3WHHu3HjYieTblKL9xMam
	cUmAZ9s5JxNiSVw/CMNCGFGQWhOVIRZiVsOiI5Rw3Cob5MOfXE7EGnQoOC6CCmdShKid
	WKbh0t9YIc53ZTi9KenznuW6OVwtmDlYbfqG8hT3wKSWJKDWx5aFrGpJY2OIT9fvRsHS
	E6xg==
X-Gm-Message-State: AODbwcDxmucxE5xWdjAZx4x9IdAKz2x07mbEQb1fUD2Pm5SgGd4y9wUz
	dSEPqGhkgkqs+z9Z5yJ/ghpAw6w2bbCF
X-Received: by 10.223.133.35 with SMTP id 32mr7846710wrh.9.1496816877436; Tue,
	06 Jun 2017 23:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.203 with HTTP; Tue, 6 Jun 2017 23:27:56 -0700 (PDT)
Received: by 10.28.18.203 with HTTP; Tue, 6 Jun 2017 23:27:56 -0700 (PDT)
In-Reply-To: <2162628.u3sMv0zo5j@peggleto-mobl.ger.corp.intel.com>
References: <CADOTBT2Ps9wzWRGogvZJ1PX6zeuAUXhiyzEjiqDdzsbKDCHLGQ@mail.gmail.com>
	<2162628.u3sMv0zo5j@peggleto-mobl.ger.corp.intel.com>
From: vijaikumar k <vijaikumar.k@mistralsolutions.com>
Date: Wed, 7 Jun 2017 11:57:56 +0530
Message-ID: <CADOTBT1W0C7xLemYSPkMd5Q8Be2ZNNvzHzAaOsYFERLg-MGyDg@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Overriding bitbake functions
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
X-List-Received-Date: Wed, 07 Jun 2017 06:27:57 -0000
Content-Type: multipart/alternative; boundary="94eb2c0d0e304614ab055158d61f"

--94eb2c0d0e304614ab055158d61f
Content-Type: text/plain; charset="UTF-8"

Thanks Paul. That was really helpful.

On Jun 7, 2017 11:56 AM, "Paul Eggleton" <paul.eggleton@linux.intel.com>
wrote:

> On Tuesday, 6 June 2017 9:16:02 AM CEST vijaikumar k wrote:
> > I need to override an append function in bitbake. Just wondering if
> > there is a way to do it.
> >
> > do_configure()
> > do_configure_append()
> > do_configure_append_mymachine()
> >
> > I want to replace/override do_configure_append() with
> > do_configure_append_mymachine(). Is this possible? I do not want to
> > disturb do_configure and do_configure_append function. All the
> > functions are in the same bb file.
>
> _append operations stack up, they can't override eachother, so if MACHINE
> is
> "mymachine" then the final do_configure that gets executed will consist of
> do_configure, do_configure_append, and do_configure_append_mymachine. You
> should set the contents of those accordingly.
>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
>

--94eb2c0d0e304614ab055158d61f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Paul. That was really helpful.</div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Jun 7, 2017 11:56 AM, &quot;=
Paul Eggleton&quot; &lt;<a href=3D"mailto:paul.eggleton@linux.intel.com">pa=
ul.eggleton@linux.intel.com</a>&gt; wrote:<br type=3D"attribution"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">On Tuesday, 6 June 2017 9:16:02 AM CEST vijaikumar k=
 wrote:<br>
&gt; I need to override an append function in bitbake. Just wondering if<br=
>
&gt; there is a way to do it.<br>
&gt;<br>
&gt; do_configure()<br>
&gt; do_configure_append()<br>
&gt; do_configure_append_mymachine(<wbr>)<br>
&gt;<br>
&gt; I want to replace/override do_configure_append() with<br>
&gt; do_configure_append_mymachine(<wbr>). Is this possible? I do not want =
to<br>
&gt; disturb do_configure and do_configure_append function. All the<br>
&gt; functions are in the same bb file.<br>
<br>
_append operations stack up, they can&#39;t override eachother, so if MACHI=
NE is<br>
&quot;mymachine&quot; then the final do_configure that gets executed will c=
onsist of<br>
do_configure, do_configure_append, and do_configure_append_mymachine. You<b=
r>
should set the contents of those accordingly.<br>
<br>
Cheers,<br>
Paul<br>
<br>
--<br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
</blockquote></div></div>

--94eb2c0d0e304614ab055158d61f--
