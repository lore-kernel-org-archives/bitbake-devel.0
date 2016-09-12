Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 910ED7721E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 21:59:58 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id c131so220110wmh.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=bDYQTHpDhi331UBccf6wjF8p8JhWbv0/B2VrLmJHYnY=;
	b=l041aRz5ZlH6DTMQlHTbHjSiIJm1HtWR0Eh2HlKY3JLCPM9lZ8cYNvkNshK/acpIfF
	b70kb+hygMj+2Ox9u3UOm7Q8y4SRh07R/fRBDXj0tGAU5PAUTvMyDiiwbHUOJPtxauJI
	1VQsdydytieGXNwEHn+xoUO5lZyPVdixJ/OtG5CST5VlrgQ3T3aKJt6nm9hjS7uFdvXV
	bnl78owKkL/ySBPmMiXU5HjK2ddSdWocyXIjHI/3b8MyFI7tMfLZnpCLo/SxjX59GcXF
	7avfe3pXI6UyDNhMi5i2k5oxFvEAQhWNsdbsine4TlrqnZ7dWmQoagcqjc8LQIScLwOT
	hWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=bDYQTHpDhi331UBccf6wjF8p8JhWbv0/B2VrLmJHYnY=;
	b=PDbAblpHsXRduRbptjA+PadJgRXhFtZzdkQAR/hDHtkEOI6Js9bZdYT8s8KrdkeQgb
	lwTQsuDzjNYomlT7441LU+hD4xv6zNO7xKNTU781MDonyPJhacR82g5pTCpcJVq5IyEB
	7rJ4dRURxYKRF5jLwO34dd2/f6cWnCDPamQs6O+m+uTQyMigKTefcvK6BkGY9KUKjt+T
	akN7RsqASk62JHT+Oq/DBH6uLGPE/g0FmwxKHnQJg+JakistpgjPcpQl5wuGo78Ah9Wt
	EqnDyT/IdN0cXQOiUVsuxuTqOuSO7wcWozcOctZsZuAwhRSt9CwqC0Bfx23IJtCsXrFw
	jMjA==
X-Gm-Message-State: AE9vXwPUA0ezc+rKdNnWHgHn5heVW0vhKB9c8Kw9dp49DajKFLnH3ksDvsGuwXOlu2PMBA==
X-Received: by 10.194.3.45 with SMTP id 13mr759746wjz.103.1473717598750;
	Mon, 12 Sep 2016 14:59:58 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172]) by smtp.gmail.com with ESMTPSA id
	uv6sm19806377wjc.31.2016.09.12.14.59.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 14:59:58 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Sep 2016 23:59:51 +0200
Message-Id: <1473717592-6824-1-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH v2 0/1] Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 22:00:02 -0000

Changes since v1:

Fix the original patch to make it actually work, and broaden it to make the
substitution more robust in general by substituting all names at once.

Ulf Magnusson (1):
  bitbake: fetch2: Make SRCREV_FORMAT name substitution safer

 bitbake/lib/bb/fetch2/__init__.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.5.0


