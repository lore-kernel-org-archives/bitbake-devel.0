Return-Path: <ngompa13@gmail.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
	[209.85.216.196])
	by mail.openembedded.org (Postfix) with ESMTP id 0A30671CB3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 11:58:48 +0000 (UTC)
Received: by mail-qt0-f196.google.com with SMTP id h4so2913767qtk.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Nov 2017 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=PtDjqyXwhvclRzgIYrTIKj0o8OvGf30FhZC6NQdajjo=;
	b=n+HP9jcoziknUoF+aoFk27Q19GmHmbUBNfyJEuvvdeCIZC6B3sePDaSGCFfTrCsvVr
	tD6JloeJ+jiPmUl+Y6CUtd6IQvTYWkCurv8x4xuddYYPdjoFBjIuViJmX9V3pNfDbtBY
	aWcHuOIXV5XkrZGgelcwdTKEfXpMQ31HGgkX7oGf+8nkChEYPdB2t5iiScsIxXaV6XAP
	YvF/QcRqbrU4nlZ5KLt8Ucbb3R5/i1LbD8VvPKfrEtyYbrtpN97yHnCS2r1JxA1pXYTL
	RU8VdwDlWZ37ZenEDcZhHaiOdVE0AAW3YgvwsZzXA0oDH0xDRBMcxuYrig2XpQ/E4fZG
	SYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=PtDjqyXwhvclRzgIYrTIKj0o8OvGf30FhZC6NQdajjo=;
	b=mRe4WLH49fyE7mCh1pK+UohDQTn+iGtxesMR7LinZx3pDKCtrq0QNas9nAftx/NzJe
	vnrTu058+NoriLuqp0JpodNSr43N7uRVwh+eNmMlAv0SQnOa5KbbK95T/fN9g97B+jWd
	VwzU2n+PLKmpFYuSzLEBMvTjiN+zKxNdHAmZ6DzTaHUWMVc2TWJPD/e7ZprxprRfeDCw
	Xf8HEiCCDSMntcVOamw9dfyEBdyrl7lyPAfr751yH2i9n55NFpdzXjiFypbosRzAaCI5
	BcdwkR1+4LAMpIITM0AjHypac9yjsOT02hm0BbUv36v4KXY7edEpEmqaEv77orYWBw99
	EdcA==
X-Gm-Message-State: AJaThX6z/dGsbzC2ORqI5xfiNVWGrVTF6NpNfDf2rduPeu+9UfvUYYl0
	5ismkrQ2yG2Vu4uoTB3j3hgxEfE+weatcfBZjGsxRM46
X-Google-Smtp-Source: ABhQp+S+QLupa348vu76xEU+WWn1Xc4J+PkO85bTGMCLwaD3WHsRsyBBotw3qELGb36dEe9h75qmUBmkL/TizsSkO5A=
X-Received: by 10.200.56.52 with SMTP id q49mr320798qtb.309.1510142329517;
	Wed, 08 Nov 2017 03:58:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.41.130 with HTTP; Wed, 8 Nov 2017 03:58:08 -0800 (PST)
From: Neal Gompa <ngompa13@gmail.com>
Date: Wed, 8 Nov 2017 06:58:08 -0500
Message-ID: <CAEg-Je9okCK9dEaV9Ytk6SvyzcCT=LeViP5o53F7B4oL+eR0vw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Releases of BitBake to package for Fedora?
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
X-List-Received-Date: Wed, 08 Nov 2017 11:58:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey all,

I'm looking reintroduce BitBake into Fedora, but it seems like there
hasn't been releases in two years. I also cannot identify anywhere
that provides tarballs of BitBake to package.

The Fedora package previously referenced snapshot tarballs generated
by tagged releases in OE Git, but there haven't been new tagged
releases in two years.

I'd previously asked this on oe-core ML and was redirected to
bitbake-devel, so apologies to cross-list subs. But it was also
pointed out there that apparently BitBake has moved to a model where
they don't have stable points of releases, which seems rather odd for
a tool that is used by more than OpenEmbedded.

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

