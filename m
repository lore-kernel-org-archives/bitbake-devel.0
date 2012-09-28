Received: from mga10.intel.com ([192.55.52.92] helo=fmsmga102.fm.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1THW4w-0003N4-AK
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 10:37:46 +0200
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by mga11.intel.com with ESMTP/TLS/RC4-SHA; 28 Sep 2012 01:24:52 -0700
Received: by qcad10 with SMTP id d10so2214425qca.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 01:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:x-gm-message-state;
	bh=NuJM5hog9jsMQJY9U9jJwPEl+GrG2MchUoHyulRJMpg=;
	b=AFY/mCx3QfKXCPS675BwWdcjZUsQ1VQslzkFVJ33IwgnqvWffOtZnz/OOD1VmsG3Kx
	W3uWQpUDPeVOoK4XZcS7mf4eakvUBzS+Zj9BTFBPxYB4uK1yOWyz197vwvI57B3keGLb
	ASDv2QQchLiT9sgK06LMCtrcfq5WHJdPxuv6GRsesiZF1S+5CxdDIt/TJeGBHRXtgwHQ
	e+wNmycCvm/yK3jRlVmTbPCB8vqszvPff6pttvC1YHSRNRII44bOQspBmy2WFLIc7IxL
	6e1iX44tMeA2DkwbQegbJzK4h+yxIGDaQq6piV6iYyV293/EqWONZv1RRcYOnpOGiY+g
	gB1A==
Received: by 10.224.190.200 with SMTP id dj8mr15545544qab.73.1348820691105;
	Fri, 28 Sep 2012 01:24:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.49.74.74 with HTTP; Fri, 28 Sep 2012 01:24:30 -0700 (PDT)
In-Reply-To: <1348760645.11186.7.camel@ted>
References: <1348667997-7165-1-git-send-email-bogdan.a.marinescu@intel.com>
	<1348760645.11186.7.camel@ted>
From: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>
Date: Fri, 28 Sep 2012 11:24:30 +0300
Message-ID: <CAMZjud1+PiP04tBSwgOj=LKAXW0WaietY8Ae5hFw7y1a7ksnfQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Gm-Message-State: ALoCoQnV9A0la+VF5F6AEQOdcsmFVXsLQByKF1LD0jbfLy0B+agFk6v/2Jhk0cIL8pCOVc3iEpEF
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] [hob] Add sanity check progress screen
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
X-List-Received-Date: Fri, 28 Sep 2012 08:37:46 -0000
Content-Type: multipart/alternative; boundary=20cf3005def428b72f04cabecac9

--20cf3005def428b72f04cabecac9
Content-Type: text/plain; charset=ISO-8859-1

Hi Richard,

