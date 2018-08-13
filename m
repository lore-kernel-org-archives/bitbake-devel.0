Return-Path: <schnitzeltony@gmail.com>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0A89178FA2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 21:04:55 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id h15-v6so15422787wrs.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=N2yUaoXFpJDrIm4o5Kyvpi2U1pBjdy8yyg7b++ZbwJM=;
	b=poIa5DnqBJWa5R0qprOR+wpLr129pOlXjC+2VthKD/cCNsMJAd9XrD4vtbeK6tn9SQ
	qRBMGScydqVgKpRPVYUDAM+GjDNbs7gEgG81AA8Cid+EJj0sCrVFOsMuewBWxf7kErSZ
	Mat/jX1CoTEaqgn7bP6TCARdJfBh8F4mUwJL2gZBJLGUYmPaGIvf6iSC24w9abhjiXmE
	kNEeV0tA65gy6VndYUgW+r0PJ5jOEcuWGffV9q3z5bUNzKiGuy78Tc7LyFn5nxgC9ODs
	T+Spdnow+h5u9x8nVNroRDzFSotEAXY8hDxhgzKmiOGoPSsl+7g+OEyz3ZjuMj9kZyU7
	/luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=N2yUaoXFpJDrIm4o5Kyvpi2U1pBjdy8yyg7b++ZbwJM=;
	b=hT03zjVP8rRBHNzUVETXCzbEQsFqCdep8R3hCzJaiv4SDggAvYVCP5C7W8ZLTI6sTV
	JqAtvxEnr+A0xISfqVMSBI6FWQRrrk7gRQiV05bGpN/e3DW1bWZnqrGJTYjyPEr9VrS1
	nxqe3eRUZ0tRePfxLptRmdjsiu+7L9HXgubIH2gLTkz9v8G91W2ZsF3jjeyaa7NBJ7vV
	AXtQ22PteWXZ1uyzO8HrZ1XXdGLUFFFWQ0TrDvBSKiDJgcEwU/OuNMiOmfPAOcxj7Hnw
	q2QA+jX3dTRvJrIQsG8S9IzhBzL809oFJEPgO79AL5Cw25YDjDrAtuinB21YONwDekG7
	0UkQ==
X-Gm-Message-State: AOUpUlFUajLdZg181sZNZlbrYvUb3K4rUIOlPPFCGg5ckWr5uaE0d5nn
	oVzmPbwsSJy0Kw5OeEdnfyGDX63Z
X-Google-Smtp-Source: AA+uWPxvRZWeFfvov4XpsTO1UZmQG24TVKeZQFk7fGEteLwwg4eUWGydwQf9NyJbOiI3g1uizpj1dw==
X-Received: by 2002:adf:fe8f:: with SMTP id
	l15-v6mr11415691wrr.165.1534194296234; 
	Mon, 13 Aug 2018 14:04:56 -0700 (PDT)
Received: from localhost.localdomain
	(p200300F07BC4D1601E6F65FFFE3E7F61.dip0.t-ipconnect.de.
	[2003:f0:7bc4:d160:1e6f:65ff:fe3e:7f61])
	by smtp.gmail.com with ESMTPSA id
	j8-v6sm12256559wrn.50.2018.08.13.14.04.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 Aug 2018 14:04:55 -0700 (PDT)
From: =?UTF-8?q?Andreas=20M=C3=BCller?= <schnitzeltony@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Aug 2018 23:04:43 +0200
Message-Id: <20180813210445.32496-1-schnitzeltony@gmail.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Subject: [PATCH 0/2] Spawn extra tasks at low CPU worload
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
X-List-Received-Date: Mon, 13 Aug 2018 21:04:56 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If it's only to prevent others from trying the same...

Andreas Müller (2):
  runqueue: Move decision if a task can be started to one common place
  runqueue: Introduce load balanced task spawning

 lib/bb/runqueue.py | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

-- 
2.14.4


