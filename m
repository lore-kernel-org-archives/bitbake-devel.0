Return-Path: <kergoth@gmail.com>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
	[209.85.216.170])
	by mail.openembedded.org (Postfix) with ESMTP id 339AF724B9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 15:28:57 +0000 (UTC)
Received: by qcrf4 with SMTP id f4so3949386qcr.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=K2wK0xazVqQH9tLOtCKIu1PzutDwKR0z15dP8Ja2dvs=;
	b=UiSNRd7JkMYX8kQz0RwHe0q30SZuvycISXWoqP+BUBOpc2tmgT40WJ9e4pdWCgLPij
	FaedyVLpI5ZDlZxz5+NZ0zDqYvlfVUL1d8dGK5+G/YP3GmpgwF70/7CBlvqVqzXRPTES
	FIgUXqa9mMuBodb7AP8xasdT79NmB7zEnvK/hMhj6F9hEHMZk6kXIk7zxmN7lfQB3bEX
	WnRhj8Y8/cRR1Dzzj43mfktN6b3emYiRYHc0476my4RHXdc/2z5yqT5ypbki6ewvStj4
	nyG1jltl6AbUMaIyqGSbF+XPyZIFdPwIIGlZ9wRNlVDO4ZK/udLIPSjXJDrLqncGXYuO
	Uvpg==
X-Received: by 10.140.148.216 with SMTP id 207mr51019104qhu.62.1427815738976; 
	Tue, 31 Mar 2015 08:28:58 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.8 with HTTP; Tue, 31 Mar 2015 08:28:38 -0700 (PDT)
In-Reply-To: <1427718573.14020.299.camel@linuxfoundation.org>
References: <1427718573.14020.299.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 31 Mar 2015 08:28:38 -0700
X-Google-Sender-Auth: WUDXNPsOqpMUS5Cv8cIm_awaGK0
Message-ID: <CABcZAN=AdAyYSQYRC9RdmpYw08YJjZ9vXtncmU4gL+3sw-V4=g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure bbappend files are processed in a determistic order
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
X-List-Received-Date: Tue, 31 Mar 2015 15:29:00 -0000
Content-Type: multipart/alternative; boundary=001a113769d0ed30bb051297414d

--001a113769d0ed30bb051297414d
Content-Type: text/plain; charset=UTF-8

On Mon, Mar 30, 2015 at 5:29 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> self.appendlist is a dict and as such unordered. This can lead to cases
> where appends with different names (e.g. x_%.bbappend vs. x_123.bbappend)
> can be reordered in application which in turn reorders the variables
> that those bbappend files might touch. Reorderd variables changes the
> sstate
> cache signatures causing real world issues.
>
> To avoid this, use a list for the append files instead.
>
> This patch is conservative and just adds a new data structure alongside
> the existing one and uses it to resolve the core issue. Later patches
> (post release) can handle some of the wider but less problematic ones
> (e.g. issues in bitbake-layers flatten).
>
> [YOCTO #7511]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Nice, looks good for now. Thanks for the quick fix on this. It should help
sstate reuse in some cases.

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113769d0ed30bb051297414d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Mar 30, 2015 at 5:29 AM, Richard Purdie <span dir=3D"ltr">&lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.pu=
rdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div id=3D":hp" class=3D"a3s" style=3D"overflow:hidden">self.appendli=
st is a dict and as such unordered. This can lead to cases<br>
where appends with different names (e.g. x_%.bbappend vs. x_123.bbappend)<b=
r>
can be reordered in application which in turn reorders the variables<br>
that those bbappend files might touch. Reorderd variables changes the sstat=
e<br>
cache signatures causing real world issues.<br>
<br>
To avoid this, use a list for the append files instead.<br>
<br>
This patch is conservative and just adds a new data structure alongside<br>
the existing one and uses it to resolve the core issue. Later patches<br>
(post release) can handle some of the wider but less problematic ones<br>
(e.g. issues in bitbake-layers flatten).<br>
<br>
[YOCTO #7511]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Nice, looks good for now. Thanks for the quick fix on this. It sho=
uld help sstate reuse in some cases.</div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">Acked-by: Christopher Larson &lt;<a href=3D"=
mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>-- <br><=
div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot =
com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br=
>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113769d0ed30bb051297414d--
