Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
	[209.85.215.50])
	by mail.openembedded.org (Postfix) with ESMTP id 0F1066FDEB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Oct 2014 20:27:42 +0000 (UTC)
Received: by mail-la0-f50.google.com with SMTP id s18so2024578lam.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Oct 2014 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=AOiE/Q2q7TDc8F20fUa9fdLRBveaBzJVNZobAs8c4TU=;
	b=rCX6hCciI3xtsH2uZb7YgFwxf1GCxGdsxGZ0Z2mvXF99wLDjirJeAUqDhCKYC3ZUAy
	xSKnzCLvtx7ID+NKqN0KNmqiWgLolc78NPouUYeZRB6w0+ic+jfHPe93Yc54kbdF0b+O
	73VNrnQzotphCbVjFZ5AF/nqaBNpiXW6RNJ3N53gtz4BH0RMbdHmhDR3LDS/wdPtjFNi
	P25zO4O1KVycZEqFBL0qe9Rst3hdJKMVyJDOTJ+NEb+sstq5YbLkU3RIAkj8YHp0NyPn
	5gRiEBPyUObAoYlxSlBvNlzWrydWqTisi2CsrcA36kfiX+t9QvLvEtrQlwcXR2sVPIjz
	By/w==
X-Received: by 10.152.7.208 with SMTP id l16mr118722laa.48.1412886461133; Thu,
	09 Oct 2014 13:27:41 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.97.200 with HTTP; Thu, 9 Oct 2014 13:27:21 -0700 (PDT)
In-Reply-To: <5436EE92.1010308@linux.intel.com>
References: <1412094118-27406-1-git-send-email-alejandro.hernandez@linux.intel.com>
	<CABcZAN=+nJjhKpGXnshy-VuFdW85oXwG5V9KsPMe79qm5cWXsQ@mail.gmail.com>
	<5436EE92.1010308@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 9 Oct 2014 13:27:21 -0700
X-Google-Sender-Auth: 08mtv_5fJDSc3dKlIhwm7a8qX_U
Message-ID: <CABcZANnpRcOBo7wSoVoHh3P7KB717LoJ9UySKE0TPiEh-cthkQ@mail.gmail.com>
To: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Thu, 09 Oct 2014 20:27:44 -0000
Content-Type: multipart/alternative; boundary=001a11c329ea9fbdd1050503434f

--001a11c329ea9fbdd1050503434f
Content-Type: text/plain; charset=UTF-8

On Thu, Oct 9, 2014 at 1:22 PM, Alejandro Hernandez <
alejandro.hernandez@linux.intel.com> wrote:

> It does not change behavior but it forces the value to be a string,
> avoiding related problems when performing comparisons on "strict", another
> option as Richard Purdie suggested would be to import the boolean function
> from /meta/lib/oe/types.py in OE-Core into a new types module in bitbake,
> forcing it to get a "good" value that we could then use.


No, that's incorrect. The second argument of getVar is a boolean argument
named 'expand', which controls whether you get an expanded or unexpanded
value. You're now passing a string in boolean context.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c329ea9fbdd1050503434f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Oct 9, 2014 at 1:22 PM, Alejandro Hernandez <span dir=3D"ltr">&lt;<=
a href=3D"mailto:alejandro.hernandez@linux.intel.com" target=3D"_blank">ale=
jandro.hernandez@linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">It does not change behavior but it forces the value to be a s=
tring,
    avoiding related problems when performing comparisons on &quot;strict&q=
uot;,
    another option as Richard Purdie suggested would be to import the
    boolean function from /meta/lib/oe/types.py in OE-Core into a new
    types module in bitbake, forcing it to get a &quot;good&quot; value tha=
t we
    could then use.</blockquote></div><br>No, that&#39;s incorrect. The sec=
ond argument of getVar is a boolean argument named &#39;expand&#39;, which =
controls whether you get an expanded or unexpanded value. You&#39;re now pa=
ssing a string in boolean context.<br>-- <br>Christopher Larson<br>clarson =
at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Mainta=
iner - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a11c329ea9fbdd1050503434f--
