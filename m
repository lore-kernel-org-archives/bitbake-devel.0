Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
	[209.85.220.180])
	by mail.openembedded.org (Postfix) with ESMTP id 009366ABF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 21:34:00 +0000 (UTC)
Received: by qkhg7 with SMTP id g7so41248484qkh.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=AW2voZyk8ZL5Ggk3pl2xjt7GWS+PPKnY9nibHgWf4qw=;
	b=0HSN1IUM6+QAVV8tVgoTSYifi52L//sHP9B4U5g3VFkE6NQZcDTtM5o5OmLXNXvaXK
	W6SgudGvXhLJDhu1luSh5Rn6CTNGyLZwM2NNYZSZSYlsNTj6XX0s8/jTDKcDi/ak+zYw
	ay22EYq4weMrbdYFzyZAxRdYLuRZhlGpPccpr/1l/Gh7R2svbsXLoJomuznIwb1CVwsF
	cSMUB/h7BzrJztJynJxipQ2N3dsjvsS9Va+2A/jsbHQmTZHlQeqS1WeXCZ+QGTD7AMXr
	4C8PKz8/1EXeazECRYKPWeoS3relLRmRvzUDVIrjc46WFdoxn1tBUpMcCnEQCjWwRYze
	q4ug==
X-Received: by 10.229.26.135 with SMTP id e7mr28461547qcc.5.1429047241208;
	Tue, 14 Apr 2015 14:34:01 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.34 with HTTP; Tue, 14 Apr 2015 14:33:41 -0700 (PDT)
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB1237988ED7477@ORSMSX101.amr.corp.intel.com>
References: <1429044350-19766-1-git-send-email-ed.bartosh@linux.intel.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237988ED7477@ORSMSX101.amr.corp.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 14 Apr 2015 14:33:41 -0700
X-Google-Sender-Auth: amYVJTV_Ap4o0mQoGGEBbHHlgWI
Message-ID: <CABcZANnTuVDDisxj3W1EjE_RN3MAaLnk2-9Wm_rcnq4E1jR=ew@mail.gmail.com>
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Allow environment variables and ~ in bbconf paths
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
X-List-Received-Date: Tue, 14 Apr 2015 21:34:03 -0000
Content-Type: multipart/alternative; boundary=001a1134101e2df9b70513b5fd86

--001a1134101e2df9b70513b5fd86
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 14, 2015 at 2:19 PM, Rifenbark, Scott M <
scott.m.rifenbark@intel.com> wrote:

> Ed,
>
> This worked for me.... Thanks.
>
> Scott
>
> >-----Original Message-----
> >From: Ed Bartosh [mailto:ed.bartosh@linux.intel.com]
> >Sent: Tuesday, April 14, 2015 1:46 PM
> >To: bitbake-devel@lists.openembedded.org
> >Cc: Rifenbark, Scott M; Ed Bartosh
> >Subject: [PATCH] Allow environment variables and ~ in bbconf paths
> >
> >This should allow to use ~, $HOME and other environment variables in
> bbconf
> >paths.
> >
> >Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
>

We already have a mechanism by which environment variables flow into the
metadata. Is there something wrong with using BB_ENV_EXTRAWHITE to use
${HOME} in this context?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134101e2df9b70513b5fd86
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Apr 14, 2015 at 2:19 PM, Rifenbark, Scott M <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:scott.m.rifenbark@intel.com" target=3D"_blank">scott.m.rifenba=
rk@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ed,<br=
>
<br>
This worked for me.... Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Scott<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;-----Original Message-----<br>
&gt;From: Ed Bartosh [mailto:<a href=3D"mailto:ed.bartosh@linux.intel.com">=
ed.bartosh@linux.intel.com</a>]<br>
&gt;Sent: Tuesday, April 14, 2015 1:46 PM<br>
&gt;To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-dev=
el@lists.openembedded.org</a><br>
&gt;Cc: Rifenbark, Scott M; Ed Bartosh<br>
&gt;Subject: [PATCH] Allow environment variables and ~ in bbconf paths<br>
&gt;<br>
&gt;This should allow to use ~, $HOME and other environment variables in bb=
conf<br>
&gt;paths.<br>
&gt;<br>
&gt;Signed-off-by: Ed Bartosh &lt;<a href=3D"mailto:ed.bartosh@linux.intel.=
com">ed.bartosh@linux.intel.com</a>&gt;<br></div></div></blockquote><div><b=
r></div><div>We already have a mechanism by which environment variables flo=
w into the metadata. Is there something wrong with using BB_ENV_EXTRAWHITE =
to use ${HOME} in this context?</div></div>-- <br><div class=3D"gmail_signa=
ture">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake=
, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Enginee=
r, Mentor Graphics</div>
</div></div>

--001a1134101e2df9b70513b5fd86--
