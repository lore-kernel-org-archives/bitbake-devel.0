Return-Path: <kergoth@gmail.com>
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
	[209.85.214.50])
	by mail.openembedded.org (Postfix) with ESMTP id CDB6362135;
	Wed, 22 Jun 2016 22:07:59 +0000 (UTC)
Received: by mail-it0-f50.google.com with SMTP id f6so49716006ith.0;
	Wed, 22 Jun 2016 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=FwO70BOPv9AnpWIs2iUbA8FMFMsnJsj+ni0KrlDmBtU=;
	b=BkWoQajrtYd55CI84XF8f63xgNylTk3KyeMrYo2fQ7BqCFiQCtFT2iWh+FbxG9cz75
	pvIaM7MCdfeHwQUQhwuHympDHFtVEMnwM+iNdwUtI2v7xmW+eKTfO0U00knBZux+ezPK
	kWgRqde0Z/Z2Mws6evs0Q22m5cM2paTDzDhlouV84y+CvqESnI+QDzrmEI/bKrMEX9Lq
	YEfCByddkoS51eRV8FoTh4QMSf4xm85H++VrawuGWXA6hgd845ZFi1VY8Yaoj5Mjq0Ye
	lDHEed0d0lSKRRSlU6OFmKUzIvSdVhYjS6MK4FIkhGaqlwdt6QVT0gKlFJRlVlRlLc7S
	qGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=FwO70BOPv9AnpWIs2iUbA8FMFMsnJsj+ni0KrlDmBtU=;
	b=CAeqCUEgDFDT/vsKk4eHI9BkzfyVh+CrWAzjAD+65xjgvhYDEspxLwiqSfCEmt2t+Q
	N8vu3gRsWPBsMp4Piy110NSHECYArPfWP+qI1Mldzu/MbAHJNra8mS10oXTurShJq626
	4Bi2TkFnzWfpHjmiAkcq8rdA7o1GFR79af1ffk6bzk3YKXpuYYqffX8uDWgqG03+MOnR
	OQv3s53Uz8FY3DE3NWe6+DigIJb1/CKGzpwEUjK/XQyL2+dvtJL13SlzjvtL4jbj0vaa
	J2iWAO5L+8HynE/GUdmtF2W2EXplgbMzKwbWTrQoardyN1eQdoY1QKa96GwbW/CXYrrc
	V78A==
X-Gm-Message-State: ALyK8tLQzw3WDlRNJrrqaFiYKzXZjgcef20XiyUo6eQQsMEK4wQ/TSalwWhu3fBya/KiwIaxPFA/hBUJ4YxcoA==
X-Received: by 10.36.43.216 with SMTP id h207mr18132046ita.66.1466633280152;
	Wed, 22 Jun 2016 15:08:00 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.130.66 with HTTP; Wed, 22 Jun 2016 15:07:40 -0700 (PDT)
In-Reply-To: <754f3c3e-6dfe-766f-eb7c-f0983c945cc7@windriver.com>
References: <20160615073901.27831.65435@opal.openembedded.org>
	<20160622155839.GC4153@jama>
	<1466631350.3319.200.camel@linuxfoundation.org>
	<754f3c3e-6dfe-766f-eb7c-f0983c945cc7@windriver.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 22 Jun 2016 15:07:40 -0700
X-Google-Sender-Auth: AIAP8i-iZgJK37ZZQ8P5FzYj9Yo
Message-ID: <CABcZAN=uCEb+SRsLW9pZ6d+9NnJWNjsb=yRz-vuqXsd_gmusWQ@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: openembedded-commits@lists.openembedded.org,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: Bitbake output format changed Was: [oe-commits] [bitbake] branch master updated (a3f464d -> 0219271)
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
X-List-Received-Date: Wed, 22 Jun 2016 22:08:01 -0000
Content-Type: multipart/alternative; boundary=001a114748a2adf1830535e52be0

--001a114748a2adf1830535e52be0
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 22, 2016 at 2:56 PM, Mark Hatle <mark.hatle@windriver.com>
wrote:

> On 6/22/16 4:35 PM, Richard Purdie wrote:
> > On Wed, 2016-06-22 at 17:58 +0200, Martin Jansa wrote:
> >> On Wed, Jun 15, 2016 at 07:39:01AM +0000, git@git.openembedded.org wr
> >> ote:
> >>> rpurdie pushed a change to branch master
> >>> in repository bitbake.
> >>>
> >>>       adds  2c88afb   taskdata/runqueue: Rewrite without use of ID
> >>> indirection
> >>
> >> Is it expected that this change also changes the format of summary
> >> shown at the end of the build and failed tasks.
> >>
> >> The commit message doesn't mention this (it even says:
> >> ..
> >> On the most part there shouldn't be user visible changes.
> >> ..
> >> There should be no functionality changes in this patch, its purely a
> >> data structure change and that is visible in the patch.
> >> ..
> >> )
> >>
> >> So before I start fixing scripts (e.g. test-dependencies) which are
> >> trying to parse bitbake output to work with new format, please
> >> confirm that this was intentional and that it will stay this way.
> >>
> >> It's also not clear why the task is mentioned twice, e.g. as:
> >>   NOTE: Running task 512 of 548 (ID: /OE/build/oe-core/openembedded
> >> -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch, /OE/build/oe
> >> -core/openembedded-core/meta/recipes-devtools/rpm/sftp.bb:do_fetch)
> >>   ERROR: Task /OE/build/oe-core/openembedded-core/meta/recipes
> >> -devtools/rpm/sftp.bb:do_fetch (/OE/build/oe-core/openembedded
> >> -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch) failed with exit
> >> code '1'
> >>
> >> are there cases where these 2 are different? and can both messages
> >> use the same "format" for task description?
> >
> > The taskids are no more, there is simply no notion of them inside
> > bitbake any longer. That means that yes, we probably do need to change
> > the output a bit since the number doesn't mean anything.
> >
> > Equally, it shouldn't be showing the same thing twice, that is a bug.
> > Internally to bitbake, everthing is now in the form (or will be when
> > multiconfig lands) "[multiconfig:<configname>:]<recipe
> > filename>:<taskname>". The question is whether we expose that to the
> > user or massage it at all. I'm tempted just to expose that string to
> > the user.
>
> I'm certainly and advocate of just exposing that string.  I think in the
> end
> that is easier to explain to someone, then trying to understand a massaged
> output.


