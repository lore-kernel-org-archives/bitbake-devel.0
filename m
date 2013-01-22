Received: from mail-da0-f48.google.com ([209.85.210.48])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <trungiee@gmail.com>) id 1TxXQs-0002Ji-FP
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 07:34:07 +0100
Received: by mail-da0-f48.google.com with SMTP id k18so3071850dae.35
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 22:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:content-type:content-transfer-encoding:subject
	:message-id:date:to:mime-version:x-mailer;
	bh=Ftra8M1E2K1ZMiy5WmAokeB00VC5wKIzuv2IDpxbYZI=;
	b=k/my5DF+mPT/27S+1WVOOPePtl8x8LfWkwX36S7cwsbgID+Dj/YSSlvEAg5mmj77eb
	iNMKpHj+zpdrK5jYM6KgZGf56tEsf6uHG2C8mUY7MPEX9gEf86ZbQXRMN/ZO8ZN98UDF
	IIeoXFoz5v9DInuY49r9KGMiwBPo/LYr5Ggn4nBKn2EoplIlcR1dAEHzrZpodtzQbYR4
	zR9whfnqGNgaz1+ymPA3c0/OUo7NnR6ghU16FzwemMIdHwgew9t9vW+IHZX2z188kRYg
	r1ENZPBewL6AnQSIvf1joPNNSCCYjVfEYu8+/mlOA7lfmY0/2p4FSjIaYvSof0dHGwYr
	uiBw==
X-Received: by 10.66.76.41 with SMTP id h9mr53663169paw.1.1358835514476;
	Mon, 21 Jan 2013 22:18:34 -0800 (PST)
Received: from [192.168.0.26] (CPE-60-225-117-182.hhui4.ken.bigpond.net.au.
	[60.225.117.182])
	by mx.google.com with ESMTPS id oi3sm10129580pbb.1.2013.01.21.22.18.31
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 21 Jan 2013 22:18:33 -0800 (PST)
From: Trung Hoang <trungiee@gmail.com>
Message-Id: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
Date: Tue, 22 Jan 2013 17:20:13 +1100
To: bitbake-devel@lists.openembedded.org
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
X-Mailer: Apple Mail (2.1499)
Subject: Display mode
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
X-List-Received-Date: Tue, 22 Jan 2013 06:34:08 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

The current git HEAD of bit bake nicely displays the x threads and what =
is happening on them instead of constantly scrolling in detail what is =
exactly happening.=20

Is this feature configurable? How do i enable it on older versions of =
bitbake? As the gumstix setup scripts check out a older version of bit =
bake and it displays reams and reams of info.




