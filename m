Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f195.google.com (mail-ig0-f195.google.com
	[209.85.213.195])
	by mail.openembedded.org (Postfix) with ESMTP id 467E77321C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 16:37:37 +0000 (UTC)
Received: by mail-ig0-f195.google.com with SMTP id c3so11861861igl.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=GeITjU7w2G3SUMRWldlCgPz5+LWJDMvnHyKxOn4IKTY=;
	b=0YnM1AhhScziTHmM4fZwpRZvA5fIVe0AAM1v1ZHmucSgiCjZGpPjDRcUnfrMz0ccyq
	MvJjG0JW/1RI4HYBf5fhVHa8IySc5PCpuN+5IBo3wCcDrkAAdQBUO9uCFtq1TzupC7PA
	ijdoOYGDmQvzNsGp621tTtrqAqUuGPHzWvz6NxLlc5NlxKBxI4sglfuCY+nFYsxRhhnB
	tCXz45kVo+QErKBwhR7mCiDKpGyMJdhMaEHzSlvuuq3c5JK+8dOzTYUEaXewDYWbEBYk
	MJn0L+ld49J1TLiQ84B+f77NpdLA8QX2a0c/srAyyrMMghOzAEpw3lptq12/U+kKlAmK
	2I6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=GeITjU7w2G3SUMRWldlCgPz5+LWJDMvnHyKxOn4IKTY=;
	b=a0uriEGhNbfsrPUTjDc5aXAsW/rrLHWlmilW9L/w2VMhgubaJcl4rb+U+2CSMDHr1h
	292OAB77MpR//3UdFkz61azeXgMSry+EOV3A+LNSHf9vUf3meD66eExNvrPCpuq91ebL
	nfw1ko62AKPaJAJqetgqUVWD87/c8+JcnwOQ9j22KqmTegyjDnr4Ald5mMLtwl9kVxfP
	LrRYC9vN8KNYvtnu8dDME7iIFGGoMeSN5/4I2lbLRwxP4QBMDL3xPtAxPHbofxvtAapX
	1nYckSTMRdfAkdlZKbMAMTssMsrZr4ZdosXT3t/Ym0rYEc8lps/WYxOkDCfmuVPynBY+
	dn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=GeITjU7w2G3SUMRWldlCgPz5+LWJDMvnHyKxOn4IKTY=;
	b=VaF0dUc+kXlePnE3s2KhgKIIFk7Tk2tRzZiCNmpuygsBnho5A88WL7P+LAs6TCIDIJ
	RUjYhrF1k23NBNr97aWIjkgDzWficUDK9UVFWTa4QHdoM3ruzFZuhki7l+ZFES0domjK
	SKqvb/6s7l65wsf9MiBUJBM534zis98vSocp/QiSXJEMPWaO64t+3caEul0yMt4Ynl1c
	8Btw4Gw67gzDuyxlAkb042TRIFuylxbrBclMDR2tmP8Br3soN04My81C/OHhDTXeRLdJ
	Ue52JJym6PUAkRP2ySdXwPoqktZz9WrnvqhHQeBH7fthmabxqULY2S2qs8f6os9iT0Pe
	fGxQ==
X-Gm-Message-State: AOPr4FVyNYO4odZP4K30JZRJl1Dg264W23HxiG/65j4WmsJSJSzllFWo65lo9XTQoijUsAmDoqYkcwS95FoO9A==
X-Received: by 10.50.29.76 with SMTP id i12mr12405261igh.87.1462811858320;
	Mon, 09 May 2016 09:37:38 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Mon, 9 May 2016 09:37:19 -0700 (PDT)
In-Reply-To: <1462798872.21831.128.camel@linuxfoundation.org>
References: <1462798872.21831.128.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 9 May 2016 09:37:19 -0700
X-Google-Sender-Auth: WGJwcnFZCFSa0FVgZXPS4gcUS1c
Message-ID: <CABcZANm6LBSKMhKAugX+g=2Giuohdxhej7W7Q1TSPO7QaGL+0A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Update logger.warn() -> logger.warning()
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
X-List-Received-Date: Mon, 09 May 2016 16:37:39 -0000
Content-Type: multipart/alternative; boundary=047d7bd75984304ce005326b6df1

--047d7bd75984304ce005326b6df1
Content-Type: text/plain; charset=UTF-8

On Mon, May 9, 2016 at 6:01 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> python deprecated logger.warn() in favour of logger.warning(). This is only
> used in bitbake code so we may as well just translate everything to avoid
> warnings under python 3. Its safe for python 2.7.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bd75984304ce005326b6df1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, May 9, 2016 at 6:01 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><div id=
=3D":qa" class=3D"">python deprecated logger.warn() in favour of logger.war=
ning(). This is only<br>
used in bitbake code so we may as well just translate everything to avoid<b=
r>
warnings under python 3. Its safe for python 2.7.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br></div></blockquo=
te></div><br>Looks good.<br>-- <br><div class=3D"gmail_signature">Christoph=
er Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded,=
 OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graph=
ics</div>
</div></div>

--047d7bd75984304ce005326b6df1--
