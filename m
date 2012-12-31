Received: from mail-la0-f45.google.com ([209.85.215.45])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TpTDe-0005Aa-8j
	for bitbake-devel@lists.openembedded.org;
	Mon, 31 Dec 2012 01:27:07 +0100
Received: by mail-la0-f45.google.com with SMTP id ep20so3277241lab.32
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Dec 2012 16:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=5T+/bHHe4I+t6f9BTOK//ip5OdgRBVNNZKYrvA75WtI=;
	b=qHvqHySDq6ffXNl3uNe8LERw4eBIJvisNjH/oFU+w2JalWoT9YZmatRCJVRBkpqaGa
	9/3h4ogdf7+SK12QE1D1dmA4yZCRHf6OOnhmiWxQKvafPeYt5TbqY1geTuSOeNnYnAXW
	RYJUhvhMmzJQ0sNymu+PT6M+CYMBjKv4ciw4UMYHao/vP2i7TjJWIeMrLjNG5Stpetj4
	ZqRMCBSPxHcimOIAOkWmHGsm+x3WK1rxiqmyCxV4GCQTSX+4tTUbW5x9nMVJOw816Dqx
	PEzxn9KlWpQ3hfisfEzN9movo01o5lyVQsvGs7yGikre6nopeQ7j/KLcxpnPz31UZoEa
	xI3g==
Received: by 10.112.50.201 with SMTP id e9mr16081154lbo.82.1356912726943; Sun,
	30 Dec 2012 16:12:06 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Sun, 30 Dec 2012 16:11:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1212301734450.20153@oneiric>
References: <alpine.DEB.2.02.1212301734450.20153@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 30 Dec 2012 17:11:46 -0700
X-Google-Sender-Auth: e2CmkZWciU-YXS6mRhVpfcNABWI
Message-ID: <CABcZANmbHgbDak8-1AMinmzXp=xcqagu2kEkrkrbPsFzmo3=vQ@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: what means "this=ignored" in the context of SRC_URI/patch?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 31 Dec 2012 00:27:08 -0000
Content-Type: multipart/alternative; boundary=f46d0401688314ac9d04d21add59

--f46d0401688314ac9d04d21add59
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 30, 2012 at 3:45 PM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

> i've poked around and checked logs and i have no idea what
> "this=ignored" means.  is it an earlier equivalent of "apply=no"?
> i've never run across it being used anywhere.
>

Never heard of such a thing, personally.

   and while we're on the topic, i'm assuming adding "apply=yes" is
> utterly redundant, yes?  even though there are a bunch of them
> sprinkled throughout some recipes in oe-core.
>


As has been mentioned before, apply=yes is only implicit and automatic when
the filename ends in .{patch,diff}{,.gz}.
-- 
Christopher Larson

--f46d0401688314ac9d04d21add59
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Sun, Dec 30, 2012 at 3:45 PM=
, Robert P. J. Day <span dir=3D"ltr">&lt;<a href=3D"mailto:rpjday@crashcour=
se.ca" target=3D"_blank">rpjday@crashcourse.ca</a>&gt;</span> wrote:<br><di=
v class=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1x9">i&#39;ve poked around and c=
hecked logs and i have no idea what<br>
&quot;this=3Dignored&quot; means. =C2=A0is it an earlier equivalent of &quo=
t;apply=3Dno&quot;?<br>
i&#39;ve never run across it being used anywhere.<br></div></blockquote><di=
v><br></div><div style>Never heard of such a thing, personally.</div><div s=
tyle><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">

<div id=3D":1x9">
=C2=A0 and while we&#39;re on the topic, i&#39;m assuming adding &quot;appl=
y=3Dyes&quot; is<br>
utterly redundant, yes? =C2=A0even though there are a bunch of them<br>
sprinkled throughout some recipes in oe-core.</div></blockquote></div><br><=
br clear=3D"all"><div style>As has been mentioned before, apply=3Dyes is on=
ly implicit and automatic when the filename ends in .{patch,diff}{,.gz}.</d=
iv>

-- <br>Christopher Larson</div></div>

--f46d0401688314ac9d04d21add59--
