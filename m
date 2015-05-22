Return-Path: <twoerner@gmail.com>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
	[209.85.213.172])
	by mail.openembedded.org (Postfix) with ESMTP id 53D2E609B2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 May 2015 21:57:47 +0000 (UTC)
Received: by igbpi8 with SMTP id pi8so743277igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 May 2015 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=WJrnRhRzBeMcuAZ5NVxS0E47Jw/RTXVqBpupSz6khHs=;
	b=YYOe25tzUXTJDQ88FhJ1D31SwqhaeCijy/T7hoaaUUleQhE+hMiJ69Rr5CPNNPKtU0
	euygC7JKdyqTYoDrVtKWPmZm1zC6lIdfubqVTR7j5vuvB1ROkeTq4RA/oTtuvYya7awB
	P9OY05qETkLzC8UZsl19l0Aa7gBityTt949HZpuOdSzLeS3L+0ZIZxxPfZCjprMHpapj
	mlLJmoqB/UAZlKvoIpXWyCASqPghKi4J+2NzHvyARj0UpWCtYD6Dcd8QQr3S4n982NDm
	YRU1u8P0M9kOFbsZXYJbGyOvcmWKPM0IHRC7V0UrGIevOAyHN7sOgrQq3M9Hvq9IUOzZ
	b7Pw==
X-Received: by 10.43.167.137 with SMTP id ne9mr11678881icc.7.1432331868966;
	Fri, 22 May 2015 14:57:48 -0700 (PDT)
Received: from [192.168.141.85] (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by mx.google.com with ESMTPSA id b2sm92432igf.10.2015.05.22.14.57.48
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 May 2015 14:57:48 -0700 (PDT)
Message-ID: <555FA65A.1020505@gmail.com>
Date: Fri, 22 May 2015 17:57:46 -0400
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: bitbake-layers layerindex-fetch
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
X-List-Received-Date: Fri, 22 May 2015 21:57:49 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I'm curious to know what heuristic "bitbake-layers layerindex-fetch"
uses to determine where to place the fetched layers?

I asked my system to:

  $ bitbake-layers layerindex-fetch meta-qt5

and it keeps insisting on installing meta-qt5 and meta-openembedded
under my openembedded-core layers resulting in:

  /z/master/layers/openembedded-core/meta-openembedded/meta-ruby \
  /z/master/layers/openembedded-core/meta-qt5 \

Is there a way that I can tell bitbake-layers that my layers are located
at /z/master/layers and have it work from there?

