Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id A97227D8E9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 May 2019 09:11:57 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id j13so1733846wmh.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 May 2019 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=xIEQtel5Ok00SgK3NFzXB4kM1aaTZPRc5I3/YqqO3gA=;
	b=MWTl8s7yre6lVU/ume/OvND7r5Le3ubC263MysreVbT3+HhLm/Vwr+rS3c2cbG+q+J
	FPq9R1vuO7XXEw6+ANUwc3mlVpm3JSuRpwWYViBaW7C7wD0exaL+51jf2X04wxEEcqNo
	wwsd4Ph1NBTJPMW8yEG/ngpLRO5VaZBAH1Wl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=xIEQtel5Ok00SgK3NFzXB4kM1aaTZPRc5I3/YqqO3gA=;
	b=AeNvs1pNsOuj7U+RpZjorY4kc3URW2KfFWMdmwpVTAVGSJWqfBxsmPizit9dWN1hTh
	JHJc8Pi8ct7p+zFywx7uQSi0pbXFLupoB+ygNfhT3A06v1mOTlagfYa8IQxgCGbYjMQW
	lt7JX+JUDBDShTKo9MHI3jIH+/5/KnCcghhKffLgyj8zDPSkia2qlRMRZDnhOEH85bzn
	1WiNl7/1QI4ztenr/yKo1GG9Z+sfqVUl0X4CM/NfzZtzDxagWxsD5CM7FSPwCyrYkxog
	Z1j5Il7FMFZODsEPNKHCLXQal8NH8aTJKLnV+hMwk4OHzy5mzuAs5PEwNwuK7Yxz8D71
	7hSA==
X-Gm-Message-State: APjAAAVpKKRNZbYLjgW2gktra1K/QELtWmu/N3eA24ub4p1z07MyPoG0
	R0e9iVy5OIle0k6D+EL3tNmLDfmT1GA=
X-Google-Smtp-Source: APXvYqwy5XNO3kyWoFFyZtq9SrMhZpdhslbhmNCgP/XeoUsMHj8FUHUCm/9yeNh/Eull551Vyo4hzA==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr1589036wmh.137.1556788318251; 
	Thu, 02 May 2019 02:11:58 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id n6sm7826370wmn.48.2019.05.02.02.11.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 02:11:57 -0700 (PDT)
Message-ID: <60cd51193b9ddc4614c063e36af9372dbcc6dd60.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 02 May 2019 10:11:55 +0100
In-Reply-To: <686686b7-76a7-92c8-b21f-4ddf76e24550@windriver.com>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
	<20190501111859.5699-4-richard.purdie@linuxfoundation.org>
	<686686b7-76a7-92c8-b21f-4ddf76e24550@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] bitbake: Drop duplicate license boilerplace text
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
X-List-Received-Date: Thu, 02 May 2019 09:11:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-05-01 at 08:44 -0500, Mark Hatle wrote:
> On 5/1/19 6:18 AM, Richard Purdie wrote:
> > With the introduction of SPDX-License-Identifier headers, we don't
> > need a ton
> > of header boilerplate in every file. Simplify the files and rely on
> > the top
> > level for the full licence text.
> 
> I've actually been told the opposite by people.  That you still need
> the boilerplate text for various jurisdiction, as the SPDX-License-
> Identifier may not meet regional copyright/license requirements.

Its good enough for u-boot, its also good enough for SPDX (e.g. 
https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf
).

Can you point at a jurisdiction where its a problem?

We have the top level LICENSE* files and they explicitly reference the
identifier. The files are a collective, with modern source control and
release tarballs or package management they work as a unit.

The copyright situation is unchanged as the copyright remains stated in
each file.

I think the benefits in cleaning this up outweigh potential risk,
particularly if we move as a wider community to establish this as the
standard (and it does make sense to me to do and support that).

Cheers,

Richard



