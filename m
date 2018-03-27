Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com
	[209.85.214.43])
	by mail.openembedded.org (Postfix) with ESMTP id D5B4F7855C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2018 18:35:31 +0000 (UTC)
Received: by mail-it0-f43.google.com with SMTP id p67-v6so450676itc.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2018 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=pU3a0+jdnWgCRjk810OQ3Cswpo5G/z5S6Rpweb6leoQ=;
	b=FlSTc5DzEy915UFBFWsGHYUd2LzoKjaS0hBT+fNj+0zr4gaDIA+oQMaoGCIUOVpY5U
	JsmvHEdA7Yd0vTcnQyqteQQYZey0YCpLd1CTeAhO2oaTQdlXDflSfTGyLoJCfIMZswzm
	Uixj+AvwisPwxHXWbYGK72d+t05DRCyqSJYryeNgEL05PKfqw9Q5uEs8YHehiuvWAI6F
	AouWV4H1F73fdWo8Rb4fbXxAJhaSI37xRlPdfZwtgoHCOmdkjjiRwrz2NiLdZ6PGnsuo
	8xSwFkCczXd8SIy9YcLh9evC7JohFWKdjOSOm+7fFmCOuvIj4sHlswcD3hVqgurZJqh7
	tZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=pU3a0+jdnWgCRjk810OQ3Cswpo5G/z5S6Rpweb6leoQ=;
	b=FthDOyTMPdXkw1oe9k8hVtwo0xA3DXTTSGQ0oh6/FWdx0ueGpVEb4gnx8OtV3eqBt9
	mf5tDiCuMuKIiM5sPqLRaly1fMeFxyF3u09vNKdzsaOUXYCFvjG3y046qGau1eS/9wnD
	UyLzuZAGLlJDMaqkb4K++etZ/EXVNRQF2v74Vn/7DitkNMDso7cJCuNRuB6hHVGngip7
	QaF3eK4bFzT9Bjy+h9FmTAGMzgeAOoUVjHpO5U1PglkGiHyomu9fj1VYIFyiowiZElTS
	z/oY6UCx9ILR0tb22D90H4HgGenjxl81DJ8O/tgaqWBxVHlZ28++/KAVs6C2qvpVOrgv
	N/yA==
X-Gm-Message-State: ALQs6tCMGBUaHJGmqghxb05wK8hXSelaPSGM8SM/sRW3MKdnO5k2w/1R
	lRRt8AR/VL2dp2Q+HupZ0qni3BQ6
X-Google-Smtp-Source: AIpwx4+UbrGEKQNT3etqemeJAUbZnbiM2sYM+A0XR+KSiCotyGCp5vY3p5bUQQwMxhmwiABz2cfJRA==
X-Received: by 2002:a24:3d4f:: with SMTP id
	n76-v6mr371738itn.147.1522175732846; 
	Tue, 27 Mar 2018 11:35:32 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	p142-v6sm1465070itb.24.2018.03.27.11.35.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 27 Mar 2018 11:35:32 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Mar 2018 13:34:26 -0500
Message-Id: <20180327183427.13983-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.14.3
Subject: [RFC] Respect force flag in runall and runonly
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
X-List-Received-Date: Tue, 27 Mar 2018 18:35:32 -0000

Implements the ability to run bitbake commands like:

 $ bitbake -f --runall fetch core-image-mimimal
 $ bitbake -f --runonly fetch core-image-minimal

which will invalidate the stamps for all affected tasks forcing them to
run even if they have already.

I've found this useful in a few circumstances. Most recently, I was
attempting to do A/B performance comparison of so package QA checks, so
it was pretty easy to figure out the impact of various QA checks with:

 $ time bitbake -f --runall package_qa core-image-minimal

Additionally, I currently do a number of actions like this (because we
don't have runall):

 $ bitbake -g <image>
 $ xargs -a pn-buildlist bitbake -f -c <action>

And I would like to replace them with

 $ bitbake -f --runall <action> <image>

Is this something that is even necessary/wanted?


