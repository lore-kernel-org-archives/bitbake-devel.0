Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
	[209.85.223.169])
	by mail.openembedded.org (Postfix) with ESMTP id 50CFB7714F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 13:59:03 +0000 (UTC)
Received: by iofl186 with SMTP id l186so124779154iof.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to
	:content-type;
	bh=d3s2E3Y3fjIzN1m5JjCDhUmxbituyEzX19ClUizbMPc=;
	b=Zdo/PsC+sCkiOrMQt2A0Y8MHUU6rr5FjtOJ5h7MJEhz+BlhYfOhBATeahScLuqP2Fz
	gwBn/C5fvzZLGyijMRuQn2+M8Bo2u2QrRxd0JWOWi1iSY/CsCXm/OEuiqXrFLsRnLBeS
	MHFZJX77aekJUwAGUkjXz8NViHRgtoJRP71P2ej8Nesg5Qyysq2NnhE04r2xfeLBp/TT
	pnc0CXfm7lgozqiaDqdDhVcuUoFtuY3TGhupU2BgL0lfhPOED5vDgB/OJ/C1ac+CN0IS
	Q1fJTJorTi5jgR95R/IgtOxMqlchMZeD05bv3l3mqldiUlFED8zxfJuJP1RsUg3A2C8i
	Fhhw==
X-Gm-Message-State: ALoCoQm3UtgTvBY/GiLEmZ7JDlPgULqbBbTvSU6SDqi1nu5f2NHAFzu8+2kz/evCjO5QF+ZLw0Al
MIME-Version: 1.0
X-Received: by 10.107.41.194 with SMTP id p185mr19964356iop.109.1445003943969; 
	Fri, 16 Oct 2015 06:59:03 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Fri, 16 Oct 2015 06:59:03 -0700 (PDT)
Date: Fri, 16 Oct 2015 14:59:03 +0100
Message-ID: <CA+1hgUgYKybYHBot6xxzDOJO4BM_8MBaSRm7niN4AO5gWbik5g@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] Patches for toaster which didn't apply to master 2015-10-16
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
X-List-Received-Date: Fri, 16 Oct 2015 13:59:04 -0000
Content-Type: multipart/alternative; boundary=001a1141bfc2c7a002052239329e

--001a1141bfc2c7a002052239329e
Content-Type: text/plain; charset=UTF-8

Several of the patches for toaster didn't apply to master.

I have now rebased our toaster-next branch on master and pushed it to:

toaster-next-outstanding
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=toaster-next-outstanding

There are no commits on that branch which haven't been sent to
bitbake-devel before.

Thanks.
Elliot
-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a1141bfc2c7a002052239329e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Several of the patches for toaster didn&#39;t apply to mas=
ter.<div><br></div><div>I have now rebased our toaster-next branch on maste=
r and pushed it to:</div><div><br></div><div>toaster-next-outstanding</div>=
<div><a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/=
?h=3Dtoaster-next-outstanding">http://git.yoctoproject.org/cgit/cgit.cgi/po=
ky-contrib/log/?h=3Dtoaster-next-outstanding</a><br></div><div><br></div><d=
iv>There are no commits on that branch which haven&#39;t been sent to bitba=
ke-devel before.</div><div><br></div><div>Thanks.</div><div>Elliot</div><di=
v><div>--=C2=A0<br></div><div><div class=3D"gmail_signature"><div dir=3D"lt=
r"><div>Elliot Smith<br>Software Engineer<br>Intel Open Source Technology C=
entre</div></div></div>
</div></div></div>

--001a1141bfc2c7a002052239329e--
