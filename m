Return-Path: <ross.burton@intel.com>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
	[209.85.216.182])
	by mail.openembedded.org (Postfix) with ESMTP id 67F3660670
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 21:07:34 +0000 (UTC)
Received: by mail-qc0-f182.google.com with SMTP id l6so34129738qcy.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 13:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=Vx7McLVCB5lcpgjO5BVo4fLwphtTTzg5JaRGFLQXMc8=;
	b=gSnr1Oh9JsopRmpyCoxplGfzexF5VN8vC6+l7Ia46AxmILguCKKQMgEuub/DCS4KKT
	T4vUXQLSxO/GDinsWRn+1i7gHbCYcTQAHqyiBP3bXRscqXGXLrR8W+xDBo8ZgfRPQ2uc
	cwV5kftzpVlw5kPLpyeng8uVMNi4KKh5ljaSvryddFpVFrAJ8vq31YYNyqHNRfi8jGVs
	QlSFSOhmYuRs0OVgUiAgT/kW/6xtSfshPMc1XF+SOw8PuniW712wN6K2V8UqaAPmE5tS
	kyddM87LBM+TRbqT4Nl//vKEDVBame0Uxl6aGZK0iuZi3v3+qk4m/uG67XkoGWoFopN0
	aFvw==
X-Gm-Message-State: ALoCoQmF46voZJCupshL4QOE0gRFkdbJStESkR9na/NtINXC9yGclW0wRisLOvSiLkyUPIxJ2s3h
X-Received: by 10.140.49.5 with SMTP id p5mr68581177qga.15.1421874455470; Wed,
	21 Jan 2015 13:07:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.166 with HTTP; Wed, 21 Jan 2015 13:07:15 -0800 (PST)
In-Reply-To: <54BFEE55.5040402@gmail.com>
References: <1421849618-28332-1-git-send-email-ross.burton@intel.com>
	<54BFEE55.5040402@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 21 Jan 2015 21:07:15 +0000
Message-ID: <CAJTo0LbAWxaq9bin3LkmbSM_8nvfHYAec99fZ41aL-NPp-aq=g@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: only check that /dev/shm is writable on Linux
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
X-List-Received-Date: Wed, 21 Jan 2015 21:07:46 -0000
Content-Type: multipart/alternative; boundary=001a11351944d581a7050d2ff117

--001a11351944d581a7050d2ff117
Content-Type: text/plain; charset=UTF-8

On 21 January 2015 at 18:22, Trevor Woerner <twoerner@gmail.com> wrote:

> Cool! On what other platforms does bitbake work?
>

I've been experimenting with OS X.  I'm not sure I'd use the word "work".
Well, bitbake works - but oe-core can't bootstrap the toolchain.

(poky-contrib:ross/darwin)

Ross

--001a11351944d581a7050d2ff117
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 21 January 2015 at 18:22, Trevor Woerner <span dir=3D"ltr">&lt;<a href=
=3D"mailto:twoerner@gmail.com" target=3D"_blank">twoerner@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":6gp" class=3D"=
a3s" style=3D"overflow:hidden">Cool! On what other platforms does bitbake w=
ork?</div></blockquote><div><br></div><div>I&#39;ve been experimenting with=
 OS X.=C2=A0 I&#39;m not sure I&#39;d use the word &quot;work&quot;.=C2=A0 =
Well, bitbake works - but oe-core can&#39;t bootstrap the toolchain.</div><=
div><br></div><div>(poky-contrib:ross/darwin)</div><div><br></div><div>Ross=
=C2=A0</div></div></div></div>

--001a11351944d581a7050d2ff117--
