Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
	[209.85.220.176])
	by mail.openembedded.org (Postfix) with ESMTP id E6B0D606E8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 13:46:56 +0000 (UTC)
Received: by qkhq76 with SMTP id q76so5297114qkh.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 06:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=6bv5XxZL56DWCLBONEj4yGmMG0NgjOSJiPiTTaBax8M=;
	b=MHIn/vnvB4Yvu9/93ZQbs2s4T/llI0ldITphZZYQiV0HY9tpWQ2scSwCP46T86c3yb
	D7KqzOvT12414FmqAvX9+bNYPWsNyUVE3IAmX5QIrfj6ew/VbnIx3AZchP1bQlxQYsjT
	hfOzXKhn0ouw/5gPjpPLAX2RAQyzfpOrBz0kOf/X2OpQNZCiaiM7nuxsjDgjKMYFfSEU
	PNz1t5EolyvP1bbKGjeO0ZB6mJe7GCGLLMAyiGEJIHMKmLfGyfnL7CAme/cVzR+VRKp8
	URKIU4TLn7aaOvntbjQ+p/GfhP0gOmQuL5WsztfFTveEagsPLMnUqmpd5/4CGs7z/L9c
	XMdg==
X-Gm-Message-State: ALoCoQn0bOpA10yDWJ7mn/mYXoLIE176mKOFZ8nL75JbFS9gJcXy8oa4PbD3R8NclKew7AzPmjtm
X-Received: by 10.55.40.18 with SMTP id o18mr59635291qkh.58.1433339217366;
	Wed, 03 Jun 2015 06:46:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Wed, 3 Jun 2015 06:46:37 -0700 (PDT)
In-Reply-To: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 3 Jun 2015 14:46:37 +0100
Message-ID: <CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Wed, 03 Jun 2015 13:46:57 -0000
Content-Type: multipart/alternative; boundary=001a11440fb8e506f005179d4a54

--001a11440fb8e506f005179d4a54
Content-Type: text/plain; charset=UTF-8

On 3 June 2015 at 13:16, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> I am using yocto 1.6 and I have written a component and written bitbake
> recipe file for this component. When rootfs is created my library is found
> in "/lib" directory but I want it to be installed to
> "/usr/lib/gstreamer-0.10" directory (which is already created by open
> source gstreamer packages).


This is under the control of your makefiles, so you'll need to share
those.  My guess is that you're using a variable name in the makefile that
has a defined meaning in automake so your assignment gets overridden.

(also, this isn't anything to do with development of bitbake, so this
discussion should be on yocto@)

Ross

--001a11440fb8e506f005179d4a54
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 3 June 2015 at 13:16, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I am using yocto 1.6 a=
nd I have written a component and written bitbake recipe file for this comp=
onent. When rootfs is created my library is found in &quot;/lib&quot; direc=
tory but I want it to be installed to &quot;/usr/lib/gstreamer-0.10&quot; d=
irectory (which is already created by open source gstreamer packages).</blo=
ckquote><div><br></div><div>This is under the control of your makefiles, so=
 you&#39;ll need to share those.=C2=A0 My guess is that you&#39;re using a =
variable name in the makefile that has a defined meaning in automake so you=
r assignment gets overridden.</div><div><br></div><div>(also, this isn&#39;=
t anything to do with development of bitbake, so this discussion should be =
on yocto@)</div><div><br></div><div>Ross</div></div></div></div>

--001a11440fb8e506f005179d4a54--
