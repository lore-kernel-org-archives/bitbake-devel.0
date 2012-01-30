Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <aleh.arol@gmail.com>) id 1RrtSp-0006PU-Vc
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jan 2012 16:48:16 +0100
Received: by bkaq10 with SMTP id q10so3404171bka.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Jan 2012 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=XuUn90wreob4P+ZnK2LHIap/HswM3D2wJZ4ZGmWj2lk=;
	b=xh2d6BUxTWcR7PSlD5S2r3p2P2KjFhltVp+oj/SEBKzFFP+YZ+jsM0EqXKjQZ71DYw
	ZA/QzjvNml/XaWVJRD6j1z2eqntTb9oR/AZt3higOsugeoJT86N8Uye0xQpk+AuTl4c8
	97S3d7cma/k2Ym67ZGhD9AIwPZztF21/ocy4M=
Received: by 10.204.128.202 with SMTP id l10mr7797693bks.116.1327938022144;
	Mon, 30 Jan 2012 07:40:22 -0800 (PST)
Received: from [10.6.18.150] ([86.57.255.94]) by mx.google.com with ESMTPS id
	fg16sm38291930bkb.16.2012.01.30.07.40.20
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 30 Jan 2012 07:40:21 -0800 (PST)
Message-ID: <4F26B9D3.9010709@gmail.com>
Date: Mon, 30 Jan 2012 18:40:03 +0300
From: Aleh Arol <aleh.arol@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:9.0) Gecko/20111222 Thunderbird/9.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Wed, 01 Feb 2012 16:21:22 +0100
Subject: source folder package dependency
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
X-List-Received-Date: Mon, 30 Jan 2012 15:48:16 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have a question I don't know how to solve:
I have a library, for example, boost, and a part of that
library(packaged together I mean), like bjam is required to build it.

So I have boost-X.Y.Z.bb recipe and src/boost-X.Y.Z folder(I have
sources locally) and I need to create bjam recipe. I can make
bjam-X.Y.Z.bb where I will refer to folder src/boost-${PV} as ${SRC_URI}
and ${S} to find jam sources under. Then if I'll need to have 5
different versions of boost I'll need to create 5 different versions of
bjam recipe.... although I can use bjam.inc it will still be 5 bjam recipes.

How can I avoid that? Any way to have a version agnostic bjam recipe? Or the right way of doing this.

-- 
Best regards,
Aleh Arol