On Thu, Sep 27, 2012 at 6:44 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2012-09-26 at 16:59 +0300, Bogdan Marinescu wrote:
> > This patch adds a sanity check progress screen to hob. The screen
> > is displayed when Hob executes the sanity check procedure. The screen
> > is displayed for at least 5 seconds. If a network error is detected,
> > a special dialog is displayed which lets the user open the proxy
> > configuration page directly.
> > Note that currently bitbake triggers the network tests only when
> > the value of its TMPDIR variable changes, which happens fairly rare
> > on my system. This is the subject of another bug (#3026).
> > Version 2 of the patch splits the changes in two parts (sanity.bbclass
> > belongs to oe-core).
> >
> > [YOCTO #3025]
> >
> > Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> > ---
> >  bitbake/lib/bb/event.py                     |    3 +-
> >  bitbake/lib/bb/ui/crumbs/builder.py         |  124
> ++++++++++++++++++++++++---
> >  bitbake/lib/bb/ui/crumbs/hig.py             |    5 ++
> >  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 +-
> >  bitbake/lib/bb/ui/crumbs/sanitycheckpage.py |   85 ++++++++++++++++++
> >  5 files changed, 205 insertions(+), 17 deletions(-)
> >  create mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py
>
>
> Merged to master, thanks.
>

It appears that this page was not merged properly. The new
sanitycheckpage.py file didn't get merged. I remember that I needed to use
"git add -f" (force) to add this file, since a .gitignore prevented it from
being added in the usual way (why does .gitignore mask .py files anyway?)
This might be why it didn't get merged in the end.
For all the people that updated the master and can't start hob because of
this problem: a temporary solution is to move your HEAD before my commit.
In this case:

git reset --hard 6fdff49d9b37a18221f8d5571f757e69b945e533

One more thing for Richard: this patch has a corresponding patch in oe-core
("Added explicit network error status in SanityCheckFailed event"). Please
take a look at that one too.

Thanks,
Bogdan


> Richard
>
>

--20cf3005def428b72f04cabecac9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Richard,<br><br><div class=3D"gmail_quote">On Thu, Sep 27, 2012 at 6:44 =
PM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@l=
inuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a=
>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Wed, 2012-09-26 at 16:59 +0300, Bogd=
an Marinescu wrote:<br>
&gt; This patch adds a sanity check progress screen to hob. The screen<br>
&gt; is displayed when Hob executes the sanity check procedure. The screen<=
br>
&gt; is displayed for at least 5 seconds. If a network error is detected,<b=
r>
&gt; a special dialog is displayed which lets the user open the proxy<br>
&gt; configuration page directly.<br>
&gt; Note that currently bitbake triggers the network tests only when<br>
&gt; the value of its TMPDIR variable changes, which happens fairly rare<br=
>
&gt; on my system. This is the subject of another bug (#3026).<br>
&gt; Version 2 of the patch splits the changes in two parts (sanity.bbclass=
<br>
&gt; belongs to oe-core).<br>
&gt;<br>
&gt; [YOCTO #3025]<br>
&gt;<br>
&gt; Signed-off-by: Bogdan Marinescu &lt;<a href=3D"mailto:bogdan.a.marines=
cu@intel.com" target=3D"_blank">bogdan.a.marinescu@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0bitbake/lib/bb/event.py =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A03 +-<br>
&gt; =A0bitbake/lib/bb/ui/crumbs/builder.py =A0 =A0 =A0 =A0 | =A0124 ++++++=
++++++++++++++++++---<br>
&gt; =A0bitbake/lib/bb/ui/crumbs/hig.py =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 =
++<br>
&gt; =A0bitbake/lib/bb/ui/crumbs/hobeventhandler.py | =A0 =A05 +-<br>
&gt; =A0bitbake/lib/bb/ui/crumbs/sanitycheckpage.py | =A0 85 ++++++++++++++=
++++<br>
&gt; =A05 files changed, 205 insertions(+), 17 deletions(-)<br>
&gt; =A0create mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py<br>
<br>
<br>
</div>Merged to master, thanks.<br></blockquote><div><br></div><div>It appe=
ars that this page was not merged properly. The new sanitycheckpage.py file=
 didn&#39;t get merged. I remember that I needed to use &quot;git add -f&qu=
ot; (force) to add this file, since a .gitignore prevented it from being ad=
ded in the usual way (why does .gitignore mask .py files anyway?) This migh=
t be why it didn&#39;t get merged in the end.</div>


<div>For all the people that updated the master and can&#39;t start hob bec=
ause of this problem: a temporary solution is to move your HEAD before my c=
ommit. In this case:</div><div><br></div><div>git reset --hard=A06fdff49d9b=
37a18221f8d5571f757e69b945e533</div>


<div><br></div><div>One more thing for Richard: this patch has a correspond=
ing patch in oe-core (&quot;Added explicit network error status in SanityCh=
eckFailed event&quot;). Please take a look at that one too.<br></div><div>

<br></div><div>Thanks,</div><div>Bogdan</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">

<span><font color=3D"#888888"><br>
Richard<br>
<br>
</font></span></blockquote></div><br>

--20cf3005def428b72f04cabecac9--
