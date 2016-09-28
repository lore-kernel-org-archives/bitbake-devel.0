Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 6B80960069
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 19:13:14 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id x203so209096oia.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=upAxocucm7ktDiVrsBRpAdCBaBJ+MrHNzga3bNqEEVs=;
	b=q8YtYA/YEHReyNul0AMBdHhpvUaSI2WdmQnqlTf+OAthM8j4HLGeea7v587ftu/UnL
	kdTrdtcmfc0RsRuWPXUg40TQe9PU5QlKqsPfclxtRJbQoLomV4iccqrjut/9xahKY7R/
	6pjPm1+hiWEgqDywIk/oW3VfpEhp7uq7WzAM93OJU9/Ga8rj0Rdnur6TYOpdpNdzmOrh
	yEdcyZCL5MQK5VqfZsRJIp35aHUilnuFDEMCFRJyn+a8aM2VTQwB+L85NaNAp5n/EWcW
	JyvCQaX313uhGHRbGJtH0XhfUfLZZwrRR8GDIWbG92c9w74UVn0oZrOMLiPKuBjlSBo3
	htJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=upAxocucm7ktDiVrsBRpAdCBaBJ+MrHNzga3bNqEEVs=;
	b=OOVbH1NEJ9upvd13wASqPeoI2PTBVXRmZDKhxSzK7FKo1SqTowr81rr8FQwYTNGa3x
	nKpzxl28sGLptbFYSCcAXIyG/5RJW0tfBr9MP7wPWnzUMtO86D8mCmxTrwU7b+ct8a38
	p9QdmWNafOA9JNJQi+qpC2prlwSzm2xocUYTKJM+kh0lQCaQXWMDCaw6G8Klo44jbmRT
	fOOlzSghkFq+hJsXLj88FfVzxlJQWZQJeReq9Yymycm7aruHBAZfK6AkpiU9O2x6aVH2
	6h1Les03bCHTlwDcSUF23rmYk9Lqemxboitetv8PDwI7jfoxmS5iZ6Xkgsadk339J6lH
	iBOA==
X-Gm-Message-State: AA6/9RnLLlr8PkcNsZ+FuqIXhD7K9RvHzOAsiQ+lgZocgMA+5LUA5wAZN/09vOfHKBbQhOHJAM3UPjj3ou13cQ==
X-Received: by 10.157.27.179 with SMTP id z48mr3712533otd.82.1475089995485;
	Wed, 28 Sep 2016 12:13:15 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Wed, 28 Sep 2016 12:12:55 -0700 (PDT)
In-Reply-To: <49f3c7f6-b330-b11d-e5c5-7a96b2e2a367@mvista.com>
References: <1475075217-17547-1-git-send-email-akuster808@gmail.com>
	<1475075668.30475.72.camel@linuxfoundation.org>
	<49f3c7f6-b330-b11d-e5c5-7a96b2e2a367@mvista.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 28 Sep 2016 12:12:55 -0700
X-Google-Sender-Auth: 2kOTY9TqI9f4TSWjEjHX0MdP8QY
Message-ID: <CABcZANnYrgzeU22zQeHzsSePGF2-diaVUY_qjNe9vk3POCYyQA@mail.gmail.com>
To: akuster <akuster@mvista.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Armin Kuster <akuster808@gmail.com>
Subject: Re: [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Wed, 28 Sep 2016 19:13:18 -0000
Content-Type: multipart/alternative; boundary=001a11403d9831581b053d9627da

--001a11403d9831581b053d9627da
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2016 at 8:25 AM, akuster <akuster@mvista.com> wrote:

> On 09/28/2016 08:14 AM, Richard Purdie wrote:
>
>> On Wed, 2016-09-28 at 08:06 -0700, Armin Kuster wrote:
>>
>>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>>>
>>> "hash() is randomised by default each time you start a new instance
>>> of
>>> recent
>>> versions (Python3.3+) to prevent dictionary insertion DOS attacks"
>>>
>>> which means we need to use hashlib.md5 to get consistent values for
>>> the codeparser cache under python 3. Prior to this, the codeparser
>>> cache was effectively useless under python3 as shown by performance
>>> regressions.
>>>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> (cherry picked from commit 12d43cf45ba48e3587392f15315d92a1a53482ef)
>>>
>>> We kept running into an issue where shell scripts were not
>>> getting generated on 32bit hosts. It seemed to be caused by this
>>> code.
>>>
>> I'm puzzled. This patch is in master. I'm therefore assuming you're
>> suggesting this for 1.30 but it doesn't say that anywhere.
>>
>
> We made a similar change in our bitbake sources for 1.28 which needed to
> be submitted per the Yocto compatible requirements.   I could have sent
> that one but then you might have said "Hey, this looks like the one in
> Master, why are you not using that one?".   I personally like to referenc=
e
> upstream official fixes than hand crafted ones that achieve the same
> result. I can send you the one we did if you want.


I think the problem is you didn=E2=80=99t actually say what version/branch =
you
wanted it applied to, not which commit the patch references..
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11403d9831581b053d9627da
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Sep 28, 2016 at 8:25 AM, akuster <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:akuster@mvista.com" target=3D"_blank">akuster@mvista.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 09/28/2016 =
08:14 AM, Richard Purdie wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Wed, 2016-09-28 at 08:06 -0700, Armin Kuster wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.o=
rg" target=3D"_blank">richard.purdie@linuxfoundatio<wbr>n.org</a>&gt;<br>
<br>
&quot;hash() is randomised by default each time you start a new instance<br=
>
of<br>
recent<br>
versions (Python3.3+) to prevent dictionary insertion DOS attacks&quot;<br>
<br>
which means we need to use hashlib.md5 to get consistent values for<br>
the codeparser cache under python 3. Prior to this, the codeparser<br>
cache was effectively useless under python3 as shown by performance<br>
regressions.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundatio<wbr>n.org</a>&=
gt;<br>
(cherry picked from commit 12d43cf45ba48e3587392f15315d92<wbr>a1a53482ef)<b=
r>
<br>
We kept running into an issue where shell scripts were not<br>
getting generated on 32bit hosts. It seemed to be caused by this<br>
code.<br>
</blockquote>
I&#39;m puzzled. This patch is in master. I&#39;m therefore assuming you&#3=
9;re<br>
suggesting this for 1.30 but it doesn&#39;t say that anywhere.<br>
</blockquote>
<br></span>
We made a similar change in our bitbake sources for 1.28 which needed to be=
 submitted per the Yocto compatible requirements.=C2=A0 =C2=A0I could have =
sent that one but then you might have said &quot;Hey, this looks like the o=
ne in Master, why are you not using that one?&quot;.=C2=A0 =C2=A0I personal=
ly like to reference upstream official fixes than hand crafted ones that ac=
hieve the same result. I can send you the one we did if you want.</blockquo=
te></div><br>I think the problem is you didn=E2=80=99t actually say what ve=
rsion/branch you wanted it applied to, not which commit the patch reference=
s..<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake,=
 OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer=
, Mentor Graphics</div>
</div></div>

--001a11403d9831581b053d9627da--
