Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 5548471633
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 20:54:17 +0000 (UTC)
Received: by igcse8 with SMTP id se8so29179075igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=kHXncUXiDp2BECfws+a3qHQdE8V2P3MUUHc18bMHfR0=;
	b=r/aktHMJbabFPOagCpzESMQ1VfLB/CxcnFCWlImgl0niNKa95G+XsF26LP9uzYf1uV
	5uKk0NXfLncOwXTuhdTcmpve9hdejEEuK3q3j5zPMdYLsU7qGiFlmtm7ccSUOpJE5Qhs
	jXMp+LrXtrNz3oSLXjG5syr0WA5HV/W89H+3waEbZuwwVlfo3jM/unFlOWO+YEhJ/gFK
	aVl9JPVi36wN0l5Y5Qen1MRavamS60GZf+OUutdvoJzJwEXZE2qKMP/oNuy8Dfh4olAB
	/V5UAOnqc3DD8HOl7DzcFc1SiETKKKE1ijSCFXnMAGF5zNaOwpeWX5Hd26F9EIqJgiQs
	FezA==
X-Received: by 10.50.43.137 with SMTP id w9mr5365991igl.38.1440795257956; Fri,
	28 Aug 2015 13:54:17 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Fri, 28 Aug 2015 13:53:58 -0700 (PDT)
In-Reply-To: <1440776740-26875-1-git-send-email-sam.thursfield@codethink.co.uk>
References: <1440776740-26875-1-git-send-email-sam.thursfield@codethink.co.uk>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 28 Aug 2015 13:53:58 -0700
X-Google-Sender-Auth: 9Z9lMlGcmDtijeXX2yzux9Zj7GA
Message-ID: <CABcZANmgC1XMh=Yn3ZoJKH+YSdVw7YK6qfiH58e_kai7_bB0Hg@mail.gmail.com>
To: Sam Thursfield <sam.thursfield@codethink.co.uk>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Research into exporting BitBake recipes for consumption elsewhere
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
X-List-Received-Date: Fri, 28 Aug 2015 20:54:20 -0000
Content-Type: multipart/alternative; boundary=e89a8f8388f58b70c6051e6549b8

--e89a8f8388f58b70c6051e6549b8
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 28, 2015 at 8:45 AM, Sam Thursfield <
sam.thursfield@codethink.co.uk> wrote:

> I wrote a proof-of-concept patch which lets you export all the tasks
> from a BitBake project, as actual executable shell and Python scripts.
> I'm sharing it here to see if anyone is interested in this sort of
> thing, and to see if anyone reading can point out obvious improvements
> that I haven't spotted.
>
> This is the first time I've hacked on BitBake's internals, so this code
> has quite a lot of room for improvement :-) Exporting is slow (~10
> mins), blocks the 'cooker' process completely while it runs, and causes
> BitBake to hang once it's finished. But, the generated scripts do
> actually work, which is what motived me to share the results.
>
> The goal of this is to have a tool for 'flattening' a set of recipes,
> which I think is useful when reasoning about what they actually do.
>
> Right now it produces almost 3GB of output for my test project. This is
> mostly because the entire data dict is dumped for each .py file. I've
> looked at deduplicating, but my naive implementation was incredibly slow
> (checking each variable in the dict for each task dump), and I've not
> thought of a more clever approach.
>
> Anyway, I hope this is interesting to someone; I may be able to spend
> some time turning it into a viable patch, if there is interest.
>

I find this very interesting, and will definitely be checking out the patch.

Regarding exporting full data dict, we maintain variable dependency
knowledge as a part of the metadata checksumming capability, so it should
be straightforward to only emit what's used for the task in question.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--e89a8f8388f58b70c6051e6549b8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 28, 2015 at 8:45 AM, Sam Thursfield <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:sam.thursfield@codethink.co.uk" target=3D"_blank">sam.thursfie=
ld@codethink.co.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div id=3D":1ey" class=3D"a3s" style=3D"overflow:hidden">I wrote a proof-of=
-concept patch which lets you export all the tasks<br>
from a BitBake project, as actual executable shell and Python scripts.<br>
I&#39;m sharing it here to see if anyone is interested in this sort of<br>
thing, and to see if anyone reading can point out obvious improvements<br>
that I haven&#39;t spotted.<br>
<br>
This is the first time I&#39;ve hacked on BitBake&#39;s internals, so this =
code<br>
has quite a lot of room for improvement :-) Exporting is slow (~10<br>
mins), blocks the &#39;cooker&#39; process completely while it runs, and ca=
uses<br>
BitBake to hang once it&#39;s finished. But, the generated scripts do<br>
actually work, which is what motived me to share the results.<br>
<br>
The goal of this is to have a tool for &#39;flattening&#39; a set of recipe=
s,<br>
which I think is useful when reasoning about what they actually do.<br>
<br>
Right now it produces almost 3GB of output for my test project. This is<br>
mostly because the entire data dict is dumped for each .py file. I&#39;ve<b=
r>
looked at deduplicating, but my naive implementation was incredibly slow<br=
>
(checking each variable in the dict for each task dump), and I&#39;ve not<b=
r>
thought of a more clever approach.<br>
<br>
Anyway, I hope this is interesting to someone; I may be able to spend<br>
some time turning it into a viable patch, if there is interest.</div></bloc=
kquote></div><br>I find this very interesting, and will definitely be check=
ing out the patch.</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">Regarding exporting full data dict, we maintain variable depen=
dency knowledge as a part of the metadata checksumming capability, so it sh=
ould be straightforward to only emit what&#39;s used for the task in questi=
on.<br>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson =
at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Mainta=
iner - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--e89a8f8388f58b70c6051e6549b8--
