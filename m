Return-Path: <alex.r.damian@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by mail.openembedded.org (Postfix) with ESMTP id 408E56BD61
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jan 2014 11:13:22 +0000 (UTC)
Received: by mail-qc0-f179.google.com with SMTP id e16so275788qcx.38
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jan 2014 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=iwQYf3I5Ym1SRGDzKeLT3dDjk/+DAElm9S2C/A9Ho/I=;
	b=Jcfgik4jpEKZSgzS+6obIxojK7mSxgcZzoC8SyynlwDBtwVtMntF5SiTI67wN8v8Hf
	lFnHpXx4cz2EVA2GMqElC8795CI87PCu8ftR0F5mBD459YugmWE2EcNBCV/GoRDaPVMO
	lZluSJAVidjOQr433rmi20EGcPPsYH9hQo6KuXz1FqpoNNxnFOGU7wHVtp2uSt9tF2YE
	m6MQRYNvg8c4KzenN44CqcxqeyRjb45TYIc/ke14hj88tVnwMceAJYiWrvAZQnIBFOcp
	r6JvMwqQGRJAX0sB8GJjbmlrwROZlvERDxyKLlsBE19R/OtZnYgoUUYkDajUCcUqaLNo
	nCiQ==
MIME-Version: 1.0
X-Received: by 10.140.89.52 with SMTP id u49mr1043134qgd.93.1390907602711;
	Tue, 28 Jan 2014 03:13:22 -0800 (PST)
Received: by 10.224.8.9 with HTTP; Tue, 28 Jan 2014 03:13:22 -0800 (PST)
In-Reply-To: <231818182.Sb91aSKJsj@peggleto-mobl5.ger.corp.intel.com>
References: <CAJ2CSBtYQ6fMSboyGDzFPR8OpANbrxxUdMKYeHjx4dw1b=PwgQ@mail.gmail.com>
	<231818182.Sb91aSKJsj@peggleto-mobl5.ger.corp.intel.com>
Date: Tue, 28 Jan 2014 11:13:22 +0000
Message-ID: <CAL7ttbf-hjJZs9mDyaZbUYO_6e=2c-iApTdQm_W7tj5sX27jog@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "Damian, Alexandru" <alexandru.damian@intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: patchset for toaster, upstream from toaster/master
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
X-List-Received-Date: Tue, 28 Jan 2014 11:13:23 -0000
Content-Type: multipart/alternative; boundary=001a11c1236a9339eb04f105e96d

--001a11c1236a9339eb04f105e96d
Content-Type: text/plain; charset=ISO-8859-1

Dropped and resubmitted.

Thanks,
Alex


On Tue, Jan 28, 2014 at 9:06 AM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> Hi Alex,
>
> On Monday 27 January 2014 16:49:31 Damian, Alexandru wrote:
> > This is a pull-request for a patchset on toaster.
> >
> > The patchset is a subset of poky-contrib/toaster/master, filtered for
> just
> > the bitbake relevant patches.
> >
> > The patchset has passed multiple reviews by me and Paul Eggleton.
> >
> > Can you please pull:
> >
> >
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/submis
> > sion27012014
>
> I forgot to mention - could you please drop the vim modelines patch from
> the
> branch?
>
> Thanks,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a11c1236a9339eb04f105e96d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dropped and resubmitted.<br><br></div>Thanks,<br>Alex=
<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
Tue, Jan 28, 2014 at 9:06 AM, Paul Eggleton <span dir=3D"ltr">&lt;<a href=
=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@l=
inux.intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Alex,<br>
<div class=3D"im"><br>
On Monday 27 January 2014 16:49:31 Damian, Alexandru wrote:<br>
&gt; This is a pull-request for a patchset on toaster.<br>
&gt;<br>
&gt; The patchset is a subset of poky-contrib/toaster/master, filtered for =
just<br>
&gt; the bitbake relevant patches.<br>
&gt;<br>
&gt; The patchset has passed multiple reviews by me and Paul Eggleton.<br>
&gt;<br>
&gt; Can you please pull:<br>
&gt;<br>
&gt; <a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/=
?h=3Dadamian/submis" target=3D"_blank">http://git.yoctoproject.org/cgit/cgi=
t.cgi/poky-contrib/log/?h=3Dadamian/submis</a><br>
&gt; sion27012014<br>
<br>
</div>I forgot to mention - could you please drop the vim modelines patch f=
rom the<br>
branch?<br>
<br>
Thanks,<br>
Paul<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div>

--001a11c1236a9339eb04f105e96d--
