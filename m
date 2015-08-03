Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
	[209.85.223.182])
	by mail.openembedded.org (Postfix) with ESMTP id 6A0A273D13
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Aug 2015 19:22:07 +0000 (UTC)
Received: by ioii16 with SMTP id i16so154481945ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Aug 2015 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=cj/uT8d6TVu9Ub1J2t4bTDrh6VnDGkAR+vLkgHS/RzI=;
	b=iIgtrnjdoGFPMVGxNoSYc7klDQSgYsXYDdn5ToG/4w8EoexFy2ZOqO37ipumNxKEhe
	BBevwdo6BB3DmiB/tLdVkUkntSfGLk+TL5Me+QEA+P4tffS9l5xJaz0xrL84Tqe9qRh/
	sfQcZAENsA/FNXdn+DRc9RyFgzb09zP1Gpl1xTSiNAoLG5lExCOocZEfFkpFgD4fprkB
	dxH2WA8MUsD9hCkNvIaL9pkw3DU0GN2esZuKTUq6j0hhmo1Ep2yaXzrRcGx++iABBcmH
	Sh30TeU5oPn8HNQNFMDeXvM4GuW35krpE5KVKoN+/VcyWVjE5WUePsvVbmoaLlnVsK4D
	xYEA==
X-Received: by 10.107.15.210 with SMTP id 79mr21288556iop.192.1438629727040;
	Mon, 03 Aug 2015 12:22:07 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.199 with HTTP; Mon, 3 Aug 2015 12:21:47 -0700 (PDT)
In-Reply-To: <1438629643-28786-1-git-send-email-kergoth@gmail.com>
References: <1438629643-28786-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Mon, 3 Aug 2015 12:21:47 -0700
X-Google-Sender-Auth: qpKneZCxHm4zfDR32KkfEvIiYQs
Message-ID: <CABcZANnRPgVmdnE8Bn6iPn2Vm7KbyExw+ejY1aqkJ+ZZj5hGQw@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.build: delete tasks thoroughly
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
X-List-Received-Date: Mon, 03 Aug 2015 19:22:09 -0000
Content-Type: multipart/alternative; boundary=001a113fe63ad7f867051c6d152a

--001a113fe63ad7f867051c6d152a
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 3, 2015 at 12:20 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> We want addtask to be able to bring back a deleted task, but we don't want
> its
> previous dependencies to come back with it, so rather than marking a task
> as
> deleted and then skipping tasks marked as such, actually delete the task
> and
> its dependency information in deltask.
>
> While we're in that part of the code, also fix a couple 'not foo in bar'
> instances to 'foo not in bar', which is preferred in python.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

This supercedes `[PATCH] bb.build: let addtask undo a deltask`.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113fe63ad7f867051c6d152a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Aug 3, 2015 at 12:20 PM, Christopher Larson <span =
dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kerg=
oth@gmail.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">From: Christopher Larson &=
lt;<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&g=
t;<br>
<br>
We want addtask to be able to bring back a deleted task, but we don&#39;t w=
ant its<br>
previous dependencies to come back with it, so rather than marking a task a=
s<br>
deleted and then skipping tasks marked as such, actually delete the task an=
d<br>
its dependency information in deltask.<br>
<br>
While we&#39;re in that part of the code, also fix a couple &#39;not foo in=
 bar&#39;<br>
instances to &#39;foo not in bar&#39;, which is preferred in python.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;<br></blockquote><div><br></div><div>T=
his supercedes `[PATCH] bb.build: let addtask undo a deltask`.</div></div>-=
- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br=
>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br=
>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div></div=
>
</div></div>

--001a113fe63ad7f867051c6d152a--
