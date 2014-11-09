Return-Path: <ross.burton@intel.com>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
	[209.85.192.51])
	by mail.openembedded.org (Postfix) with ESMTP id 9282E65C91
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Nov 2014 22:50:08 +0000 (UTC)
Received: by mail-qg0-f51.google.com with SMTP id j5so4617458qga.38
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 09 Nov 2014 14:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=ImeyaBX3Y6AKL/U0OAw5DAAZIMHo8RhP2r30Vk6WEzg=;
	b=aKVulilt4TKhKbv3XOSnIhySqZ5rhVOOq/RI6pwI9ztCP1/5Tf12usXh9QO3dKy4QM
	Uu0wYzITxDfN8dDwzHaCJ7GEOB2dRktWcZOk4O/dV0a5Se9MecKs288OldFgQidI2tfe
	J2xUiopaloVPoka+UjBStIKMYh3ZT7nkQXNKcoYmOq7AM5HM5JKfUatYpmFd6v8kT628
	BCx932mrhuqMT+KJ6vMMu5B1Z0DzSM8fODfC2jLdV1j4Z8cb3y0Xesu4IFznEx9GQsxM
	fXiFbyklz+pXTEURfjvjkXlDx2IPbjtGSRU6trcSTZVbKov0Ob2IRJUmqYeM8fvzVdoW
	Cr4A==
X-Gm-Message-State: ALoCoQkweUd/6ntnashBGROsghvQ54r1TfJ5kvYH7ByU6mIZu+zfoX5pcNpfJ5xhGRfWw0ojllyy
X-Received: by 10.140.96.101 with SMTP id j92mr36651395qge.87.1415573409136;
	Sun, 09 Nov 2014 14:50:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.98.213 with HTTP; Sun, 9 Nov 2014 14:49:48 -0800 (PST)
In-Reply-To: <545EF0DC.6030200@gmail.com>
References: <545EF0DC.6030200@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Sun, 9 Nov 2014 22:49:48 +0000
Message-ID: <CAJTo0LYME7VYRnVP_v2te=jay1dFzk_P+y+P0TRyHxpu0uoQ5g@mail.gmail.com>
To: akuster808 <akuster808@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	OE-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] building world
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
X-List-Received-Date: Sun, 09 Nov 2014 22:50:13 -0000
Content-Type: multipart/alternative; boundary=001a113a9d8a349ffa050774def0

--001a113a9d8a349ffa050774def0
Content-Type: text/plain; charset=UTF-8

On 9 November 2014 04:43, akuster808 <akuster808@gmail.com> wrote:

> "WARNING: Building libpam but 'pam' isn't in DISTRO_FEATURES, PAM won't
> work correctly"
>
> It seems to me that if one is building 'world' then all "DISTRO_FEATURES"
> should be defined, otherwise World isn't really world.
>

If world enabled all distro features then you won't be able to do a world
build to verify that everything builds without specific distro features
being enabled.   If I were building a system that did world builds and
alerted on any warnings, I'd have a whitelist.

Ross

--001a113a9d8a349ffa050774def0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 9 November 2014 04:43, akuster808 <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:akuster808@gmail.com" target=3D"_blank">akuster808@gmail.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div id=3D":1r7" class=3D"a3s" =
style=3D"overflow:hidden">&quot;WARNING: Building libpam but &#39;pam&#39; =
isn&#39;t in DISTRO_FEATURES, PAM won&#39;t work correctly&quot;<br>
<br>
It seems to me that if one is building &#39;world&#39; then all &quot;DISTR=
O_FEATURES&quot; should be defined, otherwise World isn&#39;t really world.=
</div></blockquote></div><br>If world enabled all distro features then you =
won&#39;t be able to do a world build to verify that everything builds with=
out specific distro features being enabled. =C2=A0 If I were building a sys=
tem that did world builds and alerted on any warnings, I&#39;d have a white=
list.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
Ross</div></div>

--001a113a9d8a349ffa050774def0--
