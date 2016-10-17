Return-Path: <avery.brian@gmail.com>
Received: from mail-vk0-f68.google.com (mail-vk0-f68.google.com
	[209.85.213.68])
	by mail.openembedded.org (Postfix) with ESMTP id A2CBA6022E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Oct 2016 22:25:15 +0000 (UTC)
Received: by mail-vk0-f68.google.com with SMTP id 130so6309727vkg.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Oct 2016 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=4KCgMQ9AJuLEmr0iRJxBcA/Ogug1Bi3ZXuQwZUyxxRY=;
	b=bT7LXu3h4EAqzNjJwfNf2BifQ4ZZuBzbrHak0niwDSXMUIiCmQdNqnBKae6pP+SGQa
	4NxFYMJh/sr1L9pfp9DKhCYe0ALHM50+3SSIAj/T2mLKkMNpbcL9/KHioKdx/jk2Uvmc
	BrI9FA3GFUzv/0161peF2+ovT0L5tZXh9DFZQ33+UH9tLQvScnnxIxl1pG9yx5R7ZYdq
	IRSg0OVG8/vg7ZXF094b7P2Cokp3ImV8aj+RKxN8j1+UEkZYVcLndp47ag7OJnQChfp/
	EXfFF8/Gj1WJ5jVPgl6RyhMqgP0Y0FGPoB0IzYCrrghCWP4k5xXVv3JvJG0AfTf7h6P+
	u62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=4KCgMQ9AJuLEmr0iRJxBcA/Ogug1Bi3ZXuQwZUyxxRY=;
	b=ffkCWoV80cwbUaFZaQU9kzEyGi6RYuN0zl9CnQVKWGm3Qu6/SCuM0HlSXCCQX9fk+i
	IgTiiv4cz6cp4Kb0sg9weC6m1iHeLX+KV1x3kHuk/nmDG4qE78bVx+C6qqARjXOQS1qh
	uZhy9IK/vGBnJ3EThDAxceMGGLNJQ3Lc/YPYnT8dHOSGLaMQmt9cX4J+6spAdiayTDAx
	gQRRTfxPKrYFNkdfHjpi3d6mdQmSJdai7jBPmYTqKH1NywqAogmHI7YbqL96fY+KrYrZ
	ERSkVowHMK0UNCgwTnE8mJw2Ha5AqCg5NfPZM8N1ixRv3MeuG7MDMB81bjyS8vfDXy8q
	cynQ==
X-Gm-Message-State: AA6/9Rk1ehPmn3QGnmX+mtD/8go+sJwOqpMc5bbOwa9SuCf1VZwGh/c980T/WAz9d0KRj43cF11OmFa2Da4oqA==
X-Received: by 10.31.12.17 with SMTP id 17mr20640495vkm.108.1476743117460;
	Mon, 17 Oct 2016 15:25:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.67.194 with HTTP; Mon, 17 Oct 2016 15:25:16 -0700 (PDT)
In-Reply-To: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
References: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
From: Brian Avery <avery.brian@gmail.com>
Date: Mon, 17 Oct 2016 15:25:16 -0700
Message-ID: <CAKV_0eiDd-JeBsem3XTW0vHUWqvCvBwCETgkhtAt-TuiW=H_8Q@mail.gmail.com>
To: Michael Wood <michael.g.wood@intel.com>
Cc: Richard Purdie <richard.purdie@intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3][1.32] Add morty/2.2/1.32 release information to toaster
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
X-List-Received-Date: Mon, 17 Oct 2016 22:25:16 -0000
Content-Type: multipart/alternative; boundary=001a114573aaf0dd1c053f170cb1

--001a114573aaf0dd1c053f170cb1
Content-Type: text/plain; charset=UTF-8

So,

This patch set lost the MORTY part of the subject line in it's journey from
the toaster mailing list to the bitbake maling list.

This patch was supposed to be applied only to morty since it limits the
available toaster project releases to morty.

Master should have the choice of making a morty project or a master project
and so should get a *different* patch that appends the morty release
options to the master options.

Ideally, these 3 patches:

4b94b49 bitbake: toaster: Update default release to Morty

3332426 bitbake: toaster: Update poky fixture for Morty release

7656dea bitbake: toaster: Update oe-core fixture for Morty release


Would be reverted and we would make a different patch that adds morty as an
option.


