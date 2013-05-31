Return-Path: <pranap@gmail.com>
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com
	[209.85.128.169])
	by mail.openembedded.org (Postfix) with ESMTP id AE8886041D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 18:10:50 +0000 (UTC)
Received: by mail-ve0-f169.google.com with SMTP id m1so1406094ves.28
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=fb6IC3ii39s1BBR0kWcRXnspo+KiKIOjFO/LeOfvL/w=;
	b=e3hLABwCnqzQvZkvUBv+9IrqgYdOTeVWPwhs0g8dLhJDHLDpRkf7cUk8yapw/1ks9T
	hk28tLUBlVaz3mVRk8JHvsC8lU6e6YeIXr3oHjEd44RNYA0p6Jdu9xtyBf4I5rjqH0ii
	qQ0a/8djSn6wmkRVxCL4GxsnWiBoJ6oe8+yQaVmjNC2PbNXUkL1sMN7QP5NjQvhchpnq
	+8Iq5/y4IxRAJMU/VwRRXiMhJadvh/kNFukTjYy4lM/lKkd6kSAa9r9MknZy22OnTx8C
	6u/pRlCb+NxKKRkTifh3qerngoQEFP8YULXiCo6VBZr5DWtIKRaZrfPN6K/tuVsw8PaZ
	dJow==
MIME-Version: 1.0
X-Received: by 10.52.178.134 with SMTP id cy6mr9074811vdc.73.1370023851106;
	Fri, 31 May 2013 11:10:51 -0700 (PDT)
Received: by 10.58.181.70 with HTTP; Fri, 31 May 2013 11:10:51 -0700 (PDT)
Date: Fri, 31 May 2013 11:10:51 -0700
Message-ID: <CAKFDafX5prkgzGgDmmTkTbY6+q9cP-tnSZaT=cPd0D9XPDQ_sQ@mail.gmail.com>
From: Pr Pe <pranap@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake & klocwork
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 18:10:50 -0000
Content-Type: multipart/alternative; boundary=bcaec5014bc1faaa9804de0788b4

--bcaec5014bc1faaa9804de0788b4
Content-Type: text/plain; charset=ISO-8859-1

Has anyone tried to use klocwork to analyze their source that using bitbake
and equivalent make files?

I tried to have a custom do_compile to run "kinject oe_runmake" instead of
just "oe_runmake", but that just gave an error about oe_runmake not
recognized (i think, by kinject).

So, I changed it to do "kinject make" instead of "oe_runmake" and it just
returned with an   empty kinject file - which means it did nothing because
it ran into errors.

I am looking at the meta/classes to see if I can override do_compile in
some of the bbclass files there and see how things work, but could use some
guidance on where to start and how to do this.

Thanks,
Prana

--bcaec5014bc1faaa9804de0788b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Has anyone tried to use klocwork to analyze their source t=
hat using bitbake and equivalent make files?=A0<div><br></div><div>I tried =
to have a custom do_compile to run &quot;kinject oe_runmake&quot; instead o=
f just &quot;oe_runmake&quot;, but that just gave an error about oe_runmake=
 not recognized (i think, by kinject).=A0</div>
<div><br></div><div style>So, I changed it to do &quot;kinject make&quot; i=
nstead of &quot;oe_runmake&quot; and it just returned with an =A0 empty kin=
ject file - which means it did nothing because it ran into errors.=A0</div>
<div style><br></div><div style>I am looking at the meta/classes to see if =
I can override do_compile in some of the bbclass files there and see how th=
ings work, but could use some guidance on where to start and how to do this=
.</div>
<div style><br></div><div style>Thanks,<br></div><div style>Prana</div></di=
v>

--bcaec5014bc1faaa9804de0788b4--
