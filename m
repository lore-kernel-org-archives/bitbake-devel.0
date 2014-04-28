Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
	[209.85.217.173])
	by mail.openembedded.org (Postfix) with ESMTP id 8657B65EAA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 15:38:12 +0000 (UTC)
Received: by mail-lb0-f173.google.com with SMTP id l4so5194013lbv.32
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=cmpeOlr2Re9mwJSpRPgHbomHZTzh/HagoCCVVDp+SW4=;
	b=NgaSitK93gjGG3UIIwlF6efFU1KlC6aZGUf1qpwkrJpi8jShxgxAHDUPKlnTASp37u
	9+BJoyyC9dzpDh6VLGdplY7Qzd3/xlta1l7TBJ1JWEnuMLx/xUGjkSp1+w3qFfLd1rcV
	EoK5nxgnqGKCS3DkadM5U3MlhamSiYz0HBxd15C9FZ/BKH3x1ZHN4m0SXgB+zuNn6YMA
	OdFc1NN/h8BsMdjElFnoahd+LE9xUWl/QcJs5ZO24vNFwBKP7p71l5CkbXTX1m6HEpS7
	qiHT9vdxmnCjBL/G0VWHtbivGwmihkAxCbLSa7IOAGFONLVfoo4/3W2kW2TFTDKJKRuh
	72Fw==
X-Received: by 10.152.116.43 with SMTP id jt11mr1887122lab.41.1398699493540;
	Mon, 28 Apr 2014 08:38:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.35.194 with HTTP; Mon, 28 Apr 2014 08:37:53 -0700 (PDT)
In-Reply-To: <CABcZANkmTwU3aSC0UME-W6DE8CN=vkHyrr6RuwP8jna45PnSeA@mail.gmail.com>
References: <1398698854-15713-1-git-send-email-kergoth@gmail.com>
	<CABcZANm93gs9sC0s=xLyRxvH4DBP15WPmwGbMdseFk_FSOSjgg@mail.gmail.com>
	<CABcZANkmTwU3aSC0UME-W6DE8CN=vkHyrr6RuwP8jna45PnSeA@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 28 Apr 2014 08:37:53 -0700
Message-ID: <CABcZANnkDb1=8=FTUSkq39BgEqbnEUNBXQ2NNeCMQfHwtAbV7A@mail.gmail.com>
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
X-List-Received-Date: Mon, 28 Apr 2014 15:38:15 -0000
Content-Type: multipart/alternative; boundary=001a11c3656875c88b04f81c1a1f

--001a11c3656875c88b04f81c1a1f
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 28, 2014 at 8:35 AM, Christopher Larson <kergoth@gmail.com>wrote:

> On Mon, Apr 28, 2014 at 8:31 AM, Chris Larson <kergoth@gmail.com> wrote:
>
>> On Mon, Apr 28, 2014 at 8:27 AM, Christopher Larson <kergoth@gmail.com>wrote:
>>
>>> Doing so was causing leakage between the execs of the main value and
>>> that of
>>> the subshell value, and was causing the cached subshell value to be used
>>> for
>>> the overall variable. At the least this could cause execs contamination
>>> between two variables that while differing, run the same subshell. Beyond
>>> that, it's possible we could have been using an incomplete cached value
>>> of
>>> a subshell for that of the main value.
>>>
>>> Before this, bb_codeparser.dat would change between parses with differing
>>> bbfile parse order. After, it does not change.
>>>
>>> The codeparser cache version is bumped, to ensure we don't use
>>> potentially
>>> incorrect cached values from previous runs.
>>>
>>> This should hopefully resolve the difficult-to-reproduce issues we've
>>> seen at
>>> Mentor Graphics where bitbake emits a script to run a task and misses
>>> dependent functions, resulting in 'command not found' failures. This
>>> issue has
>>> also been mentioned on the oe devel list, where someone hit a case where
>>> oe_runmake was missing from a do_install task (IIRC). Adding debug
>>> information
>>> showed that bitbake's information about the variable dependencies for
>>> this
>>> task is inaccurate in the failure cases.
>>>
>>
>> We're trying to confirm the fix, but given it's not really reproducible,
>> and only seemed
>> to be hit during automated builds, it'll be difficult to say with
>> certainty that the problem
>> is resolved. That said, I think it's clear from reading the code that
>> this is the correct
>> thing, and the previous beahvior was just an unintentional oversight when
>> the cache
>> usage was added.
>>
>
> For reference, https://gist.github.com/kergoth/11301539 was used to track
> changes to
>  bb_codeparser.dat to investigate this.
>

Sorry for yet another email on this thread, but I wanted to thank Richard
for his guidance
on this. His suggestion to look at the caching, specifically with an eye
toward file parse
order, proved to be dead on, and valuable.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c3656875c88b04f81c1a1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Apr 28, 2014 at 8:35 AM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"gmail_extra"><div class=3D"adM=
"><div class=3D""><div class=3D"gmail_quote">On Mon, Apr 28, 2014 at 8:31 A=
M, Chris Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@gmail.com" =
target=3D"_blank">kergoth@gmail.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"gmail_extra"><div><div class=3D"gmail_quote"=
>
On Mon, Apr 28, 2014 at 8:27 AM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div style=3D"overflow:hidden">Doing so was causing leakag=
e between the execs of the main value and that of<br>




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
task is inaccurate in the failure cases.</div></blockquote></div><br></div>=
We&#39;re trying to confirm the fix, but given it&#39;s not really reproduc=
ible, and only seemed</div><div class=3D"gmail_extra">to be hit during auto=
mated builds, it&#39;ll be difficult to say with certainty that the problem=
</div>



<div class=3D"gmail_extra">is resolved. That said, I think it&#39;s clear f=
rom reading the code that this is the correct</div><div class=3D"gmail_extr=
a">thing, and the previous beahvior was just an unintentional oversight whe=
n the cache</div>



<div class=3D"gmail_extra">usage was added.</div></blockquote></div><br></d=
iv></div>For reference,=C2=A0<a href=3D"https://gist.github.com/kergoth/113=
01539" target=3D"_blank">https://gist.github.com/kergoth/11301539</a> was u=
sed to track changes to</div>

<div class=3D"gmail_extra">
bb_codeparser.dat to investigate this.</div></blockquote></div><br>Sorry fo=
r yet another email on this thread, but I wanted to thank Richard for his g=
uidance</div><div class=3D"gmail_extra">on this. His suggestion to look at =
the caching, specifically with an eye toward file parse</div>

<div class=3D"gmail_extra">order, proved to be dead on, and valuable.</div>=
<div class=3D"gmail_extra">-- <br>Christopher Larson<br>clarson at kergoth =
dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tsli=
b<br>

Senior Software Engineer, Mentor Graphics
</div></div>

--001a11c3656875c88b04f81c1a1f--
