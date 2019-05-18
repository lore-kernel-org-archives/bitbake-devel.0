Return-Path: <andrew.featherstone@gmail.com>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail.openembedded.org (Postfix) with ESMTP id B01DF6C44A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 May 2019 09:04:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id f204so8951985wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 May 2019 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=CL+kl0VAmjdK8lmYf3U7c0ZcOes3SKQvlXzyPLnYzT0=;
	b=mLokk5P6VTNDoEV0O8KWfzwerayQ04O02hPc6hn1FZCikFdcxCCZXsPlT1GHdQ4REY
	uIYVZzg9gBvW8Bbuq99alMUvIkSwXEgkJdXvtQrm9b+pDMUOuf7VZiNqzMLYZ7+18V+V
	bLi9cmECKubJ6RZaLaTRf9KY4haRGj4cmLSUmpUGzIolLygrWA77ZHNXLGJbBzoL3A4O
	yHpYoP86KthunNwCUV5Vd+zg6kBdY+wPHdGBatQBtw2tePELDjfZ2EX2qtSHOU7i5VM4
	4uPq3agSbBMoBrHb1dCSEoxDqsj5p5R02NaQqkP2TAleucJ4QfpSZ9HxhNwYRfMnvvD9
	akIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=CL+kl0VAmjdK8lmYf3U7c0ZcOes3SKQvlXzyPLnYzT0=;
	b=lorijhK/IpB+t00ATdMbkZwvAXd8nA18s07zod4HpETVL9vMaNRFG0SpOfr4ApHn2b
	rzSaiNn2F7RWfWVkXoTPRpMgW7PudOlr6oqkjpFz7RXj562sSoeho8V5XmvsuURKLkXq
	9YWs0j3fRkxUYrW6mypJARlF/2BzazfgkO+3joLge97Jg8CnmsN9N5S4IO6KVUPh3N7G
	z3bLQlQ11OAnmPXxoWqCi9xJNYvd78X2GrxrpY7My46cKXUOErhZXt1RbCkFfgiXiFVl
	D3Uklud6WortLSfuPcf67sKw/qOp9ybMeQ3syvTfaAAPouS7loJ5OXc+KLPddPvY1aHJ
	nG8Q==
X-Gm-Message-State: APjAAAVE4C2SOu8IowSKwfF+rXc0cVjnRcAsZxd8jNmQcAKrCj0H2f+k
	PH/RViLPKxZO2/64rFy0xyEGsAd0X9AEp1OTE+Ere8hBRB4=
X-Google-Smtp-Source: APXvYqxT62UicfLsryTAuOXFalok5wATUFWDRUDWcoE2jHw1TRo3QDhbqE52+9yt449RXjZGvvWmI+RNs8y1GIVto90=
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr18489937wme.104.1558170278209;
	Sat, 18 May 2019 02:04:38 -0700 (PDT)
MIME-Version: 1.0
From: Andrew Featherstone <andrew.featherstone@gmail.com>
Date: Sat, 18 May 2019 10:04:24 +0100
Message-ID: <CAGW41X4-eci5jLF=is4zXyZ_S-09KAm3u6zRY7bZRm5-ZOBoNg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: BitBake release notes
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
X-List-Received-Date: Sat, 18 May 2019 09:04:38 -0000
Content-Type: multipart/alternative; boundary="000000000000eead01058925c951"

--000000000000eead01058925c951
Content-Type: text/plain; charset="UTF-8"

Hi There,

First apologies in advance if this is the wrong mailing list. If there's a
bitbake-users list, please let me know.

I'm looking for some release notes for BitBake to help understand
compatibility of recipes and when new features were added. The changelog at
https://git.openembedded.org/bitbake/tree/ChangeLog hasn't been touched in
quite a few years, Yocto Project release notes include details of changes
https://wiki.yoctoproject.org/wiki/Releases, but nothing about
compatibility. Are all 1.x releases of BitBake backwards compatible?

Regards,
Andrew

--000000000000eead01058925c951
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi There,</div><div=
><br></div><div>First apologies in advance if this is the wrong mailing lis=
t. If there&#39;s a bitbake-users list, please let me know.</div><div><br><=
/div><div>I&#39;m looking for some release notes for BitBake to help unders=
tand compatibility of recipes and when new features were added. The changel=
og at <a href=3D"https://git.openembedded.org/bitbake/tree/ChangeLog">https=
://git.openembedded.org/bitbake/tree/ChangeLog</a> hasn&#39;t been touched =
in quite a few years, Yocto Project release notes include details of change=
s <a href=3D"https://wiki.yoctoproject.org/wiki/Releases">https://wiki.yoct=
oproject.org/wiki/Releases</a>, but nothing about compatibility. Are all 1.=
x releases of BitBake backwards compatible?</div><div><br></div><div>Regard=
s,</div><div>Andrew<br></div></div></div></div>

--000000000000eead01058925c951--
