Return-Path: <kergoth@gmail.com>
Received: from mail-yh0-f54.google.com (mail-yh0-f54.google.com
	[209.85.213.54])
	by mail.openembedded.org (Postfix) with ESMTP id E169365C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 16:39:35 +0000 (UTC)
Received: by mail-yh0-f54.google.com with SMTP id 29so1166379yhl.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=0jlY3JeBCRxtzzLc47rdlNAGqaLiGWn5CIES3fXIXJ8=;
	b=0yxqSpDOqMKUnD9CM5EN6G7Hqvxsk8FqNcMY9QAREZMkiw4T2XNWMeLA2bVDSFJzkM
	f4Ssepd6H76+2H/kM7gSl1JfNJqNk0wyWHcxYs0+EAAkOlIzYMjOPKx0iZBJxr6uA9ww
	KSkY+1winRM0qTEcIyp1YoYDIr/pW+DN750L3mID530er3xwzTR9Sda80tEBzh8K3ki1
	jpzcd2hKsjCV5j15iWtXEMYQs4YJpykIkCub9g7kgck71Gj0RkQjuyF/mrW03ONGNeWj
	izbRaVgLwbc6KJgZq97GVFXv96aKKTY6bEGV30aCnRorGd0UaEYQHYNyHJEuJt9Bg4s4
	uOhQ==
X-Received: by 10.170.170.134 with SMTP id m128mr1570760ykd.21.1421944776022; 
	Thu, 22 Jan 2015 08:39:36 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.170.190.16 with HTTP; Thu, 22 Jan 2015 08:39:15 -0800 (PST)
In-Reply-To: <1421938639.19798.17.camel@linuxfoundation.org>
References: <1421938639.19798.17.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 22 Jan 2015 09:39:15 -0700
X-Google-Sender-Auth: BTvjP81b6yhnDwDkAmi10NGZ05s
Message-ID: <CABcZANnmpn8JGBVDSLrs+o04kFK53g3gzTgxf-CrkJ6Jr2_8Wg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, "Eggleton,
	Paul" <paul.eggleton@intel.com>
Subject: Re: Lifecycle issues in Bitbake
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
X-List-Received-Date: Thu, 22 Jan 2015 16:39:38 -0000
Content-Type: multipart/alternative; boundary=001a113a310c43e0be050d405131

--001a113a310c43e0be050d405131
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 22, 2015 at 7:57 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Looking at and thinking about:
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=5187
>
> We have several issues. Firstly, DATE and TIME are locked in stone when
> the base configuration is parsed. This may cause images to overwrite
> previous versions for example if DATE and TIME are not re-evaluated. We
> could fix this by specifically setting DATE and TIME in bitbake at
> BuildStart?
>

Seems quite reasonable to me.

Secondly, there is one cooker log file opened for the duration of the
> cooker lifecycle. This is a cooker log, not a log of each build so that
> is perhaps not surprising (and is the core problem in the above bug).
> There is no overwriting of the log file, it just keeps growing with each
> build.
>
> We could trigger knotty to write out build specific log files based on
> the BuildStart/Finish events?
>

This doesn't seem unreasonable, though a build isn't necessarily bound to a
particular UI, is it? Should that go into the server or perhaps the ui
helper at least? Hmm.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113a310c43e0be050d405131
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jan 22, 2015 at 7:57 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":1c2" class=3D"a3s" style=3D"overflow:hidden">Looking at=
 and thinking about:<br>
<br>
<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5187" target=
=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5187</a><br=
>
<br>
We have several issues. Firstly, DATE and TIME are locked in stone when<br>
the base configuration is parsed. This may cause images to overwrite<br>
previous versions for example if DATE and TIME are not re-evaluated. We<br>
could fix this by specifically setting DATE and TIME in bitbake at<br>
BuildStart?<br></div></blockquote><div><br></div><div>Seems quite reasonabl=
e to me.=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=
=3D":1c2" class=3D"a3s" style=3D"overflow:hidden">
Secondly, there is one cooker log file opened for the duration of the<br>
cooker lifecycle. This is a cooker log, not a log of each build so that<br>
is perhaps not surprising (and is the core problem in the above bug).<br>
There is no overwriting of the log file, it just keeps growing with each<br=
>
build.<br>
<br>
We could trigger knotty to write out build specific log files based on<br>
the BuildStart/Finish events?</div></blockquote><div><br></div><div>This do=
esn&#39;t seem unreasonable, though a build isn&#39;t necessarily bound to =
a particular UI, is it? Should that go into the server or perhaps the ui he=
lper at least? Hmm.</div></div>-- <br><div class=3D"gmail_signature">Christ=
opher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedd=
ed, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Gr=
aphics</div>
</div></div>

--001a113a310c43e0be050d405131--
