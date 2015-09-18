Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id 00F8B7669F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Sep 2015 17:34:34 +0000 (UTC)
Received: by ioiz6 with SMTP id z6so63637895ioi.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Sep 2015 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=yj+vCzX6momfA3XOYmmMDdxgyycXTl/Ifl5Bs24HSFI=;
	b=zgTpLH77ogkyVv5lK/R/MsqyeSzHOOIOhmvoCtMtA25r4fhziyJWxCqZJwERNhepRq
	chLzrHq/4sjnaJ7FGBXlyKA2XX2UtcSnEdLm7ut+w5epVWO9bEjy44iAfkava7iMrbS1
	5gtr6J6p5iDWsHu3AfBoG68bNg7JMrF38+5wxvmHvVB7KOk4ZnTdwTI30ygAK5sz49CE
	9kUYFiolshLvkyjuzfJZtFhA/gGQDr3ab87aLI5yviEB4VQFD3lH6Fvw5SbJSoEKnLrc
	SfngxqKRggB/FkvSS1r5t7lif3ZLVhOjMBuITaj7qOJ+dHGo3LyGji06t9L0XIW9Oi0N
	6L2g==
X-Received: by 10.107.128.41 with SMTP id b41mr14940561iod.74.1442597674770;
	Fri, 18 Sep 2015 10:34:34 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Fri, 18 Sep 2015 10:34:15 -0700 (PDT)
In-Reply-To: <1442594122-20623-1-git-send-email-romain.perier@gmail.com>
References: <1442594122-20623-1-git-send-email-romain.perier@gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 18 Sep 2015 10:34:15 -0700
X-Google-Sender-Auth: KR7wiOtw9yj9QjtCKgh5jWvGTLE
Message-ID: <CABcZANnxfH8BcdeeRryba56sybpXxeUKQDKBz_ZjFZ5jiU6=+A@mail.gmail.com>
To: Romain Perier <romain.perier@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Import errno module
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
X-List-Received-Date: Fri, 18 Sep 2015 17:34:36 -0000
Content-Type: multipart/alternative; boundary=001a113f8bf0f568b2052008f1c7

--001a113f8bf0f568b2052008f1c7
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 18, 2015 at 9:35 AM, Romain Perier <romain.perier@gmail.com>
wrote:

> Currently this module is dereferencing errno.ENOENT but the python module
> "errno"
> is not imported, which causes a crash when fetching from a git repository.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>

Eep, that would be my fault, sorry about that.

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113f8bf0f568b2052008f1c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 18, 2015 at 9:35 AM, Romain Perier <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:romain.perier@gmail.com" target=3D"_blank">romain.perier@gmail.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1lm=
" class=3D"a3s" style=3D"overflow:hidden">Currently this module is derefere=
ncing errno.ENOENT but the python module &quot;errno&quot;<br>
is not imported, which causes a crash when fetching from a git repository.<=
br>
<br>
Signed-off-by: Romain Perier &lt;<a href=3D"mailto:romain.perier@gmail.com"=
>romain.perier@gmail.com</a>&gt;</div></blockquote></div><br>Eep, that woul=
d be my fault, sorry about that.</div><div class=3D"gmail_extra"><br></div>=
<div class=3D"gmail_extra">Acked-by: Christopher Larson &lt;<a href=3D"mail=
to:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;</div><div class=
=3D"gmail_extra">-- <br><div class=3D"gmail_signature">Christopher Larson<b=
r>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus=
<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113f8bf0f568b2052008f1c7--
