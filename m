Received: from mail-la0-f43.google.com ([209.85.215.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TphP0-0003PE-Io
	for bitbake-devel@lists.openembedded.org;
	Mon, 31 Dec 2012 16:35:56 +0100
Received: by mail-la0-f43.google.com with SMTP id eg20so4027274lab.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Dec 2012 07:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=RUcj3zZSHcTxUyQP1Gogqv2YvCmj20OmG7Cbao+GJjk=;
	b=1AFZt+YidnpPbI2MMxcui5geIvgDmqybKxmLNkEDcWL6H/4NR63KQdIcdO/O55fJm6
	uSOAau7IThFxXg+MVc9DJ1a0DFsosJCAEscStNfBbcMj9mpOIy/OXMcZ2xs38ju5sfgB
	ZfaeSkfFoxNy4Zv5DBvnc3nI1YkVZKXEcifxMroiphID3As4Fij+Z865wBzanKlkfxXF
	z/Wphap6hYdNHhyvEvQqOsZPqCwvyqOYkRnvAI5GWhyNkEkmU80PW5226nhRUxwO05FN
	z4IJh5b71fVyBPtKPfewKDljh5OzP6W6QKyAuYEQzdfkyyCFleRcsPiwVqwq3YTvRuIT
	dIaQ==
Received: by 10.152.134.243 with SMTP id pn19mr38787967lab.11.1356967246352;
	Mon, 31 Dec 2012 07:20:46 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Mon, 31 Dec 2012 07:20:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1212301949001.21512@oneiric>
References: <alpine.DEB.2.02.1212301734450.20153@oneiric>
	<CABcZANmbHgbDak8-1AMinmzXp=xcqagu2kEkrkrbPsFzmo3=vQ@mail.gmail.com>
	<alpine.DEB.2.02.1212301949001.21512@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 31 Dec 2012 08:20:26 -0700
X-Google-Sender-Auth: lBz0rj9dE7cixglRFuJ5c3zPWd8
Message-ID: <CABcZANm8E7MH7-RvA+ds=4w2k=9=3bhO52mFMZzVJHoP_A1b=g@mail.gmail.com>
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
X-List-Received-Date: Mon, 31 Dec 2012 15:35:56 -0000
Content-Type: multipart/alternative; boundary=f46d04427248b0d01d04d2278e17

--f46d04427248b0d01d04d2278e17
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 30, 2012 at 5:53 PM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

> i notice that the value of "apply" is tested *before* the final test
> for a valid patch suffix of {.patch,.diff}, which leaves open the
> possibility of something weird or obscure happening there?  i have no
> idea what that might be, i'm just observing the order of those tests.
>

No, it just means it always obeys the value of the parameter if set,
otherwise it goes based on the filename.
-- 
Christopher Larson

--f46d04427248b0d01d04d2278e17
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Sun, Dec 30, 2012 at 5:53 PM=
, Robert P. J. Day <span dir=3D"ltr">&lt;<a href=3D"mailto:rpjday@crashcour=
se.ca" target=3D"_blank">rpjday@crashcourse.ca</a>&gt;</span> wrote:<br><di=
v class=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":x6">i notice that the value of &=
quot;apply&quot; is tested *before* the final test<br>
for a valid patch suffix of {.patch,.diff}, which leaves open the<br>
possibility of something weird or obscure happening there? =C2=A0i have no<=
br>
idea what that might be, i&#39;m just observing the order of those tests.</=
div></blockquote></div><br>No, it just means it always obeys the value of t=
he parameter if set, otherwise it goes based on the filename.<br>-- <br>

Christopher Larson</div></div>

--f46d04427248b0d01d04d2278e17--