Sorry :(

-Brian

an Intel employee



On Fri, Oct 14, 2016 at 8:27 AM, Michael Wood <michael.g.wood@intel.com>
wrote:

> From Brian:
>
> This changes the fixtures for toaster in Morty so that
> 1) We only allow the morty branch for new projects
> 2) we default to morty when making a new project.
>
> This release we do not support building older releases due to
> the Python 2.7 -> Python 3 change Morty represents.
>
> This patch set updates both the poky and oe-core fixtures.
>
> Note: this only applies to the Morty branch and should *not* be applied to
> master.
>
> -bavery
>
> Changes by me:
>  - Fix branch name in oe-core for bitbake
>  - Add "2.2" as part of the description
>
>
> brian avery (3):
>   toaster: Update oe-core fixture for Morty release
>   toaster: Update poky fixture for Morty release
>   toaster: Update default release to Morty
>
>  lib/toaster/orm/fixtures/oe-core.xml  | 16 ++++++++--------
>  lib/toaster/orm/fixtures/poky.xml     | 12 ++++++------
>  lib/toaster/orm/fixtures/settings.xml |  2 +-
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a114573aaf0dd1c053f170cb1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So,=C2=A0<div><br></div><div>This patch set lost the MORTY=
 part of the subject line in it&#39;s journey from the toaster mailing list=
 to the bitbake maling list.</div><div><br></div><div>This patch was suppos=
ed to be applied only to morty since it limits the available toaster projec=
t releases to morty. =C2=A0</div><div><br></div><div>Master should have the=
 choice of making a morty project or a master project and so should get a *=
different* patch that appends the morty release options to the master optio=
ns.</div><div><br></div><div>Ideally, these 3 patches:</div><div>







<p class=3D"gmail-p1"><span class=3D"gmail-s1">4b94b49</span><span class=3D=
"gmail-s2"> bitbake: toaster: Update default release to Morty =C2=A0</span>=
</p><p class=3D"gmail-p1"><span class=3D"gmail-s1">3332426</span><span clas=
s=3D"gmail-s2"> bitbake: toaster: Update poky fixture for Morty release</sp=
an></p>
<p class=3D"gmail-p1"><span class=3D"gmail-s1">7656dea</span><span class=3D=
"gmail-s2"> bitbake: toaster: Update oe-core fixture for Morty release</spa=
n></p><p class=3D"gmail-p1"><span class=3D"gmail-s2"><br></span></p><p clas=
s=3D"gmail-p1"><span class=3D"gmail-s2">Would be reverted and we would make=
 a different patch that adds morty as an option.</span></p><p class=3D"gmai=
l-p1"><span class=3D"gmail-s2"><br></span></p><p class=3D"gmail-p1"><span c=
lass=3D"gmail-s2">Sorry :(</span></p><p class=3D"gmail-p1"><span class=3D"g=
mail-s2">-Brian</span></p><p class=3D"gmail-p1"><span class=3D"gmail-s2">an=
 Intel employee</span></p><p class=3D"gmail-p1"><br></p></div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Oct 14, 2016 at =
8:27 AM, Michael Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:michael.g.woo=
d@intel.com" target=3D"_blank">michael.g.wood@intel.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">From Brian:<br>
<br>
This changes the fixtures for toaster in Morty so that<br>
1) We only allow the morty branch for new projects<br>
2) we default to morty when making a new project.<br>
<br>
This release we do not support building older releases due to<br>
the Python 2.7 -&gt; Python 3 change Morty represents.<br>
<br>
This patch set updates both the poky and oe-core fixtures.<br>
<br>
Note: this only applies to the Morty branch and should *not* be applied to<=
br>
master.<br>
<br>
-bavery<br>
<br>
Changes by me:<br>
=C2=A0- Fix branch name in oe-core for bitbake<br>
=C2=A0- Add &quot;2.2&quot; as part of the description<br>
<br>
<br>
brian avery (3):<br>
=C2=A0 toaster: Update oe-core fixture for Morty release<br>
=C2=A0 toaster: Update poky fixture for Morty release<br>
=C2=A0 toaster: Update default release to Morty<br>
<br>
=C2=A0lib/toaster/orm/fixtures/oe-<wbr>core.xml=C2=A0 | 16 ++++++++--------=
<br>
=C2=A0lib/toaster/orm/fixtures/poky.<wbr>xml=C2=A0 =C2=A0 =C2=A0| 12 ++++++=
------<br>
=C2=A0lib/toaster/orm/fixtures/<wbr>settings.xml |=C2=A0 2 +-<br>
=C2=A03 files changed, 15 insertions(+), 15 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.7.4<br>
<br>
--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div>

--001a114573aaf0dd1c053f170cb1--
