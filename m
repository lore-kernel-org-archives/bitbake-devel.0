Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
	[209.85.218.49])
	by mail.openembedded.org (Postfix) with ESMTP id 0891778139
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 16:43:37 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id w10so287655671oif.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=56Dq+AaGGls1xvIaT83ahEE+9HM8E1XElYFHD9DYqmI=;
	b=Y6tAAjckgTKrQ/b9sGYsHvS8FMTQcBJoEoXUwAOUnOrfZcy3B6j/KOzMzDStB3/65F
	jOGqLwIztKukJ8hHOsdulWBtN7PhYsQzlcQFgP8uj7mCk1Gp3ODVjmrHQgbjwwJyiIWB
	Q6RQTY5lSaoXcOPOvIvpKymf/zMbxE0qXruQ2JTmrDoOM45Sy+jeLWAuq4VBZr/DAfaT
	Y6nCAaK7erLXppWSEZOdShT5nicAiQcBCIgtz1mmtBmLZ0Y8XSZvQyZG5ICMiynWH3MF
	oY1RuOKGlBqs2jLlL8qGhstBUqynxKlgA6GpmhcoiO7RRbCG0gM/RE6m7/ofijDzLoKg
	B2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=56Dq+AaGGls1xvIaT83ahEE+9HM8E1XElYFHD9DYqmI=;
	b=qLyr/imWQcHMHwD8N2m4oL82I+48xoSNABU6UkmXtNXzfOmUXlCaaGRH3E/FVuINr9
	Eh9HyAjl0drrxriYB5xlLBzavgKY9vh7yOOTmsjt6SlZ72nvRGU4uDFzeXhdGYo7fm/H
	kjbbCT17IY+mOUiQZlmNEU1udI7U/9mjknZvuBv7MoBOxrcNUietgNM/PLrXJG6Fieo9
	dmQz3cqNXqRIBCJnbsaYPCN7gXme33hh1nhIVTclLLsChAOFey25H/rv4tTOARM21INS
	14D4qbbTy2Vs/iKeMeuJNhxk4GFZaK1EhLtcCn3WFYFe4HXrtAcDg+rfueZ1nnfxmH4j
	ec2w==
X-Gm-Message-State: AODbwcBU2znJtDC0kEvjku3hE84GvaSXYaT/U3dll/i72yICD5AGiSiU
	/7QPaAVskqWOrdhKOq3RPxIfPRDaiCWq
X-Received: by 10.157.41.72 with SMTP id d66mr7117751otb.124.1495730618808;
	Thu, 25 May 2017 09:43:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.226 with HTTP; Thu, 25 May 2017 09:43:18 -0700 (PDT)
In-Reply-To: <1495729973.25229.33.camel@linuxfoundation.org>
References: <cover.1494623828.git.chris_larson@mentor.com>
	<CABcZANnuX6SLn21vO8xUz65U1oyzJ2_kgGEW6cE359R-NY+M9Q@mail.gmail.com>
	<1495729973.25229.33.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 25 May 2017 09:43:18 -0700
Message-ID: <CABcZAN=GxuXCVuz2F0nESeXYTrV3UfLWqpRr=cRekj2g211+PA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
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
X-List-Received-Date: Thu, 25 May 2017 16:43:38 -0000
Content-Type: multipart/alternative; boundary="94eb2c04326c36c39a05505becd8"

--94eb2c04326c36c39a05505becd8
Content-Type: text/plain; charset="UTF-8"

On Thu, May 25, 2017 at 9:32 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2017-05-25 at 08:42 -0700, Christopher Larson wrote:
> >
> > On Fri, May 12, 2017 at 2:46 PM, Christopher Larson <kergoth@gmail.co
> > m> wrote:
> > > The latest incarnation of the support for git shallow mirror
> > > tarballs. Updated
> > > with ud.mirrortarball removed, fixes for gitsm and gitannex, more
> > > granular
> > > commits to ease review, and unit tests added. Please let me know
> > > what you
> > > think. Thanks.
> > >
> > Any feedback on this, or are folks still fighting fires related to
> > the release?
>
> I'm travelling, lets aim to discuss this with a view to merging next
> week [remind me if I forget please].


Understood, thanks!
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--94eb2c04326c36c39a05505becd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, May 25, 2017 at 9:32 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span class=3D"">On Thu, 2017-05-25 at 08:42 -0700, Christopher Lar=
son wrote:<br>
&gt;<br>
&gt; On Fri, May 12, 2017 at 2:46 PM, Christopher Larson &lt;<a href=3D"mai=
lto:kergoth@gmail.co">kergoth@gmail.co</a><br>
&gt; m&gt; wrote:<br>
&gt; &gt; The latest incarnation of the support for git shallow mirror<br>
&gt; &gt; tarballs. Updated<br>
&gt; &gt; with ud.mirrortarball removed, fixes for gitsm and gitannex, more=
<br>
&gt; &gt; granular<br>
&gt; &gt; commits to ease review, and unit tests added. Please let me know<=
br>
&gt; &gt; what you<br>
&gt; &gt; think. Thanks.<br>
&gt; &gt;<br>
&gt; Any feedback on this, or are folks still fighting fires related to<br>
&gt; the release?<br>
<br>
</span>I&#39;m travelling, lets aim to discuss this with a view to merging =
next<br>
week [remind me if I forget please].</blockquote></div><br>Understood, than=
ks!<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth a=
t gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior So=
ftware Engineer, Mentor Graphics</div></div></div></div>
</div></div>

--94eb2c04326c36c39a05505becd8--