I'd agree with that. Using the filenames is actually a nice convenience
when you need to examine a recipe.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114748a2adf1830535e52be0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Jun 22, 2016 at 2:56 PM, Mark Hatle <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:mark.hatle@windriver.com" target=3D"_blank">mark.hatle@windriv=
er.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=
=3D"HOEnZb"><div class=3D"h5">On 6/22/16 4:35 PM, Richard Purdie wrote:<br>
&gt; On Wed, 2016-06-22 at 17:58 +0200, Martin Jansa wrote:<br>
&gt;&gt; On Wed, Jun 15, 2016 at 07:39:01AM +0000, <a href=3D"mailto:git@gi=
t.openembedded.org">git@git.openembedded.org</a> wr<br>
&gt;&gt; ote:<br>
&gt;&gt;&gt; rpurdie pushed a change to branch master<br>
&gt;&gt;&gt; in repository bitbake.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adds=C2=A0 2c88afb=C2=A0 =C2=A0taskd=
ata/runqueue: Rewrite without use of ID<br>
&gt;&gt;&gt; indirection<br>
&gt;&gt;<br>
&gt;&gt; Is it expected that this change also changes the format of summary=
<br>
&gt;&gt; shown at the end of the build and failed tasks.<br>
&gt;&gt;<br>
&gt;&gt; The commit message doesn&#39;t mention this (it even says:<br>
&gt;&gt; ..<br>
&gt;&gt; On the most part there shouldn&#39;t be user visible changes.<br>
&gt;&gt; ..<br>
&gt;&gt; There should be no functionality changes in this patch, its purely=
 a<br>
&gt;&gt; data structure change and that is visible in the patch.<br>
&gt;&gt; ..<br>
&gt;&gt; )<br>
&gt;&gt;<br>
&gt;&gt; So before I start fixing scripts (e.g. test-dependencies) which ar=
e<br>
&gt;&gt; trying to parse bitbake output to work with new format, please<br>
&gt;&gt; confirm that this was intentional and that it will stay this way.<=
br>
&gt;&gt;<br>
&gt;&gt; It&#39;s also not clear why the task is mentioned twice, e.g. as:<=
br>
&gt;&gt;=C2=A0 =C2=A0NOTE: Running task 512 of 548 (ID: /OE/build/oe-core/o=
penembedded<br>
&gt;&gt; -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch, /OE/build/oe<br>
&gt;&gt; -core/openembedded-core/meta/recipes-devtools/rpm/sftp.bb:do_fetch=
)<br>
&gt;&gt;=C2=A0 =C2=A0ERROR: Task /OE/build/oe-core/openembedded-core/meta/r=
ecipes<br>
&gt;&gt; -devtools/rpm/sftp.bb:do_fetch (/OE/build/oe-core/openembedded<br>
&gt;&gt; -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch) failed with exit=
<br>
&gt;&gt; code &#39;1&#39;<br>
&gt;&gt;<br>
&gt;&gt; are there cases where these 2 are different? and can both messages=
<br>
&gt;&gt; use the same &quot;format&quot; for task description?<br>
&gt;<br>
&gt; The taskids are no more, there is simply no notion of them inside<br>
&gt; bitbake any longer. That means that yes, we probably do need to change=
<br>
&gt; the output a bit since the number doesn&#39;t mean anything.<br>
&gt;<br>
&gt; Equally, it shouldn&#39;t be showing the same thing twice, that is a b=
ug.<br>
&gt; Internally to bitbake, everthing is now in the form (or will be when<b=
r>
&gt; multiconfig lands) &quot;[multiconfig:&lt;configname&gt;:]&lt;recipe<b=
r>
&gt; filename&gt;:&lt;taskname&gt;&quot;. The question is whether we expose=
 that to the<br>
&gt; user or massage it at all. I&#39;m tempted just to expose that string =
to<br>
&gt; the user.<br>
<br>
</div></div>I&#39;m certainly and advocate of just exposing that string.=C2=
=A0 I think in the end<br>
that is easier to explain to someone, then trying to understand a massaged =
output.</blockquote><div><br></div><div>I&#39;d agree with that. Using the =
filenames is actually a nice convenience when you need to examine a recipe.=
</div></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_s=
ignature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - Bit=
Bake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Eng=
ineer, Mentor Graphics</div>
</div></div>

--001a114748a2adf1830535e52be0--
