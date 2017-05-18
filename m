Return-Path: <andy.voltz@timesys.com>
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com
	[209.85.216.175])
	by mail.openembedded.org (Postfix) with ESMTP id E3FB57805C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 16:09:13 +0000 (UTC)
Received: by mail-qt0-f175.google.com with SMTP id f55so37957688qta.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=timesys-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=dzoR7Zj7E3Z6yobXN+aKTaJ2z3QFUelhKeCcS2py/FY=;
	b=r8JvukGknlMDd4ImcpF2BkOESATddAeWgxZqh1dV9BrotJea0ieNGLrGmGXC1PnR8C
	kgAO0CFCUYQOu0iR2Ccj/uNcsmBz562yk7saCvSaRz7WrsRQI+4ZI42sE9YV0YY+KRxD
	vE52pHbn4Iywk/ILLUR0tom3d5dfCqe0/aNFA4cWk3ez8YNCif9FT3Z+3SzDmBSPjdV+
	OVF9ZRH1m/BAA0kJRnsKo4kZmmsrDH84waEUV6/LgWfFB/hIHQyzSeWwvHcAG7ncSfQ2
	x4lKviTQSx0dF0wJZhAPXjwPGrSk6GJm9x0AVPOld4EaTGpC7WPZz/EOT/nMGV4ehrbT
	zByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=dzoR7Zj7E3Z6yobXN+aKTaJ2z3QFUelhKeCcS2py/FY=;
	b=JAznPgEQ1BbJbaSSoI2/5i0UHypVUeqG6TRRFNgevAkzQFCB2ge2Q9185sgI2pWGDk
	BBqLlMradv74VV+wghcBENZh5fqb8b8xcOknXtFEmmtRaG+brEAUoDWiB59js2lDBViY
	w//hecbG8mrtEpfSqC8aCh+DJTeFE8fN3BizIlUIoKjyQ4LR8nW+EY33WKLPy0m3WsTN
	aon+C8K2rzlHdd1aNZkJUjy1MZE1FYfJhs+0vsqS/AuQLZv7DicZCYPPDbhPK5YF0rM+
	WscPpQg13aDb8zekRuevuMIoi4mn+IlvoHfXDQLG3dRAAt/IzrtcQ3fT6SSKE71L7r6S
	M+og==
X-Gm-Message-State: AODbwcBqgSgIpfrNdBnMmqWyi8qPKtDfEE65cordYZBr2WdUFRon8/vZ
	d86RLquLj/MAoJBMjQw=
X-Received: by 10.237.42.5 with SMTP id c5mr4803326qtd.284.1495123754488;
	Thu, 18 May 2017 09:09:14 -0700 (PDT)
Received: from smarf.timesys.com
	(96-94-100-129-static.hfc.comcastbusiness.net. [96.94.100.129])
	by smtp.gmail.com with ESMTPSA id
	d200sm3917151qkg.50.2017.05.18.09.09.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 May 2017 09:09:13 -0700 (PDT)
From: Andy Voltz <andy.voltz@timesys.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 May 2017 12:09:09 -0400
Message-Id: <1495123751-14886-1-git-send-email-andy.voltz@timesys.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/2] Fix NameError in generatePkgDepTreeData
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
X-List-Received-Date: Thu, 18 May 2017 16:09:14 -0000

As part of the multi-config changes it looks like the wrong loop variable is
used which causes a NameError. The rdepends loop which follows is correct,
so the fix mimics that.

The first patch is needed to run this script which demonstrates the issue:
https://gist.github.com/avoltz/e28fb3d6d9980f2d8c073e0d146cbc69

I run that script from bitbake/bin with and without the 2nd patch for testing.

The second patch fixes:

File "../poky/bitbake/lib/bb/cooker.py", line 910, in generatePkgDepTreeData
    if dep in taskdata[mc].build_targets and taskdata[mc].build_targets[dep]:
NameError: name 'dep' is not defined

I'm not sure if the first patch is the best method to enable HOB caches, but
it helps with the test case..



