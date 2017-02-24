Return-Path: <anders@chargestorm.se>
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
	[209.85.215.41])
	by mail.openembedded.org (Postfix) with ESMTP id 3D2E377511
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 20:52:51 +0000 (UTC)
Received: by mail-lf0-f41.google.com with SMTP id z127so13680787lfa.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=chargestorm-se.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=TTfDT/tWc/1qTmFPrAY+KY8DPGlReC/oev28L/0jFko=;
	b=FXZANQil1TnSNeFVwZoE7dj2VlmHzChKQjPg/7EnJ/Q4MUqoV+ve72pV0V8fPyDKuv
	Spk/QHhzinEHFC/4Y0ZJaRVRboqjhXraaRdnCn1JPgtpYejoZ02SEn18niEPYUfGbXAJ
	TNbXx4Kp4KVIWeI5NopWSIx5BY4OdQYp92ZstA8/ThVBtsX4RFzy8+NDaWCJ+rxDP6Rw
	KcxrhR3Fk5tjAGI6k235XbNxHR2ijDxrTB13VggZue/3zq5z/Tdvp+gBvpTiZhYnMWWu
	UglJ6PYJYaNPfY4spDdVhtZ6SS2wAQ3YyOwjYYaG5C+62b/wmuQoyhdFKXZ2NrFHonvk
	iZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=TTfDT/tWc/1qTmFPrAY+KY8DPGlReC/oev28L/0jFko=;
	b=Upo+PmAEVHnCgh24uXnAX+FREEWREMH8DxTeF759uutwQWlFY4fLYxN71IcIYQ+aD9
	RDGiKPpOp+8IlL3QmAb2Nb4l8m6S1Ws6Zzfad3Bo+W65gr0LGzY0sWGFdx9Rjs+ShIp+
	j16X85ZzUbQTEucj8eR7Kk4tGvT0EfgblZG5/HEYKcGFvJLd5ZLWjYP3Ji9yJLnTcK7E
	BZOAZZXl/zwbVgUuNLLOKHFQ8NrUr0/E9NitEl4qsZpzA1eHtPSz9cdd/2PYehjUPWvt
	c6iOq3mde8fW7VkjdA6zq0eqoEq38WtnqSIH3efCGIW6Z2sm/rSsWkORAyq4bQSx1KwY
	0fUw==
X-Gm-Message-State: AMke39kUvHKJvshfYbQnwAxJ7VsSw1cgWLwTeoyIRIjg6uUVtDslRFk7ZiRFUJnvMKh2Sg==
X-Received: by 10.46.5.70 with SMTP id 67mr1275335ljf.100.1487969572756;
	Fri, 24 Feb 2017 12:52:52 -0800 (PST)
Received: from localhost (h83-209-191-235.cust.se.alltele.net.
	[83.209.191.235])
	by smtp.gmail.com with ESMTPSA id h13sm2249116ljh.5.2017.02.24.12.52.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 Feb 2017 12:52:51 -0800 (PST)
From: Anders Darander <anders@chargestorm.se>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2017 21:52:16 +0100
Message-Id: <cover.1487969243.git.anders@chargestorm.se>
X-Mailer: git-send-email 2.11.0
Cc: Anders Darander <anders@chargestorm.se>
Subject: [PATCH 0/2] Handle angular2 package names in bitbake
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
X-List-Received-Date: Fri, 24 Feb 2017 20:52:52 -0000

When trying to build a webapp using angular2, some issued with angular2's
npm package names were found. This series fixes the bitbake issues, one or 
more late pull-request to oe-core will look into that side.

The following changes since commit 5b364b02270b0d7c2b7ca8d67fa2731bf93720ee:

  fetch2/svn: change 'rsh' parameter to 'ssh' (2017-02-19 08:29:43 -0800)

are available in the git repository at:

  git://github.com/darander/bitbake npm
  https://github.com/darander/bitbake/tree/npm

Anders Darander (2):
  fetch2/__init__: handle @ in package names
  lib/bb/fetch2: rewrite / to - in package names

 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/npm.py      | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.10.2


