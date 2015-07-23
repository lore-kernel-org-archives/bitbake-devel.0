Return-Path: <jatedev@gmail.com>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
	[209.85.214.177])
	by mail.openembedded.org (Postfix) with ESMTP id 4653B761D6;
	Thu, 23 Jul 2015 21:32:23 +0000 (UTC)
Received: by obbop1 with SMTP id op1so4969958obb.2;
	Thu, 23 Jul 2015 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=kuLpJZimWLHcnRkhmsY1MPH3Y4bRvxUKODXVDFAAfR4=;
	b=uutMvObInDvPTQWqWcg5cs9zpZ2L5HnJ/CwLhEFf3Xyejd9MpJK7ne4MTIAacjR2vX
	PNpQir6XcNWHz5/L6wCWMRWrfsBF4xR7e3IJvws3aAZEOnxyx1Vn3BogUybFDVBC2Cds
	lttCM0Mdk1zhn6ylSp/q2K+5WqpehGEAelY8FZRW+a2Rrm+3/dacmVmXiSBWoo0MeN7f
	UsyhIWNS6h5uLZ0wdUUKHRE9it0Sr2spexCGYliXGW1HPQ8u6YhtSIGu9hUyif7xoCFE
	xamupGgKGUvjx1+cnomK/VlXQ/r2iazPUnWB/NdlLS3f7oCBNIs121+vH5jztUvD66qR
	GbPg==
MIME-Version: 1.0
X-Received: by 10.202.78.72 with SMTP id c69mr10658119oib.130.1437687143778;
	Thu, 23 Jul 2015 14:32:23 -0700 (PDT)
Received: by 10.76.156.130 with HTTP; Thu, 23 Jul 2015 14:32:23 -0700 (PDT)
Date: Thu, 23 Jul 2015 17:32:23 -0400
Message-ID: <CAPphmgbXq_xx3_ZgFvSfoLDCD-J7r2gga+kcFsRw-ewpQp6W4w@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v3][0/2] Yocto Bug #6149
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
X-List-Received-Date: Thu, 23 Jul 2015 21:32:27 -0000
Content-Type: multipart/alternative; boundary=001a11c1622080ceec051b919f17

--001a11c1622080ceec051b919f17
Content-Type: text/plain; charset=UTF-8

These patches add code to handle a PREFERRED_PROVIDER for a runtime item.

The providers.py code chooses a recipe based on a runtime package to
resolve the multiple providers warning.

Then during package generation, the new image.bbclass code substitutes the
package into PACKAGE_INSTALL that RPROVIDES the runtime item if the
PREFERRED_PROVIDER is defined.

--001a11c1622080ceec051b919f17
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>These patches add code to handle a PREFERRED_PROVIDER=
 for a runtime item.<br><br>The providers.py code chooses a recipe based on=
 a runtime package to resolve the multiple providers warning.<br><br></div>=
Then during package generation, the new image.bbclass code substitutes the =
package into PACKAGE_INSTALL that RPROVIDES the runtime item if the PREFERR=
ED_PROVIDER is defined.<br><br></div>

--001a11c1622080ceec051b919f17--
