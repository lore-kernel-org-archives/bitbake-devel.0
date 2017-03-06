Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id D317D773E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Mar 2017 22:03:43 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id v190so7946343pfb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Mar 2017 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=YZuulJn2EN3gcbJ2iJ6/XHi2Yjlvcx2HEVAfFiX6K+I=;
	b=WuB3OLeoJAlqYWhKbL46jBOpFx3hSVoP8ws8Dxrw1t+2s7JiBMAnf1UKWqPGRK3vaL
	sL+EN1wfM0T8bfaarhfzQWBd4oT/yGn/iV9yfafoH5rOateRhBBEWO6b60sBFJKNB4uL
	hkxhyRgMkS/Qmp1NFeb23LYXQ7icXSVzXTfvqfxw+9HdORhPZrlO1oxYeIv5tmrEtOiD
	COYP+l+M7vzWT1i8mSkeEeCXqnH+w7ksq01OmeaNF3Aos8F4lEbcZw2StnWETk4f+pso
	6Izp9AkMSWjY8DiaaWDDkfKEEMDiMCKP10EIz8oimDhAB/PSOPhQlZsJp7OJaozFsvpv
	YpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=YZuulJn2EN3gcbJ2iJ6/XHi2Yjlvcx2HEVAfFiX6K+I=;
	b=gx8v62Crl8Qt2ARU9vHR+1PXYgFdETd3gSnakcdjr0DgvArt60WlPaIzH3A2F1LNBz
	MtgQs3I1oUYPbthfZz9zj6D6vxSUqutJQVbWpBhOMQ2R1KrwzFGbTn+3m45ed63gMAO4
	4aK5kQBJoEAKgeJhP7JPPMCMJGcPRoOl43Y4zzglbmhwxNvjayRy6x74oTR4UsNFJ6uR
	2TKibuw/gx/pCUMQgIXO9GF5MwXEWj42rdUMap2AyO81ES4GRfXHwm/+k7NgpnlGjZGO
	JUWlxFEB5QpvyH2XNj5cmmUbwKFLEoLLFBwXCK5XK/HfQeaGOxq+k+gZaJDbPE6TkMmG
	o9CA==
X-Gm-Message-State: AMke39lJ6C8Qb25hMNby6f0+2GmAjvQaGTTrBV25Jz1D18KziZoE5WAJILBVIB47T3ubvA==
X-Received: by 10.99.158.2 with SMTP id s2mr23451548pgd.116.1488837824617;
	Mon, 06 Mar 2017 14:03:44 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	n189sm41375332pfn.108.2017.03.06.14.03.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 06 Mar 2017 14:03:44 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Mar 2017 14:04:59 -0800
Message-Id: <cover.1488837822.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: resolve missing native[sdk]: prefixes
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
X-List-Received-Date: Mon, 06 Mar 2017 22:03:44 -0000


Some task events are missing the 'virtual:native[sdk]:' prefixes.
The Toaster has code to help match missing prefixes, but needs
additional help resolving between 'native:' and 'nativesdk:', by
way of the '_package' event field.

[YOCTO #10849]

-brian

The following changes since commit 4188e53f803aefdb26768abfad591283662cd27e:

  poky: make 4.10 the qemu* default (2017-03-04 23:19:03 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/toaster/submit/resolve-missing-native-sdk-prefixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/toaster/submit/resolve-missing-native-sdk-prefixes

David Reyna (1):
  toaster: resolve missing 'native[sdk]:' prefixes

 lib/bb/ui/buildinfohelper.py | 8 ++++++++
 1 file changed, 8 insertions(+)

--
1.9.1

