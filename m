Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f194.google.com (mail-ig0-f194.google.com
	[209.85.213.194])
	by mail.openembedded.org (Postfix) with ESMTP id 20E667002B;
	Thu,  5 May 2016 15:19:13 +0000 (UTC)
Received: by mail-ig0-f194.google.com with SMTP id c3so2299120igl.3;
	Thu, 05 May 2016 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=LybbofUbx28Lsx8eIOfA6KUJDuSyia79zj995na19Is=;
	b=n23y0XpUx6ILjay/dHoeDiv4FihwZfcwNhAIa+1uB16NEDVwsn9VmPMoFDfx49b1i+
	rKgeNgxi3k+OJ5Lb00NgXmnbWhkVETn/WAqo60YF2+RWwyESGAnB6MrzctlYGQXi98j3
	gAM9R+D3gLBi5lESVO5TmWBW8h64KCdleY4+orlc4mO7a9x7yfjZTYG9VNG3W5YUMX0r
	aKXuECrZfwsNjywOM+99vPj7CveX2iCfwn880mEbxdnSu3Z1m3bxshDVDWzFt12z6j5M
	zGh3wukAQ0dMfB5VoVDiFoAopURjVYyPHW5Le46nOdxiE/xaTp73BvelFADIx2z+rv0v
	E3yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=LybbofUbx28Lsx8eIOfA6KUJDuSyia79zj995na19Is=;
	b=GXnZ82CIjYigN7qXVkOab/O8YBOhKV6x7Y5tv5S/7Wo9HrUN6Fol0ClO+vTiEe2Ggo
	2P3k0D10FS2A3zzQUd1/1HxFovi+dmo2jbWIcoGWcZJm2s3elkYhSIkuWbyNrtEcOUff
	ELkJkZXD77U2SaWgGc31w6bRsTTQeM6T8ep2bUwtumDXI9ofPFNfsa25Kwwwd0+gKvk+
	IdkxUbXx45O9JbouuhvxIqJE9kK+WXs/l6bKEHnnyWAZGiF7JnAtLr0BCSFrMOtTietL
	GCveHPbC3uBRolY0kj4Q78ccnpbJgNLeuu569YHtIBJoOoF4N+jQ9pOlK/9HxAUP2Tp6
	KzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=LybbofUbx28Lsx8eIOfA6KUJDuSyia79zj995na19Is=;
	b=mOuh1tc9tJ/iOrN9Pukzz/mZniVqJbCNwTH9G9QwbxjJ219OEwb6M0S7NbOrZpRtzw
	NiBeT71Y3vZerhq7FVr+e+/5ACnLgPE08x+dUr8riJEv/gY6VMXU1y6BDzB1UKdsNBi8
	gFarbI5UVvYXACxHjCSMUyR5b81d8pbLfJLuQS8TMDakvabmhEb/pn0dpftYoQ/wdIfU
	g8iHjytNv9t23fFcMA07l+AiNrbuPhjm2a2VsTFyADPQmYhUCcfhCyfmtMHPi7WbuYXO
	mzhOQdSJngg1p2YYsVb4y1xjr2hjoT3KELfqZIgqKLLc0XMPjF7x503D7tqazqVb5gy7
	XAPw==
X-Gm-Message-State: AOPr4FU97n4lm43z8FReux2Bn8PbHJMpI/pG7pSW4F93VUwmMRT8iGjtjw5lEnyME9JPs9U6f5Tg5hh3lXo+tw==
X-Received: by 10.50.143.1 with SMTP id sa1mr4688815igb.20.1462461554336; Thu,
	05 May 2016 08:19:14 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Thu, 5 May 2016 08:18:54 -0700 (PDT)
In-Reply-To: <fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
	<cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
	<fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 5 May 2016 08:18:54 -0700
X-Google-Sender-Auth: 45mHM59eZ8ubCLeg8C7-Y8RmPhA
Message-ID: <CABcZANkm4caMHo2kutQFBfzhVNxyD50xSS7K0vnHSpmKJj6qvQ@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: Philip Balister <philip@balister.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Thu, 05 May 2016 15:19:14 -0000
Content-Type: multipart/alternative; boundary=001a1134bdaa71afcb053219dd74

--001a1134bdaa71afcb053219dd74
Content-Type: text/plain; charset=UTF-8

On Thu, May 5, 2016 at 8:13 AM, Mark Hatle <mark.hatle@windriver.com> wrote:

