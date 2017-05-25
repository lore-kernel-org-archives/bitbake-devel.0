Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
	[209.85.218.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6A9D778123
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 15:42:57 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id w10so285418159oif.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=GRF4LF/qf8dRqM8rg/JSQt6D7ZU0UWY7TrLy1RwLylg=;
	b=RYKMUt+k5b4Qorn7L+r3ZK3mBw7TGJQDXEisZ27q9/+jtVgZVROSOyesOF3Ymff0Wq
	YBZ8M+HAAXxnovvp/f5FKpZyh4RDO2HzR3fZQiJJ10RlM4FSk5i2RmAB3U3T91kbz1qM
	Z4OFi6AkdkX8o62plfQiCXlFJQLYJHkYE4WBNmVAA25C186VWe0zdJ0iHz0uE6I2R8iP
	tLg4WSFIA9F5xpQcKFW+eX1KBnq2X6CAV3Avr8OcieL6eIbydFIU9fN0Kgx/zDGbiG6O
	4VzBsLQ6jkQ695szdLg4ZoERquaewrV5l/bVlu6yB6k6hQjvQ8oN9CMqXkS/piu9mXnj
	8GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=GRF4LF/qf8dRqM8rg/JSQt6D7ZU0UWY7TrLy1RwLylg=;
	b=Xyc7be5NK2veFYmIJTTNpJ/NX/i+LXi5PEmopI7chNYhCG/JV/P4a21LybOt6kN6ou
	zs5oGmc6gsxLV/gRLKfUq+mktULsSiLdkf7iRuxYGY3ASQi+LQkJ/7LyoToSHrR6P9PT
	wfKZc7ZgMf6WU4nc+x9aPq7ve0DYO3DbvLndxYL2LCwbgF7EPq+kPDCxaBqca8vAeHbW
	3iUKPjaZjGJdFOF5tuhLwuvBIi/ECQThpoJUA0dUSbCNm2rx+Hbkxkytfz2Xed3PcXCj
	IZ/3hUi4KWbqfPGlUz1JDiiioxqoG+NtEq+GIsBcQTUj+LqbqqX7rI0+zZpnoBgMe6XF
	BrSQ==
X-Gm-Message-State: AODbwcDROmS7ky6Jk/Pcjxb2qpFK4jpKemtIexgjgDxfPgPYTrtc+rqX
	U8OnXLQPXkzblNEzNzh5fxNrU1iGATuw
X-Received: by 10.157.31.71 with SMTP id x7mr8465180otx.217.1495726978514;
	Thu, 25 May 2017 08:42:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.226 with HTTP; Thu, 25 May 2017 08:42:38 -0700 (PDT)
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 25 May 2017 08:42:38 -0700
Message-ID: <CABcZANnuX6SLn21vO8xUz65U1oyzJ2_kgGEW6cE359R-NY+M9Q@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/8] Add support for shallow mirror tarballs
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
X-List-Received-Date: Thu, 25 May 2017 15:42:58 -0000
Content-Type: multipart/alternative; boundary="001a113710bc3c703805505b139d"

--001a113710bc3c703805505b139d
Content-Type: text/plain; charset="UTF-8"

On Fri, May 12, 2017 at 2:46 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> The latest incarnation of the support for git shallow mirror tarballs.
> Updated
> with ud.mirrortarball removed, fixes for gitsm and gitannex, more granular
> commits to ease review, and unit tests added. Please let me know what you
> think. Thanks.
>

Any feedback on this, or are folks still fighting fires related to the
release?
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a113710bc3c703805505b139d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, May 12, 2017 at 2:46 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":177" class=
=3D"a3s aXjCH m15bfea0c1905b56f">The latest incarnation of the support for =
git shallow mirror tarballs. Updated<br>
with ud.mirrortarball removed, fixes for gitsm and gitannex, more granular<=
br>
commits to ease review, and unit tests added. Please let me know what you<b=
r>
think. Thanks.<br></div></blockquote></div><br>Any feedback on this, or are=
 folks still fighting fires related to the release?<br>-- <br><div class=3D=
"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>=
<div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder =
- BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Gra=
phics</div></div></div></div>
</div></div>

--001a113710bc3c703805505b139d--
