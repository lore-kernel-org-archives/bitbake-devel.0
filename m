Return-Path: <armccurdy@gmail.com>
Received: from mail-ob0-f196.google.com (mail-ob0-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id BA20876EBF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Jan 2016 00:43:35 +0000 (UTC)
Received: by mail-ob0-f196.google.com with SMTP id x5so1450162obg.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 16:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=UN9AWxExJkF2iy5U/diZZ5gLk1HMV9IHK9YHFBvf8ao=;
	b=zUFXaAkyUb4cDskvh9nNh6XecIBWiZXSGVgQQxckcWdUTnr71Yz8G/H2tu/evZUsaU
	RQ2ScCLB24hsr1tk9BxzXRvo6h1+49dPVuQsyIUeSIpblWmacfILPX9EmkuegQFxCdLq
	y5nefAnHEh/pnYwNcfbOfq3Y4b4Kj6gz5Lx+b2Il1UXINl2vmschAZDG7DvlUH291KmU
	IuiNiOpRi67qIOSPHCXsiv7AnIXQp3anC8b8ziS9KhAMT7wLhoqjMSVr5SSEMljkIpZ5
	UUtDWp87jVUmC277KkRNZ9Y58pNVcXZBwTkzEGpWAZCO+geWALsH/w0cSRx8d3Od1izf
	Uukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=UN9AWxExJkF2iy5U/diZZ5gLk1HMV9IHK9YHFBvf8ao=;
	b=OAgXt7oYL3nWnbDqu4CnxL6GQnrrEZ5wuzLeBtfAnlsdOmLdm5NUAyJlJj5vb60wzX
	IjsvVj3M6MttIw7tiyGoaZJG0I6dMx+A2xkrHXvevxny+u3nyEOGLAoFo7/JWdT6vWTh
	Yce2GobTiuE9RbgYmH3Oy3TFbxQWhaZTmWYrqxu3vdGNVbv0OnKMAJwJWXaebw+06zNl
	yG1UyjK9Ev9W1LC4LXBRMXm1SBxRFF/Ybt4wDYzK/GyzzPS8xsK/ndfHIvCpChOWQ1hU
	sh1H07OACvqYl47WnGvIm7IMSxe4SI+qjH7nVUMq75YlVk9wQQOcdXqqLUP4Y6bYyfN2
	oaqQ==
X-Gm-Message-State: AG10YOReUV8pdChQj9yqzgb5tWsshxcWxht0SwqJ1qRAMLVKNDuVlkbVlr7oGM1DF1EDtA==
X-Received: by 10.182.16.233 with SMTP id j9mr130485obd.9.1453941816181;
	Wed, 27 Jan 2016 16:43:36 -0800 (PST)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by smtp.gmail.com with ESMTPSA id h1sm4274956oek.11.2016.01.27.16.43.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 27 Jan 2016 16:43:35 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Jan 2016 16:43:15 -0800
Message-Id: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/3] improve formatting of OE run.do_configure etc scripts
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
X-List-Received-Date: Thu, 28 Jan 2016 00:43:37 -0000

Andre McCurdy (3):
  build.py: minor shell_trap_code() formatting tweaks
  data.py: avoid double newlines at the end of functions in emit_var()
  data.py: sort variables being output by emit_func()

 lib/bb/build.py | 5 ++---
 lib/bb/data.py  | 9 ++++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
1.9.1


