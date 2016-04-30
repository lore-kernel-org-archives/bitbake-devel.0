Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id A4D8860123
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 20:11:22 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id k129so19487231iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=9GQyHb6jcYs8hmQOTT3oc5+16jcp0UpkZYEbZZcwEaI=;
	b=I1URPogKrHZWLKW231iwff6ee7nlegcv/+8jLe+46K/QOZyE/Wd26AljQDnUm2eMlC
	hdoy5JiGG7jn2SYsfz1eOE6kyP8BHBcq9awscV7jOxVfhZY3kSxM3X4kt9OByZhY1RH5
	+1kAzu1NJ6/PybDghQAWjbf3VKVXsOkxoQvWhzpc9E0j9fXXYe6diA8wpzh4WOS1TE+M
	AYYP0Kxe1ecy7hqfaPfCUv4K2rp7ITHmUrtjjBfiTxknJ83xFCtnTUmPohNuSLXpECkv
	PtEuU3WyyxYx13kbPcflyCosaMFLjqPUvZKdjwQm5fhrxa3KfSp1nvWJjqV0XBewUf5u
	1Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=9GQyHb6jcYs8hmQOTT3oc5+16jcp0UpkZYEbZZcwEaI=;
	b=HBQ15OzreWxQDrQSuPgZZCt+Ys1XUaw66gJpeUxfPwVrvMo1yCemyqA03NyOIlqWm0
	fNZjOMhdn5IHPDUXTQ0MkW7S7qdJQ7wrszXjbuV/y27HpJavi4IMF4oxz1c7yWu3FfZj
	9tsvRa8RMw3tro9uoWuLciiRbf47nxeTph1l9M7XBsU6TGqhJe/EkJT/G5UK1QNQrbrU
	SDbXvKX7PYX+JrhYRM0YnziRw2xXNMMLc3zFby1UK/AvHUJ0Yqd4NENKc+VYCza2TFVt
	65evtLfIJCTNKSyVnx0iY8JsmUFGk+jdEXh8SniGRcpDST0xFbS94no3sUHmpQKceOvZ
	bqUg==
X-Gm-Message-State: AOPr4FU+KW1br6pyUKuVBT3EtbZ15but8v3t/NH3k/OcELITAl1T9il3pW3HNjTjRHSw0Tj1cGcDq3hb6nx6LA==
X-Received: by 10.107.2.70 with SMTP id 67mr33156728ioc.70.1462047082965; Sat,
	30 Apr 2016 13:11:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.70 with HTTP; Sat, 30 Apr 2016 13:11:03 -0700 (PDT)
In-Reply-To: <CABcZAN=DWHSWgOi-HBcShqH9t7tWQ603hPXJgGLFd8RZzwinvA@mail.gmail.com>
References: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
	<1462045969-14538-3-git-send-email-kergoth@gmail.com>
	<CABcZAN=DWHSWgOi-HBcShqH9t7tWQ603hPXJgGLFd8RZzwinvA@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Sat, 30 Apr 2016 13:11:03 -0700
Message-ID: <CABcZANnaCCc=z0Bi6gr1gTFg+B=Uze+fcguqxTOFby9TcGd+1g@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [master][PATCH] bb.cooker: only emit a var as python if 'func' is set
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
X-List-Received-Date: Sat, 30 Apr 2016 20:11:22 -0000
Content-Type: multipart/alternative; boundary=001a113968140673c10531b95d7e

--001a113968140673c10531b95d7e
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 1:06 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> On Sat, Apr 30, 2016 at 12:52 PM, Christopher Larson <kergoth@gmail.com>
> wrote:
>
>> From: Christopher Larson <chris_larson@mentor.com>
>>
>> This avoids a common issue where PACKAGECONFIG is emitted as a function in
>> bitbake -e when the 'python' flag exists. It isn't a python function
>> unless
>> both 'func' and 'python' are set. This aligns with the behavior of
>> emit_func_python.
>>
>> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>
>
> Don't apply this yet, v2 forthcoming.
>

Superceded by '[master][PATCH] bb.{cooker,data}: only emit a var as python
if 'func'
 is set'.

-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113968140673c10531b95d7e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Apr 30, 2016 at 1:06 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><span class=3D"">On Sat, Apr 30, 201=
6 at 12:52 PM, Christopher Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:k=
ergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&gt;</span> wrote:=
<br></span><div class=3D"gmail_quote"><span class=3D""><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Fro=
m: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com" target=
=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
<br>
This avoids a common issue where PACKAGECONFIG is emitted as a function in<=
br>
bitbake -e when the &#39;python&#39; flag exists. It isn&#39;t a python fun=
ction unless<br>
both &#39;func&#39; and &#39;python&#39; are set. This aligns with the beha=
vior of<br>
emit_func_python.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;</blockquote><div><b=
r></div></span><div>Don&#39;t apply this yet, v2 forthcoming.</div></div></=
blockquote></div><br>Superceded by &#39;[master][PATCH] bb.{cooker,data}: o=
nly emit a var as python if &#39;func&#39;<div class=3D"gmail_extra">=C2=A0=
is set&#39;.<br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_sig=
nature"><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>=
Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior=
 Software Engineer, Mentor Graphics</div></div>
</div></div>
</div>

--001a113968140673c10531b95d7e--
