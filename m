Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0A3F19201C
	for <bitbake-devel@openembedded.org>;
	Sun, 26 Jan 2020 16:16:27 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id a6so2000079pjh.2
	for <bitbake-devel@openembedded.org>;
	Sun, 26 Jan 2020 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=w/nLhd8rlm54YfG9+yqQrHc9HO2VBOjtE70YOup+w+U=;
	b=gjtov1AADKwn+9O2l1WRXRqwJTYiZh+m+jDl7aDLQiacHU1UOEEs5s8dvkOFlscRyd
	NjQVdqe2F7NEGR7rh/P3hL/OLqg+DrNaA2TntzU22DyLXbJd08BYg96tQqLZNRHfirLp
	J+vcpNaiJxz+HgNBlnEeSiW29grD2ciBgHbf63A7SOkX0O1Gx7otKY/bhpE1c2M/U41K
	1mYkTOa3EAtNhyXnt9lkNWieYqjaSllQEqSA2hFxk0onC1DNrkcz67y4T5Z9GejtdMDY
	VtOn0BEY0qnyGw728payy7vArEp0j7EqKJRhluOkhVt4rn8OMLU8cFBuRseD/HGLXp56
	oCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=w/nLhd8rlm54YfG9+yqQrHc9HO2VBOjtE70YOup+w+U=;
	b=T+GaK9oaDBzqCTXugT6GJ6k4eRqGUXIOiKoDf+CaJsnl2FrcjblTWjr3sz5qXan2yW
	5Cr3QS9bCy63LGLERuElZ0f4MUwL31yvcB5mWlPTIXSUHzbeya2eO/NmRmu9je7C5DCN
	Wz2yet1JS6glBrK6EvRCaTMxQbdKebfNMhT1h5dbQHRr5mMFwxALM03U5hQsHBq6ENhM
	b+6hCn6imRtQGak0fGxG0cynMwa7uB2mpw3pk5O7/5h2kMK941gy/nG3Hy6Yuw6fuLec
	7LerBsZDKXyjTy+VIUV8/V5nHMwekPa5+qbSWnNl9IoX6QZfDUL1JY29Hn4tCSj/4bK4
	s5qw==
X-Gm-Message-State: APjAAAWkFAOsTEWmAOyloyfT9a8Yqz48R8n4nBb4bgxylMSMznK3AIhA
	SQ2TXgnLNwLyh3Ld3wbub/CCK7iP
X-Google-Smtp-Source: APXvYqxmsUYO6VGVikGodmqJPLJ2mwmF0k6BHMLvTGc9r3VmJVqxXA+A7hLOlwYykLmDR4BEZQyuHA==
X-Received: by 2002:a17:902:864a:: with SMTP id
	y10mr13761467plt.2.1580055388828; 
	Sun, 26 Jan 2020 08:16:28 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:bddb:633c:e712:cec2])
	by smtp.gmail.com with ESMTPSA id
	b4sm12895937pfd.18.2020.01.26.08.16.27
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 26 Jan 2020 08:16:28 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun, 26 Jan 2020 08:16:22 -0800
Message-Id: <cover.1580055259.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.42 0/1] Merge request
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
X-List-Received-Date: Sun, 26 Jan 2020 16:16:28 -0000

Please concider this for 1.42

The following changes since commit 4ce50bbd34eefeabfeca89a6a66c71598d3c58f6:

  fetch2: Ensure cached url data is matched to a datastore (2019-11-13 22:00:03 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.42-next
  http://cgit.openembedded.org//log/?h=stable/1.42-next

Peter Kjellerstedt (1):
  cooker: Keep track of watched files using a set instead of a list

 lib/bb/cooker.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1


