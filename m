Return-Path: <alexandru.damian@intel.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id A0F35761AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 17:09:42 +0000 (UTC)
Received: by ietj16 with SMTP id j16so23270766iet.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 10:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
	:content-type;
	bh=9eQgB5NEK9TOlUYcPCGww54TYPfiZ1qs2ScD+hCgRbg=;
	b=VrFWNJkLGS1uVqdvOlRaaxBnJ5Q2N82q+A6Hdqh36GRixQZ1DM4051fiMhvk5B77Wi
	cvG6ep01GUG7cOjoh1gbt41tvaJhZeaOXBubcFSn1DZ51+M6HNwvLOO5eDvV+IPkMALn
	pOtaBjofXmUqLnc9seFaGmLtYY1f4UobLm5HOmqbNXfOp71cZMpF9ezC6iMc0daSjg3g
	c6/s4fevmJ1kR/hoDPmZAaS0wA2jlNQecaWTHbO2TNyfTt1qNH3Jj9ptzmwAMDGapcCZ
	0UJnHvQWOmqnegTYOlP8FAaQGpIFJ8z9uo27PX/uVJwWnx9BkBzvPqbtfO+srXM1zOib
	pEbA==
X-Gm-Message-State: ALoCoQlm65v2PnZ4rUH3zx+pRobJOpxSj1jkQmXj+dxWVht49uTe7S8jXHOTqhTnybShfR02LDL2
X-Received: by 10.50.44.100 with SMTP id d4mr8619619igm.67.1437757782018; Fri,
	24 Jul 2015 10:09:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.65.207 with HTTP; Fri, 24 Jul 2015 10:09:22 -0700 (PDT)
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Fri, 24 Jul 2015 18:09:22 +0100
Message-ID: <CAJ2CSBt0HMbnhxs3md+TUVs5kgEtZOPZGuCi5u1dyVWympnqSQ@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	"toaster@yoctoproject.org" <toaster@yoctoproject.org>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	Brian Avery <brian.avery@intel.com>
Subject: [META] tools to make sure the code is sane
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
X-List-Received-Date: Fri, 24 Jul 2015 17:09:42 -0000
Content-Type: multipart/alternative; boundary=e89a8f839f91deec04051ba211bf

--e89a8f839f91deec04051ba211bf
Content-Type: text/plain; charset=UTF-8

Hi guys,

Just wanted to share a bit of personal experience using tools to check
python code.

I've started to use pylint to statically check the toaster code. A patchset
that fixes issues highlighted by pylint up in certain parts of the code, is
available for review on:

https://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/bug_fixes

I've also start using landscape.io which does kind of the same job, and
it's free for open source projects. I've started checking my patches with
this tools, and you can follow it here:

https://landscape.io/github/ddalex/bitbake

What's hosted as "master" on github is not the bitbake upstream, but my WIP
code that's posted for review.


Hope this helps,
Alex

-- 
Alex Damian
Yocto Project
SSG / OTC

--e89a8f839f91deec04051ba211bf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hi guys,</div><div class=3D"gmail_default" style=3D"font-family:=
tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:tahoma,sans-serif">Just wanted to share a bit of personal experience us=
ing tools to check python code.=C2=A0</div><div class=3D"gmail_default" sty=
le=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:tahoma,sans-serif">I&#39;ve started to use pylint to =
statically check the toaster code. A patchset that fixes issues highlighted=
 by pylint up in certain parts of the code, is available for review on:</di=
v><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br>=
</div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">=
<a href=3D"https://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/bug_fixes">https://git.yoctoproject.org/cgit/cgit.cgi/poky-contr=
ib/log/?h=3Dadamian/bug_fixes</a></div><div class=3D"gmail_default" style=
=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-family:tahoma,sans-serif">I&#39;ve also start using <a href=3D=
"http://landscape.io">landscape.io</a> which does kind of the same job, and=
 it&#39;s free for open source projects. I&#39;ve started checking my patch=
es with this tools, and you can follow it here:</div><div class=3D"gmail_de=
fault" style=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmai=
l_default"><font face=3D"tahoma, sans-serif"><a href=3D"https://landscape.i=
o/github/ddalex/bitbake">https://landscape.io/github/ddalex/bitbake</a></fo=
nt><br></div><div class=3D"gmail_default"><font face=3D"tahoma, sans-serif"=
><br></font></div><div class=3D"gmail_default"><font face=3D"tahoma, sans-s=
erif">What&#39;s hosted as &quot;master&quot; on github is not the bitbake =
upstream, but my WIP code that&#39;s posted for review.</font></div><div cl=
ass=3D"gmail_default"><font face=3D"tahoma, sans-serif"><br></font></div><d=
iv class=3D"gmail_default"><font face=3D"tahoma, sans-serif"><br></font></d=
iv><div class=3D"gmail_default"><font face=3D"tahoma, sans-serif">Hope this=
 helps,</font></div><div class=3D"gmail_default"><font face=3D"tahoma, sans=
-serif">Alex</font></div><div><br></div>-- <br><div class=3D"gmail_signatur=
e"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=
=C2=A0</div></div></div>
</div>

--e89a8f839f91deec04051ba211bf--
