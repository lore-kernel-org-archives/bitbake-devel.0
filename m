Return-Path: <soemoe.a@gmail.com>
Received: from mail-pl0-f43.google.com (mail-pl0-f43.google.com
	[209.85.160.43])
	by mail.openembedded.org (Postfix) with ESMTP id A71726FFA1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2018 21:16:14 +0000 (UTC)
Received: by mail-pl0-f43.google.com with SMTP id 91-v6so207725pld.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2018 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=tDbyGRH1gv/TyNMWMkkaDsjt7/mOKO5ZnuEX7L7lp7Y=;
	b=KOcnWG6KUDsxhvDzWvoQ2GsmlwZAydf4SorvZy9q6h38meRipXLtWlxSknqcLgO230
	dMfRirWE+/s1tjxN0ZkVNHXjWDcfC30W/hU3eDucPFo2VyIgh/0XwW3XF8klixFJGflZ
	gQWQfIV/XKIcrCkkinsbajc84V1St7T0SLBMJ2w4T9C7MeGSuzkm4rM9hIcMS6VLIWyK
	S+vygISjUI5csIzO4LeHe92/SIqRWJ1/6svV/l1j9z1s0XorJGnzvBO3vn/2FLLJJSzR
	9FpEJP8BGJoRI4ZPD5J1cC3d9gj5St+9GyW4sfKP47mAJ5RECQ+wYgW6xYOjPac++57C
	ky2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=tDbyGRH1gv/TyNMWMkkaDsjt7/mOKO5ZnuEX7L7lp7Y=;
	b=Vd0kfqVudM7P1yw9JSMrvHJpQegkrM+xBIrAb5kw+GfuN+V3+RgHtIOp+K4CiqpGaT
	HZXZWi3rx+fKb/gJLPxtw51iowdUR0ZHXnyMPy0GRKotBzDCPfkYaKVLqhyXcbgZAysk
	0GZp0WNw73h852pP9IQ7C4PWZOWsR/pIhMX56dV7UV0/9k9NsQXCPm6pYG4beB+JijMt
	7T+0Dl6xEH8MEVi5CrsD++ZdWQKjly9cv9J4eYdkWtek+keaNBNni/6iSSqB++edMryN
	nO/Zvpg+1AHxPh4s49NnndZWffV0Ft0egWMQWddhrT965Ew0sCucIHFKF+ELa4FZy2mX
	rSFQ==
X-Gm-Message-State: AElRT7FzV8dOOm+AO10TMveaZvOrW/kjYRUNcXfviNBOSWEe6eY+zP9o
	rosr2F42c4NqyYvv4FEWwIE1Z4bf
X-Google-Smtp-Source: AIpwx4+BfkCYSPnTWXNk5KI2w34SvRD5HSmISZvxm6fdopE4ocryH5NgyvwB/MIhqDYubmh8BDIpCQ==
X-Received: by 2002:a17:902:9a8f:: with SMTP id
	w15-v6mr894712plp.103.1522185375079; 
	Tue, 27 Mar 2018 14:16:15 -0700 (PDT)
Received: from saung2.mtv.corp.google.com
	([2620:0:1000:1b12:c339:a1c5:5655:debf])
	by smtp.gmail.com with ESMTPSA id
	c189sm5204385pfg.72.2018.03.27.14.16.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Mar 2018 14:16:14 -0700 (PDT)
From: Soemoe Aung <soemoe.a@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Mar 2018 14:15:57 -0700
Message-Id: <cover.1522085586.git.soemoe.a@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
Subject: [PULL] *** Fix build issue with html5lib in bitbake 1.26/1.28 ***
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
X-List-Received-Date: Tue, 27 Mar 2018 21:16:14 -0000

When I was running yocto-poky on the fido and jethro branches, I was getting build errors caused by the included html5lib in bitbake. It seems like a class is being called incorrectly there. I noticed the issue is resolved in the krogoth branch and the html5lib is indeed different there.

yocto-poky fido includes bitbake version 1.26 and jethro includes bitbake version 1.28. Looking at the bitbake source repo for these versions confirms that these files are the same. yocto-poky krogoth, which has the issue fixed, uses bitbake 1.30, which also has the issue fixed in the bitbake repo.

I originally created this patch in the yocto-poky contrib repo and was directed to send it to bitbake instead. Can someone here take a look at this and accept the changes into the 1.26 and 1.28 branches? Can you also send these changes upstream to the yocto-poky fido and jethro branches?
 
Let me know if you need any changes here, like creating this patch from the bitbake repo directly instead of indirectly through yocto-poky.

The following changes since commit ea6d21066a7cce2fef08ad66287170c5995bb1e2:

  bitbake: bitbake-user-manual: Fixed porno hack for hello world example (2018-01-17 22:32:46 +0000)

are available in the Git repository at:

  git://push.yoctoproject.org/poky-contrib saung/bitbake-html5lib

Soemoe Aung (2):
  fix build error in included html5lib in bitbake
  fix html5lib fix to be the same as in the krogoth branch

 bitbake/lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.17.0.rc0.231.g781580f067-goog


