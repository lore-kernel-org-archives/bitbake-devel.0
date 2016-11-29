Return-Path: <sujith.h@gmail.com>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
	[209.85.220.196])
	by mail.openembedded.org (Postfix) with ESMTP id 434BB719F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 09:57:27 +0000 (UTC)
Received: by mail-qk0-f196.google.com with SMTP id y205so16799683qkb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 01:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=PHUPxptLAUF6j5ff3W+sy5C8ghQuuYyC0RvI3yoiZoI=;
	b=mZTKrKJoqHZ7yJQf83Z1XGulfG6AXqjRKuAPXcIuCHKzi0wVl2B1ej31n0zAdEYimy
	Mlt+BLtzzLY/g7zaDODIftjiOb2YzgMSJAAd2yQLHQKq15agUAe8jI/9epYMNDKN8esY
	eOC/dKU5ALk7lZsA1khTQGa4uXYUdfGmQB4AmFGVzHcIMhrStPhOB7cxg3Ej8LqZtu/a
	TT8SL1Msro/UCqEPIK2blVGEI/aljZlSQKF2s4BnKKwMS6VE0icGB477VVcbPRiDE4Tv
	mqP2+RrELG064hixp8Ec+PSW4AeQCjx+EK+AdSRzOmvsIfFfTyHcn2BCvTafNmPh4cjm
	V4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=PHUPxptLAUF6j5ff3W+sy5C8ghQuuYyC0RvI3yoiZoI=;
	b=fS3gmrEnncuE2gZHIgYgtgqhVqUcBooIG8lwYi8YcoYfNeX0llJq4IXw8WurHWWMZq
	F7QlLBuhDSqP9RIedraJaCJ0nxUgCyibU8mxXPElUP3y4hnFCYODdPgF1Xg1QD4I9iMP
	GGm2ZKXwhmtn/pghz0RLD8x/wV/RZvjpB84+tR0G4LCC+FrAp2w9BgTvS+EjtlR71Mr1
	G7/aLd0ojYomhN2WE02DqDkgoTjCRil+Mp7/99IJ2gqin1NoMKGfHMQZbMCoMzc3DKdL
	VMS3UOD7TuDMdDVPC0s2Jxkf8DayYbnc/ufr2Y/u5i0inm2JhZvBC+j/C6ox6hYxwLMo
	ddHQ==
X-Gm-Message-State: AKaTC00BJI+ASfmsYYOgyn3SbrvEq+0Navl8Ypp9BHFrpb7qsbu/5KgthkTEUWK8dyjGUg==
X-Received: by 10.55.128.3 with SMTP id b3mr22655447qkd.130.1480413449066;
	Tue, 29 Nov 2016 01:57:29 -0800 (PST)
Received: from kdekidd0.inp-wifi.mentorg.com ([139.181.35.34])
	by smtp.gmail.com with ESMTPSA id
	y194sm17164790qkb.8.2016.11.29.01.57.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 01:57:28 -0800 (PST)
From: Sujith Haridasan <sujith.h@gmail.com>
X-Google-Original-From: Sujith Haridasan <Sujith_Haridasan@mentor.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 15:27:21 +0530
Message-Id: <cover.1480412829.git.sujith.h@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] bitbake: cooker: convert type which needs to be marshalled
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
X-List-Received-Date: Tue, 29 Nov 2016 09:57:28 -0000

From: Sujith H <sujith.h@gmail.com>

While working on toaster, I found that when data returned from getAllKeysWithFlags 
was causing problem. So after debugging I found that one of the variable was having
a data type which couldn't be marshalled by xmlrpc. So this patch helps us
to make the data of type string.


The following changes since commit 71b7c3a88ec5a20d5e4531751d0bf23d5c94e494:

  Revert "classes/populate_sdk_ext: require uninative" (2016-11-28 15:49:15 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib sujith/xmlrpc-cooker-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=sujith/xmlrpc-cooker-fix

Sujith H (1):
  bitbake: cooker: convert type which needs to be marshalled

 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.1


