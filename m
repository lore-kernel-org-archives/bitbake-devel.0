Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <wmat@alphatroop.com>) id 1TmxUO-0004X9-Rj
	for bitbake-devel@lists.openembedded.org;
	Mon, 24 Dec 2012 03:10:02 +0100
Received: by mail-ie0-f169.google.com with SMTP id c14so8485326ieb.14
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Dec 2012 17:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=JFLUpsZOSEzBD4ThNxG3Lbqe2DGVQ1PDTc5O+r22X9k=;
	b=QoQ52arbqL/G6KmJS0B+jIbdN04QCsz3lCBSpqc2qgaWiejehG3pmj/hrFJrU3i4EK
	f/p6GC0EgT6hkR9LdFQE3seX7IT1SdRPWGY83og+xlx8FmMK+v9DRzICiJ1YKUe3A/7C
	VHdVqK0qLSH9PCYaKBfAm7NWEplzk6Dp83irQLRtOURchlSXLEJ/0xhc015dXn2jDXGV
	+ChnODfprHb/4rsetFKhniJ3w+cKpSNa9+B2UyeChN6Wexn2ST2OrUzu9J7mbASXZoj3
	co0kissoi6lzVjgiP7vCdzAXVRbu4Ls7mNrY+QCNDuZZf6lgaDRIceQLuAsMwdR+AbAH
	XupQ==
Received: by 10.50.91.195 with SMTP id cg3mr18853084igb.57.1356314111049; Sun,
	23 Dec 2012 17:55:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.74.169 with HTTP; Sun, 23 Dec 2012 17:54:50 -0800 (PST)
X-Originating-IP: [24.246.30.132]
In-Reply-To: <5680339.a2UlTKzCpO@helios>
References: <50D50E7A.6060201@mindchasers.com>
	<50D53C11.5030404@mindchasers.com> <5680339.a2UlTKzCpO@helios>
From: Bill Traynor <wmat@alphatroop.com>
Date: Sun, 23 Dec 2012 20:54:50 -0500
Message-ID: <CAGfZjq5=WktLfXqjWU3obz3mn_n-jRzBXMQGvns_jJMVESX1DA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
X-Gm-Message-State: ALoCoQlw1K4RmHwJFUADVPMGR5sy6NAkn8ZkbAxVvnhswLmMzwPJSAB8tudBSLsyb+GrSGMgODmH
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: executable metadata not supported in bbappend files?
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
X-List-Received-Date: Mon, 24 Dec 2012 02:10:03 -0000
Content-Type: multipart/alternative; boundary=e89a8f235329cb001704d18f7c00

--e89a8f235329cb001704d18f7c00
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Dec 23, 2012 at 2:43 PM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> On Friday 21 December 2012 23:50:25 Bob Cochran wrote:
> > On 12/21/2012 08:35 PM, Bob Cochran wrote:
> > > I just noticed that the current bitbake manual states in the "Defining
> > > executable metadata" section that executable metadata is only supported
> > > in .bb and .bbclass files, but I find that I can put (at least some
> > > basic) tasks in .bbappend files, too.
> > >
> > > Is this an oversight in the documentation, or are there gotchas adding
> > > tasks to bbappend files that I haven't come across?  If it's the
> former,
> > > I'll submit a patch.
> >
> > I see that bbappend isn't mentioned anywhere in the bitbake manual.
> > That's a little confusing?
>
> This is just an example of where the bitbake manual needs updating -
> bbappends
> weren't implemented when it was written. I believe the bitbake manual is
> being
> updated at the moment but I'm sure patches would still be welcome to
> extend it
> to mention bbappends in the appropriate places.
>

Yes, the manual is being updated.  Look for significant patches over the
next month.


>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>

--e89a8f235329cb001704d18f7c00
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Sun, Dec 23, 2012 at 2:43 PM, Paul Eggleton <span dir=3D"ltr">&l=
t;<a href=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.e=
ggleton@linux.intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Friday 21 December 2012=
 23:50:25 Bob Cochran wrote:<br>
&gt; On 12/21/2012 08:35 PM, Bob Cochran wrote:<br>
</div><div class=3D"im">&gt; &gt; I just noticed that the current bitbake m=
anual states in the &quot;Defining<br>
&gt; &gt; executable metadata&quot; section that executable metadata is onl=
y supported<br>
&gt; &gt; in .bb and .bbclass files, but I find that I can put (at least so=
me<br>
&gt; &gt; basic) tasks in .bbappend files, too.<br>
&gt; &gt;<br>
&gt; &gt; Is this an oversight in the documentation, or are there gotchas a=
dding<br>
&gt; &gt; tasks to bbappend files that I haven&#39;t come across? =A0If it&=
#39;s the former,<br>
&gt; &gt; I&#39;ll submit a patch.<br>
&gt;<br>
</div><div class=3D"im">&gt; I see that bbappend isn&#39;t mentioned anywhe=
re in the bitbake manual.<br>
&gt; That&#39;s a little confusing?<br>
<br>
</div>This is just an example of where the bitbake manual needs updating - =
bbappends<br>
weren&#39;t implemented when it was written. I believe the bitbake manual i=
s being<br>
updated at the moment but I&#39;m sure patches would still be welcome to ex=
tend it<br>
to mention bbappends in the appropriate places.<br></blockquote><div><br></=
div><div style>Yes, the manual is being updated. =A0Look for significant pa=
tches over the next month.</div><div style>=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">


<br>
Cheers,<br>
Paul<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-deve=
l" target=3D"_blank">http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bi=
tbake-devel</a><br>
</div></div></blockquote></div><br></div></div>

--e89a8f235329cb001704d18f7c00--
