Return-Path: <mhalstead@linuxfoundation.org>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id B0915731E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 17:47:17 +0000 (UTC)
Received: by mail-pf0-f171.google.com with SMTP id i123so52472139pfg.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=to:from:subject:cc:message-id:date:user-agent:mime-version
	:content-transfer-encoding;
	bh=+X6O1zGSio43Wm2gSwb6lHeU0Z8ZARXFUmUJsdW4cMg=;
	b=iNrknTAkyOZmU4n8Ol8UgWtMuMiESxt34ANs/8MLlfllJu8vyJK7BVObju+whtppai
	xDsh2BBhNRo73EjC0HJ9K3hKf6kz8myYjSfY5jDCDksamIUCJdkn0Q2hU531tLsiJ2jm
	SIlNRyLZ/2CnRxuKXO7oTIXeiJYyHsv7PHJ2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
	:mime-version:content-transfer-encoding;
	bh=+X6O1zGSio43Wm2gSwb6lHeU0Z8ZARXFUmUJsdW4cMg=;
	b=L/7CMb2tQMFaIGdf5rKRpdUMOsXTgaOwKT6JvN4qrRMMEr1GSDey8S1rQptpZsQm1x
	WMw6sbMHJ7NQcCLXUYtchmgkWJCDv9POtOMHZMMEKwA+6hbaU482Fb9tQGongzCGCGXZ
	+FxhpjW/Eb1KHETyJ9AF8DK8+BFQxLsQgd0ozffJEwAU7VTYRD5+aX9AA0EdbKU9j3RM
	mi6puyoD601SU3X/XwIAUbzVNeF/aB1ZzaLhyH98QidVT5ubBuMEuELL93yBYz1iW3XB
	IM1wNQN2e7jjIP02Jcgltwd7vcXMZBBJpAFVNpht6hwX4hP3bS+wFjMdy6qNW5QY/9Wn
	fN4w==
X-Gm-Message-State: ALyK8tLqZQpjNdYB1DdK/ZaAk1FHAmBfOoytueDLQU+UFX0QF35LKPn1HAbI5/k1I/5ytbh4
X-Received: by 10.98.93.65 with SMTP id r62mr22693252pfb.114.1466444837911;
	Mon, 20 Jun 2016 10:47:17 -0700 (PDT)
Received: from yct-desktop.lan ([2001:470:b:16e:222:4dff:fe50:c906])
	by smtp.gmail.com with ESMTPSA id da2sm6863331pad.3.2016.06.20.10.47.16
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 20 Jun 2016 10:47:16 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org,
	Openembedded-core@lists.openembedded.org,
	Openembedded-devel@lists.openembedded.org, yocto@yoctoproject.org
From: Michael Halstead <mhalstead@linuxfoundation.org>
Message-ID: <13986bd3-af12-4768-0a4c-78447c33c8b6@linuxfoundation.org>
Date: Mon, 20 Jun 2016 10:47:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.1.1
MIME-Version: 1.0
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>, Tom King <ka6sox@gmail.com>,
	"Perez Carranza, Jose" <jose.perez.carranza@intel.com>
Subject: Patchwork users: Help test new version
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
X-List-Received-Date: Mon, 20 Jun 2016 17:47:19 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

OpenEmbedded is nearly ready to upgrade to a new version of Patchwork.
The new version offers several new features that will allow OpenEmbedded
to improve developer workflow and automated checks on incoming patches.

If you are a Patchwork user please visit
https://patchwork-next.openembedded.org/ and take a look. If you find
anything amiss please e-mail me directly and include patchwork in the
subject line.

Thank you for your help upgrading this important system!

-- 
Michael Halstead
Linux Foundation / SysAdmin

