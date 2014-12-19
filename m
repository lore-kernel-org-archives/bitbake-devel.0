Return-Path: <ross.burton@intel.com>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
	[209.85.216.176])
	by mail.openembedded.org (Postfix) with ESMTP id 763EF728CF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 00:15:13 +0000 (UTC)
Received: by mail-qc0-f176.google.com with SMTP id i17so1988qcy.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 16:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=wkEiJKQt16rkpHqfguwBkxe48w9dmLdwMWRUpyEpkak=;
	b=PBtvqcqnn65YIY7SJmVdKjSzbtc1F35fcaRD/KsoEBDcuyRqJ8ITYvfKT4R+K0EmsU
	ZqUD84xuo9+ApWqxhO9YRkW6cvKI9FvEcz84LeY9fuUVk0kk1WTaqu2F0Eejt0KJdRMl
	kegaTk6Nn5+12ZzXmBmt+ZDkJWaRIDwtrHvXOQQWowb9ABM+do5e+OZVcYIFroU0i7hP
	1Q7N10Kio+Zy50F9gAS3BqiJ4lzkfnIeIbN2Cr5J2AhzKj/+eGxjw5lQFLeGIeUDUiPd
	AKmq1NTlJ6qvElDvwicYAjNdy//f24VhaPR1XAcG45DMjHZxiksT8dzEgJJhIlamKIox
	ca+w==
X-Gm-Message-State: ALoCoQnMnLSGGbQbmz9KmIrdhvaia80op1bKGLNherKaatFYqH9gJv7uidTXiizXcpcwWEMx8Kfj
X-Received: by 10.140.102.144 with SMTP id w16mr8406796qge.59.1418948113953;
	Thu, 18 Dec 2014 16:15:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.166 with HTTP; Thu, 18 Dec 2014 16:14:53 -0800 (PST)
In-Reply-To: <1418914454-24213-1-git-send-email-Martin.Jansa@gmail.com>
References: <1418914454-24213-1-git-send-email-Martin.Jansa@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 19 Dec 2014 00:14:53 +0000
Message-ID: <CAJTo0Lbpe2RCpUh1pE=a1Saq2CGqszWF5gnDsGHnfE8icMVEKw@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: OE-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] powertop: Fix build for !uclibc
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
X-List-Received-Date: Fri, 19 Dec 2014 00:15:16 -0000
Content-Type: multipart/alternative; boundary=001a11c16bc2498b5f050a869a0e

--001a11c16bc2498b5f050a869a0e
Content-Type: text/plain; charset=UTF-8

On 18 December 2014 at 14:54, Martin Jansa <martin.jansa@gmail.com> wrote:
>
>   i586-oe-linux-gcc: error: ${EXTRA_LDFLAGS}: No such file or directory
>

I'm also seeing cups fail on builds with similar errors:

i586-poky-linux-gcc: error: ${SECURITY_NO_PIE_CLAGS}: No such file or
directory

This appears to be down to the recent bitbake merge to master (18cd0)
"data: escape $ in shell variable assignment".  As this is a fairly drastic
change of behaviour to bitbake I think we should revert and revisit the
problem.

Ross

--001a11c16bc2498b5f050a869a0e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 18 December 2014 at 14:54, Martin Jansa <span dir=3D"ltr">&lt;<a href=3D=
"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a=
>&gt;</span> wrote:<blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border=
-left-style:solid;padding-left:1ex"><div id=3D":2ps" class=3D"" style=3D"ov=
erflow:hidden">=C2=A0 i586-oe-linux-gcc: error: ${EXTRA_LDFLAGS}: No such f=
ile or directory<br></div></blockquote></div><br>I&#39;m also seeing cups f=
ail on builds with similar errors:</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">i586-poky-linux-gcc: error: ${SECURITY_NO_PIE_=
CLAGS}: No such file or directory<br></div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">This appears to be down to the recent bitba=
ke merge to master (18cd0) &quot;data: escape $ in shell variable assignmen=
t&quot;.=C2=A0 As this is a fairly drastic change of behaviour to bitbake I=
 think we should revert and revisit the problem.</div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a11c16bc2498b5f050a869a0e--
