Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
	[209.85.217.169])
	by mail.openembedded.org (Postfix) with ESMTP id D2D2F65F2A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Aug 2014 15:06:43 +0000 (UTC)
Received: by mail-lb0-f169.google.com with SMTP id s7so5997112lbd.14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Aug 2014 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=wFGAAG9My8FKwvcLjnLATGNt7mdGkjfi/fIJMpDum8w=;
	b=klGlZkb8j1HaXxVRJH85W/yks9gIYJlzBNup6K8blEnOpbPkIGfhnVI8qF76VemCbH
	hKj1fnutgoTzEoXcGDU5ZWHZrwHqjyl6Zf+yjTald8ekvochs8BqFWXsBdRIqJ9skwDw
	ZeC7ijgQ04o1mHODh7RSJwxp1RG1H5RdUwlWhe22p0xFCq72LNscOz+8rEiGQEVOxHnJ
	jp6mLtdLILEESNukvfWFPMQCMT+lKvbV4O/ly2WKOMqaboSrxvga9abxfpHXqdauXAaC
	bvp3rfhZzPhJeYt+J7qxTNoP4qswvOlm60Gp0j/ViBAsCX3GzN+AaLp5SjXtm8Yhy7by
	vHQQ==
X-Received: by 10.153.4.6 with SMTP id ca6mr39401758lad.32.1407769604188; Mon,
	11 Aug 2014 08:06:44 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.43.42 with HTTP; Mon, 11 Aug 2014 08:06:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1408110806310.9162@localhost>
References: <alpine.LFD.2.11.1408110806310.9162@localhost>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 11 Aug 2014 08:06:24 -0700
X-Google-Sender-Auth: RcwlESmspNYB7hEAjqNSZo7v1Xw
Message-ID: <CABcZANkvKtcEfNBHJ3VfDV_A61WZ6H=bm_MgtJ4EbPcRgOdW0w@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake user manual: shouldn't "Events" mention "[eventmask]"?
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
X-List-Received-Date: Mon, 11 Aug 2014 15:06:47 -0000
Content-Type: multipart/alternative; boundary=001a1133ee5a2f9c8505005be795

--001a1133ee5a2f9c8505005be795
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 11, 2014 at 5:08 AM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:

>
>   reading up on events in BB manual and section 3.7, "Events", talks
> of defining event handlers, but claims:
>
> "This event handler gets called every time an event is triggered."
>
> but don't you have to associate an event handler with one or more
> events using the "[eventmask]" flag? that seems like a fairly
> significant omission from that section. or am i just misunderstanding
> how events work?
>

eventmask is a fairly recent addition. If eventmask is undefined, the
handler is called for all events, and its left to the event handler to make
sure it's only doing its logic for the right events (e.g. call isinstance()
on 'e' to check what event it is). The docs likely were never updated to
include it.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1133ee5a2f9c8505005be795
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 11, 2014 at 5:08 AM, Robert P. J. Day <span dir=3D"ltr">&lt;<a =
href=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.=
ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"adM"><br></div>
=C2=A0 reading up on events in BB manual and section 3.7, &quot;Events&quot=
;, talks<br>
of defining event handlers, but claims:<br>
<br>
&quot;This event handler gets called every time an event is triggered.&quot=
;<br>
<br>
but don&#39;t you have to associate an event handler with one or more<br>
events using the &quot;[eventmask]&quot; flag? that seems like a fairly<br>
significant omission from that section. or am i just misunderstanding<br>
how events work?<br>
</blockquote></div><br></div><div class=3D"gmail_extra">eventmask is a fair=
ly recent addition. If eventmask is undefined, the handler is called for al=
l events, and its left to the event handler to make sure it&#39;s only doin=
g its logic for the right events (e.g. call isinstance() on &#39;e&#39; to =
check what event it is). The docs likely were never updated to include it.<=
br>

-- <br></div><div class=3D"gmail_extra">Christopher Larson<br>clarson at ke=
rgoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer =
- Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a1133ee5a2f9c8505005be795--