> On 5/5/16 7:13 AM, Philip Balister wrote:
> > On 05/04/2016 05:29 PM, Mark Hatle wrote:
> >> On 5/4/16 3:56 AM, Richard Purdie wrote:
> >>> My proposal is we decide to have the flag day, we queue up the patches
> >>> on a python3 branch both in oe-core and bitbake, then we switch when we
> >>> get successful autobuilder builds. I'd ideally like to do this quite
> >>> soon and get one with it (within a few weeks), leaving plenty of time
> >>> to handle issues and the other changes planned for this release cycle
> >>> and give other layers time to adapt.
> >>>
> >>> I will likely push things so the basics in the core work, I'll then
> >>> need help for things like toaster, the QA framework, the supporting
> >>> tools (devtool, recipetool and so on).
> >>>
> >>> Does anyone object to this?
> >>
> >> I think this is a good plan.  Flag day, and switch.
> >>
> >> Question, do we need any type of identifier in layers to say they're
> "python3"
> >> compatible or not?
> >
> > Layers that are python2 will need krogoth branches. I'd expect master
> > branches to follow oe-core/master and jump to python3.
>
> I don't disagree, but my experience has been that branching is late or
> never in
> a lot of layers.
>
> This might be a place where we need to plan to go through the layer index
> and at
> least see if the layer parses -- and flag things that no longer parse?  (I
> don't
> even know if this is something reasonable to attempt.)
>
> My fear is just we've already got a lot of "broken" (without defining that)
> layers in the index, and I think it will be worse once the python3 change
> happens.  I'd really like to make sure we don't confuse people with
> various errors.


Perhaps we should consider some sort of flag or dependency/versioning
statement in layer.conf?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134bdaa71afcb053219dd74
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, May 5, 2016 at 8:13 AM, Mark Hatle <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mark.hatle@windriver.com" target=3D"_blank">mark.hatle@windrive=
r.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 5/5/16 7:13 AM, Philip Balister wrote:<br>
&gt; On 05/04/2016 05:29 PM, Mark Hatle wrote:<br>
&gt;&gt; On 5/4/16 3:56 AM, Richard Purdie wrote:<br>
&gt;&gt;&gt; My proposal is we decide to have the flag day, we queue up the=
 patches<br>
&gt;&gt;&gt; on a python3 branch both in oe-core and bitbake, then we switc=
h when we<br>
&gt;&gt;&gt; get successful autobuilder builds. I&#39;d ideally like to do =
this quite<br>
&gt;&gt;&gt; soon and get one with it (within a few weeks), leaving plenty =
of time<br>
&gt;&gt;&gt; to handle issues and the other changes planned for this releas=
e cycle<br>
&gt;&gt;&gt; and give other layers time to adapt.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I will likely push things so the basics in the core work, I&#3=
9;ll then<br>
&gt;&gt;&gt; need help for things like toaster, the QA framework, the suppo=
rting<br>
&gt;&gt;&gt; tools (devtool, recipetool and so on).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Does anyone object to this?<br>
&gt;&gt;<br>
&gt;&gt; I think this is a good plan.=C2=A0 Flag day, and switch.<br>
&gt;&gt;<br>
&gt;&gt; Question, do we need any type of identifier in layers to say they&=
#39;re &quot;python3&quot;<br>
&gt;&gt; compatible or not?<br>
&gt;<br>
&gt; Layers that are python2 will need krogoth branches. I&#39;d expect mas=
ter<br>
&gt; branches to follow oe-core/master and jump to python3.<br>
<br>
</span>I don&#39;t disagree, but my experience has been that branching is l=
ate or never in<br>
a lot of layers.<br>
<br>
This might be a place where we need to plan to go through the layer index a=
nd at<br>
least see if the layer parses -- and flag things that no longer parse?=C2=
=A0 (I don&#39;t<br>
even know if this is something reasonable to attempt.)<br>
<br>
My fear is just we&#39;ve already got a lot of &quot;broken&quot; (without =
defining that)<br>
layers in the index, and I think it will be worse once the python3 change<b=
r>
happens.=C2=A0 I&#39;d really like to make sure we don&#39;t confuse people=
 with various errors.</blockquote><div><br></div><div>Perhaps we should con=
sider some sort of flag or dependency/versioning statement in layer.conf?</=
div></div>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clars=
on at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Mai=
ntainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1134bdaa71afcb053219dd74--
