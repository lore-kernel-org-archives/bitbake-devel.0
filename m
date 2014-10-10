Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
	[209.85.215.41])
	by mail.openembedded.org (Postfix) with ESMTP id 6D80470703
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Oct 2014 17:12:49 +0000 (UTC)
Received: by mail-la0-f41.google.com with SMTP id pn19so3683079lab.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Oct 2014 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=TbFHk4QTTHcXyC2RtYSLM2FzCmmW+pXjMYBIZnoS8W0=;
	b=SrKSbFVLdgb7HqmbchEnD3LTxGQflic+fCSGrljPXA7v5/DPdMjeBT5solZuEmFnM8
	Eg6kgvxOXtqrZ/OSMYvb+x33EvfEAXopAYN9g8YyGdjAwi3oEaPdqZuSKSUs9VHBMOWQ
	cRuPy3GLH8XWjV4DAJIRZPJC/uheM8/pV6fbwdpTDpZP1WKqUjP+01qp3uVSDaqL4zPn
	KFiULIWE+eOVYEmfdgFMi+0eRNvLctb+SRMYqPJH/1CO/d2imXu11KI89Qp+r4tgD5qY
	BpwwTOPOMW96zxYpjpE/Y2ncJvELOihrjR7p8YHbpCMLBVksPX6rtj6tHL4z5nlBdOcj
	yG5g==
X-Received: by 10.152.203.225 with SMTP id kt1mr6227436lac.68.1412961169488;
	Fri, 10 Oct 2014 10:12:49 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.97.200 with HTTP; Fri, 10 Oct 2014 10:12:29 -0700 (PDT)
In-Reply-To: <1412960522-6609-1-git-send-email-alejandro.hernandez@linux.intel.com>
References: <1412960522-6609-1-git-send-email-alejandro.hernandez@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 10 Oct 2014 10:12:29 -0700
X-Google-Sender-Auth: IYtZ-C2uTTWb8bzeLY1XTfK---Q
Message-ID: <CABcZANmKuGytcHOKXcQQLHYUWxFd0sEYPZiXhN6_9TuEy00OaQ@mail.gmail.com>
To: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v3] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Fri, 10 Oct 2014 17:12:54 -0000
Content-Type: multipart/alternative; boundary=001a113458c496c6f8050514a857

--001a113458c496c6f8050514a857
Content-Type: text/plain; charset=UTF-8

On Fri, Oct 10, 2014 at 10:02 AM, Alejandro Hernandez <
alejandro.hernandez@linux.intel.com> wrote:

> Forcing strict to be a string, to avoid problems when performing
> comparisons
>
> [YOCTO #6762]
>
> Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
>

This commit message doesn't reflect what this commit does. It's fixing the
call to getVar, not changing whether strict is a string or not.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113458c496c6f8050514a857
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Oct 10, 2014 at 10:02 AM, Alejandro Hernandez <span dir=3D"ltr">&lt=
;<a href=3D"mailto:alejandro.hernandez@linux.intel.com" target=3D"_blank">a=
lejandro.hernandez@linux.intel.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div id=3D":12t" class=3D"a3s" style=3D"overflow:hidden">Fo=
rcing strict to be a string, to avoid problems when performing comparisons<=
br>
<br>
[YOCTO #6762]<br>
<br>
Signed-off-by: Alejandro Hernandez &lt;<a href=3D"mailto:alejandro.hernande=
z@linux.intel.com">alejandro.hernandez@linux.intel.com</a>&gt;</div></block=
quote></div><br>This commit message doesn&#39;t reflect what this commit do=
es. It&#39;s fixing the call to getVar, not changing whether strict is a st=
ring or not.<br>-- <br>Christopher Larson<br>clarson at kergoth dot com<br>=
Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior=
 Software Engineer, Mentor Graphics
</div></div>

--001a113458c496c6f8050514a857--
