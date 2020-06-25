Received: from mail.cvg.de (mail.cvg.de [193.158.56.148])
 by mx.groups.io with SMTP id smtpd.web11.10842.1593092568955169000
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2020 06:42:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=McnI2aUx;
 spf=pass (domain: sigma-chemnitz.de, ip: 193.158.56.148, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-0.intern.sigma-chemnitz.de (mail-mta-0.intern.sigma-chemnitz.de [192.168.12.76])
	by mailout-1.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05PDgjPr029527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2020 15:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1593092566;
	bh=ksRz3kWY1MK6bW6uzDnITkCryRIZ/+jtiMGUshKSXsc=; l=1117;
	h=From:To:Subject:Date;
	b=McnI2aUxA/sEbGNinUCegqWtBeFx5PawXi2SEqSVxQjoE+OuQF3VJwan695Yhh/ke
	 KwfqN7Y7ak6pyKjXDMNgHn1a/4kpLiwK4709ue1jGJHDeWvtQxT+AndvefdyEtwqnt
	 4tIMfZVE4lJPBqE/xDm+KZQ2BxMdkklZf/esjI8c=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05PDghqk022270
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Thu, 25 Jun 2020 15:42:43 +0200
Received: from mail-msa-0.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 8869E857AE8; Thu, 25 Jun 2020 15:42:42 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05PDggY2022267
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org> from ensc@sigma-chemnitz.de; Thu, 25 Jun 2020 15:42:42 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.93)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1joS9K-00Aotf-8p
	for bitbake-devel@lists.openembedded.org; Thu, 25 Jun 2020 15:42:42 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Subject: Support for git+https://foo.example.com like URIs
Date: Thu, 25 Jun 2020 15:42:42 +0200
Message-ID: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

Hello,

for some years we are using a mechanism which allows to encode the
protocol ("https", "file", ...) within the base uri.  So, we can write


| PROJECT_BASE_URI = "git+https://foo.example.com/project"
| SRC_URI = "${PROJECT_BASE_URI}/some-repo"

instead of

| PROJECT_BASE_URI = "git://foo.example.com/project"
| PROJECT_BASE_PROTOCOL = "https"
| SRC_URI = "${PROJECT_BASE_URI}/some-repo;protocol=${PROJECT_BASE_PROTOCOL}"


Four years ago I wrote a bug report [1] with a patch against bitbake
itself which was more or less rejected.

In the meantime, I moved this out in an OE class [2] which overrides
'bb.fetch.decodeurl'.


Is there some generic interest in this functionality so that I can
create and send a patch for bitbake?  Or is this too special and people
are happy with altering ${MIRROR}?



Enrico

Footnotes: 
[1]  https://bugzilla.yoctoproject.org/show_bug.cgi?id=9738

[2]  https://github.com/sigma-embedded/meta-de.sigma-chemnitz/blob/zeus/classes/elito-uridecode.bbclass
     https://github.com/sigma-embedded/meta-de.sigma-chemnitz/blob/zeus/lib/elito/__init__.py
