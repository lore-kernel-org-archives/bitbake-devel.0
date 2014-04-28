Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
	[209.85.217.181])
	by mail.openembedded.org (Postfix) with ESMTP id 1AD8F65E7F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 15:32:00 +0000 (UTC)
Received: by mail-lb0-f181.google.com with SMTP id z11so3840382lbi.26
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=BrGItcPe6a9waDkXcLOjuYF0vXcLcit6lDesf6AgIVs=;
	b=jIu+8tYbWQu5xf1motvvrlNn+R7SyW2RB7amhaLw/p6CjenI8TZa39akHeW6d9VPg6
	Gwi8vqnRmOAz246UYbWx3EHhykXIQ8okKQdtU8Whj+3xxLM2qHsaW3NMwqX5XkOp1rF/
	3JTKsQwDdZKaSRQP87yarkq5W2H/vEPgdFh0CWAEPgX6Ou39m70+yJ3mq4Dku9X6TH3G
	4Dvi7phI8R1108pVs9XZd/7kWUqDEvMN+OL5yLrZpfAJ6qbceNYSAb4g0PQDIryjhYoL
	c6lzN/d7adhTMd9ogtrpU7VwOwnocwhYjvupP1skZlmicpTKwg+KgXckMj8ffcLqzR7O
	Mung==
X-Received: by 10.152.43.168 with SMTP id x8mr552322lal.60.1398699120916; Mon,
	28 Apr 2014 08:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.35.194 with HTTP; Mon, 28 Apr 2014 08:31:40 -0700 (PDT)
In-Reply-To: <1398698854-15713-1-git-send-email-kergoth@gmail.com>
References: <1398698854-15713-1-git-send-email-kergoth@gmail.com>
From: Chris Larson <kergoth@gmail.com>
Date: Mon, 28 Apr 2014 08:31:40 -0700
Message-ID: <CABcZANm93gs9sC0s=xLyRxvH4DBP15WPmwGbMdseFk_FSOSjgg@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] codeparser: don't interact with the cache for subshells
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
X-List-Received-Date: Mon, 28 Apr 2014 15:32:01 -0000
Content-Type: multipart/alternative; boundary=001a11c22a5e3ffe4704f81c0457

--001a11c22a5e3ffe4704f81c0457
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 28, 2014 at 8:27 AM, Christopher Larson <kergoth@gmail.com>wrote:

> Doing so was causing leakage between the execs of the main value and that
> of
> the subshell value, and was causing the cached subshell value to be used
> for
> the overall variable. At the least this could cause execs contamination
> between two variables that while differing, run the same subshell. Beyond
> that, it's possible we could have been using an incomplete cached value of
> a subshell for that of the main value.
>
> Before this, bb_codeparser.dat would change between parses with differing
> bbfile parse order. After, it does not change.
>
> The codeparser cache version is bumped, to ensure we don't use potentially
> incorrect cached values from previous runs.
>
> This should hopefully resolve the difficult-to-reproduce issues we've seen
> at
> Mentor Graphics where bitbake emits a script to run a task and misses
> dependent functions, resulting in 'command not found' failures. This issue
> has
> also been mentioned on the oe devel list, where someone hit a case where
> oe_runmake was missing from a do_install task (IIRC). Adding debug
> information
> showed that bitbake's information about the variable dependencies for this
> task is inaccurate in the failure cases.
>

We're trying to confirm the fix, but given it's not really reproducible,
and only seemed
to be hit during automated builds, it'll be difficult to say with certainty
that the problem
is resolved. That said, I think it's clear from reading the code that this
is the correct
thing, and the previous beahvior was just an unintentional oversight when
the cache
usage was added.

Thanks!
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c22a5e3ffe4704f81c0457
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Apr 28, 2014 at 8:27 AM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1gm" class=3D"a3s" style=3D"over=
flow:hidden">Doing so was causing leakage between the execs of the main val=
ue and that of<br>


the subshell value, and was causing the cached subshell value to be used fo=
r<br>
the overall variable. At the least this could cause execs contamination<br>
between two variables that while differing, run the same subshell. Beyond<b=
r>
that, it&#39;s possible we could have been using an incomplete cached value=
 of<br>
a subshell for that of the main value.<br>
<br>
Before this, bb_codeparser.dat would change between parses with differing<b=
r>
bbfile parse order. After, it does not change.<br>
<br>
The codeparser cache version is bumped, to ensure we don&#39;t use potentia=
lly<br>
incorrect cached values from previous runs.<br>
<br>
This should hopefully resolve the difficult-to-reproduce issues we&#39;ve s=
een at<br>
Mentor Graphics where bitbake emits a script to run a task and misses<br>
dependent functions, resulting in &#39;command not found&#39; failures. Thi=
s issue has<br>
also been mentioned on the oe devel list, where someone hit a case where<br=
>
oe_runmake was missing from a do_install task (IIRC). Adding debug informat=
ion<br>
showed that bitbake&#39;s information about the variable dependencies for t=
his<br>
task is inaccurate in the failure cases.</div></blockquote></div><br>We&#39=
;re trying to confirm the fix, but given it&#39;s not really reproducible, =
and only seemed</div><div class=3D"gmail_extra">to be hit during automated =
builds, it&#39;ll be difficult to say with certainty that the problem</div>

<div class=3D"gmail_extra">is resolved. That said, I think it&#39;s clear f=
rom reading the code that this is the correct</div><div class=3D"gmail_extr=
a">thing, and the previous beahvior was just an unintentional oversight whe=
n the cache</div>

<div class=3D"gmail_extra">usage was added.</div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Thanks!<br>-- <br>Christopher Larson<=
br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZauru=
s<br>

Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a11c22a5e3ffe4704f81c0457--
